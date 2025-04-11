var APPOINTMENTTYPE_OPD = "";
var APPOINTMENTTYPE_ME = "";
var APPOINTMENTTYPE_MB ="";
var selfRelationId = "";
var DEPARTMENT_TYPE_ID_MATERNITY = "";
function getDepartmentBloodGroupAndMedicalCategory(){
	
	var deptValues = "";
	var bloodValues = "";
	var categoryValues = "";
	var relationValues = "";
	var stateValues = "";
	var districtValues = "";
	
	
	var hospitalId = $j('#hospitalId').val();
	
	var params = {
			"hospitalId" : hospitalId,
		}
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getDepartmentBloodGroupAndMedicalCategory',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				 var dictionary = response;
				 var deptList=dictionary.departmentList;
				 var bloodGroupList=dictionary.bloodGroupList;
				 var medicalCategoryList=dictionary.medicalCategoryList;
				 var masRelationList=dictionary.masRelationList;
				 var masStateList=dictionary.masStateList;
				 var masDistrictList=dictionary.masDistrictList;
				 
				 for(dept in deptList){
						deptValues += '<option value='+deptList[dept].departmentId+'>'
									+ deptList[dept].departmentName
									+ '</option>';
				 }
				 $j('#departmentId').append(deptValues); 	  
			  
				 
				 for(blood in bloodGroupList){
					 bloodValues += '<option value='+bloodGroupList[blood].bloodGroupId+'>'
									+ bloodGroupList[blood].bloodGroupName
									+ '</option>';
				 }
				 $j('#bloodGroupId').append(bloodValues); 	  
			  
				 
				 for(category in medicalCategoryList){
					 categoryValues += '<option value='+medicalCategoryList[category].medicalCategoryId+'>'
									+ medicalCategoryList[category].medicalCategoryName
									+ '</option>';
				 }
				 $j('#medicalCategoryId').append(categoryValues); 
				 
				 
				 
				 for(relation in masRelationList){
					 relationValues += '<option value='+masRelationList[relation].relationId+'>'
									+ masRelationList[relation].relationName
									+ '</option>';
				 }
				 $j('#nok1RelationId').append(relationValues); 
				 $j('#nok2RelationId').append(relationValues); 
				 $j('#patientRelationId').append(relationValues); 
				 
				
				 for(state in masStateList){
					 stateValues += '<option value='+masStateList[state].stateId+'>'
									+ masStateList[state].stateName
									+ '</option>';
				 }
				 $j('#patientStateId').append(stateValues);  
				 $j('#nok1StateId').append(stateValues); 
				 $j('#nok2StateId').append(stateValues); 
				 
				 for(district in masDistrictList){
					 districtValues += '<option value='+masDistrictList[district].districtId+'>'
									+ masDistrictList[district].districtName
									+ '</option>';
				 }
				 $j('#patientDistrictId').append(districtValues); 
				 $j('#nok1DistrictId').append(districtValues); 
				 $j('#nok2DistrictId').append(districtValues); 
				 
				 var rankValues = "";
				 var rankList=dictionary.rankList;
				 for(rankCount in rankList){
					 rankValues += '<option value='+rankList[rankCount].rankId+'>'
									+ rankList[rankCount].rankName
									+ '</option>';
				 }
				 $j('#rankId').append(rankValues); 
				 
				 
				 var tradeValues = "";
				 var tradeList=dictionary.tradeList;
				 for(tradeCount in tradeList){
					 tradeValues += '<option value='+tradeList[tradeCount].tradeId+'>'
									+ tradeList[tradeCount].tradeName
									+ '</option>';
				 }
				 $j('#tradeId').append(tradeValues); 	 
				 
				 var unitValues = "";
				 var unitList=dictionary.unitList;
				 for(unitCount in unitList){
					 unitValues += '<option value='+unitList[unitCount].unitId+'>'
									+ unitList[unitCount].unitName
									+ '</option>';
				 }
				 $j('#unitId').append(unitValues); 
				 
				 
				 var regionValues = "";
				 var commandList=dictionary.commandList; // region or command are same
				 for(regionCount in commandList){
					 regionValues += '<option value='+commandList[regionCount].commandId+'>'
									+ commandList[regionCount].commandName
									+ '</option>';
				 }
				 $j('#regionId').append(regionValues); 
				 
				 var mStatusValues = "";
				 var maritalStatusList=dictionary.maritalStatusList;
				 for(mStatusCount in maritalStatusList){
					 mStatusValues += '<option value='+maritalStatusList[mStatusCount].mStatusId+'>'
									+ maritalStatusList[mStatusCount].mStatusName
									+ '</option>';
				 }
				 $j('#maritalstarusId').append(mStatusValues); 
				 
				 
				 var religionValues = "";
				 var religionList=dictionary.religionList;
				 for(religionCount in religionList){
					 religionValues += '<option value='+religionList[religionCount].religionId+'>'
									+ religionList[religionCount].religionName
									+ '</option>';
				 }
				 $j('#religionId').append(religionValues); 
				 
				 var officeValues = "";
				 var recordOfficeAddressList=dictionary.recordOfficeAddressList;
				 for(officeCount in recordOfficeAddressList){
					 officeValues += '<option value='+recordOfficeAddressList[officeCount].officeId+'>'
									+ recordOfficeAddressList[officeCount].officeName
									+ '</option>';
				 }
				 $j('#recordofficeId').append(officeValues); 
				 
				
				 var genderValues = "";
				 var genderList=dictionary.genderList;
				 for(genderCount in genderList){
					 genderValues += '<option value='+genderList[genderCount].genderId+'>'
									+ genderList[genderCount].genderName
									+ '</option>';
				 }
				 $j('#genderId').append(genderValues); 
				 
				
				  APPOINTMENTTYPE_OPD = response.appointmentTypeIdOPD;
				  APPOINTMENTTYPE_ME = response.appointmentTypeIdME;
				  APPOINTMENTTYPE_MB =response.appointmentTypeIdMB;
				  selfRelationId = response.selfRelationId;		 
				  DEPARTMENT_TYPE_ID_MATERNITY=response.departmentTypeMaternityId;
				 
			
			},
			error : function(msg) {
				alert("An error has occurred while contacting the server");
			}
		});
}


function getRegistrationAndAppointmentOthers(REGISTRATION_TYPE_NAME){
var hospitalId = $j('#hospitalId').val();
	var params = {
			"hospitalId" : hospitalId,
		}
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : '/MMUWeb/registration/getRegistrationAndAppointmentOthers',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(resonse) {
				 var dictionary = resonse; 
			      var registrationTypeList=dictionary.registrationTypeList;
			    	var registrationValues = "";
			    	 for(registration in registrationTypeList){
			    		if(registrationTypeList[registration].registrationTypeName!=REGISTRATION_TYPE_NAME){
			    			registrationValues += '<option value='+registrationTypeList[registration].registrationTypeId+'>'
								+ registrationTypeList[registration].registrationTypeName
								+ '</option>';
			    		}
			    	 }
			    	 $j('#registrationTypeId').append(registrationValues); 
			      
			    
			    	 var genderList=dictionary.genderList;
			    	 var genderValues = "";
			    	 for(gender in genderList){
			    		genderValues += '<option value='+genderList[gender].administrativeSexId+'>'
			    						+ genderList[gender].administrativeSexName
			    						+ '</option>';
			    	 }
			    	 $j('#genderId').append(genderValues); 
			      
			    	 
			  	 var serviceTypeList=dictionary.serviceTypeList;
			    	 var serviceTypeValues = "";
			    	 for(serviceType in serviceTypeList){
			    		serviceTypeValues += '<option value='+serviceTypeList[serviceType].serviceTypeId+'>'
			    						+ serviceTypeList[serviceType].serviceTypeName
			    						+ '</option>';
			    	 }
			    	 $j('#serviceTypeId').append(serviceTypeValues); 
			       
			    	 
			    	
			      
			    	 var identificationList=dictionary.identificationList;
			    	 var identificationValues = "";
			    	 for(identification in identificationList){
			    		identificationValues += '<option value='+identificationList[identification].identificationTypeId+'>'
			    						+ identificationList[identification].identificationTypetName
			    						+ '</option>';
			    	 }
			    	 $j('#identificationId').append(identificationValues); 
			              
			      
			      
			   var deptList=dictionary.departmentList;
			 	 var deptValues = "";
			 	 for(dept in deptList){
			 			deptValues += '<option value='+deptList[dept].departmentId+'>'
			 						+ deptList[dept].departmentName
			 						+ '</option>';
			 	 }
			 	 $j('#departmentId').append(deptValues); 
			 	 
			 	var relationList=dictionary.relationTypeList;
				  var relValue = "";
				  for(relation in relationList){
				 		relValue += '<option value='+relationList[relation].relationTypeId+'>'
				 						+ relationList[relation].relationTypeName
				 						+ '</option>';
				 	 }
				 	 $j('#relationId').append(relValue); 
			 	 
			 	 
			 	APPOINTMENTTYPE_OPD = resonse.appointmentTypeIdOPD;
			 	
			},error : function(msg) {
				alert("An error has occurred while contacting the server");
			}
		});
}