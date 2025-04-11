<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description"/>
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@include file="..//view/commonJavaScript.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/systemadmin.js"></script>
   
  <%
	String hospitalId = "";
  if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
	
%>

<script type="text/javascript" language="javascript">
 

</script>

</head>

<body>
  <!-- Begin page -->
    <div id="wrapper">
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">System Admin</div>
                    <div class="row">
                    <input type="hidden" Id="masDesignationMappingId" name="masDesignationMappingId" value=""/>
                    <input type="hidden" Id="userId" name="userId" value="<%=userId%>"/>
                    <input type="hidden" Id="hospitalId" name="hospitalId" value="<%=hospitalId%>"/>
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
									<form:form name="submitSystemAdmin" id="submitSystemAdmin" method="post"
									action="#" autocomplete="off">
                                     
                                     <div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Manage Unit Admin</h4>
                                     <div class="row">
										<div class="col-md-3">
	                                			<div class="form-group row">
	                                				<div class="col-md-5">
	                                					<label class="col-form-label" >Service No.</label>
	                                				</div>
	                                				<div class="col-md-7">
	                                					<input type="text" class="form-control" name="SearchserviceNo" id="SearchserviceNo"/>
	                                				</div>
	                                			</div>
	                                		</div>
											<div class="col-md-3">
	                                			<button type="button" class="btn btn-primary" onclick="searchValidateList()">Search</button>
	                                		</div>
	                                		<div class="col-md-3">
											
											</div>
	                                		<div class="col-md-3 btn-right-all">
													<button type="button" class="btn btn-primary"
														onclick="ShowAllList('1')">Show All</button>
	                                		</div>
										<!--  <div class="col-md-3">
											
										</div> -->
										
										
                                      

                                    </div>
									<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdmin" style="font-size: 15px;"
												align="left"></td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>


								 
                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th3" class ="inner_md_htext">Service No.</th>
                                                <th id="th4" class ="inner_md_htext">Name </th>
                                                <th id="th4" class ="inner_md_htext">Unit Name</th>
                                                 <th id="th5" class ="inner_md_htext">Designation</th>
                                                  <th id="th5" class ="inner_md_htext">Role</th>
                                                  <th id="th5" class ="inner_md_htext">Status</th>
                                           <th id="th5" class ="inner_md_htext">Activate/Deactivate</th>
                                           
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblOfSystemAdmin">

                                        </tbody>
                                    </table>
                                    
                                    <div class="row">
						    
								</div>
								</div>
                                    <!-- end row -->
						</form:form>
						<div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Create Unit Admin</h4>
										<div class='divErrorMsg m-b-10' id='errordiv' ></div>
										<div class="messageDiv m-b-10" id="messForSysUserTranstion"></div>
									
                                     <div class="row">
										
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Select MI Room</label>
												<div class="col-sm-7">
													<select class="form-control" name="miRoom"  
													tabindex="1" id="miRoom" onChange="return getMasUnitListByUnitCode();" >
												</select>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Select Unit</label>
												<div class="col-sm-7">
													<select class="form-control" name="massSystemAdminHospital"  
													tabindex="1" id="massSystemAdminHospital" onChange="return getAllServiceByUnitId('s');" >
												</select>
												</div>
											</div>
										</div>
										
										<!-- <div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-6 col-form-label">Enter Service No.</label>
												<div class="col-sm-5">
													<input type="text" onBlur="getMasEmployeeDetail('s')" class="form-control" id="serviceNo" name="serviceNo" placeholder="">
												</div>
											</div>
										</div> -->
										<div class="col-md-4">
										<div class="form-group row">
												<label class="col-sm-5 col-form-label">Select Service No.</label>
												<div class="col-sm-7">
													<select class="form-control" id="serviceNo" name="serviceNo" tabindex="1"  onChange="return getMasEmployeeDetail('s')">
													<option value="0">Select</option>
												</select>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="userName" name="userName" placeholder="" disabled>
												</div>
											</div>
										</div>
										
										<!-- <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Age</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="serviceNo" name="serviceNo" placeholder="" disabled>
												</div>
											</div>
										</div> -->
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Rank</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="rank" name="rank" placeholder="" disabled>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Gender</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="gender" name="gender" placeholder="" disabled>
												</div>
											</div>
										</div>
										
										
										
										<!-- <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Rank</label>
												<div class="col-sm-7">
													<button type="button" onClick="reSetUnitAdmin()" class="btn btn-primary" onclick="">Reset</button>
												</div>
											</div>
										</div> -->
										
										 

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
														 
														<input type="button" id="btnActiveUnitAdmin" type="button"
															class="btn  btn-primary " onclick="submitUnitAdmin();" value="Submit"disabled/> 
														<button type="button" class="btn btn-danger "
															onclick="reSetUnitAdmin();">Reset</button>
													 
											</div>
										</div>
									 
										<!-- <div class="col-md-12 btn-right-all" >
											<button type="button" onClick="submitUnitAdmin()" class="btn btn-primary" onclick="">Submit</button>
											<button type="button" onClick="reSetUnitAdmin()" class="btn btn-primary btn btn-danger " onclick="">Reset</button>
									</div> -->
										
                                      <!-- <div class="col-md-12">
											
									</div> -->

                                    </div>

                       
								</div>
						<form:form>
						<div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Assign Designation  To Unit</h4>
									
									<div class="messageDiv form-group row" id="messForDesiTranstion"></div>
									
									
									<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForMassDesignation" style="font-size: 13px;"
												align="left"></td>
											<td> 
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
									<div style="float: right">
									<div id="resultnavigationMasDesignation" ></div>
								</div>


								 
                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                            
                                             <th id="th4" class ="inner_md_htext">Unit Name</th>
                                                <th id="th4" class ="inner_md_htext">Designation</th>
                                                  <th id="th5" class ="inner_md_htext">Status</th>
                                           <th id="th5" class ="inner_md_htext">Edit</th>
                                           <!--  <th id="th5" class ="inner_md_htext">Delete</th> -->
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblOfDesignation">

                                        </tbody>
                                    </table>
									
									<div style="text-align: center;" class='divErrorMsg form-group  m-b-10' id='errordiv1' ></div>
									<div class="row">
									<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Select MI Room</label>
												<div class="col-sm-7">
													<select class="form-control" name="miRoomDesi"  
													tabindex="1" id="miRoomDesi" onChange="return validateDesignation();" >
												</select>
												</div>
											</div>
										</div>
									
									<div class="col-md-5" style='display:none;'>
											<div class="form-group row">
												<label class="col-sm-3 col-form-label">Select Unit</label>
												<div class="col-sm-9">
													<select class="form-control" onChange="return validateDesignation();" name="massSystemAdminHospitalForDesignation"  
													tabindex="1" id="massSystemAdminHospitalForDesignation" >
												</select>
												</div>
											</div>
										</div>
									</div>
						
						<div class="row m-t-10">
							<div class="col-sm-4 col-md-4 ">
				             	 <label><strong><spring:message code="lblallDesignation"/></strong></label> 
				             	<select multiple class="form-control height110" id="availableContactTypeAdduser" name="availableContactTypeAdduser">
            			            
		                   		 </select>
		                   	</div>
									
							<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 
								
								<!-- <button id="addkey" class="btn btn-primary btn-sm btn-block m-t-10"><i class="fa fa-chevron-right"></i></button>
								<button id="removeKey" class="btn btn-primary btn-sm btn-block"><i class="fa fa-chevron-left"></i></button>
							 -->	
							  <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
								<div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
							</div>
								
							<div class="col-sm-4 col-md-4 ">
							 	<label><strong><spring:message code="lblSelectedDesignation"/></strong></label> 
			                      <select multiple class="form-control height110" id="attachContactTypeAdduser" name="attachContactTypeAdduser">
			                      </select>
               				</div>
							</div>			
                              <div class="row"> 
                               <div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
														 
														<input type="button" id="designationUnitForAdmin" type="button"
															class="btn  btn-primary " onclick="submitMasDesignation();" value="Submit"/>
													 
											</div>
								</div>
                               </div>
                               <!-- <div class="row">
						   			 <div class="col-md-12 m-t-10">
										<button type="button" class="btn btn-primary" onclick="submitMasDesignation()">Submit</button>
								</div>
								</div> -->
								
								</div>
                               </form:form>
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
                  </div>
</div>

 
<script type="text/javascript">
var userList="";
 $( document ).ready(function() {
	$('#addkey').click(function() {
			if ($('#availableContactTypeAdduser option:selected').val() != null) {
					 $('#availableContactTypeAdduser option:selected').remove().appendTo('#attachContactTypeAdduser');
					 $("#availableContactTypeAdduser").attr('selectedIndex','-1').find("option:selected").removeAttr("selected");
		         	 $("#attachContactTypeAdduser").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");      
				 } 
		});
	$('#removeKey').click(function() {
		       if ($('#attachContactTypeAdduser option:selected').val() != null) {
		             	$('#attachContactTypeAdduser option:selected').remove().appendTo('#availableContactTypeAdduser');
		           	 	$("#attachContactTypeAdduser").attr('selectedIndex',  '-1').find("option:selected").removeAttr("selected");
		          		$("#availableContactTypeAdduser").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");       
					}
		});  

 });
 
 
 var nPageNo=1;
 var Status;
 var $j = jQuery.noConflict();

 $j(document).ready(function()
 		{	
 			getAllUnitAdminDetail("ALL","SearchStatusForUnitAdmin");
 			getAllMasDesinationDetail("ALL","SearchStatusForMassDesignation");
 		});
 		
 
 function searchValidateList() {

		var searchService = $j('#SearchserviceNo').val();
	 
		 if((searchService == undefined || searchService == '')){	
			alert("Please enter  Service No.");
			return;
		}
		getCommandList('Search');
	}
 
 function ShowAllList(pageNo)
	{	 
		 nPageNo=pageNo;
		 resetForm();
		 getCommandList('ALL');
	}
 function showResultPage(pageNo,flagCheck)
	{
		
		nPageNo = pageNo;	
		//getCommandList('FILTER');
		//nPageNo = pageNo;	
	 	if(flagCheck=="unitAdminGrid"){
	 	getAllUnitAdminDetail('FILTER',"SearchStatusForUnitAdmin");
	 	}
	 	
	 	if(flagCheck=="masDesignationGrid"){
	 		getAllMasDesinationDetail('FILTER',"SearchStatusForMassDesignation");
		 	}
	 	
	 	if(flagCheck=="unitAdminForNormalUser"){
	 		getAllUnitAdminDetailForNormalUser('FILTER',"SearchStatusForUnitAdminNorUser");
	 	}
		
	} 
	
 function getCommandList(MODE,pageSize) {

		var searchService = $j('#SearchserviceNo').val();
		 var userId=$('#userId').val();
		if (MODE == 'ALL') {
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':'','adminFlagValue':'S','searchService' : ''};	
		} 
		
		else if(MODE == 'FILTER'){
			 
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':'','adminFlagValue':'S','searchService' : searchService};	
		}
		
		else if(searchService!=""){
			nPageNo = 1;
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':'','adminFlagValue':'S','searchService' : searchService};	
		}
		
		else {
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':'','adminFlagValue':'S','searchService' : searchService};	
		}
		var url = "getUnitAdminDetail";
	 	var bClickable = true;
	 	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",'SearchStatusForUnitAdmin','unitAdminGrid','resultnavigation');
	}
 function resetForm()
	{	
		 $j('#SearchserviceNo').val('');
		 
	}
 	getMasHospitalListForAdmin();
	getAllMasDesigation();
	/* getUnitAdminDetail();
	getMasDesinationDetail();
	 */
	
	
</script>
</body>



</html>