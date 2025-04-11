<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
    
<%@include file="..//view/leftMenu.jsp" %>
<%@include file="..//view/commonJavaScript.jsp" %>


    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 

</head>


	
	<%
	Calendar calendar=Calendar.getInstance();
	String month1=String.valueOf((calendar.get(Calendar.MONTH))+1);
	String date1=String.valueOf(calendar.get(Calendar.DATE));
	int year1=calendar.get(calendar.YEAR);
	
	System.out.print("" + year1);
	if(month1.length()<2){
		month1="0"+month1;
	}
	if(date1.length()<2){
		date1="0"+date1;
	}

	String serverdate = date1+"/"+month1+"/"+year1 ;
	
	//long departmentId =2051;
	String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
	String departmentName="DISPENSARY";
	  /* if (session.getAttribute("departmentId") != null) {
	   departmentId = Long.parseLong(session.getAttribute("departmentId").toString());
	   departmentName =session.getAttribute("departmentName").toString();
	  }  */
	  
	  String mmuId = "0";
		if (session.getAttribute("mmuId") != null) {
			mmuId = session.getAttribute("mmuId") + "";
		}
		
	  String cityId = "0";
		if (session.getAttribute("cityIdUsers") != null) {
			cityId = session.getAttribute("cityIdUsers").toString();
			cityId = cityId.replace(",","");
		}
		
	  String districtId = "0";
		if (session.getAttribute("distIdUsers") != null) {
			districtId = session.getAttribute("distIdUsers").toString();
			districtId = districtId.replace(",","");
		}
		
		String userName = "";
		if (session.getAttribute("userName") != null) {
			userName = session.getAttribute("userName") + "";
		}
		
		String userId = "";
		if (session.getAttribute("userId") != null) {
			userId = session.getAttribute("userId") + "";
		}
		
		String levelOfUser = "0";
		if (session.getAttribute("levelOfUser") != null) {
			levelOfUser = session.getAttribute("levelOfUser").toString();
			levelOfUser = levelOfUser.replace(",","");
		}
		
%>

<script type="text/javascript">

$j(document).ready(function() {
	if(<%=departmentId%>!=0){
		$j("#openingBalanceEntryM :input").attr("disabled", false);
		 $j('input[type="radio"]').click(function(){
			 var inputValue = $j(this).attr("value");
			 if(inputValue=="1"){
				$('#uploadDiv').show(); 
				$('#mannualDiv').hide(); 
			 }else if(inputValue=="2"){
				 $('#uploadDiv').hide(); 
				 $('#mannualDiv').show();  
			 }
		});
		 var lUsr='<%=levelOfUser%>';
		 if(lUsr=="C")
		 {
			 $('#uploadDiv').show();  
		 }	 
		 
		 getVendorNameList('');
		 getVendorTypeList();
		
		var respData = ${data};
		var group = respData.groupList;
		var groupValues="";
		for (i = 0; i < group.length; i++) {
			
			groupId = group[i].storeGroupId;
			groupName = group[i].storeGroupName;
			
			groupValues += '<option value='+ groupId+'>'+ groupName + '</option>';
			
		}
		 $j('#itemGroupId').append(groupValues);
		

		var itemTypeValue = "";
		var itemType=respData.itemTypeList;
		for (i = 0; i < itemType.length; i++) {
			itemTypeId = itemType[i].itemTypeId;
			itemTypeName = itemType[i].itemTypeName;
			
			itemTypeValue += '<option value='+ itemTypeId+'>'+ itemTypeName + '</option>';
		}
		 $j('#itemTypeId').append(itemTypeValue);
		 
		 
		
		var itemClassValue = "";
		var itemClass=respData.itemClassList;
		for (i = 0; i < itemClass.length; i++) {
			
			itemClassId = itemClass[i].itemClassId;
			itemClassName = itemClass[i].itemClassName ;
			
			itemClassValue += '<option value='+ itemClassId+'>'+ itemClassName + '</option>';
		}
		
		 $j('#itemClassId').append(itemClassValue);
		
		
		var sectionValue = "";
		var section=respData.sectionList;
		for (i = 0; i < section.length; i++) {
			sectionId = section[i].sectionId;
			sectionName = section[i].sectionName ;
			
			sectionValue += '<option value='+ sectionId+'>'+ sectionName + '</option>';
		}
		
		$j('#itemSectionId').append(sectionValue);
	}else{
		alert("Select the department");
		 $j("#openingBalanceEntryM :input").attr("disabled", true);
		return false;
	}
});


function addRow(){
	
	var tbl = document.getElementById('tblOpeningBalance');
		var lastRow = tbl.rows.length;
		var iteration = lastRow;
		var row = tbl.insertRow(lastRow);
		var hdb = document.getElementById('counter');
		var prevCnt = hdb.value;
		var iteration = parseInt(hdb.value) + 1;
		hdb.value = iteration;
		
		row.id=iteration;
		row.name=iteration;

		var spanDiv = document.createElement('div');
		spanDiv.className = "form-check";
		var cell0 = row.insertCell(0);
		var e0 = document.createElement('span');
		e0.textContent = (iteration);
		cell0.appendChild(e0);
		spanDiv.appendChild(e0);
		cell0.appendChild(spanDiv);
		
		

		var newdivpsvn = document.createElement('div');
		newdivpsvn.className = "autocomplete forTableResp width150";

		var newdivPvmsSub = document.createElement('div');
		newdivPvmsSub.id='divPvms'+ (iteration);
		newdivPvmsSub.className = "autocomplete-itemsNew";
		
		var cell1 = row.insertCell(1);
		var e1 = document.createElement('input');
		e1.type = 'text';
		e1.className='form-control border-input';
		e1.name = 'pvmsNumber';
		e1.id = 'pvmsNumberId' + (iteration);
		e1.size = '10';
		e1.setAttribute('validate','Drug Code or Drug Name,string,yes');
		e1.autocomplete = 'off';
		e1.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_pvms')
		};
		
		cell1.appendChild(e1);
		newdivpsvn.appendChild(e1);
		newdivpsvn.appendChild(newdivPvmsSub);
		cell1.appendChild(newdivpsvn);
		
		

		var newdivnomen = document.createElement('div');
		newdivnomen.className = "autocomplete forTableResp width250";
		
		var newdivnomenSub = document.createElement('div');
		newdivnomenSub.id='divNomen'+ (iteration);
		newdivnomenSub.className = "autocomplete-itemsNew";
		
		
		var cell2 = row.insertCell(2);
		var e2 = document.createElement('input');
		e2.type = 'text';
		e2.className='form-control border-input';
		e2.name = 'nomenclature';
		e2.id = 'nomenclturId' + (iteration);
		e2.setAttribute('validate','Drug Code or Drug Name,string,yes');
		e2.tabIndex = "1";
		e2.size = '30';
		e2.autocomplete = 'off';
		e2.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_nomen')
		};

		cell2.appendChild(e2);
		newdivnomen.appendChild(e2);
		newdivnomen.appendChild(newdivnomenSub);
		cell2.appendChild(newdivnomen);

		

		var cell3 = row.insertCell(3);
		var e3 = document.createElement('input');
		e3.type = 'text';
		e3.readOnly=true;
		e3.className='form-control border-input width70'
		e3.name = 'unit';
		e3.id = 'unitId' + (iteration);
		e3.tabIndex = "1";
		e3.size = '30';
		e3.autocomplete = 'off';
		cell3.appendChild(e3);

		
		var cell4 = row.insertCell(4);
		var e4 = document.createElement('input');
		e4.type = 'text';
		e4.className='form-control border-input width90'
		e4.name = 'batchNumber';
		e4.id = 'batchNumberId' + (iteration);
		e4.setAttribute('validate','Batch No.,string,yes');
		e4.setAttribute('maxlength','30');
		e4.tabIndex = "1";
		e4.size = '30';
		e4.autocomplete = 'off';
		e4.onblur = function() {
			checkDuplicatePVMS(this,'nomenclatureGrid');
		};
		cell4.appendChild(e4);
		
		
		
		var newdivdom = document.createElement('div');
		newdivdom.className = "dateHolder width110";
		var cell5 = row.insertCell(5);
		var e5 = document.createElement('input');
		e5.type = 'text';
		e5.readOnly=true;
		e5.className='noFuture_dateStore form-control';
		e5.name = 'domDate';
		e5.id = 'domDate' + (iteration);
		e5.setAttribute('validate','Date of manufacturing,string,yes');
		e5.tabIndex = "1";
		e5.size = '30';
		e5.autocomplete = 'off';
		e5.setAttribute('placeholder','DD/MM/YYYY');
		cell5.appendChild(e5);
		newdivdom.appendChild(e5)
		cell5.appendChild(newdivdom);
		
		
		
		var newdivdoe = document.createElement('div');
		newdivdoe.className = "dateHolder width110";
		var cell6 = row.insertCell(6);
		var e6 = document.createElement('input');
		e6.type = 'text';
		e6.className='comapre_date form-control';
		e6.readOnly=true;
		e6.name = 'doeDate';
		e6.id = 'doeDate' + (iteration);
		e6.setAttribute('validate','Date of expiry,date,yes');
		e6.tabIndex = "1";
		e6.size = '30';
		e6.autocomplete = 'off';
		e6.onblur = function() {
			checkDate(iteration);
		};
		e6.setAttribute('placeholder','DD/MM/YYYY');
		cell6.appendChild(e6);
		newdivdoe.appendChild(e6)
		cell6.appendChild(newdivdoe);
		
		
		var cell7 = row.insertCell(7);
		var e7 = document.createElement('input');
		e7.type = 'texts';
		e7.className='form-control border-input width60'
		e7.name = 'quantity';
		e7.id = 'quantityId' + (iteration);
		e7.setAttribute('validate','Quantity,number,yes');
		e7.tabIndex = "1";
		e7.size = '30';
		e7.autocomplete = 'off';
		e7.onkeypress = function(){
			if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;
		}
		e7.onkeydown = function(){
			if(event.key==='.'){event.preventDefault();}
		}
		e7.oninput = function(){
			event.target.value = event.target.value.replace(/[^0-9]*/g,'');
		}	
		e7.onblur = function() {
			calculateAmount(iteration);
		};
		cell7.appendChild(e7);
		
		
		var cell8 = row.insertCell(8);
		var e8 = document.createElement('input');
		e8.type = 'text';
		e8.className='form-control border-input width60'
		e8.name = 'unitRate';
		e8.id = 'unitRateId' + (iteration);
		e8.setAttribute('validate','Unit Rate,string,yes');
		e8.tabIndex = "1";
		e8.size = '30';
		e8.onblur = function() {
			calculateAmount(iteration);
		};
		e8.autocomplete = 'off';
		cell8.appendChild(e8);
		
		
		var cell9 = row.insertCell(9);
		var e9 = document.createElement('input');
		e9.type = 'text';
		e9.readOnly=true;
		e9.className='form-control border-input width90'
		e9.name = 'amount';
		e9.id = 'amountId' + (iteration);
		e9.setAttribute('validate','Amount,number,no');
		e9.tabIndex = "1";
		e9.size = '30';
		e9.autocomplete = 'off';
		cell9.appendChild(e9);
		
		var cell10 = row.insertCell(10);
		var e10 = document.createElement('select');
		e10.className='form-control vendorTypeClass'
		e10.name = 'vendorTypeId';
		e10.id = 'vendorTypeId' + (iteration);
		e10.options[0] = new Option('Select', '');
		e10.tabIndex = "1";
		e10.setAttribute('validate','Vendor Type,String,yes');
		e10.onclick=function(){setVendorType(this.id)};
		e10.onchange=function(){getVendorNameListbasedonId(this.id)};
		
		cell10.appendChild(e10);
		
		var cell11 = row.insertCell(11);
		var e11 = document.createElement('select');
		e11.className='form-control vendorClass'
		e11.name = 'vendorNameId';
		e11.id = 'vendorNameId' + (iteration);
		e11.setAttribute('validate','Vendor Type,String,yes');
		e11.options[0] = new Option('Select', '');
		e11.tabIndex = "1";
		//e11.onclick=function(){setVendorName(this.id)};
		cell11.appendChild(e11);
		
		
		var cell12 = row.insertCell(12);
		var e12 = document.createElement('button');
		e12.type = 'button';
		e12.className='btn btn-primary noMinWidth';
		e12.setAttribute('button-type','add');
		e12.setAttribute('onclick','addRow()');
		cell12.appendChild(e12);
		
		
		var cell13 = row.insertCell(13);
		var e13 = document.createElement('button');
		e13.type = 'button';
		e13.className='btn btn-danger noMinWidth';
		e13.setAttribute('button-type','delete');
		e13.setAttribute('onclick',"removeGridRow(this)");
		cell13.appendChild(e13);
		
		
		var cell14 = row.insertCell(14);
		cell14.style.display = 'none';
		var e14 = document.createElement('input');
		e14.type = 'hidden';
		e14.name = 'item';
		e14.id = 'itemId' + (iteration);
		cell14.appendChild(e14);
		

	}
	
	function checkInp(item)
	{
	
	   var x=item.value;
	   if (isNaN(x)) 
	  {
	    alert("Please enter valid numbers");
	    return false;
	  }
	}

	function removeGridRow(val) {
		if ($('#tblOpeningBalance tr[id!="th"]').length > 1) {
			$(val).closest('tr').remove();
		}else{
			alert("Can not delete all rows");
		}
	} 


	function fillSelectedValue(fieldId,value){
		
		/* var index1 = value.lastIndexOf("[");
		var index2 = value.lastIndexOf("]");
		index1++;
		var id = value.substring(index1, index2);
		$('#'+fieldId).val(id); */
		
	
			/* var valRowId = new Array();
			$("#tblOpeningBalance tr[id !='th']").each(function(j)
			{				
				valRowId[j] = $j(this).attr("id");
			});
		var cnt = valRowId.length;
		getStoreItemList(cnt); */
		
	}
	
	
/* 	function fillItemAndValues(item, psvn_nomen) {
		var count = item.substring(12); // this code commonly use for pvmsNumberId/nomenclturId input 
		var index1 = psvn_nomen.lastIndexOf("[");
		var index2 = psvn_nomen.lastIndexOf("]");
		index1++;
		var itemId = psvn_nomen.substring(index1, index2);
		
		for (var i = 0; i < itemDataList.length; i++) {
			if (psvn_nomen == itemDataList[i].pvmsNumber) {
				$('#itemId' + count).val(itemDataList[i].itemId);
				$('#pvmsNumberId' + count).val(itemDataList[i].pvmsNo);
				$('#nomenclturId' + count).val(itemDataList[i].nomenclature);
				$('#unitId' + count).val(itemDataList[i].unitName);
				$('#itemUnitId' + count).val(itemDataList[i].unitId);
				
			} else if (itemId == itemDataList[i].itemId) {
				$('#itemId' + count).val(itemDataList[i].itemId);
				$('#pvmsNumberId' + count).val(itemDataList[i].pvmsNo);
				$('#nomenclturId' + count).val(itemDataList[i].nomenclature);
				$('#unitId' + count).val(itemDataList[i].unitName);
				$('#itemUnitId' + count).val(itemDataList[i].unitId);
			}
		}

	} */

	
function submitOpeningBalanceData(){
		
		$("#btnSubmit").attr("disabled", true);
		/* var flag = false;
		$('#nomenclatureGrid tr').each(function(i, el) {
					var $tds = $(this).find('td')
					var vendorTypeVal = $($tds).closest('tr').find("td:eq(10)").find('select').find(":option:selected").val();
					console.log("vendorTypeVal"+vendorTypeVal);
					if(vendorTypeVal == ''){
						flag = true;
						alert("Please select vendor type");
						return;
					}
					
		});
		if(flag){
			return;
		} */
	if($('#uploadFile').val()
			        && $('#uploadFile').val().indexOf('.pdf') == -1
			        && $('#uploadFile').val().indexOf('.docx') == -1
			        && $('#uploadFile').val().indexOf('.xls') == -1
			        && $('#uploadFile').val().indexOf('.xlsx') == -1){
			        alert('Invalid file format Only PDF, Excel and Word file should be uploaded');
			        return false;
	}
	var value=validateFields("openingBalanceEntryM");
	if(value==true){
		/* document.openingBalanceEntryM.action="submitOpeningBalanceData";
		document.openingBalanceEntryM.method="POST";
		document.openingBalanceEntryM.submit(); */
		 var pathname = window.location.pathname;
	    var accessGroup = "MMUWeb";

	    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/store/submitOpeningBalanceData";
	    var headMainDataVal = $('#openingBalanceEntryM')[0];
		var formData = new FormData(headMainDataVal);
		formData.append('uploadFilePath', "uploads");
		formData.append('uploadRealPath', 1);
	   	//formData.append('headMainData',JSON.stringify(dataJSON));
		 $.ajax({
		    	type: 'POST',
				    url : url,
		        enctype: 'multipart/form-data',
		        data: formData,
		        processData: false,
		        contentType: false,
		        cache: false,
		        dataType : "json",
		        timeout : 100000,
		        success: function(msg) {
		        	console.log(msg)
		            if (msg.status == 1)
		            {
		            	 /* var Id= $('#fundAllocationHdId').val()
		                 localStorage.typeOfVal='fundView';
		                 localStorage.fundAllocationHdId=Id;
		                 window.location.href ="fundBillSubmit?fundAllocationHdId="+Id+""; */
		                 alert("Opening balance entry submitted successfully")
		                
		            } 
		            else if(msg.status == 0)
		            {
		             $("#btnSubmit").attr("disabled", false);
		             $("#saveBtn").attr("disabled", false);	
		             alert(msg.msg)	
		            }	
		            else
		            {
		            	$("#btnSubmit").attr("disabled", false);
		                $("#saveBtn").attr("disabled", false);	
		                alert("Please enter the valid data")
		            }
		        },
		        error: function(jqXHR, exception) {
		        	$("#btnSubmit").attr("disabled", false);
		            $("#saveBtn").attr("disabled", false);	
		            var msg = '';
		            if (jqXHR.status === 0) {
		                msg = 'Not connect.\n Verify Network.';
		            } else if (jqXHR.status == 404) {
		                msg = 'Requested page not found. [404]';
		            } else if (jqXHR.status == 500) {
		                msg = 'Internal Server Error [500].';
		            } else if (exception === 'parsererror') {
		                msg = 'Requested JSON parse failed.';
		            } else if (exception === 'timeout') {
		                msg = 'Time out error.';
		            } else if (exception === 'abort') {
		                msg = 'Ajax request aborted.';
		            } else {
		                msg = 'Uncaught Error.\n' + jqXHR.responseText;
		            }
		            alert("Response msg is "+msg);
		        }
		    });
	}else{
		alert(value.split('\n')[0]);
	}
}
	

	
function exportItemFile(){
	document.uploadForm.action="${pageContext.request.contextPath}/store/downloadPvmsItemExcelFormat";
	document.uploadForm.method="POST";
	document.uploadForm.submit(); 
}

function importPvmsDataFromFileUpload(){
	var departmentId = $('#departmentIdUpload').val();
	if(departmentId!=0){
		if (document.getElementById('uploadFile').value == ""){
			alert('Please Select the Excel file to Import...!');
			 return ;
			 }
		
		var fname = document.getElementById('uploadFile').value;
		var st = fname.length;
		st = st-3;
		if (fname.substring(st)!="xls")
		{
		alert('Only Excel(.xls) file is Allowed.');
		return;
		}
		
		
			 // Get form
			   var form = $('#uploadForm')[0];
			 // Create an FormData object 
			   var data = new FormData(form);
			 // disabled the submit button
			    $("#importBtn").prop("disabled", true);
			    $("#uploadFile").prop("disabled", true);
			    $("#loadingDiv").show();
			    $.ajax({
			     type: 'POST',
			     enctype: 'multipart/form-data',
			     url: 'importPvmsdataFromFileUpload',
			     data: data,
			     processData: false,
			     contentType: false,
			     cache: false,
			     timeout: 600000,
			     success: function(resp) {
			    	var respData =  JSON.parse(resp);
			    	$("#loadingDiv").hide();
			      	$("#importBtn").prop("disabled", false);
			      	$("#uploadFile").prop("disabled", false);
			      	$("#uploadFile").val("");
			      	$('#fileRemark').val("");
			      	$('#inputSpanUploadFile').text("");
			      	//document.getElementById("msg").innerHTML=respData.data.msg;
			      	alert(respData.data.msg+'S');
			      	document.addEventListener('click',function(e){
					    if(e.target && e.target.id== 'closeBtn'){
	   	   				 	window.location.reload();
					     }
				 });	
			            },
			     error: function (e) {
			        alert(e.responseText);
			        $("#loadingDiv").hide();
			        $("#importBtn").prop("disabled", false);
			        $("#uploadFile").prop("disabled", false);
			            }
			        });
	}else{
		alert("Please select department");
	}
	
}

function compareDate(){
	var valRowId = new Array();
	$("#tblOpeningBalance tr[id !='th']").each(function(j)
	{				
		valRowId[j] = $j(this).attr("id");
	});
	
	var cnt = valRowId.length;
	for(var i=1;i<=cnt;i++){
		var fromDate = $('#domDate'+i).val();
		 var toDate = $('#doeDate'+i).val();
		 
		 if(process(toDate) < process(fromDate)){
				alert("Expiry Date should not be earlier than Manufacturing Date");
				$('#domDate'+i).val("");
				return;
		 }
	}
}
var vendorTypeGlobal='';
function getVendorTypeList(){
	 $.ajax({
			type : "POST",
			contentType : "application/json",
			url : "getMasSupplierTypeList",
			data :JSON.stringify({}),
			dataType : 'json',
			timeout : 100000,
			success : function(res) {
				if(res.status == true){					
					var list = res.list;
					vendorTypeGlobal = list;
					var typeDropDown = '';
					for(i=0;i<list.length;i++){
						typeDropDown += '<option value='+list[i].id+'>'+list[i].name+'</option>';
					}
					
					if(typeDropDown != ''){
						$('.vendorTypeClass').append(typeDropDown);
					}
				}
			},
			error : function(jqXHR, exception) {
				alert("Error occured while contacting the server");
				$(item).attr("disabled", false);	
			}
		});
}
var vendorNameGlobal='';

function getVendorNameListbasedonId(id)
{	
    var val = $("#" + id).val();         
	getVendorNameList(id,val)
}


function getVendorNameList(id,val){		
	
	var vendorNameid = id.replace("Type", "Name");
	console.log(vendorNameid)

	//$('#'+vendorNameid).find('option').not(':first').remove();
	$('select[id="' + vendorNameid + '"]').html("<option value='0'>select</option>");
	
	var levelOfUsers=$('#levelOfUser').val();
	var mmuId=$('#mmuId').val();
	var cityId=$('#cityId').val();
	var params = {
			"levelOfUsers":levelOfUsers,
			"mmuId":mmuId,
			"cityId":cityId,
			"PN":"0",
			"id":val
	}

	
	 $.ajax({
			type : "POST",
			contentType : "application/json",
			url : "getAllUpssManufactureMapping",
			data :JSON.stringify(params),
			dataType : 'json',
			timeout : 100000,
			success : function(res) {
				console.log(res.status)
				if(res.status == true){
					//$('#'+vendorNameid).find('option').not(':first').remove();
					//$('#' + vendorNameid).html("<option value='0'>select</option>");
					var list = res.data;
					vendorNameGlobal = res.data;
					var typeDropDown = '';
					for(i=0;i<list.length;i++){
						typeDropDown += '<option value='+list[i].supplierId+'>'+list[i].supplierName+'</option>';
					}
					
					if(typeDropDown != ''){
						$('#'+vendorNameid).append(typeDropDown);
					}	
				}
			},
			error : function(jqXHR, exception) {
				alert("Error occured while contacting the server");
				$(item).attr("disabled", false);	
			}
		});
}

function setVendorType(itemId){
	var typeDropDown = '';
	var leng = $('#'+itemId+' option').length
	if(leng >1){
		return;
	}
	$('#'+itemId+' option:not(:first)').remove();
	for(i=0;i<vendorTypeGlobal.length;i++){
		typeDropDown += '<option value='+vendorTypeGlobal[i].id+'>'+vendorTypeGlobal[i].name+'</option>';
	}
	
	if(typeDropDown != ''){
		$('#'+itemId).append(typeDropDown);
	}
}

function setVendorName(itemId){
	var typeDropDown = '';
	var leng = $('#'+itemId+' option').length
	if(leng >1){
		return;
	}
	$('#'+itemId+' option:not(:first)').remove();
	//$('#'+itemId).empty();
	for(i=0;i<vendorNameGlobal.length;i++){
		typeDropDown += '<option value='+vendorNameGlobal[i].supplierId+'>'+vendorNameGlobal[i].supplierName+'</option>';
	}

	if(typeDropDown != ''){
		$('#'+itemId).append(typeDropDown);
	}
	
}

/* function setOption(id,val){
	$('#'+id).val(val);
} */
</script>

<body>

    <!-- Begin page -->
    <div id="wrapper">

        
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                	<div class="internal_Htext">Opening Balance Entry</div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                	<div class="row" style='display:none;'>
                                		<div class="col-md-2 m-l-5">
											
											<div class="form-check form-check-inline cusRadio">
												<input class="form-check-input" type="radio"  name="openingBalanceCheck" id="radiobtn1" value="1"> 
												<span class="cus-radiobtn"></span> 
												<label class="form-check-label" for="radiobtn1">Upload File</label>
											</div>
											
										</div>
										
										<div class="col-md-2" >
											
											<div class="form-check form-check-inline cusRadio">
												<input class="form-check-input" type="radio" checked name="openingBalanceCheck" id="radiobtn2" value="2"> 
												<span class="cus-radiobtn"></span> 
												<label class="form-check-label" for="radiobtn1">Enter Manually</label>
											</div>
										</div>
                                	
                                	</div>
                                	<form name="openingBalanceEntryM" id="openingBalanceEntryM" method="post" enctype='multipart/form-data'
											action="#" autocomplete="on">
                                	<div class="opdMain_detail_area m-t-10" id="uploadDiv" style="display:none;">
                                		<div class="row">
		                                	<div class="col-12">
		                               			<h4 class="service_htext">Upload File</h4>
		                               		</div>
	                               		</div>
	                               		
	                               		
	                               		<div class="row m-b-5 m-t-10">
	                               			<div class="col-md-5">
	                                			<div class="row">
	                                				<div class="col-md-4">
	                                					<label class="col-form-label" >Select Invoice</label>
	                                				</div>
	                                				<div class="col-md-7">
	                                					<div class="fileUploadDiv">
		                                					<input type="file" name="uploadFile" id="uploadFile" class="file inputUpload" validate="file,string,yes"/>
		                                					<label class="inputUploadlabel">Choose File</label>
															<span id='inputUploadFileName' class="inputUploadFileName">No File Chosen</span>
	                                					</div>
	                                				</div>
	                                				
	                                		
	                                				<div class="col-md-4">
	                                					<label class="col-form-label" >invoiceNo</label>
	                                				</div>
	                                				<div class="col-md-7">
														<input type="text" class="form-control" id="invoiceNo" name="invoiceNo" value="" />
													</div>
	                                	
	                                	<div class="col-md-4">
												<input type="hidden" class="form-control" id="userIdUpload"
											  					 name="userIdUpload"  value="<%=session.getAttribute("userId")%>">
										<input type="hidden" class="form-control" id="mmuIdd"
											   name="mmuIdd"  value="<%= mmuId %>">
											   
										<input type="hidden" class="form-control" id="cityId"
											   name="cityId"  value="<%= cityId %>">
											   
										<input type="hidden" class="form-control" id="districtId"
											   name="districtId"  value="<%= districtId %>">
											 
										<input type="hidden" class="form-control" id="levelOfUser"
											   name="levelOfUser"  value="<%= levelOfUser %>">  
										<input type="hidden" class="form-control" id="departmentIdUpload"
											   name="departmentIdUpload"  value="<%=departmentId%>">
							         	</div>
	                                			</div>
	                                		</div>
	                                		<div class="col-md-4">
	                                			
												<div id="loadingDiv">
													<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
												</div>
	                                			
	                                		</div>
	                                		<p align="center" id="msg" style="color:green; font-weight: bold;" ></p>
	                               		</div>
	                               		
	                               		                               		
                               		</div>
                               		
                                	
                                	<div class="opdMain_detail_area m-t-10"  id="mannualDiv" >
                                		<div class="row" style="display:none;">
		                                	<div class="col-12">
		                               			<h4 class="service_htext">Enter Manually</h4>
		                               		</div>
	                               		</div>
	                               		
	                               		<div class="row">
	                               			<div class="col-md-12">
												<h6 class="font-weight-bold text-theme text-underline">Entry Details</h6>
											</div>
									
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Balance Entry Date</label>
													</div>
													<div class="col-md-7">
														<input readonly type="text" class="form-control" id="BEDateId" name="BEDate" value=<%=serverdate %> />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Entered By</label>
													</div>
													<div class="col-md-7">
														<input type="text"  readonly class="form-control"  id="enterby" name="enterby" value="<%=session.getAttribute("userName")%>"/>
													</div>
												</div>
											</div>
											<input type="hidden" class="form-control"  id="enterbyId" value="<%=session.getAttribute("userId")%>">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Department</label>
													</div>
													<div class="col-md-7">
														<input readonly type="text" class="form-control" id="departmentName" name="departmentName" value="<%=departmentName %>" validate="Department,string,yes"/>
														<input  type="hidden" class="form-control" id="departmentId" name="department" value="<%=departmentId%>"/>
													</div>
												</div>
											</div>
										</div>
										
	                                	
	                                	<div class="table-responsive">
		                                	<table class="table table-stripped table-hover table-bordered table-compressed" id="tblOpeningBalance">
		                                		<thead>
		                                			<tr id="th">
		                                				<th>S.No.</th>
		                                				<th>Drug Code</th>
		                                				<th>Drug Name</th>
		                                				<th>Unit</th>
		                                				<th>Batch No/ Serial No</th>
		                                				<th>DOM</th>
		                                				<th>DOE</th>
		                                				<th>Qty</th>
		                                				<th>Unit Rate</th>
		                                				<th>Amount</th>
		                                				<th>Medicine Source</th>
		                                				<th>Manufacturer</th>
		                                				<th>Add</th>
		                                				<th>Delete</th>
		                                			</tr>
		                                		</thead>
		                                		<tbody id="nomenclatureGrid">
		                                		<%int inc=1; %>
		                                			<tr id="<%=inc%>">
		                                				<td>
		                                					<div class="form-check">
															  <%-- <input class="form-check-input position-static" type="checkbox" id="checkboxId<%=inc %>" aria-label="..."> --%>
															 <%=inc%>
															</div>
		                                				</td>
		                                				<td>
		                                					<div class="autocomplete forTableResp width150">
																<input type="text" autocomplete="never" class="form-control border-input" name="pvmsNumber" id="pvmsNumberId<%=inc %>"  validate="Drug Code or Drug Name,string,yes" onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_pvms')"/>
																<div id="divPvms1" class="autocomplete-itemsNew"></div>
															</div>
		                                				</td>
		                                				<td>
		                                					<div class="autocomplete forTableResp width250">
																<input type="text" autocomplete="never"  class="form-control border-input" name="nomenclature" id="nomenclturId<%=inc %>" validate="Drug Code or Drug Name,string,yes" onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_nomen')"/>
																<div id="divNomen1" class="autocomplete-itemsNew"></div>
															</div>
		                                				</td>
		                                				<td>
															<input type="text" readonly class="form-control border-input width70" name="unit" id="unitId<%=inc %>" />
															<input type="hidden" class="form-control border-input width70" name="itemUnit" id="itemUnitId<%=inc %>" />
		                                				</td>
		                                				<td>
		                                					<input type="text" autocomplete="never" class="form-control border-input width90" name="batchNumber" id="batchNumberId<%=inc %>"  onblur="checkDuplicatePVMS(this,'nomenclatureGrid')" validate="Batch No.,string,yes" maxlength="30"/>
		                                				</td>
		                                				<td>
		                                					<div class="dateHolder width110">
															<input readonly type="text" class="noFuture_dateStore form-control"
																name="domDate" id="domDate<%=inc %>" placeholder="DD/MM/YYYY" value="" maxlength="10" validate="Date of manufacturing,date,yes"/>
															</div>
		                  			   					</td>
		                   							<td>
		                                					<div class="dateHolder width110">
															<input readonly type="text" class="comapre_date  form-control"
																name="doeDate" id="doeDate<%=inc %>" placeholder="DD/MM/YYYY" value="" maxlength="10" validate="Date of expiry,date,yes"/>
													</div>
		                                				</td>
		                                				<td>
		                                					<input type="text" autocomplete="never" class="form-control border-input  width60" name="quantity" id="quantityId<%=inc %>" onkeypress="return isNumberKey(event)" onblur="calculateAmount(<%=inc %>)" validate="Quantity,number,yes"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control border-input width60" name="unitRate" id="unitRateId<%=inc %>"  validate="Unit Rate,string,yes" onblur="calculateAmount(<%=inc %>)"/>
		                                				</td>
		                                				<td>
		                                					<input readonly autocomplete="never" type="text" class="form-control border-input width90" name="amount" id="amountId<%=inc %>" validate="Amount,number,no"/>
		                                				</td>
		                                				<td>
		                                					<div class="autocomplete forTableResp width150">
		                                						<select class="form-control vendorTypeClass" id="vendorTypeId" name="vendorTypeId" validate="Vendor Type,string,Yes" onchange="getVendorNameList(this.id,this.value)"><option value="">Select</option></select>
		                                					</div>
		                                					
		                                				</td>
		                                				<td>
		                                					<div class="autocomplete forTableResp width150">
		                                						<select class="form-control vendorClass" id="vendorNameId" name="vendorNameId" validate="Vendor Name,string,Yes"><option value="">Select</option></select>
		                                					</div>
		                                					
		                                				</td>
		                                				<td>
		                                					<button type="button" class="btn btn-primary noMinWidth" id="btnAdd"  button-type="add" onclick="addRow()" ></button>
		                                				</td>
		                                				<td>
		                                					<button type="button" class="btn btn-danger noMinWidth" id="btnDelete" button-type="delete" onclick="removeGridRow(this)" ></button>
		                                				</td>
		                                				<td style="display: none;">
		                                					<input type="hidden" value="" tabindex="1"  name="item" id="itemId<%=inc %>"  />
		                                				</td>
														
		                                			</tr>
		                                		</tbody>
		                                	</table>
	                                	</div>
	                                <div class="col-md-4">
										<input type="hidden" name="count" id="counter" value="<%=inc%>" />
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
										<input type="hidden" class="form-control" id="mmuId"
											   name="mmuId"  value="<%=session.getAttribute("mmuId")%>">
										<input type="hidden" class="form-control" id="cityId"
											   name="cityId"  value="<%= cityId %>">
											   
										<input type="hidden" class="form-control" id="districtId"
											   name="districtId"  value="<%= districtId %>">	   
							         </div>
	                                	
	                                	
	                                	<div class="row">
		                                	<div class="col-12 m-t-10 text-right">
		                               			<input type="button" class="btn btn-primary" id="btnSubmit" value="Submit" onclick="submitOpeningBalanceData()"  />
		                               			<button type="reset" name="Reset" id="reset"  class="btn btn-danger" accesskey="r" onclick="resetData()">Reset</button>
		                               			
		                               		</div>
	                               		</div>
                                	
                                	</div>
                                	</form>
                                	
                                </div>
                            </div>
                        </div>
                    </div>
           
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
<script>

 $(function(){
	$(document).on('click','.calDate',function(){
		$j(this).datepicker({ showOn: "button",
			buttonImage: "../resources/images/calendar.gif",		
			buttonImageOnly: true,
			buttonText: 'Select Date',
			yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false});
	});
}) 
 
 function resetData(){
	 $("#btnSubmit").attr("disabled", false);
	/*  var resetRowCount=1;
	 getStoreItemList(resetRowCount); */
 }

</script>
</body>

</html>