<%@page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU Application</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description"/>
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
 
 <%@include file="..//view/commonJavaScript.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/multipleRolesAndDesignation.js"></script>   
</head>
<body>
<!-- Begin page -->
    <div id="wrapper">
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 

<div class="row">
               <div class="col-12">
                            <div class="card">
                                <div class="card-body">
									<form:form name="submitSystemAdmin" id="submitSystemAdmin" method="post"
									action="${pageContext.request.contextPath}/createAdmin/submitSystemAdminForUnit" autocomplete="off">
                                     
                                     <div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">User Registartion</h4>
                                     <div class="row">

                                    </div>

                                     <div class="row">
                                     
                                     <div class="col-md-4">
                                     </div>
                                     
                                     </div>

								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 13px;"
												align="left">User List</td>
											<td>
												
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>


								 
                                    <table class="table table-hover table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>                                                
                                                 <th id="th5" class ="inner_md_htext">User Id/Mobile Number</th>
                                                 <th id="th5" class ="inner_md_htext">Name Of User</th>
                                                 <th id="th5" class ="inner_md_htext">Type Of User</th>
                                                 <th id="th5" class ="inner_md_htext">Status</th>
                                               <!--   <th id="th5" class ="inner_md_htext">Active/InActive</th> -->
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListOfRoleAndDesignation">

                                        </tbody>
                                    </table>
                                    
                                    
								</div>
                                    <!-- end row -->
						
						<div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Users Registartion Details </h4>
						
						<div class="row">
			
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">User Id/Mobile No. </label>
													<div class="col-md-7">
														<input name="empname" id="empname" type="text"
															class="form-control border-input" value="" />
													</div>
												</div>
											</div>

											
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label"> Name Of User </label>
													<div class="col-md-7">
														<input name="Gender" id="gender" type="text"
															class="form-control border-input" value="">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">E-mail Id </label>
													<div class="col-md-7">
														<input name="DOB" id="dob" type="text"
															class="form-control border-input" value="" readonly />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label"> Type Of User </label>
													<div class="col-md-7">
													<select id="typeOfUser" name="typeOfUSer" class="form-control" onchange="nextFolloUpDate(this.value)" >
														<option value="">Select</option>
														<option value="State">State</option>
														<option value="Dist">District</option>
														<option value="City">City</option>
														<option value="mmu">MMU</option>
														
														</select>
												</div>
												</div>
											</div>
										
									

										</div>
						<div class="row">
							<div class="col-sm-4 col-md-4 ">
				             	 <label><strong><spring:message code="lblallDesignation"/></strong></label> 
				             	<select class="form-control height150" id="availableContactTypeAdduser" name="availableContactTypeAdduser">
            			            
		                   		 </select>
		                   	</div>
									
							<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 
									
							  <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
								<div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
							</div>
								
							<div class="col-sm-4 col-md-4 ">
							 	<label><strong><spring:message code="lblSelectedDesignation"/></strong></label> 
			                      <select multiple class="form-control height150" id="attachContactTypeAdduser" name="attachContactTypeAdduser">
			                      </select>
               				</div>
							</div>	
							
							<div class="row  m-t-20">
							<div class="col-sm-4 col-md-4 ">
				             	 <label><strong><spring:message code="lblallRoles"/></strong></label> 
				             	<select multiple class="form-control height150" id="availableContactTypeAdduser1" name="availableContactTypeAdduser1">
            			            
		                   		 </select>
		                   	</div>
									
							<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 
								
							  <div class="span2"> <span id="addkey1" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
								<div class="span2"> <span id="removeKey1" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
							</div>
								
							<div class="col-sm-4 col-md-4 ">
							 	<label><strong><spring:message code="lblAssignedRole"/></strong></label> 
			                      <select multiple class="form-control height150" id="attachContactTypeAdduser1" name="attachContactTypeAdduser1">
			                      </select>
               				</div>
							</div>			
                               
                               <div class="row">
						    <div class="col-md-12 m-t-10">
										<button type="button" class="btn btn-primary" onclick="submitUnitAdminforNormalUser()">Submit</button>
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
                            
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    
<script type="text/javascript">

 $j(document).ready(function() {
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
 
 
 
 $j(document).ready(function() {
	   alert("hello")
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
 //getMasDesinationDetailForUnitAdminNormalUser();
 //getUnitAdminMasRole();
 //getRoleAndDesignationDetails();
</script>
</body>
</html>