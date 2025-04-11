<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
          <jsp:include page="..//view/leftMenu.jsp"/>
          <jsp:include page="..//view/commonModal.jsp"/>
  			<%-- <%@include file="..//view/modelWindowForReports.jsp"%> --%>
                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

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
						String cityId = "1";
						if (session.getAttribute("cityId") != null) {
							cityId = session.getAttribute("cityId") + "";
						}
						
						String userName="";
						if (session.getAttribute("firstName") != null) {
							userName = session.getAttribute("firstName") + "";
						}
						
					%>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  					<jsp:include page="..//view/commonJavaScript.jsp"/>
                     <title><spring:message code="lblOpdRecalHeader" /></title>
                    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>   
					<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opdpatientrecall.js"></script>
					<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
					<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
					<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/treatmentOpdData.js"></script>
				
				
				 <script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>  
	
	<script src="${pageContext.request.contextPath}/resources/js/snomedLink.js?n=1" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
	
	<script type="text/javascript">
	 
	var labRadioValue=resourceJSON.mainchargeCodeLab;
	var imagRadioValue=resourceJSON.mainchargeCodeRadio;
   </script>
   <script>
	var hsId=<%=hospitalId%>;
	var uId=<%=userId%>;
	var $j = jQuery.noConflict();
	$j(document).ready(function(){
		$j('#lab_radio').val(labRadioValue);
		$j('#imag_radio').val(imagRadioValue);	
		$('#labImaginId').val(labRadioValue);
		
		
		
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
	</script>
	
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
				<div class="internal_Htext"><spring:message code="lblOpdRecalHeader" /></div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<form:form name="submitPatientRecall" id="submitPatientRecall" method="post" enctype='multipart/form-data'
									 action="${pageContext.request.contextPath}/opd/submitPatientRecall" autocomplete="never">
									<input type="hidden" name="opdPatientDetailId" value=""
										id="opdPatientDetailId" />
									<input type="hidden" id="ageNumber" name="ageNumber" value=""/>
									<input type="hidden" name="patientId" value="" id="patientId" />
									<input type="hidden"  name="marksAsLabValue" value="" id="marksAsLabValue" />
									<input type="hidden"  name="urgentValue" value="" id="urgentValue" />
									
									<input type="hidden"  name="obsitymarkvalue" value="" id="obsitymarkvalue" />
									<input type="hidden"  name="icdIdValue" value="" id="icdIdValue" />
									<input type="hidden"  name="patientSympotnsValue" value="abc" id="patientSympotnsValue" />
									
									<input type="hidden"  name="hospitalId" value=<%=hospitalId%> id="hospitalId" />
									<input type="hidden"  name="userId" value=<%=userId%> id="userId" />
									<input type="hidden"  name="userIdVal" value=<%=userId%> id="userIdVal" />
									<input type="hidden"  name="cityIdVal" value=<%=cityId%> id="cityIdVal" />
									
									<input type="hidden"  name="mmuName" value=<%= session.getAttribute("mmuName") %> id="mmuName" />
								  <input type="hidden"  name="campName" value="<%= session.getAttribute("campLocation") %>" id="campName" />
									
									<input type="hidden"  name="noOfDaysPro" value="" id="noOfDaysPro" />
									<input type="hidden"  name="freProcedure" value="" id="freProcedure" />
									<input type="hidden"  name="uhidNumberValue" value="" id="uhidNumberValue" />
									<input type="hidden"  name="checkForAuthenticationValue" value="" id="checkForAuthenticationValue" />
									<input type="hidden" name="countValueCurrentMedi" id="countValueCurrentMedi" value=""/>
									<input type="hidden"  name="nisValue" value="" id="nisValue" />
									<input type="hidden"  name="immunizationValue" value="" id="immunizationValue" />
									 <input  name="departmentId" id="departmentId" type="hidden" value="" />
									 <input  name="serviceNo" id="serviceNo" type="hidden" value="" />
									 <input  name="obsistyMark" id="obsistyMark" type="hidden" value="" />
									 <input  name="labImaginId" id="labImaginId" type="hidden" value="" />
									 <input  name="defaultProcedureValue" id="defaultProcedureValue" type="hidden" value="N" />
									 <input  name="obsistyCheckAlready" id="obsistyCheckAlready" type="hidden" value="" />
									 <input  name="wardDepartmentIdTemp" id="wardDepartmentIdTemp" type="hidden" value="" />
									 <input type="hidden" id="usersCounts" name="usersCounts" value=""/>
									 <input type="hidden" name="empCategory" id="empCategory" value=""/>
									  <input type="hidden" name="siqValue" id="siqValue" value=""/>
									 	<input type ="hidden" name="precriptionDtValue" id="precriptionDtValue" value=""/>
									 	<input type="hidden"  name="userName" value='<%=userName%>' id="userName" />
									 	<input  name="flagForFwc" id="flagForFwc" type="hidden" value="" />
									 	<input type="hidden" name="formFlag" id="formFlag"value="recall"/>
									 	<input type="hidden" name="icdDiagnosisValeText" id="icdDiagnosisValeText" value=""/>
									 	 <input type="hidden" name="registrationTypeCode" id="registrationTypeCode" value=""/>
									 	 <input  name="markAsMlcFlag" id="markAsMlcFlag" type="hidden" value="" />
									 	 <input  name="followUpFlagValRecall" id="followUpFlagValRecall" type="hidden" value="" />
									 	 <input type="hidden" name="patientSymptonsValeText" id="patientSymptonsValeText" value=""/>
									 	 <input type="hidden"  name="markInfectionRecall" value="" id="markInfectionRecallValue" />
									 	 <input type="hidden"  name="markDiseaseRecall" value="" id="markDiseaseRecallValue" />
									 	 <input type="hidden" name="patientSymAuditId" id="patientSymAuditId" value=""/>
									 	  <input type="hidden" name="doctorRemarksArrayVal" id="doctorRemarksArrayVal" value=""/>
									
								
							<!-- -----  Patient Detail  start here --------- -->
									
							       <div class="adviceDivMain" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Patient Detail  </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton2" value="-" onclick="showhide(this.id)" type="button">
									</div>	
								
								
								      <div class="hisDivHide p-10" id="newpost2" style="display:block">
								      	
								      	
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





<!-- ----- Previous visits & Chief	Complaint start here --------- -->		

    <div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Clinical History  </span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton3" value="-" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost3" style="display:block;">
      
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

												<div class="">
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

													<div class="floatLeft">

														<%-- <form> --%>
														<div class="row">

																<div class="hisDivHide p-10" id="newpost1177"  style="display:block;"">
									      
									      	<div class="row">
											<div class="col-md-5">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">Patient signs & symptoms<span
													class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-md-7">
													<!-- onmouseenter="getOpdNomenClatureList(this,'populateSignAndSymptoms','treatmentAudit','getAllSymptomsForOpd','signAndSymptoms','mouseOver');" -->
															<div class="autocomplete forTableResp">
															<input type="text" autocomplete="never" class="form-control border-input" name="pvmsNumber" id="patientSymptons"  onKeyUp="getOpdNomenClatureList(this,'populateSignAndSymptoms','registration','getAllSymptoms','signAndSymptoms','opd');"/>
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
				

															<div class="col-md-12">
																<div class="form-group row">
																	<label class="col-md-3 col-form-label">Clinical Examination</label>
																	<div class="col-md-6">
																		<textarea class="textNew form-control disablecopypaste" name="pastMedicalHistory"
																			id="pastMedicalHistory" cols="0" rows="0" maxlength="2000" value=""
																			tabindex="1"></textarea>
																	</div>
																	<!-- <div class="col-md-1">
																		<input type="button" class="button" tabindex="3"
																			name="" value="+"
																			onclick="getPresentTemplate('','pastMedicalHistory');" />
																	</div> -->

																	<div class="col-md-1"></div>

																</div>
															</div>


														</div>

														<%-- </form> --%>

													</div>

												</div>
											</div>

										</div>
      
      
			
	</div>


<!-- ----- Previous visits & Chief	Complaint end here --------- -->	





  <!-- ----- Vital Detail start here --------- -->

  <!-- <div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>  Vital Detail </span>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton4" value="+" onclick="showhide(this.id)" type="button">
	  </div>	
</div>	 -->

   <div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Vital Detail  </span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton4" value="+" onclick="showhide(this.id)" type="button">
	</div>	





      <div class="hisDivHide p-10" id="newpost4">
      
      
      	<div class="row">

											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Patient Height<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="height" id="height" type="text" maxlength="10"
															class="form-control border-input" onblur="idealWeight();checkBMI();" placeholder="Height"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
													</div> -->
													<div class="col-md-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="height" id="height" type="text" maxlength="10"
															class="form-control border-input disablecopypaste" onblur="checkBMI();"  placeholder="Height"
															value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
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
															<input name="ideal_weight" id="ideal_weight" maxlength="10" onblur="checkVaration()" type="text"
															class="form-control border-input disablecopypaste"
															placeholder="Ideal Weight" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
														    <div class="input-group-append">
														      <div class="input-group-text">kg</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div> -->

											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-lg-5 col-sm-4 col-form-label">Weight<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="Weight" id="weight" type="text"
															class="form-control border-input" maxlength="10" onblur="checkVaration();checkBMI();" placeholder="Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
													</div> -->
													<div class="col-lg-7 col-sm-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="Weight" id="weight" type="text"
															class="form-control border-input disablecopypaste" maxlength="10" onblur="checkVaration();checkBMI();" placeholder="Weight" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
														    <div class="input-group-append">
														      <div class="input-group-text">kg</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>

											<!-- <div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Variation in
														Weight</label>
												
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="variant_in_weight" maxlength="10" id="variant_in_weight"
															type="text" class="form-control border-input disablecopypaste"
															placeholder="Variation in Weight" value=""  readonly />
														    <div class="input-group-append">
														      <div class="input-group-text">%</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div> -->

											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-lg-5 col-sm-4 col-form-label">Temperature<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="tempature" id="tempature" type="text" maxlength="12"
															class="form-control border-input"
															placeholder="Temperature" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
													</div> -->
													<div class="col-lg-7 col-sm-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="tempature" id="tempature" type="text" maxlength="12"
															class="form-control border-input disablecopypaste"
															placeholder="Temperature" value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
														    <div class="input-group-append">
														      <div class="input-group-text">°F</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
										<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-md-3 col-form-label">BP<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-3">
														<input name="bp" id="bp" type="text"
															class="form-control border-input" placeholder="Systolic"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
														 
													</div>
													
													
													<div class="col-md-1">
														/
														 
													</div>
													
													<div class="col-md-3">
														<input name="bp1" id="bp1" type="text"
															class="form-control border-input" placeholder="Diastolic"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
														 
													</div> -->
													<div class="col-md-3 offset-md-1">
														
															<input name="bp" id="bp" type="text"
															class="form-control border-input bpSlash disablecopypaste" placeholder="Systolic"
															value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>
															<span></span> <!-- slash for bp -->
														  
													</div>
													<div class="col-md-5">
														<div class="input-group mb-2 mr-sm-2">
															<input name="bp1" id="bp1" type="text"
															class="form-control border-input bmiInput disablecopypaste" placeholder="Diastolic"
															value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>
														    <div class="input-group-append">
														      <div class="input-group-text">mmHg</div>
														    </div>
														  </div>
													</div>
													
													
												</div>
											</div>

											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-lg-5 col-sm-4 col-form-label">Pulse<span class="mandate"><sup>&#9733;</sup></span></label>
													<!-- <div class="col-md-7">
														<input name="pulse" id="pulse" type="text" maxlength="10"
															class="form-control border-input" placeholder="Pulse"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
													</div> -->
													<div class="col-lg-7 col-sm-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="pulse" id="pulse" type="text" maxlength="10"
															class="form-control border-input disablecopypaste" placeholder="Pulse"
															value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
														    <div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-lg-5 col-sm-4 col-form-label">SpO2</label>
													<!-- <div class="col-md-7">
														<input name="spo2" id="spo2" type="text" maxlength="25"
															class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="SpO2"
															value=""/>
													</div> -->
													<div class="col-lg-7 col-sm-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="spo2" id="spo2" type="text" maxlength="25"
															class="form-control border-input disablecopypaste" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" placeholder="SpO2"
															value=""/>
														    <div class="input-group-append">
														      <div class="input-group-text">%</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">BMI</label>
													<!-- <div class="col-md-7">
														<input name="bmi" id="bmi" type="text" 
															class="form-control border-input" placeholder="BMI"
															value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" readonly>
													</div> -->
													<div class="col-md-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="bmi" id="bmi" type="text" 
															class="form-control border-input disablecopypaste" placeholder="BMI"
															value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" readonly>
														    <div class="input-group-append">
														      <div class="input-group-text">kg/m2</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-lg-5 col-sm-4 col-form-label">RR</label>
													<!-- <div class="col-md-7">
														<input name="rr" id="rr" type="text" maxlength="3"
															class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="RR"
															value=""/>
													</div> -->
													<div class="col-lg-7 col-sm-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="rr" id="rr" type="text" maxlength="3"
															class="form-control border-input disablecopypaste" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" placeholder="RR"
															value=""/>
														    <div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											 <div class="col-md-4" id="markMLCId">
												<div class="form-group row">														
													<div class="col-md-9 makeDisabled mn-t-10">
														<div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" type="checkbox" id="markMLC" name="markMLC" onclick="marksAsMLCRecall()"  value="">
															<span class="cus-checkbtn"></span>
															<div class="form-check form-check-inline cusRadio">
																	<label class="col-md-12 col-form-label">Mark as MLC Case</label> 
															</div>
														</div>									
													</div>
												</div>
											</div>
												<div class="row" id="markMLCSection" style="display:none">
					      	
					      		<div class="col-lg-4 col-sm-6">
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
								
								<div class="col-lg-4 col-sm-6">
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
								<div class="col-lg-4 col-sm-6">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Police Station</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcPloiceStation" name="mlcPloiceStation" rows="2"></textarea>
										</div>
									</div>
								</div>
								<div class="col-lg-4 col-sm-6">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Treated As</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcTreatedAs" name="mlcTreatedAs" rows="2"></textarea>
										</div>
									</div>
								</div>
								<div class="col-lg-4 col-sm-6">
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
								<div class="col-lg-4 col-sm-6">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Name Of Policeman</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcPloiceName" name="mlcPloiceName" rows="2"  maxlength="100"></textarea>
										</div>
									</div>
								</div>
								<div class="col-lg-4 col-sm-6">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Designation</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcDesignation" name="mlcDesignation" rows="2"  maxlength="100"></textarea>
										</div>
									</div>
								</div>
								<div class="col-lg-4 col-sm-6">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">ID Number</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcIdNumber" name="mlcIdNumber" rows="2" maxlength="100"></textarea>
										</div>
									</div>
								</div> 
								
					      	</div>
											<!-- mark as mlc fields -->
											
											
											
											<!-- <div class="col-md-4" style="display:none;">
												<div class="form-group row">
													<input type="hidden" id="patientId" name="PatientID"
														value="">
												</div>
											</div> -->
											<div class="col-md-4" style="display:none;">
												<div class="form-group row">
													<input type="hidden" id="visitId" name="VisitID" value="">
												</div>
											</div>
											<div class="col-md-4" style="display:none;">
												<div class="form-group row">
													<input type="hidden" id="genderId" name="genderId" value="">
												</div>
											</div>
											 
											
														 <div class="col-md-5"  style="display:none" id="markObesityId">
												<div class="form-group row">
														<!--<label class="col-md-5 col-form-label">Mark Obesity
													</label>
													<div class="col-md-7 ">
													<div class="form-check form-check-inline cusCheck m-t-7 m-l-10">
														<input class="form-check-input" type="checkbox" id="obsistyMark"  onclick="obsistyFunction()">
													<span class="cus-checkbtn"></span> 
													</div>
													</div>
												</div> -->

													<div class="col-md-9 makeDisabled">
													<div class="form-check form-check-inline cusRadio m-t-5">
															<input type="radio" value="N" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="obsistyCheck" onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label id="obsistyCheckText" class="form-check-label" for="obsistyCheck"><span  >Obesity</span></label>
														</div>
														
													<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="Y" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="overCheck"
																onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label  id="overCheckText"  class="form-check-label" for="overCheck"><span  >Overweight</span></label>
															
														</div>
													<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="none" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="noneCheck"
																onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label id="noneText" class="form-check-label" for="noneCheck"><span  >None</span></label>
															
														</div>	
												</div>
													<div class="col-md-3 makeDisabled">
														<div style="display: none" id="overWeightDropDown">
															<select name="overWeightDivId"  class="form-control p-l-5" id="overWeightSelect"  tabindex="1">
																<option id="under20" value="S">10-20</option>
																<option id="above20" value="H">>20</option>
															</select>
														</div>
													</div>
													
												<div class="col-md-8">
													<div class="form-group row"></div>
												</div>
											</div>
											
										</div>
										</div>
										
      
      
			 
	</div>
<!-- ----- Vital Detail end here --------- -->


					
						
						 <!-- ----- Diagnosis  start here --------- -->
	
								 <div class="adviceDivMain" id="button7" onclick="showhide(this.id)">
									<div class="titleBg" style="width: 520px; float: left;">
										<span> Diagnosis </span>
								     </div>		
									<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton7" value="-" onclick="showhide(this.id)" type="button">
								</div>	
							
							
							      <div class="hisDivHide p-10" id="newpost7"  style="display:block;">
							      
							      
							      <div class="row">
							   				      
							      
											<div class="col-12">
							      		<h6><a class="text-theme font-weight-bold text-underline" onClick="showdiagLoader();showAllAuditRecommendedDiagnosisRecall('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Diagnosis</a>
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

											<tbody id="diagnosisGridRecall">
												<tr>
													<td>
													    <div class="autocomplete forTableResp">
													   <!--  onmouseup="getOpdNomenClatureList(this,'newDiagnosisPopulate','treatmentAudit','getAllIcdForOpd','dignosis','mouseOver');" -->
														<input type="text" size="55" name="diagnosisIdRecall" id="diagnosisIdRecall" 
														onKeyUp="getNomenClatureList(this,'newDiagnosisPopulateRecall','opd','getIcdListByName','dignosis');" class="form-control">
													   <div id="diagnosisDiv" class="autocomplete-itemsNew"></div>
													   </div>
													</td>
													<td class="text-center width220">
														<div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" id="markDiseaseRecall" name="markDiseaseRecall" type="checkbox">
															<span class="cus-checkbtn"></span>
														</div>
													</td>
													<td class="text-center width220">
														<div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" id="markInfectionRecall" name="markInfectionRecall" type="checkbox">
															<span class="cus-checkbtn"></span>
														</div>
													</td>
													<td>
														<button name="Button" type="button" id="addDiagnosisRowRecall" name="addDiagnosisRowRecall" class="buttonAdd btn btn-primary noMinWidth m-r-10" button-type="add" value="" tabindex="1" onclick="addDiagnosisRecall()"></button>
													</td>
													<td>
														<button name="Button" type="button" id="deleteDiagnosisRowRecall" name="deleteDiagnosisRowRecall" class="buttonDel btn btn-danger noMinWidth" button-type="delete" value="" tabindex="1" onclick="deleteDiagnosis()"></button>
													</td>
													<td style="display: none";>
													    <input type="hidden" value="" tabindex="1" id="diagnosisIdvalRecall" size="77" name="diagnosisIdvalRecall" />
													</td>
												</tr>
											</tbody>
							      		</table>
							      	</div>	

											

							</div>
			 
						</div>
					<!-- -----Diagnosis   end here ---------  -->
				
								
								
								
								<!-- -----Investigation   start here --------- -->


      <div class="adviceDivMain" id="button8" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span> Investigation</span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton8" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost8">
      
      
      						<div class="">
											<div class="row" id="templateOfInvest">
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label"  style="padding-left: 10px;"> Template </label>
														<div class="col-md-7">
															<div id="investigationDivInvest">
																<select name="dgInvestigationTemplateIdInvest" class="form-control"
																	id="dgInvestigationTemplateIdInvest" tabindex="1">
																	<option value="0">Select</option>
																</select> 
															</div>
														</div>
													</div>
												</div> 
												
												<div class="col-md-2" id="createInvesRecall">
													<div class="form-group row">
														<div class="col-md-12">
															<div id="createInvestigationDivToShowHide"  class="">
																<input name="investigationTemplate" type="button"
																	value="Create Template" tabindex="1" class="btn btn-primary btn-block" data-toggle="modal" data-target="#exampleModal"
																	onclick="showCreateInvestigationTemplate();" />
															</div>
														</div>
													</div>
												</div>

												<!-- <div class="col-md-2">
													<div class="form-group row">
														<div class="col-md-12">
															<div  class="opd_invetigation_createtemplate  opd_invetigation_recall_import2">
																<input name="createupdateTemplate" tabindex="1"
																	type="button" value="Update Template" class="buttonBig"
																	onclick="showUpdateOpdTempate('I');" />
															</div>
														</div>
													</div>
												</div> -->

												<div class="col-md-2" id="importNewInvesRecall">
													<div class="form-group row">
														<div class="col-md-12">
															<div id="investigationImportButton1" class="">
																<input name="updateTemplate" tabindex="1"
																	type="button" value="Update Template" data-toggle="modal" data-target="#exampleModal" class="btn btn-primary"
																	onclick="opdUpdateInvestigationTemplate()" />
															</div>
														</div>
													</div>
												</div>


												<!-- <div class="col-md-2">
													<div class="form-group row">
														<label class="col-md-5 col-form-label"> Urgent </label>
														<div class="col-md-7">
															<input type="checkbox" name="urgent" tabindex="1"
																class="radioAuto" value="1" />
														</div>
													</div>
												</div> -->
												<div class="col-md-2"></div>
												<div class="col-md-2"></div>
											</div>
											
											
											<div class="row">
												<div class="col-md-1">
													<div class="form-group">

														<!-- <div class="col-md-1">
															<input type="radio" value="" id="lab_radio" class="radioCheckCol2"
																name="labradiologyCheck" checked="checked"
																onchange="changeRadio(this.value)" />
														</div>
														<label
															style="font: bold 12px/16px Arial, tahoma; color: #000000; background: none; text-align: left; back padding: 0px 9px;"
															class="col-md-5 col-form-label labRadiologyDivfixed">Lab</label> -->
															
														<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="" id="lab_radio" class="form-check-input radioCheckCol2"
																name="labradiologyCheck" checked="checked"
																onchange="changeRadio(this.value)"  />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="lab_radio">Lab</label>
														</div>	
															
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">

														<!-- <div class="col-md-1">
															<input type="radio" value="" id="imag_radio" class="radioCheckCol2"
																name="labradiologyCheck"
																onchange="changeRadio(this.value)" />

														</div>
														<label
															style="font: bold 12px/16px Arial, tahoma; color: #000000; background: none; text-align: left; padding: 0px 9px;"
															class="col-md-5 col-form-label labRadiologyDivfixed">Imaging</label> -->
															
														<div class="form-check form-check-inline cusRadio" style="display: none";>
															<input type="radio" value="" id="imag_radio" class="form-check-input radioCheckCol2"
																name="labradiologyCheck" onchange="changeRadio(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="imag_radio">ECG/ Others</label>
														</div>
														
													</div>
												</div>
												<div class="col-md-8">
													<div class="form-group row"></div>
												</div>


											</div>
											
											
											<div class="">
												<!-- <div class="floatleft">
													<span style="float: left;"> <input type="radio"
														value="1" class="radioCheckCol2"
														style="float: left; margin-right: 6px;"
														name="labradiologyCheck" checked="checked"
														onchange="changeRadio(this.value)" />
														<div class="labRadiologyDivfixed" style="float: right">LAB</div>
													</span> <span> <input type="radio" value="2"
														class="radioCheckCol2"
														style="margin-left: 12px; margin-right: 6px;"
														name="labradiologyCheck"
														onchange="changeRadio(this.value)" /> <span
														class="labRadiologyDivfixed">Radiology</span>
													</span> <input type="hidden" name="investigationCategory"
														id="investigationCategory" /> <input id="visitId"
														name="visitId" type="hidden" value=" " /> <input
														id="visitId1" name=" " type="hidden" value=" " /> <input
														name="hinId" id="hinId" type="hidden" value=" " /> <input
														name="departmentId" id="departmentId" type="hidden" value="" /> <input
														name="hospitalId" type="hidden" id="hospitalId" value="" />


													<div class="clear"></div>
												</div> -->
												<br>





												<div id="gridview">
												 <h6><a class="text-theme font-weight-bold text-underline" onClick="showinvesLoader();showAllAuditRecommendedInvestigationRecall('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Investigation</a>
												 <span class="smallLoader" id="invesLoader"><img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"></span></h6> 
                                  				 <input type="hidden" name="countValueRecommendedInvestigation" id="countValueRecommendedInvestigation" value=""/>
								
													<table class="table table-bordered" border="0"
														align="center" cellpadding="0" cellspacing="0"
														id="investigationGrid">
														<thead>
															<tr class="table-primary">
																<th style="width:30%;">Investigation</th>
																<th  style="width:7%;">Add</th>
																<th style="width:8%;">Delete</th> 
															</tr>
														</thead>

														<tbody id="dgInvetigationGrid">
															<tr>

																<td>
																	<div class="autocomplete forTableResp">
																		<!-- <input type="text" autocomplete="never" value="" id="chargeCodeName"
																			class="form-control border-input"
																			name="chargeCodeName" onKeyPress="autoCompleteCommon(this,1);" size="44"
																			onblur="populateChargeCode(this.value,'1',this);"/>
																		 -->
																		 <input type="text" autocomplete="never" value="" id="chargeCodeName"
																			class="form-control border-input"
																			name="chargeCodeName" onKeyUp="getNomenClatureList(this,'populateChargeCode','opd','getIinvestigationList','investigation');"   size="44"/>
																		 
																		 <input type="hidden" id="qty" tabindex="1" name="qty1"
																			size="10" maxlength="6" validate="Qty,num,no" /> <input
																			type="hidden" tabindex="1" id="chargeCodeCode"
																			name="chargeCodeCode" size="10" readonly /> <input
																			type="hidden" name="investigationIdValue" value=""
																			id="investigationIdValue" /> <input type="hidden"
																			name="dgOrderDtIdValue" value=""
																			id="dgOrderDtIdValue" /> <input type="hidden"
																			name="dgOrderHdId" value="" id="dgOrderHdId " /> 
																			<%--<input type="hidden" name="marksAsLabValue" value=""
																			id="marksAsLabValue" /> <input type="hidden"
																			name="urgentValue" value="" id="urgentValue" />--%>
							  												<div id="investigationDiv" class="autocomplete-itemsNew"></div>

																	</div>
																</td>
			
																<td><button name="Button" type="button"
																	class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" tabindex="1"
																	onclick="addRowForInvestigationFun();"></button></td>
																<td><button type="button" id="deleteInves" name="delete" value=""
																	class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"
																	onclick="removeRowInvestigation(this,'investigationGrid','');"></button>
																</td>

															</tr>
														</tbody>
														<input type="hidden" value="1" name="hiddenValue"
															id="hiddenValue"/>

													</table>
													<br> 
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
											<div class="col-md-1">
													<div id="viewEcgDocs" >
															<input name="viewEcgDocumentId" type="button"
																value="View ECG" tabindex="1" class="btn btn-primary "
																onclick="viewEcgDocumnt();" />
														</div>
												</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
														<label class="col-md-5 col-form-label text-right">ECG Result</label>
														<div class="col-md-7">
														<textarea name="ecgRemarks" id="ecgRemarks" cols="50" rows="0"
														maxlength="500" tabindex="1"
														onkeyup="return ismaxlength(this)" class="form-control"></textarea>
														</div>
												</div>
											</div>
											</div>
													
												<!-- 	
													<label>Other Investigation</label>
													<textarea name="otherInvestigation" id="otherInvestigation" cols="50" rows="0"
														maxlength="500" tabindex="1"
														onkeyup="return ismaxlength(this)" class="auto"></textarea>
													<div class="clear paddingTop15"></div> -->
													
													
											<div class="row" style="display: none";>
												 <div class="col-lg-4 col-sm-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Other Investigation </label>
														<div class="col-md-7">
															<textarea name="otherInvestigation" id="otherInvestigation" cols="0" rows="0"
													        	maxlength="500" tabindex="1"   class="auto form-control"></textarea>													 
													    </div>
												    </div>
												  </div>  
												<div class="col-md-6">
													 
												
												</div>
											</div> 
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

											<div class="row" id="templateTreatment">
												
													<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-6 col-form-label no-bold"  style="padding-left: 10px;"> Template </label>
														<div class="col-md-6">
															<div id="investigationDiv">
																<select name="treatmentTemplateId"  class="form-control"
																	id="treatmentTemplateId" tabindex="1">
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
																data-toggle="modal" data-target="#exampleModal"
																onclick="createTreatmentTemplate();" />
														</div>
													</div>
												</div>
												
												 <div class="col-md-2">
													<div class="form-group row">
														<div id="createInvestigationDivToShowHide" class="opd_invetigation_createtemplate">
															<input name="showTemplate" tabindex="1"
																type="button" id="showTreatmwntTemp" value="Update Template" class="btn btn-primary "
																data-toggle="modal" data-target="#exampleModal"
																onclick="opdUpdateTreatmentTemplate();" />
														</div>
													</div>
												</div> 



										

													<div class="col-md-2"></div>




										</div>
										  <h6><a onClick="showAllCurrentMedication('ALL','SearchStatusForUnitAdminCurrentMedication');" class="text-theme font-weight-bold text-underline" href="javascript:void(0)">Current Medication</a></h6> 
										   <h6><a class="text-theme font-weight-bold text-underline" onClick="showtreatLoader();showAllAuditRecommendedTreatmentRecall('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Treatment</a>
										   <span class="smallLoader" id="treatLoader"><img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"></span></h6> 
                                  		 <input type="hidden" name="countValueRecommendedTreatment" id="countValueRecommendedTreatment" value=""/>
								
										<div class="table-responsive">
											<table class="table table-bordered m-t-10" align="center"
												cellpadding="0" cellspacing="0">
												<tr>
													<th>Drugs Name/Drugs Code</th>
													<th scope="col">Disp. Unit</th>
													<th scope="col">Dosage<span>*</span></th>
													<th scope="col">Frequency<span>*</span></th>
													<th scope="col">Days<span>*</span></th>
													<th scope="col">Total<span>*</span></th>
													<th scope="col">Instruction</th>
													<th >Available Stock</th>
												  	<th scope="col">Add</th>
													<th scope="col">Delete</th>

												</tr>
												<tbody id="nomenclatureGrid">
													<tr>

														<td>
															<div class="autocomplete forTableResp">
														
																<input type="text" autocomplete="never" value="" tabindex="1"
																	id="nomenclature1" size="77" name="nomenclature1"
																	class="form-control border-input width330" onKeyUp="getNomenClatureList(this,'populatePVMSTreatment','opd','getMasStoreItemList','numenclature');"/>
																	
																<input type="hidden" name="itemId" value=""
																	id="nomenclatureId" /> <input type="hidden"
																	name="prescriptionHdId" value="" id="prescriptionHdId" />
																<input type="hidden" name="prescriptionDtId" value=""
																	id="precriptionDtId" />
															<input type="hidden" name="statusOfPvsms" id="statusOfPvsms" value=""/>
																	<div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div>
																	
															</div>
														</td>

													

															<td>
                                                    <select name="dispensingUnit1" id="dispensingUnit1" class="medium form-control width100" ></select>
                                                    </td>				
															
														<td><input type="text" name="dosage1" tabindex="1" onkeypress="return checkValidate(event);"  onblur="fillValueNomenclature('1')"
															value="" id="dosage1" size="5" maxlength="5"   class="form-control width60"/></td>

														<td><select name="frequencyTre" id="frequencyTre" onchange="fillValueNomenclature('1')"
															class="medium form-control width150">

														</select></td>

														<td><input type="text"  class="form-control width60" onkeypress="return checkValidate(event);" name="noOfDays1" tabindex="1"
															id="noOfDays1" onblur="fillValueNomenclature('1')"
															size="5" maxlength="3" /></td>

														<td><input  class="form-control width70"  type="text" onkeypress="return checkValidate(event);" name="total1" tabindex="1"
															id="total1" size="5" validate="total,num,no"
															 /></td>

														<td><select name="instuctionFill" id="instuctionFill" class="medium form-control"> </select></td>

														<td><input  class="form-control width80" type="text" name="closingStock1" onkeypress="return event.charCode != 32"
															tabindex="1" value="" id="closingStock1" size="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
															validate="closingStock,string,no" readonly/></td>
														
													
														<td style="display: none;"><input type="hidden"
															value="" tabindex="1" id="itemIdNom" size="77"
															name="itemIdNom" /></td>
														<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRowRecall();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRowInvestigation(this,'nomenclatureGrid', '');"></button>

														</td>
														<td style="display: none;"><input type="hidden"
															name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
															readonly="readonly" />
															</td>
														<td style="display: none;"><input type="hidden"
														name="itemClassId" tabindex="1" id="itemClassId" size="10"
														readonly="readonly" /></td>	
													</tr>

												</tbody>
												<tr>
											</table>
											</div>

									
 								<div class="clearfix"></div>
											 <br>
									 
											<!-- <div class="row">
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;">Recommended Medical Advice </label>
														<div class="col-md-7">
															 <textarea name="recommendedMedicalAdvice"   class="form-control"
																validate="referralNote,string,no" id="recommendedMedicalAdvice"
																cols="0" rows="0" maxlength="500" tabindex="5"
																onkeyup="return checkLength(this)"></textarea>
														</div>
													</div>
												</div>
												<div class="col-md-6">
													 
												</div>
											</div>  --> 
											
										<!-- 
												<div class="row m-t-10">
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Recommended Medical Advice </label>
														<div class="col-md-7">
															<textarea name="recommendedMedicalAdvice" id="recommendedMedicalAdvice" cols="0" rows="0" maxlength="500" tabindex="1"  class="auto form-control" ></textarea>													 
													    </div>
												    </div>
												    
												  </div> 
												  </div> -->
												  
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

											<div class="row">


																								
												
												<!-- <div class="col-md-4 text-right">
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
																	<!-- <input type="text" autocomplete="never" class="form-control border-input"
																		value="" id="procedureNameNursing" size="42"
																		name="procedureNameNursing" onKeyPress="autoCompleteCommon(this,3);"
																		onblur="populateNursingRecall(this.value,'1',this);" /> -->
																		
																	<input type="text" autocomplete="never" class="form-control border-input"
																		value="" id="procedureNameNursing" size="42"
																		name="procedureNameNursing" onKeyUp="getNomenClatureList(this,'populateNursingRecall','opd','getMasNursingCare','procedureNursing');" />
																			
																	 <input type="hidden"  name="procedureNameNursingId" value=""  id="procedureNameNursingId"/>
				 													<input type="hidden"  name="procedureDtIdValue" value="" id="procedureDtIdValue"/>
												 					<input type="hidden"  name="procedureHdId" value="" id="procedureHdId"/>
												 					<input type="hidden"  name="statusOfPro" value="" id="statusOfPro"/>
												 					
																	<div id="procedureNursingForAutoComplete" class="autocomplete-itemsNew"></div>
																</div>
																
															</td>

													
															<td>
															<input value="" type="text"
																name="remark_nursing" id="remark_nursing"
																class="largTextBoxOpd textYellow form-control" maxlength="100" />
															</td>
															
															 
														<!-- 	<td style="display: none;">
															<input type="hidden"
																value="" id="procedureNameNursingId"
																name="procedureNameNursingId" />
																
															</td>
															<td style="display: none;">
															<input type="hidden"
																class="form-control border-input" value=""
																id="procedureNameNursing" size="55"
																name="procedureNameNursing" />
															</td>
															<td style="display: none;"><input type="hidden"
																class="form-control border-input" value=""
																id="procedureNameNursingCare" size="55"
																name="procedureNameNursingCare" />
															</td> -->
															<td>
																<button type="button" class="buttonAdd btn btn-primary noMinWidth"
																	alt="Add" tabindex="4" value="" button-type="add"
																	onclick="addRowTreatmentNursingCareRecall();"></button>
															</td>
															<td>
																<button type="button" class="buttonDel btn btn-danger noMinWidth"
																	tabindex="3" alt="Delete" value="" button-type="delete" id="deleteProcure"
																	onclick="removeProcedureRow(this);"></button>
															</td>

															<!-- <td style="display: none;"><input type="hidden"
																id="procedureHeaderId" name="procedureHeaderId" value="" />
															</td>
															<td style="display: none;"><input type="hidden"
																name="nursinghdb" value="" id="nursinghdb" /></td> -->
														</tr>
													</tbody>
													<div class="clearfix"></div>
												</table>
											 <div class="clearfix"></div>
											 <br>
									 
											<!-- <div class="row">
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Additional Advice </label>
														<div class="col-md-7">
															 <textarea name="additionalNote"   class="form-control"
																validate="referralNote,string,no" id="additionalNote"
																cols="0" rows="0" maxlength="500" tabindex="5"
																onkeyup="return checkLength(this)"></textarea>
														</div>
													</div>
												</div>
												<div class="col-md-6">
													 
												</div>
											</div>  -->
											 

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
											
													<div class="row" style="padding-left: 9px;">
														<div class="col-md-4">
															<div class="form-group row">
																<label class="col-md-5 col-form-label">Referral</label>
																
																<div class="col-md-7">
																	<select  id="referralForNew" name="referralForNew" class="midium form-control"  onchange="getReferalDataForAdd();" >
																		<option  id="option1" value="0">No</option>
																		<option id="option2" value="1">Yes</option>
																	</select>
																</div>
															</div>
														</div>
														<div class="col-md-4"></div>
														<div class="col-md-4"></div>
													</div>
													
													
													
												 

													<div id="referDiv" class="col collaps"
														style="display: block;">
														
														<div class="row">
														<div class="col-md-12 m-t-10" style="display:none">
															<label>Refer To</label> <label class="autoSpace" style="margin-left:12px;">
																<input type="radio" class="radioCheckCol2" name="referTo"
																id="referExternal" value="E"  onchange="getReferalDataForAdd('external')"
																onclick="checkReferTORecall('referExternal');"
																style="margin: 1px 5px 0px 110px;" >External (Other than ICG)
															</label> 
															
															
															<label class="autoSpace" > <input type="radio"
																class="radioCheckCol2"  onchange="getReferalDataForAdd('internal')" name="referTo" id="referInternal"
																value="I"  
																style="margin: 1px 5px 0px 32px;">Internal
															</label>
															
														</div>
														</div>


													<!--  <label
											class="autoSpace"><input type="radio"
											class="radioCheckCol2" name="referTo" id="referBoth"
											value="Both" onclick="checkReferTO('Both');"
											style="margin: 1px 5px 0px 0px;" />Both
											</label> -->
											
											
											
													<div class="row">
														<div class="col-md-4">
															<!-- <div class="form-group row">
																<label class="col-md-5 col-form-label">Referral Date</label>
																
																<div class="col-md-7">
																	 <input type="date"  class="form-control"  name="referVisitDate"  onblur="#" id="referVisitDate" placeholder="DD/MM/YYYY" value="">
																</div>
															</div> -->
														</div>
														<div class="col-md-4"></div>
														<div class="col-md-4"></div>
														
													<!-- <div class="col-md-12 text-right">
															<div class="form-group">
																<label class="col-md-5 col-form-label">Referral Date</label>
																
																<div class="col-md-7">
																	 <input type="date"  class="form-control"  name="referVisitDate" id="referVisitDate" onblur="checkReferalDate()" placeholder="DD/MM/YYYY" value="">
																</div>
																<input type="button" id="createEHospital" value="Create Empanelled Hospital" data-toggle="modal" data-target="#smallModal" onclick="createEmpanlledMaster();" tabindex="1" class="btn btn-primary">
																															</div>
														</div>	 -->
														
													</div>
											 
									 
												<!-- 	<label>Referral Date:</label> <input type="Date" name="referVisitDate" id="referVisitDate" placeholder="DD/MM/YYYY" value=""> -->

 
													<!-- onblur="checkAdmte()" -->
													<!-- <label id="priorityLabelId" style="display: block;">Current Proirity No.</label>
													 <select id="priorityId" name="priorityName" tabindex="1" style="display: block;">
														<option value="3">3</option>
														<option value="2">2</option>
														<option value="1">1</option>
													</select> -->
                                                    <br>
													<!-- <div class="clear"></div> -->
													<div id="referDepartmentDiv" style="display: block;">
														<div class="clear"></div>
														<table id="referGrid" class="table table-bordered">
															<tbody>
																<tr>
																	<th style="display:none;">S.No.</th>
																	<th>Hospital</th>
																	<th>Department</th>
																	<!-- <th scope="col">Add</th>
																	<th scope="col">Delete</th> -->
																</tr>
															</tbody>
															<tbody id="referalGridNew">

															</tbody>
														</table>
														
														<input type="hidden" value="1" name="hiddenValueRefer" id="hiddenValueRefer">
													</div>
													
													<div style="display:none;">
													<label id="referhospitalLabel" style="display: none;">Hospital
														<span>*</span>
													</label> <select id="referhospital" name="referhospital" 
													onchange="fnGetHospitalDepartment(this.value);" style="display: none;" validate="">
														<option value="0">Select</option>

														<option value=""></option>

													</select> <label id="referdayslLabel" style="display: none;">No.
														of Days</label> <input id="referdays" name="referdays" type="text" maxlength="2" style="display: none;">

													<div class="clear"></div>


													<div class="clear"></div>
													<label style="display: none">Patient Advise</label>
													<textarea name="patientAdvise" validate="patientAdvise,string,no" id="patientAdvise" cols="0" rows="0" maxlength="500" tabindex="5" onkeyup="return checkLength(this)" style="display: none"></textarea>
													<!-- <input type="button" class="buttonAuto-buttn" value="+"
										onclick="" /> -->
													<label id="referral_treatment_type_label" style="display: none">Treatment Type <span>*</span></label>
													<select id="referral_treatment_type" name="referral_treatment_type" style="display: none">
														<option value="1" selected="true">OPD</option>
														<option value="2">Admission</option>
													</select> <label id="referredForLabel" style="display: none">Referred
														For<span>*</span>
													</label> <input id="referredFor" name="referredFor" type="text" maxlength="300" validate="" style="display: none">
													
													</div>
													<div class="clear"></div>
													
													
													
											<div class="row">
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Referral Notes</label>
														<div class="col-md-7">
															 <textarea name="referralNote" class="form-control" validate="referralNote,string,no" id="referralNote" cols="0" rows="0" maxlength="500" tabindex="5" onkeyup="return checkLength(this)" ></textarea> 
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
										</div>
							</div>        
	         </div>
	
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
													<div class="form-check form-check-inline cusCheck m-l-10">
														<input class="form-check-input" type="checkbox" id="followUpChecked" name="followUpChecked" onClick="followUpFlagRecall(this)" value="Y">
														
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
										<select id="noOfDays" name="noOfDaysFollowUp" class="form-control" onchange="nextFolloUpDateRecall(this.value)" >
											<option value="">Select</option>
											<option value="1">After 1 Day</option>
											<option value="2">After 2 Day</option>
											<option value="3">After 3 Day</option>
											<option value="4">After 4 Day</option>
											<option value="5">After 5 Day</option>
											<option value="6">After 6 Day</option>
											<option value="7">After 7 Day</option>
											<option value="8">After 8 Day</option>
											<option value="9">After 9 Day</option>
											<option value="10">After 10 Day</option>
											<option value="11">After 11 Day</option>
											<option value="12">After 12 Day</option>
											<option value="13">After 13 Day</option>
											<option value="14">After 14 Day</option>
											<option value="15">After 15 Day</option>
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
											<input type="text" class="form-control noBack_date2" id="nextFollowUpDate" name="nextFollowUpDate" placeholder="DD/MM/YYYY" />
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
			 <div class="col-md-6">
				<div class="form-group row">
					<label class="col-md-4 col-form-label" style="  padding-left: 10px;">Doctor's Remark</label>
					<div class="col-md-7">
						 <textarea name="additionalNote"   style="width:600px; height:100px;"  class="form-control border-input
							validate="referralNote,string,no" id="additionalNote"
							cols="0" rows="0" maxlength="500" tabindex="5" readonly></textarea>
					</div>
				</div>
			</div>										
	 	</div>										
												
	</div>
	
	<!-- ----- doctor remark  end here --------- -->						
								
								<div class="clearfix"></div>
								
								<div class="clearfix"></div>
								
								<br>
										<div class="row">
										
										
										 <div class="col-md-12">
																<div class="btn-left-all">																 
															</div> 
															<div class="btn-right-all">
															<input type="button" id="clicked111" class="btn btn-primary" onclick="return submitForm('recall');"
															value="Submit"/>
															<!-- <button id="reset" class="btn  btn-danger"/> Reset </button> -->
																<button type="reset" name="Reset"  value=""
			                                                  class="btn  btn-danger" accesskey="r" onclick="resetFormRecall();">Reset</button>
															<input type="button" id="opdRecallMainBack"
													class="btn btn-primary" value="Back"
													onclick="opdRecallBackFunction()" />
															</div> 
													   </div> 
																										
													   </div>
													 
								</form:form>
								</div>
							</div>
								</div>
								</div>
								</div>
								
								</div>
							
	
	

		<!--  For AutoComplete Method -->
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
	<script>

var checkBox='';

function obsistyFunctionRecall() {
  checkBox = document.getElementById("obsistyMark");
 // var text = document.getElementById("text");
  if (checkBox.checked == true){
   // text.style.display = "block";
   $('#obsitymarkvalue').val(1);
  } else {
	  $('#obsitymarkvalue').val(0);
  }
  //alert($('#obsitymarkvalue').val());
}
</script>

	<script>
            /*An array containing all the country names in the world:*/
            //var countries = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua & Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia & Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central Arfrican Republic","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cuba","Curacao","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kiribati","Kosovo","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauro","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","North Korea","Norway","Oman","Pakistan","Palau","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre & Miquelon","Samoa","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Korea","South Sudan","Spain","Sri Lanka","St Kitts & Nevis","St Lucia","St Vincent","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad & Tobago","Tunisia","Turkey","Turkmenistan","Turks & Caicos","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States of America","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"];
            var arry = new Array();
            var icdArry = new Array();
            
           // autocomplete(document.getElementById("icd"), arry);

            var arryInvestigation = new Array();
            /* var inVal=$('#dgInvetigationGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
           		autocomplete(inVal, arryInvestigation); */
            
             var arryNomenclature= new Array();
            /*  var val=$('#nomenclatureGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
             autocomplete(val, arryNomenclature); */
            
             var arryProcedureCare= new Array();
             /* var valProcedure=$('#gridNursing').children('tr:first').children('td:eq(0)').find(':input')[0]
             autocomplete(valProcedure, arryProcedureCare);  */
         
        </script>

	<script type="text/javascript">
            var popup;

            function SelectName() {
                popup = window.open("getFamilyPatinetHistory?employeeId="+<%=userId%>+"", "popUpWindow", "height=500,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
            }
        </script>

	<script type="text/javascript">
            var popup;

            function showCreateInvestigationTemplate() {
            	 $('#exampleModal .modal-body').load("showCreateInvestigationTemplate?employeeId="+<%= userId %>);
                 $('#exampleModal .modal-title').text('Investgation Template');
            }
            
            function createTreatmentTemplate() {
            	$('#exampleModal .modal-body').load("createTreatmentTemplate?employeeId="+<%= userId %>);
                $('#exampleModal .modal-title').text('Treatment Template');
            }

           <%--  function showUpdateInvestigationTemplate() {
                popup = window.open("showUpdateInvestigationTemplate?employeeId="+<%=userId%>+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
            } --%>
            
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
        </script>


	<script type="text/javascript" language="javascript">
            		
                function getIcdDiagnosisDataaa(){
                	
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
                                var a = icdName + "[" + icdCode + "]"

                                var icdId = icdName + "[" + icdId + "]"
                                autoIcdList[i] = a;
                                    //alert("a "+a);
                                arry.push(a);
                                icdArry.push(icdId);
                                //console.log('data :', a, icdId);
                            }
                           
                           // putIcdIdValue(autoIcdList, icdData);

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

                }
            
            var autoIcdCode = '';
            var icdData= '';	 
             var idIcdNo = '';
             var icdValue = '';
             var multiIcdValue=[];
            
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
                    for (var i = 0; i < obj.length; i++) {
						
                        var val2 = obj.options[i].text;
                        var index1 = val2.lastIndexOf("[");
                        var index2 = val2.lastIndexOf("]");
                        index1++;
                        var idIcdNoUpdate = val2.substring(index1, index2);
                        
                        if (idIcdNo == idIcdNoUpdate) {
                        	
                        	alert("ICD  Already taken");
                            
                        	document.getElementById('icd').value = ""
                            b = true;
                        }

                    }
                  
                    for(var i=0;i<autoIcdCode.length;i++){
                 		  
                 		  var icdNo1 = icdData[i].icdCode;
                 		 
                 		  if(icdNo1 == idIcdNo){
                 			icdValue = icdData[i].icdId;
                 			multiIcdValue.push(icdValue);
                 			//digaoReferal=icdValue;
                 		  }
                 	  }
                    if (b == "false") {
                    	
                    	
                        $('#diagnosisId').append('<option value=' + icdValue + '>' + val + '</option>');
                        document.getElementById('icd').value = ""
                        	
                      
                    }
                }
                $('#icdIdValue').val(multiIcdValue);
            }
            
            function fillReferalDiagnosisVal(item)
            {
          //  var val= $(item).closest('tr').find("td:eq(7)").find(":input").val(digaoReferal)
             $(item).closest('tr').find("td:eq(2)").find("input:eq(1)").val(digaoReferal)
            }
      
        </script>


	
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
                if (data.data[0].patientId != null) {
                    document.getElementById('patientId').value = data.data[0].patientId;
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
               /*  if (data.data[0].varation != null) {
                		document.getElementById('variant_in_weight').value =data.data[0].varation;
                	 
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
                if (data.data[0].bmi != null && data.data[0].bmi != undefined && data.data[0].bmi != "" && data.data[0].bmi != "NaN") {
                    document.getElementById('bmi').value = data.data[0].bmi;
                }
                if (data.data[0].rr != null) {
                    document.getElementById('rr').value = data.data[0].rr;
                }
                if (data.data[0].patientPastMedicalHistory!= null) {
                    document.getElementById('pastMedicalHistory').value = data.data[0].patientPastMedicalHistory;
                }
                getPatientSympotonsRecall();
                if (data.data[0].followUpFlag != null && data.data[0].followUpFlag =="Y") {
                	$('#followUpChecked').attr('checked', true); 
                	document.getElementById("noOfDays").selectedIndex = data.data[0].followUpDays;
                	if(data.data[0].followUpDays!=17)
                	{	
                		document.getElementById("nextFollowUpDate").value = data.data[0].followUpDate;
                		$('#'+"nextFollowUpDate").attr('readonly', true);
                	}
                	else
                	{
                		document.getElementById("nextFollowUpDate").value = data.data[0].followUpDate;
                		
                	}
                	//nextFolloUpDate(data.data[0].followUpDays);
                	//document.getElementById("followUpChecked").checked == true;
                }
                
                if (data.data[0].mlcFlag != null && data.data[0].mlcFlag =="Y") {
                	$('#markMLC').attr('checked', true); 
                	 marksAsMLCRecall();
                	document.getElementById("mlcPloiceStation").value = data.data[0].policeStation;
                	document.getElementById("mlcTreatedAs").value = data.data[0].treatedAs;
                	document.getElementById("mlcPloiceName").value = data.data[0].mlcPloiceName;
                	document.getElementById("mlcDesignation").value = data.data[0].mlcDesignation;
                	document.getElementById("mlcIdNumber").value = data.data[0].mlcIdNumber;
                	
                }
                if (data.data[0].doctorAdditionalNote != null && data.data[0].doctorAdditionalNote!="") {
                	document.getElementById("additionalNote").value = data.data[0].doctorAdditionalNote;
                }
                if (data.data[0].doctorRecommededId != null && data.data[0].doctorRecommededId!="") {
                	document.getElementById("doctorRemarksArrayVal").value = data.data[0].doctorRecommededId;
                }
                if (data.data[0].ecgRemarks != null && data.data[0].ecgRemarks!="") {
                	document.getElementById("ecgRemarks").value = data.data[0].ecgRemarks;
                }
                if(data.data[0].masEmployeeCategory!=null)
                {
                	 document.getElementById('empCategory').value = data.data[0].masEmployeeCategory;
                }
                if(data.data[0].visitId!=null){ 
                  	 document.getElementById('visitId').value=data.data[0].visitId;
                  }
                   
                   if(data.data[0].opdPatientDetailId!=null){
                     	 document.getElementById('opdPatientDetailId').value=data.data[0].opdPatientDetailId;
                     }
                   if(data.data[0].patientId!=null){
                    	 document.getElementById('patientId').value=data.data[0].patientId;
                    }
                   if(data.data[0].duration!=null){
                  	 document.getElementById('duration').value=data.data[0].duration;
                  }
                  
                   if(data.data[0].gender!=null){
                    	 document.getElementById('gender').value=data.data[0].gender;
                    } 
                   
                  
                if (obsistyOverWeight!=null && obsistyOverWeight!="")
    			{
    			     
                	obsistyMark=obsistyOverWeight;
    			   
    			    
    			}
                if (data.data[0].obsistyCloseDate == "" ) {
             	   
                    if(data.data[0].obesityOverWeightFlag == "Y")
                 	{
                 	   document.getElementById('obsistyCheckAlready').value ="exits";
                 	   $("#overCheck").prop("checked", true);
                 	 	$("#overWeightDropDown").show();
 						$('#obsistyMark').val("Y");
 						
 						$('.makeDisabled input,.makeDisabled select').prop("disabled", true);
 						//overWeight("Y");	
                 	}	
                 	else
                 	{
                 		document.getElementById('obsistyCheckAlready').value ="exits";
                 		$("#obsistyCheck").prop("checked", true);
 						$("#overWeightDropDown").hide();
 						$('#obsistyMark').val("N");
 						$('.makeDisabled input,.makeDisabled select').prop("disabled", true);
 						//overWeight("N");
                 	}	
                  }
                
                if(data.data[0].relation!=null && data.data[0].relation==resourceJSON.relationName){
                	 $('#markObesityId').show();
                }
                else{
                	$('#markObesityId').hide();
                }
                	/* var x = document.getElementById("obsistyMark");
                	  x.checked = true;
                	  $('#obsitymarkvalue').val(1);
                	  $('#markObesityId').show();
                	}
                else{ 
                	$('#obsitymarkvalue').val(0);
                	$('#markObesityId').hide();
                } */
                if (data.data[0].genderId != null) {
                    document.getElementById('genderId').value = data.data[0].genderId;
                	}
                
                if (data.data[0].departmentId != null) {
                    document.getElementById('departmentId').value = data.data[0].departmentId;
                }
                
                if (data.data[0]!=null && data.data[0].recommendedMedicalAdvice != null  && data.data[0].recommendedMedicalAdvice!="") {
                	$("#recommendedMedicalAdvice").val(data.data[0].recommendedMedicalAdvice);  
                }
                else{
                	$("#recommendedMedicalAdvice").val('Review SOS');
                }
               /*  if (data.data[0].otherInvestigation != null  ) {
                	$("#otherInvestigation").val(data.data[0].otherInvestigation);  
                	
                } */
                if (data.data[0].registrationTypeCode != null) {
                    document.getElementById('registrationTypeCode').value = data.data[0].registrationTypeCode;
                }
                
                    //patientHistoryData(); 
                	//checkForAuthenticateUser();
                	getPatientDiagnosisDetail();
   					//patientExaminationDignosisData();
   				   	patientInvestigationData();
                   	patientTreatementDetail();
                   	getPatientReferalDetail();
                   	getFrequencyDetailTre();
					getPocedureDetailData();
					// getUsersAuth();
					//getMastStoreItemNipRecall();
					//patientObstetricsData();
					
            });
        </script>

	<script type="text/javascript">
           /*  $(document).ready(function() {
                $('#height').change(
                    function() {

                        var pathname = window.location.pathname;
                        var accessGroup = "MMUWeb";

                        var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getIdealWeight";

                        var dataJSON = {

                            'height': $('#height').val(),
                            'age': $('#ageNumber').val(),

                        }
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: url,
                            data: JSON.stringify(dataJSON),
                            dataType: 'json',
                            timeout: 100000,
                            success: function(data) {
                                if (data.status == 1) {
                                    $('#ideal_weight').val(data.data[0].idealWeight);

                                }

                            },
                            error: function(e) {

                            },
                            done: function(e) {
                                alert("success");
                                var datas = e.data;
                            }
                        });
                    });
            }); */
        </script>

	<script type="text/javascript">
           /*  $(document).ready(function() {
                $('#weight').change(
                    function() {

                        var a = document.getElementById("ideal_weight").value;
                        var b = document.getElementById("weight").value;

                        if (a > b) {
                            var sub = a - b;
                            var cal = sub * 100 / a
                            var n = cal.toFixed(2);
                            $('#variant_in_weight').val(n);

                        } else {
                            var eadd = b - a;
                            var cal1 = eadd * 100 / b
                            var n1 = cal1.toFixed(2);
                            $('#variant_in_weight').val("-" + n1);
                        }

                    });
            }); */
        </script>

	<script type="text/javascript" language="javascript">
            function populateClinicalNotes(obj) {
                var objValue = obj.value;
                if (obj.id == 'initialDiagnosis') {
                    document.getElementById('clinicalNotes').value = objValue;
                }
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
     function populateChargeCode(val,count,item) 
 	{
        	
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
        		return;
        		}
        		else{
        			var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").attr("id");
        			var checkCurrentRow=$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").val();
   			         var count=0;   			
   			        $('#dgInvetigationGrid tr').each(function(i, el) {
        			    var $tds = $(this).find('td');
        			    var chargeCodeId=  $($tds).closest('tr').find("td:eq(0)").find("input:eq(3)").attr("id");
       			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
       			        var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").attr("id");
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
       			            	$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").val(ChargeCode); 
       			        	 
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
				    }
					  else
						  {
						  var outLab='O';
						  labMarkValue=outLab;
						  }
				        
				    $(item).closest('tr').find("td:eq(6)").find(":input").val(labMarkValue)
						}
  			 
  		 } 
  		
  		
  		function testPrescriptionData()
  		{
  			var tableDataInvestigation = [];  
	    	var dataInvestigation='';
	       	var labInvestgationId=[];
			var rawArrayInvestigation=[];
	    	 
	    	var count=0;
	    		$('#dgInvetigationGrid tr').each(function(i, el) {
			    var $tds = $(this).find('td')
			  		
				var itemIdInvestigation = $tds.eq(5).find(":input").val();
				var labinvastigation="";
				 for (var i = count; i <labInvestgationId.length; i++) {
					 if(i==count){
						 labinvastigation=labInvestgationId[i];
						 break;
					 }
					 
				 }
				 count++;
				dataInvestigation={
	    				'investigationItemId' : itemIdInvestigation
	    				
				}
				tableDataInvestigation.push(dataInvestigation);
	    	}); 
	    
  		}
       	
      </script>

	<script type="text/javascript" language="javascript">
      var autoVsPvmsNo = '';
      var data='';
      var itemIds = '';
     
       
    
      function populatePVMSTreatment(val, inc,item) {
    		if (val != "") {
    			var index1 = val.lastIndexOf("[");
    			var indexForBrandName = index1;
    			var index2 = val.lastIndexOf("]");
    			index1++;
    			pvmsNo = val.substring(index1, index2);
    			var indexForBrandName = indexForBrandName--;
    			var brandName = val.substring(0, indexForBrandName);
    			if (pvmsNo == "") {
    				return false;
    			} 
    			else
    			{
    				//document.getElementById('pvmsNo' + inc).value = pvmsNo
    				  var pvmsValue = '';
    				  var dispunitIddd='';
    				  var masFrequencyId='';
    				  var  masDosage='';
    				  var  masNoOfDays='';
    		     	  for(var i=0;i<autoVsPvmsNo.length;i++){
    		     		 // var pvmsNo1 = data[i].pvmsNo;
    		     		 var masItemIdValue= autoVsPvmsNo[i];
    		     		 var pvmsNo1=masItemIdValue[1];
    		     		 var itemClassId=masItemIdValue[5];
    		     		  if(pvmsNo1 == pvmsNo){
    		     			  pvmsValue = masItemIdValue[3];
    		     			 dispunitIddd= masItemIdValue[6];
	    		     			masFrequencyId=masItemIdValue[7];
	    		     			masDosage=masItemIdValue[8];
	    		     			masNoOfDays=masItemIdValue[9];
    		     			  itemIdPrescription =masItemIdValue[0];
    		     			  itemIds = itemIdPrescription;
    		     			  
    		     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
    	      			   var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();  
    	      			   
    	      			 checkCurrentNomRowVal=$('#'+checkCurrentNomRowId).val();
    		     			$('#nomenclatureGrid tr').each(function(i, el) {
    		     			   var $tds = $(this).find('td')
    		  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
    		     			   var itemIdValue=$('#'+itemIdCheck).val();
    		     			   var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
    		     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
    		     			   if(itemIdCheck!=checkCurrentNomRowId)	   
    	 			           {
    		     				 if(itemIds==itemIdValue){
    		      			        $('#'+idddd).val("");
    		      			        $('#'+currentidddd).val("");
    		      			      	alert("Drug is already added");
    		      			        return false;
    		     				   
    	 			           }
    	 			           }
    		     			   else
    		     			   {
    		     				  $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(itemIds); 
    		     				  $(item).closest('tr').find("td:eq(1)").find("select:eq(0)").val(dispunitIddd);
    		     				  $(item).closest('tr').find("td:eq(2)").find(":input").val(masDosage)
    			       	          $(item).closest('tr').find("td:eq(3)").find("select:eq(0)").val(masFrequencyId)
    			       	          $(item).closest('tr').find("td:eq(4)").find(":input").val(masNoOfDays)
    			       	          $(item).closest('tr').find("td:eq(12)").find(":input").val(itemClassId)
	    			       	          
	    			       	     var itemClassIdTablet=3;
			       	          	 var itemClassIdCapusle=4;
			       	             var itemClassIdInjection=5;
			       	            if(itemClassId!=itemClassIdTablet && itemClassId!=itemClassIdCapusle && itemClassId!=itemClassIdInjection)
		       	     	    	{
			       	            	$(item).closest('tr').find("td:eq(5)").find(":input").val("1")			       	            	
		       	     	    	}
			       	            else
			       	            {	
    			       	          var total = masDosage * masFrequencyId * masNoOfDays;
		       	          		  var t=Math.round(total);
		       	          	      $(item).closest('tr').find("td:eq(5)").find(":input").val(t)
			       	             }
    		       	     	     $(item).closest('tr').find("td:eq(10)").find(":input").val(itemIds)
    		       	     	   
    		     			   
    		     			   }
    		     			  if(pvmsNo!=null &&pvmsNo!='')
    		     		        {
    		     				    var pathname = window.location.pathname;
    		     					var accessGroup = "MMUWeb";
    		     					var url = window.location.protocol + "//"
    		     					+ window.location.host + "/" + accessGroup
    		     					+ "/dispencery/getAvailableStock";
    		     					
    		     					/*
    		     					 * var url =
    		     					 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
    		     					 */
    		     					$
    		     							.ajax({
    		     								url : url,
    		     								dataType : "json",
    		     								data : JSON.stringify({
    		     									"itemId":itemIds,
    		     									"mmuId1":hsId,
    		     									"flag":"OPD",
    		     									"departmentId":$('#departmentId').val()
    		     								}),
    		     								contentType : "application/json",
    		     								type : "POST",
    		     								success : function(response) {
    		     									console.log(response);
    		     									var availableStock=response.availableStock;
    		     									var exp_dt = response.expiry_date; // 30/06/25
    		     									
    		     									var exp_dt = response.expiry_date; // Example: '30/06/25'

    		     									
    		     									
    		     									
    		     									if(availableStock!=undefined && availableStock!=0)
    		     									{	
	    		     									$(item).closest('tr').find("td:eq(7)").find(":input").val(availableStock);
	    		     									$(item).closest('tr').find("td:eq(0)").find(":input").css('border', '1px solid #ced4da')
	    		     									
	    		     									if (isExpiryWithinThreeMonths(exp_dt)) {
    		     									    		console.log("Expiry date is within 3 months.");
    		     									   			$(item).closest('tr').find("td:eq(0)").find(":input").css('border', '5px solid yellow');
	    		     									} else {
	    		     									   		// console.log("Expiry date is not within 3 months or is blank.");
	    		     									   		// $(item).closest('tr').find("td:eq(0)").find(":input").css('border', '5px solid green');
	    		     									}
	    		     									
	    		     									
	    		     									
    		     									}
    		     									if(availableStock==0)
    		     									{
    		     										$(item).closest('tr').find("td:eq(0)").find(":input").css('border', '5px solid red');
    		     										$(item).closest('tr').find("td:eq(7)").find(":input").val(availableStock)
    		     										
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
	    	 
     var lastRow;
     var i=0;
      function addRowForInvestigationFun(){
     	  var tbl = document.getElementById('dgInvetigationGrid');
        	lastRow = tbl.rows.length;
        	i =lastRow;
        	i++;
             	
     	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
     	    aClone.find('img.ui-datepicker-trigger').remove();
     		aClone.find(":input").val("");
     		aClone.find('input[type="text"]').prop('id', 'chargeCodeCode'+i+'');
     		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
     		aClone.find("td:eq(0)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
     		aClone.find("td:eq(0)").find("div").find("div").prop('id', 'investigationDiv' + i + '');
    		
			
     	    aClone.find("td:eq(2)").find("button:eq(0)").removeAttr("readonly",false);
			aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly",false);
			
			aClone.clone(true).appendTo('#dgInvetigationGrid');
         	$('#dgInvetigationGrid>tr:last').find("td:eq(3)").find("button:eq(0)").attr("id","newIdInv");
           
     	} 
      var countRecall=1;
      function addNomenclatureRowRecall() {
    	  var tbl = document.getElementById('nomenclatureGrid');
  			var lastRow = tbl.rows.length;
  			countRecall=lastRow+1;
     		var aClone = $('#nomenclatureGrid>tr:last').clone(true)
     		aClone.find(":input").val("");
     		//aClone.find('input[type="text"]').prop('id', 'nomenclature'+countRecall+'');
     		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'nomenclature'+countRecall+'');
     		aClone.find("td:eq(0)").find("input:eq(1)").prop('id', 'nomenclatureId'+countRecall+'');
     		aClone.find("td:eq(0)").find("input:eq(2)").prop('id', 'prescriptionHdId'+countRecall+'');
     		aClone.find("td:eq(0)").find("input:eq(3)").prop('id', 'precriptionDtId'+countRecall+'');
     		aClone.find("td:eq(0)").find("div").find("div").prop('id', 'nomenclatureIdPvs' + countRecall + '');
     		
     		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'dispensingUnit1'+countRecall+'');
     		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'dosage1'+countRecall+'');
     		
     		aClone.find("td:eq(3)").find("select:eq(0)").prop('id', 'frequencyTre'+countRecall+'');
     		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'noOfDays1'+countRecall+'');
     	  		
     		aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'total1'+countRecall+'');
     		
     		aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'instuctionFill'+countRecall+'');
     		//aClone.find("td:eq(7)").find("input:eq(0)").removeAttr("readonly",true);
     		
     		aClone.find("option[selected]").removeAttr("selected")
     		
     		aClone.find("td:eq(0)").find(":input").css('border', '1px solid #ced4da');
     			aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly",false);
			//aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(2)").find("input:eq(0)").removeAttr("readonly",false);
			//aClone.find("td:eq(3)").find(":selected").removeAttr("selected",false);
			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr('readonly',false);
			aClone.find("td:eq(4)").find("input:eq(0)").removeAttr("readonly",false);
			aClone.find("td:eq(5)").find("input:eq(0)").removeAttr("readonly",false);
			aClone.find("td:eq(6)").find("input:eq(0)").removeAttr("readonly",false);
		
     		
			aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(1)").find("select:eq(0)").removeAttr('disabled',false);
			aClone.find("td:eq(2)").find("input:eq(0)").removeAttr("disabled",false);
			//aClone.find("td:eq(3)").find(":selected").removeAttr("selected",false);
			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr('disabled',false);
			aClone.find("td:eq(4)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(5)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(6)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(10)").find("button:eq(0)").removeAttr("disabled",false);
			
			//aClone.find("checkbox").removeAttr("checked",false);
			//aClone.find("td:eq(7)").find("input:eq(0)").removeAttr("disabled",false);
				
			
		
			var addButton="";
			var removeButton="";
			addButton = ' <button name="Button" type="button"';
			addButton += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addNomenclatureRowRecall();"';
			addButton += '	tabindex="1" > </button> ';

			removeButton = ' <button type="button" name="delete" id="newIdTre" button-type="delete" value=""';
			removeButton += 'class="buttonDel btn btn-danger noMinWidth"';
			removeButton += '	onclick="removeRowInvestigation(this,0,0);"';
			removeButton += '	tabindex="1" ></button> ';
      		aClone.find("td:eq(11)").html(addButton);
    		aClone.find("td:eq(12)").html(removeButton);
    		aClone.find("td:eq(12)").find("button:eq(0)").removeAttr("disabled",false);
    		aClone.find("td:eq(14)").find(":input").prop('id', 'itemClassId'+countRecall+'');
			aClone.clone(true).appendTo('#nomenclatureGrid');
     		$('#nomenclatureGrid>tr:last').find("td:eq(12)").find('button:eq(0)').attr("id","newIdTre");
     	}
      
     
      
     
        </script>


	<div class="modal " id="messageDelete"  role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblDeleteInvestigation" /></span>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						<div class="">
							<p class="message_text">Please add first another
								Investigation.</p>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeDelete();" aria-hidden="true">Close</button>
				</div>
			</div>
		</div>
	</div>



	<div class="modal" id="messageForAuthenticate" role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblUHIDNumber" /></span>

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
											placeholder="" value="" />
									</div>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal" id="okButtonOfAuthenticate" 
						onClick="callToAutheniticate();" aria-hidden="true"><spring:message code="btnOK"/></button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeMessage();" aria-hidden="true"><spring:message code="btnClsoe"/></button>
				</div>
			</div>
		</div>
	</div>


 
 
	 <div class="modal" id="modelForCurrentMedication"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblCurrentMedication" /></span>

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
								code="outsideLab" /></span>

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
						<button class="btn btn-primary" data-dismiss="modal"
							onClick="submitMOValidateFormByModel();" id="submitMOValidateFormByModelId" aria-hidden="true">
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
						<button class="btn btn-primary" id="submitTreatmentAlertRecall"  data-dismiss="modal"
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
							<!-- <div style="float: right">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>	 -->		
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Diagnosis</th>
								<!-- <th scope="col">Select</th> -->
								</tr>
								<tbody id="recommendedDiagnosis">
								</tbody>
							</table>
						</div>
                        </div>



					</div>
				</div>
				<div class="modal-footer">
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
							<!-- <div style="float: right">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>	 -->		
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Investgation</th>
								<!-- <th scope="col">Select</th> -->
								</tr>
								<tbody id="recommendedInvestgation">
								</tbody>
							</table>
						</div>
                        </div>



					</div>
				</div>
				<div class="modal-footer">
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
							<!-- <div style="float: right">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>	 -->		
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Treatment</th>
								</tr>
								<tbody id="recommendedTreatment">
								</tbody>
							</table>
						</div>
                       </div>



					</div>
				</div>
				<div class="modal-footer">
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

						<button type="button" onClick="closeMessage();" class="close"
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
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="showdiagLoader();showAllAuditRecommendedDiagnosisRecall('ALL','SearchStatusForUnitAdminCurrentMedication');closeMessage();" aria-hidden="true">
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
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="showinvesLoader();showAllAuditRecommendedInvestigationRecall('ALL','SearchStatusForUnitAdminCurrentMedication');closeMessage();" aria-hidden="true">
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
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="showtreatLoader();showAllAuditRecommendedTreatmentRecall('ALL','SearchStatusForUnitAdminCurrentMedication');closeMessage();" aria-hidden="true">
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
<!-- <div class="modal-backdrop show" style="display:none;"></div> -->		
<!-- ----------------Accordian  end here---------- -->
<script>
	function showdiagLoader(){$('#diagLoader').show();}
	function showinvesLoader(){$('#invesLoader').show();}
	function showtreatLoader(){$('#treatLoader').show();}
	</script>
	
<script type="text/javascript" language="javascript">
            $(document).ready(
            	
            		
                function() {
                	
                	$('#diagLoader').hide();
            		$('#invesLoader').hide();
            		$('#treatLoader').hide();
                });
</script>
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
			    if (data.status == 1) {
				$('#ideal_weight').val(data.data[0].idealWeight);
				$('#ideal_weight').attr("readonly",true);
			    }
			   	   	   else
			   	   		   {
			   	   		   	alert("Ideal Weight Not Configured")
			   	   		   	$('#ideal_weight').val();
							$('#ideal_weight').removeAttr("readonly");
			   	   		   }
			},
			error : function(e) {
			},
			done : function(e) {
				alert("success");
				var datas = e.data;
			}
		});

	 }
	
	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		if(b!=undefined && b!="" && b!=null)
		var c=b/100;
		if(c!=undefined && c!="" && c!=null)
		var d=c*c;
		if(a!=undefined && a!="" && a!=null && d!=undefined && d!="" && d!=null)
		var sub = a/d;
		if(sub!=undefined && sub!="" && sub!=null)
		$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		
	}
	
	function checkObsistyMark() {
		
			if(document.getElementById('variant_in_weight').value== '' && document.getElementById('variant_in_weight').value== undefined)
			{
				alert("Please enter Height and Varation and Weight");
			}
		    
		
		
		
	}
	
	  

	 
	 function checkVaration()  {

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
 		var obsistyCheckAlready=$('#obsistyCheckAlready').val();
 		if(obsistyCheckAlready!="exits")
 		{	
 		var varationWightVal = document.getElementById("variant_in_weight").value;
 		 var varationWightActual='10';
 		 if(document.getElementById("overCheck").checked == true){
 		 if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
 			{	
 				alert("Overweight Cannot be selected as variation in weight is less than 10  ")
 				document.getElementById("overCheck").checked=false;
 				obsistyOverWeight = "";
 				$('#overWeightDropDown').hide();
 				return false;
 			}
 		 }
 		 if(document.getElementById("obsistyCheck").checked == true){
     		 if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
     			{	
     				alert("Obesity Cannot be selected as variation in weight is less than 10  ")
     				document.getElementById("obsistyCheck").checked=false;
     				obsistyOverWeight = "";
     				return false;
     			}
     		 }
        }
      }	
	}
	 
	 
	 
	 function opdUpdateInvestigationTemplate() {
   	  $('#exampleModal .modal-body').load("opdUpdateInvestigationTemplate?employeeId="+<%= userId %>);
         $('#exampleModal .modal-title').text('Update Investigation Template');
     }
	
  </script>
  
  <script type="text/javascript">
 var autoNursingNo = '';
 var nursingItemId = '';
 var nursingCode="";
  var nursingName="";
  var nursingType="";
  var nursingId="";
  var dataNursing='';
  var defaultProcedureValue="";
  

 var procedureArrayData = [];
 var p = "";
 function changeProcedureRadio(defaultProcedureValue){
	 $('#defaultProcedureValue').val(defaultProcedureValue);
	 	p++;
		$('#gridNursing tr').each(function(i, el){
			 var $tds = $(this).find('td')
	        
			 var idFreq=  $($tds).closest('tr').find("td:eq(1)").find("select:eq(0)").attr("id");
		      var idDays=$($tds).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
		        var typeOfProcValue=$tds.eq(3).find(":input").val();//$(typeOfProc).val();
		if(defaultProcedureValue=="M")
		{
			 document.getElementById(idFreq).disabled = true;
			 document.getElementById(idDays).disabled = true;
		}
		else
		{
					if(typeOfProcValue=='M')
					{
					document.getElementById(idFreq).disabled = true;
					 document.getElementById(idDays).disabled = true;
					}
					else
						{
			 				document.getElementById(idFreq).disabled = false;
			 				document.getElementById(idDays).disabled = false;
						}
		} 
		});       
	 }
 
 
 
 function changeProcedureRadio1(defaultProcedureValue){
 	p++;
 	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getMasNursingCare";
	$('#gridNursing tr').each(function(i, el){
		 var $tds = $(this).find('td')
        
		 var idFreq=  $($tds).closest('tr').find("td:eq(1)").find("select:eq(0)").attr("id");
	      var idDays=$($tds).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
	      
	      //var typeOfProc=$($tds).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
	        //var idDays= $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
	        var typeOfProcValue=$tds.eq(3).find(":input").val();//$(typeOfProc).val();
	if(defaultProcedureValue=="M")
	{
		
		 document.getElementById(idFreq).disabled = true;
		 document.getElementById(idDays).disabled = true;
		
	}
	else
	{
		
				if(typeOfProcValue=='M')
				{
				document.getElementById(idFreq).disabled = true;
				 document.getElementById(idDays).disabled = true;
				}
				else
					{
		 				document.getElementById(idFreq).disabled = false;
		 				document.getElementById(idDays).disabled = false;
					}
	} 
	});       
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify({
			'nursingType' : defaultProcedureValue
		}),
		dataType : 'json',
		timeout : 100000,
		
		success : function(res)
		
		{
			dataNursing = res.data;
			autoNursingNo=res.data;
			
			var aProcedure="";
			var valProcedureCare="";
			procedureArrayData=[];
			arryProcedureCare=[];
			for(var i=0;i<dataNursing.length;i++){
				  nursingCode= dataNursing[i].nursingCode;
				  nursingName=dataNursing[i].nursingName;
				  nursingType = dataNursing[i].nursingType;
				  nursingId = dataNursing[i].nursingId;
				  aProcedure=nursingName+"["+nursingCode +"]";
			
				//procedureArrayData.push(aProcedure);
				arryProcedureCare.push(aProcedure);
				$j('#ChangeMasProcedureCare').val('');
				//   valProcedureCare=$('#gridNursing').children('tr:last').children('td:eq(0)').find(':input')[0]
		        // autocomplete(valProcedureCare, procedureArrayData); 
				//console.log('ChangeMasProcedureCare :',procedureArrayData);
				
				
				
			}

 		
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
 }
 
 function populateNursingRecall(val, inc,item) {
	    
		if (val != "") {
			var index1 = val.lastIndexOf("[");
			var indexForBrandName = index1;
			var index2 = val.lastIndexOf("]");
			index1++;
			nursingNo = val.substring(index1, index2);
			var indexForBrandName = indexForBrandName--;
			var brandName = val.substring(0, indexForBrandName);
			// alert("pvms no--"+pvmsNo)
			
			if (nursingNo == "") {
				// alert("pvms no1111--"+pvmsNo)
				// document.getElementById('nomenclature' + inc).value = "";
				// document.getElementById('pvmsNo' + inc).value = "";
				return false;
			} else {
				 //document.getElementById('procedureNameNursingCare').value = nursingNo
				 var nursingItemIdValue= '';
				 var nursingValue = '';
				 var nursingType = '';
				 for(var i=0;i<autoNursingNo.length;i++){
						  
						  var nursingC = dataNursing[i].nursingCode;
						  if(nursingC == nursingNo){
							  nursingValue = dataNursing[i].nursingId;
							  nursingType = dataNursing[i].nursingType;
							  var checkCurrentRowIdProcedure=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
			        		  var checkCurrentRowProcedure=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
			        		  $('#gridNursing tr').each(function(i, el) {
			        			   var $tds = $(this).find('td')
	        	  			       var itemIdCheckProcedure=  $($tds).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
	        	     			   var itemIdValueProcedure=$('#'+itemIdCheckProcedure).val();
	        	     			   var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
	        	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	        	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
	        	     			   if(itemIdCheckProcedure!=checkCurrentRowIdProcedure && nursingValue==itemIdValueProcedure)	   
	          			           {
	        	     				 if(nursingValue==itemIdValueProcedure){
	        	      			        $('#'+idddd).val("");
	        	      			        $('#'+currentidddd).val("");
	        	      			        alert("Procedure is already added");
	        	      			        return false;
	        	     				   
	          			           }
	          			           }
	        	     			   else
	        	     				{   
					 
	        	     				  $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(nursingValue)
	        	     				  //$(nursingItem).closest('tr').find("td:eq(4)").find(":input").val(nursingValue)
	        	     				  $(item).closest('tr').find("td:eq(3)").find(":input").val(nursingType)
					                
	        	     				}
			        		  
						  }); 
				    }
				 }
				 return true;
			}

		} else {
			return false;
		}
	}

 function showEHRRecords() {
	 checkForAuthen =$("#checkForAuthenticationValue").val();
	 uhidNumberValue =$("#uhidNumberValue").val();
	  var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/ehr/patientSummary?patientId=";
	var userIdd = <%= userId %>;
if(uhidNumberValue=="success"){
   window.open(url+$('#patientId').val()+"&userId="+userIdd+"");
	 }
else{
	if(checkForAuthen=="popUpShow"){
		 $("#messageForAuthenticate").show();	  
		 $('.modal-backdrop').show()
	 	}
	 else{
		 window.open(url+$('#patientId').val()+"&userId="+userIdd+"");
	 } 
}
	
}
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
	 $('.modal-backdrop').show();
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



 var today="";
 var dateCheck=$('#investigationDate').val();
 if(dateCheck==null || dateCheck==""){
 $(document).ready(function() {
   today = new Date();
 var dd = String(today.getDate()).padStart(2, '0');
 var mm = String(today.getMonth() + 1).padStart(2, '0'); 
 var yyyy = today.getFullYear();

 //today =  yyyy + '-' + mm + '-' +dd;
  today = dd + '/' + mm + '/' +yyyy;
 //document.write(today);
 $('#investigationDate').val(today);
 });
 }
 
 var nPageNo=1;
 var Status;
 var $j = jQuery.noConflict();
 
 
 var hsId=<%=hospitalId%>;
 
 
 var autoIcdCode = '';
 var icdData= '';	 
  var idIcdNo = '';
  var icdValue = '';
  var multiIcdValue=[];
 
 var total_icd_value = '';
 var digaoReferal='';   
 function fillDiagnosisCombo2(val,items) {
 	  
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
         /* for (var i = 1; i < obj.length; i++) {
				
             var val1 = obj.options[i].value;
             
             if (idIcdNo == val1) {
             	alert("ICD  Already taken");
                 document.getElementById('icd').value = ""
                 b = true;
             }

         }
        */
         for(var i=0;i<autoIcdCode.length;i++){
      		  
      		  var icdNo1 = icdData[i].icdCode;
      		 
      		  if(icdNo1 == idIcdNo){
      			icdValue = icdData[i].icdId;
      			digaoReferal=icdValue;
      			
      			 $("#diagnosisId option").each(function()
                  {
      				 var icdValuesNew=$(this).val();
      				 var icdArrays=icdValuesNew.split("&&&");
      			
                  		  if(icdArrays[0]==icdValue){
                  		    alert("ICD diagnosis is already added");
                  			var icdIds= $(items).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id"); 
                  		   $('#'+icdIds).val("");
                  		 	 document.getElementById('icd').value = ""
                  		    b=true;
                  		    }
                  		});
      		  }
      	  }
         if (b == "false") {
             $('#diagnosisId').append('<option value=' + icdValue + '>' + val + '</option>');
             multiIcdValue.push(icdValue);
             document.getElementById('icd').value = ""
             	
             var checkedReferValue="";
             	$('input:radio[name=referTo]').each(function(){
             		var checkedValue = $(this);
             		
             		if(checkedValue.is(':checked')){
             			if(checkedValue.val()=='I'){
             				checkedReferValue='internal';
             			}
             			else{
             				checkedReferValue='external';
             			}
             		}
             	});
         }
     }
     $('#icdIdValue').val(multiIcdValue);
 }
 
 function fillReferalDiagnosisVal2(item)
 {
//  var val= $(item).closest('tr').find("td:eq(7)").find(":input").val(digaoReferal)
  $(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(digaoReferal);
 }
 
 
 function showUploadDocument() {  
	 
	 var userCountVal=$('#usersCounts').val();
	 if(userCountVal=="0")
	 {	 
	 checkForAuthen =$("#checkForAuthenticationValue").val();
	 }
	 uhidNumberValue =$("#uhidNumberValue").val();
	 if(uhidNumberValue=="success" ||userCountVal!="0"){
	     /* popup = window.open("showPreveiousLab?patientId="+$('#patientId').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
	     popup.focus(); */
	     $("#messageForAuthenticate").hide();
		 $('.modal-backdrop').hide();
		 $('#exampleModal').show();
		 $('.modal-backdrop').show();
	     $('#exampleModal .modal-body').load("opdUploadDocument?patientId="+$('#patientId').val());
         $('#exampleModal .modal-title').text('View Patient Documents');
	     
		 }
		 else{
			 if(checkForAuthen=="popUpShow"){
				 $("#messageForAuthenticate").show();
				 $('.modal-backdrop').show();
			 	}
			 else{
				 $("#messageForAuthenticate").hide();
				 $('.modal-backdrop').hide();
				 $('#exampleModal').show();
				 $('.modal-backdrop').show();
				 $('#exampleModal .modal-body').load("opdUploadDocument?patientId="+$('#patientId').val());
                 $('#exampleModal .modal-title').text('Documnet Upload');

			 } 
		 }
}
 
 var obsistyOverWeight='';
 function overWeight_old(radioValue)
 {
 	
 	
 	 //var text = document.getElementById("text");
 	 if(document.getElementById("obsistyCheck").checked == true){
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').hide();
 	  } 
 	if(document.getElementById("noneCheck").checked == true){
		 obsistyOverWeight = radioValue; 
		 $('#overWeightDropDown').hide();
	  }
 	 if(document.getElementById("overCheck").checked == true){
 		if(document.getElementById('height').value == "" || document.getElementById('weight').value == "")
  		{	
  		alert("please enter height and weight")
  		document.getElementById("overCheck").checked=false;
  		return false;
  		}
 		else
 		{	
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').show();
 		 var a = document.getElementById("variant_in_weight").value;
 		 var b='20';
 		 if(parseFloat(b) > parseFloat(a))
 		 {
 			
 			 document.getElementById("under20").selected=true;	 
 		 }
 		 else
 		 {
 			 document.getElementById("above20").selected=true;	 
 		 } 
 		}
 	  }
 		
 }

 
 var obsistyOverWeight='';
 /*function overWeight(radioValue)
 {
 	 var varationWightVal = document.getElementById("variant_in_weight").value;
 	 var varationWightActual='10';
 	 //var text = document.getElementById("text");
 	 
 	if(radioValue=='N'){
		 $('#ObesityId').addClass('font-bold');
		 $('#obsistyCheck').removeAttr('disabled');
	 }

	 if(radioValue=='Y'){
		 $('#OverweightId').addClass('font-bold');
		 $('#overCheck').removeAttr('disabled');
	 }
	 
	 if(radioValue=='A'){
		 $('#NoneId').addClass('font-bold');
		 $('#noneCheck').removeAttr('disabled');
		 $('#overWeightDropDown').removeAttr('disabled');
	 }
 	 if(document.getElementById("obsistyCheck").checked == true){
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').hide();
 	  }
 	 if(document.getElementById("noneCheck").checked == true){
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').hide();
 	  }
 	 if(document.getElementById("overCheck").checked == true){
 		if(document.getElementById('variant_in_weight').value == "")
 	 	{	
 			
 			$('#overWeightDropDown').hide();
 	 	alert("Overweight Cannot be selected as variation in weight is less than 10")
 	 	document.getElementById("overCheck").checked=false;
 	 	$('#obsistyMark').val("");
 	 	return false;
 	 	}
 			
 		else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
 		{	
 			$('#overWeightDropDown').hide();
 			alert("Overweight Cannot be selected as variation in weight is less than 10")
 			document.getElementById("overCheck").checked=false;
 			$('#obsistyMark').val("");
 			return false;
 		}
 		
 		else
 		{	
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').show();
 		 var a = document.getElementById("variant_in_weight").value;
 		 var b='20';
 		 if(parseFloat(b) > parseFloat(a))
 		 {
 			
 			 document.getElementById("under20").selected=true;	 
 		 }
 		 else
 		 {
 			 document.getElementById("above20").selected=true;	 
 		 } 
 		}
 	  }
 	
 	 if(document.getElementById("obsistyCheck").checked == true){
 			if(document.getElementById('variant_in_weight').value == "")
 	 		{	
 				$('#overWeightDropDown').hide();
 				alert("Obesity Cannot be selected as variation in weight is less than 10")
 	 		document.getElementById("obsistyCheck").checked=false;
 				$('#obsistyMark').val("");
 	 		return false;
 	 		}
 			
 			else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
 			{	
 				$('#overWeightDropDown').hide();
 				alert("Obesity Cannot be selected as variation in weight is less than 10")
 		 		document.getElementById("obsistyCheck").checked=false;
 				$('#obsistyMark').val("");
 		 		return false;
 			}
 		  }
 		
 }*/
 
 
 function overWeight(radioValue)
 {
 	 var varationWightVal = document.getElementById("variant_in_weight").value;
 	 var varationWightActual='10';
 	 //var text = document.getElementById("text");
 	
 	 if(document.getElementById("obsistyCheck").checked == true){
 		 document.getElementById("obsistyCheckText").style.font = "bold 15px Arial, serif";
 		 document.getElementById("overCheckText").style.fontSize ="inherit";
 		 document.getElementById("noneText").style.fontSize ="inherit";
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').hide();
 	  }
 	 if(document.getElementById("noneCheck").checked == true){
 		 document.getElementById("noneText").style.font = "bold 15px Arial, serif"; 
 		 document.getElementById("overCheckText").style.fontSize ="inherit";
 		 document.getElementById("obsistyCheckText").style.fontSize ="inherit";
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').hide();
 	  }
 	 if(document.getElementById("overCheck").checked == true){
 		 document.getElementById("overCheckText").style.font = "bold 15px Arial, serif"; 
 		 document.getElementById("noneText").style.font = "inherit"; 
 		 document.getElementById("obsistyCheckText").style.fontSize ="inherit";
 		if(document.getElementById('variant_in_weight').value == "")
 	 	{	
 			$('#overWeightDropDown').hide();
 	 	alert("Overweight Cannot be selected as variation in weight is less than 10")
 	 	document.getElementById("overCheck").checked=false;
 	 	document.getElementById("overCheckText").style.fontSize ="inherit";
 	 	return false;
 	 	}
 			
 		else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
 		{	
 			$('#overWeightDropDown').hide();
 			alert("Overweight Cannot be selected as variation in weight is less than 10")
 			document.getElementById("overCheck").checked=false;
 			document.getElementById("overCheckText").style.fontSize ="inherit";
 			return false;
 		}
 		
 		else
 		{	
 		 obsistyOverWeight = radioValue; 
 		 $('#overWeightDropDown').show();
 		 var a = document.getElementById("variant_in_weight").value;
 		 var b='20';
 		 if(parseFloat(b) > parseFloat(a))
 		 {
 			
 			 document.getElementById("under20").selected=true;	 
 		 }
 		 else
 		 {
 			 document.getElementById("above20").selected=true;	 
 		 } 
 		}
 	  }
 	
 	 if(document.getElementById("obsistyCheck").checked == true){
 			if(document.getElementById('variant_in_weight').value == "")
 	 		{	
 				$('#overWeightDropDown').hide();
 	 		alert("Obesity Cannot be selected as variation in weight is less than 10  ")
 	 		document.getElementById("obsistyCheck").checked=false;
 	 		document.getElementById("obsistyCheckText").style.fontSize ="inherit";
 	 		return false;
 	 		}
 			
 			else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
 			{	
 				$('#overWeightDropDown').hide();
 				alert("Obesity Cannot be selected as variation in weight is less than 10  ")
 		 		document.getElementById("obsistyCheck").checked=false;
 				document.getElementById("obsistyCheckText").style.fontSize ="inherit";
 		 		return false;
 			}
 		  }
 }
 
 
 getSpecialistList() ;
 
 function getWardDepartment() {

		var params = {
			
		}
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var urlDept = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/ward/getWardDepartment";
		$.ajax({
					type : "POST",
					contentType : "application/json",
					url : urlDept,
					data : JSON.stringify(params),
					dataType : "json",
					cache : false,
					success : function(msg) {
						if (msg.status == '1') {

							var comboval = '';
							var selectedVal="";
							var wardDeparId=$('#wardDepartmentIdTemp').val();
							for (var i = 0; i < msg.departmentList.length; i++) {

								if(wardDeparId==Object.keys(msg.departmentList[i])){
									selectedVal='selected';
								}
								else{
									selectedVal="";
								}
								comboval += '<option '+selectedVal+' value=' + Object.keys(msg.departmentList[i]) + ' >'
										+ Object.values(msg.departmentList[i])
										+ '</option>';

							}
							$('#wardDepartmentId').append(comboval);

						}

					},

					error : function(msg) {

						alert("An error has occurred while contacting the server");

					}
				});
	}
		
 getWardDepartment();
 
 

 $(document).on('click','#exampleModal button[data-dismiss="modal"]',function(){
 	closeModal();
 });

 function closeModal(){
 	 $('#exampleModal').hide();
 	 $('.modal-backdrop').hide();
 	 $('#exampleModal .modal-body').empty();
 }
 
 
 function showImmunizationTemplate() {
	var patientId=$('#patientId').val();
	var visitId=$('#visitId').val();

	 $('#exampleModal .modal-body').load("showImmunizationTemplate?employeeId="+<%= userId %>+"&patientId="+patientId+"&visitId="+visitId);
     $('#exampleModal .modal-title').text('Immunization History');
}

 function showAlleryHistoryTemplate() {
		var patientId=$('#patientId').val();
		var visitId=$('#visitId').val();

		 $('#exampleModal .modal-body').load("showAlleryHistoryTemplate?employeeId="+<%= userId %>+"&patientId="+patientId+"&visitId="+visitId);
	     $('#exampleModal .modal-title').text('Allergy History');
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
 
 function createEmpanlledMaster() {
     <%-- popup = window.open("opdEmpanlledMaster?employeeId="+<%= userId %>+"", "popUpWindow", "height=500,width=900,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes"); --%>
     // popup.focus();
      
      $('#smallModal .modal-body').load("opdEmpanlledMaster?employeeId="+<%= userId %>);
      $('#smallModal .modal-title').text('Empanelled Hospital Masters');
  }
 
 function createProcedureMaster() {
     <%-- popup = window.open("createProcedureMasters?employeeId="+<%= userId %>+"", "popUpWindow", "height=500,width=900,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
     popup.focus(); --%>
     var radioValue = document.querySelector('input[name = "procedureRadioName"]:checked').value;
     $('#smallModal .modal-body').load("createProcedureMasters?employeeId="+<%= userId %>+"&radioValue="+radioValue);
     $('#smallModal .modal-title').text('Procedure Masters');
 }
 function refershEmpanlledMaster() {
		
		getEmpanelledHospital();
	}
 
 
 function resetFormRecall(){
	 location.reload();
 }
 
 
 
 function deleteDgItems() {
 	var deleteDiagnosis = document.getElementById('diagnosisId');
    if (deleteDiagnosis.selectedIndex == -1)
 	   {
 	       alert("Please select atleast one diagnosis")
 	       return false;
 	   }
 	   else
 		   {
     		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {

                    if (document.getElementById('diagnosisId').options[document.getElementById('diagnosisId').selectedIndex].value != null)
                        document.getElementById('diagnosisId').remove(document.getElementById('diagnosisId').selectedIndex)

                }
 		   }
 	
     
 }
 
 function viewEcgDocumnt()
	{
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var urlEcg = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/viewEcgDocument";
		var visitIdVal= $('#visitId').val();
		 $.ajax({
             type: "POST",
             contentType: "application/json",
             url: urlEcg,
             data: JSON.stringify({
                 'visitId': visitIdVal
             }),
             dataType: 'json',
             timeout: 100000,
             success: function(res) {
         	 
            	 var data = res.ecg;
            	 var ecgImage='';
     			if (data != '') {
     				//window.open(data.ecgDocument,'_blank');
     				openPdfModel(data.ecgDocument);
     			} else {
     				ecgImage = 'Not Available'
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

	}
 

 
 
//Function to check if expiry date is within 3 months from now
 function isExpiryWithinThreeMonths(expiryDateStr) {
    if (!expiryDateStr || expiryDateStr.trim() === '') {
        console.log("Expiry date is blank.");
        return false;
    }
    
    // Format: '31/03/2025' -> dd/mm/yyyy
    const expiryDateArr = expiryDateStr.split('/'); // Split the date string into day, month, year
    
    // Correctly construct a Date object (year, month, day)
    const expiryDate = new Date(expiryDateArr[2], expiryDateArr[1] - 1, expiryDateArr[0]); // Month is 0-indexed (Jan is 0, Feb is 1, etc.)

    // Get today's date
    const today = new Date();

    // Get the date 3 months from today
    const threeMonthsLater = new Date(today);
    threeMonthsLater.setMonth(today.getMonth() + 3);
    
    console.log("expiryDateStr=" + expiryDateStr);
    console.log("expiryDate=" + expiryDate);
    console.log("threeMonthsLater=" + threeMonthsLater);

    // Compare the expiry date with today's date and 3 months from now
    if (expiryDate <= threeMonthsLater && expiryDate >= today) {
            
        return true;
    } else {
       
        return false;
    }
}




 </script>
 
 


<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

</body>

</html>

