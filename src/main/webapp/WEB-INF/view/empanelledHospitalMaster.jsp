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
	$('#selectHospital').attr("disabled", false);
	GetAllEmpanelledHospital('ALL');
	GetCityList();
		});
		
	
function GetCityList(){
	 jQuery('#citySearch').empty();
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllCity",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "<option value=\"\">Select</option>" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#city').append(combo);
		    	
		    }
		    
		});
	}		
function GetAllEmpanelledHospital(MODE){
	var empanelledHospitalName = jQuery("#searchEmpanelledHospital").attr("checked", true).val().toUpperCase();
	 var empanelledHospitalId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"empanelledHospitalName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "empanelledHospitalName":empanelledHospitalName};
		} 
	var url = "getAllEmpanelledHospital";		
	var bClickable = true;
	GetJsonData('tblListOfEmpanelledHospital',data,url,bClickable);	 
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
					var Status='Active'
				}
			else
				{
					var Status='Inactive'
				} 		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].empanelledHospitalId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px; word-break: break-all;'>"+dataList[i].empanelledHospitalCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px; word-break: break-all;'>"+dataList[i].empanelledHospitalName+"</td>";
			htmlTable = htmlTable +"<td style='width: 250px; word-break: break-all;'>"+dataList[i].city+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfEmpanelledHospital").html(htmlTable); 	
	
}


var empanelledHospId;
var empanelledHospitalCode;
var empanelledHospName;
var empanelledHospAddress;
var phNo;
var empanelledHospStatus;
var cityId;
function executeClickEvent(empanelledHospitalId,data)
{
//alert("empanelledHospitalId"+empanelledHospitalId);	
	for(j=0;j<data.data.length;j++){
		if(empanelledHospitalId == data.data[j].empanelledHospitalId){
			empanelledHospId = data.data[j].empanelledHospitalId;		
			empanelledHospName = data.data[j].empanelledHospitalName;
			empanelledHospAddress = data.data[j].empanelledHospitalAddress;
			phNo = data.data[j].phoneNo;
			empanelledHospStatus = data.data[j].status;
			empanelledHospitalCode= data.data[j].empanelledHospitalCode;
			cityId=data.data[j].cityId;
		}
	}
	rowClick(empanelledHospId,empanelledHospName,empanelledHospAddress,phNo,empanelledHospStatus,empanelledHospitalCode,cityId);
}

function rowClick(empanelledHospId,empanelledHospName,empanelledHospAddress,phNo,empanelledHospStatus,empanelledHospitalCode,cityId){	
	document.getElementById("empanelledHospitalName").value = empanelledHospName;
	document.getElementById("empanelledHospitalAddress").value = empanelledHospAddress;
	document.getElementById("phoneNo").value = phNo;
	document.getElementById("empanelledHospitalCode").value = empanelledHospitalCode;
	document.getElementById("city").value = cityId;
	$j('#empanelledHospitalCode').attr('readonly', true);
			 
	if(empanelledHospStatus == 'Y' || empanelledHospStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddEmpanelledHospital').hide();
	}
	if(empanelledHospStatus == 'N' || empanelledHospStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddEmpanelledHospital').hide();
	}
	
	
	
		
}
function addEmpanelledHospitalDetails(){
	if(document.getElementById('empanelledHospitalCode').value == null || document.getElementById('empanelledHospitalCode').value ==""){
		alert("Please Enter Empanelled Hospital Code");
		return false;
	}
	if(document.getElementById('empanelledHospitalName').value == null || document.getElementById('empanelledHospitalName').value ==""){
		alert("Please Enter Hospital Name");
		return false;
	}
	if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
		alert("Please Select City");
		return false;
	}
	
	$('#btnAddEmpanelledHospital').prop("disabled", true);
	var userId =  $j('#userId').val();
	var hospitalId =  $j('#hospitalId').val();
	var address;
	var params = {	
			 'empanelledHospitalCode' : jQuery('#empanelledHospitalCode').val(), 		 
			 'empanelledHospitalName':jQuery('#empanelledHospitalName').val(),
			 'empanelledHospitalAddress':jQuery('#empanelledHospitalAddress').val(),
			 'phoneNo':jQuery('#phoneNo').val(),
			 'userId':<%= userId%>,
			 'cityId' : jQuery('#city option:selected').val()
			 
	 }
	
	//alert(JSON.stringify(params));
	var url="addEmpanelledHospital";	
	SendJsonData(url,params); 
	
		
	
}

function updateEmpanelledHospital(status){
	//alert("status :: "+status)
	
	if(document.getElementById('empanelledHospitalCode').value == null || document.getElementById('empanelledHospitalCode').value ==""){
		alert("Please Enter Empanelled Hospital Code");
		return false;
	}
	if(document.getElementById('empanelledHospitalName').value == null || document.getElementById('empanelledHospitalName').value ==""){
		alert("Please Enter Hospital Name");
		return false;
	}
	if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
		alert("Please Select City");
		return false;
	}
	
	var userId =  $j('#userId').val();
	var params = {
			 'empanelledHospitalId':empanelledHospId,
			 'empanelledHospitalName':jQuery('#empanelledHospitalName').val(),			
			 'empanelledHospitalCode':jQuery('#empanelledHospitalCode').val(),
			 'empanelledHospitalAddress':jQuery('#empanelledHospitalAddress').val(),
			 'phoneNo':jQuery('#phoneNo').val(),
			 'status':status,
			 'userId':<%= userId%>,
			 'cityId':jQuery('#city').val()
			  
			 
		}
	
	var url="updateEmpanelledHospital";	
	SendJsonData(url,params);
	
	//alert("params: "+JSON.stringify(params)); 	
	Reset();
}


function Reset(){
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddEmpanelledHospital').show();
	showAll();
}	


function ResetForm()
{
	
	$j('#empanelledHospitalName').val('');
	$j('#empanelledHospitalAddress').val('');
	$j('#phoneNo').val('');
	$j('#searchEmpanelledHospital').val('');
	$j('#empanelledHospitalCode').val('');
	$j('#empanelledHospitalCode').attr('readonly', false);
	$j('#city').val('');
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllEmpanelledHospital('ALL');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddEmpanelledHospital').show();
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllEmpanelledHospital('FILTER');
	
} 
 
 function search()
 {
 	if(document.getElementById('searchEmpanelledHospital').value == ""){
  		alert("Please Enter Empanelled Hospital Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllEmpanelledHospital('Filter');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateEmpanelledHospitalReport";
	 openPdfModel(url);
 	/* document.searchEmpanelledHospitalForm.action="${pageContext.request.contextPath}/report/generateEmpanelledHospitalReport";
 	document.searchEmpanelledHospitalForm.method="POST";
 	document.searchEmpanelledHospitalForm.submit();  */
 	
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
                <div class="internal_Htext">Empanelled Hospital Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                        
                                     <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchEmpanelledHospitalForm" name="searchEmpanelledHospitalForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-4 col-form-label">Empanelled Hospital Name<span style="color:red">*</span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchEmpanelledHospital" id="searchEmpanelledHospital" class="form-control" id="inlineFormInputGroup" placeholder="Empanelled Hospital Name" onkeypress="return validateText('searchEmpanelledHospital',30,'Empanelled Hospital Name');">
                                                             
                                                    </div>
                                                    <div class="form-group row">
                                                    
                                                    <div class="col-md-12">
                                                       <button type="button" class="btn  btn-primary " onclick="search();">Search</button>
                                                    </div>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                        
                                        <div class="col-md-4">
                                             <div class="btn-right-all">                                      
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>
                                                    <!-- <button type="button" class="btn  btn-primary " 
                                                    id="printReportButton"  data-backdrop="static"
                                                    onclick="generateReport()">Reports</button> -->
                                              </div>
                                        </div>

                                    </div>  
                                       
                                  
					<!-- <table class="table table-striped table-hover jambo_table"> -->
                    <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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
                                                <th id="th1" class ="inner_md_htext">Empanelled Code</th>
                                                <th id="th2" class ="inner_md_htext">Empanelled Hospital Name</th>
                                                <th id="th3" class ="inner_md_htext">City</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfEmpanelledHospital">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addEmpanelledHospitaForm" name="addEmpanelledHospitaForm" action="" method="POST">
                                                <div class="row">
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-7">
                                                            <label for="Empanelled Hospital Code" class=" col-form-label inner_md_htext" >Empanelled Hospital Code<span style="color:red">*</span></label>
                                                            </div>
                                                            <div class="col-sm-5">
                                                                <input type="text" name="empanelledHospitalCode" id="empanelledHospitalCode" class="form-control" placeholder="Empanelled Hospital Code" onkeypress="return validateTextField('empanelledHospitalCode',7);">
                                                            </div>
                                                        </div>
                                                    </div>                                                    
                                                                                    
                                                  <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Empanelled Hospital Name <span style="color:red">*</span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="empanelledHospitalName" id="empanelledHospitalName" class="form-control" placeholder="Empanelled Hospital Name" onkeypress="return validateText('empanelledHospitalName',30,'Empanelled Hospital Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Address </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <textarea  class="form-control" type="textarea" name="empanelledHospitalAddress" placeholder="address" id="empanelledHospitalAddress"  MAXLENGTH="300" tabindex="1" rows="1"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">City<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="city" name="city" onchange="">
                                                                                                                           
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Contact No </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                            <textarea  class="form-control" type="textarea" name="phoneNo" id="phoneNo" value="" placeholder="Contact no"  MAXLENGTH="50" tabindex="1" rows="1"></textarea>  
                                                            </div>
                                                        </div>
                                                    </div>
                                                   
                                                   <div class="col-md-4">
														<input type="hidden"  id="rowId" name="rowId">
														<input type="hidden" class="form-control" id="userId"
															   name="userId"  value="<%=session.getAttribute("user_id")%>">
																					
											            </div>
							            
											            <div class="col-md-4">
														<input type="hidden"  id="rowId" name="rowId">
														<input type="hidden" class="form-control" id="hospitalId"
															   name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
																					
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
												
														<button type="button" id="btnAddEmpanelledHospital"
															class="btn  btn-primary " onclick="addEmpanelledHospitalDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateEmpanelledHospital('update');">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateEmpanelledHospital('active');">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateEmpanelledHospital('inactive');">Deactivate</button>
															
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