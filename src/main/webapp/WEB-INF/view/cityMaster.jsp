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
		$j('#cityCode').attr('readonly', false);		
		GetAllCity('ALL');	
		GetDistrictList();
			});
			
	function GetAllCity(MODE){
		 
		var cityName=$("#searchCityName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "cityName":""};			
			}else{
			var data = {"PN":nPageNo, "cityName":cityName};
			} 
		var url = "getAllCity";		
		var bClickable = true;
		GetJsonData('tblListOfCity',data,url,bClickable);	 
	}

	function GetDistrictList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "getAllDistrict",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "<option value=\"\">Select</option>" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#district').append(combo);
			    	
			    }
			    
			});
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].cityId+"' >";
				htmlTable = htmlTable +"<td style='display:none'>"+dataList[i].sequenceNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].districtName+"</td>";
				if(dataList[i].mmuOperational == 'Y' || dataList[i].mmuOperational == 'y')
				{
					var mmuOperational='Yes'
				}
			else
				{
					var mmuOperational='No'
				} 
				htmlTable = htmlTable +"<td style='width: 150px;'>"+mmuOperational+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfCity").html(htmlTable); 	
		
	}
    var cityId;
	var cityid='';
	var sequenceNo;
	var cityCode;
	var cityName;
	var Status;
	var districtId;
	var mmuOperational;
	var indentCity;
	function executeClickEvent(cityId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(cityId == data.data[j].cityId){
				cityId = data.data[j].cityId;
				sequenceNo=data.data[j].sequenceNo;
				cityCode = data.data[j].cityCode;			
				districtId = data.data[j].districtId;
				cityName = data.data[j].cityName;
				mmuOperational = data.data[j].mmuOperational;
				Status = data.data[j].status;
				indentCity=data.data[j].indentCity	;		
				
			}
		}
		rowClick(cityId,sequenceNo,cityCode,cityName,districtId,mmuOperational,Status,indentCity);
	}
	
	function rowClick(cityId,sequenceNo,cityCode,cityName,districtId,mmuOperational,Status,indentCity){	
		cityid=cityId;
		document.getElementById("sequenceNo").value = sequenceNo;
		document.getElementById("cityCode").value = cityCode;
		document.getElementById("cityName").value = cityName;
		document.getElementById("district").value = districtId;
		if(mmuOperational == 'Y' || mmuOperational == 'y'){	
		document.getElementById("operational").value = mmuOperational.toUpperCase();	
		}
		if(mmuOperational == 'N' || mmuOperational == 'n'){	
			document.getElementById("operational").value = mmuOperational.toUpperCase();
		}
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddCity').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddCity').hide();
		}
		if(indentCity == 'y'){	
			 
			$('#indentCity').prop('checked', true);
		}else{
			$('#indentCity').prop('checked', false);
		}
		
		$j('#cityCode').attr('readonly', true);
		
	}


		function addCity(){
			
			if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value == ""){
				alert("Please Enter Sequence No.");
				return false;
			}
			if(document.getElementById('cityCode').value == null || document.getElementById('cityCode').value == ""){
				alert("Please Enter City Code");
				return false;
			}
			if(document.getElementById('cityName').value == null || document.getElementById('cityName').value ==""){
				alert("Please Enter City Name");
				return false;
			}
			
			if(document.getElementById('district').value == null || document.getElementById('district').value ==""){
				alert("Please Select District");
				return false;
			}
			
			if(document.getElementById('operational').value == null || document.getElementById('operational').value ==""){
				alert("Please Select MMU Operational");
				return false;
			}
			
			
			$j('#btnAddCity').prop("disabled",true);
			var params = {		
					 'sequenceNo':jQuery('#sequenceNo').val(),
					 'cityCode':jQuery('#cityCode').val(),
					 'cityName':jQuery('#cityName').val(),
					 'mmuOperational':jQuery('#operational').val(),
					 'districtId':jQuery('#district').val(),
					 'userId': <%= userId%>,
					 'indentCity': getIndentCityValue()
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addCity";
			    SendJsonData(url,params);
			
			    
		}
		function getIndentCityValue(){
			var indentCity='n';
			 if(document.getElementById("indentCity").checked == true){
				 indentCity='y'
			 }
			 else{
				 indentCity='n'
			 }
			 return indentCity;
		}
		function updateCity(){
			if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value == ""){
				alert("Please Enter Sequence No.");
				return false;
			}
			if(document.getElementById('cityCode').value == null || document.getElementById('cityCode').value == ""){
				alert("Please Enter City Code");
				return false;
			}
			if(document.getElementById('cityName').value == null || document.getElementById('cityName').value ==""){
				alert("Please Enter City Name");
				return false;
			}
			
			if(document.getElementById('district').value == null || document.getElementById('district').value ==""){
				alert("Please Select District");
				return false;
			}
			
			if(document.getElementById('operational').value == null || document.getElementById('operational').value ==""){
				alert("Please Select MMU Operational");
				return false;
			}
			
			var params = {		
					  'cityId': cityid,
					  'sequenceNo':jQuery('#sequenceNo').val(),
					 'cityCode':jQuery('#cityCode').val(),
					 'cityName':jQuery('#cityName').val(),
					 'mmuOperational':jQuery('#operational').val(),
					 'districtId':jQuery('#district').val(),
					 'userId': <%= userId%>,
					 'indentCity': getIndentCityValue()
			 }
			//alert(JSON.stringify(params));
				    var url = "updateCity";
				    SendJsonData(url,params);
					$j('#btnAddCity').attr("disabled", false);
					$j('#cityCode').attr('readonly', true);
					ResetForm();
		}
		
		function updateCityStatus(){
			
			
			var params = {
					
					'cityId':cityid,			 
					 'status':Status,
					 'indentCity': getIndentCityValue()
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateCityStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchCityName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddCity').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#cityCode').attr('readonly', false);
			$j('#district').val('');
			$j('#operational').val('');
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#cityCode').val('');
			$j('#cityName').val('');
			$j('#searchCityName').val('');
			$j('#district').val('');
			$j('#operational').val('');
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllCity('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddCity').show();
			$j('#cityCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllCity('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchCityName').value == ""){
		  		alert("Please Enter City Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllCity('FILTER');
		 }
		 
		 function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateBankMasterReport";
			 openPdfModel(url)
		 	
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
                <div class="internal_Htext">City Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchBankForm"
												name="searchBankForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">City Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchCityName" id="searchCityName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="City Name" onkeypress="return validateText('searchCityName',100,'City Name')">

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
                                                <th id="th1" class ="inner_md_htext">City Name</th>
                                                <th id="th2" class ="inner_md_htext">District</th>
                                                <th id="th3" class ="inner_md_htext">MMU Operational</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfCity">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addCityForm" name="addCityForm" method="">
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
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >City Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="cityCode" name="cityCode" placeholder="City Code" onkeypress=" return validateText('cityCode',7,'City Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">City Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="cityName" name="cityName" placeholder="City Name" onkeypress="return validateText('cityName',100,'City Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">District<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="district" name="district" >
                                                                                                                           
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Operational<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" name="operational" id="operational" >
                                                                  <option value="">Select</option> 
                                                                  <option value="Y">Yes</option> 
                                                                  <option value="N">No</option>                                                         
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                 
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Indent City<!-- <span class="mandate"><sup>&#9733;</sup></span> --></label>
                                                            </div>
                                                            <div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" type="checkbox" id="indentCity" name="indentCity"  value="">
															<span class="cus-checkbtn"></span>
															<!-- <div class="form-check form-check-inline cusRadio">
																	<label class="col-md-12 col-form-label">Mark as MLC Case</label> 
															</div> -->
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
												
														<button type="button" id="btnAddCity"
															class="btn  btn-primary " onclick="addCity();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateCity();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateCityStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateCityStatus();">Deactivate</button>
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

