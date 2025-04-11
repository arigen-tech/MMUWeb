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
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript">
	
<%
			String mmuId = "0";
			if (session.getAttribute("mmuId") != null) {
				mmuId = session.getAttribute("mmuId") + "";
			}
			
			String mmuIdMultiple = "0";
			if (session.getAttribute("mmuIdMultiple") != null) {
				mmuIdMultiple = session.getAttribute("mmuIdMultiple") + "";
			}
			
		
			
			String userId = "0";
			if (session.getAttribute("userId") != null) {
				userId = session.getAttribute("userId") + "";
			}
			
			String departmentId = "0";
			if (session.getAttribute("departmentId") != null) {
				departmentId = session.getAttribute("departmentId") + "";
			}
			
			String departmentName = "";
			if (session.getAttribute("departmentName") != null) {
				departmentName = session.getAttribute("departmentName") + "";
			}
			
			String campId = "0";
			if (session.getAttribute("campId") != null) {
				campId = session.getAttribute("campId") + "";
			}
			
			String cityName = "";
			if (session.getAttribute("cityName") != null) {
				cityName = session.getAttribute("cityName") + "";
			}
			
			%>
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
		getWardList('0');
		getZoneList('0');
	$('#table_div').hide();
		$('#btn_div').hide();
		
		

	});
	
	function saveCampDetail(item){
		
			
		 var district = $('#district').val();
		 // var city = $('#cityId').val();
		  var mmu = $('#mmuId').val();
		  var year = $('#year').val();
		  var month = $('#month').val();
		  
		  if(district == ''){
			  alert("Please Select District");
			  return;
		  }
		  /* if(city == ''){
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
		
		var listOfDatails = [];
		var validationFlag = false;
		$('#campTable > tbody  > tr').each(function(index, tr) { 
				var rowId = $(tr).attr('id');
				var date = $(tr).find('td').eq(1).text();
				var day = $(tr).find('td').eq(2).text();
				var weeklyOff = $(tr).find('td').eq(3).find("select").val();
				
				//check date if it is future then consider it to save
				var parts2 = currentDateInddmmyyyy().split("/");
				var todayDate = new Date(parts2[2], parts2[1] - 1, parts2[0]);
				var parts1 = date.split("/");
				var dateObj = new Date(parts1[2], parts1[1] - 1, parts1[0]);						
				if(dateObj < todayDate){
					return;
				}
					
				if(weeklyOff == ''){
					alert("Please select Camp/Weekly off/CL for Date "+date+"");
					validationFlag = true;
					return false;
				}
				var startTime = $(tr).find('td').eq(4).find(":input").val();
				var endTime = $(tr).find('td').eq(5).find(":input").val();
				var departmentId = $(tr).find('td').eq(6).find("select").val();
				var location = $(tr).find('td').eq(7).find("textarea").val();
				var landmark = $(tr).find('td').eq(8).find("textarea").val();
				var zoneId = $(tr).find('td').eq(9).find("select").val();
				var wardId = $(tr).find('td').eq(10).find("select").val();
				var longitude = $(tr).find('td').eq(11).find(":input").val();
				var lattitude = $(tr).find('td').eq(12).find(":input").val();
				var cityIdValNe = $(tr).find('td').eq(0).find("select").val();
				
				if(weeklyOff == 'Camp' || weeklyOff == 'camp'){
					if(location != '' || landmark!= '' || zoneId != '' || wardId != '' || longitude != '' || lattitude != ''){
						if(startTime == ''){
							alert("Please select Start Time for Date "+date+"");
							validationFlag = true;
							return false;
						}
						if(endTime == ''){
							alert("Please select End Time for Date "+date+"");
							validationFlag = true;
							return false;
						}
						var st = startTime.split(':');
						var et = endTime.split(':');
						if(st[0] > et[0]){
							alert("Start Time cannot be later than End Time for Date "+date+"");
							validationFlag = true;
							return false;
						}else if( st[0] == et[0] && st[1] > et[1] ){
							alert("Start Time cannot be later than End Time for Date "+date+"");
							validationFlag = true;
							return false;
						}else if( st[0] == et[0] && st[1] == et[1] ){
							alert("Start Time and End Time cannot be equal for Date "+date+"");
							validationFlag = true;
							return false;	
						}
						
						if(departmentId == ''){
							alert("Please select Department for Date "+date+"");
							validationFlag = true;
							return false;
						}
						if(location == ''){
							alert("Please select Location for Date "+date+"");
							validationFlag = true;
							return false;
						}
						if(landmark == ''){
							alert("Please select Landmark for Date "+date+"");
							validationFlag = true;
							return false;
						}
						/* if(wardId == ''){
							alert("Please select Ward for Date "+date+"");
							validationFlag = true;
							return false;
						} */
						if(longitude == ''){
							alert("Please select Longitude for Date "+date+"");
							validationFlag = true;
							return false;
						}
						if(lattitude == ''){
							alert("Please select Lattitude for Date "+date+"");
							validationFlag = true;
							return false;
						}
						//validate lat and long
						let pattern = new RegExp('^-?([1-8]?[1-9]|[1-9]0)\\.{1}\\d{1,6}');
						  
						 if(pattern.test(longitude)){
							 
						 }else{
							 alert("Please enter valid Longitude for Date "+date+"");
								validationFlag = true;
								return false;
						 }
						 
						if(pattern.test(lattitude)){
							 
						 }else{
							 alert("Please enter valid Lattitude for Date "+date+"");
								validationFlag = true;
								return false;
						 }
						if(cityIdValNe == ''){
							alert("Please select  City");
							validationFlag = true;
							return false;
						}

					}else{
						return;
					}
					
				}
				var campOffFlag = false;
				var locationFlag = false;
				if(rowId != 0 || rowId != ''){ 
					for(x=0;x<globalCampDetailData.length;x++){
						var cId = globalCampDetailData[x].id;
						var campCheck = globalCampDetailData[x].campOrOff;
						if(cId == rowId){
							if(campCheck == 'Camp' || campCheck == 'camp'){
								if(weeklyOff != 'Camp' && weeklyOff != 'camp'){
									campOffFlag = true;
									console.log("camp changed for date "+date);
								}
							}
							
							var locationCheck = globalCampDetailData[x].location;
							if(locationCheck.trim() != location.trim()){
								locationFlag = true;
								console.log("location changed for date "+date);
							}
						}
						
					}
				}
				
				var input = {
						"id":rowId,
						"campDate":date,
						"day":day,
						"weeklyOff":weeklyOff,
						"startTime":startTime,
						"endTime":endTime,
						"departmentId":departmentId,
						"location":location,
						"landmark":landmark,
						"zoneId":zoneId,
						"wardId":wardId,
						"longitude":longitude,
						"lattitude":lattitude,
						"campOffFlag":campOffFlag,
						"locationFlag":locationFlag,
				        "cityIdMul":cityIdValNe
				}
				listOfDatails.push(input);
			});
		if(listOfDatails.length == 0){
			alert("Please configure camp plan");
			return;
		}
		
		if(validationFlag){
			return;
		}
		
		var params = {
				"cityId":"",
				"mmuId":mmu,
				"year":year,
				"month":month,
				"campPlanList":listOfDatails
		}
		console.log("data is "+JSON.stringify(params));
		//globalModifiedCampData = params;
		
		$j(item).attr("disabled", true);
		$j("#loadingDiv").show();
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'createCampPlan',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				$j("#loadingDiv").hide();
				if(data.status == true){
					alert(data.msg+'S');
					document.addEventListener('click',function(e){
						    if(e.target && e.target.id== 'closeBtn'){
		   	   				 	window.location.reload();
						     }
						 });
				}else{
					alert(data.msg);
					$(item).attr("disabled", false);
				}
				
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
				$(item).attr("disabled", false);
			}
		}); 
		
	}
	
	function setZoneWard(item){
		 var cityIdVal=item.value;		 
		var dropDown="";
	  for(var i=0;i<globalWardList.length;i++){
		if(cityIdVal==globalWardList[i].cityId){
			dropDown += '<option value='+globalWardList[i].wardId+'>'+globalWardList[i].wardName+'-'+globalWardList[i].wardNo+'</option>';
		}
	  }
	  globalWardListDropDown=dropDown;
		$(item).closest('tr').find('td').eq(10).find("select").append(dropDown);
		
		var dropDownZone = '';
		for(i=0;i<globalZoneList.length;i++){
			if(cityIdVal==globalZoneList[i].cityId){
			dropDownZone += '<option value='+globalZoneList[i].zoneId+'>'+globalZoneList[i].zoneName+'</option>';
			}
		}
		globalZoneListDropDown=dropDownZone;
		$(item).closest('tr').find('td').eq(9).find("select").append(dropDownZone);
	}
	 function getWardList(cityIdVal){
		 var cityId ="";    
		 if(cityIdVal!=null){
			 cityId= cityIdVal;
		     }
		     else
			  cityId = $('#cityId').val();
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
							dropDown += '<option value='+list[i].wardId+'>'+list[i].wardName+'-'+list[i].wardNo+'</option>';
						}
						//globalWardListDropDown = dropDown;
					//	$('.wardClass').append(dropDown);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 	}
	
	 function getZoneList(cityIdVal){
		 var city="";
		 if(cityIdVal!=null){
			 cityId= cityIdVal;
		     }
		     else
		    city = $('#cityId').val();
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
						//globalZoneListDropDown = dropDown;
						//$('.zoneClass').append(dropDown);
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
	 
	 function getCampDetail(){
			
			 // var city = $('#cityId').val();
			  var mmu = $('#mmuId').val();
			  var year = $('#year').val();
			  var month = $('#month').val();
			  
			  if( mmu != '' && year != '' && month != ''){
				  showCampDetail();
			  }
			  //this is recent change 12/11/2022 replace with GetMMUCityByCluster() need get city using mmuid
			 // getCityList();
			  GetMMUCityByCluster();
	 }

	 var globalCampDetailData = '';
	 function showCampDetail(){
		
		$('#submit_btn').attr("disabled", false);
		 /*  getDepartmentList();
		  getZoneList();
		  getWardList(); */
		  var district = $('#district').val();
		  //var city = $('#cityId').val();
		  var mmu = $('#mmuId').val();
		  var year = $('#year').val();
		  var month = $('#month').val();
		  
		  if(district == ''){
			  alert("Please Select District");
			  return;
		  }
		   /* if(city == ''){
			  alert("Please Select City");
			  return;
		  }  */
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
				  "cityId":"0",
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
						globalCampDetailData = data.list;
						var monthDays =  new Date(year, month, 0).getDate();
						var htmlTable = '';
						var campFlag = true;  //if records are greater than today date then only enable submit button
						var cityIdVal="";
						var cityNameVal="";
						for(m=0;m<monthDays;m++){	
						   var day =
							   '';
						   var monthNo = '';
						   if((m+1) <10){
							   day += '0'+(m+1);
						   }else{
							   day += (m+1);
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
						   var findDataFlag = true;
						      
						      
							if(list.length >0){
								
								for(i=0;i<list.length;i++){
									var parts = list[i].campDate.split("/");
									var date = new Date(parts[2], parts[1] - 1, parts[0]);
									 	 
									 if(date1.getTime() == date.getTime()){
										findDataFlag = false;
										if(date < date2){
											
											htmlTable = htmlTable+"<tr id='"+list[i].id+"'>";	
											
											var citytNameHtmlTemp = "";
											for(k=0;k<globalCityValue.length;k++){		
												 
												if(list[i].cityId == globalCityValue[k].cityId){
													citytNameHtmlTemp += "<option value="+ globalCityValue[k].cityId+" selected>"+ globalCityValue[k].cityName+"</option>";
												}else{
													citytNameHtmlTemp += "<option value="+ globalCityValue[k].cityId+">"+ globalCityValue[k].cityName+"</option>";	
												}									
											} 
											htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control cityListClass' onchange='setZoneWard(this);' disabled='disabled'><option value=''>Select</option>"+citytNameHtmlTemp+"</select></td>";
									
											htmlTable = htmlTable +"<td cl>"+list[i].campDate+"</td>";
											htmlTable = htmlTable +"<td class='' disaled='disabled'>"+list[i].day+"</td>";
											var weeklyOffDropdown = '';
											if(list[i].campOrOff == 'Camp'){
												weeklyOffDropdown += "<option value = 'Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option>"; 
											}else if(list[i].campOrOff == 'Weekly Off'){
												weeklyOffDropdown += "<option value = 'Camp'>Camp</option><option value='Weekly Off' selected>Weekly Off</option><option value='CL'>CL</option>";
											}else if(list[i].campOrOff == 'CL'){
												weeklyOffDropdown += "<option value = 'Camp'>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL' selected>CL</option>";
											}
											htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);' disabled='disabled'><option value=''>Select</option>'"+weeklyOffDropdown+"'</select></td>";
											htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].startTime+"' disabled='disabled'></td>";  
											
											htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].endTime+"' disabled='disabled'></td>";
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
											//callingFlag = false;
											var disableCity= "";
											htmlTable = htmlTable+"<tr id='"+list[i].id+"'>";	
											if(list[i].campOrOff == 'Weekly Off' || list[i].campOrOff == 'CL'){
												disableCity= 'disabled=disabled';
											}
											else{
												disableCity="";
											}
											
											var citytNameHtmlTemp = "";
											for(t=0;t<globalCityValue.length;t++){		
												 
												if(list[i].cityId == globalCityValue[t].cityId && list[i].campOrOff == 'Camp'){
													citytNameHtmlTemp += "<option value="+ globalCityValue[t].cityId+" selected>"+ globalCityValue[t].cityName+"</option>";
												}else{
													citytNameHtmlTemp += "<option value="+ globalCityValue[t].cityId+">"+ globalCityValue[t].cityName+"</option>";	
												}									
											} 
											htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' "+disableCity+" onchange='setZoneWard(this);'><option value=''>Select</option>"+citytNameHtmlTemp+"</select></td>";
										
											
											htmlTable = htmlTable +"<td class=''>"+list[i].campDate+"</td>";
											htmlTable = htmlTable +"<td class=''>"+list[i].day+"</td>";
											var weeklyOffDropdown = '';
											if(list[i].campOrOff == 'Camp'){
												weeklyOffDropdown += "<option value = 'Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option>";
												
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);'><option value=''>Select</option>'"+weeklyOffDropdown+"'</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].startTime+"'></td>";  
												
												htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].endTime+"'></td>";
												var departmentNameHtml = '';
												for(j=0;j<departmentData.length;j++){		
													globalDepartmentListDropDown +=  "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";
													if(list[i].departmentId == departmentData[j].departmentId){
														departmentNameHtml += "<option value="+ departmentData[j].departmentId+" selected>"+ departmentData[j].departmentName+"</option>";
													}else{
														departmentNameHtml += "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";	
													}									
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control'><option value=''>Select</option>"+departmentNameHtml+"</select></td>";
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
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='filterWardList(this)'><option value=''>Select</option>"+zoneNameHtml+"</select></td>";
												var wardNameHtml = '';
												for(l=0;l<wardData.length;l++){	
													globalWardListDropDown += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardNameWithNo+"</option>";
													if(list[i].wardId == wardData[l].wardId){
														wardNameHtml += "<option value="+ wardData[l].wardId+" selected>"+ wardData[l].wardNameWithNo+"</option>";
													}else{
														wardNameHtml += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardNameWithNo+"</option>";	
													}
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control'><option value=''>Select</option>"+wardNameHtml+"</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].longitude+"' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;'></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].lattitude+"' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;'></td>";
											
													
												
												htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button></td>";
												htmlTable = htmlTable+"</tr>";
											}else if(list[i].campOrOff == 'Weekly Off'){
											 
												
												weeklyOffDropdown += "<option value = 'Camp'>Camp</option><option value='Weekly Off' selected>Weekly Off</option><option value='CL'>CL</option>";
												
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);'><option value=''>Select</option>'"+weeklyOffDropdown+"'</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].startTime+"' disabled='disabled'></td>";  
												
												htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].endTime+"' disabled='disabled'></td>";
												var departmentNameHtml = '';
												for(j=0;j<departmentData.length;j++){		
													globalDepartmentListDropDown +=  "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";
													if(list[i].departmentId == departmentData[j].departmentId){
														departmentNameHtml += "<option value="+ departmentData[j].departmentId+" selected>"+ departmentData[j].departmentName+"</option>";
													}else{
														departmentNameHtml += "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";	
													}									
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' disabled='disabled'><option value=''>Select</option>"+departmentNameHtml+"</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'>"+list[i].location+"</textarea></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'>"+list[i].landmark+"</textarea></td>";
												var zoneNameHtml = '';
												for(k=0;k<zoneData.length;k++){				
													globalZoneListDropDown += "<option value="+ zoneData[k].zoneId+">"+ zoneData[k].zoneName+"</option>";
													if(list[i].zoneId == zoneData[k].zoneId){
														zoneNameHtml += "<option value="+ zoneData[k].zoneId+" selected>"+ zoneData[k].zoneName+"</option>";
													}else{
														zoneNameHtml += "<option value="+ zoneData[k].zoneId+">"+ zoneData[k].zoneName+"</option>";	
													}
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='filterWardList(this)' disabled='disabled'><option value=''>Select</option>"+zoneNameHtml+"</select></td>";
												var wardNameHtml = '';
												for(l=0;l<wardData.length;l++){	
													globalWardListDropDown += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardName+"</option>";
													if(list[i].wardId == wardData[l].wardId){
														wardNameHtml += "<option value="+ wardData[l].wardId+" selected>"+ wardData[l].wardName+"</option>";
													}else{
														wardNameHtml += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardName+"</option>";	
													}
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' disabled='disabled'><option value=''>Select</option>"+wardNameHtml+"</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].longitude+"' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;' disabled='disabled'></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].lattitude+"' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;' disabled='disabled'></td>";
 
													
												
												htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)' disabled='disabled'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button></td>";
												htmlTable = htmlTable+"</tr>";
											}else if(list[i].campOrOff == 'CL'){
												
												 weeklyOffDropdown += "<option value = 'Camp'>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL' selected>CL</option>";
												
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);'><option value=''>Select</option>'"+weeklyOffDropdown+"'</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].startTime+"' disabled='disabled'></td>";  
												
												htmlTable = htmlTable +"<td class='minwidth120'><input type='time' class='form-control' value='"+list[i].endTime+"' disabled='disabled'></td>";
												var departmentNameHtml = '';
												for(j=0;j<departmentData.length;j++){		
													globalDepartmentListDropDown +=  "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";
													if(list[i].departmentId == departmentData[j].departmentId){
														departmentNameHtml += "<option value="+ departmentData[j].departmentId+" selected>"+ departmentData[j].departmentName+"</option>";
													}else{
														departmentNameHtml += "<option value="+ departmentData[j].departmentId+">"+ departmentData[j].departmentName+"</option>";	
													}									
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' disabled='disabled'><option value='' >Select</option>"+departmentNameHtml+"</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'>"+list[i].location+"</textarea></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'>"+list[i].landmark+"</textarea></td>";
												var zoneNameHtml = '';
												for(k=0;k<zoneData.length;k++){				
													globalZoneListDropDown += "<option value="+ zoneData[k].zoneId+">"+ zoneData[k].zoneName+"</option>";
													if(list[i].zoneId == zoneData[k].zoneId){
														zoneNameHtml += "<option value="+ zoneData[k].zoneId+" selected>"+ zoneData[k].zoneName+"</option>";
													}else{
														zoneNameHtml += "<option value="+ zoneData[k].zoneId+">"+ zoneData[k].zoneName+"</option>";	
													}
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='filterWardList(this)' disabled='disabled'><option value=''>Select</option>"+zoneNameHtml+"</select></td>";
												var wardNameHtml = '';
												for(l=0;l<wardData.length;l++){	
													globalWardListDropDown += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardName+"</option>";
													if(list[i].wardId == wardData[l].wardId){
														wardNameHtml += "<option value="+ wardData[l].wardId+" selected>"+ wardData[l].wardName+"</option>";
													}else{
														wardNameHtml += "<option value="+ wardData[l].wardId+">"+ wardData[l].wardName+"</option>";	
													}
												}
												htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' disabled='disabled'><option value=''>Select</option>"+wardNameHtml+"</select></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].longitude+"' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;' disabled='disabled'></td>";
												htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='"+list[i].lattitude+"' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;' disabled='disabled'></td>";

												
												
												htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)' disabled='disabled'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button></td>";
												htmlTable = htmlTable+"</tr>";
											}
											
										}
										
									}
								}
								
								if(findDataFlag){
									//when list data is there but no match
									callingFlag = true;
									if(date1 < date2){
										htmlTable = htmlTable+"<tr id=''>";		
										var citytNameHtmlTemp = "";
										for(j=0;j<globalCityValue.length;j++){		
									 			citytNameHtmlTemp += "<option value="+ globalCityValue[j].cityId+">"+ globalCityValue[j].cityName+"</option>";	
											 								
										} 
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='setZoneWard(this);' disabled='disabled'  ><option value=''>Select</option>"+citytNameHtmlTemp+"</select></td>";
										
										htmlTable = htmlTable +"<td class=''>"+concatenatedDate+"</td>";
										htmlTable = htmlTable +"<td class=''>"+dayName+"</td>";
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);' disabled='disabled'><option value=''>Select</option><option value='Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option></select></td>";
										htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='08:00' disabled='disabled'></td>";  
										
										htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='15:00' disabled='disabled'></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' disabled='disabled'><option value=''>Select</option></select></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'></textarea></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'></textarea></td>";
										
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' disabled='disabled'><option value=''>Select</option></select></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' disabled='disabled'><option value=''>Select</option></select></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' disabled='disabled'></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' disabled='disabled'></td>";
										 
										
										
										htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth'><i class='fa fa-plus'></i></button></td>";
										htmlTable = htmlTable+"</tr>";
									}else{
										callingFlag = true;
										campFlag = false;
										htmlTable = htmlTable+"<tr id=''>";	
										var citytNameHtmlTemp = "";
										for(j=0;j<globalCityValue.length;j++){		
									 			citytNameHtmlTemp += "<option value="+ globalCityValue[j].cityId+">"+ globalCityValue[j].cityName+"</option>";	
											 								
										} 
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control cityListClass' onchange='setZoneWard(this);' ><option value=''>Select</option>"+citytNameHtmlTemp+"</select></td>";
										
										htmlTable = htmlTable +"<td class=''>"+concatenatedDate+"</td>";
										htmlTable = htmlTable +"<td class=''>"+dayName+"</td>";
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);'><option value=''>Select</option><option value='Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option></select></td>";
										htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='08:00'></td>";  
										
										htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='15:00'></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control departmentClass'><option value=''>Select</option></select></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'></textarea></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'></textarea></td>";
										
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' onchange='filterWardList(this)'><option value=''>Select</option></select></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control wardClass'><option value=''>Select</option></select></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;'></td>";
										htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;'></td>";
										
										
										
										htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button></td>";
										htmlTable = htmlTable+"</tr>";
									}
							    	  
								}
							}else{
								//when no data in db
								callingFlag = true;
								if(date1 < date2){
									htmlTable = htmlTable+"<tr id=''>";	
									var citytNameHtmlTemp = "";
									for(j=0;j<globalCityValue.length;j++){		
								 			citytNameHtmlTemp += "<option value="+ globalCityValue[j].cityId+">"+ globalCityValue[j].cityName+"</option>";	
										 								
									} 
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control cityListClass' onchange='setZoneWard(this);' disabled='disabled'><option value=''>Select</option>"+citytNameHtmlTemp+"</select></td>";
									
									htmlTable = htmlTable +"<td class=''>"+concatenatedDate+"</td>";
									htmlTable = htmlTable +"<td class=''>"+dayName+"</td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);' disabled='disabled'><option value=''>Select</option><option value='Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option></select></td>";
									htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='08:00' disabled='disabled'></td>";  
									
									htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='15:00' disabled='disabled'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control departmentClass' disabled='disabled'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'></textarea></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2' disabled='disabled'></textarea></td>";
									
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' disabled='disabled'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control wardClass' disabled='disabled'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' disabled='disabled'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' disabled='disabled'></td>";
								 
										
									htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth'><i class='fa fa-plus'></i></button></td>";
									//htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button></td>";
									htmlTable = htmlTable+"</tr>";
								}else{
									callingFlag = true;
									campFlag = false;
									htmlTable = htmlTable+"<tr id=''>";	
									var citytNameHtmlTemp = "";
									for(j=0;j<globalCityValue.length;j++){		
								 			citytNameHtmlTemp += "<option value="+ globalCityValue[j].cityId+">"+ globalCityValue[j].cityName+"</option>";	
							 		} 
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control cityListClass' onchange='setZoneWard(this);'><option value=''>Select</option>"+citytNameHtmlTemp+"</select></td>";
								
									htmlTable = htmlTable +"<td class=''>"+concatenatedDate+"</td>";
									htmlTable = htmlTable +"<td class=''>"+dayName+"</td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control' onchange='disableBasedOnOFF(this);'><option value=''>Select</option><option value='Camp' selected>Camp</option><option value='Weekly Off'>Weekly Off</option><option value='CL'>CL</option></select></td>";
									htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='08:00'></td>";  
									
									htmlTable = htmlTable +"<td class=''><input type='time' class='form-control width100' value='15:00'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control departmentClass'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'></textarea></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><textarea class='form-control' rows='2'></textarea></td>";
									
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control zoneClass' onchange='filterWardList(this)'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><select class='form-control wardClass'><option value=''>Select</option></select></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;'></td>";
									htmlTable = htmlTable +"<td class='minwidth120'><input type='text' class='form-control' value='' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;'></td>";
									
									 
											
									htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm'><button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button></td>";
									htmlTable = htmlTable+"</tr>";
								}
								
							}
						
					   }
						
						   $('#campDetailTable').html(htmlTable);
						  
						   if(campFlag){
							  // $('#submit_btn').attr("disabled", true);
						   }
						   
							$('#table_div').show();
							$('#btn_div').show();
						
						
				
						
					}else{
						alert(data.msg);
					}
					
				},
			    complete: function (data) {
			    	//setDropDownValues();
			    	if(callingFlag){
			    		getDepartmentList();
						 //getZoneList();
						 //getWardList();
						 //getCityList();
						 
						 
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
			$(item).closest('tr').find('td').eq(10).find("select").find('option').not(':first').remove();
			$(item).closest('tr').find('td').eq(10).find("select").append(globalWardListDropDown);
			return;
		}else{
			$(item).closest('tr').find('td').eq(10).find("select").empty();
		}
		var html = '<option value="">Select</option>';
		for(var i=0; i< globalWardList.length;i++){
			var zoneId = globalWardList[i].zoneId;
			if(zoneId != '' && zoneId == item.value){
				
				html += "<option value="+globalWardList[i].wardId+">"+globalWardList[i].wardName+"</option>";
			}
		}
		$(item).closest('tr').find('td').eq(10).find("select").append(html);
	}
	
	function addRow(item){
		var tbl = document.getElementById('campTable');
		var lastRow = tbl.rows.length;
		k = lastRow+1;
		var aClone = $(item).closest('tr').clone(true)
		aClone.closest('tr').attr("id","");
		aClone.find(":input").val("");
		aClone.find("td:eq(6)").find("option[selected]").removeAttr("selected");
		aClone.find("td:eq(0)").find("option[selected]").removeAttr("selected");
		aClone.find("td:eq(14)").html('');
		var r= $("<button class='btn btn-sm btn-primary noMinWidth' onclick='addRow(this)'><i class='fa fa-plus'></i></button><button class='btn btn-danger noMinWidth' onclick='deleteRow(this)'><i class='fa fa-minus'></i></button>");
		aClone.find("td:eq(14)").html(r);
		$(item).closest('tr').after(aClone.clone(true).appendTo('#campTable'));
	}
	
	function deleteRow(item){
		
		var rowId = $(item).closest('tr').attr("id");
		//console.log("id is "+rowId);
		
		if(rowId != 0 && rowId != '' && rowId !='undefined'){ 
			var params = {
					"id":rowId
			}
			
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'deleteCampPlan',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						$(item).closest('tr').remove();
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
		}else{
			$(item).closest('tr').remove();
		}
	}
	
	function disableBasedOnOFF(item){
		var val = item.value;
		if(val != 'Camp' && val != 'camp'){
			$(item).closest('tr').find('td').eq(4).find(":input").prop('disabled',true);
			$(item).closest('tr').find('td').eq(5).find(":input").prop('disabled',true);
			$(item).closest('tr').find('td').eq(6).find("select").prop('disabled',true);
			$(item).closest('tr').find('td').eq(7).find("textarea").prop('disabled',true);
			$(item).closest('tr').find('td').eq(8).find("textarea").prop('disabled',true);
			$(item).closest('tr').find('td').eq(9).find("select").prop('disabled',true);
			$(item).closest('tr').find('td').eq(10).find("select").prop('disabled',true);
			$(item).closest('tr').find('td').eq(11).find(":input").prop('disabled',true);
			$(item).closest('tr').find('td').eq(12).find(":input").prop('disabled',true);
			$(item).closest('tr').find('td').eq(0).find("select").prop('disabled',true);
			
			$(item).closest('tr').find('td').eq(6).find("select").val('');
			$(item).closest('tr').find('td').eq(7).find("textarea").val('');
			$(item).closest('tr').find('td').eq(8).find("textarea").val('');
			$(item).closest('tr').find('td').eq(9).find("select").val('');
			$(item).closest('tr').find('td').eq(10).find("select").val('');
			$(item).closest('tr').find('td').eq(11).find(":input").val('');
			$(item).closest('tr').find('td').eq(12).find(":input").val('');
			$(item).closest('tr').find('td').eq(0).find("select").val('');
			
		}else{
			$(item).closest('tr').find('td').eq(4).find(":input").prop('disabled',false);
			$(item).closest('tr').find('td').eq(5).find(":input").prop('disabled',false);
			$(item).closest('tr').find('td').eq(6).find("select").prop('disabled',false);
			$(item).closest('tr').find('td').eq(7).find("textarea").prop('disabled',false);
			$(item).closest('tr').find('td').eq(8).find("textarea").prop('disabled',false);
			$(item).closest('tr').find('td').eq(9).find("select").prop('disabled',false);
			$(item).closest('tr').find('td').eq(10).find("select").prop('disabled',false);
			$(item).closest('tr').find('td').eq(11).find(":input").prop('disabled',false);
			$(item).closest('tr').find('td').eq(12).find(":input").prop('disabled',false);
			$(item).closest('tr').find('td').eq(0).find("select").prop('disabled',false);
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
	 	
	 	var globalCityValue="";
	 	function getCityList( ){
			//$j("#cityId").empty();
			//$j("#mmuId").empty();
			var districtId=$j("#district option:selected").val();
			var mmuIdT=$j("#mmuId option:selected").val();
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
			    data: JSON.stringify({"PN" : "0","districtId": districtId,"mmuIdT":mmuIdT}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	globalCityValue=result.data;
			    	for(var i=0;i<result.data.length;i++){
			    		
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
			    //	$j(".cityListClass").append('<option value=0>All</option>');
			    	//jQuery('#cityId').append(combo);
			    	 
			    	jQuery('.cityListClass').html(combo);
			    	
			    }
			    
			});
		}	
	 	
	 	function GetMMUCityByCluster(){
	 		 
	 		var mmuIdT=$j("#mmuId option:selected").val();
	 		jQuery.ajax({
	 		 	crossOrigin: true,
	 		    method: "POST",			    
	 		    crossDomain:true,
	 		    url: "${pageContext.servletContext.contextPath}/master/getMMUByCityCluster",
	 		    data: JSON.stringify({"PN" : "0","mmuId": mmuIdT}),
	 		    contentType: "application/json; charset=utf-8",
	 		    dataType: "json",
	 		    success: function(result){
	 		    	var combo = "" ;
	 		    	
	 		    	globalCityValue=result.data;
					for(var i=0;i<result.data.length;i++){
			    		
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
	 		    	jQuery('.cityListClass').html(combo);
	 		    	
	 		    }
	 		    
	 		});
	 	}
	 	
	 /*  function getCityList(){
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
				url: "${pageContext.servletContext.contextPath}/master/getMmuByCityMapping",
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
	  
	 	
	 	function getMMUListByDistrictId(item,districtIdTemp){
	 		 $j("#mmuId").empty(); 		
	 		var mmuIdMultiple = "<%out.print(mmuIdMultiple);%>" 
	 		var mmuId = "<%out.print(mmuId);%>" 
	 		
	 		 
	 		
		  var params;
		  if(item != ''){
			  //var cityId = item.value;
			  var districtId = item.value;
			  if(districtId==undefined){
					 districtId=districtIdTemp;
				 }
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
						
						console.log("mmuId="+mmuId)
						
						console.log("mmuIdArray="+mmuIdMultiple)
			            // Split the string into an array of ids, removing any empty elements
			            var mmuIdArray = mmuIdMultiple.split(',').filter(Boolean);

						console.log(mmuIdArray)
						
						$j('#mmuId').find('option').not(':first').remove();				 
						 
						
						 
						if(mmuIdArray.length>1 && mmuIdMultiple != 0) {
							
							for (var i = 0; i < list.length; i++) {
				                // Check if mmuId is in the mmuIdArray
				                if (mmuIdArray.includes(list[i].mmuId.toString()) && mmuIdArray.length>1) {
				                    mmuDrop += '<option value=' + list[i].mmuId + '>' + list[i].mmuName + '</option>';
				                }
				              
				            }						
							
						}
						
						else if(mmuIdMultiple == 0 && mmuId != 0) {
							
							for (var i = 0; i < list.length; i++) {
				                // Check if mmuId is in the mmuIdArray
				                if (mmuId.toString() == list[i].mmuId.toString()) {
				                    mmuDrop += '<option value=' + list[i].mmuId + '>' + list[i].mmuName + '</option>';
				                }
				              
				            }						
							
						}
						else
						{
							for (var i = 0; i < list.length; i++) {				                
				                
				                    mmuDrop += '<option value=' + list[i].mmuId + '>' + list[i].mmuName + '</option>';
				                }	             
				          
							
						}					
						
						
						if (mmuDrop) {
			                $j('#mmuId').append(mmuDrop);
			            } else {			                
			                console.log("MMU has not been assigned to you for this district");
			                mmuDrop = '<option value="0">MMU has not been assigned to you for this district</option>';
							$j('#mmuId').append(mmuDrop);
			            }
						
						
						
					}
					else{
						mmuDrop = '<option value="0">No Record Found</option>';
						$j('#mmuId').append(mmuDrop);
					}  
					
					GetMMUCityByCluster();
					getCampDetail();
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
	        var currentYear = (new Date()).getFullYear();
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
	  
	  function goHome(){
		  window.location = '../dashboard/dashboard';
	  }
	  
	  function GetDistrictList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
			    data: JSON.stringify({"PN" : "0","mmuIdSession":<%=userId%>}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	
					var districtIdByMMU=result.districtIdByMMU;
			    	
			    	//if(districtIdByMMU!=null && districtIdByMMU!=""){
			    		if(false){
			    	for(var i=0;i<result.data.length;i++){
			    	    if(result.data[i].districtId== districtIdByMMU){  
			    		combo += '<option value='+result.data[i].districtId+' selected>' +result.data[i].districtName+ '</option>';
			    	    }
			    	}
			    	
			    	jQuery('#district').append(combo);
			    	getMMUListByDistrictId("null",districtIdByMMU);
			    	 
			    }
			    	else{
			    	 	for(var i=0;i<result.data.length;i++){
				    	 	combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
				     	}
				     	jQuery('#district').append(combo);
				    		
			    		}
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

				<div class="internal_Htext">Camp Details</div>

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
												<!-- <select class="form-control" id="district" onchange="getCityList()"> -->
												<select class="form-control" id="district" onchange="getMMUListByDistrictId(this,null)">
												
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
												<select class="form-control" id="mmuId" onchange="getCampDetail()">
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
												<select class="form-control" id="year" onchange="getCampDetail()">
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
												<select class="form-control" id="month" onchange="getCampDetail()">
												<option value="">Select Month</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-md-4">
										
										<button type="button" class="btn btn-primary" onclick="showCampDetail()">Show
											Camp Plan</button>
										<span id="loadingDiv" class="m-l-10">
													<img class="m-r-10 " src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
												</span>
									</div>
								</div>

								<div>
									<div class="clearfix">
									
								<!-- 	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityId">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div> -->
									
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
										<div class="table-responsive scrollableDiv" id="table_div">
											<table
												class="table table-striped table-hover table-bordered stickyTableHeader" id="campTable">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th rowspan="2">City</th>
														<th rowspan="2">Date</th>
														<th rowspan="2">Day</th>
														<th rowspan="2">Camp / Weekly off / CL</th>
														<th colspan="2" class="text-center">Camp Time</th>
														<th rowspan="2">Department</th>
														<th rowspan="2">Location</th>
														<th rowspan="2">Landmark</th>
														<th rowspan="2">Zone Name</th>
														<th rowspan="2">Ward Name</th>
														<th rowspan="2">Longitude</th>
														<th rowspan="2">Latitude</th>
														<th rowspan="2">Action</th>
													</tr>
													<tr>
														<th style="top:34px">Start Time</th>
														<th style="top:34px">End Time</th>
													</tr>
												</thead>
												<tbody id="campDetailTable">
													<tr>
														<!-- <td class="">1/8/2021</td>
														<td class="">Sunday</td>
														<td class="minwidth120"><select class="form-control">
																<option>Select</option>
														</select></td>
														<td><input type="text"
															class="form-control width70"></td>
														<td ><input type="text"
															class="form-control width70"></td>
														<td class="minwidth120"><select class="form-control">
																<option>Select</option>
														</select></td>
														<td><textarea
																class="form-control width220" rows="2"></textarea></td>
														<td ><textarea
																class="form-control width220" rows="2"></textarea></td>
														<td class="minwidth120"><select class="form-control">
																<option>Select</option>
														</select></td>
														<td class="minwidth120"><select class="form-control">
																<option>Select</option>
														</select></td>
														<td class="minwidth120"><input type="text"
															class="form-control"></td>
														<td class="minwidth120"><input type="text"
															class="form-control"></td>
														<td class="minwidth120 btn-group-sm">
															<button class="btn btn-sm btn-primary noMinWidth">
																<i class="fa fa-plus"></i>
															</button>
															<button class="btn btn-danger noMinWidth">
																<i class="fa fa-minus"></i>
															</button>
														</td> -->
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>

								
								<div class="row m-t-20" id="btn_div">
									<div class="col-12 text-right">									
										<button type="button" class="btn btn-primary" id="submit_btn" onclick="saveCampDetail(this)">Submit</button>
										<button type="button" class="btn btn-primary" onclick="goHome();">Close</button>
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
