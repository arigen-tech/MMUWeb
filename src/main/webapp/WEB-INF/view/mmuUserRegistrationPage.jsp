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
<script type="text/javascript" language="javascript">
<%
String mmuIdMultiple="No";
if (session.getAttribute("mmuIdMultiple") != null) {
	mmuIdMultiple = session.getAttribute("mmuIdMultiple") + "";
}
String mmuId="No";
if (session.getAttribute("mmuId") != null) {
	mmuId = session.getAttribute("mmuId") + "";
}

String userTypeName = "1";
if (session.getAttribute("userTypeName") != null) {
	userTypeName = session.getAttribute("userTypeName") + "";
}
%>
</script>
<style type="text/css">
.control-label {
	padding-top: 7px;
	margin-bottom: 0;
}

.container {
	margin-top: 20px;
}

.image-preview-input {
	position: relative;
	overflow: hidden;
	margin: 0px;
	color: #333;
	background-color: #fff;
	border-color: #ccc;
}

.image-preview-input input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	margin: 0;
	padding: 0;
	font-size: 20px;
	cursor: pointer;
	opacity: 0;
	filter: alpha(opacity = 0);
}

.image-preview-input-title {
	margin-left: 2px;
}

.cap {
	text-transform: capitalize;
}

.lower {
	text-transform: lowercase;
}

.upper {
	text-transform: uppercase;
}

.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #ea5b21;
}


input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

</style>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<script type="text/javascript">

	var $j = jQuery.noConflict();
	
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">
              <form id="userDetailForm">
				<div class="internal_Htext">Manage User</div>
                <input type="hidden"  name="userTypeIdUpdate" value="" id="userTypeIdUpdate" />
                <input type="hidden"  name="userTypeName" value="<%=userTypeName%>" id="userTypeName" />
                <input type="hidden"  name="mmuIdMultiple" value="<%=mmuIdMultiple%>" id="mmuIdMultiple" />
                <input type="hidden"  name="mmuId" value="<%=mmuId%>" id="mmuId" />
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Name of User</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="userName" class="form-control">
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Status</label>
											</div>
											<div class="col-md-7">
													<select id="statusUserDropDown" name="statusUserDropDown" class="form-control" onChange="searchUserListByStatus(this.value)" >
														<option value="3">All</option>
														<option value="1">Active</option>
														<option value="2">Inactive</option>
														
														</select>
												</div>
										</div>
									</div>

									<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-4">
													<button type="button" class="btn btn-primary" onclick="searchUserList()">Search</button>
												
												</div>
												
											</div>
										</div>
										
									<div class="col-md-2">
										<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												</div>
											 
										</div>
										
									<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-4">
													<button type="button" class="btn btn-primary" id="reportBtn" onclick="generateReport();">Report</button>
												
												</div>
												
											</div>
										</div>	
								
								</div>

								<div class="m-t-10">
									<div class="clearfix">
										<div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>											
										</div>
                                
										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										<div class="table-responsive scrollableDiv" id="table_div">
											<table
												class="table table-striped table-hover table-bordered " id="campTable">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th>User ID / Mobile Number</th>
														<th>Name of User</th>
														<th>Level of User</th>
														<th>Status</th>
														 <th>Edit</th>
														<th>Inactive / Active</th>
													</tr>
												</thead>
												<tbody id="usersDetailTable">
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
								
								<div class="row m-t-10">
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">User ID/ Mobile No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="mobileNo" maxlength="10" onblur="getEmployeeDetails(this.value)" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Name of User</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="nameOfUser">
											</div>
										</div>
									</div>
									
									<div class="w-100"></div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Email ID</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="emailId">
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Level of User</label>
											</div>
											<div class="col-md-7">
													<select id="typeOfUser" name="typeOfUSer" class="form-control" onChange="typeChange(this.value)" >
														<option value="">Select</option>
														<option value="State">State</option>
														<option value="Dist">District</option>
														<option value="City">City</option>
														<option value="MMU">MMU</option>
														<option value="Vendor">Vendor</option>
														
														</select>
												</div>
										</div>
										<input type="hidden" id="levelUsers" name="levelUsers" value=""/>
										<input type="hidden" id="employeeId" name="employeeId" value=""/>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of User</label>
											</div>
											<div class="col-md-7">
													<select id="getAllUserType" name="getAllUserType" class="form-control">
													
														</select>
												</div>
										</div>
										<input type="hidden" id="levelUsers" name="levelUsers" value=""/>
									</div>

									<div class="col-md-6" style="display:none" id="uploadSignatureBlock">
                                        <div class="form-group row">
                                            <div class="col-md-4">
                                                <label class="col-form-label">Upload Signature</label>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="fileUploadDiv" style="margin-left:-30px">
                                                    <input type="file" class="inputUpload" name="userSignature" id="userSignature">
                                                    <label class="inputUploadlabel">Choose File</label>
                                                    <span id="" class="inputUploadFileName">No File Chosen</span>
                                                </div>
                                            </div>
                                            <div class="col-md-1">
                                                <label class="col-form-label"><i title="No signature uploaded" id="signatureDownload" class="fa fa-download" style="font-size:large;cursor:no-drop" aria-hidden="true"></i></label>
                                            </div>
                                        </div>
                                    </div>
								</div>
								
								<div class="row m-t-10">
									<div class="col-12">
										<label class="col-form-label" id="sdcmVal"></label>
									</div>
									<div class="col-sm-4 col-md-4 ">						             	
						             	<select multiple class="form-control height110" id="userTypesSelect" name="userTypesSelect">
		            			            
				                   		 </select>
				                   	</div>
											
									<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 									
									    <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
										<div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
									</div>
										
									<div class="col-sm-4 col-md-4 ">
					                    <select multiple class="form-control height110" id="appendUserTypesSelect" name="appendUserTypesSelect">
					                    
					                    </select>
		               				</div>
								</div>
								
								<div class="row m-t-10">
									<div class="col-12">
										<label class="col-form-label">Role Assigned</label>
									</div>
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
								
								<div class="row m-t-20" id="btn_div">
									<div class="col-12 text-right">									
										<button type="button" class="btn btn-primary" id="btnSubit" onclick="submitUnitAdminforNormalUser()">Submit</button>
										<button type="button" class="btn btn-primary" onclick="redirectDashboard()">Close</button>
									</div>
								</div>

							</div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->
            </form>
			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->
<div class="modal" id="messageForUpdate" role="dialog">
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
									<span><spring:message code="msgForupdate" /></span> 
									
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="reloadApplication();" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<%-- <button class="btn btn-primary" data-dismiss="modal"
							onClick="closeMessage();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button> --%>
					</div>
					
					
					
				</div>
			</div>
		</div>
		
<div class="modal" id="messageForCreate" role="dialog">
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
									<span><spring:message code="msgForCreate" /></span> 
								
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="reloadApplication();" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<%-- <button class="btn btn-primary" data-dismiss="modal"
							onClick="closeMessage();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button> --%>
					</div>
					
					
					
				</div>
			</div>
		</div>
		

	<!-- jQuery  -->

<script type="text/javascript">

function showResultPage(pageNo) 	
{
	
	nPageNo = pageNo;	
	getuserDetailsList('FILTER');
	
}


function getuserDetailsList(MODE) { 	
 	
    var cmdId=0;
 	var user_name = $j('#userName').val();
	var mmuId = $j('#mmuId').val();
	var userTypeVal=$('#userTypeName').val();
	var mmuIdMultiple=$('#mmuIdMultiple').val();
	var mmuId=$('#mmuId').val();
	var actulaMmuId="";
	var statusVal="";
	statusVal=$('#statusUserDropDown').val();
	if(mmuIdMultiple=="No")
	{
		actulaMmuId=mmuId;
	}
	else
	{
		actulaMmuId=mmuIdMultiple;
	}	
       var cmdId=0;
		if(MODE == 'ALL'){
		      var data = {"mmuId": actulaMmuId,"employeeId": 1,"pageNo":nPageNo,"userTypeName":userTypeVal,'statusVal':statusVal};
			}
		  else if(user_name!="")
			{
				
				var data = {"mmuId": actulaMmuId,"employeeId":'1',"pageNo":nPageNo,"userName":user_name,"userTypeName":userTypeVal,'statusVal':statusVal};
			} 
		  else
			{
				var data = {"mmuId": actulaMmuId,"employeeId": '1',"pageNo":nPageNo,"userTypeName":userTypeVal,'statusVal':statusVal};
			} 

	var url = "getUsersDetailsList";		
	var bClickable = true;
	GetOpdJsonData('tblListofOpdP',data,url,bClickable);
}

function searchUserList()
{
		
	var nPageNo=1;	
	var user_name = $j('#userName').val();
	
	if((user_name == undefined || user_name == '')){	
		alert("Please enter name of user");
		return;
	}
	getuserDetailsList('FILTER');
	//ResetForm();
} 

function searchUserListByStatus(val)
{
		
	var nPageNo=1;	
	var statusVal = val;
	getuserDetailsList('FILTER');
	//ResetForm();
} 

function ResetForm()
{	
	$j('#userName').val('');
}

function showAll()
{
	 ResetForm();
	nPageNo = 1;	
	getuserDetailsList('ALL');
	
	
}

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count;
	
	var dataList = jsonData.data;
	if(dataList!=undefined && dataList!="" && dataList.length >= 0)	
	{	
	for(i=0;i<dataList.length;i++)
		{	 		
		if (dataList[i].hasOwnProperty('mobileNo'))
	     {	
			htmlTable+="<tr><td style='width: 150px;'>"+dataList[i].mobileNo+"</td>";
	     }
	 		else
	 		{
	 			htmlTable+="<tr><td style='width: 150px;'></td>";
	 		}	
	        if (dataList[i].hasOwnProperty('userName'))
	        {	
	        	htmlTable+= "<td style='width: 300px;'>"+dataList[i].userName+"</td>"; 
	        }
	       else
	 		{
	 			htmlTable+="<td style='width: 100px;'></td>";
	 		}
	     
	        if (dataList[i].hasOwnProperty('levelOfUser'))
	        {
	 			if(dataList[i].levelOfUser=="M"){	
	 	 			htmlTable+="<td style='width: 100px;'>"+'MMU'+"</td>";
	 	 			}
	 	 			else if(dataList[i].levelOfUser=="D"){
	 	 				htmlTable+="<td style='width: 100px;'>"+'District'+"</td>";
	 	 			}
	 	 			else if(dataList[i].levelOfUser=="C")
	 	 			{
	 	 				htmlTable+="<td style='width: 100px;'>"+'City'+"</td>";
	 	 			}
	 	 			else if(dataList[i].levelOfUser=="S")
		 	 			{
		 	 				htmlTable+="<td style='width: 100px;'>"+'State'+"</td>";
		 	 			}
	 	 			else if(dataList[i].levelOfUser=="V")
	 	 			{
	 	 				htmlTable+="<td style='width: 100px;'>"+'Vendor'+"</td>";
	 	 			}
	        }
	       else
	 		{
	 			htmlTable+="<td style='width: 100px;'></td>";
	 		}
	    
	       if (dataList[i].hasOwnProperty('userFlag'))
	        {
	 			if(dataList[i].userFlag=="0"){	
	 	 			htmlTable+= "<td style='width: 100px;'>"+'New User'+"</td>";
	 	 			}
	 			else if(dataList[i].userFlag=="1"){
	 			
	 				htmlTable+="<td style='width: 100px;'>"+'Active'+"</td>";
	 			}
	 			else if(dataList[i].userFlag=="2"){
		 			
		 				htmlTable+="<td style='width: 100px;'>"+'Inactive'+"</td>";
		 			}
	       }
	      else
	 		{
	 			htmlTable+="<td style='width: 100px;'></td>";
	 		}
	       htmlTable+="<td style='width: 100px;'><button type='button' onclick='editUserDetails("+dataList[i].userId+")' class='btn btn-primary'>Edit</button></td>";
			if(dataList[i].userFlag=="2")
			{	
				htmlTable+='<td style="width: 100px;"><label class="switch"><input type="checkbox" id="active'+dataList[i].userId+'" value="'+dataList[i].mobileNo+'" onchange="activeInactiveFun(this.value,this.id,'+dataList[i].userId+')"><span class="slider round"></span></label></td></tr>';
			}
			else
			{
				htmlTable+='<td style="width: 100px;"><label class="switch"><input type="checkbox" id="active'+dataList[i].userId+'" checked="checked" value="'+dataList[i].mobileNo+'" onchange="activeInactiveFun(this.value,this.id,'+dataList[i].userId+')"><span class="slider round"></span></label></td></tr>';
			}	
	    
			htmlTable+= "</tr>";
		}	
		}
	   if(jsonData.status == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	//alert("tblListOfCommand ::" +htmlTable)
	$j("#usersDetailTable").html(htmlTable);	
	
	
}

 $j(document).ready(function() {

	   var userTypeName='<%=userTypeName%>';

       if(userTypeName=='APM' || userTypeName=='apm'){
          $("#reportBtn").hide();
         }
       else{
    	   $("#reportBtn").show();
         }
		  
	$('#addkey').click(function() {
			if ($('#userTypesSelect option:selected').val() != null) {
						var sel = document.getElementById("getAllUserType");
				 		var getAllUserTypeValue = sel.options[sel.selectedIndex].text;
				     if(getAllUserTypeValue.startsWith('Doct') ||getAllUserTypeValue.startsWith('ANM')||getAllUserTypeValue.startsWith('Lab')||getAllUserTypeValue.startsWith('Phar')
				    		 ||getAllUserTypeValue.startsWith('Driv'))
				     {
				    	 var mmuTypeVal = [];
				    	 $("#appendUserTypesSelect > option").each(
									function() {
										var mmuIdValue=this.value;
										mmuTypeVal.push(mmuIdValue)
									});
				    	 if(mmuTypeVal!=null && mmuTypeVal!="")
				    	 {
				    		 alert("You can't select multiple MMU for this type of users")
				    		 return false;
				    	 } 
				     }	 
					 $('#userTypesSelect option:selected').remove().appendTo('#appendUserTypesSelect');
					 $("#userTypesSelect").attr('selectedIndex','-1').find("option:selected").removeAttr("selected");
		         	 $("#userTypesSelect").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");      
				 } 
		});
	$('#removeKey').click(function() {
		       if ($('#appendUserTypesSelect option:selected').val() != null) {
		             	$('#appendUserTypesSelect option:selected').remove().appendTo('#userTypesSelect');
		           	 	$("#appendUserTypesSelect").attr('selectedIndex',  '-1').find("option:selected").removeAttr("selected");
		          		$("#appendUserTypesSelect").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");       
					}
		});  

 });
 
 
 
 $j(document).ready(function() {
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
 function redirectDashboard()
 {
 	window.location="${pageContext.request.contextPath}/dashboard/dashboard";
 }


   function generateReport(){
	  var user_flag=$('#statusUserDropDown').val();
      var url = "${pageContext.request.contextPath}/report/printUsersReport?userFlag="+user_flag;
	    openPdfModel(url);

  }
 
</script>
</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
