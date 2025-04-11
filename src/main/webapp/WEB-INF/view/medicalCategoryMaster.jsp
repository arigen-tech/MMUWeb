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
  
<script type="text/javascript">

nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	$j("#btnActive").hide();
	$j("#btnInActive").hide();		
	$j('#updateBtn').hide();	  
	$j('#medicalCategoryCode').attr('readonly', false);		
		GetAllMedicalCategory('ALL');			
		});
		
function GetAllMedicalCategory(MODE){
	
	 var medicalCategoryName= jQuery("#searchMedicalCategory").attr("checked", true).val().toUpperCase();
	 var medicalCategoryId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "medicalCategoryName":""};			
		}else{
		var data = {"PN":nPageNo, "medicalCategoryName":medicalCategoryName};
		} 
	var url = "getAllMedicalCategory";		
	var bClickable = true;
	GetJsonData('tblListOfMedicalCategory',data,url,bClickable);	 
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
					var Status='Active';
				}
			else
				{
					var Status='Inactive';
				} 

		 if(dataList[i].fitFlag == '' || dataList[i].fitFlag == 'undefined')
			{
				var Flag='';
			}
		 else if(dataList[i].fitFlag == 'F' || dataList[i].fitFlag == 'f')
			{
				var Flag='Fit';
			}
		   else if(dataList[i].fitFlag =='U' || dataList[i].fitFlag =='u' )
			{
				var Flag='Unfit';
			} 		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].medicalCategoryId+"' >";	
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].medicalCategoryCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].medicalCategoryName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Flag+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfMedicalCategory").html(htmlTable); 	
	
}

var medCatId;
var medCatCode;
var medCatName;
var medCatStatus;
var fFlag;

function executeClickEvent(medicalCategoryId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(medicalCategoryId == data.data[j].medicalCategoryId){
			medCatId = data.data[j].medicalCategoryId;			
			medCatCode = data.data[j].medicalCategoryCode;			
			medCatName = data.data[j].medicalCategoryName;
			medCatStatus = data.data[j].status;
			fFlag= data.data[j].fitFlag;
			
		}
	}
	rowClick(medCatId,medCatCode,medCatName,medCatStatus,fFlag);
}

function rowClick(medCatId,medCatCode,medCatName,medCatStatus,fFlag){	
		
	document.getElementById("medicalCategoryCode").value = medCatCode;
	document.getElementById("medicalCategoryName").value = medCatName;
	
	if(fFlag =='F' ||  fFlag =='f'){
		$("#fit_radio").prop("checked", true);
		}
	else if(fFlag =='U' ||  fFlag =='u'){
		$("#unfit_radio").prop("checked", true);
		}
			 
	if(medCatStatus == 'Y' || medCatStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddMedicalCategory').hide();
		$j('#medicalCategoryCode').attr('readonly', true);
	}
	if(medCatStatus == 'N' || medCatStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddMedicalCategory').hide();
		$j('#medicalCategoryCode').attr('readonly', true);
	}
	
	
}

function searchMedicalCategoryList(){	
	if(document.getElementById('searchMedicalCategory').value == "" || document.getElementById('searchMedicalCategory') == null){
		 alert("Plese Enter the Medical Category Name");
		 return false;
	 }
		 	 
	 var medicalCategoryName= jQuery("#searchMedicalCategory").attr("checked", true).val().toUpperCase();
		
		var nPageNo=1;
		var url = "getAllMedicalCategory";
		var data =  {"PN":nPageNo, "medicalCategoryName":medicalCategoryName};
		var bClickable = true;
		GetJsonData('tblListOfMedicalCategory',data,url,bClickable);		
}
var success;
var error;
var fitFlag;
function addMedicalCategoryDetails(){
	
	fitFlag=$("input[name='fit_flag']:checked","#addMedicalCategoryForm").val();
		
	if(document.getElementById('medicalCategoryCode').value == null || document.getElementById('medicalCategoryCode').value == ""){
		alert("Please Enter Medical Category Code");
		return false;
	}
	if(document.getElementById('medicalCategoryName').value == null || document.getElementById('medicalCategoryName').value ==""){
		alert("Please Enter Medical Category Name");
		return false;
	}
	$('#btnAddMedicalCategory').prop("disabled",true);
	var userId =  $j('#userId').val();
	var params = {
			'fitFlag':	fitFlag,		 
			 'medicalCategoryCode':jQuery('#medicalCategoryCode').val(),
			 'medicalCategoryName':jQuery('#medicalCategoryName').val()	,
			 'userId':userId
	 } 
	 
	    var url = "addMedicalCategory";
	    SendJsonData(url,params);
	    
	
}


function updateMedicalCategory(){	
	if(document.getElementById('medicalCategoryCode').value == null || document.getElementById('medicalCategoryCode').value == ""){
		alert("Please Enter Medical Category Code");
		return false;
	}
	if(document.getElementById('medicalCategoryName').value == null || document.getElementById('medicalCategoryName').value ==""){
		alert("Please Enter Medical Category Name");
		return false;
	}
	fitFlag=$("input[name='fit_flag']:checked","#addMedicalCategoryForm").val();	
	var userId =  $j('#userId').val();
	var params = {
			'fitFlag':	fitFlag,
			 'medicalCategoryId':medCatId,
			 'medicalCategoryCode':jQuery('#medicalCategoryCode').val(),
			 'medicalCategoryName':jQuery('#medicalCategoryName').val(),
			 'userId':userId
			
	 } 

		    var url = "updateMedicalCategoryDetails";
	        SendJsonData(url,params);

	        $j("#btnActive").hide();
	    	$j("#btnInActive").hide();
	    	$j('#updateBtn').hide();
	    	$j('#btnAddMedicalCategory').show();
	    	$j('#medicalCategoryCode').attr('readonly', false);
	        
}

function updateMedicalCategoryStatus(){
	if(document.getElementById('medicalCategoryCode').value == null || document.getElementById('medicalCategoryCode').value == ""){
		alert("Please Enter Medical Category Code");
		return false;
	}
	if(document.getElementById('medicalCategoryName').value == null || document.getElementById('medicalCategoryName').value ==""){
		alert("Please Enter Medical Category Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'medicalCategoryId':medCatId,
			 'medicalCategoryCode':medCatCode,
			 'status':medCatStatus,
			 'userId':userId
			 
		} 
		    var url = "updateMedicalCategoryStatus";
		    SendJsonData(url,params);
	 
		    $j("#btnActive").hide();
	    	$j("#btnInActive").hide();
	    	$j('#updateBtn').hide();
	    	$j('#btnAddMedicalCategory').show();
	    	$j('#medicalCategoryCode').attr('readonly', false);
	        
}


function Reset(){
	document.getElementById("addMedicalCategoryForm").reset();
	document.getElementById("searchMedicalCategoryForm").reset();
	document.getElementById('searchMedicalCategory').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMedicalCategory').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#medicalCategoryCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#medicalCategoryCode').val('');
	$j('#medicalCategoryName').val('');
	$j('#searchMedicalCategory').val('');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMedicalCategory').show();
	$j('#medicalCategoryCode').attr('readonly', false);
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllMedicalCategory('ALL');
	
}
 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllMedicalCategory('FILTER');
	
} 
 
 function search()
 {
 	if(document.getElementById('searchMedicalCategory').value == ""){
 		alert("Please Enter Medical Category Name");
 		return false;
 	}
 	nPageNo=1;
 	GetAllMedicalCategory('Filter');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateMedicalCategoryReport";
	 openPdfModel(url);

 	/* document.searchMedicalCategoryForm.action="${pageContext.request.contextPath}/report/generateMedicalCategoryReport";
 	document.searchMedicalCategoryForm.method="POST";
 	document.searchMedicalCategoryForm.submit(); */ 
 	
 }
 
   function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	    	alert("Only numeric value is allowed")
	        return false;
	    }
	    return true;
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
                <div class="internal_Htext">Medical Category Master</div>
                   
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                    
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchMedicalCategoryForm"
												name="searchMedicalCategoryForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Medical Category Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchMedicalCategory" id="searchMedicalCategory"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Medical Category Name" onkeypress="return validateText('searchMedicalCategory',30,'Medical Category Name');" >

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
                                                <th id="th2" class ="inner_md_htext">Medical Category Code</th>
                                                <th id="th3" class ="inner_md_htext">Medical Category Name</th>
                                                <th id="th3" class ="inner_md_htext">Fit/Unfit</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfMedicalCategory">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addMedicalCategoryForm" name="addMedicalCategoryForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="Medical Category Code" class=" col-form-label inner_md_htext" >Medical Category Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="medicalCategoryCode" name="medicalCategoryCode" placeholder="Medical Category Code" 
                                                                onkeypress="return isNumber(event)"maxlength="2">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="service" class="col-form-label inner_md_htext">Medical Category Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="medicalCategoryName" name="medicalCategoryName" placeholder="MedicalCategory Name" onkeypress="return validateText('medicalCategoryName',30,'Medical Category Name');" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row m-t-5">
                                                        <div class="form-check form-check-inline cusRadio m-l-20 ">
															<input type="radio" value="F" class="form-check-input radioCheckCol2"
																name="fit_flag" id="fit_radio" checked="checked"/>
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="fit_radio">Fit</label>
														</div>
														
														<div class="form-check form-check-inline cusRadio m-l-10">
															<input type="radio" value="U" class="form-check-input radioCheckCol2"
																name="fit_flag" id="unfit_radio" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="unfit_radio">Unfit</label>
														</div>
														
                                                        </div>
                                                    </div>
                                                    
                                                    
                                                    
                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
							            </div>
                                                    
                                                </div>
                                            </form>
                                        </div>

                                    </div>
									 
         							<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddMedicalCategory"
															class="btn  btn-primary " onclick="addMedicalCategoryDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateMedicalCategory();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateMedicalCategoryStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateMedicalCategoryStatus();">Deactivate</button>
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