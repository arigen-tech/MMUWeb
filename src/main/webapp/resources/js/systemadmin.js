/**
 * 
 */

var masHospitalList="";
function getMasHospitalListForAdmin(){
	$.ajax({
				url : "getMasHospitalListForAdmin",
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.data;
					masHospitalList=datas;
					var miRoomVal="";
					var internalHospitalList = '<option value=""><strong>Select Unit</strong></option>';
					miRoomVal='<option value=""><strong>Select Unit</strong></option>';
					$.each(datas, function(i, item) {
						internalHospitalList +='<option value="' 
						+ item.hospitalId + '" >' + item.hospitalName
						+ '</option>'; 
						
						miRoomVal +='<option value="' 
							+ item.unitCode + '" >' + item.hospitalName
							+ '</option>'; 
					});
					
					
					//$('#massSystemAdminHospital').html(internalHospitalList);
					//$('#massSystemAdminHospitalForDesignation').html(internalHospitalList);	
					
					$('#miRoom').html(miRoomVal);
					$('#miRoomDesi').html(miRoomVal);
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
}

////////////////////////////////////////////////////////

var masHospitalList="";
function getMasUnitListByUnitCode(){
	
	var unitCodeVal=$('#miRoom').val();
	if(unitCodeVal==""){
		unitCodeVal=$('#miRoomDesi').val();
	}
	if(unitCodeVal==""){
		alert("Please select MI Room.");
		return false;
	}
	$.ajax({
				url : "getMasUnitListByUnitCode",
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'unitCodeVal':unitCodeVal
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.data;
					//masHospitalList=datas;
					var miRoomVal="";
					
					var unitList = '<option value=""><strong>Select Unit</strong></option>';
					if(datas!=null && datas.length>0){
					for(i=0;i<datas.length;i++){
						unitList +='<option value="' 
						+ datas[i].unitId + '" >' + datas[i].DESCR
						+ '</option>'; 
					}
					}
					else{
						alert("No Unit associated with MiRoom.");
					}
					$('#massSystemAdminHospital').html(unitList);
					$('#massSystemAdminHospitalForDesignation').html(unitList);	
					 
					 
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
}


///////////////////////////////////////////////////////




function getMasEmployeeDetail(flag){
	//var serviceNo=$('#serviceNo').val();
	var serviceNo=$('#serviceNo').find('option:selected').val();
	var unitId=$('#massSystemAdminHospital').val();
	if(serviceNo=="" || serviceNo=='0' || serviceNo==null){
		return false;
	}
	if(unitId=="" || unitId=='0' || unitId==null){
		alert("Please select Unit.");
		return false;
	}
	$.ajax({
				url : "getMasEmployeeDetail",
				dataType : "json",
				data : JSON.stringify({
					'serviceNo' : serviceNo,
					'unitId' :unitId,
					'flag':flag
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var dataList = response.dataMasEmployee;
					var htmlTable = "";	
					
					if(dataList!=null && dataList.length >= 0)
						{
						$('#errordiv').empty();
						 $('#userName').val(dataList[0].firstName);
						 $('#gender').val(dataList[0].gender);
						 $('#rank').val(dataList[0].rank);
						// $('#errordiv').empty("");
						 $("#btnActiveUnitAdmin").attr("disabled", false);
						}
					else{
						$('#errordiv').empty();
						$('#errordiv').html("Service Number does not exist of this Unit.Please Enter vaild Service Number.");
						$('#errordiv').show();
						errorFunctionHold("errordiv");	
						if(flag=='s')
						$("#btnActiveUnitAdmin").attr("disabled", true);
						resetWhenUserNotExist();
					}							  
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
}
var masDesignationGlobal="";

function getAllMasDesigation(){
	$.ajax({
				url : "getAllMasDesigation",
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'adminFlgValue' : 'U'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.dataMasDesignation;
					var masDesignationList = "";
					$.each(datas, function(i, item) {
						masDesignationList +='<option value="' 
						+ item.designationId + '" >' + item.designationName
						+ '</option>'; 
					});
					$('#availableContactTypeAdduser').html(masDesignationList);
								  
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
}



function submitUnitAdmin(){
	//var serviceNo=$('#serviceNo').val();
	//alert("serviceNo"+serviceNo);
	try{
		$("#btnActiveUnitAdmin").attr("disabled","disabled");
		}
		catch(e){}
	var serviceNo=$('#serviceNo').find('option:selected').val();
	//var unitId=$('#massSystemAdminHospital').find('option:selected').val();
	var unitId=$('#miRoom').find('option:selected').val();
	if(unitId=="" || unitId=="Select Unit"){
		alert("Please Select Unit.");
		return false;
	}
	if(serviceNo=="" || serviceNo=='0'){
		alert("Please Select Service Number.");
		return false;
	}
	var selectedUnitId=$('#massSystemAdminHospital').find('option:selected').val();
	
	$.ajax({
		url : "submitUnitAdmin",
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1',
			'serviceNo':serviceNo,
			'unitId' : unitId,
			'adminFlagValue': 'S',
			'selectedUnitId':selectedUnitId
		}),
		contentType : "application/json",
		type : "POST",
		
		success : function(response) {
			if(response.status=="success"){
				$('#errordiv').empty("");
				alert(""+resourceJSON.msgForUnitAdminCreateNormalUser+'S');
				reSetUnitAdmin();
				
				//$('#messForSysUserTranstion').append(""+resourceJSON.msgForUnitAdminCreateNormalUser);
				//$('#messForSysUserTranstion').show();	
			}
			if(response.status=="fail"){
				$('#errordiv').empty("");
				if(response.adminFlag=="U"){
					alert("User is already exist. Which has created by Unit Admin.");
				}
				else{
				alert(""+resourceJSON.msgForUnitAdminAlreadyExistNormalUser);
				}
				//$('#errordiv').append(""+resourceJSON.msgForUnitAdminAlreadyExistNormalUser);
				//$('#errordiv').show();
				$("#btnActiveUnitAdmin").attr("disabled", true);
				reSetUnitAdmin();
			}
			
			getAllUnitAdminDetail("ALL","SearchStatusForUnitAdmin");
			
			//getUnitAdminDetail();
			
		}
	});
	
}

 


function getUnitAdminDetail(userList){
			var htmlTable="";
			var statusActive="y";
			var statusDeActive="n";
			if(userList!=null && userList!="" && userList.length!=0){
			for(i=0;i<userList.length;i++)
			{htmlTable = htmlTable+"<tr>";	
			var serviceNoo="";
			if(userList[i].serviceNo!=null&& userList[i].serviceNo!=undefined&& userList[i].serviceNo!="")
			serviceNoo=userList[i].serviceNo;

					htmlTable = htmlTable +"<td style='width: 80px;'>"+serviceNoo+"</td>";			
					htmlTable = htmlTable +"<td style='width: 120px;'>"+userList[i].firstName+"</td>";
					htmlTable = htmlTable +"<td >"+userList[i].unitName+"</td>";
					
					htmlTable = htmlTable +"<td style='width: 100px;'>"+userList[i].designamtionName+"</td>";
					htmlTable = htmlTable +"<td style='width: 100px;'>"+userList[i].roleNames+"</td>";
					var status="";
					if(userList[i].status=='y'){
						status="Active";
					}
					else{
						status="Inactive";
					}
					
					htmlTable = htmlTable +"<td style='width: 100px;'>"+status+"</td>";
					if(userList[i].status=='n'){
					htmlTable += '<td style="width: 100px;"><button name="Button" type="button"';
					htmlTable += '	class="buttonAdd btn btn-primary" value="" onclick="activateDeActivatUser( '+userList[i].userId+ ',\''+statusActive+'\');"';
					htmlTable += '	tabindex="1" >Activate </button></td>';
					}
					else{
					htmlTable += '<td style="width: 100px;"><button name="Button" type="button"';
					htmlTable += '	class="buttonAdd btn btn-primary" value="" onclick="activateDeActivatUser( '+userList[i].userId+',\''+statusDeActive+'\');"';
					htmlTable += '	tabindex="1" >Deactivate</button></td>';
					htmlTable = htmlTable+"</tr>";
					}
					}
			}
			else{
				htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";
			}
				
				$('#tblOfSystemAdmin').html(htmlTable);
}



function activateDeActivatUser(userId,status){
	$.ajax({
		url : "activateDeActivatUser",
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1',
			'userId':userId,
			'status' : status
		}),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
			getAllUnitAdminDetail('ALL',"SearchStatusForUnitAdmin");
		}
	});
	
}


function submitMasDesignation(){
	var countForDesignation=0;
	try{
		$("#designationUnitForAdmin").attr("disabled","disabled");
		}
		catch(e){}
	//var unitId=$('#massSystemAdminHospitalForDesignation').find('option:selected').val();
		var unitId=$('#miRoomDesi').find('option:selected').val();
	var userId=$('#userId').val();
	var masdesigationId=document.getElementById('attachContactTypeAdduser');
	var masDesigationIdValues="";
	for(var i=0;i<masdesigationId.options.length;i++){
		masDesigationIdValues+=masdesigationId.options[i].value+",";
	}
	 var masDesigtionMappingId=$('#masDesignationMappingId').val();
	if(unitId==""){
		alert("Please Select MI Room.");
		try{
			$("#designationUnitForAdmin").attr("disabled",false);
			}
			catch(e){}
			return false;
	}
	if(masDesigationIdValues==""){
		alert("Please Select Designation.");
		try{
			$("#designationUnitForAdmin").attr("disabled",false);
			}
			catch(e){}
		return false;
		}
	 
	$.ajax({
		url : "submitMasDesignation",
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1',
			'unitId':unitId,
			'massDesignationValue' : masDesigationIdValues,
			'masDesigtionMappingId' :masDesigtionMappingId,
			'userId':userId
			 
		}),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
			//getMasDesinationDetail();
			//getUnitAdminDetail();
			if(response!=null && response.status=='success'){
				alert("Data created Successfully"+'S');
				countForDesignation++;
			}
			if(response!=null && response.status=='updateDesi'){
				alert("Data updated Successfully"+'S');
				countForDesignation++;
			}
			
			getAllMasDesinationDetail("ALL","SearchStatusForMassDesignation");
			getAllUnitAdminDetail("ALL","SearchStatusForUnitAdmin")
			getAllMasDesigation()
			getMasHospitalListForAdmin();
			
			 var masdesigationId=document.getElementById('attachContactTypeAdduser');
				if(masdesigationId.options.length!=0)
				for(var i=0;i<masdesigationId.options.length;i++){
					$('#attachContactTypeAdduser').empty("");
				} 
				
				$('#masDesignationMappingId').val("");
				if(countForDesignation>0){
				try{
					$("#designationUnitForAdmin").attr("disabled",false);
					$('#errordiv1').empty();
					}
					catch(e){}
				}
		}
	});
	
}


function getMasDesinationDetail(dataDesignationList){
			var htmlTable="";
			if(dataDesignationList!=null && dataDesignationList.length!=0){
			for(i=0;i<dataDesignationList.length;i++)
			{htmlTable = htmlTable+"<tr>";	
			
					htmlTable = htmlTable +"<td  style='width: 250px;'>"+dataDesignationList[i].unitName+"</td>";
					htmlTable = htmlTable +"<td>"+dataDesignationList[i].designamtionName+"</td>";
					var status="";
					if(dataDesignationList[i].status=='y'){
						status="Active";
					}
					else{
						status="Inactive";
					}
					htmlTable = htmlTable +"<td style='width: 100px;'>"+status+"</td>";
					
					htmlTable += '<td  style="width: 80px;"><button name="Button" type="button"';
					htmlTable += '	class="buttonAdd btn btn-primary" value="" onclick="editDesignation('+dataDesignationList[i].masId+');"';
					htmlTable += '	tabindex="1" >Edit </button></td>';
					htmlTable = htmlTable+"</tr>";
					}
			}
			else{
				htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";
			}
				$('#tblOfDesignation').html(htmlTable);
}


function editDesignation(massId){
	try{
		$("#designationUnitForAdmin").attr("disabled","disabled");
		}
		catch(e){}
	$.ajax({
		url : "editDesignation",
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1',
			'massIdValue' : massId
		}),
		contentType : "application/json",
		type : "POST",
		success : function(data) {
			var dataDesignationObjList=data.listDataDesignation;
			var internalHospitalList="";
			var masDesignationSelectedValue="";
			var hospitalId="";
			var unitCode=dataDesignationObjList[0].unitCode;
			if(dataDesignationObjList.status!=0){
				try{
					$("#designationUnitForAdmin").attr("disabled",false);
					}
					catch(e){}
				for(i=0;i<dataDesignationObjList.length;i++){
					var desinationIdArray=dataDesignationObjList[i].designationId.split(",");
					var desinationNameArray=dataDesignationObjList[i].designamtionName.split(",")
					for(var j=0;j<desinationIdArray.length;j++){
				masDesignationSelectedValue +='<option value="' 
				+  desinationIdArray[j] + '" >' +  desinationNameArray[j]
				+ '</option>'; 
				
					}
			  hospitalId= dataDesignationObjList[i].unitId;
			  $('#masDesignationMappingId').val(dataDesignationObjList[i].masId);
				
			  var designationMappingValue="";
					var designationIdMappingArray=dataDesignationObjList[i].designationMappingId.split(",");
					var designationNameMappingArray=dataDesignationObjList[i].designamtionMappingName.split(",")
						for(var j=0;j<designationIdMappingArray.length;j++){
							designationMappingValue +='<option value="' 
								+  designationIdMappingArray[j] + '" >' +  designationNameMappingArray[j]
								+ '</option>'; 
				}
				
				}
				
			var internalHospitalList = '<option value=""><strong>Select Unit</strong></option>';
			$.each(masHospitalList, function(i, item) {
				var selectValue="";
				if(hospitalId==item.hospitalId){
					selectValue='selected';
				}
				else{
					selectValue='';
				}
				internalHospitalList +='<option '+selectValue+' value="' 
				+ item.hospitalId + '" >' + item.hospitalName
				+ '</option>'; 
			});
			
			//$('#massSystemAdminHospitalForDesignation').html(internalHospitalList);	 
			$('#miRoomDesi').val(unitCode);
			$('#attachContactTypeAdduser').html(masDesignationSelectedValue);
			$('#availableContactTypeAdduser').html(designationMappingValue);
			getMasUnitListByUnitCodeDesi(hospitalId);
			$('#errordiv1').empty("");
			}
		}
	});
	
}

function submitUnitAdminforNormalUser(){
	//var serviceNo=$('#serviceNo').val();
	var countForAmin=0;
	try{
	$("#btnActiveUnitAdmin").attr("disabled","disabled");
	}
	catch(e){}
	var serviceNo=$('#serviceNo').find('option:selected').val();
	var unitId=$('#hospitalId').val();
	var userId=$('#userId').val();
	
	 
	if(serviceNo=="" || serviceNo=='0'){
		alert("Please Select Service Number.");
		try{
		$("#btnActiveUnitAdmin").attr("disabled",false);
		}
		catch(e){}
		return false;
	}
	
	var masdesigationId=document.getElementById('attachContactTypeAdduser');
	var masDesigationIdValues="";
	for(var i=0;i<masdesigationId.options.length;i++){
		masDesigationIdValues+=masdesigationId.options[i].value+",";
	}
	
	var masRoles=document.getElementById('attachContactTypeAdduser1');
	var masRoleIdValues="";
	for(var i=0;i<masRoles.options.length;i++){
		masRoleIdValues+=masRoles.options[i].value+",";
	}
	var userIdValue=$('#userIdValue').val();
	
	 if((masRoleIdValues == undefined || masRoleIdValues == '') && (masDesigationIdValues == undefined || masDesigationIdValues == '')){	
			alert("Please entered at least  Roles or Designation.");
			try{
				$("#btnActiveUnitAdmin").attr("disabled",false);
				}
				catch(e){}
			return;
		}	
	 
	 
	 var selectedUnitId=$('#massSystemAdminHospital1ForUnit').find('option:selected').val();
	$.ajax({
		url : "submitUnitAdmin",
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1',
			'serviceNo':serviceNo,
			'unitId' : unitId,
			'userId' : userId,
			'masDesigationIdValues' : masDesigationIdValues,
			'masRoleIdValues' : masRoleIdValues,
			'adminFlagValue': 'U',
			'userIdValue' :userIdValue,
			'selectedUnitId':selectedUnitId
		}),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
			
			if(response.status=="success"){
				$('#errordiv').val("");
				$('#messForTranstion').empty();
			//	$('#messForTranstion').append(""+resourceJSON.msgForUnitAdminCreateNormalUser);
			//	$('#messForTranstion').show();
				alert(""+resourceJSON.msgForUnitAdminCreateNormalUser+'S');
				reSetNorMalUser();
				countForAmin++;
			}
			 
		if(response.status=="updateSuccess"){
			$('#errordiv').val("");
			$('#messForTranstion').empty();
			//$('#messForTranstion').append(""+resourceJSON.msgForUnitAdminUpdateNormalUser);
			//$('#messForTranstion').show();	
			alert(""+resourceJSON.msgForUnitAdminUpdateNormalUser+'S');
			reSetNorMalUser();
			countForAmin++;
		}
		
		if(response.status=="fail"){
			 
			$('#errordiv').val("");
			//$('#errordiv').append(""+resourceJSON.msgForUnitAdminAlreadyExistNormalUser);
			//$('#errordiv').show();	
			
			if(response.adminFlag=="S"){
				alert("User is already exist. Which has created by System Admin.");
			}
			else{
				alert(""+resourceJSON.msgForUnitAdminAlreadyExistNormalUser);
			}
			reSetNorMalUser();
			//document.getElementById("serviceNo").focus();
			countForAmin++;
		}
		if(countForAmin>0){
		try{
			$("#btnActiveUnitAdmin").attr("disabled", false);
			}
			catch(e){}
		}
			//getUnitAdminDetailForNormalUser();
		getAllUnitAdminDetailForNormalUser("ALL","SearchStatusForUnitAdminNorUser");
		}
	});
	
}


function getMasDesinationDetailForUnitAdminNormalUser(){
	var unitId=$('#hospitalId').val();
	var userId=$('#userId').val();
	
	$.ajax({
		url : "getMasDesinationDetail",
		dataType : "json",
		data : JSON.stringify({
			'adminFlagValue' : 'U',
			'unitId':unitId,
			'userId':userId
			 }),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
					
			var dataDesignationObjList=response.dataDesignationList;
			masDesignationGlobal=dataDesignationObjList;
			var masDesignationSelectedValue="";
			if(dataDesignationObjList!=null && dataDesignationObjList!=undefined && dataDesignationObjList.length!=0)
			for(var i=0;i<dataDesignationObjList.length;i++){
				
				var desinationIdArray=dataDesignationObjList[i].designationId.split(",");
				var desinationNameArray=dataDesignationObjList[i].designamtionName.split(",")
				//user for remove designation
				masDesignationGlobal=desinationIdArray;
				for(var j=0;j<desinationIdArray.length;j++){
						masDesignationSelectedValue +='<option value="' 
								+  desinationIdArray[j] + '" >' +  desinationNameArray[j]
							+ '</option>'; 
				}
				$('#masDesignationMappingId').val(dataDesignationObjList[i].masId);
			}
				
			$('#availableContactTypeAdduser').html(masDesignationSelectedValue);
			$('#availableContactTypeAdduser').show();
		}
	});
}



 

function getUnitAdminMasRole(){
	var unitId=$('#hospitalId').val();
	var userId=$('#userId').val();
	$.ajax({
				url : "getUnitAdminMasRole",
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'adminFlgValue' : 'U',
					'unitId':unitId,
					'userId':userId
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.listMasRole;
					var internalHospitalList = "";
					$.each(datas, function(i, item) {
						internalHospitalList +='<option value="' 
						+ item.roleId + '" >' + item.roleName
						+ '</option>'; 
					});
					$('#availableContactTypeAdduser1').html(internalHospitalList);
								  
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
}
function getUnitAdminDetailForNormalUser(userList){
			var htmlTable="";
			var statusActive="y";
			var statusDeActive="n";
			if(userList!=null){
			for(i=0;i<userList.length;i++)
			{htmlTable = htmlTable+"<tr>";	
			var serviceNoo="";
						if(userList[i].serviceNo!=null&& userList[i].serviceNo!=undefined&& userList[i].serviceNo!="")
						serviceNoo=userList[i].serviceNo;
						
					htmlTable = htmlTable +"<td style='width: 80px;'>"+serviceNoo+"</td>";			
					htmlTable = htmlTable +"<td style='width: 150px;'>"+userList[i].firstName+"</td>";
					
					htmlTable = htmlTable +"<td style='width: 120px;'>"+userList[i].designamtionName+"</td>";
					
					htmlTable = htmlTable +"<td style='width: 120px;'>"+userList[i].roleNames+"</td>";
					
					 
					var status="";
					if(userList[i].status=='y'){
						status="Active";
					}
					else{
						status="Inactive";
					}
					var diasableFlag="";
					
					if(userList[i].roleNames!=null && userList[i].roleNames!="" && userList[i].roleNames=='UNIT ADMIN'){
						diasableFlag='disabled';
					}
					else{
						diasableFlag='';
					}
					
					htmlTable = htmlTable +"<td style='width: 150px;'>"+status+"</td>";
					 
					htmlTable += '<td  style="width: 80px;"><button name="Button" type="button"';
					htmlTable += '	class="buttonAdd btn btn-primary" value="" onclick="editUnitAdminUser('+userList[i].userId+',\''+statusDeActive+'\');"';
					htmlTable += '	tabindex="1" >Edit </button></td>';
					 
					if(userList[i].status=='n'){
						htmlTable += '<td style="width: 80px;"><button name="Button" type="button"';
						htmlTable += '	class="buttonAdd btn btn-primary" value="" '+diasableFlag+' onclick="activateDeActivatUnitUser( '+userList[i].userId+ ',\''+statusActive+'\');"';
						htmlTable += '	tabindex="1" >Activate </button></td>';
						}
						else{
						htmlTable += '<td style="width: 80px;"><button name="Button" type="button"';
						htmlTable += '	class="buttonAdd btn btn-primary" value="" '+diasableFlag+' onclick="activateDeActivatUnitUser( '+userList[i].userId+',\''+statusDeActive+'\');"';
						htmlTable += '	tabindex="1" >Deactivate </button></td>';
						htmlTable = htmlTable+"</tr>";
						}
					
					htmlTable += '<td style="display:none"><input  type="hidden" value="'
						+ userList[i].designationId + '" name="designationIdValue" ';
					htmlTable += ' id="designationIdValue'+i+'" size="6"';
					htmlTable += ' class="form-control"/>';
					htmlTable += '</td>';
					
					htmlTable += '<td style="display:none"><input  type="hidden" value="'
						+ userList[i].rolesId + '" name="rolesId" ';
					htmlTable += ' id="rolesId'+i+'" size="6"';
					htmlTable += ' class="form-control"/>';
					htmlTable += '</td>';
					
					
					htmlTable += '<td style="display:none"><input  type="hidden" value="'
						+ userList[i].userId + '" name="userId" ';
					htmlTable += ' id="userId'+i+'" size="6"';
					htmlTable += ' class="form-control"/>';
					htmlTable += '</td>';
					htmlTable = htmlTable+"</tr>";
					 
					}
			}
			else{
				htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";
			}
			
				$('#tblOfUnitAdmin').html(htmlTable);
}

var listUser=""
var masDesignationSelectedValue="";
var masRolesValue="";
var serviceNo="";
var desinationIdArray="";
var rolesIdIdArray="";
var masDesignationList="";
var count=0;
function editUnitAdminUser(userId){
	$('#errordiv').empty("");
	$('#messForTranstion').empty("");
	var unitId=$('#hospitalId').val();
	$.ajax({
		url : "editUnitAdminUser",
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1',
			'userId' : userId,
			'unitId' :unitId
		}),
		contentType : "application/json",
		type : "POST",
		success : function(data) {
			  listUser=data.listUserData;
			  masDesignationSelectedValue="";
			  masRolesValue="";
			  serviceNo="";
			  desinationIdArray="";
			  rolesIdIdArray="";
			  masDesignationList="";
			  count=0;
			try{
				var unitIdForUnitA=data.unitIdForUnitA;
				var unitCodeVal=data.unitCodeVal;
				var unitIdForUnitASele=data.selectUnitId;
				if(unitIdForUnitASele!="" && unitIdForUnitASele!=undefined && unitIdForUnitASele!=null)
				$('#massSystemAdminHospital1ForUnit').val(unitIdForUnitASele);
				//document.getElementById("massSystemAdminHospital1ForUnit").focus();
				getAllServiceByUnitId('us',listUser);
				 
				setTimeout(getValueAccoTime, 6000);
				
			}
			catch (e) {
				console.log(e);
			}
			
		}
	});
	
}

function getValueAccoTime(){
	
	if(listUser.status!=0){
		/*serviceNo=listUser[0].serviceNo;
		
		if(serviceNo!=null){
			actionSelectedSA(serviceNo);
		}*/
		
		
		for(i=0;i<listUser.length;i++){
			if(listUser[i].designationId!=""){
			  desinationIdArray=listUser[i].designationId.split(",");
			var desinationNameArray=listUser[i].designamtionName.split(",")
		
			for(var j=0;j<desinationIdArray.length;j++){
				masDesignationSelectedValue +='<option value="' 
					+  desinationIdArray[j] + '" >' +  desinationNameArray[j]
				+ '</option>'; 
			}
			}
			if(listUser[i].rolesId!=""){
			var rolesIdIdArray=listUser[i].rolesId.split(",");
			var rolesNameArray=listUser[i].roleNames.split(",")
			
			for(var j=0;j<rolesIdIdArray.length;j++){
				masRolesValue +='<option value="' 
				+  rolesIdIdArray[j] + '" >' +  rolesNameArray[j]
				+ '</option>'; 
					}
			}
			
			
			
			if(listUser[i].designationMappingId!=""){
				
				var desinationIdMappingArray=listUser[i].designationMappingId.split(",");
				var desinationNameMappingArray=listUser[i].designamtionMappingName.split(",")
			var masDesignationMappingValue="";
				for(var j=0;j<desinationIdMappingArray.length;j++){
					masDesignationMappingValue +='<option value="' 
						+  desinationIdMappingArray[j] + '" >' +  desinationNameMappingArray[j]
					+ '</option>'; 
				}
				}
			
			var masRoleMappingValue="";
			
			if(listUser[i].rolesMappingId!=""){
				
				var roleIdMappingArray=listUser[i].rolesMappingId.split(",");
				var roleNameMappingArray=listUser[i].roleMappingNames.split(",")
				for(var j=0;j<roleIdMappingArray.length;j++){
					masRoleMappingValue +='<option value="' 
						+  roleIdMappingArray[j] + '" >' +  roleNameMappingArray[j]
					+ '</option>'; 
				}
				}
			
			
			$('#userIdValue').val(listUser[i].userId);
			$('#rolesId').val(listUser[i].rolesId);
			
			
		}
		//$('#serviceNo').val(serviceNo);
		//document.getElementById("serviceNo").focus();
		
	if(masDesignationMappingValue!=""){	
	$('#availableContactTypeAdduser').html(masDesignationMappingValue);
	}
	else{
		getMasDesinationDetailForUnitAdminNormalUser();
	}
	if(masRoleMappingValue!=""){
		$('#availableContactTypeAdduser1').html(masRoleMappingValue);	
	}
	else{
		getUnitAdminMasRole();
	}
	
	$('#attachContactTypeAdduser').html(masDesignationSelectedValue);
	$('#attachContactTypeAdduser1').html(masRolesValue);
	
	//getUnitAdminMasRole();
	//getMasDesinationDetailForUnitAdminNormalUser()
	}
}


function actionSelectedSA(statusValue){
	var selectObj = document.getElementById("serviceNo");
	if(selectObj!=null && selectObj!=""){
    for (var i = 0; i < selectObj.options.length; i++) {
    		if (selectObj.options[i].value== statusValue) {
                selectObj.options[i].selected = true;
                return;
    		}
    		}
		}
	}
	
function activateDeActivatUnitUser(userId,status){
	$.ajax({
		url : "activateDeActivatUser",
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1',
			'userId':userId,
			'status' : status
		}),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
			//getUnitAdminDetailForNormalUser();
			getAllUnitAdminDetailForNormalUser("ALL","SearchStatusForUnitAdminNorUser");
		}
	});
	
}

function reSetUnitAdmin(){
	//$('#serviceNo').val("");
	getAllServiceByUnitId('s');
	$('#userName').val("");
	$('#gender').val("");
	$('#rank').val("");
	getMasHospitalListForAdmin();
	$('#errordiv').empty("");
	$('#messForSysUserTranstion').empty("");
	
}
function reSetNorMalUser(){	
	
	//$('#serviceNo').val("");
	getAllServiceByUnitId('u');
	getAllServiceByUnitId('us');
	$('#userName').val("");
	$('#gender').val("");
	$('#rank').val("");
	

	
	$('#errordiv').empty("");
	$('#messForTranstion').empty("");
	$('#userIdValue').val("");
	var masdesigationId=document.getElementById('attachContactTypeAdduser');
	if(masdesigationId.options.length!=0)
	for(var i=0;i<masdesigationId.options.length;i++){
		$('#attachContactTypeAdduser').empty("");
	}
	
	var masRoles=document.getElementById('attachContactTypeAdduser1');
	var masRoleIdValues="";
	for(var i=0;i<masRoles.options.length;i++){
		$('#attachContactTypeAdduser1').empty("");
	}

	getMasDesinationDetailForUnitAdminNormalUser();
	getUnitAdminMasRole();
	$('#userName').val("");
	$('#gender').val("");
	$('#rank').val("");
}
function resetWhenUserNotExist(){
	$('#userName').val("");
	$('#gender').val("");
	$('#rank').val("");
	
	$('#userName').val("");
	$('#gender').val("");
	$('#rank').val("");
}

	
	
	
	function validateDesignation(){
		//var unitId=$('#massSystemAdminHospitalForDesignation').find('option:selected').val();
		var unitId=$('#miRoomDesi').find('option:selected').val();
		
		$.ajax({
					url : "getMasDesigationForUnitId",
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'adminFlgValue' : 'S',
						'unitId':unitId
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						var statusSuccess = response.statusSuccess;
					 if(statusSuccess=='scuucess'){
						 $('#errordiv1').empty();
						 $('#errordiv1').html("Designation already assigned with unit.");
						$('#errordiv1').show();
						errorFunctionHold("errordiv1");	
						try{
							$("#designationUnitForAdmin").attr("disabled","disabled");
							}
							catch(e){}
						
						//getMasHospitalListForAdmin();
						
						var masDesignationValue=document.getElementById('attachContactTypeAdduser');
						for(var i=0;i<masDesignationValue.options.length;i++){
							$('#attachContactTypeAdduser').empty("");
						}
					 }
					 else{
							$('#errordiv1').empty("");
							try{
								$("#designationUnitForAdmin").attr("disabled",false);
								}
								catch(e){}
								getAllMasDesigation();
								var masDesignationValue=document.getElementById('attachContactTypeAdduser');
								for(var i=0;i<masDesignationValue.options.length;i++){
									$('#attachContactTypeAdduser').empty("");
								}
					 }
									  
					},
					error : function(e) {

						console.log("ERROR: ", e);

					},
					done : function(e) {
						console.log("DONE");
						alert("success");
						var datas = e.data;

					}
				});
	}

	function errorFunctionHold(errorDiv){
		setTimeout(function(){
		    document.getElementById(""+errorDiv).innerHTML = '';
		}, 4000);
	}
	
	
	function getAllUnitAdminDetail(MODE,className)
	 {
	 	
	 	var userId = $('#userId').val();
	 	var unitId = $('#hospitalId').val();
	 	 if(MODE == 'ALL'){
	 		 
	 			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':unitId,'adminFlagValue':'S','searchService':''};			
	 		}
	 	else
	 		{
	 			var data =  {'pageNo':nPageNo, 'adminFlagValue':'S','userId':userId,'unitId':unitId,'searchService':''}; 
	 		} 
	 	var url = "getUnitAdminDetail";
	 	var bClickable = true;
	 	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,'unitAdminGrid','resultnavigation');
	 }
	
	
	
	function makeTableCommon(jsonData,flagCheck)
	 {
		 if(flagCheck=="unitAdminGrid"){
		 var userList = jsonData.dataUserList;
		 getUnitAdminDetail(userList);
		 }
		 
		if(flagCheck=="masDesignationGrid"){
			var dataDesignationList  = jsonData.dataDesignationList;
			getMasDesinationDetail(dataDesignationList)
		 }
		 
		if(flagCheck=="unitAdminForNormalUser"){
			var dataUserList  = jsonData.dataUserList;
			getUnitAdminDetailForNormalUser(dataUserList)
		 }
		
	 }
	
	 function showResultPage(pageNo,flagCheck)
	 {
	 	nPageNo = pageNo;	
	 	if(flagCheck=="unitAdminGrid"){
	 	getAllUnitAdminDetail('FILTER',"SearchStatusForUnitAdmin");
	 	}
	 	
	 	if(flagCheck=="masDesignationGrid"){
	 		getAllMasDesinationDetail('FILTER',"SearchStatusForMassDesignation");
		 	}
	 	
	 	if(flagCheck=="unitAdminForNormalUser"){
	 		getAllUnitAdminDetailForNormalUser('FILTER',"SearchStatusForUnitAdminNorUser");
	 	}
	 }

	 function getAllMasDesinationDetail(MODE,className)
	 {
	 	
	 	var userId = $('#userId').val();
		var unitId = $('#hospitalId').val();
	 		 
	 	 if(MODE == 'ALL'){
	 		 
	 			var data = {'pageNo':nPageNo,'userId' : userId,'unitId':unitId,'adminFlagValue' : 'S'};			
	 		}
	 	else
	 		{
	 			var data =  {'pageNo':nPageNo,'adminFlagValue':'S','userId':userId,'unitId':unitId}; 
	 		} 
	 	var url = "getMasDesinationDetail";
	 	var bClickable = true;
	 	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"masDesignationGrid","resultnavigationMasDesignation");
	 }
	 
	 function getAllUnitAdminDetailForNormalUser(MODE,className)
	 {
			var unitId = $('#hospitalId').val();
			var userId = $('#userId').val();
	 	 if(MODE == 'ALL'){
	 		 
	 			var data = {'pageNo':nPageNo,'userId' : userId, 'adminFlagValue' : 'U','unitId':unitId,'serviceNumber':''};			
	 		}
	 	else
	 		{
	 			var data =  {'pageNo':nPageNo,'adminFlagValue':'U','userId':userId, 'unitId':unitId,'serviceNumber':''}; 
	 		} 
	 	var url = "getUnitAdminDetail";
	 	var bClickable = true;
	 	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"unitAdminForNormalUser","resultnavigation");
	 }
	 
	 function getAllServiceByUnitId(flag,listUser){
		 var selectedValue="";
		 if(flag=='s'){
		  selectedValue=$( "#massSystemAdminHospital option:selected" ).val();
		 }
		 else if(flag=='us'){
			 selectedValue=$("#massSystemAdminHospital1ForUnit option:selected" ).val();
		 }
		 else{
			 selectedValue=$('#hospitalId').val();
		 }
		 if(selectedValue!='0'){
		$.ajax({
				url : "getAllServiceByUnitId",
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'unitId':selectedValue,
					'flag':flag
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					var datas = response.listMasEmployee;
					var seviceList= '<select class="form-control" id="serviceNo" name="serviceNo" tabindex="1" onFocus="return getMasEmployeeDetail(u)" onChange="return getMasEmployeeDetail(u);">'
					  seviceList+= '<option value="0"><strong>Select</strong></option>';
					if(datas!=null && datas.length>0){
						var serviceNo="";
						if(listUser!=undefined && listUser!=null && listUser!=""){
						  serviceNo=listUser[0].serviceNo;
						}
					for(var j=0;j<datas.length;j++){
						var systemSelectedVal="";
						if(serviceNo!="" && datas[j].serviceNo==serviceNo){
							systemSelectedVal='selected';
						}
						else{
							systemSelectedVal="";
							 
						}
						seviceList +='<option '+systemSelectedVal+' value="' 
							+  datas[j].serviceNo + '" >' +  datas[j].serviceNo +" "+datas[j].empName+'</option>'; 
					} 
					}
					seviceList +='</select>';
					$('#serviceNo').html(seviceList);
					document.getElementById("serviceNo").focus();
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
	 }
	 }
	 
	 var masHospitalList="";
	 function getMasHospitalListForUnitAdmin(){
	 var hospitalId=$('#hospitalId').val();
	 var slectedValueUnitcode="";
		 $.ajax({
	 				url : "getMasHospitalListForAdmin",
	 				dataType : "json",
	 				data : JSON.stringify({
	 					'employeeId' : '1'
	 				}),
	 				contentType : "application/json",
	 				type : "POST",
	 				success : function(response) {
	 					console.log(response);
	 					var datas = response.data;
	 					masHospitalList=datas;
	 					var miRoomVal="";
	 				//	var internalHospitalList = '<option value=""><strong>Select Unit</strong></option>';
	 					miRoomVal='<option value=""><strong>Select Unit</strong></option>';
	 					var systemSelectedVal="";
	 					var disableVal="";
	 					
	 					$.each(datas, function(i, item) {
	 						//alert("hospitalId>>>>>>.."+hospitalId);	
	 						//alert("item.hospitalId>>>>>>>>>>>"+item.hospitalIdForU);	
	 						if(item.hospitalIdForU==hospitalId){
	 							
								systemSelectedVal='selected';
								disableVal='disabled';
								slectedValueUnitcode=item.unitCode;
							}
							else{
								systemSelectedVal="";
								disableVal="";
							}
	 						miRoomVal +='<option '+systemSelectedVal+' value="' 
	 							+ item.unitCode + '"  '+disableVal+' >' + item.hospitalName
	 							+ '</option>'; 
	 					});
	 					
	 					
	 					$('#miRoom').html(miRoomVal);
	 					getMasUnitListByUnitCodeFroSelected(slectedValueUnitcode);
	 				},
	 				error : function(e) {

	 					console.log("ERROR: ", e);

	 				},
	 				done : function(e) {
	 					console.log("DONE");
	 					alert("success");
	 					var datas = e.data;

	 				}
	 			});
	 }

	 var masHospitalList="";
	 function getMasUnitListByUnitCodeFroSelected(slectedValueUnitcode){
	 	
	 	var unitCodeVal=slectedValueUnitcode;
	 	if(unitCodeVal==""){
	 		alert("Please select MI Room.");
	 		return false;
	 	}
	 	$.ajax({
	 				url : "getMasUnitListByUnitCode",
	 				dataType : "json",
	 				data : JSON.stringify({
	 					'employeeId' : '1',
	 					'unitCodeVal':unitCodeVal,
	 					'unitId':unitCodeVal
	 				}),
	 				contentType : "application/json",
	 				type : "POST",
	 				success : function(response) {
	 					console.log(response);
	 					var datas = response.data;
	 					//masHospitalList=datas;
	 					var miRoomVal="";
	 					var unitList = '<option value=""><strong>Select Unit</strong></option>';
	 					for(i=0;i<datas.length;i++){
	 						unitList +='<option value="' 
	 						+ datas[i].unitId + '" >' + datas[i].DESCR
	 						+ '</option>'; 
	 					}
	 					$('#massSystemAdminHospital1ForUnit').html(unitList);
	 					//$('#massSystemAdminHospitalForDesignation').html(unitList);	
	 					
	 					 
	 				},
	 				error : function(e) {

	 					console.log("ERROR: ", e);

	 				},
	 				done : function(e) {
	 					console.log("DONE");
	 					alert("success");
	 					var datas = e.data;

	 				}
	 			});
	 }

	 
	 var masHospitalList="";
	 function getMasUnitListByUnitCodeDesi(hospitalId){
	 	
	 	var unitCodeVal=$('#miRoom').val();
	 	if(unitCodeVal==""){
			unitCodeVal=$('#miRoomDesi').val();
		}
	 	if(unitCodeVal==""){
	 		alert("Please select MI Room.");
	 		return false;
	 	}
	 	$.ajax({
	 				url : "getMasUnitListByUnitCode",
	 				dataType : "json",
	 				data : JSON.stringify({
	 					'employeeId' : '1',
	 					'unitCodeVal':unitCodeVal
	 				}),
	 				contentType : "application/json",
	 				type : "POST",
	 				success : function(response) {
	 					console.log(response);
	 					var datas = response.data;
	 					//masHospitalList=datas;
	 					var miRoomVal="";
	 					var unitList = '<option value=""><strong>Select Unit</strong></option>';
	 					for(i=0;i<datas.length;i++){
	 						var selectUnit="";
	 						if(hospitalId!=undefined && hospitalId!="" && hospitalId!=null){
	 							
	 							if(hospitalId==datas[i].unitId){
	 								selectUnit='selected';
	 							}
	 							else{
	 								selectUnit='';
	 							}
	 						}
	 						unitList +='<option '+selectUnit+' value="' 
	 						+ datas[i].unitId + '" >' + datas[i].DESCR
	 						+ '</option>'; 
	 					}
	 					//$('#massSystemAdminHospital').html(unitList);
	 					$('#massSystemAdminHospitalForDesignation').html(unitList);	
	 					
	 					 
	 				},
	 				error : function(e) {

	 					console.log("ERROR: ", e);

	 				},
	 				done : function(e) {
	 					console.log("DONE");
	 					alert("success");
	 					var datas = e.data;

	 				}
	 			});
	 }

	 
