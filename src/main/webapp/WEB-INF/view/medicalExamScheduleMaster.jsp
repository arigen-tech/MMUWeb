<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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

<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#selectEmployeeCategory').attr('disabled', false);
			GetMedicalExamScheduleList('ALL');
			GetEmployeeCategoryList();
		});
		
function GetMedicalExamScheduleList(MODE)
{
	//var employeeCategoryName= jQuery("#searchEmployeeCategory").find('option:selected').val();
	var categoryDueId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "employeeCategoryName":""};			
		}
	else
		{
		var data = {"PN":nPageNo,"employeeCategoryName":employeeCategoryName};
		} 
	var url = "getAllMedicalExamScheduleDetails";
		
	var bClickable = true;
	GetJsonData('tblMedicalExamSchedule',data,url,bClickable);
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
		 
		 var FromMonth = "";
		 var ToMonth = "";
			
			if(dataList[i].fromMonth == '1')
				{
				FromMonth = 'January';
				}
			else if(dataList[i].fromMonth == '2')
				{
				FromMonth = 'February';
				}
			else if (dataList[i].fromMonth == '3')
				{
				FromMonth = 'March';
				}
			else if (dataList[i].fromMonth == '4')
			{
				FromMonth = 'April';
			}
			else if (dataList[i].fromMonth == '5')
			{
				FromMonth = 'May';
			}
			else if (dataList[i].fromMonth == '6')
			{
				FromMonth = 'June';
			}
			else if (dataList[i].fromMonth == '7')
			{
				FromMonth = 'July';
			}
			else if (dataList[i].fromMonth == '8')
			{
				FromMonth = 'August';
			}
			else if (dataList[i].fromMonth == '9')
			{
				FromMonth = 'September';
			}
			else if (dataList[i].fromMonth == '10')
			{
				FromMonth = 'October';
			}
			else if (dataList[i].fromMonth == '11')
			{
				FromMonth = 'November'
			}
			else if (dataList[i].fromMonth == '12')
			{
				FromMonth = 'December';
			}
			 if(dataList[i].toMonth == '1')
			{
				ToMonth = 'January';
			}
			else if(dataList[i].toMonth == '2')
			{
				ToMonth = 'February';
			}
			else if (dataList[i].toMonth == '3')
			{
				ToMonth = 'March';
			}
			else if (dataList[i].toMonth == '4')
			{
				ToMonth = 'April';
			}
			else if (dataList[i].toMonth == '5')
			{
				ToMonth = 'May';
			}
			else if (dataList[i].toMonth == '6')
			{
				ToMonth = 'June';
			}
			else if (dataList[i].toMonth == '7')
			{
				ToMonth = 'July';
			}
			else if (dataList[i].toMonth == '8')
			{
				ToMonth = 'August';
			}
			else if (dataList[i].toMonth == '9')
			{
				ToMonth = 'September';
			}
			else if (dataList[i].toMonth == '10')
			{
				ToMonth = 'October';
			}
			else if (dataList[i].toMonth == '11')
			{
				ToMonth = 'November';
			}
			else if (dataList[i].toMonth == '12')
			{
				ToMonth = 'December';
			}
			htmlTable = htmlTable+"<tr id='"+dataList[i].categoryDueId+"' >";
			htmlTable = htmlTable +"<td style='width: 100px;' >"+dataList[i].employeeCategoryName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+FromMonth+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+ToMonth+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblMedicalExamSchedule").html(htmlTable);	
	
	
}
var comboArray = [];
var cdId;
var fMonth;
var tMonth;
var cdStatus;
var ecId;
var ecName;
function executeClickEvent(categoryDueId,data)
{
	
	
	for(j=0;j<data.data.length;j++){
		if(categoryDueId == data.data[j].categoryDueId){
			cdId = data.data[j].categoryDueId;
			//cId =  data.data[j].categoryId;
			fMonth = data.data[j].fromMonth;
			tMonth = data.data[j].toMonth;
			cdStatus = data.data[j].status;
			ecId = data.data[j].employeeCategoryId;
			ecName = data.data[j].employeeCategoryName;
			
		}
	}
	
	rowClick(cdId,fMonth,tMonth,cdStatus,ecId,ecName);
}

var success;
var error;

function addMedicalExamScheduleDetails(){
	
	/* if(document.getElementById('selectEmployeeCategory').value==" "){
		alert("Please Select the Employee Category");
		return false;
	} */
	
	if(document.getElementById('selectEmployeeCategory').value==""){
		alert("Please Select the Employee Category");
		return false;
	}
	
	if(document.getElementById('fromMonth').value=="0"){
		alert("Please Select the AME Due- From Month");
		return false;
	}
	
	if(document.getElementById('toMonth').value=="0"){
		alert("Please Select the AME Due- To Month");
		return false;
	}
	$('#btnAddMedicalExamSchedule').prop("disabled",true);
	var params = {
			
			 'employeeCategoryId':jQuery('#selectEmployeeCategory').find('option:selected').val(),
			 'fromMonth':jQuery('#fromMonth').find('option:selected').val(),
			 'toMonth':jQuery('#toMonth').find('option:selected').val(),
			 'userId':$j('#userId').val()
	 } 	
	//alert(JSON.stringify(params));
	var url="addMedicalExamSchedule";
	    SendJsonData(url,params);
}

function updateMedicalExamScheduleDetails()
{	
	if(document.getElementById('selectEmployeeCategory').value == "0"){
		alert("Please Select the Employee Category");
		return false;
	}
	
	if(document.getElementById('fromMonth').value == "0"){
		alert("Please Select the AME Due- From Month");
		return false;
	}
	if(document.getElementById('toMonth').value == "0"){
		alert("Please Select the AME Due- To Month");
		return false;
	}
	
	var userId =  $j('#userId').val();	
	var params = {
			 'categoryDueId':cdId,
			 'employeeCategoryId':jQuery('#selectEmployeeCategory').find('option:selected').val(),
			 'fromMonth':jQuery('#fromMonth').find('option:selected').val(),
			 'toMonth':jQuery('#toMonth').find('option:selected').val(),
			 'userId':userId
	 }
	 //alert(JSON. stringify(params)); 
	var url="updateMedicalExamScheduleDetails";
	SendJsonData(url,params);	
	//GetMedicalExamScheduleList();	 		
	$j('#updateBtn').hide();
	$j('#btnAddMedicalExamSchedule').show();
	$j('#selectEmployeeCategory').attr('disabled', true);
	
}

function updateStatus(){
	var userId =  $j('#userId').val();
	 var params = {
		 'categoryDueId':cdId,		 
		 'status':cdStatus,
		 'userId':userId
		 
	}  
	 var url= "updateMedicalExamScheduleStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").hide();
		    $j("#updateBtn").hide();
			 $j("#btnInActive").hide();
			 $j('#btnAddMedicalExamSchedule').show();
			 
}



function GetEmployeeCategoryList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getRankCategoryList",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].employeeCategory;
	    		combo += '<option value='+result.data[i].employeeCategoryId+'>' +result.data[i].employeeCategoryName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectEmployeeCategory').append(combo);
	    	//jQuery('#searchEmployeeCategory').append(combo);
	    }
	    
	});
}

function rowClick(cdId,fMonth,tMonth,cdStatus,ecId,ecName){	
	
	document.getElementById("fromMonth").value = fMonth;
	document.getElementById("toMonth").value = tMonth;
	jQuery("#selectEmployeeCategory").val(ecId);
	
	
if(cdStatus == 'Y' || cdStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddMedicalExamSchedule").hide();
	}
	if(cdStatus == 'N' || cdStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
	
	$j('#btnAddMedicalExamSchedule').hide();	
	 $j('#selectEmployeeCategory').attr('disabled', true);
	
}

/* function changeSection(value){
	
	var sectionId = jQuery('#selectSection').find('option:selected').val();
	
	if(value == sectionId){
		$j('#updateBtn').attr("disabled", false);
	}
	
} */
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetMedicalExamScheduleList('FILTER');
	
}

function Reset(){
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMedicalExamSchedule').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#selectEmployeeCategory').attr('disabled', false);
	showAll();
}



function ResetForm()
{	
	$j('#fromMonth').val('0');
	$j('#toMonth').val('0');
	$j('#selectEmployeeCategory').val('');
	//$j('#searchEmployeeCategory').val('');
	
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetMedicalExamScheduleList('ALL');
	$j('#selectEmployeeCategory').attr('disabled', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMedicalExamSchedule').show();
	
}

/* function search()
{
	if(document.getElementById('searchEmployeeCategory').value == ""){
		alert("Please select Employee Category");
		return false;
	}
	nPageNo=1;
	GetMedicalExamScheduleList('Filter');
} */

 function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateMedicalExamScheduleReport";
	openPdfModel(url);

	/* document.searchMedicalExamScheduleForm.action="${pageContext.request.contextPath}/report/generateMedicalExamScheduleReport";
	document.searchMedicalExamScheduleForm.method="POST";
	document.searchMedicalExamScheduleForm.submit();  */
	
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
                <div class="internal_Htext">Medical Exam Schedule Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                      
											<%-- <form class="form-horizontal" id="searchEmployeeCategoryForm"
												name="searchEmployeeCategoryForm" method="" role="form">
												<div class="form-group row">
													<div class="col-md-4">
                                                        <div class="form-group row">                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Employee Category<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="searchEmployeeCategory" onchange=" ">                                                                    
                                                                </select>                                                                
                                                            </div>
                                                        </div>
                                                    </div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary obesityWait-search"
																onclick="search()">Search</button>
														</div>
													</div>
												</div>
											</form> --%>

										<form class="form-horizontal" id="searchMedicalExamScheduleForm"
												name="searchMedicalExamScheduleForm" method="" role="form">
												 <div class="row m-b-10">
										<div class="col-md-12 text-right">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												<button type="button" class="btn  btn-primary "
												id="printReportButton" 
													onclick="generateReport()">Reports</button>
											
										</div>
										</div>
										</form>
									
                                    
		<div style="float:left">
               
                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
           <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
           <td>
            <!-- <div id=resultnavigation></div> -->
           
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
                                                <th id="th2" class ="inner_md_htext"> Employee Category  </th>
                                                <th id="th3" class ="inner_md_htext"> AME Due - From </th>
                                                <th id="th4" class ="inner_md_htext"> AME Due - To </th>
                                                <th id="th5" class ="inner_md_htext"> Status </th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblMedicalExamSchedule">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addMedicalExamScheduleForm" name="addMedicalExamScheduleForm" method="">
                                                <div class="row">
                                                
                                                <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Employee Category<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectEmployeeCategory" >
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Section Code" class=" col-form-label inner_md_htext" >AME Due - From<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
																<select class="form-control" id="fromMonth"  onchange="">
                                                                    <option value="0">Select</option>
                                                                    <option value="1">January</option>
                                                                    <option value="2">February</option>
                                                                    <option value="3">March</option>
                                                                    <option value="4">April</option>
                                                                    <option value="5">May</option>
                                                                    <option value="6">June</option>
                                                                    <option value="7">July</option>
                                                                    <option value="8">August</option>
                                                                    <option value="9">September</option>
                                                                    <option value="10">October</option>
                                                                    <option value="11">November</option>
                                                                    <option value="12">December</option>
                                                                </select>      
                                                           </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">AME Due - To<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="toMonth"  onchange="">
                                                                    <option value="0">Select</option>
                                                                    <option value="1">January</option>
                                                                    <option value="2">February</option>
                                                                    <option value="3">March</option>
                                                                    <option value="4">April</option>
                                                                    <option value="5">May</option>
                                                                    <option value="6">June</option>
                                                                    <option value="7">July</option>
                                                                    <option value="8">August</option>
                                                                    <option value="9">September</option>
                                                                    <option value="10">October</option>
                                                                    <option value="11">November</option>
                                                                    <option value="12">December</option>
                                                                </select>
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
												
														<button type="button" id="btnAddMedicalExamSchedule"
															class="btn  btn-primary " onclick="addMedicalExamScheduleDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateMedicalExamScheduleDetails();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
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

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>