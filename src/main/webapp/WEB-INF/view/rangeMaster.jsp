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
     <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" />
    
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
			$j('#rangeFlag').attr('readonly', false);
			 $j('#selectGender').attr('readonly', false);
			GetRangeList('ALL');
			GetGenderList();
			
		});

		
function GetRangeList(MODE)
{
	var genderId = jQuery('#sGender').find('option:selected').val();
	var rangeId=0;
	if(MODE == 'ALL'){
		var data = {"PN":nPageNo,"administrativeSexId":""};			
	}
else
	{
	var data = {"PN":nPageNo, "administrativeSexId":genderId};
	} 
	var url = "getAllRange";
		
	var bClickable = true;
	GetJsonData('tblListOfRange',data,url,bClickable);
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
		 
		 var RangeType = "";
		 
		 if(dataList[i].rangeFlag == 'A' || dataList[i].rangeFlag == 'a')
			 {
			 RangeType='Age'
			 }
		 else if (dataList[i].rangeFlag == 'H' || dataList[i].rangeFlag == 'h')
			 {
			 RangeType = 'Height'
			 }
			htmlTable = htmlTable+"<tr id='"+dataList[i].rangeId+"' >";	
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].administrativeSexName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].fromRange+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].toRange+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+RangeType+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfRange").html(htmlTable);	
	
	
}
var comboArray = [];
var rId;
var rFromRange;
var rToRange;
var rStatus;
var rRangeFlag
var gName;
var gId;
function executeClickEvent(rangeId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(rangeId == data.data[j].rangeId){
			rId = data.data[j].rangeId;
			rFromRange = data.data[j].fromRange;
			rToRange = data.data[j].toRange;
			rStatus = data.data[j].status;
			rRangeFlag = data.data[j].rangeFlag;
			gName = data.data[j].administrativeSexName;
			gId = data.data[j].administrativeSexId;
			
		}
	}
	rowClick(rId,rFromRange,rToRange,rStatus,rRangeFlag,gName,gId);
}

/* function searchRangeList(){	
	if(document.getElementById('sGender').value == "" || document.getElementById('sGender') == null){
		 alert("Plese Select Gender");
		 return false;
	 }	 	 
	 var genderId= jQuery("#sGender").val();
		
		var nPageNo=1;
		var url = "getAllRange";
		var data =  {"PN":nPageNo, "administrativeSexId":genderId};
		var bClickable = true;
		GetJsonData('tblListOfRange',data,url,bClickable);		
} */

function addRangeDetails(){
	
	if(document.getElementById('selectGender').value=="" || document.getElementById('selectGender').value==null){
		alert("Please select Gender");
		return false;
	} 
	 if(document.getElementById('fromRange').value=="" || document.getElementById('fromRange').value==null){
		alert("Please Enter From Range");
		return false;
	}
	 
	if(document.getElementById('toRange').value=="" || document.getElementById('toRange').value==null){
		alert("Please Enter To Range");
		return false;
	}
	if(document.getElementById('rangeFlag').value=="0" || document.getElementById('rangeFlag').value==null){
		alert("Please Select Range Type");
		return false;
	}
	
	$('#btnAddRange').prop("disabled", true);
	var userId =  $j('#userId').val();
	
	var params = {
			'administrativeSexId':jQuery('#selectGender').find('option:selected').val(),
			 'fromRange':jQuery('#fromRange').val(),
			 'toRange':jQuery('#toRange').val(),
			 'rangeFlag':jQuery('#rangeFlag').find('option:selected').val(),
			 'userId':userId
	 } 
	
	if(validateRange()){
		//alert("validateRange() :: "+validateRange())
		var url="addRange";		
		SendJsonData(url,params);
		
	}else{
		return false;
	}
	
		
	
}




function updateRangeDetails()
{	
	$j('#messageId').fadeIn();
	$j('#rangeFlag').attr('disabled', false);
	 $j('#selectGender').attr('disabled', false);
	 if(document.getElementById('fromRange').value == "" || document.getElementById('fromRange').value == null ){
		alert("please enter the From Range");
		return false;
	}
	if(document.getElementById('toRange').value == "" || document.getElementById('toRange').value == null ){
		alert("please enter the To Range");
		return false;
	}
	var userId =  $j('#userId').val();	
	var params = {
			 'rangeId':rId,
			 'fromRange':jQuery('#fromRange').val(),
			 'toRange':jQuery('#toRange').val(),
			 'userId':userId
	 } 
	if(validateRange()){
	var url="updateRangeDetails";
	SendJsonData(url,params);	
 		 		
	$j("#btnInActive").hide();
	$j("#btnActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddRange').show();	 
    $j('#btnAddRange').attr("disabled", false);
    $j('#rangeFlag').val('0');
	ResetForm();
	}else{
		return false;
		$j('#updateBtn').show();
		$j('#btnAddRange').attr("disabled", false);
	}
	
}

function updateStatus(){
	$j('#messageId').fadeIn();
	$j('#rangeFlag').attr('disabled', false);
	 $j('#selectGender').attr('disabled', false);
	if(document.getElementById('fromRange').value == "" || document.getElementById('fromRange') == null ){
		alert("Please Select the From Range");
		return false;
	}
	var userId =  $j('#userId').val();	
	 var params = {
		 'rangeId':rId,
		 'fromRange':rFromRange,
		 'status':rStatus,
		 'userId':userId
		 
		 
	}  
	 
	 var url="updateRangeStatus";
	 SendJsonData(url,params);	 
	    $j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddRange').show();	 
		$j('#rangeFlag').attr('disabled', false);
		$j('#selectGender').attr('disabled', false);
		$j('#selectGender').val('');
		$j('#rangeFlag').val('0');
		
	    
}



function GetGenderList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getGenderList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].administrativeSexName;
	    		combo += '<option value='+result.data[i].administrativeSexId+'>' +result.data[i].administrativeSexName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectGender').append(combo);
	    	jQuery('#sGender').append(combo);
	    }
	    
	});
}

function rowClick(rId,rFromRange,rToRange,rStatus,rRangeFlag,gName,gId){	
		
	document.getElementById("fromRange").value = rFromRange;
	document.getElementById("toRange").value = rToRange;
	
	for(var j=0; j<comboArray.length;j++){		
		if(comboArray[j] == gName){
			
			jQuery("#selectGender").val(gId);
		}
	}
			
	jQuery("#rangeFlag").val(rRangeFlag);
		
	
	if(rStatus == 'Y' || rStatus == 'y'){
		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddRange').hide();
		$j('#rangeFlag').attr("disabled","disabled");
		$j('#selectGender').attr("disabled","disabled");
	}
	if(rStatus == 'N' || rStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddRange').hide();
		$j('#rangeFlag').attr("disabled","disabled");
		$j('#selectGender').attr("disabled","disabled");
	}

	
	
	
}

function changeGender(value){
	
	var administrativeSexId = jQuery('#selectGender').find('option:selected').val();
	
	if(value == administrativeSexId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}
function showResultPage(pageNo)
{
	
	
	nPageNo = pageNo;	
	GetRangeList('FILTER');
	
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
    	//alert("Please enter less than or equal to 10 digit number for Range");
    	alert("Please enter valid Range");
        return false;
    }
    return true;
}

function Reset(){
	document.getElementById("addRangeForm").reset();
	document.getElementById("rangeForm").reset();
	document.getElementById('sGender').value = "";
	$j('#rangeFlag').attr('disabled', false);
	 $j('#selectGender').attr('disabled', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddRange').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	showAll();
}



function ResetForm()
{	
	$j('#fromRange').val('');
	$j('#toRange').val('');
	$j('#selectGender').val('');
	$j('#searchRange').val('');
	
	
}

function showAll()
{
	$j('#sGender').val('');
	ResetForm();
	nPageNo = 1;	
	GetRangeList('ALL');
	$j("#btnInActive").hide();
	$j("#btnActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddRange').show();
	$j('#btnAddRange').attr("disabled", false);
	$j('#rangeFlag').attr('disabled', false);
	$j('#selectGender').attr('disabled', false);
	$j('#selectGender').val('');
	$j('#rangeFlag').val('0');
	
}

function search()
{
	if(document.getElementById('sGender').value == "" || document.getElementById('sGender').value == 0){
 		alert("Please Select Gender");
 		return false;
 	}
	nPageNo=1;
	GetRangeList('Filter');
	ResetForm();
}
function generateReport()
{
	//$('#urlForReport').val("${pageContext.request.contextPath}/report/generateRangeMasterReport");
	var url="${pageContext.request.contextPath}/report/generateRangeMasterReport";
	openPdfModel(url);
	/* document.rangeForm.action="${pageContext.request.contextPath}/report/generateRangeMasterReport";
	document.rangeForm.method="POST";
	document.rangeForm.submit();  */
	
}

function validateRange(){
	var rangeFlag = jQuery('#rangeFlag').find('option:selected').val();
	var genderId = jQuery('#selectGender').find('option:selected').val();
	//alert("rangeFlag :: "+rangeFlag +" genderId :: "+genderId);
	if(rangeFlag == 'A'){	
		
	 var fromRange = $('#fromRange').val();
	 var toRange = $('#toRange').val();
	 
	if(fromRange == ''){
		alert("Please Enter the From Age");
	}
	if(toRange == ''){
		alert("Please Enter the To Age");
	}
	 
	 if(fromRange <=0 || toRange >=100){
		 alert("Please Enter the valid Range of Age");
		 return false;
	 } 
	 
	 if(parseInt(fromRange) >= parseInt(toRange)){
		 
		 alert("From age range cannot be (greater than or equal to) To Age Rang")
		 return false;
	 }else{
		 return true;
	 }
	} 
	
	if(rangeFlag == 'H'){
		var fromRange = $('#fromRange').val();
		 var toRange = $('#toRange').val();
		 
		if(fromRange == ''){
			alert("Please Enter the From Height");
		}
		if(toRange == ''){
			alert("Please Enter the To Height");
		}
		 
		 if(fromRange <=0 || toRange >=200){
			 alert("Please Enter the valid Range of Height");
			 return false;
		 }
		if(parseInt(fromRange) != parseInt(toRange)){
			 
			 alert("From Height Range should equal To Height Range")
			 return false;
		 }else{
			 return true;
		 } 
	}
}
		 


function validateHeightRange(){
	
}

$(document).ready(function () {
    $("#rangeFlag").change(function () {
    if (this.value === 'H' || this.value === 'h')
        $("input[name='toRange']").prop('readonly', true);
    else
      	$("input[name='toRange']").prop('readonly', false);
		});
});

function myChangeFunction(fromRange) {
    var toRange = document.getElementById('toRange');
    var rangeFlag = document.getElementById('rangeFlag');
    //if(rangeFlag == 'H' || rangeFlag == 'h'){
    toRange.value = fromRange.value;
    //}
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
                <div class="internal_Htext">Range Master</div>
                    
                    <!-- end row -->
                   
                  <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       <form class="form-horizontal" id="rangeForm" name="rangeForm" method="" role="form">  
                                    <div class="row">
                                                                     
                                        <div class="col-md-8">
                                         
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Gender<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                       
                                                     <select class="form-control" id="sGender" onchange="">
                                                                    
                                                                </select>
                                                    </div>
                                                    
                                                    <!-- <div class="col-3"><button type="button" class="btn  btn-primary " onclick="GetRangeList('FILTER');">Search</button> </div> -->
                                                    
                                                  <div class="form-group row">
                                                    
                                                    <div class="col-md-12">
                                                       <button type="button" class="btn  btn-primary " onclick="search();">Search</button>
                                                    </div>
                                                    </div>
                                                
                                                
                                                </div>
                                            

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
                                  </form>
                                       

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
                                                <th id="th2" class ="inner_md_htext">Gender</th>
                                                <th id="th3" class ="inner_md_htext">From Range</th>
                                                <th id="th4" class ="inner_md_htext">To Range</th>
                                                <th id="th4" class ="inner_md_htext">Range Type</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfRange">
										 
                     				 </tbody>
                                    </table>
                                    
                                   
                                    
                                    

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addRangeForm" name="addRangeForm" method="">
                                                <div class="row">
                                                <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Gender<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectGender" onchange="changeGender(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Range Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                               <select class="form-control" id="rangeFlag"  onchange="">
                                                                    <option value="0">Select</option>
                                                                    <option value="A">Age</option>
                                                                    <option value="H">Height</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="From Range" class=" col-form-label inner_md_htext" >From Range<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="fromRange" name="fromRange" onchange="myChangeFunction(this)" placeholder="From Range"  onkeypress="return isNumber(event);">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Name" class="col-form-label inner_md_htext">To Range<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="toRange" name="toRange" placeholder="To Range" onkeypress="return isNumber(event);">
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
											
														<button type="button" id="btnAddRange"
															class="btn  btn-primary " onclick="addRangeDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateRangeDetails();">Update</button>
															
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