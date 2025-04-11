
var comboArrayRoles =[];
var comboArrayDesignation = [];
var $j = jQuery.noConflict();
$j(document).ready(function()
		{
		
		GetAllRole();
		getuserDetailsList('FILTER');
		getAllUserType();
		//GetAllDesignation();
		/* GetRoleAndDesignationMappingList(); */
		//getRoleAndDesignationDetails();
		});
		
	
function GetAllRole(){
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getRoleRightsList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value='0'>Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArrayRoles[i] = result.data[i].roleName;
	    		combo += '<option value='+result.data[i].roleId+'>' +result.data[i].roleName+ '</option>';
	    		
	    	}
	    	jQuery('#availableContactTypeAdduser1').append(combo);
	    	//jQuery('#searchRole').append(combo);
	    }
	    
	});
		
}

function GetAllDesignation(){
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getDesignationList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value='0'>Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArrayDesignation[i] = result.data[i].designationName;
	    		combo += '<option value='+result.data[i].designationId+'>' +result.data[i].designationName+ '</option>';	    		
	    	}
	    	jQuery('#availableContactTypeAdduser').append(combo);
	    	/* jQuery('#searchDesignation').append(combo); */
	    }
	    
	});
}

function submitUnitAdminforNormalUser(){
	
	var mobileNo=$('#mobileNo').val();
	if(mobileNo=="" ) {
		createCustomAlert("Please enter mobile number");
    	document.getElementById('mobileNo').focus();
        return false;
      }
	if(mobileNo!="" && mobileNo.length!=10)
	{
		createCustomAlert("Please enter valid mobile number");
    	document.getElementById('mobileNo').focus();
        return false;
	}	
	
	var nameOfUser=$('#nameOfUser').val();
	if(nameOfUser=="" ) {
    	alert("Please enter name of user");
    	document.getElementById('nameOfUser').focus();
        return false;
      }
	
	var emailId=$('#emailId').val();
	if(emailId=="" ) {
    	alert("Please enter email Id");
    	document.getElementById('emailId').focus();
        return false;
      }
	if(emailId!="" ) {
		validateEmail(emailId) 
      }
	
	
	
	var userTypesId=document.getElementById('appendUserTypesSelect');
	
	
	var appendUserTypesIdValues="";
	for(var i=0;i<userTypesId.options.length;i++){
		appendUserTypesIdValues+=userTypesId.options[i].value+",";
	}
	var typUsr=$('#levelUsers').val()
	if(typUsr=="")
	{
		alert("Please select level of user")
		return false;
	}
	if(appendUserTypesIdValues=="" && typUsr=="D")
	{
		alert("Please select Disrict Type")
		return false;
	}	
	if(appendUserTypesIdValues=="" && typUsr=="C")
	{
		alert("Please select City Type")
		return false;
	}
	if(appendUserTypesIdValues=="" && typUsr=="M")
	{
		alert("Please select MMU Type")
		return false;
	}
	if(appendUserTypesIdValues=="" && typUsr=="S")
	{
		alert("Please select State Type")
		return false;
	}
	var masRoles=document.getElementById('attachContactTypeAdduser1');
	
	var masRoleIdValues="";
	for(var i=0;i<masRoles.options.length;i++){
		masRoleIdValues+=masRoles.options[i].value+",";
	}
	
	 if((masRoleIdValues == undefined || masRoleIdValues == '')){	
			alert("Please entered at least  Roles or Designation.");
			return;
		}
	 
	 var e = document.getElementById("getAllUserType");
	 var getAllUserTypeValue = e.value;
	 
	 if(getAllUserTypeValue==undefined || getAllUserTypeValue == '')
	 {
		 alert("Please select type of users");
		return; 
	 } 
	 
	 $("#btnSubit").attr("disabled", true);
	 var updateValForUser=$('#userTypeIdUpdate').val();
	 var urlPath="";
	if(updateValForUser!=null && updateValForUser!="" && updateValForUser!=undefined){
	    urlPath="updateUsersRegistartionType";
	    var formData = new FormData(document.getElementById("userDetailForm"));
     	formData.append('userId', updateValForUser);
     	formData.append('userTypeValues', appendUserTypesIdValues);
     	formData.append('masRoleIdValues', masRoleIdValues);
     	formData.append('mobileNo', $('#mobileNo').val());
     	formData.append('nameOfUser', $('#nameOfUser').val());
     	formData.append('emailId', $('#emailId').val());
     	formData.append('employeeId', $('#employeeId').val());
     	formData.append('levelUsers', $('#levelUsers').val());
     	formData.append('userTypeVal', getAllUserTypeValue);

     	$.ajax({
     		url : urlPath,
     		dataType : "json",
     		data : formData,
     		contentType : false,
     		enctype: 'multipart/form-data',
     		processData: false,
     		crossDomain:true,
     		type : "POST",
     		success : function(response) {
     			actionUserResponse(response);
     		}
     	});
	}
	else {
	    urlPath="submitRoleAndTypeOfUsers";
	    $.ajax({
            url : urlPath,
            dataType : "json",
            data : JSON.stringify({
                'userId':updateValForUser,
                'userTypeValues' : appendUserTypesIdValues,
                'masRoleIdValues' : masRoleIdValues,
                'mobileNo': $('#mobileNo').val(),
                'nameOfUser': $('#nameOfUser').val(),
                'emailId': $('#emailId').val(),
                'employeeId': $('#employeeId').val(),
                'levelUsers': $('#levelUsers').val(),
                'userTypeVal':getAllUserTypeValue
            }),
            contentType : "application/json",
            type : "POST",
            success : function(response) {
                actionUserResponse(response);
            }
        });
	}

	function actionUserResponse(response){
	    if(response.status=="success"){
             $('#messageForCreate').show();
             $('.modal-backdrop').show();
        }
        if(response.status=="statusUpdated"){
             $('#messageForUpdate').show();
             $('.modal-backdrop').show();
        }

        if(response.status=="updateSuccess"){
            $('#errordiv').val("");
            $('#messForTranstion').append(""+resourceJSON.msgForUnitAdminUpdateNormalUser);
            $('#messForTranstion').show();
        }

        if(response.status=="fail"){
            alert(response.msg);
        }
        $("#btnSubit").attr("disabled", false);
	}
	
	function getRoleAndDesignationDetails(){
		
		$.ajax({
			url : "getMultipleRoleAndDesignation",
			dataType : "json",
			data : JSON.stringify({ }),
			contentType : "application/json",
			type : "POST",
			success : function(response) {
						
				var dataList=response.dataUserList;
				var htmlTable="";
				var statusActive="y";
				var statusDeActive="n";
				for(i=0;i<dataList.length;i++)
				{
					htmlTable = htmlTable+"<tr>";	
						
						htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].designamtionName+"</td>";
						
						htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].roleNames+"</td>";
						
						 
						var status="";
						if(dataList[i].status=='y' || dataList[i].status=='Y'){
							status="Active";
						}
						else{
							status="InActive";
						}
						
						htmlTable = htmlTable +"<td style='width: 150px;'>"+status+"</td>";
						 
						htmlTable += '<td><button name="Button" type="button"';
						htmlTable += '	class="buttonAdd btn btn-primary" value="" onclick="editUnitAdminUser('+dataList[i].designationId+',\''+statusDeActive+'\');"';
						htmlTable += '	tabindex="1" >Edit </button></td>';
						 
						if(userList[i].status=='n'){
							htmlTable += '<td><button name="Button" type="button"';
							htmlTable += '	class="buttonAdd btn btn-primary" value="" onclick="activateDeActivatUnitUser( '+dataList[i].designationId+ ',\''+statusActive+'\');"';
							htmlTable += '	tabindex="1" >Active </button></td>';
							}
							else{
							htmlTable += '<td><button name="Button" type="button"';
							htmlTable += '	class="buttonAdd btn btn-primary" value="" onclick="activateDeActivatUnitUser( '+dataList[i].designationId+',\''+statusDeActive+'\');"';
							htmlTable += '	tabindex="1" >InActive </button></td>';
							htmlTable = htmlTable+"</tr>";
							}
						
						
						htmlTable += '<td style="display:none"><input  type="hidden" value="'
							+ dataList[i].designationId + '" name="designationIdValue" ';
						htmlTable += ' id="designationIdValue'+i+'" size="6"';
						htmlTable += ' class="form-control"/>';
						htmlTable += '</td>';
						
						htmlTable += '<td style="display:none"><input  type="hidden" value="'
							+ dataList[i].rolesId + '" name="rolesId" ';
						htmlTable += ' id="rolesId'+i+'" size="6"';
						htmlTable += ' class="form-control"/>';
						htmlTable += '</td>';
						
					
						htmlTable = htmlTable+"</tr>";
						 
						}
					
					$('#tblListOfRoleAndDesignation').html(htmlTable);
			}
		});

	}
}

function removeOptions(selectElement) {
	   var i, L = selectElement.options.length - 1;
	   for(i = L; i >= 0; i--) {
	      selectElement.remove(i);
	   }
	}

//$(document).delegate("#typeOfUser","change",
function typeChange(val) {
	$('#appendUserTypesSelect').empty();
	var getValue = val;
	if (getValue != 'Dist')
	{	
	document.getElementById('sdcmVal').innerHTML = getValue;
	}
	else
	{
		document.getElementById('sdcmVal').innerHTML = 'District';
	}	
	if (getValue == 'Dist') {
		document.getElementById('levelUsers').value = 'D';
	} else if (getValue == 'City') {
		document.getElementById('levelUsers').value = 'C';
	} else if (getValue == 'MMU') {
		document.getElementById('levelUsers').value = 'M';
	} else if (getValue == 'State') {
		document.getElementById('levelUsers').value = 'S';
	}
	else if (getValue == 'Vendor') {
		document.getElementById('levelUsers').value = 'V';
	}
	//alert("val "+getValue)
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//" + window.location.host + "/"
			+ accessGroup + "/user/getAllUserTypeDataSDCM";

	removeOptions(document.getElementById('userTypesSelect'));
	
	if(getValue!='State')
	{	
	jQuery.ajax({
		crossOrigin : true,
		method : "POST",
		crossDomain : true,
		url : "getAllUserTypeDataSDCM",
		data : JSON.stringify({
			'typeValue' : getValue
		}),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			//alert("success "+result.data.length);
			var combo = "<option value='0'>Select</option>";

			for (var i = 0; i < result.list.length; i++) {
				comboArrayRoles[i] = result.list[i].name;
				combo += '<option value=' + result.list[i].id + '>'
						+ result.list[i].name + '</option>';

			}
			jQuery('#userTypesSelect').append(combo);
			//jQuery('#searchRole').append(combo);
		}

	});
  }else{
	  var combo = '<option value="0">Select</option>';
    	combo = '<option value="1">Chhattisgarh</option>';
    	jQuery('#userTypesSelect').append(combo);
  }
}




function getAllUserType() {
	
	var j=1;
    
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/user/getAllUserTypeForUserReg";
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(msg) {
					if (msg.status == '1') {

						var comboval = "<option value=\"\">Select</option>";
						for (var i = 0; i < msg.data.length; i++) {

							comboval += '<option value=' + msg.data[i].userTypeId + '>'
									+ msg.data[i].userTypeName
									+ '</option>';

						}
						$j('#getAllUserType').append(comboval);

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

function activeInactiveFun(mobileNo,item,userId)
{
	//statusSlider=document.getElementById(item).checked;
	//alert(statusSlider)
	var switchStatus = item;
	var isActiveStatus='';
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/user/activeInactiveUsers";
	
	if (document.getElementById(switchStatus).checked == false) {
       isActiveStatus='inactive'
    	   if (confirm("Do you want to deactivate the user ?")) {
    		   $.ajax({
    				type : "POST",
    				contentType : "application/json",
    				url : url,
    				data : JSON.stringify({
    					'mobileNo' : mobileNo,
    					'userId' :userId,
    					'isActiveStatus':isActiveStatus,
    				}),
    				dataType : 'json',
    				timeout : 100000,
    				beforeSend : function() {
    					$('.ajax-loader').css("visibility", "visible");
    				},
    				success : function(res) {
    					getuserDetailsList('FILTER');
    					console.log("SUCCESS: ", res);
    					var datas = res.msg;
    					if (res.status == '1') {
    						
    							window.location.reload();
    						
    					} else {
    						alert(datas)
    					}
    				},
    				error : function(e) {
    					console.log("ERROR: ", e);
    				},
    				complete : function() {
    					$('.ajax-loader').css("visibility", "hidden");
    				}
    			 });
    	   }
    	   else
    	   {	   
            document.getElementById(switchStatus).checked=true;
    	   }
     }
    else {
           isActiveStatus='active'
    	   if (confirm("Do you want to activate the user ?")) {
    		   $.ajax({
    				type : "POST",
    				contentType : "application/json",
    				url : url,
    				data : JSON.stringify({
    					'mobileNo' : mobileNo,
    					'userId' :userId,
    					'isActiveStatus':isActiveStatus,
    				}),
    				dataType : 'json',
    				timeout : 100000,
    				beforeSend : function() {
    					$('.ajax-loader').css("visibility", "visible");
    				},
    				success : function(res) {
    					getuserDetailsList('FILTER');
    					console.log("SUCCESS: ", res);
    					var datas = res.msg;
    					if (res.status == '1') {
    						
    							window.location.reload();
    						
    					} else {
    						alert(datas)
    					}
    				},
    				error : function(e) {
    					console.log("ERROR: ", e);
    				},
    				complete : function() {
    					$('.ajax-loader').css("visibility", "hidden");
    				}
    			 });
    	   }
    	   else
    	   {	   
              document.getElementById(switchStatus).checked=false; 
    	   }
    }
 }

    var listUser=""
	
	function editUserDetails(userIdVal){
	
		$.ajax({
			url : "editUserDetails",
			dataType : "json",
			data : JSON.stringify({
				'employeeId' : '1',
				'userIdVal' : userIdVal
				
			}),
			contentType : "application/json",
			type : "POST",
			success : function(data) {
				  listUser=data.listUserData;
				  var userName=listUser[0].userName;
				  var loginName=listUser[0].loginName;
				  var levelOfUSers=listUser[0].levelOfUSers;
				  var userId=listUser[0].userId;
				  var emailId=listUser[0].emailId;
				  var userTypeId=listUser[0].userTypeId;
				  var userTypeIdUpdate=listUser[0].userId;
				  var empId=listUser[0].empId;
				
				  document.getElementById('userTypeIdUpdate').value=userTypeIdUpdate;
				  document.getElementById('nameOfUser').value=userName;
				  document.getElementById('mobileNo').value=loginName;
				  document.getElementById('employeeId').value=empId;
				  $("#mobileNo").attr("disabled", "disabled");
				  $('#typeOfUser').val(listUser[0].levelOfUSers);
				  //$("#typeOfUser").attr("disabled", "disabled");
				  if(emailId!=null && emailId!=undefined)
				  {	  
				  document.getElementById('emailId').value=emailId;
				  }
				  $('#getAllUserType').val(listUser[0].userTypeId);
				  typeChange(listUser[0].levelOfUSers);
				  setTimeout(getValueAccoTimeForSelected, 6000);
				  $('#uploadSignatureBlock').show();
				  if(listUser[0].signatureFileName){
				    $('#signatureDownload').attr('title', listUser[0].signatureFileName).css({'color':'green','cursor':'pointer'}).on('click', function(){
				        var url = 'download?key='+listUser[0].userId+'&name='+listUser[0].signatureFileName+'&type=signature';
				        window.location = url;
				    });
				  }
			}
		});
		
	}
    var mmuIdArray='';
    var masMmuSelectedValue='';
    var masRolesValue='';
    
    function getValueAccoTimeForSelected(){
    	
    	if(listUser.status!=0){
    		 removeOptions(document.getElementById('appendUserTypesSelect'));
    		$('#appendUserTypesSelect').empty();
    		console.log('liast cleared');
    		
    		//dropDownAppendUserTypesSelect.remove(dropDownAppendUserTypesSelect.selectedIndex);
    		//$('#appendUserTypesSelect').val="";
        	//$('#attachContactTypeAdduser1').html('');
    		 masMmuSelectedValue='';
    		 masRolesValue='';
    		 for(i=0;i<listUser.length;i++){
    			
    			 if(listUser[0].stateId!="" && listUser[0].stateId!=undefined){
    				var stateIdArray=listUser[0].stateId.split(",");
        			var stateNameArray=listUser[0].stateName.split(",")
        		
        			for(var j=0;j<stateIdArray.length;j++){
        				masMmuSelectedValue +='<option value="' 
        					+  stateIdArray[j] + '" >' +  stateNameArray[j]
        				+ '</option>'; 
        			}
    			}
    			
    			if(listUser[0].mmuId!=""){
    				mmuIdArray=listUser[0].mmuId.split(",");
    			var mmuNameArray=listUser[0].mmuName.split(",")
    		
    			for(var j=0;j<mmuIdArray.length;j++){
    				masMmuSelectedValue +='<option value="' 
    					+  mmuIdArray[j] + '" >' +  mmuNameArray[j]
    				+ '</option>'; 
    			}
    			}
    			if(listUser[0].distId!=""){
    			var	distIdArray=listUser[0].distId.split(",");
    			var distNameArray=listUser[0].distName.split(",")
    		
    			for(var j=0;j<distIdArray.length;j++){
    				masMmuSelectedValue +='<option value="' 
    					+  distIdArray[j] + '" >' +  distNameArray[j]
    				+ '</option>'; 
    			}
    			}
    			
    			if(listUser[0].cityId!=""){
        			var	cityIdArray=listUser[0].cityId.split(",");
        			var cityNameArray=listUser[0].cityName.split(",")
        		
        			for(var j=0;j<cityIdArray.length;j++){
        				masMmuSelectedValue +='<option value="' 
        					+  cityIdArray[j] + '" >' +  cityNameArray[j]
        				+ '</option>'; 
        			}
        			}
    			
    			if(listUser[0].vendorId!=""){
        			var	vendorIdArray=listUser[0].vendorId.split(",");
        			var vendorNameArray=listUser[0].vendorName.split(",")
        		
        			for(var j=0;j<vendorIdArray.length;j++){
        				masMmuSelectedValue +='<option value="' 
        					+  vendorIdArray[j] + '" >' +  vendorNameArray[j]
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
    			
    			$('#userIdValue').val(listUser[i].userId);
    			$('#rolesId').val(listUser[i].rolesId);
    			
    			
    		}
    		//$('#serviceNo').val(serviceNo);
    		//document.getElementById("serviceNo").focus();
    		
    	/*if(masDesignationMappingValue!=""){	
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
    	}*/
    		 console.log('value mmu'+masMmuSelectedValue);
    	$('#appendUserTypesSelect').html(masMmuSelectedValue);
    	$('#attachContactTypeAdduser1').html(masRolesValue);
    	
    	//getUnitAdminMasRole();
    	//getMasDesinationDetailForUnitAdminNormalUser()
    	}
    }
    
   function reloadApplication()
   {
	   window.location.reload();   
   }
    
   function validateEmail(mail) 
   {
    if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail))
     {
       return (true)
     }
       alert("You have entered an invalid email address!")
       return (false)
   }
    
   function getEmployeeDetails(mobileNo){
		
		$.ajax({
			url : "employeeUserDetails",
			dataType : "json",
			data : JSON.stringify({
				'employeeId' : '1',
				'userName' : mobileNo
				
			}),
			contentType : "application/json",
			type : "POST",
			success : function(data) {
				  listUser=data;
				  if(data.userName!=null && data.userName!="")
				  { 
				  var userName=data.userName;
				  var userTypeId=data.typeOfUser;
				  var employeeId=data.empId;
				  				
				  document.getElementById('nameOfUser').value=userName;
				  document.getElementById('getAllUserType').value=userTypeId;
				  document.getElementById('employeeId').value=employeeId;
				  }
				
			}
		});
		
	} 