<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

                    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
                            <!DOCTYPE html>
                            <html lang="en">

                            <head>
                                <meta charset="utf-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>AFMSM-15 CheckList(MO Validate)</title>
                                <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
                                <meta content="Coderthemes" name="author" />
                                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                                <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalexam.js"></script>
<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
%>
                            </head>

                            <body>
                                <div>

                                    <form name="frm">
                                        <div>
                                            <!-- Start content -->
                                            <div class="col-md-4">
                                                <div id="successmsg" style="color:green; align:center;">
                                                    ${message}
                                                </div>
                                            </div>
                                            <div class="">

                                                <div class="container-fluid">
                                                    

                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div>
                                                                <div >
                                                                   
                                                                   
								    <input type="hidden" name="visitIdModal" id="visitIdModal" value=""/>
									<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
									<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
									<input type="hidden" name="patientIdModal" id="patientIdModal" value=""/>	
									<input type="hidden" name="genderId" id="genderId" value=""/>	
									<input type="hidden" name="saveInDraft" id="saveInDraft" value="draftMo"/>		
									<input type="hidden" name="opdPatientDetailId" id="opdPatientDetailId" value=""/>	
									<input type="hidden" name="referTo" id="referTo" value="E"/>  
                                                                    <div class="row">
                                                                        <h4 class="service_htext" style="border:none;"></h4>
                                                                   

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Name </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="empNameModalV" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Service No.</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="serviceNoModal" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Rank</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="rankModal" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">unit</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="unitModal" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                  
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">DOB </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="dobModal" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Age </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="ageModal" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Gender </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="genderModal" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                     
                                                                    </div>
																	
																	<div class="row">
																		<div class="col-12 m-t-10">
																			<h6 class="font-weight-bold text-theme"> Present Medical Category (Composite)</h6>
																		</div>
																	</div>
                                                                    
                                                                    <table class="table table-hover table-striped table-bordered">
                                                                        <thead class="bg-success" style="color: #fff;">
												<tr>
													<th id="th1">Medical Category</th>
													<th id="th2">Date of Category</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input id="medicalCompositeNameModal" type="text" class="form-control"></td>
													<td><input id="medicalCompositeDateModal" type="text" class="form-control"></td>

												</tr>

											</tbody>
                                          </table>
																	
																	<div class="row">
																		<div class="col-12 ">
																			<h6 class="font-weight-bold text-theme"> Details of Present & Previous Disabilities</h6>
																		</div>
																	</div>
                                                                   
                                                                    <div class="table-responsive">
                                                                        <table class="table table-hover table-striped table-bordered">
                                                                            <thead class="bg-success" style="color:#fff;">
													<tr>
													   <th id="th1" style="width: 25px;">Select</th>
														<th id="th2" style="width: 275px;">Diagnosis</th>
														<th id="th3" style="width: 80px;">System</th>
														<th id="th4">Medical Category</th>
														<th id="th5">Type of Category</th>
														<th id="th6">Category Date</th>
														<th id="th7" style="width: 80px;">Duration</th>
														<th id="th8">Next Category Date</th>
													</tr>
												</thead>
												<tbody id="medicalCategoryEmp">
                                                                                <tr>
                                                                                    <td>
                                                                                        <div class="form-check form-check-inline cusCheck">
                                                                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="">
                                                                                            <span class="cus-checkbtn"></span> 
                                                                                         </div>
                                                                                    </td> 
                                                                                    <td>
                                                                                        <div class="autocomplete">
                                                                                        <input type="text" class="form-control" id="diagnosisIdMedical" onblur="fillDiagnosisComboMedical(this.value,this);" placeholder="Diagnosis" />
                                                                                        </div>
                                                                                         </td>
                                                                                        
                                                                                    <td>
                                                                                        <input type="text" class="form-control"> </td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control">
                                                                                    </td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control"> </td>
                                                                                    <td>
                                                                                       <div class="dateHolder">
																	                    <input type="text" id="diagnosisDate" 
																	                     name="diagnosisDatesssss" class="input_date form-control" 
																	                     placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                    </td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control"> </td>
                                                                                    <td>
                                                                                         <div class="dateHolder">
																	                    <input type="text" id="nextDiagnosisDate" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                       </td>
                                                                                      <td style="display: none";><input type="hidden"
																						value="" tabindex="1" id="diagnosisIdval" size="77"
																						name="diagnosisIdval" />
																					</td>										  
												  </tr>	
												  												  
												</tbody>											
											</table>
                                       </div>

									<!-- -----  Requirement & periodicty of review  start here --------- -->	
									
							   <div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
									<div class="titleBg" style="width: 520px; float: left;">
										<span>Requirement & periodicty of review </span>
									</div>
									<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton1" value="-" onclick="showhide(this.id)" type="button">
								</div> 
							
							  <div class="hisDivHide p-10" id="newpost1" style="display:block">		
							  					      
							      <div class="row">											
											<table class="table table-hover table-striped table-bordered">                                       
			                                         
			                                      <tbody  id="requirement">                                      
			                                      
				                                        
			                                        </tbody>     
			                                         
			                                    </table>											
										</div>
							      
								</div>
								
								<!-- -----  Requirement & periodicty of review   end here --------- -->	
																
									 
								
							<!-- -----  Recommendations on posting   start here --------- -->
									
							       <div class="adviceDivMain" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Recommendations on posting  </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton2" value="-" onclick="showhide(this.id)" type="button">
									</div>	
								
								
								      <div class="hisDivHide p-10" id="newpost2" style="display:block">
								      
							                  
							                  
							                  
							             <div class="row">											
											<table class="table table-hover table-striped table-bordered">                                       
			                                         
			                                      <tbody  id="recommendation_posting">     
			                                 
			                                         </tbody>     
			                                         
			                                    </table>											
										</div>
							                  
							                  
							                  
							                  
							                  
      
		
	                                 </div>
	
	
                          <!-- -----  Recommendations on posting   end here --------- -->





<!-- ----- Employability Restrictions start here --------- -->		

    <div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 620px; float: left;">
			<span>Employability Restrictions: General ( Please input 'Y' if individual can performa a duty, 'N in case he cannot')  </span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton3" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost3">
      
      	<div class="row">
      	
      	
      	<table class="table table-hover table-striped table-bordered">                                       
			                                         
			                                      <tbody  id="employabilityRestrictions"> 
			                                      
			                                      
			                                        </tbody>     
			                                         
			                                    </table>	
      	
      	 
      	
      	
							

		</div>
      
      
			
	</div>


<!-- ----- Employability Restrictions end here --------- -->	





  <!-- ----- Employability Restrictions (Psychiatric Conditions)  start here --------- -->

   

   <div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Employability Restrictions: 'S' Factor (Psychiatric Conditions) </span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton4" value="+" onclick="showhide(this.id)" type="button">
	</div>	





      <div class="hisDivHide p-10" id="newpost4">      
      
      	<div class="row">
         

                                    <table class="table table-hover table-striped table-bordered">                                       
			                                         
			                                      <tbody  id="psychiatric">   
			                                      
			                                      
	                                        </tbody>
	                                        
	                                    </table>
 
									</div> 
								</div>
							<!-- ----- Employability Restrictions (Psychiatric Conditions) end here --------- -->




								<!-- ----- Employability Restrictions  H Factor start here --------- -->

										<div class="adviceDivMain" id="button5"
											onclick="showhide(this.id)">
											<div class="titleBg" style="width: 520px; float: left;">
												<span> Employability Restrictions: 'H' Factor
													(Hearing Factor-Ear)</span>
											</div>
											<input class="buttonPlusMinus" tabindex="1" name=""
												id="relatedbutton5" value="+" onclick="showhide(this.id)"
												type="button">
										</div>


										<div class="hisDivHide p-10" id="newpost5">


											<div class="row">

												<table class="table table-hover table-striped table-bordered">

													<tbody id="h-factor">

													</tbody>
												</table>


											</div>

										</div>

										<!-- ----- Employability Restrictions  H Factor  end here --------- -->
								
								
								
								
								<!-- ----- Employability Restrictions Appendages  start here --------- -->


									 <div class="adviceDivMain" id="button6" onclick="showhide(this.id)">
											<div class="titleBg" style="width: 520px; float: left;">
												<span> Employability Restrictions: 'A' Factor (Appendages factor - limbs)</span>   
												
										  </div>		
											<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton6" value="+" onclick="showhide(this.id)" type="button">
										</div>	
									
									
						 <div class="hisDivHide p-10" id="newpost6">									      
									 <div class="row">
									      
									          <table class="table table-hover table-striped table-bordered">                                      
			                                       <thead  id="appendages">   
									                   <tr id="activity">                                    
					                                        <th class="ques_width">
					                                             <b class="ques_th_txt">Activity</b>
					                                         </th>
					                                          <th class="ques_drop">		                                           
					                                                <b class="ques_th_txt">Permitted or Not</b>  									 
															</th> 
															
															<th></th>	
															<th></th>								
				                                        </tr> 
				                                     </thead>
				                                     
				                                     <tbody id="aAppendagesFactor">
				                                     	<tr>
				                                     	
				                                     		<td></td>
				                                     		<td></td>
				                                     		<td><button type="button" name="add"   id="a_factor-add"   onclick="addAppendagesRestrictionsAFactor()" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" ></button></td>
														    
														    <td></td>
														    
				                                     	</tr>
				                                     </tbody>
				                              </table> 
													
										</div>			 
	                      </div>
	                      
	                      
	                    <!-- ----- Employability Restrictions Appendages  end here --------- -->
								
								
								
								<!-- ----- Employability Restrictions (Physical Factor)  start here --------- -->
	
								 <div class="adviceDivMain" id="button7" onclick="showhide(this.id)">
									<div class="titleBg" style="width: 520px; float: left;">
										<span>Employability Restrictions: 'P' Factor (Physical Factor)
								   </div>
									    <input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton7" value="+" onclick="showhide(this.id)" type="button">
								   	
							   </div>
							
							      <div class="hisDivHide p-10" id="newpost7">						      
							      
							             <div class="row">						      
							      
							      		      
                                            <table class="table table-hover table-striped table-bordered">                                       
			                                         
			                                      <tbody  id="p-factor">             
			                                  
			                                       </tbody>
			                                    </table>

								

									</div>
     
		 
					</div>
					<!-- -----Employability Restrictions (Physical Factor)   end here --------- -->
								
								
								
								<!-- -----Employability Restrictions: 'E' Factor (Eye Factor)   start here --------- -->


						      <div class="adviceDivMain" id="button8" onclick="showhide(this.id)">
								<div class="titleBg" style="width: 520px; float: left;">
									<span> Employability Restrictions: 'E' Factor (Eye Factor)</span>
								</div>
								<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton8" value="+" onclick="showhide(this.id)" type="button">
							</div>	
						
						
						      <div class="hisDivHide p-10" id="newpost8"> 
						       <div class="row">						      
							      
							      		      
                                    <table class="table table-hover table-striped table-bordered">                                       
			                                         
			                                      <tbody  id="eye_factor">             
			                                      
				                                  </tbody>
				                             </table> 
					         </div>     	
					       
						</div>
						<!-- -----Employability Restrictions: 'E' Factor (Eye Factor)   end here --------- -->
								
								
								
					<!-- -----Employability Restrictions:Specific to Aviation Cadre   start here --------- -->
						
					      <div class="adviceDivMain" id="button9" onclick="showhide(this.id)">
							<div class="titleBg" style="width: 520px; float: left;">
								<span> Employability Restrictions:Specific to Aviation Cadre </span>
							</div>
							<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton9" value="+" onclick="showhide(this.id)" type="button">
						</div>	
					
					
							      <div class="hisDivHide p-10" id="newpost9">
							            <div class="row">					      		      
		                                    <table class="table table-hover table-striped table-bordered">                                       
					                                         
			                                      <tbody  id="aviation_cadre">             
			                                      
				                                        
				                                     </tbody>
				                              </table>
				                          </div>				                       
								  </div>
 
			        	<!-- -----Employability Restrictions:Specific to Aviation Cadre   end here --------- -->
				
				
				
							<!-- -----Employability specific to Divers/Submariners   start here --------- -->
	
							 <div class="adviceDivMain" id="button10" onclick="showhide(this.id)">
								<div class="titleBg" style="width: 520px; float: left;">
									<span>Employability specific to Divers/Submariners  </span>
									
								</div>
								<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton10" value="+" onclick="showhide(this.id)" type="button">
							</div> 
						     <div class="hisDivHide p-10" id="newpost10">
						     
						               <div class="row">					      		      
		                                    <table class="table table-hover table-striped table-bordered">                                       
					                                         
			                                      <tbody  id="submariners">             
			                                      
				                                      </tbody>
				                                 </table>
				                        </div>
				                                        
						   
						      
							</div>
							
							<!-- ----- Employability specific to Divers/Submariners  end here --------- -->	
								
		 
								
								
								 
								
								<div class="clearfix"></div>	
						</div>
					 
					 			<div class="row m-t-20">
										<div class="col-12 text-right">
											<input type="button" id="reset" class="btn btn-danger" data-dismiss="modal"
															value="Close"/>		
										 
										</div>
									</div>
					 
					</div>

				</div>
				<!-- container -->

			</div>
			<!-- content -->
			
			<div class="modal " id="messageDelete"  role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

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
			
		</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	<!-- END wrapper -->
<script>
$(document).ready(function() {
  
    var data = ${
        data
    };
    if (data.data[0].serviceNo != null) {
       document.getElementById('serviceNoModal').value = data.data[0].serviceNo;
    }
    if (data.data[0].visitId != null) {
        document.getElementById('visitIdModal').value = data.data[0].visitId;
    }
    if (data.data[0].patientId != null) {
        document.getElementById('patientIdModal').value = data.data[0].patientId;
    }
    if (data.data[0].patientName != null) {
        document.getElementById('empNameModalV').value = data.data[0].patientName;
    }
    if (data.data[0].age != null) {
        document.getElementById('ageModal').value = data.data[0].age;
    }
    if (data.data[0].rank != null) {
        document.getElementById('rankModal').value = data.data[0].rank;
    }
   
    if (data.data[0].unit != null) {
        document.getElementById('unitModal').value = data.data[0].unit;
    }
    if (data.data[0].dob != null) {
        document.getElementById('dobModal').value = data.data[0].dob;
    }
    
    if (data.data[0].gender != null) {
        document.getElementById('genderModal').value = data.data[0].gender;
    }
    if (data.data[0].medicalCategogyName != null) {
        document.getElementById('medicalCompositeNameModal').value = data.data[0].medicalCategogyName;
    }
    if (data.data[0].medicalCategogyDate != null) {
        document.getElementById('medicalCompositeDateModal').value = data.data[0].medicalCategogyDate;
    } 
    getMBPreAssesDetailsData();
    getMbAMSF15CheckListforValidate();
    
    //getMBPreAssesDetailsInvestigationData();
});
   
    function showhide(buttonId)
     {
		 if(buttonId=="button1"){
					test('related'+buttonId,"newpost1");					
		 }else if(buttonId=="button2"){
					test('related'+buttonId,"newpost2");
		 }else if(buttonId=="button3"){
					test('related'+buttonId,"newpost3");
		 }else if(buttonId=="button4"){
					test('related'+buttonId,"newpost4");
		 }else if(buttonId=="button5"){
					test('related'+buttonId,"newpost5");
		 }else if(buttonId=="button6"){
					test('related'+buttonId,"newpost6");
		 }else if(buttonId=="button7"){
					test('related'+buttonId,"newpost7");
		 }else if(buttonId=="button8"){
					test('related'+buttonId,"newpost8");
		 }else if(buttonId=="button9"){
					test('related'+buttonId,"newpost9");
		 }else if(buttonId=="button10"){
					test('related'+buttonId,"newpost10");
		 }else if(buttonId=="button11"){
					test('related'+buttonId,"newpost11");
		 }else if(buttonId=="button12"){
					test('related'+buttonId,"newpost12");
		 }else if(buttonId=="button13"){
					test('related'+buttonId,"newpost13");
		 }else if(buttonId=="button14"){
					test('related'+buttonId,"newpost14");
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
	
	
	$('#addbutton').click(function() {
         var pathname = window.location.pathname;
         var accessGroup = "MMUWeb";
         var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/saveAmsf15CheckList";
         var listofChekListlHD =[];
     		var datacheckListHD1='';
     			
     		$('#requirement tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	 	var checklistValue = $tds.eq(1).find(":input").val();
     	   	     var checklistId = $tds.eq(2).find(":input").val();
     	     	datacheckListHD1={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'RequirementPeriodicty',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD1);
     		});
     		
     		var datacheckListHD2='';
     		$('#recommendation_posting tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	   	    var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD2={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistId':checklistId,
     				'checklistHeaderName':'RecommendationsPosting',
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD2);
     		});
     		
     		var datacheckListHD3='';
     		$('#employabilityRestrictions tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	     	var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD3={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'EmployabilityRestrictions',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD3);
     		});
     		var datacheckListHD4='';
     		$('#psychiatric tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	   	    var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD4={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'SFactor',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD4);
     		});
     		var datacheckListHD5='';
     		$('#h-factor tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	   	    var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD5={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'HFactor',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD5);
     		});
     		
     		var datacheckListHD6='';
     		$('#p-factor tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	     	var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD6={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'PFactor',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD6);
     		});
     		
     		var datacheckListHD7='';
     		$('#eye_factor tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	    	var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD7={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'EFactor',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD7);
     		});
     		
     		var datacheckListHD8='';
     		$('#aviation_cadre tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	   	    var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD8={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'AviationCadre',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD8);
     		});
     		
     		var datacheckListHD9='';
     		$('#submariners tr').each(function(i, el) {
     	   	 	var $tds = $(this).find('td')
     	    	var checklistName = $tds.eq(0).find(":input").val();
     	   	    var checklistValue = $tds.eq(1).find(":input").val();
     	   	    var checklistId = $tds.eq(2).find(":input").val();
     	   		datacheckListHD9={
     				'visitId' : $('#visitIdModal').val(),
     				'patientId' : $('#patientIdModal').val(),
     				'checklistHeaderName':'EmployabilitySpecific',
     				'checklistId':checklistId,
     				'checklistName':checklistName,
     				'checklistValue':checklistValue
     			}
     	  		listofChekListlHD.push(datacheckListHD9);
     		});
     	
         var dataJSON = {

        		 'visitId': $('#visitIdModal').val(),
                 'patientId': $('#patientIdModal').val(),
                 'checkListValue':listofChekListlHD,
                 'hospitalId':<%=hospitalId%>,
   			 	 'userId':<%= userId %>,
            
         }
         $("#addbutton").attr("disabled", true);
         $.ajax({
             type: "POST",
             contentType: "application/json",
             url: url,
             data: JSON.stringify(dataJSON),
             dataType: 'json',
             success: function(msg) {
             	console.log(msg)
                 if (msg.status == 1)
                 {
                	 alert("Employability Restrictions Details Update successfully");
                	 $j('#exampleModal').modal('hide');
                 } 
                 else if(msg.status == 0)
                 {
                  $("#addbutton").attr("disabled", false);	
                  alert(msg.msg)	
                 }	
                 else
                 {
                 	$("#addbutton").attr("disabled", false);
                     alert("Please enter the valid data")
                 }
             },
             error: function(jqXHR, exception) {
             	$("#clicked").attr("disabled", false);
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

     });
	 
	 function getMBPreAssesDetailsInvestigationData() {
			var visitId = $('#visitId').val();
			var patientId=$('#patientId').val();
			var data = {
				"visitId" : visitId,
				"patientId":patientId
			};
			$
					.ajax({
						type : "POST",
						contentType : "application/json",
						url : 'getRefferedOpinionDetails',
						data : JSON.stringify(data),
						dataType : "json",
						// cache: false,

						success : function(response) {
						$("#dgInvetigationGrid tr").remove();	
						var datas = response.listObject;	
						var trHTML = '';
						var i=0;
						console.log(datas);
						$.each(datas, function(i, item) {
							   
							    var investigationName=item.investigationName;
							    var result=item.result;
								
								if(investigationName!=null && investigationName!=undefined)
								{
								trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationName+'" id="chargeCodeName" autocomplete="_off" class="form-control border-input" name="chargeCodeName"  size="44" onblur="populateChargeCode(this.value,1,this);" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode" name="chargeCodeCode" size="10" readonly /></div></td><td><div class="form-group row"><div class="col-md-7"><input type="text" class="form-control" value="'+result+'" id="result"></div><div class="col-md-5"><div class="view_result"><a href="#">View Result</a></div></div></div></td></tr>';	
								//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
								i++;
								}
								
												
				});
						$('#dgInvetigationGrid').append(trHTML);
					}
		    });
		 }
	 
	 function getMBPreAssesDetailsData() {
			investigationGridValue = "investigationGrid";
			var visitId = $('#visitId').val();
			var patientId=$('#patientId').val();
			var data = {
				"visitId" : visitId,
				"patientId":patientId
			};
			$
					.ajax({
						type : "POST",
						contentType : "application/json",
						url : 'getMBPreAssesDetails',
						data : JSON.stringify(data),
						dataType : "json",
						// cache: false,

						success : function(response) {
						$("#medicalCategoryEmp tr").remove();	
						var datas = response.data;	
						var trHTML = '';
						var trHTMLNew = '';
						var i=0;
						console.log(datas);
						$.each(datas, function(i, item) {
							   
							var investigationName=item.inveName;
							var icdName=item.icdName;
							var diagnosisId=item.diagnosisId;
							var system=item.system;
							var medicalCategory=item.medicalCategory;
							var categoryType='';
							var	categoryTypeVal=item.categoryType;
							var mbStatus=item.mbStatus;
							
							if(categoryTypeVal=='P')
							{
							  categoryType='Permanent';	
							}
							if(categoryTypeVal=='T')
							{
							   categoryType='Temporary';
							}	
							var categoryDate=item.categoryDate;
							var duration=item.duration;
							var nextCategoryDate=item.nextCategoryDate;
							var selectCheck=item.applyFor;
							var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"> <span class="cus-checkbtn"></span> ';
							var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
							if(selectCheck=='Y')
							{
								 checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked disabled="true"> <span class="cus-checkbtn"></span> ';
								 tr='<tr style="background-color: #84e08f"><td><div class="form-check form-check-inline cusCheck">';
								
							}	
							
							if(icdName!=null && icdName!=undefined && mbStatus=='P')
							{
							trHTML+=tr+checkValue+'</div></td><td><textarea class="form-control" value="'+icdName+'" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea></td><td><input type="text" value="'+system+'" id="system'+i+'" class="form-control" readonly /> </td><td><input type="text" value="'+medicalCategory+'" id="medicalCategory'+i+'" class="form-control" readonly></td><td><input type="text" value="'+categoryType+'" id="categoryType'+i+'" class="form-control" readonly> </td><td><div class="dateHolder"><input type="text" value="'+categoryDate+'" id="diagnosisDate'+i+'" name="diagnosisDatesssss" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td><input type="text" value="'+duration+'" id="duration'+i+'" class="form-control" readonly> </td><td><div class="dateHolder"><input type="text" value="'+nextCategoryDate+'" id="nextDiagnosisDate'+i+'" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td style="display: none";><input type="hidden" value="" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" readonly /></td></tr>';	
							//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
							i++;
							}
								
												
				});
						$('#medicalCategoryEmp').append(trHTML);
						
					}
		    });
			}
	      
	 function addRowForMedicalCategoryNew(){
       	 // var newIndex = $('.autocomplete').length;
       	    i++
       	    var aClone = $('#medicalCategoryNew>tr:last').clone(true);
       	    aClone.find('img.ui-datepicker-trigger').remove();
       		aClone.find(":input").val("");
       	    aClone.find("td:eq(0)").find(":input").prop('id', 'inlineCheckbox1');
       		aClone.find('input[type="text"]').prop('id', 'diagnosisId'+i+'');
       	    //aClone.find('input[type="text"]').prop('id', 'investigationDatess'+i+'');
       	    aClone.find("td:eq(0)").find(":input").prop('checked', false);
       	    //aClone.find("td:eq(2)").find(":checkbox").prop('id', 'otherAfLabCheck'+i+'').prop('checked', true);
       		/*aClone.find('input[type="radio"]').prop('name', 'labradiologyCheck1'+i+'');
       		aClone.find('input[type="radio"]').prop('id', 'othAfLab1'+i+'');*/
       		aClone.find("td:eq(8)").find(":input").prop('id', 'diagnosisIdval'+i+'');
       		aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'diagnosisDate'+i+'').removeClass('input_date hasDatepicker').addClass('input_date');
       		aClone.find("td:eq(7)").find("input:eq(0)").prop('id', 'nextDiagnosisDate'+i+'').removeClass('input_date hasDatepicker').addClass('input_date');
       		aClone.clone(true).appendTo('#medicalCategoryNew');
       		var val = $('#medicalCategoryNew>tr:last').find("td:eq(1)").find(":input")[0];
       		autocomplete(val, arry);
       		
       		var medicalCategoryVal = $('#medicalCategoryNew>tr:last').find("td:eq(3)").find(":input")[0];
       		autocomplete(medicalCategoryVal, MeidcalCategoryArry);
       		
       }
	 
	 function addRequirementPeriodictyGrid()
	 {
		    i++
     	    var aClone = $('#requirement>tr:last').clone(true);
     	    aClone.find('img.ui-datepicker-trigger').remove();
     		aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#requirement');
	 }
	 function addRecommendationsPosting()
	 {
		    i++
     	    var aClone = $('#recommendation_posting>tr:last').clone(true);
     	    aClone.find('img.ui-datepicker-trigger').remove();
     		aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#recommendation_posting');
	 }
	 function addEmployabilityRestrictions()
	 {
		    i++
     	    var aClone = $('#employabilityRestrictions>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#employabilityRestrictions');
	 }
	 function addEmployabilityRestrictionsGeneral()
	 {
		    i++
     	    var aClone = $('#employabilityRestrictions>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#employabilityRestrictions');
	 }
	 function addEmployabilityRestrictionsSFactor()
	 {
		    i++
     	    var aClone = $('#psychiatric>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#psychiatric');
	 }
	 function addEmployabilityRestrictionsHFactor()
	 {
		    i++
     	    var aClone = $('#h-factor>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#h-factor');
	 }
	 function addEmployabilityRestrictionsPFactor()
	 {
		    i++
     	    var aClone = $('#p-factor>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#p-factor');
	 }
	 function addEmployabilityRestrictionsEFactor()
	 {
		    i++
     	    var aClone = $('#eye_factor>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#eye_factor');
	 }
	 function addEmployabilityRestrictionsActivationCarde()
	 {
		    i++
     	    var aClone = $('#aviation_cadre>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#aviation_cadre');
	 }
	 function addEmployabilityRestrictionsDiversSubmariners()
	 {
		    i++
     	    var aClone = $('#submariners>tr:last').clone(true);
     	    aClone.find(":input").val("");
     	  	aClone.clone(true).appendTo('#submariners');
	 }
	 function deleteRow(btn) {
		  var row = btn.parentNode.parentNode;
		  row.parentNode.removeChild(row);
		}
	 

	function getMbAMSF15CheckListforValidate() {
		var visitId = $('#visitId').val();
		var patientId = $('#patientId').val();
		var data = {
			"visitId" : visitId,
			"patientId" : patientId
		};
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getAmsf15CheckList',
			data : JSON.stringify(data),
			dataType : "json",
			success : function(response) {
				var datas = response.checkListData;
				datasGetMbChekList=response.checkListData;
				var RequirementPeriodicty='';
				var RecommendationPosting='';
				var employabilityRestrictions='';
				var SFactorGetVal='';
				var HFactor='';
				var PFactor='';
				var EFactor='';
				var AviationCadre='';
				var EmployabilitySpecific='';
				var aFactorGetVal='';
				if(datas!=null && datas!="")
				{	
				for (var i = 0; i < datas.length; i++) {
					var checklistId=datas[i].checklistId;
					var headerID=datas[i].checklistHdCode;
                    var headerID=datas[i].checklistHdCode;
                    var checklistName=datas[i].checklistName;
                    var checklistValue=datas[i].checklistValue;
					if (headerID=='RequirementPeriodicty') {
						$("#requirement tr").remove();
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'AMA'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}
						else if(checklistValue == 'AMA'){
							optionList += '<option value="AMA" selected>'+checklistValue+'</option><option  id="no" value="No">No</option><option  id="yes" value="Yes">No</option></option>';
						}
						else if(checklistValue == 'SPL'){
							optionList += '<option value="SPL" selected>'+checklistValue+'</option><option  id="ama" value="AMA">AMA</option><option  id="spl" value="Super SPL">Super SPL</option></option>';
						}
						else if(checklistValue == 'Super SPL'){
							optionList += '<option value="Super SPL" selected>'+checklistValue+'</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
						}
						else if(checklistValue == '6 Monthly'){
							optionList += '<option value="6 Monthly" selected>'+checklistValue+'</option><option  id="3Month" value="3 Monthly">3 Month</option><option  id="month" value="Monthly">Month</option></option>';
						}
						else if(checklistValue == ""){
						optionList += '<option value="" selected>"Select"</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						RequirementPeriodicty+='<tr id="does_individual_tr">';
						RequirementPeriodicty+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{									
						RequirementPeriodicty+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control" >'+optionList+'</select></td>'; 
						}
						else
						{
							RequirementPeriodicty+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	
						RequirementPeriodicty+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						/* RequirementPeriodicty+='<td><button type="button" name="add" id="requirement-add" onclick="addRequirementPeriodictyGrid()" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" ></button></td>';
						RequirementPeriodicty+='<td><button type="button" name="delete" id="requirement-delete" onclick="deleteRow(this)"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" ></button></td>'; */
						RequirementPeriodicty+='</tr>';
						
					}
					if (headerID=='RecommendationsPosting') {
						$("#recommendation_posting tr").remove();
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'AMA'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}
						
						else if(checklistValue == undefined){
						
							optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						RecommendationPosting+='<tr id="does_individual_tr">';
						RecommendationPosting+='<td class="ques_width"><label class="col-form-label">'+checklistName+'</label><input  type="hidden"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
						RecommendationPosting+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							if(checklistName=='Yes, the same be justify:(Does he need to be posted to station with Specialist availability?)'){
								
								RecommendationPosting+='<td><textarea class="form-control" rows="3" name="reasonForVarious" maxlength="50" id="reasonForVarious">'+checklistValue+'</textarea></td>';
						    }
							else
							{	
							RecommendationPosting+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
							}
						}	 
						RecommendationPosting+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						/* RecommendationPosting+='<td><button type="button" name="add"  id="recommendations-add" onclick="addRecommendationsPosting()" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" ></button></td>';
						RecommendationPosting+='<td><button type="button" name="delete"  id="recommendations-delete" onclick="deleteRow(this)"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" ></button></td>'; */
						RecommendationPosting+='</tr>';
						
					}
					 if (headerID=='EmployabilityRestrictions' && checklistName!='null') {
							$("#employabilityRestrictions tr").remove();
							var optionList = '';
							var inputVal='';
							if(checklistValue == 'Yes'){
								optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
							}else if(checklistValue == 'No'){
								optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
							}else if(checklistValue == 'AMA'){
								optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
							}
							else if(checklistValue == 'Modified'){
								optionList += '<option value="Modified" selected>'+checklistValue+'</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
							}
							else if(checklistValue == undefined){
							optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
						    }
							else if(checklistValue == 'select' && checklistName=='Can he  performa  PET'){
								optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option><option id="modified" value="Modified">Modified</option>';
							    }
							else if(checklistValue == 'select' && checklistName=='Participation in Games'){
								optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option><option id="recreational" value="Recreational">Recreational</option>';
							    }
							else if(checklistValue == 'select'){
								optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
							    }
							
							else
							{
								inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
							}	
							employabilityRestrictions+='<tr id="does_individual_tr">';
							
							var flag = true;
							if(checklistName=='05Kgonly')
							{
								
							  employabilityRestrictions+='<td class="ques_width form-inline"><label class="col-form-label ">Can lift, weights </label><div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" value="05Kgonly" checked><span class="cus-checkbtn"></span></div>';
					          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(a) Upto 05 Kg only">';
					          employabilityRestrictions+='<div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkbox" value="10Kgonly"><span class="cus-checkbtn"></span></div>';
					          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(b) Upto  10 Kg only">';
					          employabilityRestrictions+='</td>';
					          flag = false;
							  
							}
							else if(checklistName=='10Kgonly')
							{
								
								  employabilityRestrictions+='<td class="ques_width form-inline"><label class="col-form-label ">Can lift, weights </label><div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" value="05Kgonly"><span class="cus-checkbtn"></span></div>';
						          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(a) Upto 05 Kg only">';
						          employabilityRestrictions+='<div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkbox" value="10Kgonly" checked><span class="cus-checkbtn"></span></div>';
						          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(b) Upto  10 Kg only">';
						          employabilityRestrictions+='</td>';	
						          flag = false;
							}
							else if(checklistName=='05KgonlyAnd10Kgonly')
							{
								  employabilityRestrictions+='<td class="ques_width form-inline"><label class="col-form-label ">Can lift, weights </label><div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" value="05Kgonly" checked><span class="cus-checkbtn"></span></div>';
						          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(a) Upto 05 Kg only">';
						          employabilityRestrictions+='<div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkbox" value="10Kgonly" checked><span class="cus-checkbtn"></span></div>';
						          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(b) Upto  10 Kg only">';
						          employabilityRestrictions+='</td>';	
						          flag = false;
							}
							else if(checklistName=='noneValue')
							{
								  employabilityRestrictions+='<td class="ques_width form-inline"><label class="col-form-label ">Can lift, weights </label><div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" value="05Kgonly"><span class="cus-checkbtn"></span></div>';
						          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(a) Upto 05 Kg only">';
						          employabilityRestrictions+='<div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkbox" value="10Kgonly"><span class="cus-checkbtn"></span></div>';
						          employabilityRestrictions+='<input  type="text"  id="lift_in"  class=" form-control-plaintext  col-form-label width120" value="(b) Upto  10 Kg only">';
						          employabilityRestrictions+='</td>';	
						          flag = false;
							}
							
							if(flag){
								employabilityRestrictions+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
								flag = false;
							}	
							
							
							if(optionList!=null && optionList!="")
							{	
								
								employabilityRestrictions+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
							}
							else
							{
								
								employabilityRestrictions+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
							}	  
							employabilityRestrictions+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
							employabilityRestrictions+='</tr>';
							
						}
					//alert("headerID" + headerID);
					if (headerID=='SFactor') {
						$("#psychiatric tr").remove();	
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'NA')
						{
							optionList +='<option  id="na"  value="NA" selected>NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistValue == undefined){
						optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						SFactorGetVal+='<tr id="does_individual_tr">';
						SFactorGetVal+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
							SFactorGetVal+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							
							SFactorGetVal+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	 
						SFactorGetVal+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						SFactorGetVal+='</tr>';
						
					}
					if (headerID=='HFactor') {
						$("#h-factor tr").remove();
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'NA')
						{
							optionList +='<option  id="na"  value="NA" selected>NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistValue == 'Swin')
						{
							optionList +='<option  id="swin"  value="Swin" selected>Swin </option><option  id="na"  value="NA">NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistValue == undefined){
						optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						HFactor+='<tr id="does_individual_tr">';
						HFactor+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
							HFactor+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							
							HFactor+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	 
						HFactor+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						HFactor+='</tr>';
						
					}
					if (headerID=='PFactor') {
						$("#p-factor tr").remove();
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'NA')
						{
							optionList +='<option  id="na"  value="NA" selected>NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistValue == undefined){
						optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						PFactor+='<tr id="does_individual_tr">';
						PFactor+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
							PFactor+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							
							PFactor+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	  
						PFactor+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						PFactor+='</tr>';
						
					}
					if (headerID=='EFactor') {
						$("#eye_factor tr").remove();
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'NA')
						{
							optionList +='<option  id="na"  value="NA" selected>NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistValue == undefined){
						optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						EFactor+='<tr id="does_individual_tr">';
						EFactor+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
							EFactor+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							
							EFactor+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	
						EFactor+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						EFactor+='</tr>';
						
					}
					if (headerID=='AviationCadre') {
						$("#aviation_cadre tr").remove();
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'NA')
						{
							optionList +='<option  id="na"  value="NA" selected>NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistValue == undefined){
						optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						AviationCadre+='<tr id="does_individual_tr">';
						AviationCadre+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
							AviationCadre+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							
							AviationCadre+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	 
						AviationCadre+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						AviationCadre+='</tr>';
						
					}
					if (headerID=='EmployabilitySpecific') {
						$("#submariners tr").remove();
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'NA')
						{
							optionList +='<option  id="na"  value="NA" selected>NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistName == 'Can he dive/swim')
						{
							if(checklistValue == undefined){
								optionList += '<option value="" selected>Select</option><option  id="swim"  value="Swim">Swim </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';
							    }
							else
							{	
							optionList +='<option value="" selected>'+checklistValue+'</option><option  id="swim"  value="Swim">Swim </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
							}
						}
						else if(checklistValue == undefined){
						optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						EmployabilitySpecific+='<tr id="does_individual_tr">';
						EmployabilitySpecific+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
							EmployabilitySpecific+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							
							EmployabilitySpecific+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	  
						EmployabilitySpecific+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						EmployabilitySpecific+='</tr>';
						
					}
					if (headerID=='aFactor') {
						$("#aAppendagesFactor tr").remove();	
						var optionList = '';
						var inputVal='';
						if(checklistValue == 'Yes'){
							optionList += '<option value="Yes" selected>'+checklistValue+'</option><option  id="no" value="No">No</option></option>';
						}else if(checklistValue == 'No'){
							optionList += '<option value="No" selected>'+checklistValue+'</option><option  id="no" value="Yes">Yes</option></option>';
						}else if(checklistValue == 'NA')
						{
							optionList +='<option  id="na"  value="NA" selected>NA </option><option  id="yes"  value="Yes">Yes </option><option  id="no" value="No">No</option>';	
						}
						else if(checklistValue == undefined){
						optionList += '<option value="" selected>Select</option><option  id="yes" value="Yes">Yes</option><option  id="no" value="No">No</option></option>';
					    }
						else
						{
							inputVal +='<input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" />';	
						}	
						aFactorGetVal+='<tr id="does_individual_tr">';
						aFactorGetVal+='<td class="ques_width"><input  type="text"  id="does_individual_in"  class="col-md-10  form-control-plaintext  col-form-label" value="'+checklistName+'"></td>';
						if(optionList!=null && optionList!="")
						{	
							
							aFactorGetVal+='<td class="ques_drop"><select name="does_individual"  id="dropDown" class="form-control">'+optionList+'</select></td>'; 
						}
						else
						{
							
							aFactorGetVal+=	'<td><input type="text" name="value" id="newValue" maxlength="50" value="'+checklistValue+'" class="form-control" /></td>';
						}	 
						aFactorGetVal+='<td style="display: none";><input type="hidden" value="'+checklistId+'" tabindex="1" id="checkListId" size="77" name="checkListIdval" /></td>';
						aFactorGetVal+='</tr>';
						
					}
					
				  }
					
				$("#requirement").html(RequirementPeriodicty);
				$("#recommendation_posting").html(RecommendationPosting);
				$("#employabilityRestrictions").html(employabilityRestrictions);
				$("#psychiatric").html(SFactorGetVal);
				$("#h-factor").html(HFactor);
				$("#p-factor").html(PFactor);
				$("#eye_factor").html(EFactor);
				$("#aviation_cadre").html(AviationCadre);
				$("#submariners").html(EmployabilitySpecific);
				$("#aAppendagesFactor").html(aFactorGetVal);
				diasableFormField();
			}
			else
			 {
				return false;
			}
		   }
		});
	}

      function diasableFormField(){
		 
		 $('input').attr('disabled','disabled');
		 $('select').attr('disabled','disabled');
		 $('textarea').attr('disabled','disabled');
		 $('button').attr('disabled','disabled');
		 $('#closebtn').removeAttr('disabled');
		$('.uneditableEditorView .jqte_editor').attr('contenteditable','false');
		$('.modal input, .modal button').removeAttr('disabled');
	 }
	/*  function submitWindow()
	 {
	 var code=document.getElementById('code').value;
	 var flag =true;
	 if(validateMetaCharacters(code)){

	 }

	 } */
</script>
</body>

</html>