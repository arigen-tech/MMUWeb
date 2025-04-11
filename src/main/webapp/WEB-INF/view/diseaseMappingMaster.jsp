<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Medical Unit- MMSSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
<%@include file="..//view/commonModal.jsp"%>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>

 <script type="text/javascript">

	var nPageNo=1;
	var $j = jQuery.noConflict();
	var diagnosisList="";
	<% 
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	%>
	
	$j(document).ready(function()
			{
		$j("#btnActive").hide();
		$j("#btnInActive").hide();		
		$j('#updateBtn').hide();	  
		$j('#diseaseTypeCode').attr('readonly', false);		
		GetAllDiseaseMapping('ALL');
		GetDiseaseNameList();			
			});
			
	function GetAllDiseaseMapping(MODE){
		 
		var diseaseName=$("#searchDiseaseName").val();	
		
		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "diseaseName":""};			
			}else{
			var data = {"PN":nPageNo, "diseaseName":diseaseName};
			} 
		var url = "getAllDiseaseMapping";		
		var bClickable = true;
		GetJsonData('tblListOfDiseaseMap',data,url,bClickable);	 
	}

	function makeTable(jsonData)
	{	
		var htmlTable = "";	
		var data = jsonData.count; 
		var diagnosis="";
		var pageSize = 5; 	
		var dataList = jsonData.data; 
		diagnosisList=jsonData.diagnosisData;
		
		for(i=0;i<dataList.length;i++)
			{		
			
			 if(dataList[i].status == 'Y' || dataList[i].status == 'y')
					{
						var Status='Active'
					}
				else
					{
						var Status='Inactive'
					} 		
			 
				for(x=0;x<diagnosisList.length;x++){
					if(diagnosisList[x].diseaseMappingId==dataList[i].diseaseMappingId){
					diagnosis=diagnosisList[x].masIcdName;
					}
				}	
				htmlTable = htmlTable+"<tr id='"+dataList[i].diseaseMappingId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diseaseName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+diagnosis+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfDiseaseMap").html(htmlTable); 	
		
	}

	var disMapId;
	var diseaseId;
	var diagnosisId;
	var Status;
	function executeClickEvent(diseaseMapId,data)
	{
		for(j=0;j<data.data.length;j++){
			if(diseaseMapId == data.data[j].diseaseMappingId){
				disMapId = data.data[j].diseaseMappingId;			
				diseaseId = data.data[j].diseaseId;			
				diagnosisId = data.data[j].masIcId;
				Status = data.data[j].status;
				
			}
		}
		rowClick(disMapId,diseaseId,diagnosisId,Status);
	}
	
	function rowClick(disMapId,diseaseId,diagnosisId,Status){	
		$('#diagnosisId').html("");	
		document.getElementById("diseaseName").value = diseaseId;
					   						   					   			
		 var combo = '<option value=""></option>';	    	
	    	for(var i=0;i<diagnosisList.length;i++){
		    		if(disMapId==diagnosisList[i].diseaseMappingId)	{
			    	var arrayId=diagnosisList[i].masIcId.split(",");
			    	var arrayName=diagnosisList[i].masIcdName.split(",");			    	
			    	for(var k=l=0;k<arrayId.length && arrayName.length; k++,l++){

			    		combo += '<option value='+arrayId[k]+'>'+arrayName[l].replace("; ",", ")+'</option>';

				    }	
			    					    		
		    	}
	      }
	     $('#diagnosisId').append(combo); 
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddDiseaseMapping').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDiseaseMapping').hide();
		}

			
	}


		function addDiseaseMapping(){
			
			if(document.getElementById('diseaseName').value == null || document.getElementById('diseaseName').value == ""){
				alert("Please Select Disease Name");
				return false;
			}
			
           var digCount=document.getElementById('diagnosisId').length;
			
			
			if(total_icd_value=="") {
				if(digCount==0){
            	alert("Please enter at least one ICD Diagnosis");
            	document.getElementById('icd').focus();
                return false;
				}
              }

			
			var diagnosis = "";
			$("#diagnosisId option").each(function()
					{
				diagnosis += (diagnosis == "") ? "" : ",";
				diagnosis += $(this).val();
					    
				});
			$('#btnAddDiseaseMapping').prop("disabled",true);
			
			var params = {		
					
					 'diseaseId':jQuery('#diseaseName option:selected').val(),
					 "diagnosis" : diagnosis,
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addDiseaseMapping";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateDiseaseMapping(){	
			if(document.getElementById('diseaseName').value == null || document.getElementById('diseaseName').value == ""){
				alert("Please Select Disease Name");
				return false;
			}
			
           var digCount=document.getElementById('diagnosisId').length;
			
			if(total_icd_value=="") {
				if(digCount < 2){
            	alert("Please enter at least one ICD Diagnosis");
            	document.getElementById('icd').focus();
                return false;
				}
              }

			
			var diagnosis = "";
			$("#diagnosisId option").each(function()
					{
				diagnosis += (diagnosis == "") ? "" : ",";
				diagnosis += $(this).val();
					    
				});	

			var params = {
					'diseaseMappingId':disMapId,
					'diseaseId':jQuery('#diseaseName option:selected').val(),
					 "diagnosis" : diagnosis,
					 'userId': <%= userId%>
					
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateDiseaseMapping";
				    SendJsonData(url,params);
					$j('#btnAddDiseaseMapping').attr("disabled", false);
					$j('#diseaseCode').attr('readonly', true);
					ResetForm();
		}
		
		function updateDiseaseMappingStatus(){			
			
			var params = {
					
					'diseaseMappingId':disMapId,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateDiseaseMappingStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			$('#diagnosisId').html("");	
			$j('#searchDiseaseName').val('');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDiseaseMapping').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#diseaseName').val('');
			$j('#searchDiseaseName').val('');
			$('#diagnosisId').html("");	
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllDiseaseMapping('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDiseaseMapping').show();
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllDiseaseMapping('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchDiseaseName').value == ""){
		  		alert("Please Enter Disease Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllDiseaseMapping('FILTER');
		 }
		 
		 function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateDiseaseMappingReport";
			 openPdfModel(url)
			 
		 	/* document.searchDiseaseForm.action="${pageContext.request.contextPath}/report/generateDiseaseMappingReport";
		 	document.searchDiseaseForm.method="POST";
		 	document.searchDiseaseForm.submit();  */
		 	
		 }

		 function GetDiseaseNameList(){
				jQuery.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: "getAllDisease",
				    data: JSON.stringify({"PN" : "0"}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].diseaseId+'>' +result.data[i].diseaseName+ '</option>';
				    		
				    	}
				    	jQuery('#diseaseName').append(combo);
				    }
				    
				});
			}

		 var total_icd_value = '';
         var digaoReferal=''; 
         
           function fillDiagnosisComboMaster(val) {
           	  
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
                   for(var i=0;i<autoIcdCode.length;i++){
                		  
                		  var icdNo1 = icdData[i].icdCode;
                		 
                		  if(icdNo1 == idIcdNo){
                			icdValue = icdData[i].icdId;
                			
                			digaoReferal=icdValue;
                			 $("#diagnosisId option").each(function()
                             		{
                             		    if($(this).val()==icdValue){
                             		    alert("ICD diagnosis is already added");
                             		    document.getElementById('icd').value = ""
                             		    b=true;
                             		    }
                             		});
                		  }
                	  }
                   if (b == "false") {
                   	
                       $('#diagnosisId').append('<option value=' + icdValue + '>' + val + '</option>');
                       document.getElementById('icd').value = ""

                   }
               }
           }


		 function deleteDgItems(value) {
			 
			 
			 
			 /* if((document.getElementById('diagnosisId').value == '' || document.getElementById('diagnosisId').value == undefined) || 
					 (document.getElementById('diagnosisName').value == '' || document.getElementById('diagnosisName').value == undefined)){

				 alert("diagnosisId :" + diagnosisId);
					alert("Please select at least one diagnosis");
					return;
				} */

             if (confirm(resourceJSON.opdIcdDeleteMsg)) {

                 if (document.getElementById('diagnosisId').options[document.getElementById('diagnosisId').selectedIndex].value != null)
                     document.getElementById('diagnosisId').remove(document.getElementById('diagnosisId').selectedIndex)

             }
         } 
</script> 
</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">
 
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Disease and Diagnosis mapping Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                       <input type="hidden"  name="userId" value=<%=userId%> id="userId" />
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDiseaseForm"
												name="searchDiseaseForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Disease Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDiseaseName" id="searchDiseaseName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Disease Name">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary "
																onclick="search()">Search</button>
														</div>
													</div>
												</div>
											</form>

										</div>
										 <div class="col-md-4">
											<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
													
													<button type="button" class="btn  btn-primary "
														id="printReportButton" 
															onclick="generateReport()">Reports</button>
												<!-- <button type="button" class="btn  btn-primary "
													onclick="generateReport()">Reports</button> -->
											</div>
										</div>
									</div> 
                                    
		
			                     <div style="float:left">
               
                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
                                        <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
                                              <td>          
           
							                         </td>
							           </tr>
							         </table>
                                  </div>  
                                     <div style="float:right">
                                       <div id="resultnavigation">
                                       </div> 
                                     </div> 

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th2" class ="inner_md_htext">Disease Name</th>
                                                <th id="th3" class ="inner_md_htext">Diagnosis</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfDiseaseMap">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSampleForm" name="addSampleContainerForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Disease Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="diseaseName" name="diseaseName"></select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
												<div class="form-group row  autocomplete">

												<label class="col-md-6 col-form-label"> 
														Diagnosis <span class="mandate"><sup>&#9733;</sup></span> </label>
													<div class="col-md-6">
														<input name="icddiagnosis" id="icd" type="text"
													class="form-control border-input"
													placeholder="Diagnosis" value=""  onKeyUp="getNomenClatureList(this,'fillDiagnosisComboMaster','opd','getIcdListByName','dignosisSHO');"   />
														<div class="autocomplete-itemsNew" id="icdDiagnosisMas" ></div>
														<input type="hidden" name="diagnosisSSHO" id="icdDiagnosisMas">
													</div>

												</div>
											</div>
								
								<div class="col-md-3">
												<select name="diagnosisId" multiple="4" size="5"
													tabindex="1" id="diagnosisId" class="listBig width-full"
													validate="ICD Daignosis,string,yes">
												</select>
								</div>                                                 
                                 <div class="col-md-1">
												<button type="button" class="buttonDel btn  btn-danger" id="delBtn"
													value="" onclick="deleteDgItems(this,'diagnosisId');"
													align="right" />Delete</button>				
											
								</div>
								<div class="w-100 m-t-10"></div>                        
                                                    
                                                 </div>
                                                    
                                                    
                                                    <div class="col-md-4">
												        <input type="hidden"  id="rowId" name="rowId">																													
									                </div>
                                                    
                                                </div>
                                            </form>
                                        </div>

                                  
									
         							<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddDiseaseMapping"
															class="btn  btn-primary " onclick="addDiseaseMapping();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDiseaseMapping();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDiseaseMappingStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDiseaseMappingStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
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
            <!-- content -->

        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>