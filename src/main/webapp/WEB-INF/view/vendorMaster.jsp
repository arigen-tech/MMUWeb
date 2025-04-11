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
			$j('#supplierCode').attr('readonly', false);
			GetVendorList('ALL');
			GetAllVendorType('ALL');
			GetStateList('ALL');
			//GetBankList();
			//GetAccountTypeList();
			//GetDistrictList('ALL');
		});
		
function GetVendorList(MODE)
{
	var supplierName= jQuery("#searchVendor").attr("checked", true).val().toUpperCase();
		
	var supplierId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "supplierName":""};			
		}
	else
		{
		var data = {"PN":nPageNo,"supplierName":supplierName};
		} 
	var url = "getAllVendorDetails";
		
	var bClickable = true;
	GetJsonData('tblListOfVendor',data,url,bClickable);
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].supplierId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].supplierCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].supplierName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].supplierTypeName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		  // alert('No Record Found');
		}			
	
	$j("#tblListOfVendor").html(htmlTable);	
	
	
}
	var comboArray = [];
	var suppId;
	var suppCode;
	var suppName;
	var suppTypeId;
	var suppTypeName;
	var pinnNo;
	var tinnNo;
	var dlId;
	var add1;
	var add2;
	var stId;
	var stName;
	var ctId;
	var ctName;
	var phNo;
	var mbNo;
	var pinCd;
	var eMail;
	var faxNo;	
	var lcAdd1;
	var lcAdd2;
	var lcPhNo;
	var lcStId;
	var lcStName;
	var lcCtId;
	var lcCtName;
	var lcPinNo;
	var venStatus;
	var panNo;
		
function executeClickEvent(supplierId,data)
{
	
	
	for(j=0;j<data.data.length;j++){
		if(supplierId == data.data[j].supplierId){
			suppId = data.data[j].supplierId;
			suppCode = data.data[j].supplierCode;
			suppName = data.data[j].supplierName;
			venStatus = data.data[j].status;
			suppTypeId = data.data[j].supplierTypeId;
			suppTypeName = data.data[j].supplierTypeName;
			pinnNo = data.data[j].pinNo;
			tinnNo = data.data[j].tinNo;
			dlId = data.data[j].licenceNo;
			add1 = data.data[j].address1;
			add2 = data.data[j].address2;
			stId = data.data[j].stateId;
			stName = data.data[j].stateName;
			ctId = data.data[j].cityId;
			ctName = data.data[j].cityName;
			phNo = data.data[j].phoneno;
			mbNo = data.data[j].mobileno;
			pinCd = data.data[j].pinCode;
			eMail = data.data[j].emailid;
			faxNo = data.data[j].faxnumber;
			//urll = data.data[j].url;
			lcAdd1 = data.data[j].localAddress1;
			lcAdd2 = data.data[j].localAddress2;
			lcPhNo = data.data[j].localPhoneNo;
			lcStId = data.data[j].localstateId;
			lcStName = data.data[j].localStateName;
			lcCtId = data.data[j].localdistrictId;
			lcCtName = data.data[j].localdistrictName;
			lcPinNo = data.data[j].localPinCode;
			panNo =  data.data[j].panNumber;
			
			
		}
	}
	rowClick(suppId,suppCode,suppName,suppTypeId,suppTypeName,pinnNo,tinnNo,dlId,
			add1,add2,stId,stName,ctId,ctName,phNo,mbNo,pinCd,
			eMail,faxNo,lcAdd1,lcAdd2,lcPhNo,lcStId,lcStName,lcCtId,lcCtName,
			lcPinNo,venStatus,panNo);
	
	
	
}

var success;
var error;

function addVendor(){
	
	if(document.getElementById('supplierCode').value==""){
		alert("Please Enter the Vendor Code");
		return false;
	}
	if(document.getElementById('supplierName').value==""){
		alert("Please Enter the Vendor Name");
		return false;
	}
	if(document.getElementById('selectVendorType').value==""){
		alert("Please Select Vendor Type");
		return false;
	}
	
	if(document.getElementById('tinNo').value==""){
		alert("Please Enter the GSTIN Number");
		return false;
	}
	if(document.getElementById('licenceNo').value==""){
		alert("Please Enter the Licence No");
		return false;
	}

	if(document.getElementById('panNo').value==""){
		alert("Please Enter the PAN Number");
		return false;
	}
	
	$('#btnAddVendor').prop("disabled",true);
	var userId =  <%=session.getAttribute("user_id")%>;
	var stateId=jQuery('#selectState').find('option:selected').val() !='' ? jQuery('#selectState').find('option:selected').val() :'';
	var districtId =jQuery('#selectCity').find('option:selected').val() !='' ? jQuery('#selectCity').find('option:selected').val() :'';
	var localstateId = jQuery('#selectLocalState').find('option:selected').val() !='' ? jQuery('#selectLocalState').find('option:selected').val() :'';
	var localdistrictId=jQuery('#selectLocalCity').find('option:selected').val() !='' ? jQuery('#selectLocalCity').find('option:selected').val() :'';
	var params = {
			 
			'supplierCode':jQuery('#supplierCode').val(),
			 'supplierName':jQuery('#supplierName').val(),
			 'supplierTypeId':jQuery('#selectVendorType').find('option:selected').val(),
			 'pinNo':jQuery('#pinNo').val(),
			 'tinNo':jQuery('#tinNo').val(),
			 'licenceNo':jQuery('#licenceNo').val(),
			 'panNo' : jQuery('#panNo').val(),
			 'address1':jQuery('#address1').val(),
			 'address2':jQuery('#address2').val(),
			 'stateId':stateId,
			 'districtId':districtId,
			 'phoneno':jQuery('#phoneno').val(),
			 'mobileno':jQuery('#mobileno').val(),
			 'pinCode':jQuery('#pinCode').val(),
			 'emailid':jQuery('#emailid').val(),
			 'faxnumber':jQuery('#faxnumber').val(),			 
			 'localAddress1':jQuery('#localAddress1').val(),
			 'localAddress2':jQuery('#localAddress2').val(),
			 'localPhoneNo':jQuery('#localPhoneNo').val(),
			 'localPinCode':jQuery('#localPinCode').val(),
			 'localstateId':localstateId,
			 'localdistrictId':localdistrictId,
			 'userId':userId
			 
	 } 	
	//alert(JSON.stringify(params));
	var url="addVendor";
	    SendJsonData(url,params);
	    ResetForm();
}


function updateVendorDetails()
{	

	if(document.getElementById('supplierCode').value==""){
		alert("Please Enter the Vendor Code");
		return false;
	}
	if(document.getElementById('supplierName').value==""){
		alert("Please Enter the Vendor Name");
		return false;
	}
	if(document.getElementById('selectVendorType').value==""){
		alert("Please Select Vendor Type");
		return false;
	}
	
	if(document.getElementById('tinNo').value==""){
		alert("Please Enter the GSTIN Number");
		return false;
	}
	if(document.getElementById('licenceNo').value==""){
		alert("Please Enter the Licence No");
		return false;
	}

	if(document.getElementById('panNo').value==""){
		alert("Please Enter the PAN Number");
		return false;
	}
		
	
	var userId =  <%=session.getAttribute("user_id")%>;
	var stateId=jQuery('#selectState').find('option:selected').val() !='' ? jQuery('#selectState').find('option:selected').val() :'';
	var districtId =jQuery('#selectCity').find('option:selected').val() !='' ? jQuery('#selectCity').find('option:selected').val() :'';
	var localstateId = jQuery('#selectLocalState').find('option:selected').val() !='' ? jQuery('#selectLocalState').find('option:selected').val() :'';
	var localdistrictId=jQuery('#selectLocalCity').find('option:selected').val() !='' ? jQuery('#selectLocalCity').find('option:selected').val() :'';	
	var params = {
			'supplierId' : suppId,
			'supplierCode':jQuery('#supplierCode').val(),
			 'supplierName':jQuery('#supplierName').val(),
			 'supplierTypeId':jQuery('#selectVendorType').find('option:selected').val(),
			 'pinNo':jQuery('#pinNo').val(),
			 'tinNo':jQuery('#tinNo').val(),
			 'licenceNo':jQuery('#licenceNo').val(),
			 'panNo' : jQuery('#panNo').val(),
			 'address1':jQuery('#address1').val(),
			 'address2':jQuery('#address2').val(),
			 'stateId':stateId,
			 'districtId':districtId,
			 'phoneno':jQuery('#phoneno').val(),
			 'mobileno':jQuery('#mobileno').val(),
			 'pinCode':jQuery('#pinCode').val(),
			 'emailid':jQuery('#emailid').val(),
			 'faxnumber':jQuery('#faxnumber').val(),
			 //'url':jQuery('#url').val(),
			 'localAddress1':jQuery('#localAddress1').val(),
			 'localAddress2':jQuery('#localAddress2').val(),
			 'localPhoneNo':jQuery('#localPhoneNo').val(),
			 'localPinCode':jQuery('#localPinCode').val(),
			 'localstateId':localstateId,
			 'localdistrictId':localdistrictId,
			 'userId':userId,
			 'status':venStatus
			 
	 } 
	
	var url="updateVendorDetails";
	SendJsonData(url,params);	
	GetVendorList();	
	$j('#supplierCode').attr('readonly', true);
	ResetForm();	
}

function updateStatus(){
	if(document.getElementById('supplierCode').value=="" || document.getElementById('supplierCode').value == null ){
		alert("Please Enter the Vendor Code");
		return false;
	}
	
	var userId =  <%=session.getAttribute("user_id")%>;
	var url="updateVendorStatus";
	 var params = {
		 'supplierId':suppId,
		 'supplierCode':jQuery('#supplierCode').val(),
		 'status':venStatus,
		 'userId':userId
		 
	}  
	 var url= "updateVendorStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#btnAddVendor').show();
			$j("#updateBtn").hide();
}



function GetAllVendorType(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllSupplierType",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].supplierTypeId;
	    		combo += '<option value='+result.data[i].supplierTypeId+'>' +result.data[i].supplierTypeName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectVendorType').append(combo);
	    }
	    
	});
}

function changeVendorType(value){
	
	var groupId = jQuery('#selectVendorType').find('option:selected').val();
	
	if(value == supplierTypeId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}


 function GetBankList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllBank",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = '<option value="">Select</option>' ;
	    	
	    	for(var j=0;j<result.data.length;j++){
	    		comboArray[j] = result.data[j].bankName;
	    		combo += '<option value='+result.data[j].bankId+'>' +result.data[j].bankName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#bankName').append(combo);
	    	
	    }
	    
	});
  }

 function GetAccountTypeList(){
	 jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllAccountType",
		    data: JSON.stringify({"PN":"0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	//alert("success "+result.data.length);
		    	var combo = '<option value="">Select</option>' ;
		    	
		    	for(var j=0;j<result.data.length;j++){
		    		comboArray[j] = result.data[j].accountTypeName;
		    		combo += '<option value='+result.data[j].accountId+'>' +result.data[j].accountTypeName+ '</option>';
		    		//alert("combo :: "+comboArray[i]);
		    		
		    		
		    	}
		    	jQuery('#accountType').append(combo);
		    	
		    }
		    
		});
	 }
 
function GetStateList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getStateList",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = '<option value="">Select</option>' ;
	    	
	    	for(var j=0;j<result.data.length;j++){
	    		comboArray[j] = result.data[j].stateName;
	    		combo += '<option value='+result.data[j].stateId+'>' +result.data[j].stateName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectState').append(combo);
	    	jQuery('#selectLocalState').append(combo);
	    }
	    
	});
}


 var stateId="";
 var localStateId="";
function districtByStateId(value){		
	
	GetDistrictListById(value);
}

function districtlByStateId(value){	
		
	GetLocalDistrictListById(value);
}
  
function GetDistrictListById(value){
	$j('#selectCity').html('');
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getDistrictListById",
	    data: JSON.stringify({"stateId":value}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",	   
	    success: function(result){
	    	//alert("success "+result.data.length);
	        var combo = '<option value="">Select</option>' ;
	    	for(var l=0;l<result.data.length;l++){
	    		comboArray[l] = result.data[l].districtName;
	    		combo += '<option value='+result.data[l].districtId+'>' +result.data[l].districtName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    	}
	    	
	    	jQuery('#selectCity').append(combo);   
	    	
	    	
	    }
	    
	});
   } 
  
  
   function GetLocalDistrictListById(value){
	$j('#selectLocalCity').html('');
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getDistrictListById",
	    data: JSON.stringify({"stateId":value}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",	   
	    success: function(result){
	    	//alert("success "+result.data.length);
	        var combo = '<option value="">Select</option>' ;
	    	for(var l=0;l<result.data.length;l++){
	    		comboArray[l] = result.data[l].districtName;
	    		combo += '<option value='+result.data[l].districtId+'>' +result.data[l].districtName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    	}
	    	
	    	jQuery('#selectLocalCity').append(combo);   
	    	
	    	
	    }
	    
	});
   } 
  
  
  
function GetDistrictList(stateId,localStateId){	
	$j('#selectCity').html('')
	$j('#selectLocalCity').html('');	
	var combo1 = '<option value="">Select</option>' ;
	 var combo2 = ' <option value="">Select</option>' ;
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getDistrictList",
	    data: JSON.stringify({"stateId":stateId,"localStateId":localStateId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",	   
	    success: function(result){
	    	//alert("success "+result.data.length);
	    
	    	for(var l=0;l<result.data.length;l++){
	    		comboArray[l] = result.data[l].districtName;
	    		combo1 += '<option value='+result.data[l].districtId+'>' +result.data[l].districtName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    	}
	    	jQuery('#selectCity').append(combo1);
	    	jQuery("#selectCity").val(ctId);
           
	    	
	    	for(var k=0;k<result.ldata.length;k++){
	    		comboArray[k] = result.ldata[k].districtName;
	    		combo2 += '<option value='+result.ldata[k].districtId+'>' +result.ldata[k].districtName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}    	
	    	
	    	jQuery('#selectLocalCity').append(combo2);
	    	jQuery("#selectLocalCity").val(lcCtId);
	    }
	    
	});
} 



function rowClick(suppId,suppCode,suppName,suppTypeId,suppTypeName,pinnNo,tinnNo,dlId,
		add1,add2,stId,stName,ctId,ctName,phNo,mbNo,pinCd,
		eMail,faxNo,lcAdd1,lcAdd2,lcPhNo,lcStId,lcStName,lcCtId,lcCtName,
		lcPinNo,venStatus,panNo)
		{	
	GetDistrictList(stId,lcStId);
	$j('#supplierCode').attr('readonly', true);
	document.getElementById("supplierCode").value = suppCode;
	document.getElementById("supplierName").value = suppName;
	jQuery("#selectVendorType").val(suppTypeId);
	document.getElementById("phoneno").value = phNo;
	document.getElementById("pinNo").value = pinnNo;
	document.getElementById("tinNo").value = tinnNo;
	document.getElementById("licenceNo").value = dlId;
	document.getElementById("panNo").value = panNo;
	document.getElementById("address1").value = add1;
	document.getElementById("address2").value = add2;
	jQuery("#selectState").val(stId);
	jQuery("#selectCity").val(ctId);
	document.getElementById("phoneno").value = phNo;
	document.getElementById("mobileno").value = mbNo;
	document.getElementById("pinCode").value = pinCd;
	document.getElementById("emailid").value = eMail;
	document.getElementById("faxnumber").value = faxNo;	
	document.getElementById("localAddress1").value = lcAdd1;
	document.getElementById("localAddress2").value = lcAdd2;
	document.getElementById("localPhoneNo").value = lcPhNo;	
	jQuery("#selectLocalState").val(lcStId);
	jQuery("#selectLocalCity").val(lcCtId);
	document.getElementById("localPinCode").value = lcPinNo;
	
if(venStatus == 'Y' || venStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddVendor").hide();
	}
	
if(venStatus == 'N' || venStatus == 'n'){
	
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
		$j("#btnAddVendor").hide();
		$j("#btnActive").attr("disabled", false);
		$j("#btnInActive").attr("disabled", false);
	 
	 }	

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetVendorList('FILTER');
	
}

function Reset(){
	document.getElementById("addVendorForm").reset();
	document.getElementById("searchVendorForm").reset();
	document.getElementById('searchVendor').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddVendor').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#supplierCode').attr('readonly', false);
	$j('#supplierName').attr('readonly', false);
	showAll();
}


function ResetForm()
{	
	
	$j('#searchVendor').val('');
	$j('#supplierCode').val('');
	$j('#supplierName').val('');
	$j('#selectVendorType').val('');
	$j('#pinNo').val('');
	$j('#tinNo').val('');
	$j('#licenceNo').val('');	
	$j('#panNo').val('');
	$j('#address1').val('');
	$j('#address2').val('');
	$j('#selectState').val('');
	$j('#selectCity').val('');
	$j('#phoneno').val('');
	$j('#mobileno').val('');
	$j('#pinCode').val('');
	$j('#emailid').val('');
	$j('#faxnumber').val('');	
	$j('#localAddress1').val('');
	$j('#localAddress2').val('');
	$j('#localPhoneNo').val('');
	$j('#selectLocalState').val('');
	$j('#selectLocalCity').val('');
	$j('#localPinCode').val('');
	$j('#supplierCode').attr('readonly', false);
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetVendorList('ALL');
	 $j("#btnActive").hide();
	 $j("#btnInActive").hide();
	 $j('#btnAddVendor').show();
	 $j("#updateBtn").hide();
	
}


function enableAddButton(){
	if(document.getElementById("supplierCode").value!=null || !document.getElementById("supplierCode").value==""){
		$j('#btnAddVendor').attr("disabled", false);
	}else if( document.getElementById("supplierName").value!=null || !document.getElementById("supplierName").value==""){
		$j('#btnAddVendor').attr("disabled", false);
	}else{
		$j('#btnAddVendor').attr("disabled", true);
	}
}

function search()
{
	if(document.getElementById('searchVendor').value == ""){
		alert("Please Enter Vendor Name");
		return false;
	}
	nPageNo=1;
	GetVendorList('Filter');
}

 function generateReport()
 {
	 var hospitalId=$j('#hospitalId').val();
	 var url="${pageContext.request.contextPath}/report/generateVendorMasterReport?hospitalId="+hospitalId; 
	 openPdfModel(url);
	/* document.searchVendorForm.action="${pageContext.request.contextPath}/report/generateVendorMasterReport";	
	document.searchVendorForm.method="POST";
	document.searchVendorForm.submit();  */
	
 } 
 
 function validateTextMob(id, length, data){

	 
		if($j("#"+id).val().length >= length){
			 alert("Length of "+data+" should be equal to  "+length);	
			 
			var str=  $j("#"+id).val();
			 str=str.substring(0,length).trim();
			 
			 $j("#"+id).val(str);
			 return false;
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
                <div class="internal_Htext">Vendor Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                        
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchVendorForm"
												name="searchVendorForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Vendor Name <span
														style="color: red">*</span></label>
													<div class="col-4">

														<input type="text" name="searchVendor" id="searchVendor"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Vendor Name" onkeypress="return validateText('searchVendor',30,'Vendor Name');">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary obesityWait-search"
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
                                            	<th id="th2" class ="inner_md_htext">Vendor Code</th>
                                                <th id="th2" class ="inner_md_htext">Vendor Name</th>
                                                <th id="th3" class ="inner_md_htext">Vendor Type</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                      
                                     <tbody id="tblListOfVendor">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addVendorForm" name="addVendorForm" method="">
                                                <div class="row">
                                                	<div class="col-12">
														<h6 class="text-theme font-weight-bold text-underline">Vendor Details </h6>
													</div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Vendor Code" class=" col-form-label inner_md_htext" >Vendor Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="supplierCode" name="supplierCode" placeholder="Vendor Code" onkeypress=" return validateText('supplierCode',20,'Vendor Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Vendor Name" class="col-form-label inner_md_htext">Vendor Name<span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="supplierName" name="supplierName" placeholder="Vendor Name" onkeypress="return validateText('supplierName',150,'Vendor Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="vendor Type" class="col-sm-5 col-form-label inner_md_htext">Vendor Type<span style="color:red">*</span> </label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectVendorType" onchange="">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="PIN Number" class=" col-form-label inner_md_htext" >PIN Number </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="pinNo" name="pinNo" placeholder="PIN Number" onkeypress=" return validateText('pinNo',6,'PIN Number');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="TIN Number" class="col-form-label inner_md_htext">GSTIN Number<span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="tinNo" name="tinNo" placeholder="GSTIN Number" onkeypress="return validateText('tinNo',11,'GSTIN Number');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">Licence Number <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="licenceNo" name="licenceNo" placeholder="Licence Number" onkeypress="return validateText('licenceNo',20,'Licence Number')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">PAN Number <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="panNo" name="panNo" placeholder="PAN Number" onkeypress="return validateText('panNo',10,'PAN Number')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                   <!--  <div class="col-12">
														<h6 class="text-theme font-weight-bold text-underline">Bank Details </h6>
													</div>
													
													<div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">Account Holder <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="beneficiaryName" name="beneficiaryName" placeholder="Account Holder" onkeypress="return validateText('beneficiaryName',100,'Beneficiary Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">Bank Name <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                            <select class="form-control" id="bankName"  onchange=""></select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">Branch Address <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                            <textarea  class="form-control" type="textarea" name="branchAddress" placeholder="Branch Address" id="branchAddress"  MAXLENGTH="200" tabindex="1" rows="1"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">IFSC Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="ifsCode" name="ifsCode" placeholder="IFSC Code" onkeypress="return validateText('ifsCode',11,'IFS Code')">
                                                            </div>
                                                        </div>
                                                    </div>                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">Branch Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="branchcode" name="branchcode" placeholder="Branch Code" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false; return validateText('branchcode',10,'Branch Code')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">MICR Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="micrCode" name="micrCode" placeholder="MICR Code" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false; return validateText('micrCode',9,'MICR Code')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">Account Type <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                            <select class="form-control" id="accountType"  onchange=""></select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="licence Number" class="col-form-label inner_md_htext">Account Number <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="accountNumber" name="accountNumber" placeholder="Account Number" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false; return validateText('accountNumber',20,'Account Number')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="w-100"></div> -->
													<div class="col-12 m-t-10 text-underline">
														<h6 class="text-theme font-weight-bold text-underline">Address Details </h6>
													</div>				
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Address 1 </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <textarea  class="form-control" type="textarea" name="address1" placeholder="Address 1" id="address1"  MAXLENGTH="200" tabindex="1" rows="1"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Address 2 </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <textarea  class="form-control" type="textarea" name="address2" placeholder="Address 2" id="address2"  MAXLENGTH="200" tabindex="1" rows="1"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="state" class="col-sm-5 col-form-label inner_md_htext">State</label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectState"  onchange="districtByStateId(this.value)">
                                                                   
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="city" class="col-sm-5 col-form-label inner_md_htext">City/District</label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectCity" onchange="">
                                                                   
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Phone Number" class="col-form-label inner_md_htext">Phone Number </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="phoneno" name="phoneno" placeholder="Phone Number" onkeypress="return validateText('phoneno',15,'Phone Number')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Mobile Number" class="col-form-label inner_md_htext">Mobile Number  </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="mobileno" name="mobileno" placeholder="Mobile Number" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;return validateTextMob('mobileno',10,'Mobile Number')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="pinCode" class="col-form-label inner_md_htext">PIN Code </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="pinCode" name="pinCode" placeholder="PIN Code" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false; return validateText('pinCode',6,'PIN Code'); ">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="emailID" class="col-form-label inner_md_htext">Email ID </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="emailid" name="emailid" placeholder="Email ID" onkeypress="return validateText('emailid',250,'Email ID')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="FAX Number" class="col-form-label inner_md_htext">FAX Number </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="faxnumber" name="faxnumber" placeholder="FAX Number" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false; return validateText('faxnumber',20,'FAX Number')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    
                                                    <div class="w-100"></div>
													<div class="col-12 m-t-10">
														<h6 class="text-theme font-weight-bold text-underline">Local Address</h6>
													</div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Address 1 </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <textarea  class="form-control" type="textarea" name="localAddress1" placeholder="Address 1" id="localAddress1"  MAXLENGTH="200" tabindex="1" rows="1"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Address 2 </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <textarea  class="form-control" type="textarea" name="localAddress2" placeholder="Address 2" id="localAddress2"  MAXLENGTH="200" tabindex="1" rows="1"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Local Phone Number" class="col-form-label inner_md_htext">Phone Number </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="localPhoneNo" name="localPhoneNo" placeholder="Phone Number" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false; return validateText('localPhoneNo',10,'Phone Number')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="state" class="col-sm-5 col-form-label inner_md_htext">State </label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectLocalState" onchange="districtlByStateId(this.value)">
                                                                  
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="city" class="col-sm-5 col-form-label inner_md_htext">City/District </label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectLocalCity" onchange="">
                                                                
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Local PIN Code" class=" col-form-label inner_md_htext" >PIN Code </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="localPinCode" name="localPinCode" placeholder="PIN Code" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false; return validateText('localPinCode',6,'PIN Code');">
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
												
														<button type="button" id="btnAddVendor"
															class="btn  btn-primary " onclick="addVendor();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateVendorDetails();">Update</button>
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