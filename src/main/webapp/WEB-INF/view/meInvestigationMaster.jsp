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
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
  <%  
	
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
		
	}
	
	%>

<script type="text/javascript">

var comboArrayRoles =[];
var comboArrayDesignation = [];
var $j = jQuery.noConflict();
var dataList="";
$j(document).ready(function()
		{
	
		ageCombo();
		$j("#btnActive").hide();
		$j("#btnInActive").hide();		
		$j('#updateBtn').hide();  
			
		//getInvestigationNameList();		
		getAllInvestigationMappingList('ALL');
		});

function search(){
	if(document.getElementById('searchInvestigation').value == 0){
		alert("Please Enter Age");
		return false;
	}
	nPageNo=1;
	getAllInvestigationMappingList('Filter');
}


function ageCombo(){
	
	var select = '';
	select += "<option value='0' disabled>Select</option>";
	for (i=15;i<=60;i++){
	    select += '<option value=' + i + '>' + i + '</option>';
	}
	$('#investigationAge').html(select);
	
}

function getInvestigationNameList(){	
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getInvestigationNameList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){	    	
	    	var combo = "<option value='0' disabled>Select</option>" ;	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArrayRoles[i] = result.data[i].id;
	    		combo += '<option value='+result.data[i].id+'>' +result.data[i].name+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    	}
	    	jQuery('#investigationName').append(combo);	    	
	    }
	    
	});
		
}



function getAllInvestigationMappingList(MODE){
	var age=$j("#searchInvestigation").val();	
	
	var designationId = $j('#searchDesignation').find('option:selected').val();
	var roleDesigId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"age":""};
			
		}
	else
		{
		
		var data = {"PN":nPageNo, "age":age};
		} 
	 
	var url = "getAllInvestigationMapping";		
	var bClickable = true;
	GetJsonData('tblListOfInvMapping',data,url,bClickable);
}

function makeTable(jsonData)
{	
	
	var htmlTable = "";	
	var data = jsonData.count;
	
	var pageSize = 5;	
	 dataList = jsonData.data;
	
	for(i=0;i<dataList.length;i++){		
		 if(dataList[i].status == 'Y' || dataList[i].status == 'y'){
					Status='Active'						
				}else{
					Status='Inactive'
				}
		
		
			htmlTable = htmlTable+"<tr id='"+dataList[i].investignationMappingId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].age+"</td>";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+"<input type='hidden' value='"+dataList[i].investigationId+"' id='meinv'>" +dataList[i].investigationName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";			
			htmlTable = htmlTable+"</tr>";			
		}
		if(dataList.length == 0){
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";		   
		}			
	
	$j("#tblListOfInvMapping").html(htmlTable);	
	
	
}


var investigationId;
var investigationName;
var status;
var age;
var invMapid;
function executeClickEvent(investignationMappingId,data)
{
	for(j=0;j<data.data.length;j++){
		
		if(investignationMappingId == data.data[j].investignationMappingId){
			investigationId = data.data[j].investigationId;			
			investigationName = data.data[j].investigationName;	
			age=data.data[j].age;
			invMapid=data.data[j].investignationMappingId;
			status = data.data[j].status;
		}
	}
	
	rowClick(investigationId,investigationName,status,age,invMapid);
}

  function rowClick(investigationId,investigationName,status,age,invMapid){
	  $('#investigationId').html('');
		  var combo = '<option value=""></option>';	    	
	   	  for(var i=0;i<dataList.length;i++){
		    		if(invMapid==dataList[i].investignationMappingId)	{
			    	var arrayId=dataList[i].investigationId.split(",");
			    	var arrayName=dataList[i].investigationName.split(",");			    	
			    	for(var k=l=0;k<arrayId.length && arrayName.length; k++,l++){
	
			    		combo += '<option value='+arrayId[k]+'>'+arrayName[l].replace("; ",", ")+'</option>';
	
				    }	
			    					    		
		    	}
	        }
	        $('#investigationId').append(combo);
    
	  if(status == 'Y' || status == 'y'){
			
			$j("#btnInActive").show();
			$j("#btnActive").hide();
		    $j("#updateBtn").show();
		    $j("#btnAddMEInv").hide();	    
			 $j("#btnInActive").attr("disabled", false);
		}
	
	
	if (status == 'N' || status == 'n') {
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j("#updateBtn").hide();
			$j("#btnAddMEInv").hide();
			$j("#btnActive").attr("disabled", false);
		}

		$("#investigationAge").val('');
		var values = age;
		var splitValues = values.split(',');
		$('#investigationAge option').filter(function() {
			return values.indexOf($(this).text()) > -1; 
		}).prop('selected', true);		
		
		$j('#btnAddMEInv').hide();

	}

	function addMEInvestigation() {
		var multiselectAgeVal=$("#investigationAge").val();	
	
		if ((multiselectAgeVal == '') || (multiselectAgeVal == 'select')) {
			alert("Please Select Age");
			return false;
		}

		var invCount=document.getElementById('investigationId').length;
			if(invCount ==0){
        	alert("Please enter at least one Investigation Name ");
        	document.getElementById('investigationName').focus();
            return false;
			}
         		
		var investigationId = "";
		$("#investigationId option").each(function()
				{
			investigationId += (investigationId == "") ? "" : ",";
			investigationId += $(this).val();
				    
			});	
       
		
		$('#btnAddMEInv').prop("disabled",true);
		url = 'saveMEInvestigation';
		params = {
			"age" : multiselectAgeVal,
			"investigationId" : investigationId,
			"userId" : jQuery('#userId').val()
		};
		
		// alert(JSON.stringify(params));
		SendJsonData(url, params);

		ResetForm();
		}

	function updateMEInvestigation(status) {
		

		if (status == 'update') {
			var multiselectInvVal = $("#investigationName").val();
			var multiselectAgeVal = $("#investigationAge").val();
			if ((multiselectAgeVal == '') || (multiselectAgeVal == 'select')) {
				alert("Please Select Age");
				return false;
			}
			var invCount=document.getElementById('investigationId').length;
			if(invCount < 2){
        	alert("Please enter at least one Investigation Name ");
        	document.getElementById('investigationName').focus();
            return false;
			}
         		
			var investigationId = "";
			$("#investigationId option").each(function()
					{
				investigationId += (investigationId == "") ? "" : ",";
				investigationId += $(this).val();
					    
				});	

		}

		var params = {
			"invMappingId" : invMapid,
			"age" : multiselectAgeVal,
			"investigationId" : investigationId,
			"userId" : jQuery('#userId').val()

		}
		
		// alert(JSON.stringify(params));
		var url = "updateInvestigationMapping";
		SendJsonData(url, params);

		if (status == 'active') {
			$j("#updateBtn").show();
		}
		if (status == 'inactive') {
			$j("#updateBtn").hide();
		}
		if (status == 'update') {
			$j("#updateBtn").hide();
		}
		ResetForm();
	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		getAllInvestigationMappingList('FILTER');

	}
	function showAll() {
		ResetForm();
		nPageNo = 1;
		getAllInvestigationMappingList('ALL');

	}
	function ResetForm() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddMEInv').show();
		$j('#investigationAge').val('');
		$j('#investigationId').html('');
		$j('#searchInvestigation').val('');

	}

	function updateStatus() {

		$j('#messageId').fadeIn();
		var params = {
		    'invMappingId' : invMapid,
			'status' : status
		}
		
		//alert("params: " + JSON.stringify(params));

		var url = "updateMEInvestStatus";
		SendJsonData(url, params);
		$j("#btnActive").attr("disabled", true);
		$j("#btnInActive").attr("disabled", true);
	}

	function Reset() {

		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddMEInv').show();
		showAll();

	}
	
	function generateReport()
	{
		var url="${pageContext.request.contextPath}/report/generateMEInvestigationMasterReport";
		openPdfModel(url);

		/* document.searchInvestigationForm.action="${pageContext.request.contextPath}/report/generateMEInvestigationMasterReport";
		document.searchInvestigationForm.method="POST";
		document.searchInvestigationForm.submit();  */
		
	}

	 
      function fillInvestigationComboMaster(val) {
          var combo="";
          var index1 = val.lastIndexOf("[");
          var index2 = val.lastIndexOf("]");
          index1++;
          idIcdNo = val.substring(index1, index2);
          if (idIcdNo == "") {
              return;
          } else {
             
             var b = "false";
             $("#investigationId option").each(function()
                        		{
                        		    if($(this).val()==idIcdNo){
                        		    alert("Investigation Name is already added");
                        		    document.getElementById('investigationName').value = ""
                        		    b=true;
                        		    }
                        		});
          	  
              if (b == "false") {
              	   combo +='<option value=' + idIcdNo + '>' + val + '</option>';
                  $('#investigationId').append(combo);
                  document.getElementById('investigationName').value = ""

              }
          }
      }
      
      function deleteDgItems(value) {
    	  
    	  if((investigationAge == undefined || investigationAge == '') || (investigationId == undefined || investigationId == '')){
				alert("Please select at least one investigation");
				return;
			}

          if (confirm(resourceJSON.opdIcdDeleteMsg)) {

              if (document.getElementById('investigationId').options[document.getElementById('investigationId').selectedIndex].value != null)
                  document.getElementById('investigationId').remove(document.getElementById('investigationId').selectedIndex)

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
                <div class="internal_Htext">Investigation Mapping To ME</div>
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                            <input  name="labImaginId" id="labImaginId" type="hidden" value="" />
                            <input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                        <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchInvestigationForm" name="searchInvestigationForm" method="" role="form">
                                                <div class="form-group row">                                              
                                                
                                                    <label class="col-2 col-form-label">Age<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-3">
                                                    
                                                    <input type="text" name="searchInvestigation" id="searchInvestigation"
															class="form-control" id="inlineFormInputGroup"
															placeholder="age"
															onkeypress="return validateTextField('searchInvestigation',20,'Age');">                                                    
                                                                                                      
                                                   </div>
                                                    <div class="form-group row">                                                    
                                                    <div class="col-md-6">
                                                       <button type="button" class="btn  btn-primary " onclick="search();">Search</button>
                                                    </div>
                                                    </div> 
                                                </div>
                                            </form>

                                        </div>
                                        
                                        <div class="col-md-4">
                                             <div class="btn-right-all">                                      
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>
                                                     <button type="button" class="btn  btn-primary "
                                                     id="printReportButton" 
													onclick="generateReport()">Reports</button>
                                                    
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
                                            <th id="th3" class ="inner_md_htext">Age</th>
                                                <th id="th4" class ="inner_md_htext">Investigation Name</th>                                                
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfInvMapping">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12 m-t-5">
                                            <form id="addInvestigationForm" name="addInvestigationForm" method="">
                                                <div class="row">
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Age<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         </div>
                                                         <div class="col-md-6">
                                                            <select class="form-control" id="investigationAge" name="investigationAge" multiple="multiple">                                                                
                                                            </select>
                                                         </div>
                                                    </div>
                                                </div>
                                                    
                             <div class="col-md-4">
							<div class="form-group row  autocomplete">

												<label class="col-md-4 col-form-label"> 
														Investigation Name <span class="mandate"><sup>&#9733;</sup></span> </label>
													<div class="col-md-8">
														<input name="investigationName" id="investigationName" type="text"
													class="form-control border-input"
													placeholder="Investigation Name" value=""  onKeyUp="getNomenClatureList(this,'fillInvestigationComboMaster','medicalexam','getInvestigationListUOM','masterInvestigationMe');"  />
														<div class="autocomplete-itemsNew" id="icdDiagnosisMas" ></div>
													</div>

												</div>
											</div>
								
								<div class="col-md-3">
												<select name="investigationId" multiple="4" size="5"
													tabindex="1" id="investigationId" class="listBig width-full"
													validate="Investigation,string,yes">
													
												</select>
								</div>                                                 
                                 <div class="col-md-1">
												<button type="button" class="buttonDel btn  btn-danger" id="delBtn"
													value="" onclick="deleteDgItems(this,'investigationId');"
													align="right" />Delete</button>				
											
								</div>
								<div class="w-100 m-t-10"></div>                        
                                                    
                                               </div>     
                                            </form>
                                        </div>

                                    </div>
										
									<div class="clearfix"></div>
         							
									<div class="row m-t-8">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddMEInv"
															class="btn  btn-primary " onclick="addMEInvestigation();">Add</button>															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateMEInvestigation('update');">Update</button>	
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateStatus();">Deactivate</button>															
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