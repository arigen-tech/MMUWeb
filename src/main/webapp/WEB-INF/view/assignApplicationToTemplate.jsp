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
		
		GetTemplateList();
		$j('#selectModuleTemllateWiseId').hide();
		$j('#btnTemplateAssignment').hide();
		$j('#tblHeaderListOfApplicationTemplateWise').hide();
	});
	
	var moduleList='';
	var comboArray=[];
	function GetTemplateList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getTemplateList",
		    data: JSON.stringify({}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	//alert("success "+result.data.length);
		    	var combo = "<option value='0'>Select Template</option>" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		comboArray[i] = result.data[i].templateName;
		    		combo += '<option value='+result.data[i].templateId+'>' +result.data[i].templateName+ '</option>';
		    		
		    	}		    	
		    	jQuery('#selectTemplate').append(combo);
		    }
		    
		});
	}
	
	function searchApplication(){
		
		/* if(document.getElementById('selectModuleTemplateWise').value == 0){			
			$j('#btnTemplateAssignment').hide();
			return false;
		}else{
			$j('#btnTemplateAssignment').show();
		}  */
		
		var htmlTable = "";	
		var tempId = $j('#selectTemplate').find('option:selected').val();
			$j('#tblListOfApplicationTemplateWise').html("");
			$j('#selectModuleTemplateWise').val(0);
		param={"templateId":tempId}
		jQuery.ajax({
			method:"POST",
			url:"getModuleNameTemplateWise",
			data: JSON.stringify(param),
			contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var rownum=1;
		    	var dataList = result.data;
		    	
		    	for(i=0;i<dataList.length;i++)
		 		{	  		
		    		htmlTable = htmlTable+"<tr id='"+dataList[i].tempappId+"' >";			
		 			htmlTable = htmlTable +"<td style='width: 150px;'>"+rownum+"</td>";
		 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].name+"</td>";
		 			/* htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].templateId+"</td>"; */
		 			htmlTable = htmlTable+"</tr>";
		 			rownum++;
		 		}
		    	if(dataList.length == 0)
		 		{
		 		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		 		   
		 		}
		    	$j("#tblListOfApplication").html(htmlTable);
		    			    		
		    	
		    }
		})
		$j('#btnTemplateAssignment').attr("disabled", false);
	}
	
	function displayApplication(){
		
		 if(document.getElementById('selectTemplate').value == "0"){
			alert("Please Select the Template Name");
			return false;
		} 
		$j('#selectModuleTemplateWise').html("");
		$j('#selectModuleTemllateWiseId').show();
		
		jQuery.ajax({
			method:"POST",
			url:"getModuleNameTemplateWise",
			data: JSON.stringify(param),
			contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){		    	
			var combo = "<option value='0'>Module Name</option>" ;		    	
		    	for(var i=0;i<result.listObjModule.length;i++){
		    		//alert("aa :: "+result.listObjModule[i].applicationId);
		    		comboArray[i] = result.listObjModule[i].applicationId;		    		
		    		combo += '<option value='+result.listObjModule[i].applicationId+'>' +result.listObjModule[i].applicationName+ '</option>';		    		    		
		    	}		    	    	
				$j('#selectModuleTemplateWise').append(combo); 
		    }
		})
		
	}
	var templateIdd;
	function populateApplicationAndTemplates(parentId){
		//alert(parentId);
		if(document.getElementById('selectModuleTemplateWise').value == 0){
			$j('#tblListOfApplicationTemplateWise').hide();
			$j('#btnTemplateAssignment').hide();
			return false;
		}else{
			$j('#tblListOfApplicationTemplateWise').show();
			$j('#tblHeaderListOfApplicationTemplateWise').show();
		} 
		
		var tempId = $j('#selectTemplate').find('option:selected').val();
		//alert("tempId :: "+tempId);
		params={"parentId":parentId,
				"templateId":tempId}
		
		var htmlTable = "";
			jQuery.ajax({
				method:"POST",
				data: JSON.stringify(params),
				url:"getAllApplicationAndTemplates",				
				contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	if(result.jsonStatus=="1"){
			    		var rownum=1;
				    	var dataList = result.data;
				    	var tempList = result.tempList;
				    	 /*  for(j=0;tempList.length;j++){
				    		templateIdd = tempList[j].templateId;
				    		alert("templateIdd :: "+templateIdd);
				    	}   */
				    	
				    	var checkboxvalue='';
				    	for(i=0;i<dataList.length;i++){	  	
				    		var checkbox_name = '';
				    		var checkbox = '';
				    		var parentId = dataList[i].parentId;
				    		//alert("parentId:: "+parentId);
				    		htmlTable = htmlTable+"<input type='hidden' name='applicationId' value="+dataList[i].applicationId+" id='applicationId"+i+"'/>";
				    		htmlTable = htmlTable+"<input type='hidden' name='templateId' value="+dataList[i].templateId+" id='templateId"+i+"'/>";
				    		
				    		htmlTable = htmlTable+"<tr id='"+dataList[i].applicationId+"' >";			
				 			htmlTable = htmlTable +"<td style='width: 150px;'>"+rownum+"</td>";
					 			if(parentId!=0){
					 				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].applicationName2+"&nbsp;"+"<i class='fa fa-long-arrow-alt-right'></i>"+"&nbsp"+dataList[i].applicationName+"</td>";
					 			}
					 			else{
					 				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].applicationName+"</td>";
					 								 				
					 			}
				 			
				 			var appId=dataList[i].applicationId;
				 						 				
				 				if(dataList[i].status == 'Y' || dataList[i].status =='y'){
				 					//htmlTable =htmlTable +"<td style='width: 150px;'><input type='checkbox' checked name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'></td>";
				 					
				 					htmlTable =htmlTable +"<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-5'><input type='checkbox' class='form-check-input' checked name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'><span class='cus-checkbtn'></span></div></td>";
				 				}
				 				else if(dataList[i].parentId == 0){
				 					
				 					//htmlTable =htmlTable +"<td style='width: 150px;'><input type='checkbox' enabled name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'></td>";
				 					
				 					htmlTable =htmlTable +"<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-5'><input type='checkbox' enabled class='form-check-input' name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'><span class='cus-checkbtn'></span></div></td>";				 					
				 				}
				 				else{
				 					//htmlTable =htmlTable +"<td style='width: 150px;'><input type='checkbox' name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'></td>";
				 					
				 					htmlTable =htmlTable +"<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-5'><input type='checkbox' class='form-check-input' name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'><span class='cus-checkbtn'></span></div></td>";
				 				}
				 			
				 			htmlTable = htmlTable+"</tr>";
				 			rownum++;
				 			
				 		}
				    	if(dataList.length == 0)
				 		{
				 		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
				 		   
				 		}			    	
				    	$j("#tblListOfApplicationTemplateWise").html(htmlTable);
				    	
			    	}else{
			    		
			    		var rownum=1;
				    	var dataList = result.data;
				    	var tempList = result.tempList;
				    	var checkboxvalue='';
				    	for(i=0;i<dataList.length;i++){	  	
				    		var checkbox_name = '';
				    		var checkbox = '';
				    		var parentId = dataList[i].parentId;
				    		htmlTable = htmlTable+"<input type='hidden' name='applicationId' value="+dataList[i].applicationId+" id='applicationId"+i+"'/>";
				    		htmlTable = htmlTable+"<input type='hidden' name='templateId' value='' id='templateId"+i+"'/>";
				    		
				    		htmlTable = htmlTable+"<tr id='"+dataList[i].applicationId+"' >";			
				 			htmlTable = htmlTable +"<td style='width: 150px;'>"+rownum+"</td>";
					 			if(parentId!=0){
					 				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].applicationName2+"&nbsp;"+"<i class='fa fa-long-arrow-alt-right'></i>"+"&nbsp"+dataList[i].applicationName+"</td>";
					 			}
					 			
					 			else{
					 				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].applicationName+"</td>";
					 								 				
					 			}
				 			
				 			var appId=dataList[i].applicationId;
				 			
				 			if(dataList[i].parentId == 0){
				 				
			 					//htmlTable =htmlTable +"<td style='width: 150px;'><input type='checkbox' checked name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'></td>";
			 					
			 					htmlTable =htmlTable +"<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-5'><input type='checkbox' class='form-check-input' checked name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'><span class='cus-checkbtn'></span></div></td>";
			 					
			 				}else{
			 					//htmlTable =htmlTable +"<td style='width: 150px;'><input type='checkbox'  name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'></td>";
			 					
			 					htmlTable =htmlTable +"<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-5'><input type='checkbox' class='form-check-input'  name='checkBoxTemp' "+checkboxvalue+" id='checkBoxTemp"+i+"'><span class='cus-checkbtn'></span></div></td>";
			 				}
				 			htmlTable = htmlTable+"</tr>";
				 			rownum++;
				 			
				 		}
				    	if(dataList.length == 0)
				 		{
				 		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
				 		   
				 		}			    	
				    	$j("#tblListOfApplicationTemplateWise").html(htmlTable);
				    	
			    	}
			    	
			    }
			})
			
		
		
			$j('#btnTemplateAssignment').show();
			$j('#btnTemplateAssignment').attr("disabled", false);
	}
	
	var checkBoxArray=[];
	var applicationIdAarray=[];
	var templateIdArray=[];
	function addTemplateApplication(){
		
		$j('#btnTemplateAssignment').attr("disabled", true);
		
		if(document.getElementById('selectTemplate').value == "0"){
			alert("Please Select Template Name");
			return false;
		}
		if(document.getElementById('selectModuleTemplateWise').value== "0"){
			alert("Please Select Module Name");
			return false;
		} 
		var tempId = $j('#selectTemplate').find('option:selected').val();		
		var tbl = document.getElementById('tblListOfApplicationTemplateWise');
		var parentId = document.getElementById('selectModuleTemplateWise').value;
		
		lastRow = tbl.rows.length;
		//alert("lastRow ::"+lastRow);
		var labMarkValue = ''; 
		 for(var j=0;j<lastRow;j++){
		    var chkbox = 'checkBoxTemp'+j+'';
		    var statusflag='';
		    if(document.getElementById(chkbox).checked == true){
		    	var yflag='y';
		    		statusflag=yflag;
		    		checkBoxArray.push(statusflag);			    		
		    }else{
		    	var nflag='n';
		    	statusflag=nflag;
		    	checkBoxArray.push(statusflag);
		    }
				//alert("checkBoxArray ::"+checkBoxArray);
				
			var applicationId = document.getElementById('applicationId'+j).value;		    
		    applicationIdAarray.push(applicationId);	
		    
		    var templatesId = document.getElementById('templateId'+j).value;
		    templateIdArray.push(templatesId);
		    //alert("templateIdArray ::"+templateIdArray)
		 } 
		    var params={
				 	'applicationIdAarray':applicationIdAarray,
				 	'templateId':tempId,
				 	'checkBoxArray':checkBoxArray,
				 	'templateIdArray':templateIdArray,
				 	"parentId":parentId
				 	}
		    //alert(JSON.stringify(params));
		    jQuery.ajax({
				method:"POST",
				data: JSON.stringify(params),
				url:"addTemplateApplication",				
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
		    //
		    
			//}
		    
			
	}
	//multiselect checkboxes.
	function multiselectCheckBox(source){
		
		var checkboxes = document.getElementsByName('checkBoxTemp');
		for(var i in checkboxes)
			checkboxes[i].checked = source.checked;
		
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
				<div class="internal_Htext">Assign Menu To Template</div>
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
											
												<!-- <input type="hidden" name="tempCheckValue" id="tempCheckValue"/> -->
												<div class="form-group row">
													<label class="col-md-3 col-form-label inner_md_htext">Template
														Name<span class="mandate"><sup>&#9733;</sup></span>
													</label>
													<div class="col-md-5">
														 														 
															<select class="form-control" id="selectTemplate" name="selectTemplate" onchange="searchApplication();">
																
															</select>											 
														 
													</div>
													
													<!-- <div class="col-md-6">
														<div class="col-auto">															 
															<select class="form-control" id="selectTemplate" name="selectTemplate" onchange="searchApplication();">
																
															</select>											 
														</div>
													</div>
													 -->
													
													
													
													
													
													<div class="col-md-2">
														<button id="searchBtn" type="button"
															class="btn  btn-primary asign-search"
															onclick="displayApplication();">Application</button>
													</div>
												</div>
												
												
												<div class="form-group row" id="selectModuleTemllateWiseId">
												     <label class="col-md-3 col-form-label inner_md_htext">Module Name<span style="color: red">*</span>
													 </label>
													<div class="col-md-5">
														 
															<select class="form-control assign_app_input" id="selectModuleTemplateWise" name="selectModuleTemplateWise" onchange="populateApplicationAndTemplates(this.value);">
																
															</select>																
															 
													</div>
													<!-- <div class="col-md-5">
														<div class="col-auto">
															<div class="input-group mb-2"  style="width:303px !important;">
															<select class="form-control assign_app_input" id="selectModuleTemplateWise" name="selectModuleTemplateWise" onchange="populateApplicationAndTemplates(this.value);">
																
															</select>																
															</div>
														</div>
													</div> -->
													
													<div class="col-md-2">
														
													</div> 
													
													
												</div>
											

										</div>
										
										<div class="col-md-4">
										</div>
										 
                                    
									</div>
									
									
									 </form>
									
									
									

									<table class="table table-hover table-striped table-bordered">
										<thead class="bg-success" style="color: #fff;">
											<tr>
												<th id="th2" class="inner_md_htext">Sr No</th>
												<th id="th3" class="inner_md_htext">Assigned Module</th>
											</tr>
										</thead>
										<tbody id="tblListOfApplication">

										</tbody>
									</table>
									
									<table class="table table-hover table-striped table-bordered">
										<thead class="bg-success" style="color: #fff;" id="tblHeaderListOfApplicationTemplateWise">
										<tr>
												<th id="th2" class="inner_md_htext">Sr No</th>
												<th id="th3" class="inner_md_htext">Assigned Module</th>
												<th id="th4" class="inner_md_htext">
												<!-- <input type="checkbox" id="checkBoxTemp" name="checkBoxTemp" onclick="multiselectCheckBox(this);"> Select All -->
												<div class="form-check form-check-inline cusCheck m-l-5">
													<input class="form-check-input" type="checkbox" id="checkBoxTemp" name="checkBoxTemp" onclick="multiselectCheckBox(this);">
													<span class="cus-checkbtn"></span> 
													<label class="form-check-label" for="checkBoxTemp">Select All</label>
												</div>
												</th>
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
  
								
								
									<%-- <div class="row">
										<div class="col-md-7"></div>
										<div class="col-md-5">
											<form>
												<div class="button-list">

													<button id="btnTemplateAssignment" type="button"
														class="btn btn-primary btn-rounded w-md waves-effect waves-light"
														onclick="addTemplateApplication();">Save</button>
													

												</div>
											</form>
										</div>

									</div> --%>

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