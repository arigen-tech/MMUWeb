<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript">
	nPageNo = 1;
	var $j = jQuery.noConflict();
	$j(document).ready(function() {
		displayApplication();
		$j('#btnTemplateAssignment').hide();
		$j('#tblHeaderListOfApplicationTemplateWise').hide();
	});
	
	
	var comboArray=[];
	function displayApplication(){
		
		$j('#selectModuleTemplateWise').html("");
		$j('#selectModuleTemllateWiseId').show();
		
		jQuery.ajax({
			method:"POST",
			url:"getModuleNameTemplateWise",
			data: JSON.stringify({}),
			contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){		    	
			var combo = "<option value='0'>Module Name</option>" ;		    	
		    	for(var i=0;i<result.listObjModule.length;i++){
		    		comboArray[i] = result.listObjModule[i].applicationId;		    		
		    		combo += '<option value='+result.listObjModule[i].applicationId+'>' +result.listObjModule[i].applicationName+ '</option>';		    		    		
		    	}		    	    	
				$j('#selectModuleTemplateWise').append(combo); 
		    }
		})
		
	}
	var templateIdd;
	function populateApplicationAndTemplates(parentId){
		if(document.getElementById('selectModuleTemplateWise').value == 0){
			$j('#tblListOfApplicationTemplateWise').hide();
			$j('#btnTemplateAssignment').hide();
			return false;
		}else{
			$j('#tblListOfApplicationTemplateWise').show();
			$j('#tblHeaderListOfApplicationTemplateWise').show();
		} 
		
		params={"parentId":parentId}
		
		var htmlTable = "";
			jQuery.ajax({
				method:"POST",
				data: JSON.stringify(params),
				url:"getAllApplicationOfSelectedParentId",				
				contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	if(result.status=="1"){
			    		var rownum=1;
				    	var dataList = result.data;
				    	for(i=0;i<dataList.length;i++){	  	
				    		var optionvalue = '';
				    		var parentId = dataList[i].parentId;
				    		var sequenceId = dataList[i].sequenceNo;
				    		htmlTable = htmlTable+"<input type='hidden' name='applicationId' value="+dataList[i].applicationId+" id='applicationId"+i+"'/>";
				    		htmlTable = htmlTable+"<tr id='"+dataList[i].applicationId+"' >";			
					 			if(parentId!=0){
					 				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].partentApplicationName+"&nbsp;"+"<i class='fa fa-long-arrow-alt-right'></i>"+"&nbsp"+dataList[i].applicationName+"</td>";
						 			htmlTable = htmlTable+"<td style='width: 50px;'><select name='sequenceNo' id='sequenceNo"+i+"' class='form-control' onchange='checkexistingSequence(this.id,this.value)'>";  
					 				htmlTable = htmlTable+"<option value='0'>Select</option>";
					 				 for(j=1;j<dataList.length;j++){	
						 					if (parseInt(sequenceId) == j) {
												 selectCategory = 'selected';
												 htmlTable = htmlTable+'<option ' + selectCategory + ' value='+dataList[i].sequenceNo+'>'+dataList[i].sequenceNo+'</option>';
												} else {
												  selectCategory = "";
												  htmlTable = htmlTable+'<option ' + selectCategory + 'value='+j+'>'+j+'</option>';
												}
						 				}
					 				htmlTable = htmlTable+'</select>';
					 				htmlTable = htmlTable+"</td>";
				 					htmlTable = htmlTable+"</tr>";
					 			}
				 			rownum++;
				 			
				 		}
				    	if(dataList.length == 0)
				 		{
				 		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
				 		   
				 		}			    	
				    	$j("#tblListOfApplicationTemplateWise").html(htmlTable);
				    	
			    	}else{
						alert("No Application assigned with selected module.");	
			    	}
			    }
			})
			$j('#btnTemplateAssignment').show();
			$j('#btnTemplateAssignment').attr("disabled", false);
	}
	
	var checkBoxArray=[];
	var applicationIdAarray=[];
	var applicationSequenceAarray=[];
	function addTemplateApplication(){
		$j('#btnTemplateAssignment').attr("disabled", true);
		
		if(document.getElementById('selectModuleTemplateWise').value== "0"){
			alert("Please Select Module Name");
			return false;
		} 
		var tbl = document.getElementById('tblListOfApplicationTemplateWise');
		var parentId = document.getElementById('selectModuleTemplateWise').value;
		lastRow = tbl.rows.length;
		 for(var j=0;j<lastRow-1;j++){
			 
			var applicationId = document.getElementById('applicationId'+j).value;		    
		    applicationIdAarray.push(applicationId);	
		    
		    var applicationSequence = document.getElementById('sequenceNo'+j).value;		    
		    applicationSequenceAarray.push(applicationSequence);	
		    
		 } 
		    var params={
				 	'applicationIdAarray':applicationIdAarray,
				 	'applicationSequenceAarray':applicationSequenceAarray,
				 	"parentId":parentId
				 	}
		    jQuery.ajax({
				method:"POST",
				data: JSON.stringify(params),
				url:"setSequenceToApplication",				
				contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	if(result.status==1){			    		
			        	document.getElementById("messageId").innerHTML = result.msg;
			        	alert(result.msg+'S');
			        	document.addEventListener('click',function(e){
	   					    if(e.target && e.target.id== 'closeBtn'){
	   	   	   				 	window.location.reload();
	   					     }
	   					 });
			    	}
			    },
				error : function(msg) {
					alert("An error has occurred while contacting the server");
					window.location.reload();
				}
			    });
		    
			
	}
	function checkexistingSequence(currentRowId,currentValue){
		 $('#tblListOfApplicationTemplateWise tr').each(function(i, el) {
			 var $tds = $(this).find('td');
			 var selectSequenceId=$($tds).closest('tr').find("td:eq(1)").find("select:eq(0)").attr("id");
			 var selectValue=$('#'+selectSequenceId).val();
				 if(selectSequenceId!=currentRowId && currentValue==selectValue){
					 alert("Sequence is already selected");
					 $('#'+currentRowId).val("0");
				        return false;
				 }
		 });
	}
	</script>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<!-- ========== Left Sidebar Start ========== -->

		<!-- Left Sidebar End -->

		<!-- ============================================================== -->
		<!-- Start right Content here -->
		<!-- ============================================================== -->
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
				<div class="internal_Htext">Assign Sequence To Application</div>
					<div class="row">
						
					</div>
					<!-- end row -->

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<p align="center" id="messageId"
										style="color: green; font-weight: bold;"></p>
									 
									<form class="form-horizontal" id="searchTemplateForm" name="searchTemplateForm" method="" role="form">
									
                                       <div class="row">
										<div class="col-md-8">
												<div class="form-group row" id="selectModuleTemllateWiseId">
												     <label class="col-md-3 col-form-label inner_md_htext">Module Name<span style="color: red">*</span>
													 </label>
													<div class="col-md-5">
															<select class="form-control assign_app_input" id="selectModuleTemplateWise" name="selectModuleTemplateWise" onchange="populateApplicationAndTemplates(this.value);">
															</select>																
															 
													</div>
													<div class="col-md-2">
													</div> 
												</div>
										</div>
										<div class="col-md-4">
										</div>
									</div>
									 </form>
									
									
									

									
									
									<table class="table table-hover table-striped table-bordered">
										<thead class="bg-success" style="color: #fff;" id="tblHeaderListOfApplicationTemplateWise">
										<tr>
												<th id="th1" class="inner_md_htext">Assigned Module</th>
												<th id="th2" class="inner_md_htext">Sequence</th>
											</tr>											
										</thead>
										<tbody id="tblListOfApplicationTemplateWise">

										</tbody>
									</table>

									
								   <div class="clearfix"></div>								
								        
										<div class="row">		 
										 <div class="col-md-12">
															<div class="btn-left-all">																 
															</div> 
															<div class="btn-right-all">
																<button id="btnTemplateAssignment" type="button"
														class="btn btn-primary"
														onclick="addTemplateApplication();">Save</button>
															</div> 
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

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>