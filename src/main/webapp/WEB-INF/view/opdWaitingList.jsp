<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>



</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>


<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	String hospitalFlag="O";
	if (session.getAttribute("hospitalFlag") != null) {
		hospitalFlag = session.getAttribute("hospitalFlag") + "";
	}
	
	String departmentId="5";
	
%>
<%@include file="..//view/commonJavaScript.jsp" %>
</head>
<body>
  <!-- Begin page -->
    <div id="wrapper">
 
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">OPD Waiting List</div>
	 
                    <input type="hidden" id="opdType" name="opdType" value='opd'>
                     <input type="hidden"  name="mmuId" value=<%= session.getAttribute("mmuId") %> id="mmuId" />
									<input type="hidden"  name="userId" value=<%= session.getAttribute("userId") %> id="userId" />
									<input type="hidden"  name="campId" value=<%= session.getAttribute("campId") %> id="campId" />
                    <input type="hidden" id="closeVisitId" name="closeVisitId" value="">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row">
		                               <!--   <div class=" col-md-3">
		                                 	<div class="form-group row">
														<label class="col-sm-5 col-form-label">Department<span class="mandate"><sup>&#9733;</sup></span></label>
														<div class="col-sm-7">
															<select class="form-control" id="opdDepartmentId" onchange="getDepartmentWaitingList()">
															</select>
														  </div>
													     </div>
		                                 </div>  -->
										<div class="col-md-3">
											<div class="form-group row">
											    	
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="mobile_no" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Mobile Number">
												</div>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patient_name" placeholder="">
												</div>
											</div>
										</div>
										<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-4">
													<button type="button" class="btn btn-primary" onclick="searchOpdPreConsultationList()">Search</button>
												
												</div>
												
											</div>
										</div>
										
										
										
										
										<div class="col-md-2">
										<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												</div>
											 
										</div>
                                      

                                    </div>

                                     <div classs="row">
                                     
                                     <div class="col-md-4">
                                     </div>
                                     
                                     </div>

								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>

								<div class="table-responsive">
								<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                             <th style=display:none; >VisitId</th>
											<th style="display: none;">PatientId</th>
											<th>Patient Name</th>
											<th>Age</th>
											<th>Gender</th>
											<th>Department</th>
											<!-- <th>Doctor</th> -->
											<th>Mobile No</th>
											<th>Type Of Patient</th>
											<th><button type='button' id='selectAllCheckBox' onClick='selectAllCheckForClose()' name='selectAllCheckBox' class='btn btn-primary btn-sm'>Select All</button></Button></th>
											<!-- <th>Action</th> -->
										</tr>
                                        </thead>
                                         
                                        <tbody id="tblListofOpdP">
												
                                        </tbody>
                                    </table>
                                    </div>
                                    
                                    <div class="tableLegend">
                                    	<!-- <div class="tbLegendName">
                                    		<div class="colorBox high"></div>
                                    		<label>High</span>
                                    	</div>
                                    	<div class="tbLegendName">
                                    		<div class="colorBox medium"></div>
                                    		<label>Medium</span>
                                    	</div>
                                    	<div class="tbLegendName">
                                    		<div class="colorBox low"></div>
                                    		<label>Low</span>
                                    	</div> -->
                                    	<div class="tbLegendName pull-right">
                                    	<button type='button' id='closeOpd' onClick='event.stopPropagation(); showCloseMessage()' name='closeOpd' class='btn btn-primary btn-sm'>Visit Close</button>
                                    	</div>
                                    </div>
						
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
                  </div>

</div>

<div class="modal" id="messageForCloseBtn" role="dialog">
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
									<span><spring:message code="msgForCloseOpd" /></span> <br />
									
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="rejectOpdWaitList();" aria-hidden="true">
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


</body>
<script type="text/javascript">
	window.history.forward();
	function preventBack() {
		window.history.forward(1);
	}
</script>
 
<script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getOpdPreConsultationList('ALL');
			//getDepartment();
			
		});
	
	
function searchOpdPreConsultationList()
{
		
	var nPageNo=1;	
	 var mobile_no = $j('#mobile_no').val();
	 	var patient_name = $j('#patient_name').val();
	if((mobile_no == undefined || mobile_no == '') && (patient_name == undefined || patient_name == '')){	
		alert("At least one option must be entered");
		return;
	}
	getOpdPreConsultationList('FILTER');
	ResetForm();
} 

function getOpdPreConsultationList(MODE) { 	
 	
	     var cmdId=0;
	     var mobile_no = $j('#mobile_no').val();
	 	var patient_name = $j('#patient_name').val();
	 	var opdType = $j('#opdType').val();
	 	var mmuId = $j('#mmuId').val();
    var cmdId=0;
	 if(MODE == 'ALL'){
		<%--  var data = {"hospitalId": <%=hospitalId%>,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"opdWait","mobileNo":"","patientName":"","opdType":opdType}; --%>
		 var data = {"hospitalId": mmuId,"employeeId": 1,"pageNo":nPageNo,"opdPre":"opdWait","mobileNo":"","patientName":"","opdType":mmuId};
		}
	   else if(mobile_no!=""||patient_name!="")
		{
		nPageNo = 1;
		var data = {"hospitalId": mmuId,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"opdWait","mobileNo":mobile_no,"patientName":patient_name,"opdType":mmuId};
		} 
	   else
		{
		var data = {"hospitalId": mmuId,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"opdWait","mobileNo":mobile_no,"patientName":patient_name,"opdType":mmuId};
		} 
	 
	var url = "getOpdWaitingList";		
	var bClickable = true;
	GetOpdJsonData('tblListofOpdP',data,url,bClickable);
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
 		if(dataList[i].priority==1){	
 			htmlTable = htmlTable+"<tr style='background-color: #ef9999' id='"+dataList[i].visitId+"' >";	
 		   }
 		  else if(dataList[i].priority==2){
 			 htmlTable = htmlTable+"<tr style='background-color: #f4dc92' id='"+dataList[i].visitId+"' >";	  
 		  }
 		 else
			{
 			 htmlTable = htmlTable+"<tr style='background-color: #84e08f' id='"+dataList[i].visitId+"' >";
			}
 			htmlTable = htmlTable +"<td  style=display:none; ><input type='text' value='"+dataList[i].visitId+"' /></td>";
 			htmlTable = htmlTable +"<td  style=display:none;'>"+dataList[i].patientId+"</td>";
 			htmlTable = htmlTable +"<td style='width: 200px;'>"+dataList[i].patinetname+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].ageFull+"</td>"; 
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].gender+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].departmentName+"</td>";
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mobileNumber+"</td>";
 			if(dataList[i].patientType=="G"){	
 	 			htmlTable = htmlTable +"<td style='width: 100px;'>"+'General Citizen'+"</td>";
 	 			}
 	 			else if(dataList[i].patientType=="L"){
 	 				htmlTable = htmlTable +"<td style='width: 100px;'>"+'Labour'+"</td>";
 	 			}
 	 			else
 	 			{
 	 				htmlTable = htmlTable +"<td style='width: 100px;'>"+''+"</td>";
 	 			}
 			
 			//htmlTable = htmlTable +"<td style='width: 100px;'><button type='button' id='closeOpd' onClick='event.stopPropagation(); showCloseMessage("+dataList[i].visitId+")' name='closeOpd' class='btn btn-primary btn-sm'>Close</button></td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'><input type='checkbox' name='urgent' id='check"+dataList[i].visitId+"' onClick='event.stopPropagation();bulkClose(this)' tabindex='1' class='radioAuto' value='' /></td>";  
 			htmlTable = htmlTable+"</tr>";
 		}	
 		}
 	   if(jsonData.status == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofOpdP").html(htmlTable);	
 	
 	
 }
 
 function executeClickEvent(Id)
 {
	 //alert(Id)
	 window.location="getOpdPatientModel?visitId="+Id+"";
	
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getOpdPreConsultationList('FILTER');
 	
 }
 
 function ResetForm()
 {	
 	 $j('#mobile_no').val('');
 	 $j('#patient_name').val('');
 }
 
 function showAll()
 {
	 ResetForm();
 	nPageNo = 1;	
 	getOpdPreConsultationList('ALL');
 	//getDepartment();
 	
 }
 
 
 function getDepartmentWaitingList()
 {
 	
	var departId=$('#opdDepartmentId').val(); 
	var nPageNo=1;	
	var opdType=$('#opdType').val();  	
 	<%-- var data = {"hospitalId": <%= hospitalId %>,"employeeId": <%=userId%>,"departmentId":departId,"opdPre":"opdWait", "serviceNo":"","patientName":"","pageNo":"1","opdType":opdType}; --%>
 	 var data = {"hospitalId": 1,"employeeId": <%=userId%>,"departmentId":2,"opdPre":"opdWait", "serviceNo":"","patientName":"","pageNo":"1","opdType":opdType}; 
 	var bClickable = true;
 	var url = "getOpdWaitingList";
 	GetOpdJsonData('tblListofOpdP',data,url,bClickable);
 }
 
 
	function getDepartment() {

		var pathname = window.location.pathname;
		
		
		
        //var accessGroup = "MMUWeb";
        
        var accessGroup = "MMUWeb";
		
	

        var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/admin/getDepartmentList";
		
		
       
		
		var params = {
			"hospitalID" : "<%= hospitalId %>"
		}

		$j.ajax({
					type : "POST",
					contentType : "application/json",
					url : url,
					data : JSON.stringify(params),
					dataType : "json",
					cache : false,
					success : function(msg) {
						if (msg.status == '1') {

							var comboval = "<option value=\"\">Select</option>";
							for (var i = 0; i < msg.departmentList.length; i++) {

								comboval += '<option value=' + msg.departmentList[i].departmentId + '>'
										+ msg.departmentList[i].departmentname
										+ '</option>';

							}
							$j('#opdDepartmentId').append(comboval);

						}

					},

					error : function(msg) {

						alert("An error has occurred while contacting the server");

					}
				});
	}
	
	function showCloseMessage()
	{
		if(bulkCloseVisit=="")
		{
			
			alert("Please select at-least one opd record")
			return false;
		}	
		//document.getElementById('closeVisitId').value = visitId;
		$('#messageForCloseBtn').show();
		$('#submitMOValidateFormByModelId').attr('disabled',false);
		
	}
	
	function rejectOpdWaitList()
	{
		$('#submitMOValidateFormByModelId').attr('disabled',true);
		//e.stopPropagation();
		var closeVisitId= $('#closeVisitId').val();
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/rejectOpdWaitingList";
		
		$
				.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'visitId' : bulkCloseVisit,
						'mbVisit':"OPD"
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						var datas = response.msg;
						if(datas=="visitStatusUpdated")
						{
								$('#messageForCloseBtn').hide();
								$('.modal-backdrop ').hide();
							    ResetForm();
							 	nPageNo = 1;	
							 	getOpdPreConsultationList('ALL');
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
	
	function closeMessage(){
		$('#messageForCloseBtn').hide();
		$('.modal-backdrop ').hide();
	}
	
	var checkBox='';
	var bulkCloseVisit=[];
	function bulkClose(item) {
		
			 checkBox = $(item).closest('tr').find("td:eq(8)").find(":input").attr("id");
			  var returnvalue = $("#" + checkBox).prop("checked"); 
			  var visitId='';
			  var param='';
			  //alert(returnvalue); 
			 // var text = document.getElementById("text");
			  if (returnvalue==true){
				  visitId=$(item).closest('tr').find("td:eq(0)").find(":input").val();
				  param={'visitId':visitId};
				  bulkCloseVisit.push(param);
				 
			  } else {
				 // alert("Not Selected ")
				  visitId=$(item).closest('tr').find("td:eq(0)").find(":input").val();
				  //bulkCloseVisit.push(visitId);
				  param={'visitId':visitId};
				  
					  var index = bulkCloseVisit.findIndex(function(item, i){
					    return item.visitId === visitId
					  });
					if(index==0)
					{
						bulkCloseVisit.splice(0,1);	
					}	
				  bulkCloseVisit.splice(index,1);
			    // text.style.display = "none";
			  }
			
		
	}
	
	function selectAllCheckForClose()
	{
		  $('#tblListofOpdP tr').each(function(i, el) {
			     var checkBoxidd= $(this).find("td:eq(8)").find("input:eq(0)").attr("id")
			     var checked = $("#" + checkBoxidd).prop("checked",true);
				  var returnvalue = true; 
			   	  var visitId='';
				  var param='';
				  if (returnvalue==true){
					  var $tds = $(this).find('td')
					  visitId=$tds.eq(0).find(":input").val();
					  param={'visitId':visitId};
					  bulkCloseVisit.push(param);
					 
				  }
				  else
				  {
					  return false;
				  }	  
		  });	
	}
 
 
</script>

 
</html>