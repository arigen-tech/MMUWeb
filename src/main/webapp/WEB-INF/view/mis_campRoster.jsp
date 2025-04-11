<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Generate Monthly Camp Plan</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript">
	
<%String mmuId = "1";
			if (session.getAttribute("mmu_id") != null) {
				mmuId = session.getAttribute("mmu_id") + "";
			}
			String userId = "1";
			if (session.getAttribute("user_id") != null) {
				userId = session.getAttribute("user_id") + "";
			}

			String departmentId = "1";
			if (session.getAttribute("department_id") != null) {
				departmentId = session.getAttribute("department_id") + "";
			}

			String campId = "0";
			if (session.getAttribute("camp_id") != null) {
				campId = session.getAttribute("camp_id") + "";
			}%>
	nPageNo = 1;
	var $j = jQuery.noConflict();
	var globalDepartmentList = '';
	var globalZoneList = '';
	var globalWardList = '';
	var globalDepartmentListDropDown='';
	var globalZoneListDropDown='';
	var globalWardListDropDown='';
	$j(document).ready(function() {
		GetDistrictList();
		//getMMUList('');
		//getCityList();
		$('#cityId').focus();
		
	$('#table_div').hide();
		$('#btn_div').hide();

	});
	
	function generateCampReport(item){
		  var district = $('#district').val();
		  //var city = $('#cityId').val();
		  var mmu = $('#mmuId').val();
		  var year = $('#year').val();
		  var month = $('#month').val();
		  
		  if(district == ''){
			  alert("Please Select District");
			  return;
		  }
		 /*  if(city == ''){
			  alert("Please Select City");
			  return;
		  } */
		  if(mmu == ''){
			  alert("Please Select MMU");
			  return;
		  }
		  if(year == ''){
			  alert("Please Select Year");
			  return;
		  }
		  if(month == ''){
			  alert("Please Select Month");
			  return;
		  }
		
		  var printCaseSheet="${pageContext.request.contextPath}/report/printCampMonthlyReport?mmu_id="+mmu+"&yr_id="+year+"&month_id="+month;
			openPdfModel(printCaseSheet);
		
	}
	
	
	 function getWardList(){
			var cityId = $('#cityId').val();
			if(cityId == ''){
				alert("Please select city")
				return;
			}
			var params = {
					"cityId":cityId
			}
			
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getWardList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.list;
						globalWardList = list; 
						var dropDown = '';
						for(i=0;i<list.length;i++){
							dropDown += '<option value='+list[i].wardId+'>'+list[i].wardName+'</option>';
						}
						globalWardListDropDown = dropDown;
						$('.wardClass').append(dropDown);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 	}
	
	 function getZoneList(){
		  var city = $('#cityId').val();
			var params = {
					"cityId":city
			}
			
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getZoneList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.list;
						globalZoneList = list;
						var dropDown = '';
						for(i=0;i<list.length;i++){
							dropDown += '<option value='+list[i].zoneId+'>'+list[i].zoneName+'</option>';
						}
						globalZoneListDropDown = dropDown;
						$('.zoneClass').append(dropDown);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 	}
	
	 function getDepartmentList(){
			var mmuId = $('#mmuId').val();
			var params = {
					"mmuId":mmuId
			}
			
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getMMUDepartment',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.list;
						globalDepartmentList = list;
						var dropDown = '';
						for(i=0;i<list.length;i++){
							//dropDown += '<option value='+list[i].departmentId+'>'+list[i].departmentName+'</option>';
							if(i == 0){
								dropDown += '<option value='+list[i].departmentId+' selected>'+list[i].departmentName+'</option>';
							}else{
								dropDown += '<option value='+list[i].departmentId+'>'+list[i].departmentName+'</option>';
							}
							
						}
						globalDepartmentListDropDown = dropDown;
						$('.departmentClass').append(dropDown);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 	}
	
	function showCampDetail(){
		
		$('#submit_btn').attr("disabled", false);
		 /*  getDepartmentList();
		  getZoneList();
		  getWardList(); */
		  var city = $('#cityId').val();
		  var mmu = $('#mmuId').val();
		  var year = $('#year').val();
		  var month = $('#month').val();
		  
		  if(city == ''){
			  alert("Please Select City");
			  return;
		  }
		  if(mmu == ''){
			  alert("Please Select MMU");
			  return;
		  }
		  if(year == ''){
			  alert("Please Select Year");
			  return;
		  }
		  if(month == ''){
			  alert("Please Select Month");
			  return;
		  }
		  
		  var campParam = {
				  "cityId":city,
				  "mmuId":mmu,
				  "year":year,
				  "month":month
		  }
		  var callingFlag = false;
		  $j("#loadingDiv").show();
		  $j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getCampDetail',
				data : JSON.stringify(campParam),
				dataType : "json",
				cache : false,
				success : function(data) {
					$j("#loadingDiv").hide();
					var zoneData = data.zoneList.list;
					var wardData = data.wardList.list;
					var departmentData = data.departmentList.list ;
					globalDepartmentList = departmentData;
					globalWardList = wardData;
					globalZoneList = zoneData;
					if(data.status == true){
						var list = data.list;
						if(list.length > 0){
							var htmlTable = '';
							var savedCampFlag = true;
							for(i=0;i<list.length;i++){
								 var parts = list[i].campDate.split("/");
									var date1 = new Date(parts[2], parts[1] - 1, parts[0]);
									var parts2 = currentDateInddmmyyyy().split("/");
									var date2 = new Date(parts2[2], parts2[1] - 1, parts2[0]);
									 
									
								if(date1 <= date2){
									htmlTable = htmlTable+"<tr id='"+list[i].id+"'>";			
									htmlTable = htmlTable +"<td cl>"+list[i].campDate+"</td>";
									htmlTable = htmlTable +"<td class='' disaled='disabled'>"+list[i].day+"</td>";
									var weeklyOffDropdown = '';
									if(list[i].campOrOff == 'Camp'){
										weeklyOffDropdown += "<option value = 'camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option>"; 
									}else if(list[i].campOrOff == 'Weekly Off'){
										weeklyOffDropdown += "<option value = 'camp'>Camp</option><option value='Weekly Off' selected>Weekly Off</option><option value='CL'>CL</option>";
									}else if(list[i].campOrOff == 'CL'){
										weeklyOffDropdown += "<option value = 'camp'>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL' selected>CL</option>";
									}
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);' disabled='disabled'><option value=''>Select</option>'"+weeklyOffDropdown+"'</select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].startTime+"' disabled='disabled'></td>";  
									
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].endTime+"' disabled='disabled'></td>";
									var departmentNameHtml = "<option value="+ list[i].departmentId+" selected>"+ list[i].departmentName+"</option>";	
									
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control departmentClass' disabled='disabled'><option value=''>Select</option>"+departmentNameHtml+"</select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'>"+list[i].location+"</textarea></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'>"+list[i].landmark+"</textarea></td>";
									if(list[i].zoneId != ''){
										var zoneNameHtml = "<option value="+ list[i].zoneId+" selected >"+ list[i].zoneName+"</option>";	
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' disabled='disabled'><option value=''>Select</option>"+zoneNameHtml+"</select></td>";
									}else{
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' disabled='disabled'><option value=''>Select</option></select></td>";
									}									
									
									var wardNameHtml = "<option value="+ list[i].wardId+" selected>"+ list[i].wardName+"</option>";	
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control wardClass' disabled='disabled'><option value=''>Select</option>"+wardNameHtml+"</select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].longitude+"' disabled='disabled'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].lattitude+"' disabled='disabled'></td>";
									htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth'><i class='fa fa-plus' disabled='disabled'></i></button></td>";
									
									htmlTable = htmlTable+"</tr>";
								}else{
									callingFlag = false;
									savedCampFlag = false;
									htmlTable = htmlTable+"<tr id='"+list[i].id+"'>";			
									htmlTable = htmlTable +"<td class=''>"+list[i].campDate+"</td>";
									htmlTable = htmlTable +"<td class=''>"+list[i].day+"</td>";
									var weeklyOffDropdown = '';
									if(list[i].campOrOff == 'Camp'){
										weeklyOffDropdown += "<option value = 'Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option>"; 
									}else if(list[i].campOrOff == 'Weekly Off'){
										weeklyOffDropdown += "<option value = 'Camp'>Camp</option><option value='Weekly Off' selected>Weekly Off</option><option value='CL'>CL</option>";
										
									}else if(list[i].campOrOff == 'CL'){
										weeklyOffDropdown += "<option value = 'camp'>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL' selected>CL</option>";
									}
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);'><option value=''>Select</option>'"+weeklyOffDropdown+"'</select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].startTime+"'></td>";  
									
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].endTime+"'></td>";
									var departmentNameHtml = '';
									for(j=0;j<departmentData.length;j++){		
										globalDepartmentListDropDown +=  "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";
										if(list[i].departmentId == departmentData[j].departmentId){
											departmentNameHtml += "<option value="+ departmentData[j].departmentId+" selected>"+ departmentData[j].departmentName+"</option>";
										}else{
											departmentNameHtml += "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";	
										}									
									}
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control departmentClass'><option value=''>Select</option>"+departmentNameHtml+"</select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'>"+list[i].location+"</textarea></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'>"+list[i].landmark+"</textarea></td>";
									var zoneNameHtml = '';
									for(k=0;k<zoneData.length;k++){				
										globalZoneListDropDown += "<option value="+ zoneData[k].zoneId+">"+ zoneData[k].zoneName+"</option>";
										if(list[i].zoneId == zoneData[k].zoneId){
											zoneNameHtml += "<option value="+ zoneData[k].zoneId+" selected>"+ zoneData[k].zoneName+"</option>";
										}else{
											zoneNameHtml += "<option value="+ zoneData[k].zoneId+">"+ zoneData[k].zoneName+"</option>";	
										}
									}
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' onchange='filterWardList(this)'><option value=''>Select</option>"+zoneNameHtml+"</select></td>";
									var wardNameHtml = '';
									for(l=0;l<wardData.length;l++){	
										globalWardListDropDown += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardName+"</option>";
										if(list[i].wardId == wardData[l].wardId){
											wardNameHtml += "<option value="+ wardData[l].wardId+" selected>"+ wardData[l].wardName+"</option>";
										}else{
											wardNameHtml += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardName+"</option>";	
										}
									}
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control wardClass'><option value=''>Select</option>"+wardNameHtml+"</select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].longitude+"'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].lattitude+"'></td>";
									htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)'><i class='fa fa-plus'></i></button></td>";
									
									htmlTable = htmlTable+"</tr>";
								}
								
								
							}
							$('#campDetailTable').html(htmlTable);
							if(savedCampFlag){
								$('#submit_btn').attr("disabled", true);
							}							 
							 $('#table_div').show();
								$('#btn_div').show();
						}else{
							
							var monthDays =  new Date(year, month, 0).getDate();
							var htmlTable = '';
							var campFlag = true;
						   for(i=0;i<monthDays;i++){	
							   var day = '';
							   var monthNo = '';
							   if((i+1) <10){
								   day += '0'+(i+1);
							   }else{
								   day += (i+1);
							   }
							   if(month <10){
								   monthNo = '0'+month;
							   }else{
								   monthNo = month;
							   }
							   
							   
							   
							   var concatenatedDate = day+"/"+monthNo+"/"+year;
							   var dayName = getDayName(monthNo+"/"+day+"/"+year);
							   var parts = concatenatedDate.split("/");
								var date1 = new Date(parts[2], parts[1] - 1, parts[0]);
								var parts2 = currentDateInddmmyyyy().split("/");
								var date2 = new Date(parts2[2], parts2[1] - 1, parts2[0]);
								//var weeklyOffOption = '<'
								
								if(date1 <= date2){
									htmlTable = htmlTable+"<tr id=''>";			
									htmlTable = htmlTable +"<td class=''>"+concatenatedDate+"</td>";
									htmlTable = htmlTable +"<td class=''>"+dayName+"</td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);' disabled='disabled'><option value=''>Select</option><option value='Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='09:00' disabled='disabled'></td>";  
									
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='03:00' disabled='disabled'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control departmentClass' disabled='disabled'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'></textarea></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'></textarea></td>";
									
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' disabled='disabled'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control wardClass' disabled='disabled'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' disabled='disabled'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' disabled='disabled'></td>";
									htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth'><i class='fa fa-minus'></i></button></td>";
									
									htmlTable = htmlTable+"</tr>";
								}else{
									callingFlag = true;
									campFlag = false;
									htmlTable = htmlTable+"<tr id=''>";			
									htmlTable = htmlTable +"<td class=''>"+concatenatedDate+"</td>";
									htmlTable = htmlTable +"<td class=''>"+dayName+"</td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);'><option value=''>Select</option><option value='Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='09:00'></td>";  
									
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='03:00'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control departmentClass'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'></textarea></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'></textarea></td>";
									
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' onchange='filterWardList(this)'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control wardClass'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value=''></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value=''></td>";
									htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)'><i class='fa fa-plus'></i></button></td>";
									
									htmlTable = htmlTable+"</tr>";
								}
					    	  
					      	}
						   $('#campDetailTable').html(htmlTable);
						  /*  $('.zoneClass').append(globalZoneListDropDown);
						   $('.wardClass').append(globalWardListDropDown);
						   $('.departmentClass').append(globalDepartmentListDropDown); */
						   if(campFlag){
							   $('#submit_btn').attr("disabled", true);
						   }
						    /* getDepartmentList();
							getZoneList();
							getWardList(); */
						   //getZoneList();
							 $('#table_div').show();
							$('#btn_div').show();
						}
					}else{
						alert(data.msg);
					}
					
				},
			    complete: function (data) {
			    	//setDropDownValues();
			    	if(callingFlag){
			    		getDepartmentList();
						 getZoneList();
						 getWardList();
			    	}
			    	 
			     }, 
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 		
		  
			  /*  console.log("ward dropdownlist "+globalWardListDropDown);
			    $('.zoneClass').append(globalZoneListDropDown);
				  $('.wardClass').append(globalWardListDropDown);	
				  $('.departmentClass').append(globalDepartmentListDropDown); */
		
		  
	  }
	
	function setDropDownValues(){
		console.log("ward dropdown "+globalWardListDropDown);
		    $('.zoneClass').append(globalZoneListDropDown);
			  $('.wardClass').append(globalWardListDropDown);	
			  $('.departmentClass').append(globalDepartmentListDropDown);
	}
	
	function filterWardList(item){
		if(item.value == ''){
			return;
		}else{
			$(item).closest('tr').find('td').eq(9).find("select").empty();
		}
		var html = '<option value="">Select</option>';
		for(var i=0; i< globalWardList.length;i++){
			var zoneId = globalWardList[i].zoneId;
			if(zoneId != '' && zoneId == item.value){
				
				html += "<option value="+globalWardList[i].wardId+">"+globalWardList[i].wardName+"</option>";
			}
		}
		$(item).closest('tr').find('td').eq(9).find("select").append(html);
	}
	
	function addRow(item){
		var tbl = document.getElementById('campTable');
		var lastRow = tbl.rows.length;
		k = lastRow+1;
		var aClone = $(item).closest('tr').clone(true)
		aClone.find("td:eq(5)").find("option[selected]").removeAttr("selected");
		aClone.find("td:eq(12)").html('');
		var r= $("<button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button>");
		aClone.find("td:eq(12)").html(r);
		aClone.clone(true).appendTo('#campTable');
	}
	
	function deleteRow(item){
		$(item).closest('tr').remove();
	}
	
	function disableBasedOnOFF(item){
		var val = item.value;
		if(val != 'Camp'){
			$(item).closest('tr').find('td').eq(3).find(":input").prop('disabled',true);
			$(item).closest('tr').find('td').eq(4).find(":input").prop('disabled',true);
			$(item).closest('tr').find('td').eq(5).find("select").prop('disabled',true);
			$(item).closest('tr').find('td').eq(6).find("textarea").prop('disabled',true);
			$(item).closest('tr').find('td').eq(7).find("textarea").prop('disabled',true);
			$(item).closest('tr').find('td').eq(8).find("select").prop('disabled',true);
			$(item).closest('tr').find('td').eq(9).find("select").prop('disabled',true);
			$(item).closest('tr').find('td').eq(10).find(":input").prop('disabled',true);
			$(item).closest('tr').find('td').eq(11).find(":input").prop('disabled',true);
			
			$(item).closest('tr').find('td').eq(5).find("select").val('');
			$(item).closest('tr').find('td').eq(8).find("select").val('');
			$(item).closest('tr').find('td').eq(9).find("select").val('');
			
		}else{
			$(item).closest('tr').find('td').eq(3).find(":input").prop('disabled',false);
			$(item).closest('tr').find('td').eq(4).find(":input").prop('disabled',false);
			$(item).closest('tr').find('td').eq(5).find("select").prop('disabled',false);
			$(item).closest('tr').find('td').eq(6).find("textarea").prop('disabled',false);
			$(item).closest('tr').find('td').eq(7).find("textarea").prop('disabled',false);
			$(item).closest('tr').find('td').eq(8).find("select").prop('disabled',false);
			$(item).closest('tr').find('td').eq(9).find("select").prop('disabled',false);
			$(item).closest('tr').find('td').eq(10).find(":input").prop('disabled',false);
			$(item).closest('tr').find('td').eq(11).find(":input").prop('disabled',false);
		}
		
	}
	  
	function getDayName(date){
		
		var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
		var d = new Date(date);
		var dayName = days[d.getDay()];
		return dayName;
	}
	  
	  /* function getDistrictList(){
			
			var params = {
					"stateId":1
			}
			
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getDistrictList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.list;
						var districtDrop = '<option value="">Select</option>';
						for(i=0;i<list.length;i++){
							districtDrop += '<option value='+list[i].districtId+'>'+list[i].districtName+'</option>';
						}
						$('#districtId').append(districtDrop);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
					$('#submit_btn').attr("disabled", false);
				}
			}); 
	 	} */
	 	function getCityList(){
			$j("#cityId").empty();
			var districtId=$j("#district option:selected").val();
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
			    data: JSON.stringify({"PN" : "0","districtId": districtId}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
			    	$j("#cityId").append('<option value=0>All</option>');
			    	jQuery('#cityId').append(combo);
			    	
			    }
			    
			});
		}
	  /* function getCityList(){
			var params = {
			}
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getCityList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.list;
						var cityDrop = '';
						for(i=0;i<list.length;i++){
							cityDrop += '<option value='+list[i].cityId+'>'+list[i].cityName+'</option>';
						}
						$j('#cityId').append(cityDrop);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 	} */
	  
	  function getMMUList(item){
			
			var params;
			  if(item != ''){
				  var cityId = item.value;
				  params = {
							"cityId":cityId
					}
			  }else{
				  params = { };
			  }
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				//url : 'getMMUList',
				url: "${pageContext.servletContext.contextPath}/master/getMmuByCityMapping",
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						//var list = data.list;
						var list = data.data;
						var mmuDrop = '';
						$j('#mmuId').find('option').not(':first').remove();
						console.log("cityList "+list);
						for(i=0;i<list.length;i++){
							mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
						}
						$j('#mmuId').append(mmuDrop);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 	}
	  
	  
	  $(function () {
	        //Reference the DropDownList.
	        var year = $("#year");
	 
	        //Determine the Current Year.
	        var currentYear = 2021;
	 		var currentToNext100Year = currentYear +100;
	        //Loop and add the Year values to DropDownList.
	        
	        for (var i = currentYear; i <= currentToNext100Year; i++) {
	            var option = $("<option />");
	            option.html(i);
	            option.val(i);
	            year.append(option);
	        }
	    });
	  
	  $(function () {
	        var month = $("#month");
	 
	        var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	        for (var i = 0; i < monthNames.length; i++) {
	            var option = $("<option />");
	            option.html(monthNames[i]);
	            option.val(i+1);
	            month.append(option);
	        }
	    });
	  
	  function filterMMU(){
		  
	  }
	  function GetDistrictList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#district').append(combo);
			    	
			    }
			    
			});
		}
	  
	  function getMMUListByDistrictId(item){
	 		 $j("#mmuId").empty();
		  var params;
		  if(item != ''){
			  //var cityId = item.value;
			  var districtId = item.value;
			  params = {
						"cityId":"",
						"districtId":districtId,
				}
		  }else{
			  params = { };
		  }
		 
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url: "${pageContext.servletContext.contextPath}/master/getMmuByDistrictId",
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.data;
						var mmuDrop = '';
						$j('#mmuId').find('option').not(':first').remove();
						for(i=0;i<list.length;i++){
							mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
						}
						$j('#mmuId').append(mmuDrop);
					}
					else{
						mmuDrop = '<option value="0">No Record Found</option>';
						$j('#mmuId').append(mmuDrop);
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
			<div class="container-fluid">

				<div class="internal_Htext">Generate Camp Monthly Report</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<!-- <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" name="districtName" onchange="getCityList(this)" id="districtId">
												</select>
											</div>
										</div>
									</div> -->
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="district" onchange="getMMUListByDistrictId(this)">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									<!-- <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityId" onchange="getMMUList(this)">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div> -->
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="year">
												<option value="">Select Year</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Month</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="month">
												<option value="">Select Month</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-md-4">
										
										<button type="button" class="btn btn-primary" onclick="generateCampReport()">Generate Report
											</button>
										
									</div>
								</div>

								<div>
									<div class="clearfix">
										<!-- <div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>
											
										</div> -->

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										
									</div>
								</div>

								
								<div class="row m-t-20" id="btn_div">
									<div class="col-12 text-right">									
										<button type="button" class="btn btn-primary" id="submit_btn" onclick="saveCampDetail(this)">Submit</button>
										<button type="button" class="btn btn-primary">Close</button>
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

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
