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
  
<script type="text/javascript">
nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j("#btnAddHospital").hide();
	$j('#hospitalCode').attr('readonly', false);
	$j('#unitName').attr('readonly', true);
			GetAllUnit('ALL');
			
		});
		
function GetAllUnit(MODE){
	 var unitName= jQuery("#searchHospital").attr("checked", true).val();
		
	
	 var hospitalId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "unitName":""};			
		}else{
		var data = {"PN":nPageNo, "unitName":unitName};
		} 
	var url = "getAllHospital";		
	var bClickable = true;
	GetJsonData('tblListOfHospital',data,url,bClickable);	 
}
function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count; 
	//alert("data :: "+data);
	var pageSize = 5; 	
	var dataList = jsonData.data; 
	
	
	for(i=0;i<dataList.length;i++)
		{		
		
		 if(dataList[i].status == 'Y' || dataList[i].status == 'y')
				{
					var Status='Yes/Active'
				}
		 else  if(dataList[i].status == 'N' || dataList[i].status == 'n')
			{
				var Status='Yes/Inactive'
			}
			else
				{
					var Status='No'
				} 		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].unitId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].unitName+"</td>";
			//htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].unitName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			//htmlTable = htmlTable +'<td style="display:none"><input type="hidden" class="form-control" id="unitId" name="unitId"  value="'+dataList[i].unitId+'"></td>';
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='2'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfHospital").html(htmlTable); 	
	
}

var comboArray = [];
var hId;
var hospitalCode;
var hospitalStatus;
var unitId;
var unitName;
function executeClickEvent(unitId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(unitId == data.data[j].unitId){
			hId = data.data[j].hospitalId;			
			hospitalStatus = data.data[j].status;
			unitName = data.data[j].unitName;
			unitId = data.data[j].unitId;
		}
	}
	rowClick(unitId,unitName,hospitalStatus);
}

function rowClick(unitId,unitName,hospitalStatus){	
	
	//document.getElementById("hospitalId").value = hId;
	document.getElementById("unitId").value = unitId;
	document.getElementById("unitName").value = unitName;
	document.getElementById("chkMi").value = hospitalStatus;
	
	
	
	//alert(hospitalStatus)
	if(hospitalStatus == 'Y' || hospitalStatus == 'y'){
		
		//$j('#chkMi').attr('checked', 'checked');
		$("#chkMi").prop("checked", true);
		$j("#btnInActive").hide();
		$j("#btnActive").hide();
	    $j("#updateBtn").show();
	    $j("#btnAddHospital").hide();
		
	}
	  if(hospitalStatus == 'N' || hospitalStatus == 'n'){
		
		$("#chkMi").prop("checked", false);
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j("#updateBtn").show();
	}  
	if(hospitalStatus == '0' || hospitalStatus == '0'){
		
		$("#chkMi").prop("checked", false);
		
		//$j('#chkMi').removeAttr('checked');
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j("#updateBtn").show();
	}
	$j("#btnActive").attr("disabled", false);
	$j("#btnInActive").attr("disabled", false);
	$j('#updateBtn').attr("disabled", false);
	$j('#btnAddHospital').hide();
	
	$j('#hospitalCode').attr('readonly', true);
	$j('#unitName').attr('readonly', true);
}


/* function searchHospitalList(){
	
	if(document.getElementById('searchHospital').value == "" || document.getElementById('searchHospital') == null){
		 alert("Plese Enter the Hospital Name");
		 return false;
	 }
		 	 
	 var hospitalName= jQuery("#searchHospital").attr("checked", true).val().toUpperCase();
		
		var nPageNo=1;
		var url = "getAllHospital";
		var data =  {"PN":nPageNo, "hospitalName":hospitalName};
		var bClickable = true;
		GetJsonData('tblListOfHospital',data,url,bClickable);	
		
		ResetForm();
} */


function addHospitalDetails(){	
	if(document.getElementById('hospitalCode').value == null || document.getElementById('hospitalCode').value == ""){
		alert("Please Enter Hospital Code");
		return false;
	}
	if(document.getElementById('hospitalName').value == null || document.getElementById('hospitalName').value ==""){
		alert("Please Enter Hospital Name");
		return false;
	}
	if(document.getElementById('selectUnitList').value == null || document.getElementById('selectUnitList').value ==""){
		alert("Please Select Unit");
		return false;
	}
	var  checked = '';
	 if(document.getElementById('chkMi').isSelected==true){
		 checked = 'Y'
	 }
		 else{
			 checked = 'N'
		 }
	var userId =  $j('#userId').val();
	var userId =  $j('#userId').val();
	var params = {
			 'hospitalName':jQuery('#hospitalName').val(),
			 'unitId':unitId,
			 'status':checked,
			 'userId':userId
	 } 
	var url="addHospital";
	//alert("params: "+JSON.stringify(params)); 
	SendJsonData(url,params);
	
		/* jQuery.ajax({
	 crossOrigin: true,
	    method: "POST",
	    header:{
	    	'Access-Control-Allow-Origin': '*'
	    	},
	    	crossDomain:true,
	    url: "addHospital",
	    data: JSON.stringify(params),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	        //alert("result" +result);
	         console.log(result);
	        if(result.status==1){     	
	        		
	        	showAll('ALL');
	        	document.getElementById("messageId").innerHTML = result.msg;
	        	$j('#messageId').toggle(5000);   	        	
	        }
	        if(result.status==2){	        	
	        	GetAllHospital('ALL')
	        	document.getElementById("messageId").innerHTML = result.msg;
	        	$j('#messageId').toggle(5000);
	        }
	        if(result.status==0){
	        	document.getElementById("messageId").innerHTML = result.msg;
	        	$j('#messageId').toggle(5000);
	        }
	    }
	    
	    
	});	 */
	
}


function updateHospitalMaster(){	
	
	if(document.getElementById('unitName').value == null || document.getElementById('unitName').value ==""){
		alert("Please Enter Unit Name");
		return false;
	}
	/* if(document.getElementById('selectUnitList').value == null || document.getElementById('selectUnitList').value ==""){
		alert("Please Select Unit");
		return false;
	} */
	var userId =  $j('#userId').val();
	var unitId =  $j('#unitId').val();
	var  checked = '';
	 if($('#chkMi').prop("checked") == true){
		 
		 checked = 'Y'
	 }
		 else{
			 checked = 'N'
		 }
	var params = {
			 'unitName':jQuery('#unitName').val(),			 
			 'unitId':unitId,
			 'status':checked,
			 'userId':userId
			 
	 } 
	
	var url="updateMasHospitalDetails";
	SendJsonData(url,params);
	
	//alert("params: "+JSON.stringify(params)); 	
		/* jQuery.ajax({
		 crossOrigin: true,
		    method: "POST",
		    header:{
		    	'Access-Control-Allow-Origin': '*'
		    	},
		    	crossDomain:true,
		    url: "updateMasHospitalDetails",
		    data: JSON.stringify(params),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		        //alert("result" +result);
		        console.log(result);
		        if(result.status==1){
		        		        	
		        	showAll('ALL');
		        	document.getElementById("messageId").innerHTML = result.msg;
		        	$j('#messageId').toggle(5000);
		        }
		        if(result.status==0){		        	
		        	showAll('ALL');
		        	document.getElementById("messageId").innerHTML = result.msg;
		        	$j('#messageId').toggle(5000);
		        }
		    }
		    
		    
		}); */
		$j('#updateBtn').hide();				
		$j('#hospitalCode').val('');
		$j('#unitName').val('');
		$j('#selectUnitList').val('')
		$("#chkMi").prop("checked", false);
		
}


function updateHospitalStatus(){
	
	if(document.getElementById('hospitalCode').value == null || document.getElementById('hospitalCode').value == ""){
		alert("Please Select the Hospital");
		return false;
	}
	if(document.getElementById('unitName').value == null || document.getElementById('unitName').value ==""){
		alert("Please Select the Hospital");
		return false;
	}
	/* if(document.getElementById('selectUnitList').value == null || document.getElementById('selectUnitList').value ==""){
		alert("Please Select the Hospital");
		return false;
	} */
	var userId =  $j('#userId').val();
	var params = {
			'hospitalId':hId,
			'hospitalCode':jQuery('#hospitalCode').val(),
			 'status':hospitalStatus,
			 'userId':userId
		}
	var url="updateMasHospitalStatus";
	SendJsonData(url,params);
	//alert("params: "+JSON.stringify(params)); 
	 /* jQuery.ajax({
		 crossOrigin: true,
		    method: "POST",
		    header:{
		    	'Access-Control-Allow-Origin': '*'
		    	},
		    	crossDomain:true,
		    url: "updateMasHospitalStatus",
		    data: JSON.stringify(params),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		        //alert("result" +result);
		        console.log(result);
		        if(result.status==1){
		        	
		        	showAll('ALL');
		        	document.getElementById("messageId").innerHTML = result.msg;
		        	$j('#messageId').toggle(5000);
		        }
		        if(result.status==0){
		        	
		        	showAll('ALL');
		        	document.getElementById("messageId").innerHTML = result.msg;
		        	$j('#messageId').toggle(5000);
		        }
		    }
		    		    
		}); */
	 
	$j("#btnActive").attr("disabled", true);
	$j("#btnInActive").attr("disabled", true);
	$j('#updateBtn').attr("disabled", true);				
	ResetForm();
}

function Reset(){
	document.getElementById("searchHospitalForm").reset();
	document.getElementById("addHospitalForm").reset();
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddHospital').hide();
	$j('#hospitalCode').attr('readonly', false);
	$j('#unitName').attr('readonly', true);
	showAll();
}	

function showResultPage(pageNo)
{
	
	nPageNo = pageNo;	
	GetAllUnit('FILTER');
	
}

function enableAddButton(){
	if( document.getElementById("unitName").value!=null || !document.getElementById("unitName").value==""){
		$j('#btnAddHospital').attr("disabled", false);
	}else{
		$j('#btnAddHospital').attr("disabled", true);
	}
}

function validTextBox(){
	
	if($j('#unitName').val().length > 30){
		 alert("Unit Name should be less than 30");
		 document.getElementById('unitName').value="";
		 return false;
	 }
}

function ResetForm()
{
	$j('#unitName').val('');
	$j('#selectUnitList').val('');
	$j('#searchHospital').val('');
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllUnit('ALL');
	
}

function changeUnit(value){
	
	var unitId = jQuery('#selectUnitList').find('option:selected').val()
	if(value == unitId){
		$j('#updateBtn').attr("disabled", false);
	}
}


function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateHospitalReport";
	openPdfModel(url);
	/* document.searchHospitalForm.action="${pageContext.request.contextPath}/report/generateHospitalReport";
	document.searchHospitalForm.method="POST";
	document.searchHospitalForm.submit();  */
	
}

function search()
{
	if(document.getElementById('searchHospital').value == ""){
		alert("Please Enter Unit Name");
		return false;
	}
	nPageNo=1;
	GetAllUnit('Filter');
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
                 <div class="internal_Htext">Hospital Master</div>
                    <!-- <div class="row">
                        <div class="col-12">
                            <div class="page-title-box">
                               

                                <ol class="breadcrumb float-right">
                                    <li class="breadcrumb-item active"><a href="#">Home</a></li>
                                     <li class="breadcrumb-item  active"><a href="#">Master</a></li>  
                                    <li class="breadcrumb-item active">Hospital Master</li>
                                </ol>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div> -->
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                      
                                       <div class="row">
										<div class="col-md-8">
											<form class="form-horizontal" id="searchHospitalForm"
												name="searchHospitalForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Unit Name <span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchHospital" id="searchHospital"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Unit Name" onkeypress="return validateText	('searchHospital',30,'Unit Name');">

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
                                                <th id="th3" class ="inner_md_htext">Unit Name</th>
                                                <th id="th5" class ="inner_md_htext">MI Room</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfHospital">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addHospitalForm" name="addHospitalForm" action="" method="POST">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Unit Name <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="unitName" id="unitName" class="form-control" placeholder="Unit Name" onkeypress="return validateTextField('hospitalName',30,'Hospital Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <!-- <div class="col-sm-5 p-t-5">
                                                            <label for="Hospital Check" class="form-check-label inner_md_htext m-t-5" >MI Room </label>
                                                            <input id='chkMi' type='checkbox' class=" form-check-input m-l-10 m-t-7"  value=''>
                                                        </div> -->
                                                        
                                                        <div class="form-check form-check-inline cusCheck m-t-5 m-l-10">
															<input class="form-check-input" id='chkMi' type='checkbox'>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label" for="chkMi">MI Room</label>
														</div> 
														 
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-7">
                                                                <input type="hidden" name="unitId" id="unitId" class="form-control" value="">
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
												
														<button type="button" id="btnAddHospital"
															class="btn  btn-primary " onclick="addHospitalDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateHospitalMaster();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateHospitalStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateHospitalStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
												
											</div>
										</div>
									</div>
										
                                    <%-- <div class="row">
                                        <div class="col-md-7">
                                        </div>
                                        <div class="col-md-5">
                                            <form>
                                                <div class="button-list">

                                                    <button id="btnAddHospital" type="button"  class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="addHospitalDetails();">Add</button>
                                                    <button id ="updateBtn" type="button"  class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateHospitalMaster();">Update</button>
                                                    <button id="btnActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateHospitalStatus();">Activate</button>
                                      				<button id="btnInActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateHospitalStatus();">Deactivate</button>
                                                    <button type="button" class="btn btn-danger btn-rounded w-md waves-effect waves-light" onclick="Reset();">Reset</button>

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