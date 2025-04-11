<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@include file="..//view/leftMenu.jsp" %> 
  <%@include file="..//view/commonJavaScript.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.5">
    
    <title>Indian Coast Guard</title>
    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
        
        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
    </style>
</head>
<!-- <body class="bg-light"> -->
<body>

 <!-- Begin page -->
    <div id="wrapper">
<div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Appointment  Session</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <!-- <p align="center" id="messageId"></p> -->
                                   <div style="float:left">
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0">			
		                                    <tbody>
		                                    <tr>
												<td class="SearchStatus" style="font-size: 15px; color: green;" align="left"></td>
												<td>
												 <!-- <div id=resultnavigation></div> -->
												</td>
											</tr>
										</tbody>
										</table>
		                                 </div>
		                                 <div style="float:right">
				                                    <div id="resultnavigation"></div> 
		                                    </div>
				                                    <table id="sessionTbl" class="table table-striped table-hover table-bordered">
												           <thead class="bg-success" style="color:#fff;">
												                   <tr>
												                   <!--  <th id="th2" class ="inner_md_htext">Hospital Name</th> -->
												                      <th id="th3" class ="inner_md_htext">Department Name</th>
												                      <th id="th4" class ="inner_md_htext">Appointment Type </th>
												                      <th id="th5" class ="inner_md_htext">Start Time</th>
												                      <th id="th5" class ="inner_md_htext">End Time</th>
												                      <th id="th5" class ="inner_md_htext">Status</th>
												                   </tr>
												               </thead>
												           
												        <tbody class="clickableRow" id="tblListOfAppointmentSession">
														 </tbody>
												       </table>
                                      
                                      
                                     <div class="row">  
								            <div class="col-md-4"> 
												<div class="form-group row">
													<label   class="col-sm-5 col-form-label">Department</label>
													<div class="col-sm-7">
													 <select class="form-control" id="departmentId" name="department">
													  <option value="0" selected="selected">Select</option>
													</select>
													</div>
												</div> 
								            </div>
											
											<div class="col-md-4">
											
											    <div class="form-group row">
													<label for="inputEmail3" class="col-sm-5 col-form-label">Appointment type</label>
													<div class="col-sm-7">
													 <select class="form-control" id="appointmentTypeId" name="appointmentType">
													  <option value="0" selected="selected">Select</option>
													</select>
													</div>
												</div> 
								            </div>
								            
								             <div class="col-md-4">
								             <input type="hidden"  id="status" name="status">
								             </div>
								             
								            <div class="col-md-4">
							                    <div class="form-group row">
							                        <label for="StartTime" class="col-sm-5 col-form-label">Start Time </label>
							                        <div class="col-sm-7">
							
							                            <input type="text" class="form-control" id="startTime" onblur="IsValidTime(this.value,this.id)" onkeyup="mask(this.value,this,'2',':');" placeholder="HH:MM">
							                        </div>
							                    </div>
							            </div>
							            <div class="col-md-4">
							                    <div class="form-group row">
							                        <label for="EndTime" class="col-sm-5 col-form-label">End Time </label>
							                        <div class="col-sm-7">
							                            <input type="text" class="form-control" id="endTime" onblur="IsValidTime(this.value,this.id)" onkeyup="mask(this.value,this,'2',':');" placeholder="HH:MM">
							                        </div>
							                    </div>
							            </div>
							            
										<div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
							            </div>
								            
								  </div>
                                    
                                      <div class="clearfix"></div>
												  <br>
											 <div class="row"> 
												  <div class="col-md-12">
														<div class="btn-left-all">
														 
														</div> 
														<div class="btn-right-all">
															  <button type="button" id="btnAdd" class="btn btn-primary  " onclick="submitAppointmentSession();">Add</button>
			                                                    <button type="button" style="display:none" id ="updateBtn" class="btn btn-primary  " onclick="updateAppointmentSession('y');">Update</button>
			                                                    <button id="btnActive" style="display:none" type="button" class="btn btn-primary  " onclick="updateAppointmentSession('y');">Activate</button>
			                                      				<button id="btnInActive" style="display:none" type="button" class="btn btn-primary  " onclick="updateAppointmentSession('n');">Deactivate</button>
			                                                    <button type="button" class="btn btn-danger " onclick="resetFields();">Reset</button>
				                                                
														</div> 
												  </div> 
											 </div>
							 
                                    
                                    
                                    
                                    
                                    
                                    
                                   
                                 

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
            <!-- content -->

           

        </div>
</div>
<!-- *************************************************************************************** -->
  <script type="text/javascript">
  var nPageNo=1;
  var Status;
  var $j = jQuery.noConflict();

  $j(document).ready(function(){	

  	var dictionary = ${data};
  	var appointmentTypeList=dictionary.appointmentTypeList;
  	var departmentList=	dictionary.departmentList;

	var appointmentTypeValues="";
 	    for(appointmentType in appointmentTypeList){
 	    	appointmentTypeValues += '<option value='+appointmentTypeList[appointmentType].appointmentTypeId+'>'
							+ appointmentTypeList[appointmentType].appointmentTypeName
							+ '</option>';
		 }
		 $j('#appointmentTypeId').append(appointmentTypeValues); 	
		 
  var deptValues="";
      for(dept in departmentList){
				deptValues += '<option value='+departmentList[dept].departmentId+'>'
							+ departmentList[dept].departmentName
							+ '</option>';
		 }
		 $j('#departmentId').append(deptValues);
		 
		 
  			GetAppointmentSession('ALL');
  			
  		});
  		
  function GetAppointmentSession(MODE)
  {
	var hospitalId = $j('#hospitalId').val(); 
  	var cmdId=0;
  	 if(MODE == 'ALL'){
  			var data = {"PN":nPageNo,"hospitalId":hospitalId};			
  		}
  	else
  		{
  		var data = {"PN":nPageNo,"hospitalId":hospitalId};	
  		} 
  	var url = "getAllAppointmentSession";
  		
  	var bClickable = true;
  	GetJsonData('tblListOfAppointmentSession',data,url,bClickable);
  }
  function makeTable(jsonData)
  {	
  	var htmlTable = "";	
  	var data = jsonData.count;
  	var pageSize = 5;
  	var dataList = jsonData.data;
  	
  	for(i=0;i<dataList.length;i++)
  		{		
  		
  		 if(dataList[i].status == 'Y' || dataList[i].status == 'y')
  				{
  					Status='Active'
  						
  				}
  			else
  				{
  					Status='Inactive'
  				}
  		 
  		
  				
  			htmlTable = htmlTable+"<tr id='"+dataList[i].Id+"' >";			
  			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentName+"</td>";			
  			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].apppointmentType+"</td>";
  			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].startTime+"</td>";
  			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].endTime+"</td>";
  			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
  			
  			htmlTable = htmlTable+"</tr>";
  			
  		}
  	if(dataList.length == 0)
  		{
  		htmlTable = htmlTable+"<tr ><td colspan='5'><h6></h6></td></tr>";
  		}			
  	
  	$j("#tblListOfAppointmentSession").html(htmlTable);	
  	
  }  
  
  function executeClickEvent(rowId,jsonData) {
	  
	  var dataList=jsonData.data;
	  for(count in dataList){
			 if(dataList[count].Id===parseInt(rowId)){
				 $j('#rowId').val(dataList[count].Id); 
				 $j('#departmentId').val(dataList[count].departmentId); 
				 $j("#departmentId").prop('disabled',true);
				 $j('#appointmentTypeId').val(dataList[count].apppointmentTypeId); 
				 $j("#appointmentTypeId").prop('disabled',true); 
				 $j('#startTime').val(dataList[count].startTime); 
				 $j('#endTime').val(dataList[count].endTime); 
				 $j('#status').val(dataList[count].status); 
				 
				if(dataList[count].status=="y" || dataList[count].status=="Y"){
					$j("#btnInActive").show();
					$j('#updateBtn').show();
					$j("#btnAdd").hide();
					$j("#btnActive").hide();
				}else{
					$j("#btnAdd").hide();
					$j("#btnInActive").hide();
					$j('#updateBtn').hide();
					$j("#btnActive").show();
				}
			 }
 		 }
  
  } 
  
  </script>
  
        
  <script>
  var successIcon = '<i class="fa fa-check-circle m-r-5"></i>';
  var errorIcon = '<i class="fa fa-times-circle m-r-5"></i>';
  
   function submitAppointmentSession(){
	   $("#btnAdd").attr("disabled", true);
	  var value= validateFields();
	  if(value){
		  var departmentId = $j('#departmentId').find('option:selected').val();	 
			 var appointmentTypeId = $j('#appointmentTypeId').find('option:selected').val();	 
			 var hospitalId = $j('#hospitalId').val(); // This line will remove after updating OSB
			 var startTime = $j('#startTime').val();
			 var endTime =  $j('#endTime').val();
			 var userId =  $j('#userId').val();
			 
			var params = {
				"departmentId":departmentId,
				"appointmentTypeId":appointmentTypeId,
				"hospitalId":hospitalId,
				"startTime":startTime,
				"endTime":endTime,
				"userId":userId
			 } 	
				$j.ajax({
					type : "POST",
					contentType : "application/json",
					url : 'submitappointmentsession',
					data : JSON.stringify(params),
					dataType : "json",
					cache : false,
					success : function(response) {
					if(response.status==1){
						alert(response.msg+'S');
						GetAppointmentSession('ALL');
						resetFields();
						 $("#btnAdd").attr("disabled", false);
					}else{
						alert(response.msg);
						$("#btnAdd").attr("disabled", false);
					}
				},
					error : function(msg) {
						alert("An error has occurred while contacting the server");
						$("#btnAdd").attr("disabled", false);
					}
			    
			});	
	  }
	  else
		  $("#btnAdd").attr("disabled", false);
		 
   } 
   function showResultPage(pageNo)
   {
   nPageNo = pageNo; 
   GetAppointmentSession('FILTER');

   }  
   
   function resetFields(){
	   $j('#departmentId').val("0");
	   $j('#appointmentTypeId').val("0");
	   $j('#departmentId').attr("disabled", false); 
	   $j('#appointmentTypeId').attr("disabled", false); 
	   $j('#startTime').val("");
	   $j('#endTime').val("");
	   $j("#btnInActive").hide();
	   $j("#btnActive").hide();
	   $j('#updateBtn').hide();
	   $j("#btnAdd").show();
	  
   }
  
  function validateFields(){
	  if($j('#departmentId').val()=="0" ){
			alert("Please Select the Department");
			return false;
		}else if($j('#appointmentTypeId').val()=="0"){
			alert("Please Select the Appointment Type");
			return false;
		}else if($j('#startTime').val()=="" ){
			alert("Please Enter the Start Time");
			return false;
		}else if($j('#endTime').val()=="" ){
			alert("Please Enter the End Time");
			return false;
		}else if(compareTime()){
			alert("End time cannot less then or equal to start time.");
			return false;
		}
	  return true;
  } 
  
  
  
  function compareTime(){
	  var dummyDate='01/01/2011';
	  var startTime= dummyDate + " " +$j('#startTime').val();
	  var endTime=dummyDate + " " + $j('#endTime').val();
	 if(Date.parse(startTime) > Date.parse(endTime)){
		 return true;
	 }else if(Date.parse(startTime)==Date.parse(endTime)){
		 return true;
	 }else{
		 return false;
	 }
  }
  
  
   function updateAppointmentSession(btnStatus){
	   var value= validateFields();
		  if(value){
			  $j("#departmentId").prop('disabled',false);
			  $j("#appointmentTypeId").prop('disabled',false);
				 var departmentId = $j('#departmentId').find('option:selected').val();	 
				 var appointmentTypeId = $j('#appointmentTypeId').find('option:selected').val();	
				 var hospitalId = $j('#hospitalId').val(); 
				 var startTime = $j('#startTime').val();
				 var endTime =  $j('#endTime').val();
				 var rowId =  $j('#rowId').val(); 
				 var status = btnStatus; 

					
				 var params = {
						 "rowId":rowId,
						 "departmentId":departmentId,
						 "appointmentTypeId":appointmentTypeId,
						 "hospitalId":hospitalId,
						 "startTime":startTime,
						 "endTime":endTime,
						 "status":status
				       }
					 $j.ajax({
							type : "POST",
							contentType : "application/json",
							url : 'updateAppointmentSession',
							data : JSON.stringify(params),
							dataType : "json",
							cache : false,
							success : function(response) {
								
							//document.getElementById("messageId").innerHTML="";
								
							if(response.status==1){
								
								alert(response.msg+'S');
								
								/* document.getElementById("messageId").innerHTML= successIcon + response.msg;
								$("#messageId").css("color", "#0abb87");
					    		$("#messageId").css("background", "rgba(29, 201, 183, 0.1");
					    		$j("#messageId").animate({height: "34px"},500);
					    		setTimeout(function() {
									
					    			$j("#messageId").animate({height: "0px"},500);
						
							    },3000); */
								GetAppointmentSession('ALL');
								resetFields();
								
							}else{
								alert(response.msg);
							}
						},
							error : function(msg) {
								alert("An error has occurred while contacting the server");
							}
					    
					});	
		  }
   }
   
</script>
</body>
</html>