<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
  
<script type="text/javascript">

	var nPageNo=1;
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
		$j('#districtCode').attr('readonly', false);		
		GetAllDistrict('ALL');
		loadVendors();
			});
			
	function GetAllDistrict(MODE){
		 
		var districtName=$("#searchDistrictName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "districtName":""};			
			}else{
			var data = {"PN":nPageNo, "districtName":districtName};
			} 
		var url = "getAllDistrict";		
		var bClickable = true;
		GetJsonData('tblListOfDistrict',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].districtId+"' >";
				htmlTable = htmlTable +"<td style='display:none'>"+dataList[i].sequenceNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].districtCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].districtName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfDistrict").html(htmlTable); 	
		
	}
    var districtId;
	var districtid='';
	var sequenceNo;
	var districtCode;
	var districtName;
	var stateId;
	var Status;
	var population;
	var upss;
	var longitude;
	var latitude;
	var startDate;
	var vendorIdds;
	function executeClickEvent(districtId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(districtId == data.data[j].districtId){
				districtId = data.data[j].districtId;
				sequenceNo=data.data[j].sequenceNo;
				districtCode = data.data[j].districtCode;			
				districtName = data.data[j].districtName;
				stateId = data.data[j].stateId;
				Status = data.data[j].status;
				vendorIdds=data.data[j].vendorId;
				population = data.data[j].population;
				if(data.data[j]!=null && data.data[j].upss!=null && data.data[j].upss!=undefined)
				upss = data.data[j].upss;
				else{
					upss="";
				}
				longitude = data.data[j].longitude;
				latitude = data.data[j].latitude;
				startDate = data.data[j].startDate;
				
			}
		}
		rowClick(districtId,sequenceNo,districtCode,districtName,stateId,Status,population,upss,longitude,latitude,startDate,vendorIdds);
	}
	
	function rowClick(districtId,sequenceNo,districtCode,districtName,stateId,Status,population,upss,longitude,latitude,startDate,vendorIdds){	
		districtid=districtId;
		document.getElementById("sequenceNo").value = sequenceNo;
		document.getElementById("districtCode").value = districtCode;
		document.getElementById("districtName").value = districtName;
		document.getElementById("state").value = stateId;
		document.getElementById("vendorId").value = vendorIdds;
		document.getElementById("population").value = population;
		document.getElementById("UPSS").value = upss;
		 if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddDistrict').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDistrict').hide();
		}
		
		
		$j('#districtCode').attr('readonly', true);
		
		document.getElementById("longitude").value = longitude;
		document.getElementById("latitude").value = latitude;
		document.getElementById("startDate").value = startDate;
	}


		function addDistrict(){
			
			if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value == ""){
				alert("Please Enter Sequence No.");
				return false;
			}
			
			if(document.getElementById('districtCode').value == null || document.getElementById('districtCode').value == ""){
				alert("Please Enter District Code");
				return false;
			}
			if(document.getElementById('districtName').value == null || document.getElementById('districtName').value ==""){
				alert("Please Enter district Name");
				return false;
			}
			
			if(document.getElementById('state').value == null || document.getElementById('state').value ==""){
				alert("Please Select State");
				return false;
			}
			if(document.getElementById('UPSS').value == null || document.getElementById('UPSS').value ==""){
				alert("Please Enter UPSS Name");
				return false;
			}

			if(document.getElementById('longitude').value == null || document.getElementById('longitude').value ==""){
				alert("Please Enter Longitude Name");
				return false;
			}

			if(document.getElementById('latitude').value == null || document.getElementById('latitude').value ==""){
				alert("Please Enter Latitude Name");
				return false;
			}
			if(document.getElementById('startDate').value == null || document.getElementById('startDate').value ==""){
				alert("Please Enter Start Date");
				return false;
			}

			
			$j('#btnAddDistrict').prop("disabled",true);
			var params = {		
					 'sequenceNo':jQuery('#sequenceNo').val(),
					 'districtCode':jQuery('#districtCode').val(),
					 'districtName':jQuery('#districtName').val(),
					 'stateId':jQuery('#state').val(),
					 'userId': <%= userId%>,
					 'population' : jQuery('#population').val(),
					 'UPSS':jQuery('#UPSS').val(),
					 'longitude':jQuery('#longitude').val(),
					 'latitude':jQuery('#latitude').val(),
					 'startDate':jQuery('#startDate').val(),
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addDistrict";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateDistrict(){
			if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value == ""){
				alert("Please Enter Sequence No.");
				return false;
			}
			if(document.getElementById('districtCode').value == null || document.getElementById('districtCode').value == ""){
				alert("Please Enter District Code");
				return false;
			}
			if(document.getElementById('districtName').value == null || document.getElementById('districtName').value ==""){
				alert("Please Enter district Name");
				return false;
			}
			
			if(document.getElementById('state').value == null || document.getElementById('state').value ==""){
				alert("Please Select State");
				return false;
			}
			if(document.getElementById('UPSS').value == null || document.getElementById('UPSS').value ==""){
				alert("Please Enter UPSS Name");
				return false;
			}
			if(document.getElementById('longitude').value == null || document.getElementById('longitude').value ==""){
				alert("Please Enter Longitude Name");
				return false;
			}

			if(document.getElementById('latitude').value == null || document.getElementById('latitude').value ==""){
				alert("Please Enter Latitude Name");
				return false;
			}
			if(document.getElementById('startDate').value == null || document.getElementById('startDate').value ==""){
				alert("Please Enter Start Date");
				return false;
			}
			
			var params = {		
					 'districtId' : districtid,
					 'sequenceNo':jQuery('#sequenceNo').val(),
					 'districtCode':jQuery('#districtCode').val(),
					 'districtName':jQuery('#districtName').val(),
					 'stateId':jQuery('#state').val(),
					 'status':Status,
					 'userId': <%= userId%>,
					 'population' : jQuery('#population').val().trim(),
					 'UPSS':jQuery('#UPSS').val(),
					 'longitude':jQuery('#longitude').val(),
					 'startDate':jQuery('#startDate').val(),
					 'latitude':jQuery('#latitude').val(),
					 'vendorId':jQuery('#vendorId').val()
			 }
			//alert(JSON.stringify(params));
				    var url = "updateDistrict";
				    SendJsonData(url,params);
					$j('#btnAddDistrict').attr("disabled", false);
					$j('#cityCode').attr('readonly', true);
					ResetForm();
		}
		
		function updateDistrictStatus(){
			
			
			var params = {
					
					'districtId':districtid,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateDistrictStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchDistrictName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDistrict').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#districtCode').attr('readonly', false);
			document.getElementById('UPSS').value = "";
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#districtCode').val('');
			$j('#districtName').val('');
			$j('#searchDistrictName').val('');
			$j('#state').val('');
			$j('#population').val('');
			$j('#UPSS').val('');
			$j('#longitude').val('');
			$j('#latitude').val('');
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllDistrict('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDistrict').show();
			$j('#districtCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllDistrict('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchDistrictName').value == ""){
		  		alert("Please Enter District Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllDistrict('FILTER');
		 }
		 
		 function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateBankMasterReport";
			 openPdfModel(url)
		 	
		 }
 
		 
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
		 
		 function loadVendors(){
				//var vendorId=1;
			    var params = {"PN":0,"status":"y"}
			    var pathname = window.location.pathname;
			    var accessGroup = "MMUWeb";
			    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/audit/getVendors";
			    $.ajax({
			        type : "POST",
			        contentType : "application/json",
			        url : url,
			        data : JSON.stringify(params),
			        dataType : "json",
			        cache : false,
			        success : function(result) {
			            if(result.data.length > 0){
			                $('#vendorId').empty().append('<option value="">--Select--</option>');
			                for(var i=0;i<result.data.length;i++){
			                    var rowData = result.data[i];
			                   	
			                    $('#vendorId').append($('<option/>').val(rowData.mmuVendorId).text(rowData.mmuVendorName));
			                    
			                }
			            }
			        },
			        error : function(data) {
			            alert("An error has occurred while contacting the server");
			        }
			    });
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
                <div class="internal_Htext">District Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDistrictForm"
												name="searchDistrictForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">District Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDistrictName" id="searchDistrictName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="District Name" onkeypress="return validateText('searchDistrictName',30,'District Name')">

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
												<!-- <button type="button" class="btn  btn-primary "
												id="printReportButton" 
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
                                                <th id="th1" class ="inner_md_htext">District Code</th>
                                                <th id="th2" class ="inner_md_htext">District Name</th>
                                                <th id="th3" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfDistrict">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addCityForm" name="addDistrictForm" method="">
                                                <div class="row">
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Sequence No.<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="sequenceNo" name="sequenceNo" value="" placeholder="Sequence Number" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >District Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="districtCode" name="districtCode" placeholder="District Code" onkeypress=" return validateText('districtCode',7,'District Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">District Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="districtName" name="districtName" placeholder="District Name" onkeypress="return validateText('districtName',30,'District Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Population</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="population" name="population" placeholder="Population" onkeypress="return isNumberKey(this, event); return validateText('population',10,'Population')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">State<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="state" name="state" >
                                                                  <option value="">Select</option>
                                                                  <option value="1">Chhattisgarh</option>                                                         
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                  <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">UPSS Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" maxlength="250" id="UPSS" name="UPSS" placeholder="UPSS">
                                                            </div>
                                                        </div>
                                                    </div>
                                                 
                                                 
                                                  <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Longitude<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" maxlength="250" id="longitude" name="longitude" placeholder="Longitude" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Latitude<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" maxlength="250" id="latitude" name="latitude" placeholder="Latitude" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-sm-6">
													<div class="form-group row">
														<div class="col-md-5">
															<label class="col-form-label">Start Date<span class="mandate"><sup>&#9733;</sup></span></label>
														</div>
														<div class="col-md-7">
															<div class="dateHolder">
																<input type="text" id="startDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY">
															</div>
														</div>
													</div>
												</div>
                                                  <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Vendor</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" name="vendorId" id="vendorId">
                                                        <option value="">--Select--</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                                  <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
																											
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
												
														<button type="button" id="btnAddDistrict"
															class="btn  btn-primary " onclick="addDistrict();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDistrict();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDistrictStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDistrictStatus();">Deactivate</button>
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

