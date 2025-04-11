<!-- Designed and developed by @Krishna kumar :Feb 2019 for ICG(Indian Coast Guard) -->

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<jsp:include page="..//view/leftMenu.jsp" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/treatmentOpdData.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

 <jsp:include page="..//view/commonModal.jsp" />  
<html>
 <meta http-equiv="cache-control" content="no-cache, must-revalidate, post-check=0, pre-check=0" />
  <meta http-equiv="cache-control" content="max-age=0" />
  <meta http-equiv="expires" content="0" />
  <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
  <meta http-equiv="pragma" content="no-cache" />
<head>
<%
	String hospitalId = "1";
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	String userName="";
	if (session.getAttribute("firstName") != null) {
		userName = session.getAttribute("firstName") + "";
	}
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

	Calendar c = Calendar.getInstance(); 
	Date currentDate1 = c.getTime();
	String currentDate=formatter.format(currentDate1); 

	//c.set(Calendar.DATE, 01);
	Date startDate1 = c.getTime();

	//c.set(Calendar.DATE, 30);
	Date enddate1 = c.getTime();
	String startDate=formatter.format(startDate1); 
	String enddate=formatter.format(enddate1); 	
	
	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<jsp:include page="..//view/commonJavaScript.jsp" />
<title>OPD Main</title>

<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->

<script src="${pageContext.request.contextPath}/resources/js/snomedLink.js?n=1" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>

<%-- <link href="${pageContext.request.contextPath}/resources/css/jquery-ui.css"  rel="stylesheet" type="text/css"/> --%>
<script type="text/javascript">
	window.history.forward();
	var labRadioValue=resourceJSON.mainchargeCodeLab;
	var imagRadioValue=resourceJSON.mainchargeCodeRadio;

	
</script>

<script>

$j(document).on('hidden.bs.modal','#exampleModal', function (event) {
    var loaderHtml ='<div class="text-center text-theme text-sm">Loading <i class="fa fa-spin fa-spinner"></i> </div>';
	$j('#exampleModal .modal-body').html(loaderHtml);
});


var hsId=<%=hospitalId%>;
var uId=<%=userId%>;
var addNur=0;
var $j = jQuery.noConflict();
$j(document).ready(function(){
	$j('#lab_radio').val(labRadioValue);
	$j('#imag_radio').val(imagRadioValue);
	$('#labImaginId').val(labRadioValue);
	getSpecialistList();
	function split(val) {
		return val.split(/,\s*/);
	}
	function extractLast(term) {
		return split(term).pop();
	}

		$j( ".historyAutoComplete" )
	    .autocomplete({
		    minLength: 1,
			source: function( request, response ) {
	            // delegate back to autocomplete, but extract the last term
				var arTerm=request.term.split(",");
				var searchTerm=arTerm[arTerm.length-1].trim();
				
				
				 console.log("terms :: "+searchTerm);
				servURL = enumSERVICES.SEARCH.searchbyacceptability_url;
				var refsetidParam = null;
				
				
				var fieldId = $j(this.element).attr("id");
				
				if(searchTerm.length == 0 ||searchTerm.indexOf("&") !=-1 || searchTerm.indexOf("^") !=-1 || searchTerm.indexOf("#") !=-1 || searchTerm.indexOf("@") !=-1)
				{
					alert("Please enter the valid search parameter");
					//$j("#"+fieldId).val("");
					return false;
				}
				var semantictag = "";
				   if(fieldId=='snomeddiagnosis'){
				    semantictag ="disorder++finding";
				   }
				   if(fieldId=='allergyHistory'){
				    semantictag ="substance";
				   }
				   if(fieldId=='medicationHistory'){
				    semantictag ="product";
				   }
				   if(fieldId=='implantHistory'){
				    semantictag ="procedure";
				   }
				   
				   if(fieldId=='surgicalHistory'){
				    semantictag ="disorder++finding++procedure++observable entity++body structure++event";
				   }
				   
				   if(fieldId=='familyHistory'){
				    semantictag ="situation";
				   }
				
				
				var acceptability= "synonyms";
				
				var url = "../opd/getSnomedData?snoTerm="+searchTerm+"&semantictag="+semantictag+"&acceptability="+acceptability+"&returnlimit=10";
				
				$j.getJSON(url,
	            		function (data)
				{ 
	            	var array = data.error ? [] : $j.map(data, function(m) {
						return {
							label: m.term+"["+m.conceptId+"]" ,
							 value:  m.conceptId 
						};
					});
					response(array);
				
	            });
	        },
	        focus: function() {
	            // prevent value inserted on focus
	            return false;
	        },
	        select: function( event, ui ) {
	            var terms = split( this.value );
	         	// remove the current input
	            terms.pop();
	            terms.push( ui.item.label );
	            // add placeholder to get the comma-and-space at the end
	            terms.push( "" );
	           
	       		
	            this.value = terms.join( "," );
	            return false;	       		
	        }
	    });
	});
	</script> 
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>


<%
	int i = 1;
%>

<body>
<!-- Begin page -->
    <div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">OPD Consultation</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form:form name="opdMainData" id="opdMainData" method="post" enctype='multipart/form-data'
											action="#" autocomplete="on">
								<input type="hidden" id="procedureRadioIdd" name="procedureRadioIdd" value=""/>
								<input type="hidden" id="ageNumber" name="ageNumber" value=""/>
								<input type="hidden"  name="uhidNumberValue" value="" id="uhidNumberValue" />
								<input type="hidden"  name="checkForAuthenticationValue" value="" id="checkForAuthenticationValue" />
								 <input  name="serviceNo" id="serviceNo" type="hidden" value="" />
								 <input  name="checkForInve" id="checkForInve" type="hidden" value="1" />
								 <input type="hidden"  name="userId" value=<%=userId%> id="userId" />
								 <input type="hidden"  name="hospitalId" value=<%=hospitalId%> id="hospitalId" />
								 <input type="hidden"  name="mmuName" value=<%= session.getAttribute("mmuName") %> id="mmuName" />
								  <input type="hidden"  name="campName" value="<%=session.getAttribute("campLocation")%>" id="campName" />
								  <input type="hidden"  name="campId" value=<%= session.getAttribute("campId") %> id="campId" />
								  <input type="hidden"  name="cityId" value=<%= session.getAttribute("cityId") %> id="cityId" />
								  <input  name="labImaginId" id="labImaginId" type="hidden" value="" />
								  <input  name="defaultProcedureValue" id="defaultProcedureValue" type="hidden" value="N" />
								   <input  name="obsistyCheckAlready" id="obsistyCheckAlready" type="hidden" value="" />
								   <input type="hidden" id="usersCounts" name="usersCounts" value=""/>
								   <input type="hidden" name="empCategory" id="empCategory" value=""/>	
								   <input type="hidden" name="siqValue" id="siqValue" value=""/>
								   <input  name="flagForFwc" id="flagForFwc" type="hidden" value="" />	
								   <input type ="hidden" name="precriptionDtValue" id="precriptionDtValue" value=""/>
								   <input type="hidden"  name="userName" value='<%=userName%>' id="userName" />
								   <input type="hidden" name="formFlag" id="formFlag" value="opdMain"/>
								   <input type="hidden" name="registrationTypeCode" id="registrationTypeCode" value=""/>
							       <input type="hidden" name="patientSymAuditId" id="patientSymAuditId" value=""/>
							        <input type="hidden" name="doctorRemarksArrayVal" id="doctorRemarksArrayVal" value=""/>
								   
								<!-- -----  Service Detail  start here --------- -->	
  
	<!-- -----  Service Detail  end here --------- -->	
								
								
								<!-- -----  Patient Detail  start here --------- -->
	
	  <div class="adviceDivMain" id="button2" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Patient Detail  </span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton2" value="-" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost2" style="display:block;">
			
			<div class="row">
				<div class="col-md-8">
						<div class="row">
			
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Name </label>
													<div class="col-md-7">
														<input name="empname" id="empname" type="text"
															class="form-control border-input" value="" readonly />
													</div>
												</div>
											</div>

											
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-md-5 col-form-label"> Gender </label>
													<div class="col-md-7">
														<input name="Gender" id="gender" type="text"
															class="form-control border-input" value="" readonly>
													</div>
												</div>
											</div>
											
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-md-5 col-form-label"> Age </label>
													<div class="col-md-7">
														<input name="Age" id="age" type="text"
															class="form-control border-input" value="" readonly>
													</div>
												</div>
											</div>
										
									
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Mobile No. </label>
													<div class="col-md-7">
														<input name="Mobile No" id="mobileno" type="text"
															class="form-control border-input" value="" readonly>
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Type Of Patient  </label>
													<div class="col-md-7">
														<input name="ptientType" id="ptientType" type="text"
															class="form-control border-input" value="" readonly>
													</div>
												</div>
											</div>
											


											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-md-5 col-form-label"> </label>
													<div class="col-md-7"></div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-md-5 col-form-label"> </label>
													<div class="col-md-7"></div>
												</div>
											</div>

										</div>
				</div>
				
				<div class="col-md-3 offset-md-1">
					<div class="row">
						<div class="col-12">
												
							   <img src="/MMUWeb/resources/images/photo_icon.png" class="opdPrevPic" id="prevPic" alt=""  />
							   
							   <div class="col-sm-12">
							    	<label class="col-form-label">Profile Image<span class="mandate"><sup>&#9733;</sup></span></label>
							    </div>
						</div>
					</div>
				</div>
			
			</div>
			
			
			
			
	</div>
<!-- -----  Patient Detail  end here --------- -->
								
								
								
								
<!-- ----- Previous visits & Chief		Complaint start here --------- -->		

    <div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Clinical History</span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton3" value="-" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost3"  style="display:block;">
      
      
      <div class="row">
											<div class="col-md-4">
												<div class="arrowlistmenu">
													<ul class="categoryitems">
														<!-- <li><a href="#" class="text-danger">Allergy</a></li> -->
														<li><a href="javascript:void(0)"  onclick="showPreveiousVisit()"> Previous Visits </a></li>
														<!-- <li><a href="#" onclick=" ">Previous
																Hospitalization </a></li> -->
														<li><a href="javascript:void(0)"   onclick="showPreveiousVital()">Previous Vitals</a></li>
														<li><a href="javascript:void(0)" id="prevLabClinicHistory" onclick="showPreveiousLabInvestigation()">Previous Lab
																Investigation </a></li>
														<li><a href="javascript:void(0)" id="prevRadioHistory" onclick="showPreveiousRadioInvestigation()">Previous ECG
																Investigation </a></li>
														<li><a href="javascript:void(0)"   onclick="showAuditHistory()">Audit History</a></li>
														<!-- <li><a href="#" onclick="showEHRRecords()">EHR</a></li> -->
													
														<!-- <li><a href="#" data-toggle="modal" data-target="#exampleModal" onclick="growthChart()"> Child Growth Chart </a></li> -->
														
														
														
														
													</ul>
												</div>
											</div>

											<div class="col-md-8">

												<div class="opdArea">
													<div id=hospidataId style="display: none">
														<label>Hospital Name</label> <input type="text"
															name="hospName" tabindex="1" size="100" value=""
															maxlength="150" /> <input type="text" name="hospName"
															tabindex="1" size="100" value="" maxlength="150" /> <label
															class="auto">DOA</label> <input type="text" name="doa"
															class="date" id="doa" MAXLENGTH="30"
															validate="Pick a from date,date,no" value=""
															readonly="readonly"
															onblur="checkDate1(this.value,this.id)" /> <input
															type="text" name="doa" class="date" id="doa"
															MAXLENGTH="30" validate="Pick a from date,date,no"
															value="" readonly="readonly"
															onblur="checkDate1(this.value,this.id)" /> <img
															src="${pageContext.request.contextPath}/resources/images/cal.gif"
															width="16" height="16" border="0"
															onclick="javascript:setdate('doa',document.opdMain.doa, event)"
															validate="Pick a date" /> <label class="auto">DOD</label>
														<input type="text" name="dod" value="" class="date"
															id="dod" MAXLENGTH="30"
															validate="Pick a from date,date,no" readonly="readonly" />
														<input type="text" name="dod" value="" class="date"
															id="dod" MAXLENGTH="30"
															validate="Pick a from date,date,no" readonly="readonly"
															onblur="checkDate1(this.value,this.id)" /> <img
															src="${pageContext.request.contextPath}/resources/images/cal.gif"
															width="16" height="16" border="0"
															onclick="javascript:setdate('dod',document.opdMain.dod, event)"
															validate="Pick a date"
															onblur="checkDate1(this.value,this.id)" />
														<div class="clear"></div>
														<label>Diagnosis</label> <input type="text" class="auto"
															size="48" id="pastDiagnosis" tabindex="1" value=""
															name="pastDiagnosis" maxlength="100" />
														<div class="clear"></div>
														<label>Advise on Discharge</label>

														<textarea name="adviceOnDischarge" cols="0" rows="0"
															maxlength="300" value="" tabindex="1"
															></textarea>

														<textarea name="adviceOnDischarge" cols="0" rows="0"
															maxlength="300" value="" tabindex="1"
															></textarea>

													</div>

													 
															<div class="row">
															
															<div class="hisDivHide p-10" id="newpost117"  style="display:block;"">
									      
									      	<div class="row">
											<div class="col-md-5">
												<div class="form-group row  autocomplete">
												<!-- onmouseenter="getOpdNomenClatureList(this,'populateSignAndSymptoms','treatmentAudit','getAllSymptomsForOpd','signAndSymptoms','mouseOver');" -->
													<label class="col-md-5 col-form-label">Patient signs & symptoms<span
													class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-md-7">
															<div class="autocomplete forTableResp">
															<input type="text" autocomplete="never" class="form-control border-input" name="pvmsNumber" id="patientSymptons"  onKeyUp="getOpdNomenClatureList(this,'populateSignAndSymptoms','registration','getAllSymptoms','signAndSymptoms','opd');"/>
															<!-- <input type="text" autocomplete="never" class="form-control border-input" name="pvmsNumber" id="patientSymptons" onKeyUp="getOpdNomenClatureList(this,'populateSignAndSymptoms','treatmentAudit','getAllSymptomsForOpd','signAndSymptoms','opd');"/> -->
															<div id="divPvms1" class="autocomplete-itemsNew"></div>
													</div>

												</div>
											</div>
											</div>

											<div class="col-md-4">
											<div name="patientSympotnsIdDiv" id="patientSympotnsIdDiv">
												
											</div>
												<!-- <select name="patientSympotnsId" multiple="2" value="" size="5"
													tabindex="1" id="patientSympotnsId" class="listBig width-full disablecopypaste"
													validate="ICD Daignosis,string,yes">
												</select> -->
											</div>
											<div class="col-md-3">
												<button type="button" class="buttonDel btn  btn-danger"
													value="" onclick="deletePatientSympotonsItems();"
													align="right" />
												Delete
												</button>
												
											</div>

										</div>
									      
												 
										</div>

																<!-- <div class="col-md-12">
																	<div class="form-group row">
																		<label class="col-md-3 col-form-label">Patient signs and 
																			Symptoms<span
													class="mandate"><sup>&#9733;</sup></span> </label>
																		<div class="col-md-6">
																			<textarea class="textNew form-control" maxlength="2000" name="patientSymptons"
																				id="patientSymptons" cols="0" rows="0" value=""
																				tabindex="1"></textarea>
																		</div>
																		 <div class="col-md-1">
																			<input type="button" class="btn btn-primary" tabindex="3"
																				name="" value="+" onclick="chiefComplaint()" />
																		</div> 
																		<div class="col-md-2"></div>
																	</div>
																</div> -->

																<div class="col-md-12">
																	<div class="form-group row">
																		<label class="col-md-3 col-form-label">Clinical Examination</label>
																		<div class="col-md-6">
																			<textarea class="textNew form-control" name="pastMedicalHistory" maxlength="2000"
																				id="pastMedicalHistory" cols="0" rows="0" value=""
																				tabindex="1"></textarea>
																		</div>
																		<!--  <div class="col-md-1">
																			<input type="button" class="button" tabindex="3"
																				name="" value="+"
																				onclick="getPresentTemplate('','pastMedicalHistory');" />
																		</div> -->

																		<div class="col-md-2"></div>

																	</div>
																</div>



															</div>

												

													</div>

												</div>
											</div>

      
      
			
	</div>


<!-- ----- Previous visits & Chief	Complaint end here --------- -->	
								
								
								
								 <!-- ----- Vital Detail start here --------- -->

  <div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>  Vital Detail </span>
	</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton4" value="+" onclick="showhide(this.id)" type="button">
	  	
</div>	

      <div class="hisDivHide p-10" id="newpost4">
      
      
                           <div class="row disablecopypasteDiv">

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Patient Height<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="height" id="height" type="text" maxlength="3"
															class="form-control border-input" onblur="idealWeight();checkBMI();" placeholder="Height"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  />
													</div> -->
													<div class="col-md-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="height" id="height" type="text" maxlength="3"
															class="form-control border-input" onblur="checkBMI();" placeholder="Height"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  />
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Ideal Weight
													</label>
												
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="ideal_weight" id="ideal_weight" maxlength="5" onblur="checkVaration()" type="text"
															class="form-control border-input"
															placeholder="Ideal Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
														    <div class="input-group-append">
														      <div class="input-group-text">kg</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div> -->
                                            
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Weight<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="Weight" id="weight" type="text"
															class="form-control border-input" maxlength="3" onblur="checkVaration();checkBMI();" placeholder="Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
													</div> -->
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="Weight" id="weight" type="text"
															class="form-control border-input" maxlength="5" onblur="checkBMI();" placeholder="Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
														    <div class="input-group-append">
														      <div class="input-group-text">kg</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>

											

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Temperature<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="tempature" id="tempature" type="text" maxlength="8"
															class="form-control border-input"
															placeholder="Temperature" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
													</div> -->
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="tempature" id="tempature" type="text" maxlength="8"
															class="form-control border-input"
															placeholder="Temperature" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
														    <div class="input-group-append">
														      <div class="input-group-text">°F</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
										
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-3 col-form-label">BP<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-3">
														<input name="bp" id="bp" type="text"
															class="form-control border-input" placeholder="Systolic" maxlength="3"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
														 
													</div>
													
													
													<div class="col-md-1">
														/
														 
													</div>
													
													<div class="col-md-3">
														<input name="bp" id="bp1" type="text" maxlength="3"
															class="form-control border-input" placeholder="Diastolic"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
														 
													</div> -->
													<div class="col-md-3 offset-md-1">
														<input name="bp" id="bp" type="text"
															class="form-control border-input bpSlash" placeholder="Systolic" maxlength="3"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
															<span></span> <!-- slash for bp -->
														  
													</div>
													<div class="col-md-5">
														<div class="input-group mb-2 mr-sm-2">
															<input name="bp" id="bp1" type="text" maxlength="3"
															class="form-control border-input bmiInput" placeholder="Diastolic"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
														    <div class="input-group-append">
														      <div class="input-group-text">mmHg</div>
														    </div>
														  </div>
													</div>
													
													
													
													
													
													
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Pulse<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="pulse" id="pulse" type="text" maxlength="8"
															class="form-control border-input" placeholder="Pulse"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  />
													</div> -->
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="pulse" id="pulse" type="text" maxlength="8"
															class="form-control border-input" placeholder="Pulse"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  />
														    <div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">SpO2</label>
													<!-- <div class="col-md-7">
														<input name="spo2" id="spo2" type="text" maxlength="15"
															class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="SpO2"
															value="" required>
													</div> -->
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="spo2" id="spo2" type="text" maxlength="15"
															class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="SpO2"
															value="" required>
														    <div class="input-group-append">
														      <div class="input-group-text">%</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">BMI </label>
													<!-- <div class="col-md-7">
														<input name="bmi" id="bmi" type="text" 
															class="form-control border-input" placeholder="BMI"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" readonly>
													</div> -->
													<div class="col-md-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="bmi" id="bmi" type="text" 
															class="form-control border-input" placeholder="BMI"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" readonly>
														    <div class="input-group-append">
														      <div class="input-group-text">kg/m2</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">RR</label>
													<!-- <div class="col-md-7">
														<input name="rr" id="rr" type="text" maxlength="3"
															class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="RR"
															value="" required>
													</div> -->
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="rr" id="rr" type="text" maxlength="3"
															class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="RR"
															value="" required>
														    <div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
												
											<div class="col-md-4" style="display:none;">
												<div class="form-group row">
													<input type="hidden" id="patientId" name="PatientID"
														value="">
												</div>
											</div>
											<div class="col-md-4" style="display:none;">
												<div class="form-group row">
													<input type="hidden" id="visitId" name="VisitID" value="">
												</div>
											</div>
											<div class="col-md-4" style="display:none;">
												<div class="form-group row">
													<input type="hidden" id="departmentId" name="departmentId" value="">
												</div>
											</div>
											<div class="col-md-4" style="display:none;">
												<div class="form-group row">
													<input type="hidden" id="genderId" name="genderId" value="">
												</div>
											</div>
											 
											
												 <div class="col-md-5" id="markMLCId">
												<div class="form-group row">
													
												<div class="col-md-9 makeDisabled">
													
													<div class="col-md-12 ">
													<div class="form-check form-check-inline cusCheck m-t-7">
														<input class="form-check-input" type="checkbox" id="markMLC" onClick="marksAsMLC(this)"  value="">
														
													<span class="cus-checkbtn"></span>
													<div class="form-check form-check-inline cusRadio">
															<label class="col-md-12 col-form-label">Mark as MLC Case</label> 
													</div>
													</div>
												</div>
										
											
												<div class="col-md-8">
													<div class="form-group row"></div>
												</div>
											
												</div></div>
										</div>
										</div>
							
					      	<div class="row" id="markMLCSection" style="display:none">
					      	
					      		<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="" id="mlcDate" class="calDate form-control" placeholder="DD/MM/YYYY" readonly>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Place</label>
										</div>
										<div class="col-md-7">
											<input type="text" name="" id="mlcPlace" class="form-control" readonly>
										</div>
									</div>
								</div> 
								<div class="w-100"></div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Police Station</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcPloiceStation" rows="2"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Treated As</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcTreatedAs" rows="2"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Name of Institution</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcNameOfInstatuition" rows="2" readonly="readonly"></textarea>
										</div>
									</div>
								</div>
								 
								<div class="w-100"></div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Name Of Policeman</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcPloiceName" rows="2"  maxlength="100"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Designation</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcDesignation" rows="2"  maxlength="100"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">ID Number</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcIdNumber" rows="2" maxlength="100"></textarea>
										</div>
									</div>
								</div>
								
					      	</div>
									
      
      
			 
	</div>

<!-- ----- Vital Detail end here --------- -->

			
									
								
				<!-- ----- Diagonsis  start here --------- -->
										
										 <div class="adviceDivMain" id="button7" onclick="showhide(this.id)">
											<div class="titleBg" style="width: 520px; float: left;">
												<span> Diagnosis </span>
										     </div>		
											<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton7" value="-" onclick="showhide(this.id)" type="button">
										</div>	
									
									
									      <div class="hisDivHide p-10" id="newpost7"  style="display:block;"">
									      
									      	<div class="row">
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Provisional
														Diagnosis </label>
													<div class="col-md-7">
													<textarea name="workingdiagnosis" id="workingdiagnosis" cols="0" rows="0"
													        	maxlength="500"  tabindex="5" class="form-control"></textarea>	
													
														<input name="workingdiagnosis" id="workingdiagnosis" maxlength="100"
															type="text" class="form-control border-input"
															placeholder="Provisional  Diagnosis" value="" />
													</div>
												</div>
											</div>

											<div class="col-md-4">
												
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label"> </label>
													<div class="col-md-7"></div>
												</div>
											</div> -->
										
											<div class="col-12">
							      		<h6><a class="text-theme font-weight-bold text-underline" onClick="showdiagLoader();showAllAuditRecommendedDiagnosis('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Diagnosis</a>
							      		<span class="smallLoader" id="diagLoader"><img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"></span></h6> 
                                        <input type="hidden" name="countValueRecommendedDiagnosis" id="countValueRecommendedDiagnosis" value=""/>
							      		<table class="table table-bordered" border="0" cellpadding="0" cellspacing="0">
											<thead>
												<tr>
													<th>Diagnosis<span
													class="mandate"><sup>&#9733;</sup></span></th>
													<th class="text-center">Mark as Communicable Disease</th>
													<th class="text-center">Mark as Infectious Disease</th> 
													<th>Add</th>
													<th>Delete</th> 
												</tr>
											</thead>

											<tbody id="diagnosisGrid">
												<tr>
													<td>
													    <div class="autocomplete forTableResp">
													    <!-- onmouseup="getOpdNomenClatureList(this,'newDiagnosisPopulate','treatmentAudit','getAllIcdForOpd','dignosis','mouseOver');"  -->
														<input type="text" size="55" name="diagnosisId" value="" id="diagnosisId" 
														onKeyUp="getNomenClatureList(this,'newDiagnosisPopulate','opd','getIcdListByName','dignosis');" class="form-control">
													   <div id="diagnosisDiv" class="autocomplete-itemsNew"></div>
													   </div>
													</td>
													<td class="text-center width220">
														<div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" id="markDisease" name="markDisease" type="checkbox">
															<span class="cus-checkbtn"></span>
														</div>
													</td>
													<td class="text-center width220">
														<div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" id="markInfection" name="markInfection" type="checkbox">
															<span class="cus-checkbtn"></span>
														</div>
													</td>
													<td>
														<button name="Button" type="button" id="addDiagnosisRow" name="addDiagnosisRow" class="buttonAdd btn btn-primary noMinWidth m-r-10" button-type="add" value="" tabindex="1" onclick="addDiagnosis()"></button>
													</td>
													<td>
														<button name="Button" type="button" id="deleteDiagnosisRow" name="deleteDiagnosisRow" class="buttonDel btn btn-danger noMinWidth" button-type="delete" value="" tabindex="1" onclick="deleteDiagnosis(this)"></button>
													</td>
													<td style="display: none";>
													    <input type="hidden" value="" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" />
													</td>
													<td style="display: none";>
													    <input type="hidden" value="T" tabindex="1" id="diagnosisAuditFlag" size="77" name="diagnosisAuditFlag" />
													</td>
												</tr>
											</tbody>
							      		</table>
							      	</div>	
											<!-- <div class="col-md-4">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">Final
														Diagnosis <span
													class="mandate"><sup>&#9733;</sup></span> </label>
													<div class="col-md-7">
														<input name="icddiagnosis" id="icd" type="text" autocomplete="off"
															class="form-control border-input"
															placeholder="ICD Diagnosis" value=""
															onblur="fillDiagnosisCombo(this.value);" />
															<div class="autocomplete forTableResp">
															<input name="icddiagnosis" id="icd" type="text"
															class="form-control border-input disablecopypaste"
															placeholder=" " value=""  onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','dignosis');"  />
																<div class="autocomplete-itemsNew" id="icdDiagnosisUpdatea" ></div>
													</div>

												</div>
											</div>
											</div>

											<div class="col-md-4">
												<select name="diagnosisId" multiple="4" value="" size="5"
													tabindex="1" id="diagnosisId" class="listBig width-full disablecopypaste"
													validate="ICD Daignosis,string,yes">
												</select>
											</div>
											<div class="col-md-4">
												<button type="button" class="buttonDel btn  btn-danger"
													value="" onclick="deleteDgItems();"
													align="right" />
												Delete
												</button> -->
												
												<!-- <input type="checkbox"> Not available -->
												
												<!-- <div class="form-check form-check-inline cusCheck m-t-10 m-l-10">
													<input class="form-check-input" type="checkbox" id="zdiagcheckbox">
													<span class="cus-checkbtn"></span> 
													<label class="form-check-label" for="zdiagcheckbox">Not Available</label>
												</div> -->
												
											</div>
									      
												 
										</div>
									<!-- -----Diagonsis   end here --------- -->
								
								
								
								
								<!-- -----Investigation   start here --------- -->


							      <div class="adviceDivMain" id="button8" onclick="showhide(this.id)">
							     	<div class="titleBg" style="width: 520px; float: left;">
										<span> Investigation</span>
									</div>
									<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton8" value="+" onclick="showhide(this.id)" type="button">
								</div>	
							
							
							      <div class="hisDivHide p-10" id="newpost8">
							      
							      	<div class="">
											<div class="row">

												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label no-bold" style="padding-left: 10px;"> Template </label>
														<div class="col-md-7">
															<div id="investigationDiv">
																<select name="investigationTemplateId"  class="form-control" 
																	id="dgInvestigationTemplateId" tabindex="1">
																</select>
															</div>
														</div>
													</div>
												</div>

												<div class="col-md-8">
													
														
															<input type="button" value="Create Template" tabindex="1" class="btn btn-primary"
																data-toggle="modal" data-target="#exampleModal" 
															onclick="showCreateInvestigationTemplate();">
															
															<!-- <input name="investigation" tabindex="1"
																	type="button" value="Import New" class="btn btn-primary"
																	onclick="showInvestiDataTemplate()" /> -->
																	
															<input name="updateTemplate" tabindex="1"
																	type="button" value="Update Template" data-toggle="modal" data-target="#exampleModal" class="btn btn-primary"
																	onclick="opdUpdateInvestigationTemplate()" />
													
												</div>

												<!-- <div class="col-md-2">
													<div class="form-group row">
														<div class="col-md-12">
															<div>
																<input name="createupdateTemplate" tabindex="1"
																	type="button" value="Update Template" class="buttonBig"
																	onclick="showUpdateOpdTempate('I');" />
															</div>
														</div>
													</div>
												</div> -->

												


												<!--       <div class="col-md-2">
                                                                    <div class="form-group row">
                                                                          <label class="col-md-5 col-form-label"> Urgent  </label>
                                                                        <div class="col-md-7">
                                                                            <input type="checkbox" name="urgent" tabindex="1" class="radioAuto" value="1" />  
                                                                        </div>
                                                                    </div>
                                                                </div> -->


											</div>




											<div class="row m-t-10">
												<div class="col-md-1">
													<div class="form-group">

														<!-- <div class="col-md-1">
															<input type="radio" value="" class="radioCheckCol2"
																name="labradiologyCheck" id="lab_radio" checked="checked"
																onchange="changeRadio(this.value)" />
														</div>
														<label
															style="font: bold 12px/16px Arial, tahoma; color: #000000; background: none; text-align: left; back padding: 0px 9px;"
															class="col-md-5 col-form-label labRadiologyDivfixed">Lab</label> -->
															
														<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="" class="form-check-input radioCheckCol2"
																name="labradiologyCheck" id="lab_radio" checked="checked"
																onchange="changeRadio(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="lab_radio">Lab</label>
														</div>
														
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">

														<!-- <div class="col-md-1">
															<input type="radio" value="" class="radioCheckCol2"
																name="labradiologyCheck" id="imag_radio"
																onchange="changeRadio(this.value)" />

														</div>
														<label
															style="font: bold 12px/16px Arial, tahoma; color: #000000; background: none; text-align: left; padding: 0px 9px;"
															class="col-md-5 col-form-label labRadiologyDivfixed">Imaging</label> -->
														
														<div class="form-check form-check-inline cusRadio" style="display: none";>
															<input type="radio" value="" class="form-check-input radioCheckCol2"
																name="labradiologyCheck" id="imag_radio"
																onchange="changeRadio(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="imag_radio">ECG &nbsp/Others</label>
														</div>
														
													</div>
												</div>
												<div class="col-md-8">
													<div class="form-group row"></div>
												</div>


											</div>


											<div class="">









												<div id="gridview">
												 <h6><a class="text-theme font-weight-bold text-underline" onClick="showinvesLoader();showAllAuditRecommendedInvestigation('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Investigation</a>
												 <span class="smallLoader" id="invesLoader"><img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"></span></h6> 
                                  				 <input type="hidden" name="countValueRecommendedInvestigation" id="countValueRecommendedInvestigation" value=""/>
								
													<table class="table table-bordered" border="0"
														align="center" cellpadding="0" cellspacing="0"
														id="investigationGrid">
														<thead>
															<tr class="table-primary">
																<th>Investigation</th>
																<th>Add</th>
																<th>Delete</th>
															</tr>
														</thead>

														<tbody id="dgInvetigationGrid">
															<tr>

																<td>
																<div class="autocomplete forTableResp">
																<!-- 	<div class="autocomplete"> 
																		 <input type="text" value="" id="chargeCodeName" autocomplete="_off"
																			class="form-control border-input"
																			name="chargeCodeName"  size="44"
																			onblur="populateChargeCode(this.value,1,this);" /> -->
																			<input type="text" autocomplete="never" value="" id="chargeCodeName"
																			class="form-control border-input disablecopypaste"
																			name="chargeCodeName" onKeyUp="getNomenClatureList(this,'populateChargeCode','opd','getIinvestigationList','investigation');"   size="44"/>
																		<input type="hidden" id="qty" tabindex="1" name="qty1"
																			size="10" maxlength="6" validate="Qty,num,no" /> <input
																			type="hidden" tabindex="1" id="chargeCodeCode"
																			name="chargeCodeCode" size="10" readonly />
																		<!-- <div id="investigationDivOpd" class="autocomplete-itemsNew"></div>	 -->
																			<div class="autocomplete-itemsNew" id="investigationDivOpd" ></div>
																	</div>
																</td>
																<td style="display: none";><input type="hidden"
																	value="" tabindex="1" id="inestigationIdval" size="77"
																	name="inestigationIdval" /></td>

																 <td>
                                                                  <button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button>
                                                                  </td>
																<td>
																	<button type="button" name="delete" value=""
																		class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"
																		onclick="removeRowInvestigationOpd(this)">
																		</button>
																</td>
																<td style="display: none";>
													  			  <input type="hidden" value="T" tabindex="1" id="invetgationAuditFlag" size="77" name="invetgationAuditFlag" />
																</td>

															</tr>
														</tbody>
														<input type="hidden" value="1" name="hiddenValue"
															id="hiddenValue" />

													</table>
													<br>
													
													
												<!-- 	
													 <label>Other Investigation</label>
													<textarea name="otherInvestigation" cols="50" rows="0"
														maxlength="500" tabindex="1"
														onkeyup="return ismaxlength(this)" class="auto"></textarea>
													<div class="clear paddingTop15"></div> -->
													
													<div class="row">		
											<div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">ECG File Upload</h6>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Upload File</label>
													<div class="col-md-7" id="ecgFileUpload">
														<!-- <div class="fileUploadDiv">
															<input type="file" name="ecgFileUploadVal"
															id="ecgFileUploadVal" class="inputUpload" />
															<label class="inputUploadlabel">Choose File</label>
															<span class="inputUploadFileName">No File Chosen</span>
														</div> -->
														<div class="fileUploadDiv">
														  	<input type="file" class="inputUpload" name="ecgFileUploadVal" id="ecgFileUploadVal">
														  	<label class="inputUploadlabel">Choose File</label>
															<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
													  	</div>
													</div>
													
												</div>
												
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
														<label class="col-md-5 col-form-label text-right">ECG Result</label>
														<div class="col-md-7">
														<textarea name="ecgResult" id="ecgResult" cols="50" rows="0"
														maxlength="500" tabindex="1"
														onkeyup="return ismaxlength(this)" class="form-control"></textarea>
														</div>
												</div>
											</div>
											</div>
													
										<!-- 	<div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">ECG File Upload</h6>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Upload File</label>
													<div class="col-md-7" id="ecgFileUpload">
														<div class="fileUploadDiv">
														<input type="file" name="ecgFileUploadVal"
															id="ecgFileUploadVal" class="inputUpload" />
															<label class="inputUploadlabel">Choose File</label>
															<span class="inputUploadFileName">No File Chosen</span>
														</div>
													</div>
													
												</div>
											</div>
										
																
											<div class="row" style="display: none";>
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-3 col-form-label no-bold" style=" padding-left: 10px;"> Other Investigation </label>
														<div class="col-md-8">
															<textarea name="otherInvestigation" id="otherInvestigation" cols="0" rows="0"
													        	maxlength="500"  tabindex="5" class="form-control"></textarea>													 
													    </div>
												    </div>
												  </div>  
												<div class="col-md-6">
													 
												
												</div>
											</div>  -->
													
													
													
													<table border="0" align="center" cellpadding="0"
														cellspacing="0" id="investigationGrid1">
													</table>

												</div>
											</div>


										</div>
							      
										 
								</div>
								<!-- -----Investigation   end here --------- -->
															
							
								
								<!-- -----Treatment   start here --------- -->
	
      <div class="adviceDivMain" id="button9" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span> Treatment</span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton9" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost9">
      
      
      <div class="">

											<div class="row">

												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-6 col-form-label no-bold"  style="padding-left: 10px;"> Template </label>
														<div class="col-md-6">
															<div id="investigationDiv">
																<select name="treatmentTemplateId"  class="form-control"
																	id="treatmentTemplateId" tabindex="1">
																	<%-- <select name="treatmentTemplateId"	tabindex="1" onchange="showHideInvestigationTemplateCombo(this.value);">--%>
																	<option value="0">Select</option>
																</select>
															</div>
														</div>
													</div>
												</div>

												<div class="col-md-2">
													<div class="form-group row">
														<div id="createInvestigationDivToShowHide" class="opd_invetigation_createtemplate">
															<input name="investigationTemplate" type="button"
																value="Create Template" tabindex="1" class="btn btn-primary "
																data-toggle="modal" data-target="#exampleModal" data-backdrop="static"
																onclick="createTreatmentTemplate();" />
														</div>
													</div>
												</div>

												 <div class="col-md-2">
													<div class="form-group row">
														<div id="createInvestigationDivToShowHide" class="opd_invetigation_createtemplate">
															<input name="showTemplate" tabindex="1"
																type="button" id="showTreatmwntTemp" value="Update Template" class="btn btn-primary "
																data-toggle="modal" data-target="#exampleModal" data-backdrop="static"
																onclick="opdUpdateTreatmentTemplate();" />
														</div>
													</div>
												</div> 



												<!-- <div class="col-md-2">
													<div class="form-group row">
														<div id="investigationImportButton1"  class="opd_invetigation_import">
															<input name="treatmentImportButton1" tabindex="1"
																type="button" value="Import New" class="btn btn-primary"
																onclick="showTemplateDataTemplate()"/>
														</div>
													</div>
												</div> -->





											</div>

										</div>
										<h6><a class="text-theme font-weight-bold text-underline" onClick="showtreatLoaderCurrent();showAllCurrentMedication('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Current Medication</a>
										<span class="smallLoader" id="treatLoaderCurrent"><img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"></span></h6> 
                                        <input type="hidden" name="countValueCurrentMedi" id="countValueCurrentMedi" value=""/>
                                        
                                         <h6><a class="text-theme font-weight-bold text-underline" onClick="showtreatLoader();showAllAuditRecommendedTreatment('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Treatment</a>
                                         <span class="smallLoader" id="treatLoader"><img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"></span></h6> 
                                  		 <input type="hidden" name="countValueRecommendedTreatment" id="countValueRecommendedTreatment" value=""/>
								
                                        
                                        <div class="table-responsive">
										<table class="table table-bordered m-t-10" align="center"
											cellpadding="0" cellspacing="0" id="dgTreatmentGrid">
											<tr>
												<th>Drugs Name/Drugs Code</th>
												<th >Disp. Unit</th>
												<th >Dosage<span>*</span></th>
												<th >Frequency<span>*</span></th>
												<th >Days<span>*</span></th>
												<th >Total<span>*</span></th>
												<th >Instructions</th>
												<th >Available Stock</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="nomenclatureGrid">
												<tr>

													<td>
													<div class="autocomplete forTableResp">
														<!--<div class="autocomplete forTableResp">
															 <input type="text" value=""  
																id="nomenclature1"  size="77" autocomplete="_off" name="nomenclature1"
																class="form-control width330"
																onblur="populatePVMS(this.value,'1',this);" /> -->
														<input type="text" autocomplete="never" value="" tabindex="1"
																	id="nomenclature1" size="77" name="nomenclature1"
																	class="form-control border-input width330 disablecopypaste" 
																	onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','numenclature');"/>		
                                                        <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div>
														</div>
													</td>

													<td>
                                                    <select name="au1Treatment" id="au1Treatment" class="medium form-control width100" ></select>
                                                    </td>

													<td><input type="text" name="dosage1" onkeypress="return checkValidate(event);" tabindex="1" autocomplete="nope" spellcheck="false"
														value="" id="dosage1" onblur="fillValueNomenclature()" size="5" maxlength="3" class="form-control width60 disablecopypaste" /></td>

													<td><select name="frequency1" id="frequency1" onchange="fillValueNomenclature()"
														class="medium form-control width150">

													</select></td>

													<td><input type="text" name="noOfDays1" onkeypress="return checkValidate(event);" tabindex="1" autocomplete="nope" spellcheck="false"
														id="noOfDays1" onblur="noOfDaysAlert(this.value,this)"
														size="5"  maxlength="3" class="form-control width60 disablecopypaste" /></td>

													<td><input type="text" name="total1" onkeypress="return checkValidate(event);" tabindex="1"
														id="total1" size="5" validate="total,num,no"
														onblur="treatmentTotalAlert(this.value,1)"  class="form-control width70"  /></td>

													<td>
													<select name="instuctionFill" id="instuctionFill" class="medium form-control">
													 </select>
													 </td>

													<td><input type="text" name="closingStock1"
														tabindex="1" value="" id="closingStock1" size="3"
														validate="closingStock,string,no"   class="form-control width80" readonly/></td>
													
                                                   	<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom" size="77"
														name="itemIdNom" /></td>
													<td>
													
														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" button-type="add" value=""
															onclick="addNomenclatureRow();" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" id="deleteNomenclature" button-type="delete" value=""
															onclick="removeTreatmentRow(this);"
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
													<td style="display: none;"><input type="hidden"
														name="itemClassId" tabindex="1" id="itemClassId" size="10"
														readonly="readonly" /></td>	
													<td style="display: none";>
												     <input type="hidden" value="T" tabindex="1" id="treatmentAuditFlag" size="77" name="treatmentAuditFlag" />
													</td>	
												</tr>

											</tbody>
											<tr>
										</table> 
										</div>
						
										
										
										
										
	</div>
	<!-- -----Treatment   end here --------- -->
								
								
								
								<!-- -----Procedure   start here --------- -->
	
	 <div class="adviceDivMain" id="button10" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Minor Procedure  </span>
			
			</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton10" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost10">
      
      
      
      <div class=""> 

											<div class="row m-b-10">


												<div class="col-md-3">
													<div class="form-group">
														<!-- <div class="col-md-1">
															<input class="m-t-5" value="N" type="radio"
																checked="checked" name="procedureRadioName"
																id="procedureRadio"
																onchange="changeProcedureRadio(this.value)">
														</div>
														<label class="col-md-5 col-form-label">Nursing
															Care</label> -->
											

													</div>
												</div>
												
											

												<!-- <div class="col-md-3 text-right">
												<input type="button" id="createPrcocedure" value="Create Procedure" tabindex="1" class="btn btn-primary" data-toggle="modal" data-target="#smallModal" onclick="createProcedureMaster();">
												</div> -->

											</div>

											<div id="divTemplet">

												<table class="table table-bordered" align="center"
													cellpadding="0" cellspacing="0">
													<tr>
														<th>Name</th>
														<th>Remarks</th>
														<th>Add</th>
														<th>Delete</th>
														<!-- <th>Alert Me</th> -->
													</tr>
													<tbody id="gridNursing">
														<tr>
															<td>
																<div class="form-group autocomplete forTableResp">
																		<input type="text" autocomplete="never" class="form-control border-input disablecopypaste"
																		value="" id="procedureNameNursing" size="42"
																		name="procedureNameNursing" onKeyUp="getNomenClatureList(this,'populateNursing','opd','getMasNursingCare','procedureNursing');" />
																<div id="procedureNursing" class="autocomplete-itemsNew"></div>
																</div>
															</td>
														
															<td><textarea name="remark_nursing" id="remark_nursing" cols="0" rows="0"
													        	maxlength="500"  tabindex="5" class="form-control" maxlength="100"></textarea>
													        </td>
															<td style="display: none;"><input type="hidden"
																value="" id="procedureNameNursingId"
																name="procedureNameNursingId" /></td>
															<td style="display: none;"><input type="hidden"
																class="form-control border-input" value=""
																id="procedureNameNursing" size="55"
																name="procedureNameNursing" />
															<td style="display: none;"><input type="hidden"
																class="form-control border-input" value=""
																id="procedureNameNursingCare" size="55"
																name="procedureNameNursingCare" /></td>
															<td>
																<button type="button" class="buttonAdd btn btn-primary noMinWidth"
																	alt="Add" tabindex="4" button-type="add" value=""
																	onclick="addRowTreatmentNursingCare();"></button>
															</td>
															<td>
																<button type="button" class="buttonDel btn btn-danger noMinWidth"
																	tabindex="3" alt="Delete" button-type="delete" value=""
																	onclick="removeProcedureRow(this);"></button>
															</td>

															<td style="display: none;"><input type="hidden"
																id="procedureHeaderId" name="procedureHeaderId" value="" />
															</td>
															<td style="display: none;"><input type="hidden"
																name="nursinghdb" value="" id="nursinghdb" /></td>
														</tr>
													</tbody>
												</table>
												<!-- <label>Additional Advice</label>
												<textarea name="additionalNote"
													validate="referralNote,string,no" id="additionalNote"
													cols="0" rows="0" maxlength="500" tabindex="5"
													onkeyup="return checkLength(this)" style="width: 477px;"></textarea> -->
                                                  
                                                	 <div class="clearfix"></div>
											 <br>
                                                  <!-- 		<div class="row">
																 <div class="col-md-6">
																	<div class="form-group row">
																		<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Additional Advice </label>
																		<div class="col-md-7">
																			 <textarea name="additionalNote"   class="form-control"
																				validate="referralNote,string,no" id="additionalNote"
																				cols="0" rows="0" maxlength="500" tabindex="5"
																				onkeyup="return checkLength(this)">
																			</textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-6">
																	 
																</div>
															</div> 
											  -->
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  

											</div>
      
      
      
      
      
      </div>
			 
	</div>
	
	<!-- ----- Procedure  end here --------- -->
								
   <!-- -----Referral   start here --------- -->
	 <div class="adviceDivMain" id="button11" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Referral </span>
		</div>	
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton11" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost11">
      
      
      	<div id="referalDiv">
												
													<div class="row">
														<div class="col-md-4">
															<div class="form-group row ">

																<label class="col-md-4 col-form-label">Referral</label>

																<div class="col-md-8">
																	<select id="referral" name="referral" class="midium form-control">
																		<option value="0">No</option>
																		<option value="1">Yes</option>
																	</select>


																</div>

															</div>

														</div>



														<div class="col-md-4"></div>
														<div class="col-md-4"></div>


													</div>

													<!-- <label>Referral </label>
												 <select  style=" width: 10%;" id="referral" name="referral" class="midium">
													<option value="0">No</option>
													<option value="1">Yes</option>
												</select>
                                                  <br><br><br> -->
													<!-- <div id="referDiv" class="col collaps"
														style="display: block;">
														<label>Refer To</label> <label class="autoSpace">
															<input type="radio" class="radioCheckCol2" name="referTo"
															id="referExternal" value="E"
															onclick="checkReferTO('referExternal');"
															style="margin: 1px 5px 0px 0px;" checked="checked">External
														</label> <label class="autoSpace"> <input type="radio"
															class="radioCheckCol2" name="referTo" id="referInternal"
															value="I" onclick="checkReferTO('referInternal');"
															style="margin: 1px 5px 0px 0px;">Internal
														</label> -->





	                                                   <div id="referDiv"  style="display: block;">
														
														<div class="row m-t-10" >
												           
												           <div class="col-md-6 m-t-5" style="display:none">
															<label>Refer To</label> 
															<label class="autoSpace">
															
																<input type="radio" class="radioCheckCol2" name="referTo"
																id="referExternal" value="E" onchange="getEmpanelled()"
																onclick="checkReferTO('referExternal');"
																style="margin: 1px 5px 0px 85px;" checked="checked">External(Other Than ICG)
															</label> 
															
															<label class="autoSpace"> 
																<input type="radio"
																class="radioCheckCol2" onchange="getInternalRefferal()" name="referTo" id="referInternal"
																value="I" onclick="checkReferTO('referInternal');"
																style="margin: 1px 5px 0px 32px;">Internal
															</label>
	
															</div> 
														



														<!-- <label>Referral Date: </label> <input type="Date"
															name="referVisitDate" id="referVisitDate"
															placeholder="DD/MM/YYYY" value=""> -->
														<div class="col-md-12 text-right">
															<div class="form-group">
																<!-- <label class="col-md-5 col-form-label">Referral Date</label>
																
																<div class="col-md-7">
																	 <input type="date"  class="form-control"  name="referVisitDate" id="referVisitDate" onblur="checkReferalDate()" placeholder="DD/MM/YYYY" value="">
																</div> -->
																<input type="button" id="createEHospital" value="Create Empanelled Hospital" data-toggle="modal" data-target="#smallModal" data-backdrop="static" onclick="createEmpanlledMaster();" tabindex="1" class="btn btn-primary">
																															</div>
														</div>	
																												
													</div>
															
															
														<!-- onblur="checkAdmte()" -->
														<!-- <label id="priorityLabelId" style="display: block;">Current Proirity No.</label>
													 <select id="priorityId" name="priorityName" tabindex="1" style="display: block;">
														<option value="3">3</option>
														<option value="2">2</option>
														<option value="1">1</option>
													</select> -->
														<!-- <div class="clear"></div> -->
														<div id="referDepartmentDiv" style="display: block;">
															<table id="referGrid" class="table table-bordered">
																<thead>
																	<tr>
																		<th>S.No.</th>
																		<th>Hospital</th>
																		<th>Department</th>
																		
																	</tr>
																</thead>
																<tbody id="referalGrid">

																</tbody>
															</table>

															<input type="hidden" value="1" name="hiddenValueRefer"
																id="hiddenValueRefer">
														</div>
														<label id="referhospitalLabel" style="display: none;">Hospital
															<span>*</span>
														</label> <select id="referhospital" name="referhospital"
															onchange="fnGetHospitalDepartment(this.value);"
															style="display: none;" validate="">
															<option value="0">Select</option>

															<option value=""></option>

														</select> <label id="referdayslLabel" style="display: none;">No.
															of Days</label> <input id="referdays" name="referdays"
															type="text" maxlength="2" style="display: none;">

														<label style="display: none">Patient Advise</label>
														<textarea name="patientAdvise"
															validate="patientAdvise,string,no" id="patientAdvise"
															cols="0" rows="0" maxlength="500" tabindex="5"
															style="display: none"></textarea>
														<!-- <input type="button" class="buttonAuto-buttn" value="+"
										onclick="" /> -->
														<label id="referral_treatment_type_label"
															style="display: none">Treatment Type <span>*</span></label>
														<select id="referral_treatment_type"
															name="referral_treatment_type" style="display: none">
															<option value="1" selected="true">OPD</option>
															<option value="2">Admission</option>
														</select> <label id="referredForLabel" style="display: none">Referred
															For<span>*</span>
														</label> <input id="referredFor" name="referredFor" type="text"
															maxlength="300" validate="" style="display: none">
														
														
														<div class="row">
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Referral Notes</label>
														<div class="col-md-7">
															 <textarea name="referralNote" class="form-control" validate="referralNote,string,no" id="referralNote" cols="0" rows="0" maxlength="500" tabindex="5" ></textarea> 
														</div>
													</div>
												</div>
												
												<div class="col-md-6">													 
												</div>
											</div>  
														
													<div class="row">
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;">Others</label>
														<div class="col-md-7">
															 <textarea name="doctorRemarks" class="form-control" validate="doctorRemarks,string,no" id="doctorRemarks" cols="0" rows="0" maxlength="500" tabindex="5" ></textarea> 
														</div>
													</div>
												</div>
												
												<div class="col-md-6">													 
												</div>
											</div>  
														<!-- <input type="button" class="buttonAuto-buttn" value="+"
										onclick="" /> -->
													</div>

												</div>
      
      <div class="clearfix"></div>
			 
	</div>
	<div class="clearfix"></div>
	<!-- ----- Referral  end here --------- -->
	
	<!-- -----Follow Up   start here --------- -->
  <div  id="followUp" >
	 <div class="adviceDivMain" id="button12" onclick="showhide(this.id)">
		<div class="titleBg"style="width: 520px; float: left;">
			<span>  Follow Up </span>
	   </div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton12" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost12">
      
      
      <div class="row">
      
      <div class="col-md-3 ">
													<div class="form-check form-check-inline cusCheck ">
														<input class="form-check-input" type="checkbox" id="followUpChecked" onClick="followUpFlag(this)" value="Y">
														
													<span class="cus-checkbtn"></span>
													<div class="form-check form-check-inline cusRadio">
															<label class="col-md-12 col-form-label">Follow Up</label> 
													</div>
													</div>
												</div>
												
								<div class="col-md-4">
								<div class="form-group row">
									<label class="col-md-5 col-form-label">Number of Days</label>
									<div class="col-md-7">
										<select id="noOfDays" name="noOfDays" class="form-control" onchange="nextFolloUpDate(this.value)" >
											<option value="">Select</option>
											<option value="1">After 1 Day</option>
											<option value="2">After 2 Days</option>
											<option value="3">After 3 Days</option>
											<option value="4">After 4 Days</option>
											<option value="5">After 5 Days</option>
											<option value="6">After 6 Days</option>
											<option value="7">After 7 Days</option>
											<option value="8">After 8 Days</option>
											<option value="9">After 9 Days</option>
											<option value="10">After 10 Days</option>
											<option value="11">After 11 Days</option>
											<option value="12">After 12 Days</option>
											<option value="13">After 13 Days</option>
											<option value="14">After 14 Days</option>
											<option value="15">After 15 Days</option>
											<option value="16">Review SOS</option>
											<option value="17">Others</option>
											</select>
									</div>
								</div>
							</div>
							
							<div class="col-md-5">
								<div class="form-group row">
									<label class="col-md-4 col-form-label">Next Date</label>
									<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" class="form-control noBack_date2" id="nextFollowUpDate" placeholder="DD/MM/YYYY" />
										</div>					
									</div>	
								</div>
							</div>
							
							
													
	 </div>
													
													
												
	</div>
	</div>
	
	<!-- ----- Follow Up  end here --------- -->
	
	<!-- ----- doctor remark start here --------- -->
  
	 <div class="adviceDivMain" id="button13" onclick="showhide(this.id)">
		<div class="titleBg"style="width: 520px; float: left;">
			<span>Doctor's Remark</span>
	   </div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton13" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost13">
       <div class="row">
       <div class="col-12">
         <h6><a class="text-theme font-weight-bold text-underline" onClick="showDoctorRemarksTemplate('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Doctor's Remark Template</a></h6> 
                    <input type="hidden" name="countValueshowDoctorRemarksTemplate" id="countValueshowDoctorRemarksTemplate" value=""/>
         </div>
												<%-- <div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-6 col-form-label no-bold"  style="padding-left: 10px;"> Template </label>
														<div class="col-md-6">
															<div id="investigationDiv">
																<select name="medicalAdviceTemplateId"  class="form-control"
																	id="medicalAdviceTemplateId" tabindex="1">
																	<select name="treatmentTemplateId"	tabindex="1" onchange="showHideInvestigationTemplateCombo(this.value);">
																	<option value="0">Select</option>
																</select>
															</div>
														</div>
													</div>
												</div>

												<div class="col-md-2">
													<div class="form-group row">
														<div id="createInvestigationDivToShowHide" class="opd_invetigation_createtemplate">
															<input name="medicalAdviceTemplate" type="button"
																value="Create Template" tabindex="1" class="btn btn-primary "
																data-toggle="modal" data-target="#exampleModal"
																onclick="createMedicalAdviceTemplate();" />
														</div>
													</div>
												</div>
 
											</div> --%>
             
			 <div class="col-md-6">
				<div class="form-group row">
				  
					<label class="col-md-4 col-form-label" style="  padding-left: 10px;">Doctor's Remark</label>
					<div class="col-md-7 ">
						 <textarea name="additionalNote"   style="width:600px; height:100px;"  class="form-control border-input
							validate="referralNote,string,no" id="additionalNote"
							cols="0" rows="0" maxlength="500" tabindex="5" readonly></textarea>
					</div>
				</div>
			</div>										
	 	</div>										
												
	</div>
 </form:form>
	<!-- ----- doctor remark  end here --------- -->
	
	
 
								      <div class="clearfix"></div>
									<br>
									<div class="row">
										<div class="col-md-12 clearfix">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												<input type="submit" id="opdMainClicked"
													class="btn btn-primary" value="Submit"
													onclick="opdSubmitFunction()" />
												<!-- <button id="reset" class="btn  btn-danger" accesskey="r"/> Reset </button> -->
												<button type="reset" name="Reset" value=""
													class="btn  btn-danger" accesskey="r"
													onclick="resetForm();">Reset</button>
												<input type="submit" id="opdMainBack"
													class="btn btn-primary" value="Back"
													onclick="opdBackFunction()" />	

											</div>
										</div>
									</div>
  
	
   


										<!-- Disposal end here -->
						
							

		
	 
	 <div class="modal z-index5000" id="zzzmessageForAuthenticate" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

				<button type="button" onClick="closeMessage();" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>

			</div>
			<div class="modal-body">
				<div class="control-group">
					
						<div class='divErrorMsg form-group row' id='errordiv' ></div>
				<div class="form-group row" id="messageForAuthenticateMessae"></div>
				
					<div class="col-md-12">
							<div class="form-group row">
								<label class="col-md-5 col-form-label"><spring:message code="lblUHIDNumber"/> 
								</label>
								<div class="col-md-7">
									<input name="uhidNumber" id="uhidNumber" type="text"
										class="form-control border-input"
										placeholder="" value=""  />
								</div>
							</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" data-dismiss="modal"
					onClick="callToAutheniticate();" aria-hidden="true"><spring:message code="btnOK"/></button>
				<button class="btn btn-primary" data-dismiss="modal"
					onClick="closeMessage();" aria-hidden="true"><spring:message code="btnClsoe"/></button>
			</div>
		</div>
	</div>
</div>
	 
	 </div>
<div class="modal" id="modelForCurrentMedication"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeCurrentMedication();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<div style="float: right">
									<div id="resultnavigationForCurrentMedication"></div>
								</div>			
								
						
						<div class="table-responsive">
						
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
									<th>Drugs Name/Drugs Code</th>
									<th scope="col">Dosage<span>*</span></th>
									<th scope="col">Frequency<span>*</span></th>
									<th scope="col">Days<span>*</span></th>
									<th scope="col">Total<span>*</span></th>
									<th scope="col">Stock</th>
									<th scope="col">Deparment/Doctor</th>
									<!-- <th scope="col">Department</th> -->
									<th scope="col">Prescribed Date</th>
									<th>Stop</th>
									<th>Repeat</th>

								</tr>
								<tbody id="currentMedicationGrid">
								</tbody>
							</table>
						</div>




					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						  aria-hidden="true" onClick="submitCurrentMedication();"><spring:message code="btnSubmit"/></button>
					
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeCurrentMedication();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>
	
 <div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
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
         Loading <i class="fa fa-spin fa-spinner"></i>
        </div>
      </div> 
       <!-- <div class="text-center text-primary text-xsm">
         loading <i class="fa fa-spin fa-spinner"></i>
        </div> -->
    </div>
  </div>
</div>

 <div class="modal fade" id="smallModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center text-theme text-sm">
         Loading <i class="fa fa-spin fa-spinner"></i>
        </div>
      </div> 
       <!-- <div class="text-center text-primary text-xsm">
         loading <i class="fa fa-spin fa-spinner"></i>
        </div> -->
    </div>
  </div>
</div>

<div class="modal" id="messageForInvestigationOutside" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeMessage();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgForInves" /></span> <br />
									<spring:message code="msgDesignation2" />
									&#63;


								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="submitMOValidateFormByModel();" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<button class="btn btn-primary" data-dismiss="modal"
							onClick="closeMessage();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button>
					</div>
					
					
					
				</div>
			</div>
		</div>
		
<div class="modal" id="messageForTreatmentAlert" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeMessage();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgForTreatmentDaysLimit" /></span> <br />
									<spring:message code="msgDesignation2" />
									&#63;


								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitTreatmentAlert"  data-dismiss="modal"
							onClick="fillValueNomenclature()" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<button class="btn btn-primary" data-dismiss="modal"
							onClick="closeMessage();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button>
					</div>
					
					
					
				</div>
			</div>
		</div>	
		
<div class="modal" id="modelForRecommendedDiagnosis"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeRecommendedDiagnosis();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<!-- <div style="float: right" style="display:none;">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div> -->			
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Diagnosis</th>
								<th scope="col">Select</th>
								</tr>
								<tbody id="recommendedDiagnosis">
								</tbody>
							</table>
						</div>
                       </div>



					</div>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal"
						  aria-hidden="true" onClick="submitRecommendedAIForOpd();"><spring:message code="btnSubmit"/></button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeRecommendedDiagnosis();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>
	
<div class="modal" id="modelForRecommendedInvestgation"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeRecommendedInvestgation();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<!-- <div style="float: right" style="display:none;">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>	 -->		
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Investigation</th>
								<th scope="col">Select</th>
								</tr>
								<tbody id="recommendedInvestgation">
								</tbody>
							</table>
						</div>
                       </div>



					</div>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal"
						  aria-hidden="true" onClick="submitRecommendedAIInvestgationForOpd();"><spring:message code="btnSubmit"/></button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeRecommendedInvestgation();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>	
<div class="modal" id="modelForRecommendedTreatment"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeRecommendedTreatment();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
						<!-- 	<div style="float: right">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>	 -->		
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Treatment</th>
								<th scope="col">Select</th>
								</tr>
								<tbody id="recommendedTreatment">
								</tbody>
							</table>
						</div>
                       </div>



					</div>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal"
						  aria-hidden="true" onClick="submitRecommendedAITreatmentForOpd();"><spring:message code="btnSubmit"/></button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeRecommendedTreatment();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>	
	
<div class="modal" id="modelForDoctorRemarks"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeDoctorRemarks();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<!-- <div style="float: right">
									<div id="resultnavigationForDoctorRemarks"></div>
								</div>	 -->		
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th>Doctor Remarks</th>
								<th>Select</th>

								</tr>
								<tbody id="modelForDoctorRemarksGrid">
								</tbody>
							</table>
						</div>
                       </div>



					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						  aria-hidden="true" onClick="submitDoctorRemarks();"><spring:message code="btnSubmit"/></button>
					
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeDoctorRemarks();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>	
<div class="modal" id="msgForAIDiagnosis" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeDiagnosisMessage();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="messageForAIDiagnosis" /></span> 
								 </div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelDiagnosisId"  data-dismiss="modal" value=""
							onClick="showdiagLoader();showAllAuditRecommendedDiagnosis('ALL','SearchStatusForUnitAdminCurrentMedication');closeDiagnosisMessage(this.value);" aria-hidden="true">
							<spring:message code="btnYes" />
						</button>
					 <button class="btn btn-primary" data-dismiss="modal" id="currentDiagnosisRowItem" value=""
							onClick="clearAiDiagnosis(this.value);" aria-hidden="true">
							<spring:message code="btnNo" />
					</button>
					</div>
					
					
					
				</div>
			</div>
</div>
				
<div class="modal" id="msgForAIInvestigation" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeMessage();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="messageForAIInvestigation" /></span> 
								 </div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelInvestgationId"  data-dismiss="modal"
							onClick="showinvesLoader();showAllAuditRecommendedInvestigation('ALL','SearchStatusForUnitAdminCurrentMedication');closeInvestigationMessage(this.value);" aria-hidden="true">
							<spring:message code="btnYes" />
						</button>
					 <button class="btn btn-primary" data-dismiss="modal" id="currentInvRowItem" value=""
							onClick="clearAiInvestgation(this.value);" aria-hidden="true">
							<spring:message code="btnNo" />
					</button>
					</div>
					
					
					
				</div>
			</div>
</div>

<div class="modal" id="msgForAITreatment" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeMessage();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="messageForAITreatment" /></span> 
								 </div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelTreatmentId"  data-dismiss="modal"
							onClick="showtreatLoader();showAllAuditRecommendedTreatment('ALL','SearchStatusForUnitAdminCurrentMedication');closeTreatmentMessage(this.value);" aria-hidden="true">
							<spring:message code="btnYes" />
						</button>
					 <button class="btn btn-primary" data-dismiss="modal" id="currentTreatRowItem" value=""
							onClick="clearAiTreatment(this.value);" aria-hidden="true">
							<spring:message code="btnNo" />
					</button>
					</div>
					
					
					
				</div>
			</div>
</div>

<!-- 
<div class="modal-backdrop show" style="display:none;"></div>

 -->


	<script>

<!-- All Java Script and Ajax code written by @Krishna kumar :March 2019 for ICG(Indian Coast Guard) -->	
	
var checkBox='';

</script>

	<script>
            /*An array containing all the country names in the world:*/
            //var countries = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua & Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia & Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central Arfrican Republic","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cuba","Curacao","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kiribati","Kosovo","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauro","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","North Korea","Norway","Oman","Pakistan","Palau","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre & Miquelon","Samoa","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Korea","South Sudan","Spain","Sri Lanka","St Kitts & Nevis","St Lucia","St Vincent","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad & Tobago","Tunisia","Turkey","Turkmenistan","Turks & Caicos","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States of America","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"];
            var arry = new Array();
            var icdArry = new Array();
            
           // autocomplete(document.getElementById("icd"), arry);

                   
            var arryInvestigation = new Array();
           /*  var inVal=$('#dgInvetigationGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
            autocomplete(inVal, arryInvestigation); */
            
             var arryNomenclature= new Array();
            /*  var val=$('#nomenclatureGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
             autocomplete(val, arryNomenclature);
              */
        
             
            // autocomplete(document.getElementById("procedureNameNursing"), arryProcedureCare);
             
                 
        </script>

	<script type="text/javascript">
            var popup;

            function SelectName() {
                popup = window.open("getFamilyPatinetHistory?employeeId="+<%=userId%>+"", "popUpWindow", "height=500,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
            }
            
            function chiefComplaint() {
                popup = window.open("getChiefComplaint?employeeId="+<%=userId%>+"", "popUpWindow", "height=500,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
            }
        </script>

	<script type="text/javascript">
            var popup;

            function showCreateInvestigationTemplate() {
            	
                $('#exampleModal .modal-body').load("showCreateInvestigationTemplate?employeeId="+<%= userId %>);
                $('#exampleModal .modal-title').text('Investgation Template');
            }
            
            function opdUpdateInvestigationTemplate() {
            	  $('#exampleModal .modal-body').load("opdUpdateInvestigationTemplate?employeeId="+<%= userId %>);
                  $('#exampleModal .modal-title').text('Update Investigation Template');
              }
            
            function createTreatmentTemplate() {
                $('#exampleModal .modal-body').load("createTreatmentTemplate?employeeId="+<%= userId %>);
                $('#exampleModal .modal-title').text('Treatment Template');
            }

            function opdUpdateTreatmentTemplate() {
          	    $('#exampleModal .modal-body').load("opdUpdateTreatmentTemplate?employeeId="+<%= userId %>);
                $('#exampleModal .modal-title').text('Update Treatment Template');
            }
            
            function showUpdateInvestigationTemplate() {
               popup = window.open("showUpdateInvestigationTemplate?employeeId="+<%= userId %>+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus(); 
                
            }
            function createMedicalAdviceTemplate() {
                $('#exampleModal .modal-body').load("createMedicalAdviceTemplate?employeeId="+<%= userId %>);
                $('#exampleModal .modal-title').text('Medical Advice Template');
            }
            
            function createNivTreatmentTemplate() {
                $('#exampleModal .modal-body').load("createNivTreatmentTemplate?employeeId="+<%= userId %>);
                $('#exampleModal .modal-title').text('NIV Treatment Template');
            }
            
            function opdUpdateNivTemplate() {
          	    $('#exampleModal .modal-body').load("opdUpdateNivTemplate?employeeId="+<%= userId %>);
                $('#exampleModal .modal-title').text('Update Niv Template');
            }
            
			/* function showPreveiousVisit() {            	
                popup = window.open("showPreveiousVisit?patientId="+$('#patientId').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
            }
			 */
			 var uhidNumberValue="";
			 var checkForAuthen="";
			 function showPreveiousVisit() {
				 
					 $('#exampleModal').show();
					 $('.modal-backdrop').show();
				     $('#exampleModal .modal-body').load("showPreveiousVisit?patientId="+$('#patientId').val());
	                 $('#exampleModal .modal-title').text('Previous Visit');
						
			 }
			 
			 function showPreveiousVital() {
				
					
					 $('#exampleModal').show();
					 $('.modal-backdrop').show();
				     $('#exampleModal .modal-body').load("showPreveiousVital?patientId="+$('#patientId').val());
	                 $('#exampleModal .modal-title').text('Previous Vitals');
				    /*  popup = window.open("showPreveiousVital?patientId="+$('#patientId').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
				     popup.focus(); */
					
			 }
			 
			 function showAuditHistory() {
					
					
				 $('#exampleModal').show();
				 $('.modal-backdrop').show();
			     $('#exampleModal .modal-body').load("showAuditHistory?patientId="+$('#patientId').val());
                 $('#exampleModal .modal-title').text('Audit History');
			    /*  popup = window.open("showPreveiousVital?patientId="+$('#patientId').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
			     popup.focus(); */
				
		 }
			 
			 function showPreveiousLabInvestigation() {
				
					 $('#exampleModal').show();		
				     $('#exampleModal .modal-body').load("showPreveiousLab?patientId="+$('#patientId').val());
	                 $('#exampleModal .modal-title').text('Previous Lab Investigation');
				     
					
			 }
			 
           function showPreveiousRadioInvestigation() {
        	   
					 $('#exampleModal').show();
					 $('.modal-backdrop').show();
				     $('#exampleModal .modal-body').load("showPreveiousRadio?patientId="+$('#patientId').val());
	                 $('#exampleModal .modal-title').text('Previous ECG Investigation');
				 
			 }
			 
		
			 function showPreveiousHospitalization() {
				 
					 $('#exampleModal').show();
					 $('.modal-backdrop').show();
				     $('#exampleModal .modal-body').load("showPreveiousHospitalization?patientId="+$('#patientId').val());
	                 $('#exampleModal .modal-title').text('Previous Hospitalization');
				  
			 }
			 
			
			function showUploadDocument() {  
				 
				
					 $('#exampleModal').show();
					 $('.modal-backdrop').show();
				     $('#exampleModal .modal-body').load("opdUploadDocument?patientId="+$('#patientId').val());
	                 $('#exampleModal .modal-title').text('View Patient Documents');
				   
			 }
			
			/* function showEHRRecords() {
				  var pathname = window.location.pathname;
                  var accessGroup = "MMUWeb";
				var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/ehr/patientSummary?patientId=";
                window.open(url+$('#patientId').val()+"");
                
            } */

            function showEHRRecords() {
            	var userCountVal=$('#usersCounts').val();
				 if(userCountVal=="0")
				 {	 
				 checkForAuthen =$("#checkForAuthenticationValue").val();
				 }
				 uhidNumberValue =$("#uhidNumberValue").val();
				
          	  var pathname = window.location.pathname;
               var accessGroup = "MMUWeb";
          	var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/ehr/patientSummary?patientId=";
      		var userIdd = <%= userId %>;
          	 if(uhidNumberValue=="success" ||userCountVal!="0"){
          	   window.open(url+$('#patientId').val()+"&userId="+userIdd+"");
          		 }
          	else{
          		if(checkForAuthen=="popUpShow"){
          			 $("#messageForAuthenticate").show();
          			$(".modal-backdrop").show();
          		 	}
          		 else{
          			 window.open(url+$('#patientId').val()+"&userId="+userIdd+"");
          		 } 
          	}
          	
          }
            
            function childVaccinationChart() {      
				 
				 checkForAuthen =$("#checkForAuthenticationValue").val();
				 uhidNumberValue ="success";
				 if(uhidNumberValue=="success"){
				     /* popup = window.open("showPreveiousLab?patientId="+$('#patientId').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
				     popup.focus(); */
				     $("#messageForAuthenticate").hide();
					 $('.modal-backdrop').hide();
				     $('#exampleModal .modal-body').load("childVaccinationChart?visitId="+$('#visitId').val());
	                 $('#exampleModal .modal-title').text('Child Vaccination Chart');
			     
					 }
					 else{
						 if(checkForAuthen=="popUpShow"){
							 $("#messageForAuthenticate").show();
							 $('.modal-backdrop').show();
						 	}
						 else{
							 $('#exampleModal .modal-body').load("childVaccinationChart?visitId="+$('#visitId').val());
			                 $('#exampleModal .modal-title').text('Child Vaccination Chart');

						 } 
					 }
			 }
            
            function growthChart() {      
				 
				 checkForAuthen =$("#checkForAuthenticationValue").val();
				 uhidNumberValue ="success";
				 if(uhidNumberValue=="success"){
				     /* popup = window.open("showPreveiousLab?patientId="+$('#patientId').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
				     popup.focus(); */
				     $("#messageForAuthenticate").hide();
					 $('.modal-backdrop').hide();
				     $('#exampleModal .modal-body').load("showChildGrowthChart?patientId="+$('#patientId').val());
	                 $('#exampleModal .modal-title').text('Child Growth Chart');
				     
					 }
					 else{
						 if(checkForAuthen=="popUpShow"){
							 $("#messageForAuthenticate").show();
							 $('.modal-backdrop').show();
						 	}
						 else{
							  $('#exampleModal .modal-body').load("showChildGrowthChart?patientId="+$('#patientId').val());
				              $('#exampleModal .modal-title').text('Child Growth Chart');

						 } 
					 }
			 }
     
			function createProcedureMaster() {
                <%-- popup = window.open("createProcedureMasters?employeeId="+<%= userId %>+"", "popUpWindow", "height=500,width=900,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus(); --%>
                var radioValue = document.querySelector('input[name = "procedureRadioName"]:checked').value;
                $('#smallModal .modal-body').load("createProcedureMasters?employeeId="+<%= userId %>+"&radioValue="+radioValue);
                $('#smallModal .modal-title').text('Procedure Masters');
            }
			
			function createEmpanlledMaster() {
               <%-- popup = window.open("opdEmpanlledMaster?employeeId="+<%= userId %>+"", "popUpWindow", "height=500,width=900,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes"); --%>
               // popup.focus();
                
                $('#smallModal .modal-body').load("opdEmpanlledMaster?employeeId="+<%= userId %>);
                $('#smallModal .modal-title').text('Empanelled Hospital Masters');
            }
			
			function refershEmpanlledMaster() {
				
				getEmpanelledHospital();
			}
			
			 function showImmunization() {
				 var userCountVal=$('#usersCounts').val();
				 if(userCountVal=="0")
				 {	 
				 checkForAuthen =$("#checkForAuthenticationValue").val();
				 }
				 uhidNumberValue =$("#uhidNumberValue").val();
				 if(uhidNumberValue=="success" ||userCountVal!="0"){
					     //getPatientImmunizationHistory('ALL','SearchStatusForMassDesignation');
					 $('.modal-backdrop').hide();
						$('#exampleModal').show();
						$('.modal-backdrop').show();
							showImmunizationTemplate();	 	 
				 }
					 else{
						 if(checkForAuthen=="popUpShow"){
							 $("#messageForAuthenticate").show();
							 $('.modal-backdrop').show();
						 	}
						 else{
							// getPatientImmunizationHistory('ALL','SearchStatusForMassDesignation');
							 $('.modal-backdrop').hide();
								$('#exampleModal').show();
								$('.modal-backdrop').show();
									showImmunizationTemplate();	 
						 } 
					 }
			 }
			
			function showPreviousMeMb(type) {
				 var userCountVal=$('#usersCounts').val();
				 if(userCountVal=="0")
				 {	 
				 checkForAuthen =$("#checkForAuthenticationValue").val();
				 }
				 uhidNumberValue =$("#uhidNumberValue").val();
				 if(uhidNumberValue=="success" ||userCountVal!="0"){
					 getCompleteMedicalExamMEOrMB('ALL','SearchStatusForUnitAdmin',type);
					  //$('#exampleModal .modal-body').load("showPreveiousMedicalExamBoard?patientId="+$('#patientId').val());
		                // $('#exampleModal .modal-title').text('Previous Visit');
					 }
					 else{
						 if(checkForAuthen=="popUpShow"){
							 $("#messageForAuthenticate").show();
							 $('.modal-backdrop').show();
						 	}
						 else{
							 getCompleteMedicalExamMEOrMB('ALL','SearchStatusForUnitAdmin',type);
							 // $('#exampleModal .modal-body').load("showPreveiousMedicalExamBoard?patientId="+$('#patientId').val());
				               //  $('#exampleModal .modal-title').text('Previous Visit');
						 } 
					 }
			 }
			
        </script>
<script>
	function showdiagLoader(){$('#diagLoader').show();}
	function showinvesLoader(){$('#invesLoader').show();}
	function showtreatLoader(){$('#treatLoader').show();}
	function showtreatLoaderCurrent(){$('#treatLoaderCurrent').show();}
	</script>

	<script type="text/javascript" language="javascript">
            $(document).ready(
            	
            		
                function() {
                	
                	$('#diagLoader').hide();
            		$('#invesLoader').hide();
            		$('#treatLoader').hide();
            		$('#treatLoaderCurrent').hide();
            		
                	
                	
                    var pathname = window.location.pathname;
                    var accessGroup = "MMUWeb";

                    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getIcdList";

                    //var data = $('employeeId').val();

                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        url: url,
                        data: JSON.stringify({
                            'employeeId': <%= userId %>
                        }),
                        dataType: 'json',
                        timeout: 100000,

                        success: function(res)

                        {
                        	icdData = res.ICDList;
                        	autoIcdCode=res.ICDList;
                            //alert(data.length);
                            //console.log('data :',data);
                            var autoIcdList = [];
                            for (var i = 0; i < icdData.length; i++) {
                                var icdId = icdData[i].icdId;
                                var icdCode = icdData[i].icdCode;
                                var icdName = icdData[i].icdName;
                                var communicableFlag = icdData[i].communicableFlag;
                                var infectionsFlag = icdData[i].infectionsFlag;
                                var a = icdName + "[" + icdCode + "]"

                                var icdId = icdName + "[" + icdId + "]"
                                autoIcdList[i] = a;
                                    //alert("a "+a);
                                arry.push(a);
                                icdArry.push(icdId);
                                //console.log('data :', a, icdId);
                            }
                           
                            //putIcdIdValue(autoIcdList, icdData);

                        },
                        error: function(jqXHR, exception) {
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
                            alert(msg);
                        }
                    });
                                  
                });
            
            var autoIcdCode = '';
           var icdData= '';	 
            var idIcdNo = '';
            var icdValue = '';
            var multiIcdValue=[];
          /*  function putIcdIdValue(item){
           	 //  alert(pvmsNo);
           	 
           	  for(var i=0;i<autoIcdCode.length;i++){
           		  
           		  var icdNo1 = icdData[i].icdCode;
           		 
           		  if(icdNo1 == idIcdNo){
           			icdValue = icdData[i].icdId;
           			alert("Icditem id is " + icdValue )
           		  }
           	  }
           	  
           	// $('#diagnosisId').append('<option value=' + icdValue + '>' + val + '</option>');
           	         	  
             }  */
         var total_icd_value = '';
          var digaoReferal='';   
         
            function fillDiagnosisCombo(val) {
            	 
            	
                var index1 = val.lastIndexOf("[");
                var index2 = val.lastIndexOf("]");
                index1++;
                idIcdNo = val.substring(index1, index2);
                if (idIcdNo == "") {
                    return;
                } else {
                    obj = document.getElementById('diagnosisId');
                    total_icd_value += val+",";
                   
                    obj.length = document.getElementById('diagnosisId').length;
                    var b = "false";
                    for(var i=0;i<autoIcdCode.length;i++){
                 		  
                 		  var icdNo1 = icdData[i].icdCode;
                 			
                 		  if(icdNo1 == idIcdNo){
                 			icdValue = icdData[i].icdId;
                 			multiIcdValue.push(icdValue);
                 			digaoReferal=icdValue;
                 			 $("#diagnosisId option").each(function()
                              		{
                              		    if($(this).val()==icdValue){
                              		    alert("ICD diagnosis is already added");
                              		    document.getElementById('icd').value = ""
                              		    b=true;
                              		    }
                              		});
                 		  }
                 	  }
                    if (b == "false") {
                    	
                        $('#diagnosisId').append('<option value=' + icdValue + '>' + val + '</option>');
                        document.getElementById('icd').value = ""

                    }
                }
            }

            function fillReferalDiagnosisVal(item)
            {
            var val= $(item).closest('tr').find("td:eq(7)").find(":input").val(digaoReferal)
            }
            
            
        </script>

	<!-- <script type="text/javascript" language="javascript">
            
            '""'
            var $j = jQuery.noConflict();
            $j(document).ready(function() {
                alert("localStorage.patient: " + localStorage.patientId);
                document.getElementById('visitId').value = localStorage.visitId;
                document.getElementById('patient_Id').value = localStorage.patientId;

            });
        </script> -->

	<!-- <script type="text/javascript">
   $(document).ready(function () {
       $('#height').keyup(function () { alert('test'); });
   });
</script> -->

	<script type="text/javascript">
            $(document).ready(function() {
                /* if (typeof element !== "undefined" && element.value == '') {
                } */
                
                
                var data = ${
                    data
                };
                if(data.data[0].departmentCode!=null && data.data[0].departmentCode!="")
                {
                	if(data.data[0].gender== "FEMALE")
                	{
                		$('#obstetricsId').show();
                		$('#mensturalHistoryId').show();
                		//$('#systemicExamination').show();
                		//$('#cardiovascularSystem').show();
                		$('#perVaginalExaminationId').show();
                		document.getElementById('flagForFwc').value ='fwc';               		
                	}
                }
                
               if (data.data[0].visitId != null) {
                    document.getElementById('visitId').value = data.data[0].visitId;
                }
                if (data.data[0].departmentId != null) {
                    document.getElementById('departmentId').value = data.data[0].departmentId;
                }
                if (data.data[0].genderId != null) {
                    document.getElementById('genderId').value = data.data[0].genderId;
                }
                if (data.data[0].patientId != null) {
                    document.getElementById('patientId').value = data.data[0].patientId;
                }
               
                if (data.data[0].gender != null) {
                    document.getElementById('gender').value = data.data[0].gender;
                }
             
                if (data.data[0].patientName != null) {
                    document.getElementById('empname').value = data.data[0].patientName;
                }
                
                if (data.data[0].ageFull != null) {
                    document.getElementById('age').value = data.data[0].ageFull;
                    document.getElementById('ageNumber').value = data.data[0].age;
                    
                }
             
                if (data.data[0].mobileno != null) {
                    document.getElementById('mobileno').value = data.data[0].mobileno;
                }
                if(data.data[0].patientType=="G"){	
                	 document.getElementById('ptientType').value ='General Citizen';
     	 			}
     	 		 else if(data.data[0].patientType=="L"){
     	 			document.getElementById('ptientType').value = 'Labour';
     	 			}
 	 			
 	 			if (data.data[0].patientImage != null ) {
 	 				console.log(data.data[0].patientImage);
 	 				prevPic.setAttribute('src', "data:image/png;base64,"+data.data[0].patientImage);
 					
 	             } else {
 	            	prevPic.setAttribute('src', "/MMUWeb/resources/images/no-photo.jpg");
 	             } 
     	 			
                if (data.data[0].height != null) {
                    document.getElementById('height').value = data.data[0].height;
                }
               /*  if (data.data[0].idealWeight != null) {
                    document.getElementById('ideal_weight').value = data.data[0].idealWeight;
                } */
                if (data.data[0].weight != null) {
                    document.getElementById('weight').value = data.data[0].weight;
                }
                /* if (data.data[0].varation != null) {
                    document.getElementById('variant_in_weight').value = data.data[0].varation;
                } */
                if (data.data[0].tempature != null) {
                    document.getElementById('tempature').value = data.data[0].tempature;
                }
                if (data.data[0].bp != null) {
                    document.getElementById('bp').value = data.data[0].bp;
                }
                if (data.data[0].bp1 != null) {
                    document.getElementById('bp1').value = data.data[0].bp1;
                }
                if (data.data[0].pulse != null) {
                    document.getElementById('pulse').value = data.data[0].pulse;
                }
                if (data.data[0].spo2 != null) {
                    document.getElementById('spo2').value = data.data[0].spo2;
                }
                if (data.data[0].bmi != null) {
                    document.getElementById('bmi').value = data.data[0].bmi;
                }
                if (data.data[0].rr != null) {
                    document.getElementById('rr').value = data.data[0].rr;
                }
                
                getPatientSympotons();
                //checkForAuthenticateUser();
                if (data.data[0].pastMedicalHistory != null) {
                    document.getElementById('pastMedicalHistory').value = data.data[0].pastMedicalHistory;
                }
                if (data.data[0].pastSurgicalHistory != null) {
                    document.getElementById('surgicalHistory').value = data.data[0].pastSurgicalHistory;
                }
                if (data.data[0].medicationHistory != null) {
                    document.getElementById('medicationHistory').value = data.data[0].medicationHistory;
                }
                if (data.data[0].socailHistory != null) {
                    document.getElementById('socialHistory').value = data.data[0].socailHistory;
                }
                if (data.data[0].familyHistory != null) {
                    document.getElementById('familyHistory').value = data.data[0].familyHistory;
                }
                if (data.data[0].allegeyHistory != null) {
                    document.getElementById('allergyHistory').value = data.data[0].allegeyHistory;
                }
                if (data.data[0].registrationTypeCode != null) {
                    document.getElementById('registrationTypeCode').value = data.data[0].registrationTypeCode;
                }
                if(data.data[0].age<16)
            	{
                	$('#childVaccinationId').show();	
            	}
                
               /*  if (data.data[0].implantHistory != null) {
                    document.getElementById('implantHistory').value = data.data[0].implantHistory;
                } */
               // patientHistoryData();
                getWardDepartment();
                getUsersAuth();
            
                
            });
        </script>

	<script type="text/javascript">
	function idealWeight() {
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/getIdealWeight";
	   
		var dataJSON={
				 
				  'height':$('#height').val(),
	      		  'age':$('#ageNumber').val(),
				  'genderId':$('#genderId').val(),
				
		}
		
		
	   
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify(dataJSON),
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				//console.log("SUCCESS: ", data);
				
			   	   	   if (data.status == 1) {
				//var data = data;
				//alert("value is "+data.data[0].idealWeight);
				$('#ideal_weight').val(data.data[0].idealWeight);
				$('#ideal_weight').attr("disabled","disabled");
	           
				
			    }
			   	   	   else
			   	   		   {
			   	   		   	alert("Ideal Weight Not Configured")
			   	   		   	$('#ideal_weight').val();
							$('#ideal_weight').removeAttr("disabled");
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
	
	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		if(a!="" && b!="")
		{	
		var c=b/100;
		var d=c*c;
		var sub = a/d;
		$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		}
		else
		{
			$('#bmi').val("");
		}	
		
	}
	
	function checkObsistyMark() {
		
			if(document.getElementById('variant_in_weight').value== '' && document.getElementById('variant_in_weight').value== undefined)
			{
				alert("Please enter Height and Varation and Weight");
				return false;
			}
		    
		
		
		
	}
	
  </script>

	<script type="text/javascript">
            
                   /*  function checkVaration()  {

                    	var a = document.getElementById("ideal_weight").value;
                		var b = document.getElementById("weight").value;
                      if(a!=null && b!=null && a!="" && b!="")
                       {	  
                		if (parseFloat(a) > parseFloat(b)) {
                			var sub = a - b;
                			var cal = sub * 100 / a
                			var n = cal.toFixed(2);
                			$('#variant_in_weight').val("-" + n);

                		} else {
                			var eadd = b - a;
                			var cal1 = eadd * 100 / a
                			var n1 = cal1.toFixed(2);
                			$('#variant_in_weight').val("+" +n1);
                		}
                		
                     }	
				} */
                    
                    var followUpFlagValue='';
                    
                    function followUpFlag()
                    {
                    
	    	            if(document.getElementById("followUpChecked").checked == true){
	    	            	followUpFlagValue="Y";
	    	            	//alert("this is true")
	    	            	
	    	            }
	    	            else
	    	            {
	    	            	followUpFlagValue="N";
	    	            	//alert("this is false")
	    	            }	
                    } 
                    
                    var markAsMLC='';
                    function marksAsMLC()
                    {
                    
	    	            if(document.getElementById("markMLC").checked == true){
	    	            	markAsMLC="Y";
	    	            	$('#markMLCSection').show();
	    	            	var someDate = new Date();
	    	            	var dd = someDate.getDate();
	    	            	var mm = someDate.getMonth() + 1;
	    	            	var y = someDate.getFullYear();
	    	            	var someFormattedDate = dd + '/'+ mm + '/'+ y;
	    	            	$('#'+"mlcDate").val(someFormattedDate);
	    	            	var mmuName=$('#mmuName').val();
	    	            	var campName=$('#campName').val();
	    	            	$('#'+"mlcNameOfInstatuition").val('MMSSY,'+mmuName);
	    	               	$('#'+"mlcPlace").val(campName); 
	    	            	
	    	            	
	    	            	
	    	            }
	    	            else
	    	            {
	    	            	markAsMLC="N";
	    	            	$('#markMLCSection').hide();
	    	            	//alert("this is false")
	    	            }	
                    } 
        </script>

	<script type="text/javascript" language="javascript">
             function opdSubmitFunction() {
                var pathname = window.location.pathname;
                var accessGroup = "MMUWeb";

                var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/saveOpdPatientdetails";
                
             
                ///////////////////Vitals Validation //////////////////////////////////////
                var height = $('#height').val();
                var weight = $('#weight').val();
			    var tempature = $('#tempature').val();
			    var bp = $('#bp').val();
			    var bp1 = $('#bp1').val();
			    var pulse = $('#pulse').val();
			    
			    var agee = $('#ageNumber').val();
				//var ageFlag = $('#ageId').val();
				
				if(agee >12){
					
					var	bp = $('#bp').val();
					if(bp == ''){
						alert("Please enter bp");
						return;
					}
					var bp1 = $('#bp1').val();
					if(bp1 == ''){
						alert("Please enter bp");
						return;
					}
				}
			    if(height=="" ||weight==""||tempature==""||pulse=="")
			    {
			    	alert("Please enter height,weight,Temperature and pulse in vital section");
			 		return false;
			    }	
				if(height==0 || weight==0 || tempature==0|| pulse==0)
				 {
			 		alert("Height,Weight,Temperature and Pulse should be greater than 0");
			 		return false;
				 }
			    
                   
			    
                  /* if(total_icd_value=="") {
                	alert("Please enter at least one Diagnosis in Diagnosis Section ");
                	document.getElementById('icd').focus();
                    return false;
                  } */
                  
                  //////////////////////////Follow up validation ///////////////////////
                  var followUpd=document.getElementById("noOfDays");
	             var followDays=followUpd.value;
	            
                  if($('#nextFollowUpDate').val()!="")
                  {
                   if(document.getElementById("followUpChecked").checked == false){
                	   
                		   alert("Please Mark Follow-Up")
                		   return false;
                    }
                   }
                  
				//////////////////////////////Diagnosis validation part ////////////////	
                var  idforDiagnosis='';
      			var valDiagnosisGrid='';	
      			if($('#diagnosisGrid tr'))
      			{
      	 		 $('#diagnosisGrid tr').each(function(i, el) {
      	 			idforDiagnosis= $(this).find("td:eq(0)").find("input:eq(5)").val() 
  		    		 var $tds = $(this).find('td')
  		           	    var itemIdDiagnsosisCheck = $tds.eq(0).find(":input").val();
	      	 			if($('#dgInvetigationGrid tr').length > 0)
	        			{
	      	 				var diagonsisValue = $tds.eq(5).find(":input").val();
	      	 				if(diagonsisValue==""){
					        	 alert("Please enter valid diagnosis name"); 
					        	 itemIdDiagnsosisCheck.focus();
					      		 return false; 
					        	
					         }
	      	 				if(itemIdDiagnsosisCheck==""){
 					        	 alert("Please enter valid diagnosis name"); 
 					        	 itemIdDiagnsosisCheck.focus();
 					      		 return false; 
 					        	
 					         }
	        			}
	      	 			else
	      	 			{	
  					      // alert(id);
  					         if(idforDiagnosis==""){
  					        	 alert("Please enter valid diagnosis name"); 
  					        	 itemIdDiagnsosisCheck.focus();
  					      		 return false; 
  					        	
  					         }
	      	 			}
  					       
  				    
      	 		 }); 
      			}
                  
                  var flag = true;
                  
               /////////////////// referral Validation ///////////////////////////////   
                       
                  $('#referalGrid tr').each(function(i, el) {
	            	    var $tds = $(this).find('td')
	            	    var extHospitalId = $tds.eq(1).find(":input").val();
	            	    var deptId = $tds.eq(2).find(":input").val();
	            	 
	            	
	            	 if(extHospitalId== "")
              	    {
                  		alert("Please select hospital for referral");
                  		flag = false;
                  		return false;    	
              		}
	            		            	 
                  });
                  if(flag == false){
                	  return;
                  }	  	
              
                
               ////////////////////////////// investigation validation part ////////////////	
                var  idforInvestigation='';
    			var valnomenclatureGrid='';	
    			
    	 		 $('#dgInvetigationGrid tr').each(function(i, el) {
    	 			idforInvestigation= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
		    		 var $tds = $(this).find('td')
		           	    var itemIdCheck = $tds.eq(1).find(":input").val();
    	 			    var itemIdCheckText = $tds.eq(0).find(":input").val();
    	 			   if($('#dgInvetigationGrid tr').length > 1)
    	    			{
					      // alert(id);
					         if(itemIdCheck==""){
					        	 alert("Please enter valid Investigation name"); 
					        	 itemIdCheck.focus();
					      		 return false; 
					        	
					         }
    	    			}
    	 			   else
    	 				  {
    	 				  if(itemIdCheckText!="" && itemIdCheck==""){
					        	 alert("Please enter valid Investigation name"); 
					        	 itemIdCheck.focus();
					      		 return false; 
					        	
					         }
    	 				   
    	 				  } 
    	 			   
				    
    	 		 }); 
    			
             /////////////////////// treatment validation part ////////////////////////////
              	if($('#nomenclatureGrid tr').length > 1)
    			{
    	 		 $('#nomenclatureGrid tr').each(function(i, el) {
    	 		    	var $tds = $(this).find('td')
		           	    var itemNomenclatureIdCheck = $tds.eq(8).find(":input").val();
		           	   
					      // alert(id);
					         if(itemNomenclatureIdCheck==""){
					        	 alert("Please enter valid Drugs Name"); 
					        	 itemNomenclatureIdCheck.focus();
					      		 return false; 
					        	
					         }
					       
				    
    	 		 }); 
    			}
               if($('#campId').val()==null)
               {
            	   alert("Camp Not available")
               } 
             
            	var extNomenclatureFlag=true;
				var  idforTreat='';
    			var valnomenclatureGrid='';	
    	 		 $('#nomenclatureGrid tr').each(function(i, el) {
    	 			idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
    	 			var $tds = $(this).find('td')
       	    		var treatmentName = $tds.eq(0).find(":input").val();
       	    		var dosage = $tds.eq(2).find(":input").val();
       	   			var frequency = $tds.eq(3).find(":input").val();
       	   			var splitFrequency=frequency.split("@");
       	   		 	var days = $tds.eq(4).find(":input").val();
       	   			var instruction = $tds.eq(6).find(":input").val();
       	   		    var totalNom = $tds.eq(5).find(":input").val();
       	            var treatmentItemId=$tds.eq(8).find(":input").val(); 
       	            
       	         	if(frequency!= "" || dosage!= "" || days!= "")
 	 				{	
    	          	if(treatmentName== "")
  	   			 	{
      				alert("Please Enter Drugs Name");
      				treatmentName.focus();
      				return false;	    	
  				  	}
    	          	if(treatmentName!= "" && treatmentItemId=="")
  	   			 	{
      				alert("Please Enter Valid Drugs Name");
      				treatmentName.focus();
      				return false;	    	
  				  	}
 	 			   }
       	   		       	 			
		    		if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
				    {
    	 			
       				if(dosage== "" ||dosage==0)
  	    			{
      					alert("Dosage should be greater than 0 under drugs name");
      					dosage.focus();
     					return false;      	
  					 }
       				if(frequency== "")
   	   				 {
       					alert("Please select frequency against entered drugs name");
       					frequency.focus();
     					return false;       	
   					 }
    				if(days== "" && splitFrequency[1]!=13)
   	    			{
       					alert("Please Enter No. of Days against entered drugs name");
       					frequency.focus();
     					return false;       	
   				    }
    				
    				if(totalNom== "" ||totalNom==0)
   	    			{
       					alert("Total should be greater than 0 under drugs name");
       					frequency.focus();
     					return false;       	
   				    }
       
				    }
        		 });
    	 		///////////////////////////Patient sympotons json//////////////////////////////
    	 		 var patientSympotnsArryVal = [];
			    		    var patientSympotnsText=[];	
			    		    $('#patientSympotnsId').find('span').each(function() { 
			    			    var id = this.id;
			    			    var value = $(this).html();
			    			    var spitValue=value.split("[");
			    			   patientSympotnsText.push(spitValue[0]);
			    			   var symptomsIdValue=id;
								var param = {'symptomsId' : symptomsIdValue,
				    	    		      'visitId':  $('#visitId').val(),
				    	    		      'patientId':$('#patientId').val()
				    	                 };
								
								patientSympotnsArryVal.push(param)
			    			});
			    		    if(patientSympotnsText == "") {
			                    alert("Please enter patient signs and symptoms");
			                    document.getElementById('patientSymptons').focus(); 
			                    return false;
			                  }
					    	/* $("#patientSympotnsId > option").each(
									function() {
										patientSympotnsText.push(this.text);
										var symptomsIdValue=this.value;
										var param = {'symptomsId' : symptomsIdValue,
						    	    		      'visitId':  $('#visitId').val(),
						    	    		      'patientId':$('#patientId').val()
						    	                 };
										
										patientSympotnsArryVal.push(param)
									});
					    	
					    	  
			                if(patientSympotnsText == "") {
			                    alert("Please enter patient signs and symptoms");
			                    document.getElementById('patientSymptons').focus(); 
			                    return false;
			                  }	 */    	
    	 		 
    	 		 //////////////////////////////Procedure Care Validation /////////////////////////
    	 	    
    	 		if($('#gridNursing tr').length > 1)
    			{
    	 		 $('#gridNursing tr').each(function(i, el) {
    	 		    	var $tds = $(this).find('td')
		           	    var itemProcedureCareIdCheck = $tds.eq(2).find(":input").val();
		           	   
					      // alert(id);
					         if(itemProcedureCareIdCheck==""){
					        	 alert("Please enter valid Procedure Care name"); 
					        	 itemProcedureCareIdCheck.focus();
					      		 return false; 
					        	
					         }
					       
				    
    	 		 }); 
    			}
    	 		 
            	var  idforProcedureCare='';
                $('#gridNursing tr').each(function(i, el) {
                	  var $tds = $(this).find('td')
                      var typeOfProcValue=$tds.eq(2).find(":input").val();//$(typeOfProc).val();	
            	      idforProcedureCare=$(this).find("td:eq(0)").find("input:eq(0)").attr("id")
            	     if(document.getElementById(idforProcedureCare).value!= '' && document.getElementById(idforProcedureCare).value != undefined)
				     {
            	      if(typeOfProcValue=="N" || typeOfProcValue=="P")
            	  	  {
            	      if(idFreq=="")
            	      {
            	    	  alert("Please select frequency against entered procedure care");
            	    	  idFreq.focus();
       					  return false;   
            	      }
            	     
            	    	  
            	  	 }
				  }
    	 		});
    	 		 
                    var tableDataInvestigation = [];  
			    	var dataInvestigation='';
			    	var dataInvestigationHD='';
			    	var labMarkValue = '';   	
			    	var labInvestgationId=[];
					var urgent='';
					  var id='';
					  var idotherlab='';
					  var idforInv=''
					  var countForInves=0;
					$('#dgInvetigationGrid tr').each(function(i, el){
					     idforInv= $(this).find("td:eq(0)").find("input:eq(0)").attr("id")  
			   			 if(document.getElementById(idforInv).value!= '' && document.getElementById(idforInv).value != undefined)
		    			  {  
			   				 var $tds = $(this).find('td')
			   				 //id= $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
			   				 if($tds.eq(2).find(":input").is(":checked")){
					         var iinLab='O';
					         labMarkValue=iinLab;
					         countForInves++;
					        }
					        else
					         {
					         var outLab='I';
					         labMarkValue=outLab;
					         }
					             
					        labInvestgationId.push(labMarkValue);
		    	          }
					    });
					var checkForVal=$('#checkForInve').val();
					  if(countForInves>0 && checkForVal==1){
						  $('#messageForInvestigationOutside').show();
							$('.modal-backdrop').show();
							$('#checkForInve').val(1);
							return false;
					  }       
			    	
			    	    var count=0;
			    		$('#dgInvetigationGrid tr').each(function(i, el) {
			    		idforInv= $(this).find("td:eq(0)").find("input:eq(0)").attr("id")  
				   		if(document.getElementById(idforInv).value!= '' && document.getElementById(idforInv).value != undefined)
			    		{ 	
					    var $tds = $(this).find('td')
					  		
						var itemIdInvestigation = $tds.eq(1).find(":input").val();
					    var auditInvestigationValue = $tds.eq(4).find(":input").val();
				
					 	var labinvastigation="";
						 for (var i = count; i <labInvestgationId.length; i++) {
							 if(i==count){
								 labinvastigation=labInvestgationId[i];
								 break;
							 }
							 
						 }
						 count++;
						dataInvestigation={
			    				'investigationId' : itemIdInvestigation
			    				
						}
						//var otherInvestigation= document.getElementById('otherInvestigation').value;
						dataInvestigationHD={'otherInvestigation' : '',
	            							 'listofInvestigationDT':[{ 'investigationId' : itemIdInvestigation,
	            								                        'auditInvestigationValue':auditInvestigationValue
	            				    			}]
	            		                   }
						tableDataInvestigation.push(dataInvestigationHD);
			    		}	
			    	});
		    	
				 
			    		   /*  var icdArryVal = [];
			    		    var diagonsisText=[];			    	
					    	$("#diagnosisId > option").each(
									function() {
										diagonsisText.push(this.text);
										var diagonsisValue=this.value;
										var param = {'icdId' : diagonsisValue,
						    	    		      'visitId':  $('#visitId').val(),
						    	    		      'patientId':$('#patientId').val()
						    	                 };
										
										 icdArryVal.push(param)
									});	
			     	     */
			    	
					    	 /////////////Diagnosis JSON Value /////////////////////////////////////
				            var icdArryVal = [];
				            var diagonsisText=[]; 
				            var dataDiagnosisID='';
				          	$('#diagnosisGrid tr').each(function(i, el) {
				            	    var $tds = $(this).find('td')
				            	    var diagonsisValue = $tds.eq(5).find(":input").val();
				            	    var auditDiagonsisValue = $tds.eq(6).find(":input").val();
				            	    var diagonsisTextValueSplit = $tds.eq(0).find(":input").val();
				            	    var diagonsisTextValue=diagonsisTextValueSplit.split("[");
				            	    //var markDisease=$tds.eq(1).find(":input").val();
				            	   // var markInfectious=$tds.eq(2).find(":input").val();
				            	    var markDiseaseVal='';
				            	    if($tds.eq(1).find(":input").is(":checked"))
				            	    {
				            	    	markDiseaseVal="Y";
				            	    }
				            	    else
				            	    {
				            	    	markDiseaseVal="N";
				            	    }
				            	    var markInfectiousVal='';
				            	    if($tds.eq(2).find(":input").is(":checked"))
				            	    {
				            	    	markInfectiousVal="Y";
				            	    }
				            	    else
				            	    {
				            	    	markInfectiousVal="N";
				            	    }
				            	    if(diagonsisValue!="")
				            		{
				            		dataDiagnosisID={
				            				      	'icdId' : diagonsisValue,
				            				      	'markDiseaseVal':markDiseaseVal,
				            				      	'markInfectiousVal':markInfectiousVal,
				            				      	 'visitId':  $('#visitId').val(),
							    	    		      'patientId':$('#patientId').val(),
							    	    		      'auditDiagonsisValue':auditDiagonsisValue
				            		    	      	}
				            		
				            		icdArryVal.push(dataDiagnosisID);
				            		diagonsisText.push(diagonsisTextValue[0]);
				            		
				            		}
				            	});
			    	
			    	   	////////////// Treatment JSON ///////////////////
					    	var tableDataPrescrption = [];  
					    	var dataPresecption='';
					    	var idforTreat='';
					    var otherPresecription= document.getElementById('additionalNote').value;	
			    		$('#nomenclatureGrid tr').each(function(i, el) {
			    			idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
			    		if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
					    {
			    	    var $tds = $(this).find('td')
	    			  		
	    				var itemIdPresc = $tds.eq(8).find(":input").val();
	    				var dosage = $tds.eq(2).find(":input").val();
	    				var frequency = $tds.eq(3).find(":input").val();
	    				var splitFrequency=frequency.split("@");
	    				var noofdays = $tds.eq(4).find(":input").val();
	    				var total = $tds.eq(5).find(":input").val();
	    				var instruction = $tds.eq(6).find(":input").val();
	    				var dispunitId = $tds.eq(1).find(":input").val();
	    				var auditTreatmentFlag = $tds.eq(13).find(":input").val();
	    				var nisCheck='';
	    				
	    				
	    				
	    				
	    				dataPresecption={
	    	    				'itemId' : itemIdPresc,
	    	    				'dispunitId':dispunitId,
	    	    				'dosage' : dosage,
	    	    				'frequencyId' : splitFrequency[1],
	    	    				'noOfDays' : noofdays,
	    	    				'total' : total,
	    	    				'instruction' : instruction,
	    	    				'auditTreatmentFlag':auditTreatmentFlag
	    	    			} 
					    	tableDataPrescrption.push(dataPresecption);
					    }
			    	});
			  
			    	
			    ///////////////// Referral Json ////////////////////	
			    	var listofReferallHD =[];
	            	var listofReferalDT =[];
	            	var dataReferalHD='';
	            	if (document.getElementById('referExternal').checked)
	            	{
	            	$('#referalGrid tr').each(function(i, el) {
	            	    var $tds = $(this).find('td')
	            	    var extHospitalId = $tds.eq(1).find(":input").val();
	            	  	var splitHospital=extHospitalId.split("@");
	            	  	var departmentVal=$tds.eq(2).find(" option:selected" ).val();
	            		var department='';
	            		if(departmentVal!=null && departmentVal!=undefined && departmentVal!='')
	            		{	
	            		 department= $tds.eq(2).find(" option:selected" ).text();
	            		}
	            		var referalNote= document.getElementById('referralNote').value;
	            		var doctorNote= document.getElementById('doctorRemarks').value;
	            		            	
	            		
	            		dataReferalHD={
	            				'extHospitalId' : splitHospital[0],
	            				'patientId' : $('#patientId').val(),
	            				'hospitalId' : <%=hospitalId%>,
	            				'referralNote' : referalNote,
	            				'doctorNote' : doctorNote,
	            				'listofReferalDT':[{ 'extDepartment' : department }]
	            		}
	            		listofReferallHD.push(dataReferalHD);
	            	});
	            	}
	///////////////////////// Internal Refferal JSON //////////////////////////////////
	               var listofInternalReferallHD =[];
	            	var listofIntReferalDT =[];
	            	var dataIntReferalHD='';
	            	if (document.getElementById('referInternal').checked)
	            	{	
	            	$('#referalGrid tr').each(function(i, el) {
	            	    var $tds = $(this).find('td')
	            	    var intHospitalId = $tds.eq(1).find(":input").val();
	            	  	var splitIntHospital=intHospitalId.split("@");
	            		var intDepartment = $tds.eq(2).find(":input").val();
	            		var splitIntDepartment=intDepartment.split("@");
	            		
	            		var referalNote= document.getElementById('referralNote').value;
	            		            	
	            		
	            		dataIntReferalHD={
	            				'intHospitalId' : splitIntHospital[0],
	            				'patientId' : $('#patientId').val(),
	            				'hospitalId' : <%=hospitalId%>,
	            				'referralNote' : referalNote,
	            				'listofIntReferalDT':[{'intDepartment' : splitIntDepartment[0]}]
	            		}
	            		listofInternalReferallHD.push(dataIntReferalHD);
	            	});
	            	}
	            	
	////////////////////// Nursing care Json ///////////////////////////////////////   	
	            	var nrusingM=[];
	            	var nrusingP=[];
	            	var nrusingN=[];
	            	
	            	var listofNursingHD =[];
	            	var listofNursingDT =[];
	            	var dataNursingHD='';
	            	var dataNursingDT='';
	            	if(document.getElementById('procedureNameNursing').value!= '' && document.getElementById('procedureNameNursing').value != undefined)
			    	{
	            		
	            	$('#gridNursing tr').each(function(i, el) {
	            	    var $tds = $(this).find('td')
	            	    var nursingType = $tds.eq(3).find(":input").val();
	            	  
	            	    var nursingValue = $tds.eq(2).find(":input").val();
	            		var remarks = $tds.eq(1).find(":input").val();
	            		
	            		//var extReferalDate=document.getElementById('referVisitDate').value;
	            	   dataNursingHD={
	            				'patientId' : $('#patientId').val(),
	            				'visitId' : $('#visitId').val(),
	            				'hospitalId':<%=hospitalId%>,
	            				'procedureType':nursingType ,
	            				'listofNursingDT':listofNursingDT,
	            				    }
	            	   
	            	   dataNursingDT={'nursingId' : nursingValue,
        				       	       'remarks' : remarks,
        				       'nursingType':nursingType,}
	            	   
        		       //listofNursingDT.push(dataNursingDT);
	            	   
	            		if (nursingType=='M')
	            	  	{
	            			nrusingM.push(dataNursingDT);
	            			
	            	  	}
	            	   if (nursingType=='P')
	            	  	{
	            		   nrusingP.push(dataNursingDT);
	            	  	}
	            	   if (nursingType=='N')
	            	  	{
	            		   nrusingN.push(dataNursingDT);
	            	  	}
	            		
	            	   //listofNursingHD.push(listofNursingHD);
	            		
	            		
	            	
	            	});
	            		
	            	var nursingNJson={
	            			'patientId' : $('#patientId').val(),
            				'visitId' : $('#visitId').val(),
            				'hospitalId':<%=hospitalId%>,
            				'userId':<%= userId %>,
            				'procedureType':'N',
            				'listofNursingDT':nrusingN
            		}
	            	
            		var nursingPJson={
	            			'patientId' : $('#patientId').val(),
            				'visitId' : $('#visitId').val(),
            				'hospitalId':<%=hospitalId%>,
            				'userId':<%= userId %>,
            				'procedureType':'P',
            				'listofNursingDT':nrusingP
            		}
            		var nursingMJson={
	            			'patientId' : $('#patientId').val(),
            				'visitId' : $('#visitId').val(),
            				'hospitalId':<%=hospitalId%>,
            				'userId':<%= userId %>,
            				'procedureType':'M',
            				'listofNursingDT':nrusingM
            		}
	            	if(nrusingN!="" && nrusingN!='undefined')
	            	{
	            	listofNursingDT.push(nursingNJson);
	            	}
	            	if(nrusingP!="" && nrusingP!='undefined')
	            	{
	            	listofNursingDT.push(nursingPJson);
	            	}
	            	if(nrusingM!="" && nrusingM!='undefined')
	            	{
	            	listofNursingDT.push(nursingMJson);
	            	}
	            	  
	            	}
			                  
	            	
	            total_icd_value = total_icd_value.substring(0,total_icd_value.length-1);
	            
	            
	                     
	           					
                var dataJSON = {

                    'visitId': $('#visitId').val(),
                    'patientId': $('#patientId').val(),
                    'pallar': $('#pollar').val(),
                    'edema': $('#ordema').val(),
                    'cyanosis': $('#cyanosis').val(),
                    'icterus': $('#icterus').val(),
                    'hairnail' :$('#hairnail').val(),
                    'lymphNode': $('#lymphnode').val(),
                    'clubbing': $('#clubbing').val(),
                    'gcs': $('#gcs').val(),
                    'tremors': $('#tremors').val(),
                    'generalOther': $('#others').val(),
                    //'general':$('#ordema').val(),
                    'cns': $('#cns').val(),
                    'chestresp': $('#chest').val(),
                    'musculoskeletal': $('#musculoskeletal').val(),
                    'cvs': $('#cvs').val(),
                    'skin': $('#skin').val(),
                    'gi': $('#gi').val(),
                    'systemother': $('#others1').val(),
                    'genitourinary': $('#geneticurinary').val(),
                    'idealWeight': '',
                    'implantDeviceData': "",
                    'height': $('#height').val(),
                    'weight': $('#weight').val(),
                    'varation': '',
                    'temperature': $('#tempature').val(),
                    'bp': $('#bp').val(),
                    'bp1': $('#bp1').val(),
                    'pulse': $('#pulse').val(),
                    'spo2': $('#spo2').val(),
                    'bmi': $('#bmi').val(),
                    'rr': $('#rr').val(),
                    'icdValue':icdArryVal,
                    'symptomsValue':patientSympotnsArryVal,
                    'symptomsText':patientSympotnsText,
	      			'hospitalId':<%=hospitalId%>,
	      			'userId':<%= userId %>,
                    'patientSymptons': $('#patientSymptons').val(),
                    'pastMedicalHistory': $('#pastMedicalHistory').val(),
                     'icdDiagnosis' : diagonsisText,
                    'workingDiagnosis' : "",
                    'snomedDiagnosis' : "",
                    "departmentId"  :  $('#departmentId').val(),
                    "obsistyCheckAlready"  :  $('#obsistyCheckAlready').val(),
                    "orderStatus"   :  "P",
                    "listofInvestigation" : tableDataInvestigation,
                    "prescriptionStatus" :"P",
                    "otherPresecription" :otherPresecription,
                    "injectionStatus" : "N",
                    "nipStatus" : "N",
                    "listofPrescription" : tableDataPrescrption,
                    "listofNip" :"",
                    "listofNursingCareHD" : listofNursingDT,
                    "listofInternalReferallHD" : listofInternalReferallHD,
                    "listofReferallHD" : listofReferallHD,
                    'otherInvestigation':$('#otherInvestigation').val(),
                    'followUpFlagValue':followUpFlagValue,
                    'followUpdays':followDays,
                    'followupDate':$('#nextFollowUpDate').val(),
                    'markMlc':markAsMLC,
                    'policeStation':$('#mlcPloiceStation').val(),
                    'treatedAs':$('#mlcTreatedAs').val(),
                    'precriptionDtValue':$('#precriptionDtValue').val(),
                    'doctorAdditionalNote':$('#doctorRemarksArrayVal').val(),
                    'mlcPloiceName':$('#mlcPloiceName').val(),
                    'mlcDesignation':$('#mlcDesignation').val(),
                    'mlcIdNumber':$('#mlcIdNumber').val(),
                    'campId': $('#campId').val(),
                    'ecgRemarks':$('#ecgResult').val()
                    
                   
                   }
                var opdMainDataVal = $('#opdMainData')[0];
       		    var formData = new FormData(opdMainDataVal);
       		 	formData.append('uploadFilePath', "uploads");
     			formData.append('uploadRealPath', 1);
               	formData.append('opdMainData',JSON.stringify(dataJSON));
              	formData.append('visitId',$('#visitId').val());
	            	
	            	/* ,
                    "listofdisposalHDId" : listofdisposalHDId */
                $("#opdMainClicked").attr("disabled", true);
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
                           //localStorage.flagForFwc=flagForFwc;
                           var Id= $('#visitId').val()
                           window.location.href ="opdSubmit?visitId="+Id+"";
                        } 
                        else if(msg.status == 0)
                        {
                         $("#opdMainClicked").attr("disabled", false);	
                         alert(msg.msg)	
                        }	
                        else
                        {
                        	$("#opdMainClicked").attr("disabled", false);
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

            
                       
        </script>


	<script type="text/javascript" language="javascript">
      
       var arrayData = [];
        var i = "";
        var invesRadio="";
        function changeRadio(radioValue){
        	invesRadio=radioValue;
        	$('#labImaginId').val(radioValue);
        }
        
      
        var charge_code_array = [];
        var ChargeCode='';
        var multipleChargeCode = new Array();
        function populateChargeCode(val,count,item) {
   
        	//alert(count);
        //	if(validateMetaCharacters(val)){
        		if(val != "")
        		{
        			
        		    var index1 = val.lastIndexOf("[");
        		    var indexForChargeCode=index1;
        		    var index2 = val.lastIndexOf("]");
        		    index1++;
        		    ChargeCode = val.substring(index1,index2);
        		    
        		    var indexForChargeCode=indexForChargeCode--;
        		   
        		    var patientSymAuditId=$('#patientSymAuditId').val()
        		    var array = patientSymAuditId.split(',');
					array.sort(function(a, b) {
						  return a - b;
						});
					 $('#patientSymAuditId').val(array);
					 patientSymAuditId=$('#patientSymAuditId').val();
	     			 if(patientSymAuditId!=null &&patientSymAuditId!='')
	     		        {
	     				    var pathname = window.location.pathname;
	     					var accessGroup = "MMUWeb";
	     					var url = window.location.protocol + "//"
	     					+ window.location.host + "/" + accessGroup
	     					+ "/opd/getAIInvestgationDetail";
	     					$
	     							.ajax({
	     								url : url,
	     								dataType : "json",
	     								data : JSON.stringify({
	     									"patientSympotnsId":patientSymAuditId,
	     									"investgationId":ChargeCode
	     								}),
	     								contentType : "application/json",
	     								type : "POST",
	     								success : function(response) {
	     								console.log(response);
	     								var data=response.data;
	     							    if(data[0].investgationCount>0)
	     								 {
	     							    	 $('#msgForAIInvestigation').show();
	     							    	 $('#currentInvRowItem').val(val);
	     							    	$('#submitMOValidateFormByModelInvestgationId').val(val);
	     							    	$('.modal-backdrop').show();	
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
               
        		if(ChargeCode == "")
        		{
        		//document.getElementById('chargeCodeName'+count).value="";
        		//document.getElementById('chargeCodeCode'+count).value="";
        		return;
        		}
        		else{
        			        			
        			//document.getElementById('chargeCodeCode').value=ChargeCode
        			var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
        			var checkCurrentRow=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
   			         var count=0;   			
   			        $('#dgInvetigationGrid tr').each(function(i, el) {
        			    var $tds = $(this).find('td')
       			        var chargeCodeId=  $($tds).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
       			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
       			        var idddd =$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
       			        var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
       			    	  if(chargeCodeId!=checkCurrentRowIddd && ChargeCode==chargeCodeIdValue)
       			          {
       			    		  	if(ChargeCode==chargeCodeIdValue){
       			       			alert("Investigation is already added");
       			        		$('#'+idddd).val("");
       			        		$('#'+currentidddd).val("");
       			        		$('#'+chargeCodeIdValue).val("");
       			        		return false;
       			           }
       			          			        
       			            }
       			            else
       			        	{
       			        	     
       			        	   $(item).closest('tr').find("td:eq(1)").find(":input").val(ChargeCode);
       			        	}
       			       
       			    }); 
   			      }
        		}
        	  }
        
        function clearAiInvestgation(val)
        {
        	var currentValue=val;
        	$('#dgInvetigationGrid tr').each(function(i, el) {
			  var $tds = $(this).find('td')
			        var chargeCodeId=   $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
			        var chargeCodeIdSecond=   $($tds).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
			        if(currentValue==chargeCodeIdValue)
			        {	
			      		$('#'+chargeCodeId).val("");
			        	$('#'+chargeCodeIdSecond).val("");
			        }
			     			        	
			   });
        	$('#msgForAIInvestigation').hide();
        	$('.modal-backdrop').hide();
        }
        
      
  		 function changeInvRadio(item){
  			var labMarkValue = ''; 
  			for(var j=0;j<lastRow;j++){
				  var f = 'othAfLab1'+j+'';
				    if(document.getElementById(f).checked == true){
						  var iinLab='I';
						  labMarkValue=iinLab;
						  //alert("aaaaaaa " +labMarkValue)
				    }
					  else
						  {
						  var outLab='O';
						  //alert("out lab "+outLab);
						  labMarkValue=outLab;
						  //alert("bbbbbb " +labMarkValue)
						  }
				        
				    $(item).closest('tr').find("td:eq(6)").find(":input").val(labMarkValue);
						}
  			 
  		 }
  		
  			
        	
      
</script>

	<script type="text/javascript" language="javascript">
      var autoVsPvmsNo = '';
      var data='';
      var itemIds = '';
     <%--  $(document).ready(
        function getMastStoreItem(){
    	  var pathname = window.location.pathname;
    		var accessGroup = "MMUWeb";

    		var url = window.location.protocol + "//"
    				+ window.location.host + "/" + accessGroup
    				+ "/opd/getMasStoreItemList";
             
    		//var data = $('employeeId').val();
    	   // alert("radioValue" +radioValue);
    		$.ajax({
    			type : "POST",
    			contentType : "application/json",
    			url : url,
    			data : JSON.stringify({
    				'employeeId' : <%= userId %>,
    				'sectionId':10
    			}),
    			dataType : 'json',
    			timeout : 100000,
    			
    			success : function(res)
    			
    			{
    				data = res.MasStoreItemList;
    				autoVsPvmsNo = res.MasStoreItemList;
    				var autoList = [];
    				for(var i=0;i<data.length;i++){
    					
						var masItemIdValue= data[i];
    					
    					var masItemId=masItemIdValue[0];
    					var masPvmsNo = masItemIdValue[1];
    					var masDispUnit = masItemIdValue[3];
    					var masNomenclature = masItemIdValue[2];
    				
    					var aNom=masNomenclature+"["+masPvmsNo +"]";
    					autoList[i] = aNom;
    					//alert("a "+a);
    					arryNomenclature.push(aNom);
    					//console.log('MasStoredata :',aNom);
    					
    					
    				}
    				//putPvmsValue(autoList, data);
    			
    	           },
    	           error: function (jqXHR, exception) {
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
    	               alert(msg);
    	           }
    		});
    		
    		}); --%>
    var dispDepartment='';
    
     function getDepartmentId() {
  		var pathname = window.location.pathname;
  		var accessGroup = "MMUWeb";
 		var url = window.location.protocol + "//"
  				+ window.location.host + "/" + accessGroup
  				+ "/opd/getDepartmentId";
 		var dispDeptmentarCode=resourceJSON.DISPENSARY_DEPARTMENT_CODE;
      	var dataJSON={
  				  'code':dispDeptmentarCode,
  	     	      }
  		$.ajax({
  			type : "POST",
  			contentType : "application/json",
  			url : url,
  			data : JSON.stringify(dataJSON),
  			dataType : 'json',
  			timeout : 100000,
  			success : function(data) {
  				dispDepartment=data.departmentId;
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
     
     
     var newIcdValue ='';
     var newChargeCode='';
     var multipleChargeCode = new Array();
     function newDiagnosisPopulate(val,count,item) {
    		//alert("called");
    		if (val != "") {
    			 var communicable='';
            	 var infectious=''; 
            	 
    			var index1 = val.lastIndexOf("[");
    			var indexForBrandName = index1;
    			var index2 = val.lastIndexOf("]");
    			index1++;
    			newChargeCode = val.substring(index1, index2);
    			var indexForBrandName = indexForBrandName--;
    			var brandName = val.substring(0, indexForBrandName);
    			// alert("pvms no--"+pvmsNo)
    	      	
    			if (newChargeCode == "") {
    				
    				return false;
    			} 
    			else
    			{
    			
    		     	  for(var i=0;i<autoIcdCode.length;i++){
    		     
    		     		  var icdNo1=icdData[i].icdCode;
    		     		  
    		     		 communicable=icdData[i].communicableFlag;
              			infectious=icdData[i].infectionsFlag;
              			   		     		 
    		     		  if(icdNo1 == newChargeCode){
    		     			 newIcdValue = icdData[i].icdId;
    		     			 var patientSymAuditId=$('#patientSymAuditId').val()
    		     			 var array = patientSymAuditId.split(',');

	    		     			array.sort(function(a, b) {
								  return a - b;
								});
	    		     			 console.log(array);
	    		     			$('#patientSymAuditId').val(array);
	    		     			 patientSymAuditId=$('#patientSymAuditId').val();
    		     			 if(patientSymAuditId!=null &&patientSymAuditId!='')
	     	     		        {
	     	     				    var pathname = window.location.pathname;
	     	     					var accessGroup = "MMUWeb";
	     	     					var url = window.location.protocol + "//"
	     	     					+ window.location.host + "/" + accessGroup
	     	     					+ "/opd/getAIDiagnosisDetail";
	     	     					$
	     	     							.ajax({
	     	     								url : url,
	     	     								dataType : "json",
	     	     								data : JSON.stringify({
	     	     									"patientSympotnsId":patientSymAuditId,
	     	     									"diagnosisId":newIcdValue
	     	     								}),
	     	     								contentType : "application/json",
	     	     								type : "POST",
	     	     								success : function(response) {
	     	     								console.log(response);
	     	     								var data=response.data;
	     	     							    if(data[0].diagnosisCount>1)
	     	     								 {
	     	     							    	$('#msgForAIDiagnosis').show();
	    	     							    	$('#currentDiagnosisRowItem').val(val);
	    	     							    	$('#submitMOValidateFormByModelDiagnosisId').val(val);
	    	     							    	$('.modal-backdrop').show();	
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
    		     			 
    	      			    var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
    	        			var checkCurrentRow=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
    	   			         var count=0;   			
    	   			        $('#diagnosisGrid tr').each(function(i, el) {
    	        			    var $tds = $(this).find('td')
    	       			        var chargeCodeId=  $($tds).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
    	       			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
    	       			        var idddd =$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
    	       			        var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
    	       			    	  if(chargeCodeId!=checkCurrentRowIddd && newIcdValue==chargeCodeIdValue)
    	       			          {
    	       			    		  	if(newIcdValue==chargeCodeIdValue){
    	       			       			alert("Diagnosis is already added");
    	       			        		$('#'+idddd).val("");
    	       			        		$('#'+currentidddd).val("");
    	       			        		$('#'+chargeCodeIdValue).val("");
    	       			        		return false;
    	       			           }
    	       			          			        
    	       			            }
    	       			            else
    	       			        	{
    	       			        	     
    	       			        	   $(item).closest('tr').find("td:eq(5)").find(":input").val(newIcdValue);
    	       			        	   if(communicable=="Y")
    	       			        	   {	   
    	       			        	   $(item).closest('tr').find("td:eq(1)").find(":input").prop('checked', true);
    	       			        	   }
	    	       			           if(infectious=="Y")
	 	       			        	   {	   
	 	       			        	   		$(item).closest('tr').find("td:eq(2)").find(":input").prop('checked', true);
	 	       			        	   }
    	       			        	   
    	       			        	
    	       			        	}
    	       			 
    		     			 	
    		     			}); 
    		     		  }
    		     	  }	
    		     	
    	           
    				return true;
    			}

    		} 
    		else
    		{
    			return false;
    		}
    	}
     
     function clearAiDiagnosis(val)
     {
     	var currentValue=val;
     	$('#diagnosisGrid tr').each(function(i, el) {
			  var $tds = $(this).find('td')
			        var chargeCodeId=   $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
			        var chargeCodeIdSecond=   $($tds).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
			        if(currentValue==chargeCodeIdValue)
			        {	
			      		$('#'+chargeCodeId).val("");
			        	$('#'+chargeCodeIdSecond).val("");
			        }
			     			        	
			   });
     	$('#msgForAIDiagnosis').hide();
     	$('.modal-backdrop').hide();
     }
     
    

 </script>

<script type="text/javascript" language="javascript">
////////////////////////////Disposal Grid AutoPoulate ///////////////////////////////


function getDateInDDMMYYY(dateCheck){ 
	 var dateFormat="";
	 var today1="";
	 if(dateCheck!=null || dateCheck!=""){
	   today1 = new Date(dateCheck);
	 var dd = String(today1.getDate()).padStart(2, '0');
	 var mm = String(today1.getMonth() + 1).padStart(2, '0'); 
	 var yyyy = today1.getFullYear();
	 dateFormat =  dd + '/' + mm + '/' +yyyy;
	 } 
	 return dateFormat;
}

	var today="";
	if(dateCheck==null || dateCheck==""){
	$(document).ready(function() {
	  today = new Date();
	var dd = String(today.getDate()).padStart(2, '0');
	var mm = String(today.getMonth() + 1).padStart(2, '0'); 
	var yyyy = today.getFullYear();
	
	//today =  yyyy + '-' + mm + '-' +dd;
	 today = dd + '/' + mm + '/' +yyyy;
	});
	}
 
 function checkReferalDate() {
     var dateString = document.getElementById('dateOfImplant').value;
     var myDate = new Date(dateString);
     var today = new Date();
     if ( myDate > today ) { 
         alert("You cannot enter a date in the future");
         document.getElementById('dateOfImplant').value='';
         return false;
     }
     return true;
 }
 

function getWardDepartment() {

	var params = {
		
	}
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlDept = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/ward/getWardDepartment";
	$
	.ajax({
				type : "POST",
				contentType : "application/json",
				url : urlDept,
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(msg) {
					if (msg.status == '1') {

						var comboval = '';
						for (var i = 0; i < msg.departmentList.length; i++) {

							comboval += '<option value=' + Object.keys(msg.departmentList[i]) + '>'
									+ Object.values(msg.departmentList[i])
									+ '</option>';

						}
						$j('#wardDepartmentId').append(comboval);

					}

				},

				error : function(msg) {

					alert("An error has occurred while contacting the server");

				}
			});
}
	
 
 
</script>


		
<!-- ----------------Accordian  end here---------- -->

<script>
    function showhide(buttonId)
     {
		 if(buttonId=="button2"){
					test('realted'+buttonId,"newpost2");
		 }else if(buttonId=="button3"){
					test('realted'+buttonId,"newpost3");
		 }else if(buttonId=="button4"){
					test('realted'+buttonId,"newpost4");
		 }else if(buttonId=="button7"){
					test('realted'+buttonId,"newpost7");
		 }else if(buttonId=="button8"){
					test('realted'+buttonId,"newpost8");
		 }else if(buttonId=="button9"){
					test('realted'+buttonId,"newpost9");
		 }else if(buttonId=="button10"){
					test('realted'+buttonId,"newpost10");
		 }else if(buttonId=="button11"){
					test('realted'+buttonId,"newpost11");
		 }else if(buttonId=="button12"){
					test('realted'+buttonId,"newpost12");
		 }else if(buttonId=="button13"){
				test('realted'+buttonId,"newpost13");
	 	}
	 }
    
	function test(buttonId,newpost){
			 var x = document.getElementById(newpost);
				if (x.style.display != "block") {
					x.style.display = "block";
					document.getElementById(buttonId).value="-";
				}else {
					x.style.display = "none";
					document.getElementById(buttonId).value="+";
				}	 
	}
	      
  </script>

<script>



/* function submitMOValidateFormByModel(){
	
	$('#checkForInve').val(0);
	$('#submitMOValidateFormByModelId').attr('disabled',true);
	opdSubmitFunction();
	 
} */


$(document).on('click','#exampleModal button[data-dismiss="modal"],#exampleModal input[data-dismiss="modal"]',function(){
	closeModal();
});

function closeModal(){
	 $('#exampleModal').hide();
	 var loaderDiv = '<div class="text-center text-theme text-sm"> Loading <i class="fa fa-spin fa-spinner"></i> </div>';
	 $('#exampleModal .modal-body').html(loaderDiv);
	 $('.modal-backdrop').hide();
}

function showImmunizationTemplate() {
	var patientId=$('#patientId').val();
	var visitId=$('#visitId').val();

	 $('#exampleModal .modal-body').load("showImmunizationTemplate?employeeId="+<%= userId %>+"&patientId="+patientId+"&visitId="+visitId);
     $('#exampleModal .modal-title').text('Immunization History');
}


$j('body').on("focus",".noFuture_date6", function() {
  	 $j(this).datepicker({ showOn: "button",
  		buttonImage: "../resources/images/calendar.gif",		
		buttonImageOnly: true,
		dateFormat: 'dd/mm/yy',
		buttonText: 'Select Date',
		selectWeek:false,
		closeOnSelect:true,  
		changeMonth: true, 
		changeYear: true,
		clickInput:false,
		yearRange: '1900:2090',
		maxDate: new Date(),
		onSelect: function(dateText) {
	      display(this);
	      $(this).change();
	    }
  	 }).on("change", function() {
	    display("Change event");  
  	 });
  	function display(ides) {
  		generateNextDateForImmun(ides);  
  	}
  });


function generateNextDateForImmun(item) {
	 
	  var carrentDateIdValue=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
	  var durationValue=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
	  var nextCategoryDateId=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
	  if(carrentDateIdValue==null || carrentDateIdValue==""){
			return false;
	  	}
	 
	var currentDateVal=carrentDateIdValue.split("/");
	var date=currentDateVal[0];
	var month=currentDateVal[1];
	var year=currentDateVal[2];
	if(durationValue==null || durationValue==""){
		alert("Please enter  duration");
		return false;
	}
	
	var monthNew ="";	
	 
//monthNew =parseInt(month)+parseInt(durationValue);
	var yearNew ="";	
	year =parseInt(year)+parseInt(durationValue);
	var dateNext="";
var yearNew;
var remMonthNew;
var  coYearNew;
/*if(monthNew>12){
	   var remMonthNew= parseInt(monthNew)%12;
	  var  coYearNew= parseInt(monthNew)/12;
	   coYearNew=  Math.floor(parseInt(coYearNew));
	   year=parseInt(year)+parseInt(coYearNew);
	   
	   if(date!=null && date!="" && date.toString().length==1)
	     {
	    	 date="0"+date;
	     }
	     if(remMonthNew!=null && remMonthNew!="" && remMonthNew.toString().length==1){
	    	 remMonthNew="0"+remMonthNew;
	     }
	   
	   
	   dateNext=date+"/"+remMonthNew+"/"+year;
	}
	else{
		
		 if(date!=null && date!="" && date.toString().length==1)
	     {
	    	 date="0"+date;
	     }
	     if(monthNew!=null && monthNew!="" && monthNew.toString().length==1){
	    	 monthNew="0"+monthNew;
	     }
	   
		 dateNext=date+"/"+monthNew+"/"+year;
	}*/
	 if(date!=null && date!="" && date.toString().length==1)
   {
  	 date="0"+date;
   }
   if(month!=null && month!="" && month.toString().length==1){
  	 month="0"+month;
   }
 
	 dateNext=date+"/"+month+"/"+year;
	
	/*
	 * used for Date Comparision next due date
	 *  var currentItemId= $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
	  var countForImmunization=0;
		$('#immunisationStatusGrid tr').each(function(i, el) {

			var itemIdVals = $(this).find("td:eq(0)").find("input:eq(1)").val();
			var oldNextDueDate=$(this).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
			if(currentItemId==itemIdVals){
					var countDateVal=getDateComapareImmu(oldNextDueDate,dateNext)
					if(countDateVal>0){
						countForImmunization=+1; 
					}
			}
	 	});
	  
		if(countForImmunization>0){
			alert("Immunization is already given.");
			return false
		}*/
		
	 
	$('#'+nextCategoryDateId).val(dateNext);
	$('#'+nextCategoryDateId).attr('readonly', true); 
	}
	
	/* function submitECG()
	{
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var urlEcg = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/documentUpload";
		 var dataJSON = {

        		 'visitId': $('#visitId').val()
		 }
		 var opdMainData = $('#opdMainData')[0];
		 var formData = new FormData(opdMainData);
       	 var countFile=1;
       	formData.append('ecgFileUpload', "#ecgFileUpload");
       	formData.append('uploadRealPath', 1);
       	formData.append('opdMainData',JSON.stringify(dataJSON));
       	formData.append('visitId',$('#visitId').val());
		
        $.ajax({
       	     type: 'POST',
 		     url : urlEcg,
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
                  
                } 
                else if(msg.status == 0)
                {
                 
                 alert(msg.msg)	
                }	
                else
                {
                
                    alert("Please enter the valid data")
                }
            },
            error: function(jqXHR, exception) {
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

	} */
	
	function opdBackFunction()
	{
		location.href='${pageContext.request.contextPath}/opd/opdWaitingList';
	}

</script>
 
 

</body>
<jsp:include page="..//view/modelWindowForReportsMultiple.jsp" />
</html>
