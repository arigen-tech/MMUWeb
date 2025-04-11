<%@page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
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
	String serviceNo="";
	if (session.getAttribute("service_No") != null) {
		serviceNo = session.getAttribute("service_No") + "";
		 //out.print("serviceNo"+serviceNo);
	}
	String userName="";
	if (session.getAttribute("user_Name") != null) {
		userName = session.getAttribute("user_Name") + "";
		//out.print("userName"+userName);
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
	 <h6 style="display:none;">Welcome <c:out value='${sessionScope["firstName"]} (${sessionScope["hospital_Name"]})'/></h6>
	<%--  <h6>Service Number  <c:out value='${sessionScope["service_No"]}'/></h6><br> --%>
	  <div class="internal_Htext">Unit Admin</div>
	  	<input type="hidden"  name="hospitalId" value=<%=hospitalId%> id="hospitalId" />
		<input type="hidden"  name="userId" value=<%=userId%> id="userId" />
			<input type="hidden"  name="userIdValue" value= "" id="userIdValue" />
			<input type="hidden"  name="rolesId" value= "" id="rolesId" />	
				<input type="hidden"  name="massSystemAdminHospital" value= <%=hospitalId%> id="massSystemAdminHospital" />				
                    <div class="row">
                    
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
									<form:form name="submitSystemAdmin" id="submitSystemAdmin" method="post"
									action="${pageContext.request.contextPath}/createAdmin/submitSystemAdminForUnit" autocomplete="off">
                                     
                                     <div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Manage User and Role Advance</h4>
                                     <div class="row">

                                    </div>

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
                                     
                                     </div>

								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											  <td class="SearchStatusForUnitAdminNorUser" style="font-size: 13px;"
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
                                                 <th id="th5" class ="inner_md_htext">Designation</th>
                                                 <th id="th5" class ="inner_md_htext">Role</th>
                                                 <th id="th5" class ="inner_md_htext">Status</th>
                                                 <th id="th5" class ="inner_md_htext">Edit</th>
                                                 <th id="th5" class ="inner_md_htext">Activate/Deactivate</th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblOfUnitAdmin">

                                        </tbody>
                                    </table>
                                    
                                    
								</div>
                                    <!-- end row -->
                                    
                                    <div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Create User</h4>
									<div class='divErrorMsg m-b-10' id='errordiv' ></div>
										<div class="messageDiv m-b-10" id="messForTranstion"></div>
									 
                                     <div class="row">
										
										
										 <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Selected MI Room</label>
												<div class="col-sm-7" >
													<select disabled class="form-control" name="miRoom"  
													tabindex="1" id="miRoom" onChange="return getMasUnitListByUnitCode();"  >
												</select>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Select Unit</label>
												<div class="col-sm-7">
													<select class="form-control" name="massSystemAdminHospital1ForUnit"  
													tabindex="1" id="massSystemAdminHospital1ForUnit"     onChange="return getAllServiceByUnitId('us');" >
												</select>
												</div>
											</div>
										</div>
										 
										<div class="col-md-4">
										<div class="form-group row">
												<label class="col-sm-5 col-form-label">Select Service No.</label>
												<div class="col-sm-7">
													<select class="form-control" id="serviceNo" name="serviceNo" tabindex="1" onFocus="return getMasEmployeeDetail('u')" onChange="return getMasEmployeeDetail('u');">
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
										</div>
										 -->
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Gender</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="gender" name="gender" placeholder="" disabled>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Rank</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="rank" name="rank" placeholder="" disabled>
												</div>
											</div>
										</div>
										
										<div class="col-md-8"></div>
										<!-- <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Rank</label>
												<div class="col-sm-7">
													<button type="button" onClick="reSetNorMalUser()" class="btn btn-primary" onclick="">Reset</button>
												</div>
											</div>
										</div> -->
                                      
                                      <div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
														<button type="button" class="btn btn-danger "
															onclick="reSetNorMalUser();">Reset</button>
													 
											</div>
										</div>
                                      

                                    </div>

                       
								</div>
								
								
						
						<div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Assign Designation and Role </h4>
						
						<div class="row">
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
							
							<div class="row  m-t-20">
							<div class="col-sm-4 col-md-4 ">
				             	 <label><strong><spring:message code="lblallRoles"/></strong></label> 
				             	<select multiple class="form-control height110" id="availableContactTypeAdduser1" name="availableContactTypeAdduser1">
            			            
		                   		 </select>
		                   	</div>
									
							<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 
								
							  <div class="span2"> <span id="addkey1" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
								<div class="span2"> <span id="removeKey1" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
							</div>
								
							<div class="col-sm-4 col-md-4 ">
							 	<label><strong><spring:message code="lblAssignedRole"/></strong></label> 
			                      <select multiple class="form-control height110" id="attachContactTypeAdduser1" name="attachContactTypeAdduser1">
			                      </select>
               				</div>
							</div>			
                               
                             <!--   <div class="row">
						    <div class="col-md-12 m-t-10">
										<button type="button" class="btn btn-primary" onclick="submitUnitAdminforNormalUser()">Submit</button>
								</div>
								</div> -->
							
							  <div class="row"> 
                               <div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
														 
														<input type="button"  id="btnActiveUnitAdmin" type="button"
															class="btn  btn-primary " onclick="submitUnitAdminforNormalUser();" value="Submit" /> 
													 
											</div>
								</div>
                               </div>
							
								
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
 
 
 
 $( document ).ready(function() {
		$('#addkey1').click(function() {
				if ($('#availableContactTypeAdduser1 option:selected').val() != null) {
						 $('#availableContactTypeAdduser1 option:selected').remove().appendTo('#attachContactTypeAdduser1');
						 $("#availableContactTypeAdduser1").attr('selectedIndex','-1').find("option:selected").removeAttr("selected");
			         	 $("#attachContactTypeAdduser1").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");      
					 } 
			});
		$('#removeKey1').click(function() {
			       if ($('#attachContactTypeAdduser1 option:selected').val() != null) {
			             	$('#attachContactTypeAdduser1 option:selected').remove().appendTo('#availableContactTypeAdduser1');
			           	 	$("#attachContactTypeAdduser1").attr('selectedIndex',  '-1').find("option:selected").removeAttr("selected");
			          		$("#availableContactTypeAdduser1").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");       
						}
			});  

	 });
 
 var nPageNo=1;
 var Status;
 var $j = jQuery.noConflict();

 $j(document).ready(function()
 		{	
	 		getAllUnitAdminDetailForNormalUser("ALL","SearchStatusForUnitAdminNorUser");
	 		//getAllServiceByUnitId('u');
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
function showResultPage(pageNo)
	{
		
		nPageNo = pageNo;	
		getCommandList('FILTER');
		
	}
	
function getCommandList(MODE,pageSize) {

		var searchService = $j('#SearchserviceNo').val();
		var unitId = $('#hospitalId').val();
		 var userId=$('#userId').val();
		if (MODE == 'ALL') {
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':unitId,'adminFlagValue':'U','searchService' : ''};	
		} 
		
		else if(MODE == 'FILTER'){
			 
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':unitId,'adminFlagValue':'U','searchService' : searchService};	
		}
		
		else if(searchService!=""){
			nPageNo = 1;
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':unitId,'adminFlagValue':'U','searchService' : searchService};	
		}
		
		else {
			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':unitId,'adminFlagValue':'U','searchService' : searchService};	
		}
		var url = "getUnitAdminDetail";
	 	var bClickable = true;
	 	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",'SearchStatusForUnitAdminNorUser',"unitAdminForNormalUser","resultnavigation");
	}
function resetForm()
	{	
		 $j('#SearchserviceNo').val('');
		 
	}
 getMasDesinationDetailForUnitAdminNormalUser();
 getUnitAdminMasRole();
 getMasHospitalListForUnitAdmin();
// getUnitAdminDetailForNormalUser();
</script>

</body>



</html>