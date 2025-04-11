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
		$j('#mmuCode').attr('readonly', false);		
		GetAllMMU('ALL');         
		//GetCityList();
		GetVendorList();
		GetMMUTypeList();
		GetDistrictList();
			
			});
			
	function GetAllMMU(MODE){
		 
		//var cityName=document.getElementById('citySearch').value	
		var mmuSearchName=document.getElementById('mmuSearch').value
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "mmuSearch":""};			
			}else{
			var data = {"PN":nPageNo, "mmuSearch":mmuSearchName};
			} 
		var url = "getAllMMU";		
		var bClickable = true;
		GetJsonData('tblListOfMMU',data,url,bClickable);	 
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
		    	//var combo = "<option value="0">Select</option>" ;
		    	var combo = '<option value="0"><strong>Select</strong></option>';
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
		var chasisNoVal="";
		
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
					
			 if(dataList[i].chassisNo!=null && dataList[i].chassisNo!=undefined && dataList[i].chassisNo!=""){
				 chasisNoVal =dataList[i].chassisNo;
			 }
			 else{
				 chasisNoVal="";
			 }
				htmlTable = htmlTable+"<tr id='"+dataList[i].mmuId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuName+"</td>";
				/* htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuCity+"</td>"; */
				htmlTable = htmlTable +"<td style='width: 150px;'>"+chasisNoVal+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfMMU").html(htmlTable); 	
		
	}

	var mmuId;
	var regNo;
	var mmuName;
	var cityId;
	var mmuCode;
	var vendorId;
	var operationalDate;
	var mmuTypeId;
	var Status;
	var mmuid='';
	var officeId=0;
	var pollNo;
	var chassisNo;
	var districtIdV=0;
	function executeClickEvent(mmuId,data)
	{
		for(j=0;j<data.data.length;j++){
			if(mmuId == data.data[j].mmuId){
				mmuId= data.data[j].mmuId;
				regNo= data.data[j].regNo;			
				mmuName = data.data[j].mmuName;			
				cityId = data.data[j].cityId;
				mmuCode = data.data[j].mmuCode;
				vendorId = data.data[j].mmuVendorId;
				operationalDate = data.data[j].operationalDate;
				mmuTypeId = data.data[j].mmuTypeId;
				Status = data.data[j].status;
				
				if(data.data[j].officeId!=null)
					officeId = data.data[j].officeId;
				else{
					officeId=0;
				}
	           if(data.data[j]!=null && data.data[j].pollNo)
				pollNo = data.data[j].pollNo;
	           else
	        	   pollNo="";
	         if(data.data[j]!=null &&  data.data[j].chassisNo!=null)	   
				chassisNo = data.data[j].chassisNo;
	         else
	        	 chassisNo ="";
	         if(data.data[j]!=null &&  data.data[j].districtId!=null)
					districtIdV=data.data[j].districtId;
				else{
					districtIdV="0";
					}
			}
			
		}
		rowClick(mmuId,regNo,mmuName,mmuCode,vendorId,operationalDate,mmuTypeId,Status,officeId,pollNo,chassisNo,districtIdV);
	}
	
	function rowClick(mmuId,regNo,mmuName,mmuCode,vendorId,operationalDate,mmuTypeId,Status,officeId,pollNo,chassisNo,districtIdV){
		document.getElementById("regNo").value = regNo;
		//$j('#regNo').attr('readonly', true);
		document.getElementById("mmuName").value = mmuName;
		//document.getElementById("city").value = cityId;
		document.getElementById("mmuCode").value = mmuCode;
		document.getElementById("vendorName").value = vendorId;
		document.getElementById("operationalDate").value = operationalDate;
		document.getElementById("mmuType").value = mmuTypeId;
		if(officeId!=null && officeId!="")
		//if(officeId)
			document.getElementById("officeId").value = officeId;
		else
			document.getElementById("officeId").value ="";
		if(pollNo!=null &&pollNo!="" )
			document.getElementById("pollNo").value = pollNo;
		else
			document.getElementById("pollNo").value ="";
		if(chassisNo!=null && chassisNo!="")
			document.getElementById("chassisNo").value = chassisNo;
		else
			document.getElementById("chassisNo").value="";
		
		mmuid=mmuId;
		
		if(districtIdV!=null && districtIdV!="")
		   document.getElementById("district").value = districtIdV;	
		else
			document.getElementById("district").value ="0";
		
			
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddMMU').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddMMU').hide();
		}

		$j('#mmuCode').attr('readonly', true);
		
	}


		function addMMU(){
			
			if(document.getElementById('regNo').value == null || document.getElementById('regNo').value == ""){
				alert("Please Enter Reg. No");
				return false;
			}
			if(document.getElementById('mmuName').value == null || document.getElementById('mmuName').value ==""){
				alert("Please Enter MMU Name");
				return false;
			}
			/* if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
				alert("Please Select City");
				return false;
			} */

			if(document.getElementById('vendorName').value == null || document.getElementById('vendorName').value ==""){
				alert("Please Select Vendor Name");
				return false;
			}

			if(document.getElementById('mmuType').value == null || document.getElementById('mmuType').value ==""){
				alert("Please Select MMUType");
				return false;
			}
			$j('#btnAddMMU').prop("disabled",true);
			
			var params = {		
					
					 'regNo':jQuery('#regNo').val(),
					 'mmuName':jQuery('#mmuName').val(),
					 'cityId':"",//$j('#city option:selected').val(),
					 'mmuCode':$j('#mmuCode').val(),
					 'mmuVendorId':$j('#vendorName option:selected').val(),
					 'oprationalDate':jQuery('#operationalDate').val(),
					 'userId': <%= userId%>,
					 'mmuTypeId':jQuery('#mmuType').val(),
					 'officeId':jQuery('#officeId').val(),
					 'pollNo':jQuery('#pollNo').val(),
					 'chassisNo':jQuery('#chassisNo').val(),
					 'districtId':jQuery('#district').val()
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addMMU";
			    SendJsonData(url,params);
			    Reset();
						    
		}
		
		function updateMMU(){	
			if(document.getElementById('regNo').value == null || document.getElementById('regNo').value == ""){
				alert("Please Enter Reg. No");
				return false;
			}
			if(document.getElementById('mmuName').value == null || document.getElementById('mmuName').value ==""){
				alert("Please Enter MMU Name");
				return false;
			}
			/* if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
				alert("Please Select City");
				return false;
			} */

			if(document.getElementById('vendorName').value == null || document.getElementById('vendorName').value ==""){
				alert("Please Select Vendor Name");
				return false;
			}

			if(document.getElementById('mmuType').value == null || document.getElementById('mmuType').value ==""){
				alert("Please Select MMUType");
				return false;
			}
			$j('#btnAddMMU').prop("disabled",true);
			
			var params = {		
					 'mmuId':mmuid, 
					 'regNo':jQuery('#regNo').val(),
					 'mmuName':jQuery('#mmuName').val(),
					 'cityId':"",//$j('#city option:selected').val(),
					 'mmuCode':$j('#mmuCode').val(),
					 'mmuVendorId':$j('#vendorName option:selected').val(),
					 'oprationalDate':$j('#operationalDate').val(),
					 'userId': <%= userId%>,
					 'status' :Status,
					 'mmuTypeId':jQuery('#mmuType').val(),
					 'officeId':jQuery('#officeId').val(),
                     'pollNo':jQuery('#pollNo').val(),
                     'chassisNo':jQuery('#chassisNo').val(),
                     'districtId':jQuery('#district').val()
			 }
			  // alert(JSON.stringify(params));
				    var url = "updateMMU";
				    SendJsonData(url,params);
					$j('#btnAddMMU').attr("disabled", false);
					$j('#mmuCode').attr('readonly', true);
					Reset();
		}
		
		function updateMMUStatus(){
			
			var params = {
					
					'mmuId':mmuid,			 
					 'status':Status
					 
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateMMUStatus";
			        SendJsonData(url,params);
			        Reset();
			        //showAll();
		     
		}
		
		function Reset(){
			
			//document.getElementById('citySearch').value = "";
			document.getElementById('mmuSearch').value = "";
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddMMU').show();
			document.getElementById("messageId").innerHTML = "";
			$j("#messageId").css("color", "black");
			$j('#regNo').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#regNo').val('');
			$j('#mmuName').val('');
			//$j('#city').val('');
			$j('#mmuSearch').val('');
			
			$j('#mmuCode').val('');
			$j('#vendorName').val('');
			$j('#operationalDate').val('');
			$j('#mmuType').val('');
			$j('#officeId').val('');
            $j('#pollNo').val('');
            $j('#chassisNo').val('');
			
		}
		
		function showAll()
		{
			
			ResetForm();
			nPageNo = 1;	
			GetAllMMU('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddMMU').show();
			$j('#mmuCode').attr('readonly', false);
			$j('#regNo').attr('readonly', false);
			$j('#district').val('0'); 
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllMMU('FILTER');
			
		} 
		
		 function search()
		 {
		 	/* if(document.getElementById('citySearch').value == ""){
		  		alert("Please Select City Name");
		  		return false;
		  	} */
			 if(document.getElementById('mmuSearch').value == ""){
			  		alert("Please Enter MMU Name");
			  		return false;
			  	}
		 	nPageNo=1;
		 	GetAllMMU('FILTER');
		 }
		 
		 function generateReport()
		 {
			var url="${pageContext.request.contextPath}/report/generateDiseaseReport";
			 openPdfModel(url);
		 	/* document.searchDiseaseForm.action="${pageContext.request.contextPath}/report/generateDiseaseReport";
		 	document.searchDiseaseForm.method="POST";
		 	document.searchDiseaseForm.submit(); */ 
		 	
		 }


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
				    	
				    	jQuery('#citySearch').append(combo);
				    	jQuery('#city').append(combo);
				    	
				    }
				    
				});
			}

		 function GetVendorList(){
				jQuery.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: "getAllMMUVendor",
				    data: JSON.stringify({"PN" : "0"}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].mmuVendorId+'>' +result.data[i].mmuVendorName+ '</option>';
				    		
				    	}
				    	jQuery('#vendorName').append(combo);
				    }
				    
				});
			}

		 function GetMMUTypeList(){
				jQuery.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: "getAllMMUType",
				    data: JSON.stringify({"PN" : "0"}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].mmuTypeId+'>' +result.data[i].mmuTypeName+ '</option>';
				    		
				    	}
				    	jQuery('#mmuType').append(combo);
				    }
				    
				});
			}

		 function validateRegNo(){
            var regNo=$j("#regNo").val();
            
            if(regNo !='' && mmuid==''){
			 jQuery.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: "validateRegNo",
				    data: JSON.stringify({"regNo" : regNo.trim()}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	if(result.status=='1'){
				    		alert(result.msg);
				    		$j("#regNo").val(" ");
					     }
				    	
				    	
				    }
				    
				});
            }

			 }
		 function GenrateMMUCode(sel){
			 var city =sel.options[sel.selectedIndex].text;
			 var mmuName=$j("#mmuName").val();             
              if(mmuName ==''){
                  alert("Please enter MMU name");
                  return false;
                  
			    }
			if( mmuName !='' && city!=''){
				var finalmmuName=mmuName.substring(0,3);
				var mmuCode=city+"-"+finalmmuName;
				$j("#mmuCode").val(mmuCode);
				$j('#mmuCode').attr('readonly', true);
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
                <div class="internal_Htext">MMU Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDiseaseForm"
												name="searchDiseaseForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">MMU Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">
                                                    <!-- <select class="form-control" id="citySearch" name="citySearch">
                                                                
                                                                </select>
														 -->
														 
														<input class="form-control" type="text" name="mmuSearch" id="mmuSearch"/> 
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
                                                <th id="th2" class ="inner_md_htext">MMU Code</th>
                                                <th id="th3" class ="inner_md_htext">MMU Name</th>
                                                <th id="th4" class ="inner_md_htext">Chassis No</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfMMU">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addMMForm" name="addMMForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" > Reg. No <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="regNo" name="regNo" placeholder="REG NO" onblur="validateRegNo()" onkeypress=" return validateText('regNo',20,'Reg No');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="mmuName" name="mmuName" placeholder="MMU Name" onkeypress="return validateText('mmuName',100,'MMU Name')">
                                                            </div>  
														</div>
                                                      </div>                                                       
                                                    <!--  <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">City<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="city" name="city" onchange="GenrateMMUCode(this)">
                                                                                                                           
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div> -->
                                                   <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" readonly="readonly" id="mmuCode" name="mmuCode" placeholder="MMU Code" onkeypress="">
                                                            </div>  
														</div>
                                                      </div> 
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Vendor Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="vendorName" name="vendorName">
                                                                
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Operational Date</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                            <div class="dateHolder">
                                                                 <input type="text"  class="calDate datePickerInput form-control" id="operationalDate" placeholder="DD/MM/YYYY" name="operationalDate" onkeyup="mask(this.value,this,'2,5','/');" onblur="">
                                                             </div>
                                                             </div>  
														</div>
                                                      </div>
                                                      
                                                      <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="mmuType" name="mmuType">
                                                                                                                                                                                            
                                                                </select>
														</div>
														</div>
                                                      </div>

                                                      <div class="col-md-4">
                                                      <div class="form-group row">
                                                          <div class="col-sm-5">
                                                          <label for="collection name" class="col-form-label inner_md_htext">Nishtha Id</label>
                                                          </div>
                                                          <div class="col-sm-7">
                                                              <input type="text"  class="form-control" id="officeId" placeholder="Nishtha Id" name="officeId" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
                                                          </div>
                                                    </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                    <div class="form-group row">
                                                        <div class="col-sm-5">
                                                        <label for="collection name" class="col-form-label inner_md_htext">Poll No</label>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text"  class="form-control" id="pollNo" placeholder="Poll No" name="pollNo">
                                                        </div>
                                                    </div>
                                                  </div>

                                                  <div class="col-md-4">
                                                      <div class="form-group row">
                                                          <div class="col-sm-5">
                                                          <label for="collection name" class="col-form-label inner_md_htext">Chassis No</label>
                                                          </div>
                                                          <div class="col-sm-7">
                                                              <input type="text"  class="form-control" id="chassisNo" placeholder="Chassis No" name="chassisNo">
                                                          </div>
                                                    </div>
                                                    </div>
                                                      <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">District</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="district" name="district" >
                                                                   <!-- <option value="0">Select</option>   -->                                                       
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
								<div class="col-md-12">
											
											<div class="btn-right-all">
												
														<button type="button" id="btnAddMMU"
															class="btn  btn-primary " onclick="addMMU();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateMMU();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateMMUStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateMMUStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
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