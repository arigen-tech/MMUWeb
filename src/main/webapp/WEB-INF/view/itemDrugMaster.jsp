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
			$j('#pvmsNo').attr('readonly', false);
			$j('#nomenclature').attr('readonly', false);
			GetItemList('ALL');
			GetAllStoreGroup('ALL');
			GetAllSection('ALL');
			GetAllItemClass('ALL');			
			GetAllItemType('ALL');
			GetAllUnitAU('ALL');
			GetAllDispensingUnit('ALL');
			GetAllFrequency();
			$("#dispUnitQty").keypress(function (e) {
			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {			        
			               return false;
			    }
			   });
			   /* Do not allow paste */
			   $('#dispUnitQty').bind("paste",function(e) {
			          e.preventDefault();
			      });
			
		});
		
function GetItemList(MODE)
{
	var nomenclature= jQuery("#searchItem").val();
		
	var itemId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "nomenclature":"","drugType":"E"};			
		}
	else
		{
		var data = {"PN":nPageNo,"nomenclature":nomenclature,"drugType":"E"};
		} 
	var url = "getAllItemDetails";
		
	var bClickable = true;
	GetJsonData('tblListOfItem',data,url,bClickable);
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].itemId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].pvmsNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].nomenclature+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].groupName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].storeUnitName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].sectionName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].itemClassName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfItem").html(htmlTable);	
	
	
}
var comboArray = [];
var itmId;
var pvms;
var nomcl;
var itmStatus;
var grpId;
var grpName;
var struId;
var struName;
var secId;
var secName;
var itcId;
var itcName;
var ittId;
var ittName;
var disQtId;
var disQtName;
var disQty;
var roD;
var dangerousDrug;
var edl;
var sastiDawai;
var facilityCode;
var unitAUId;
var dispensingUnitId;
var dosage;
var nod;
var frequency;
var inactiveForEntry;
function executeClickEvent(itemId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(itemId == data.data[j].itemId){
			itmId = data.data[j].itemId;
			pvms = data.data[j].pvmsNo;
			nomcl = data.data[j].nomenclature;
			itmStatus = data.data[j].status;
			grpId = data.data[j].groupId;
			grpName = data.data[j].groupName;
			struId = data.data[j].storeUnitId;
			struName = data.data[j].storeUnitName;
			secId = data.data[j].sectionId;
			secName = data.data[j].sectionName;
			itcId = data.data[j].itemClassId;
			itcName = data.data[j].itemClassName;
			ittId = data.data[j].itemTypeId;
			ittName = data.data[j].itemTypeName;
			disQtId = data.data[j].storeUnitId;
			disQtName = data.data[j].storeUnitName;
			disQty = data.data[j].dispUnitQty;
			roD = data.data[j].rolD;
			dangerousDrug =  data.data[j].dangerousDrug;
			edl =  data.data[j].edl; 
			sastiDawai =  data.data[j].sastiDawai;
			facilityCode =  data.data[j].facilityCode;
			unitAUId =  data.data[j].unitAUId;
			dispensingUnitId =  data.data[j].dispensingUnitId;
			dosage =  data.data[j].dosage;
			nod =  data.data[j].nod;
			frequency =  data.data[j].frequency;
			inactiveForEntry= data.data[j].inactiveForEntry;
		}
	}
	rowClick(itmId,pvms,nomcl,itmStatus,grpId,grpName,struId,struName,secId,secName,
			itcId,itcName,ittId,ittName,disQtId,disQtName,disQty,roD,dangerousDrug,edl,sastiDawai,facilityCode,
			unitAUId,dispensingUnitId,dosage,nod,frequency,inactiveForEntry);
	
		
}

var success;
var error;
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        return false;

    return true;
}    

function addItemDetails(){
	
	if(document.getElementById('pvmsNo').value==""){
		alert("Please Enter the Drug Code");
		return false;
	}
	if(document.getElementById('nomenclature').value==""){
		alert("Please Enter the Drug Name");
		return false;
	}
	if(document.getElementById('selectItemGroup').value==""){
		alert("Please Select Item Group");
		return false;
	}
	if(document.getElementById('selectSection').value==""){
		alert("Please Select Section");
		return false;
	}
	if(document.getElementById('selectItemClass').value==""){
		alert("Please Select Item Class");
		return false;
	}
	if(document.getElementById('selectItemType').value==""){
		alert("Please Select Item Type");
		return false;
	}
	if(document.getElementById('selectUnitAU').value==""){
		alert("Please Select Unit A/U");
		return false;
	}
	if(document.getElementById('selectDispensingUnit').value==""){
		alert("Please Select Dispensing Unit");
		return false;
	}
	
	if(document.getElementById('rolD').value==""){
		alert("Please Enter the Re-order Level-Dispensary");
		return false;
	}
	
	if(document.getElementById('selectFacilityCode').value==""){
		alert("Please Select Facility Code");
		return false;
	}
	$('#btnAddItem').prop("disabled",true);
	var hospitalId =  $j('#hospitalId').val();
	var userId =  $j('#userId').val();
	var dangerousDrug=$('#dangerousDrug').is(':checked') ? $('#dangerousDrug').val() :'N';
	var edl=$('#edl').is(':checked') ? $('#edl').val() :'N';
	var sastiDawai=$('#sastiDawai').is(':checked') ? $('#sastiDawai').val() :'N';
	var facilitycode=$("#selectFacilityCode option:selected").val();
	var inactiveForEntry=$('#inactiveForEntry').is(':checked') ? $('#inactiveForEntry').val() :'N';
	var params = {
			 
			 'pvmsNo':jQuery('#pvmsNo').val(),
			 'nomenclature':jQuery('#nomenclature').val(),
			 'groupId':jQuery('#selectItemGroup').find('option:selected').val(),
			 'sectionId':jQuery('#selectSection').find('option:selected').val(),
			 'itemClassId':jQuery('#selectItemClass').find('option:selected').val(),
			 'itemTypeId':jQuery('#selectItemType').find('option:selected').val(),
			 'storeUnitId':jQuery('#selectUnitAU').find('option:selected').val(),
			 'storeDispUnitId':jQuery('#selectDispensingUnit').find('option:selected').val(),
			 'dispUnitQty':jQuery('#dispUnitQty').val(),
			 'rolD':jQuery('#rolD').val(),
			  'userId': <%= userId%>,
			 'drugType':"E",
			 'dangerousDrug' : dangerousDrug,
			 'edl' : edl,
			 'sastiDawai' : sastiDawai,
			 'facilitycode' : facilitycode,
			 'dosage' : jQuery('#dosage').val(),
			  'nod' : jQuery('#nod').val(),
			  'frequency' : jQuery('#frequency').find('option:selected').val() ,
			  'inactiveForEntry': inactiveForEntry,
	 } 	
	//alert(JSON.stringify(params));
	var url="addItem";
	    SendJsonData(url,params);
}


function updateItemDetails()
{	

	if(document.getElementById('pvmsNo').value=="" || document.getElementById('pvmsNo').value == null ){
		alert("Please Enter the Drug Code");
		return false;
	}
	if(document.getElementById('nomenclature').value=="" || document.getElementById('nomenclature').value == null ){
		alert("Please Enter the Drug Name");
		return false;
	}
	if(document.getElementById('selectItemGroup').value=="" || document.getElementById('selectItemGroup').value == null ){
		alert("Please Select Item Group");
		return false;
	}
	if(document.getElementById('selectSection').value=="" || document.getElementById('selectSection').value == null ){
		alert("Please Select Section");
		return false;
	}
	if(document.getElementById('selectItemClass').value=="" || document.getElementById('selectItemClass').value == null ){
		alert("Please Select Item Class");
		return false;
	}
	if(document.getElementById('selectItemType').value=="" || document.getElementById('selectItemType').value == null ){
		alert("Please Select Item Type");
		return false;
	}
	if(document.getElementById('selectUnitAU').value=="" || document.getElementById('selectUnitAU').value == null ){
		alert("Please Select Unit A/U");
		return false;
	}
	if(document.getElementById('selectDispensingUnit').value=="" || document.getElementById('selectDispensingUnit').value == null ){
		alert("Please Select Dispensing Unit");
		return false;
	}
	
	if(document.getElementById('rolD').value=="" || document.getElementById('rolD').value == null ){
		alert("Please Enter the Re-order Level-Dispensary");
		return false;
	}
		
	if(document.getElementById('selectFacilityCode').value==""){
		alert("Please Select Facility Code");
		return false;
	}
	var edl=$('#edl').is(':checked') ? $('#edl').val() :'N';
	var sastiDawai=$('#sastiDawai').is(':checked') ? $('#sastiDawai').val() :'N';
	var facilitycode=$("#selectFacilityCode").val();
	var hospitalId =  $j('#hospitalId').val();
	var userId =  $j('#userId').val();
	var dangerousDrug=$('#dangerousDrug').is(':checked') ? $('#dangerousDrug').val() :'N';
	var inactiveForEntry=$('#inactiveForEntry').is(':checked') ? $('#inactiveForEntry').val() :'N';
	var params = {
			 'itemId':itmId,
			 'pvmsNo':jQuery('#pvmsNo').val(),
			 'nomenclature':jQuery('#nomenclature').val(),
			 'groupId':jQuery('#selectItemGroup').find('option:selected').val(),
			 'sectionId':jQuery('#selectSection').find('option:selected').val(),
			 'itemClassId':jQuery('#selectItemClass').find('option:selected').val(),
			 'itemTypeId':jQuery('#selectItemType').find('option:selected').val(),
			 'storeUnitAuId':jQuery('#selectUnitAU').find('option:selected').val(),
			 'storeDispUnitId':jQuery('#selectDispensingUnit').find('option:selected').val(),
			 'dispUnitQty':jQuery('#dispUnitQty').val(),
			 'rolD':jQuery('#rolD').val(),
			 'userId':<%= userId%>,
			 'drugType':"E",
			 'dangerousDrug' : dangerousDrug,
			 'edl' : edl,
			 'sastiDawai' : sastiDawai,
			 'facilitycode' : facilityCode,
			 'dosage' : jQuery('#dosage').val(),
			  'nod' : jQuery('#nod').val(),
			  'frequency' : jQuery('#frequency').find('option:selected').val()	,
			  'inactiveForEntry': inactiveForEntry,
			  
	 } 
	//alert(JSON.stringify(params));
	var url="updateItemDetails";
	SendJsonData(url,params);	
	GetItemList();	 		
	$j('#updateBtn').hide();
	$j("#btnActive").hide();
	 $j("#btnInActive").hide();
	$j('#btnAddItem').show();
	//$j('#pvmsNo').attr('readonly', true);
	
	
}
function updateStatus(){
	if(document.getElementById('pvmsNo').value=="" || document.getElementById('pvmsNo').value == null ){
		alert("Please Enter the PVMS or NIV");
		return false;
	}
	var hospitalId =  $j('#hospitalId').val();
	var userId =  $j('#userId').val();
	 var params = {
		 'itemId':itmId,
		 'pvmsNo':jQuery('#pvmsNo').val(),
		 'status':itmStatus,
		 'userId':<%= userId%>
		 
	}  
	 var url= "updateItemStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").hide();
			 $j("#btnInActive").hide();
			 $j('#updateBtn').hide();
			 $j('#btnAddItem').show();
}



function GetAllStoreGroup(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllStoreGroup",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].groupId;
	    		combo += '<option value='+result.data[i].groupId+'>' +result.data[i].groupName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectItemGroup').append(combo);
	    }
	    
	});
}


function GetAllFrequency(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.request.contextPath}/opd/getMasFrequency",
	    data: JSON.stringify({"employeeId": '1'}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.MasFrequencyList.length;i++){
	    		
	    		combo += '<option value='+result.MasFrequencyList[i].frequencyId+'>' +result.MasFrequencyList[i].frequencyName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#frequency').append(combo);
	    }
	    
	});
}

function changeItemGroup(value){
	
	var groupId = jQuery('#selectItemGroup').find('option:selected').val();
	
	if(value == groupId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}

function GetAllSection(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllStoreSectionDetails",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var k=0;k<result.data.length;k++){
	    		comboArray[k] = result.data[k].sectionId;
	    		combo += '<option value='+result.data[k].sectionId+'>' +result.data[k].sectionName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectSection').append(combo);
	    }
	    
	});
}


function GetAllItemClass(){
	
	jQuery('#selectItemClass').html("");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllItemClassDetails",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    async:true,
	    success: function(result){
	    	
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var k=0;k<result.data.length;k++){
	    		
	    		comboArray[k] = result.data[k].itemClassId;
	    		combo += '<option value='+result.data[k].itemClassId+'>' +result.data[k].itemClassName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectItemClass').append(combo);
	    }
	    
	});
}


function GetAllItemType(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllItemType",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var n=0;n<result.data.length;n++){
	    		comboArray[n] = result.data[n].itemTypeId;
	    		combo += '<option value='+result.data[n].itemTypeId+'>' +result.data[n].itemTypeName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectItemType').append(combo);
	    }
	    
	});
}


function GetAllUnitAU(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllItemUnit",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var l=0;l<result.data.length;l++){
	    		comboArray[l] = result.data[l].storeUnitId;
	    		combo += '<option value='+result.data[l].storeUnitId+'>' +result.data[l].storeUnitName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectUnitAU').append(combo);
	    }
	    
	});
}

function changeUnitAU(value){
	
	var storeUnitId = jQuery('#selectUnitAU').find('option:selected').val();
	
	if(value == storeUnitId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}

function GetAllDispensingUnit(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllItemUnit",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var m=0;m<result.data.length;m++){
	    		comboArray[m] = result.data[m].storeUnitId;
	    		combo += '<option value='+result.data[m].storeUnitId+'>' +result.data[m].storeUnitName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectDispensingUnit').append(combo);
	    }
	    
	});
}

function changeDispensingUnit(value){
	
	var storeUnitId = jQuery('#selectDispensingUnit').find('option:selected').val();
	
	if(value == storeUnitId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}


function rowClick(itmId,pvms,nomcl,itmStatus,grpId,grpName,struId,struName,secId,secName,
		itcId,itcName,ittId,ittName,disQtId,disQtName,disQty,roD,dangerousDrug,edl,sastiDawai,facilityCode,
		unitAUId,dispensingUnitId,dosage,nod,frequency,inactiveForEntry){	
		
	document.getElementById("pvmsNo").value = pvms;
	document.getElementById("nomenclature").value = nomcl;	
	jQuery("#selectItemGroup").val(grpId);
	jQuery("#selectSection").val(secId);	
	jQuery("#selectItemClass").val(itcId);
	jQuery("#selectItemType").val(ittId);
	jQuery("#selectUnitAU").val(unitAUId);
	jQuery("#selectDispensingUnit").val(dispensingUnitId);
	jQuery("#dispUnitQty").val(disQty);
	jQuery("#rolD").val(roD);
	
	jQuery("#dosage").val(dosage);
	jQuery("#nod").val(nod);
	jQuery("#frequency").val(frequency);
	
	
if(itmStatus == 'Y' || itmStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddItem").hide();
	}
	if(itmStatus == 'N' || itmStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
		$j("#btnAddItem").hide();
	}
	if(dangerousDrug == 'Y' || dangerousDrug == 'y'){
		jQuery("#dangerousDrug").prop('checked', true);
	
	}
	else{
		jQuery("#dangerousDrug").prop('checked', false);
	}
	
		
	if(edl == 'Y' || edl == 'y'){
		jQuery("#edl").prop('checked', true);
	
	}
	else{
		jQuery("#edl").prop('checked', false);
	}
	
	if(sastiDawai == 'Y' || sastiDawai == 'y'){
		jQuery("#sastiDawai").prop('checked', true);
	
	}
	else{
		jQuery("#sastiDawai").prop('checked', false);
	}
	
	if(inactiveForEntry == 'Y' || inactiveForEntry == 'y'){
		jQuery("#inactiveForEntry").prop('checked', true);
	
	}
	else{
		jQuery("#inactiveForEntry").prop('checked', false);
	}
	jQuery("#selectFacilityCode").val(facilityCode);
	
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetItemList('FILTER');
	
}

function Reset(){
	
	document.getElementById('searchItem').value = "";
	
	
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");	
	showAll();
}


function ResetForm()
{	
	$j('#pvmsNo').val('');
	$j('#nomenclature').val('');
	$j('#searchItem').val('');
	$j('#selectItemGroup').val('');
	$j('#selectSection').val('');
	$j('#selectItemClass').val('');
	$j('#selectItemType').val('');
	$j('#selectUnitAU').val('');
	$j('#selectDispensingUnit').val('');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddItem').show();
	$j('#dispUnitQty').val('');
	$j('#rolD').val('');
	$j('#rolS').val('');
	$j("#dangerousDrug").prop('checked', false);
	$j("#edl").prop('checked', false);
	$j("#sastiDawai").prop('checked', false);
	$j('#selectFacilityCode').val('');
	
	$j('#dosage').val('');
	$j('#nod').val('');
	$j('#frequency').val('');
	$j("#inactiveForEntry").prop('checked', false);
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetItemList('ALL');
	
}

function validateTextField(id,length){	
	if($j("#"+id).val().length >= length){
		 alert("Length of "+id+" should be less than 30");
		 
		 var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
}


function search()
{
	if(document.getElementById('searchItem').value == ""){
		alert("Please Enter Drug Name");
		return false;
	}
	nPageNo=1;
	GetItemList('Filter');
}

 function generateReport()
{
	 var url="${pageContext.request.contextPath}/report/generateItemDrugMasterReport";
	 openPdfModel(url);
	/* document.searchDrugItemForm.action="${pageContext.request.contextPath}/report/generateItemDrugMasterReport";
	document.searchDrugItemForm.method="POST";
	document.searchDrugItemForm.submit();  */
	
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
                <div class="internal_Htext">Item Drug Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                        
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDrugItemForm"
												name="searchDrugItemForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Drug Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchItem" id="searchItem"
															class="form-control" 
															placeholder="Drug Name" onkeypress="return validateText('searchItem',30,'Nomenclature');">

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
                                                <th id="th2" class ="inner_md_htext">Drug Code</th>
                                                <th id="th3" class ="inner_md_htext">Drug Name</th>
                                                <th id="th4" class ="inner_md_htext">Item Group</th>
                                                <th id="th4" class ="inner_md_htext">Unit</th>
                                                <th id="th4" class ="inner_md_htext">Section</th>
                                                <th id="th4" class ="inner_md_htext">Item Class</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                      
                                     <tbody id="tblListOfItem">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addItemForm" name="addItemForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="EDL CODE" class=" col-form-label inner_md_htext" >Drug Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="pvmsNo" name="pvmsNo" placeholder="Drug Code" onkeypress=" return validateText('pvmsNo',30,'PVMS/NIV');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <div class="form-group row">
                                                        <div class="col-sm-3">
                                                            <label for="service" class="col-form-label inner_md_htext">Drug Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <input type="text" class="form-control" id="nomenclature" name="nomenclature" placeholder="Drug Name" onkeypress="return validateTextField('nomenclature',300,'Nomenclature')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Item Group<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectItemGroup" onchange="changeItemGroup(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-6 col-form-label inner_md_htext">Section<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-6">
                                                                <select class="form-control" id="selectSection" onchange="">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Item Class<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectItemClass" onchange="">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Item Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectItemType" >
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-6 col-form-label inner_md_htext">Unit A/U<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-6">
                                                                <select class="form-control" id="selectUnitAU" onchange="changeUnitAU(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Dispensing Unit<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectDispensingUnit" onchange="changeDispensingUnit(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Dispensing Qty </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="dispUnitQty" name="dispUnitQty" placeholder="Dispensing Qty" maxlength="10">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="service" class="col-form-label inner_md_htext">Re-order Level-Dispensary<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="rolD" name="rolD" placeholder="Re-order Level-Dispensary" 
                                                                onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" maxlength="10">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="Dosage" class="col-form-label inner_md_htext">Dosage</label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="dosage" name="dosage" placeholder="Dosage" 
                                                                onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" maxlength="180">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="No of Days" class="col-form-label inner_md_htext">No of Days</label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="nod" name="nod" placeholder="No of Days" 
                                                                onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" maxlength="5">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="Frequency" class="col-sm-5 col-form-label inner_md_htext">Frequency</label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="frequency" >
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>                                                    
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Facility Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectFacilityCode" onchange="">
                                                                 <option value="">Select</option>
                                                                 <option value="P">Primary</option>
                                                                 <option value="U">Universal</option>   
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">   
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="dangerousDrug" id="dangerousDrug" value="y"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="Dangerous Drug">Dangerous Drug</label>
														</div>
                                                    </div>
                                                    <div class="col-md-4">   
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="edl" id="edl" value="y"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="EDL">EDL</label>
														</div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">   
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="sastiDawai" id="sastiDawai" value="y"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="Sasti Dawai">Sasti Dawai</label>
														</div>
                                                    </div>
                                                    
                                                     <div class="col-md-4">   
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="inactiveForEntry" id="inactiveForEntry" value="y"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="Inactive for entry">Inactive for entry</label>
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
												
														<button type="button" id="btnAddItem"
															class="btn  btn-primary " onclick="addItemDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateItemDetails();">Update</button>
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
