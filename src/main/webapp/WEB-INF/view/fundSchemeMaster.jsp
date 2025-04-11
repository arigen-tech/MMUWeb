<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>
<script type="text/javascript">
var nPageNo=1;
var $j = jQuery.noConflict();
<% 
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
%>

$j(document).ready(function(){
	$j("#btnActive").hide();
	$j("#btnInActive").hide();		
	$j('#updateBtn').hide();	  
	$j('#fundSchemeCode').attr('readonly', false);		
	GetAllFundScheme('ALL');
});

function GetAllFundScheme(MODE){
	 
	var fundSchemeName=$("#searchFundSchemeName").val();		 
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "fundSchemeName":""};			
		}else{
		var data = {"PN":nPageNo, "fundSchemeName":fundSchemeName};
		} 
	var url = "getAllFundScheme";		
	var bClickable = true;
	GetJsonData('tblListOfFundScheme',data,url,bClickable);	 
}

	
function makeTable(jsonData){	
	var htmlTable = "";	
	var data = jsonData.count; 
	var pageSize = 5; 	
	var dataList = jsonData.data;
	
	for(i=0;i<dataList.length;i++){		
		if(dataList[i].status == 'Y' || dataList[i].status == 'y'){
			var Status='Active'
		}else{
			var Status='Inactive'
		} 		
				
		htmlTable = htmlTable+"<tr id='"+dataList[i].fundSchemeId+"' >";			
		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].fundSchemeCode+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].fundSchemeName+"</td>";
		htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
		htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0){
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
	}			
	
	
	$j("#tblListOfFundScheme").html(htmlTable); 	
	
}
var fundSchemeId;
var fundSchemeid='';
var fundSchemeCode;
var fundSchemeName;
var Status;

function executeClickEvent(fundSchemeId,data){
	
	for(j=0;j<data.data.length;j++){
		if(fundSchemeId == data.data[j].fundSchemeId){
			fundSchemeId = data.data[j].fundSchemeId;			
			fundSchemeCode = data.data[j].fundSchemeCode;			
			fundSchemeName = data.data[j].fundSchemeName;
			Status = data.data[j].status;	
		}
	}
	rowClick(fundSchemeId,fundSchemeCode,fundSchemeName,Status);
}

function rowClick(fundSchemeId,fundSchemeCode,fundSchemeName,Status){	
	fundSchemeid=fundSchemeId;
	document.getElementById("fundSchemeCode").value = fundSchemeCode;
	document.getElementById("fundSchemeName").value = fundSchemeName;
	 if(Status == 'Y' || Status == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddFundScheme').hide();
	}
	if(Status == 'N' || Status == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddFundScheme').hide();
	}
	
	$j('#fundSchemeCode').attr('readonly', true);
	
}

function addFundSchemeMaster(){
	if(document.getElementById('fundSchemeCode').value == null || document.getElementById('fundSchemeCode').value == ""){
		alert("Please Enter Fund Scheme Code");
		return false;
	}
	if(document.getElementById('fundSchemeName').value == null || document.getElementById('fundSchemeName').value ==""){
		alert("Please Enter fund Scheme Name");
		return false;
	}
	
	$j('#btnAddFundScheme').prop("disabled",true);
	var params = {		
		'fundSchemeId':jQuery('#fundSchemeId').val(),
		'fundSchemeCode':jQuery('#fundSchemeCode').val(),
		'fundSchemeName':jQuery('#fundSchemeName').val(),
		'userId': <%= userId%>,
	 }
	
	//alert(JSON.stringify(params));
    var url = "addFundSchemeMaster";
    SendJsonData(url,params);
    $j('#btnAddFundScheme').attr("disabled", false);
    ResetForm();
}

function updateFundSchemeMaster(){	
	if(document.getElementById('fundSchemeCode').value == null || document.getElementById('fundSchemeCode').value == ""){
		alert("Please Enter Fund Scheme Code");
		return false;
	}
	if(document.getElementById('fundSchemeName').value == null || document.getElementById('fundSchemeName').value ==""){
		alert("Please Enter fund Scheme Name");
		return false;
	}
		
	var params = {		
		 'fundSchemeId' : fundSchemeid,
		 'fundSchemeCode':jQuery('#fundSchemeCode').val(),
		 'fundSchemeName':jQuery('#fundSchemeName').val(),
		 'status':Status,
		 'userId': <%= userId%>,
	 }
	//alert(JSON.stringify(params));
    var url = "updateFundSchemeMaster";
    SendJsonData(url,params);
	$j('#btnAddFundScheme').attr("disabled", false);
	ResetForm();
}

function updateFundSchemeStatus(){
	var params = {	
			'fundSchemeId' : fundSchemeid,		 
			'status':Status
		} 
	//alert(JSON.stringify(params));
    var url = "updateFundSchemeStatus";
    SendJsonData(url,params);
}

function Reset(){
	document.getElementById('searchFundSchemeName').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddFundScheme').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#fundSchemeCode').attr('readonly', false);
	showAll();
}
		
function ResetForm(){	
	$j('#fundSchemeCode').val('');
	$j('#fundSchemeName').val('');
	$j('#searchFundSchemeName').val('');
}

function showAll(){
	ResetForm();
	nPageNo = 1;	
	GetAllFundScheme('ALL');
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddFundScheme').show();
	$j('#fundSchemeCode').attr('readonly', false);
	
	
}
 function showResultPage(pageNo){
	nPageNo = pageNo;	
	GetAllFundScheme('FILTER');	
} 

$(document).ready(function () {
    $("#search").click(function () {
    	 var fundName = $("#searchFundSchemeName").val();
         if(fundName != undefined && fundName != ""){
        	nPageNo=1;
        	GetAllFundScheme('FILTER'); 
         }else{
        	 alert("Please Enter Fund Scheme Name");
      		return false; 
         }
       
    });
});
function isNumberKey(txt, evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode == 46) {
        //Check if the text already contains the . character
        if (txt.value.indexOf('.') === -1) {
            return true;
        } else {
            return false;
        }
    } else {
        if (charCode > 31
             && (charCode < 48 || charCode > 57))
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
			<div class="container-fluid">

				<div class="internal_Htext">Fund Scheme Master</div>
				<input type="hidden"  name="fundSchemeId" value="" id="fundSchemeId" />
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Fund Scheme Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" name="searchFundSchemeName" id="searchFundSchemeName" class="form-control"
												 placeholder="Fund Scheme Name" onkeypress="return validateText('searchFundSchemeName',30,'Fund Scheme Name')">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" id="search">Search</button>
									</div>
									 <div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="showAll()">Show All</button>
									</div>
								</div>
								
								<div>
								<div style="float:left">               
                                   <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   
                                   <tr>
	                                   <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
	                                  <td></td>
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
                                                <th>Fund Scheme Code</th>
                                                <th>Fund Scheme Name</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                       <tbody class="clickableRow" id="tblListOfFundScheme">
										 
                     				   </tbody> 
                                    </table>
								</div>
								
								<form id="addSocietyForm" name="addSocietyForm" method="">
								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Fund Scheme Code</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="fundSchemeCode" name="fundSchemeCode" placeholder="Fund Scheme Code" onkeypress=" return validateText('fundSchemeCode',7,'Fund Scheme Code');" />
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Fund Scheme Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control"  id="fundSchemeName" name="fundSchemeName" placeholder="Fund Scheme Name" onkeypress="return validateText('fundSchemeName',30,'Fund Scheme Name')" />
											</div>
										</div>
									</div>
								</div>
								</form>
								
							
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<button type="button" id="btnAddFundScheme" class="btn  btn-primary" onclick="addFundSchemeMaster();">Add</button>
									<button type="button" id="updateBtn" class="btn  btn-primary" onclick="updateFundSchemeMaster();">Update</button>
									<button type="button" id="btnActive"  class="btn  btn-primary" onclick="updateFundSchemeStatus();">Activate</button>
									<button type="button" id="btnInActive"  class="btn btn-primary" onclick="updateFundSchemeStatus();">Deactivate</button>
									<button type="button" class="btn btn-danger" onclick="Reset();">Reset</button>
								</div>
                               </div>	
							</div>
						</div>
						
						
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->


</body>

</html>






