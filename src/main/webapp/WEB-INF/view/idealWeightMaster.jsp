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
	getAgeListOfMasRange();	
	getHeightListOfMasRange();
	
			
	//GetAge();
	GetAllIdealWeight('ALL');
	GetAllAdministrativeSex();		
		});
function GetAllIdealWeight(MODE){	
	var administrativeSexId = jQuery('#sGenderList').find('option:selected').val();
	 var idealWeightId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"administrativeSexId":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "administrativeSexId":administrativeSexId};
		} 
	var url = "getAllIdealWeight";		
	var bClickable = true;
	GetJsonData('tblListOfIdealWeight',data,url,bClickable);	 
}


function makeTable(jsonData)
{	
	var Gender ="";
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
		 
		 if(dataList[i].genderId==1 )
			{
				 Gender='Male'
			}
			else if(dataList[i].genderId == 2)
			{
				 Gender='Female'
			} 
			else{
				 Gender='Transender'
			}
		 
		 if(dataList[i].toHeight == "" ){
			 var toHeight = "";
		 }else{
			 var toHeight = dataList[i].toHeight;
		 }
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].idealWeightId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+Gender+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].fromAge+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].toAge+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].fromHeight+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+toHeight+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].weight+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfIdealWeight").html(htmlTable); 	
	
}

var comboArray = [];
var idealWtId;
var idealWtFromHeight;
var idealWtToHeight;
var idealWtFromAge;
var idealWtToAge;
var idealWtWeight;
var idealWtStatus;
var genderId; 
var ageRangeId;
var heightRangeId;
var heightRange;
var ageRange;
var flag;
function executeClickEvent(idealWeightId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(idealWeightId == data.data[j].idealWeightId){
			idealWtId = data.data[j].idealWeightId;
			genderId = data.data[j].genderId;
			idealWtFromAge = data.data[j].fromAge;			
			idealWtToAge = data.data[j].toAge;
			idealWtFromHeight = data.data[j].fromHeight;
			idealWtToHeight = data.data[j].toHeight;
			idealWtWeight = data.data[j].weight;
			idealWtStatus = data.data[j].status;
			ageRangeId=data.data[j].ageRangeId;
			heightRangeId=data.data[j].heightRangeId;
			flag=data.data[j].rangeFlag;
			//alert("idealWtStatus :: "+idealWtStatus);
			
			heightRange = idealWtFromHeight+"-"+idealWtToHeight;
			ageRange = idealWtFromAge+"-"+idealWtToAge;
			
		}
	}
	
	
	rowClick(idealWtId,genderId,ageRange,heightRange,idealWtWeight,idealWtStatus,ageRangeId,heightRangeId);
}





function GetAllAdministrativeSex(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllAdministrativeSex",
	    data: JSON.stringify({"PN":1}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){	    	
	    	var combo = "<option value=\"\">Select</option>" ;	    	
	    	for(var i=0;i<result.data.length;i++){	
	    		comboArray[i] = result.data[i].administrativeSexName;
	    		if(result.data[i].status == 'Y' || result.data[i].status == 'y'){
	    			combo += '<option value='+result.data[i].administrativeSexId+'>' +result.data[i].administrativeSexName+ '</option>';
	    		}
	    	}
	    	jQuery('#selectGender').append(combo);
	    	jQuery('#sGenderList').append(combo);
	    }	    
	});
}

var adminSexId='';
function changeGenderId(){
	adminSexId = $j('#selectGender').find('option:selected').val();
		
	if(adminSexId == 1 || adminSexId == 2 || adminSexId == 3){
		getAgeAndHeightListOfMasRange();
		
	}
}
var rangeID;
function getAgeAndHeightListOfMasRange(){
	jQuery('#selectAge').html("");
	jQuery('#selectHeight').html("");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getMasRange",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){	    	
	    	var combo = "<option value=\"\">Select</option>";	
	    	var combo1 = "<option value=\"\">Select</option>";	
	    	for(var i=0;i<result.data.length;i++){  
	    		
	    		comboArray[i] = result.data[i].rangeId;	
	    		
	    		if(result.data[i].rangeFlag == 'A' && result.data[i].genderId == adminSexId){
	    			
	    			combo += '<option value='+result.data[i].rangeId+'>' +result.data[i].fromAgeToAge+ '</option>';
	    		}else if(result.data[i].rangeFlag == 'H' && result.data[i].genderId == adminSexId){
	    			
	    			combo1 += '<option value='+result.data[i].rangeId+'>' +result.data[i].fromHeightToHeight+ '</option>';
	    			
	    			
	    		}    		
	    	}
	    	
	    	jQuery('#selectAge').append(combo);
	    	jQuery('#selectHeight').append(combo1);
	    }
	    
	});
	$j('#selectAgeDiv').show();
	$j('#selectHeightDiv').show();
}

function rowClick(idealWtId,genderId,ageRange,heightRange,idealWtWeight,idealWtStatus,ageRangeId,heightRangeId){	
		
			
	 if(genderId!=0){	 
			//alert("genderId if :: "+genderId); 
			jQuery("#selectGender").val(genderId);
			
	}	
	 
	 
	 for(var j=0;j<comboArray.length;j++){
		 
		 if(comboArray[j] == heightRangeId){
			 		 
			 $j('#selectHeight').val(heightRangeId);
		 }
	 }
	
	for(var j=0;j<comboArray.length;j++){
		 
		 if(comboArray[j] == ageRangeId){
			 		 
			 $j('#selectAge').val(ageRangeId);
		 }
	 }
	 
	document.getElementById("ideaWeight").value = idealWtWeight; 
	

	if(idealWtStatus == 'Y' || idealWtStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();		
		$j('#addIdealWeight').hide();
	}
	if(idealWtStatus == 'N' || idealWtStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
	}
	
	$j('#addIdealWeight').hide();	
	 $j("#btnActive").attr("disabled", false);
	 $j("#btnInActive").attr("disabled", false);
	 
	
}

function getHeightListOfMasRange(){
	jQuery('#selectAge').html("");
	jQuery('#selectHeight').html("");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getMasRange",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){	    	
	    	var combo = "<option value=\"\">Select</option>" ;	    	
	    	for(var i=0;i<result.data.length;i++){    		
	    		comboArray[i] = result.data[i].rangeId;	
	    		if(result.data[i].rangeFlag == 'H'){
	    		combo += '<option value='+result.data[i].rangeId+'>' +result.data[i].fromHeightToHeight+ '</option>';	    			    		
	    		}	    		
	    	}
	    	jQuery('#selectHeight').append(combo);
	    	
	    }
	    
	});
	$j('#selectAgeDiv').show();
	$j('#selectHeightDiv').show();
}

function getAgeListOfMasRange(){
	
	jQuery('#selectAge').html("");
	jQuery('#selectHeight').html("");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getMasRange",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){	    	
	    	var combo = "<option value=\"\">Select</option>" ;	    	
	    	for(var i=0;i<result.data.length;i++){    		
	    		comboArray[i] = result.data[i].rangeId;	
	    		if(result.data[i].rangeFlag == 'A'){
	    		combo += '<option value='+result.data[i].rangeId+'>' +result.data[i].fromAgeToAge+ '</option>';	    			    		
	    		}	    		
	    	}
	    	jQuery('#selectAge').append(combo);
	    	
	    }
	    
	});
	$j('#selectAgeDiv').show();
	$j('#selectHeightDiv').show();
}


function addIdealWeightDetails(){
	
	if(document.getElementById('selectGender').value=="" || document.getElementById('selectGender')==null){
		alert("Please Select Gender");
		return false;
	}
	 
	if(document.getElementById('selectHeight').value==""){
		alert("Please Select the Height");
		return false;
	}
	
	if(document.getElementById('selectAge').value=="" || document.getElementById('selectAge')==null){
		alert("Please select Age");
		return false;
	} 
	
	if(document.getElementById('ideaWeight').value=="" || document.getElementById('ideaWeight')==null){
		alert("Please Enter the Ideal Weight");
		return false;
	}
	$('#addIdealWeight').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'administrativeSexId':jQuery('#selectGender').find('option:selected').val(),// jQuery('#ideaWeight').val(),
			 'masRange1':jQuery('#selectHeight').find('option:selected').val(),
			 'masRange2':jQuery('#selectAge').find('option:selected').val(),
			 'weight':jQuery('#ideaWeight').val(),
			 'userId':userId
	 } 	
	var url="addIdealWeight";
	SendJsonData(url,params);
	}
	
function updateIdealWeight(istatus)
{	
	
	if(document.getElementById('selectGender').value=="" || document.getElementById('selectGender')==null){
		alert("Please Select Gender");
		return false;
	}
	 
	if(document.getElementById('selectHeight').value==""){
		alert("Please Select the Height");
		return false;
	}
	
	if(document.getElementById('selectAge').value=="" || document.getElementById('selectAge')==null){
		alert("Please Enter the Age");
		return false;
	} 
	
	if(document.getElementById('ideaWeight').value=="" || document.getElementById('ideaWeight')==null){
		alert("Please Enter the Weight");
		return false;
	}
	var userId =  $j('#userId').val();	
	var params = {
			 'idealWeightId':idealWtId,
			 'weight':jQuery('#ideaWeight').val(),
			 'masRange1':jQuery('#selectHeight').find('option:selected').val(),
			 'masRange2':jQuery('#selectAge').find('option:selected').val(),
			 'genderId':jQuery('#selectGender').find('option:selected').val(),
			 'status':istatus,
			 'userId':userId
	 } 
	var url="updateIdealWeight";
	SendJsonData(url,params);	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j("#addIdealWeight").show();	 		
	
	ResetForm();
}


 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllIdealWeight('FILTER');
	
} 
 function Reset(){
	 
	    getAgeListOfMasRange();	
		getHeightListOfMasRange();
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j("#addIdealWeight").show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		showAll();
	}



	function ResetForm()
	{	
		
		$j('#ideaWeight').val('');
		$j('#selectHeight').val('');
		$j('#selectAge').val('');
		$j('#selectGender').val('');
		$j('#sGenderList').val('');
		
	}

	function showAll()
	{
		ResetForm();
		nPageNo = 1;	
		GetAllIdealWeight('ALL');
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j("#addIdealWeight").show();
		
	}

	 function search()
	 {
	 	if(document.getElementById('sGenderList').value == "" || document.getElementById('sGenderList').value == 0){
	  		alert("Please Select Gender");
	  		return false;
	  	}
	 	nPageNo=1;
	 	GetAllIdealWeight('Filter');
	 	//ResetForm();
	 }
	 
	 function generateReport()
	 {

		 var url="${pageContext.request.contextPath}/report/generateIdealWeightReport";
		 openPdfModel(url);
	 	/* document.idealWeightForm.action="${pageContext.request.contextPath}/report/generateIdealWeightReport";
	 	document.idealWeightForm.method="POST";
	 	document.idealWeightForm.submit();  */
	 	
	 	
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
                <div class="internal_Htext">Ideal Weight Master</div>
                    <div class="row">
                      
                    </div>
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                      <form class="form-horizontal"  name="idealWeightForm" >  
                                    <div class="row">
                                                                     
                                        <div class="col-md-8">
                                         
                                               <div class="form-group row">
                                                    <label class="col-2 col-form-label">Gender<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                       
                                                               <select class="form-control" id="sGenderList" onchange="">
                                                                    
                                                                </select>
                                                    </div>
                                                    <div class="form-group row">
                                                    
                                                    <div class="col-md-12">
                                                       <button type="button" class="btn  btn-primary obesityWait-search " onclick="search();">Search</button>
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
                                                <th id="th3" class ="inner_md_htext">From Age</th>
                                                <th id="th3" class ="inner_md_htext">To Age</th>
                                                <th id="th4" class ="inner_md_htext">From Height</th>
                                                <th id="th4" class ="inner_md_htext">To Height</th>
                                                <th id="th5" class ="inner_md_htext">Ideal Weight</th>
                                                <th id="th6" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfIdealWeight">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addIdealWeightForm" name="addIdealWeightForm" action="" method="POST">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="" class=" col-form-label inner_md_htext" >Gender <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectGender" name="selectGender" onchange="changeGenderId();">
                                                                   
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row" id="selectHeightDiv">                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext"> Height <span class="mandate"><sup>&#9733;</sup></span></label>  
                                                             <div class="col-md-7">                                                          
                                                             <select class="form-control" id="selectHeight" name="selectHeight">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                       <div class="form-group row" id="selectAgeDiv">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Age<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectAge" name="selectAge">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                       <div class="col-md-4">
                                                        <div class="form-group row">                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Ideal Weight<span class="mandate"><sup>&#9733;</sup></span></label>                                                            
                                                            <div class="col-md-7">
                                                                 <input type="text" class="form-control" id="ideaWeight" name="ideaWeight" placeholder="Ideal Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" maxlength="6"/>
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
												
														<button type="button" id="addIdealWeight"
															class="btn  btn-primary " onclick="addIdealWeightDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateIdealWeight('update');">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateIdealWeight('active');">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateIdealWeight('inactive');">Deactivate</button>
															
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