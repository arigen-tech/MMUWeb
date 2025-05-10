var typingTimer;                //timer identifier
var doneTypingInterval = 500;  //time in ms, 5 second for example
 
var referenceItem = '';
var functionNameGlobal='';
var globalArray1 =null;
var globalArray2 =null;
var globalFlag ='';
var globalURL ='';
var globalURL2 ='';
var opdGlobalFlag ='';
var flagForTakenItem='';
var mouseOverFlag='';
function getNomenClatureList(item,functionName,url1,url2,flag){
	delete flagForTakenItem;
	flagForTakenItem=0;
	globalFlag = flag;
	globalURL =url1;
	globalURL2 =url2;
	functionNameGlobal=functionName;
	var e = window.event;
	var checkKeys = restrictCallingService(e);
	if(checkKeys){
		return;
	}
   referenceItem = item;
   clearTimeout(typingTimer);
   typingTimer = setTimeout(doneTypingNomenclature, doneTypingInterval);
 }
function getOpdNomenClatureList(item,functionName,url1,url2,flag,opdFlag){
	delete flagForTakenItem;
	flagForTakenItem=0;
	globalFlag = flag;
	globalURL =url1;
	globalURL2 =url2;
	opdGlobalFlag=opdFlag;
	functionNameGlobal=functionName;
	var e = window.event;
	var checkKeys = restrictCallingService(e);
	if(checkKeys){
		return;
	}
   referenceItem = item;
   if(opdGlobalFlag!='mouseOver')
   {	   
   clearTimeout(typingTimer);
   typingTimer = setTimeout(doneTypingNomenclature, doneTypingInterval);
   }
   else
	  {
	   getAutocompleteDataForOpd(referenceItem)
	  } 
 }

function doneTypingNomenclature() {
	getAutocompleteData(referenceItem);
 } 

 var nomenclatureArryNew=[];
 var pvmsNumberArryNew=[];
 var dataArrayForNomenClature = [];
 var mainItemReferenceForNomenclature = '';
 var icdArrayValuNew=[];
 function getAutocompleteData(item){
	 mainItemReferenceForNomenclature = item;
	 
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/"
		+ accessGroup +"/"+ globalURL+"/"+globalURL2;
	 var id = item.id;
	 var icgName = $(item).val();
	 var counter = 0;
	 
	var divIdGen=$(item).siblings("div.autocomplete-itemsNew").attr("id");
 	if(icgName == undefined || icgName == ''){
 		 $('#'+divIdGen).empty();
		 $('#'+divIdGen).hide();
 		 return;
 	 }
 	var userId = '';
 	if(globalFlag!="indent" ||globalFlag!="MIitem" ){
 		userId=$('#userId').val();
 	}
 	 var params = {};
 	   
  if(globalFlag!="" && (globalFlag=="dignosis" || globalFlag=="diagnosisForReferal"
	  || globalFlag=="dignosisSHO" || globalFlag=="compositeCategory" || globalFlag=="diagnosisMe" || globalFlag=="diagnosisMe18" || globalFlag=='compositeCategoryForDetail')){
	  flagForTakenItem=1;
	  params = {
  			 'employeeId':userId,
  				"icdName" : icgName,
  	 	}
  	 }
  if(globalFlag!="" && globalFlag=="diagnosismi" ){
	  params = {
			 'employeeId':user_Id,
				"icdName" : icgName,
	 	}
	  flagForTakenItem=1;
	 }
  	if(globalFlag!="" && (globalFlag=="investigation" || globalFlag=="investigationMe" || globalFlag=="investigationMeDg" || globalFlag=="investigationTemplate" || globalFlag=="masterInvestigationMe")){
  		var radioValue=$('#labImaginId').val();
  		params = {
  	 			 'employeeId':userId,
  	 				"icdName" : icgName,
  	 				'mainChargeCode':radioValue,
  	 	 	}
  	 	
  	}
  	
  	if(globalFlag!="" && (globalFlag=="investigationPrinting")){
  		var radioValue=$('#labImaginId').val();
  		params = {
  	 			 'employeeId':userId,
  	 				"icdName" : icgName,
  	 				'mainChargeCode':radioValue,
  	 	 	}
  	 	
  	}
  	
  	if(globalFlag!="" && globalFlag=="numenclature"){
  		var radioValue=$('#labImaginId').val();
  		params = {
  	 			    'employeeId':userId,
  	 				"icdName" : icgName,
  	 				'sectionId':10,
  	 	 	}
  	}
  	
  	
	if(globalFlag!="" && globalFlag=="newNib"){
		var hospitalId=$('#hospitalId').val();
  		params = {
  	 			 'employeeId':userId,
  	 			 "icdName" : icgName,
  	 			'hospitalId': hospitalId
  	 	 	}
  	}
	
	if(globalFlag!="" && globalFlag=="newNibLp"){
		var hospitalId=$('#hospitalId').val();
  		params = {
  	 			 'employeeId':userId,
  	 			 "icdName" : icgName,
  	 			'hospitalId': hospitalId,
  	 			'lpFlag': 'lp'
  	 	 	}
  	}
	
	
	if(globalFlag!="" && globalFlag=="procedureNursing"){
		var defaultProcedureValue=$('#defaultProcedureValue').val();
		var hospitalId=$('#hospitalId').val();
  		params = {
  	 			 'employeeId':userId,
  	 			"icdName" : icgName,
  	 			'nursingType' : defaultProcedureValue
  	 	 	}
  	}
	if(globalFlag!="" && (globalFlag=="formReportUserMan" || globalFlag=="formReportUserManParent" || globalFlag=="updateformReportUserMan")){
		 
  		params = {
  	 			 'employeeId':userId,
  	 			  "icdName" : icgName
  	 			 
  	 	 	}
  	}
	

		if (globalFlag != "" && globalFlag == "store_nomen") {
		var hospitalId = $('#hospitalId').val();
		var itemGroupId = $j('#itemGroupId').val();
		var itemTypeId = $j('#itemTypeId').val();
		var itemSectionId = $j('#itemSectionId').val();
		var itemClassId = $j('#itemClassId').val();
		params = {
			"hospitalId" : hospitalId,
			"itemGroupId" : itemGroupId,
			"itemTypeId" : itemTypeId,
			"itemSectionId" : itemSectionId,
			"itemClassId" : itemClassId,
			"pvmsNo" : '',
			"nomenclturId" : icgName,
		}

	}
	if(globalFlag!="" && (globalFlag=="indent" || globalFlag=="budgetary")){
		
  		params = {
  				'employeeId' : user_id,
  				'flag':"disp",
  				'sectionId':10,
  				"icdName" : icgName
  	 	 	}
  	}
  	if(globalFlag!="" && globalFlag=="MIitem"){
  		params = {
  	 			   'employeeId':user_id,
  	 				"icdName" : icgName,
  	 				'sectionId':10,
  	 				'flag':'MIitem',
  	 	 	}
  	}
		if(globalFlag!="" && (globalFlag=="immunizationFlag" || globalFlag=="immunizationFlagForTem" )){
	  		params = {
	  	 			 'employeeId':userId,
	  	 				"icdName" : icgName,
	  	 				'sectionId':11,
	  	 				'flag':'123',
	  	 	 	}
	  	}	

		if (globalFlag != "" && globalFlag == "store_pvms") {
			var hospitalId = $('#hospitalId').val();
			var itemGroupId = $j('#itemGroupId').val();
			var itemTypeId = $j('#itemTypeId').val();
			var itemSectionId = $j('#itemSectionId').val();
			var itemClassId = $j('#itemClassId').val();
			params = {
				"hospitalId" : hospitalId,
				"itemGroupId" : itemGroupId,
				"itemTypeId" : itemTypeId,
				"itemSectionId" : itemSectionId,
				"itemClassId" : itemClassId,
				"pvmsNo" : icgName,
				"nomenclturId" : '',
			}

		}
		if (globalFlag != "" && globalFlag == "store_adj_nomen") {
			var hospitalId = $('#hospitalId').val();
			 var params = {
						"hospitalId" : hospitalId,
						"pvmsNo" : '',
						"nomenclturId" : icgName,
						"itemId":''
					}
			 
		}
		
		if (globalFlag != "" && globalFlag == "store_adj_pvms") {
			var hospitalId = $('#hospitalId').val();
			 var params = {
						"hospitalId" : hospitalId,
						"pvmsNo" : icgName,
						"nomenclturId" : '',
						"itemId":''
					}
			 
		}
		
		if(globalFlag!="" && globalFlag=="expiry_nomen"){
			 
	  		params = {
	  	 			 'nomenclturId':icgName
	  	 	 	}
	  	}
		if(globalFlag!="" && globalFlag=="expiry_pvms"){
	  		params = {
	  	 			 'pvmsNo':icgName
	  	 	 	}
	  	}
		
		if(globalFlag!="" && globalFlag=="icd_dignosis"){
			params = {
		  			
		  			 'employeeId':userIdCaseSheet,
		  			 "icdName" : icgName
		  	 	}
			flagForTakenItem=1;
	  	}
		
		if(globalFlag!="" && globalFlag=="linen"){
			params = {
		  			
		  			 'nomenclature':icgName
		  	 	}
	  	}
		
		 if(globalFlag!="" && globalFlag=="rankList" ){
			  params = {
					 'employeeId':userId,
					  "rankName" : icgName,
			 	}
			  //flagForTakenItem=1;
			 }
		   
			 if(globalFlag!="" && globalFlag=="unitShipList" ){
			  params = {
					 'employeeId':userId,
					  "unitName" : icgName,
			 	}
			  //flagForTakenItem=1;
			 }
			 
			 if(globalFlag!="" && globalFlag=="branchTradeList" ){
				  params = {
						 'employeeId':userId,
						  "tradeName" : icgName,
				 	}
				  //flagForTakenItem=1;
				 }
			 
			 if(globalFlag!="" && globalFlag=="hospitalList" ){
				  params = {
						 'employeeId':userId,
						  "hospitalName" : icgName,
				 	}
				  //flagForTakenItem=1;
				 }
				if(globalFlag!="" && globalFlag=="signAndSymptoms"){
					params = {
				  			
				  			 'name':icgName,
				  			 'opdFlag':opdGlobalFlag
				  	 	}
			  	}
				
				if(globalFlag!="" && globalFlag=="wardCityAndDistrict"){
					params = {
				  			
				  			 'wardName':icgName,
				  			 'cityId':$('#cityIdSessionValue').val()
				  	 	}
			  	}
				if(globalFlag!="" && globalFlag=="employee"){
					params = {
				  			
				  			 'userName':icgName,
				  			 'mmuId':$('#mmuIds').val()
				  	 	}
			  	}
		
 			$.ajax({
 				type : "POST",
 				contentType : "application/json",
 				url : url,
 				data : JSON.stringify(params),
 				dataType : "json",
 				cache : false,
 				async: true,
 				success : function(response) {
 					if (response.status == "1") {
 						icdArrayValuNew=[];
 						 if(globalFlag!="" && (globalFlag=="dignosis" || globalFlag=="dignosisSHO"
 							|| globalFlag=="diagnosisForReferal" || globalFlag=="diagnosisMe" || globalFlag=="diagnosisMe18" || globalFlag=="diagnosismi")){
 							icdData = response.ICDList;
 							autoIcdCode=response.ICDList;
 							 
 					     
                        var autoIcdList = [];
                        for (var i = 0; i < icdData.length; i++) {
                            var icdId = icdData[i].icdId;
                            var icdCode = icdData[i].icdCode;
                            var icdName = icdData[i].icdName;
                           // var a = icdName + "[" + icdCode + "]"

                            var icdId = icdName + "[" + icdId + "]"
                            icdArrayValuNew[i] = icdName+'['+ icdCode +']';
                        }
 						}
 						 
                        if(globalFlag!="" && (globalFlag=="investigation" || globalFlag=="investigationTemplate")){
                        
                        	globalArray1=response.InvestigationList;
                        	investigationForUom=response.InvestigationList;
                        	for (var i = 0; i < globalArray1.length; i++) {
                                
                        	var investigationId= globalArray1[i].investigationId;
            				var investigationName = globalArray1[i].investigationName;
            				var a=investigationName+"["+investigationId +"]"
            				 icdArrayValuNew[i] = a;
                        }
                        }
                        
                        if(globalFlag!="" && (globalFlag=="employee")){
                            
                        	globalArray1=response.usersList;
                        	investigationForUom=response.usersList;
                        	for (var i = 0; i < globalArray1.length; i++) {
                                
                        	var userId= globalArray1[i].userId;
            				var userName = globalArray1[i].userName;
            				var mobileNo = globalArray1[i].mobileNo;
            				var userTypeName = globalArray1[i].userTypeName;
            				var mmuId= globalArray1[i].mmuId;
            				var a=userName;
            				 icdArrayValuNew[i] = a;
                        }
                        }
                    	
                       
                        if(globalFlag!="" && (globalFlag=="numenclature"   || globalFlag=="budgetary" || globalFlag=="immunizationFlag"  
                        	|| globalFlag=="newNib" || globalFlag=="indent" || globalFlag=="MIitem" || globalFlag=="immunizationFlagForTem")){
     						globalArray1 = response.MasStoreItemList;
     						autoVsPvmsNo=  response.MasStoreItemList;
     		 				//For NewNib User  
     						nipDataforItem=response.MasStoreItemList; 
                            //var autoList = [];
                            for (var i = 0; i < globalArray1.length; i++) {
                            	var masItemIdValue= globalArray1[i];
            					var masItemId=masItemIdValue[0];
            					var masPvmsNo = masItemIdValue[1];
            					var masDispUnit = masItemIdValue[3];
            					var masNomenclature = masItemIdValue[2];
            					var masFrequency = masItemIdValue[7];
            					var masDosage = masItemIdValue[8];
            					var masNoOfDays = masItemIdValue[9];
            					
            					var aNom=masNomenclature+"["+masPvmsNo +"]";
            					//autoList[i] = aNom;
            				     icdArrayValuNew[i] = aNom;
                            }
     						}
                        
                        
                        
                        if(globalFlag!="" && globalFlag=="procedureNursing"){
                            
                        	dataNursing = response.data;
            				autoNursingNo=response.data;
            				var count=0; 
                        	for (var i = 0; i < dataNursing.length; i++) {
                                
                        		nursingCode= dataNursing[i].nursingCode;
            					nursingName=dataNursing[i].nursingName;
            					nursingType = dataNursing[i].nursingType;
            					nursingId = dataNursing[i].nursingId;
            					
            					var aProcedure=nursingName+"["+nursingCode +"]";
            						icdArrayValuNew[count] = aProcedure;
            						count++;
                        	}
                        }
                        
                        if(globalFlag!="" && globalFlag=="formReportUserMan"){   
                        
                        			var maxAppId = response.max_app_id;
                        			//alert("maxId :: "+maxAppId);
                        			dataList = response.data;	
            					 	var maxId = parseInt(maxAppId.substring(1,maxAppId.length))+1;
            						$('#applicationId').val("A"+maxId);	
            									
            						var count=0; 				
            				  for(i=0;i<dataList.length;i++){
            					  var appId = dataList[i].id;					  
            					  var status = dataList[i].status;
            					  if(status == 'y' || status == 'Y'){
            					//Id = parseInt(appId.substring(1,appId.length));					  
            					var  appNameList = dataList[i].appName;
            					  //var url = dataList[i].url;
            					  var applicationName = appNameList+"["+appId+"]";
            					  
            					  icdArrayValuNew[count] = applicationName;
            					  count++;
            					  }
            					 
        				}  
                        }
                        
                     if(globalFlag!="" && globalFlag=="formReportUserManParent"){
      					  var count=0; 
      				  var dataList1 = response.listObjModule;
      					for(var i=0;i<dataList1.length;i++){
      						 var appPId = dataList1[i].applicationId;
      						 var parentId = dataList1[i].parentApplicationId;
      						 //alert("appPId :: "+appPId);
      						
      						var parentApplicationName = dataList1[i].parentApplicationName;
      						
      						
      						 var appName1 = dataList1[i].applicationName;
      						var appName=""; 
      						var test="0";
      						 	if(parentApplicationName == undefined){
      						 		appName =  appName1+"["+appPId+"]"+"["+test+"]";
      						 	}else{
      						 		  appName =  appName1+"["+appPId+"]"+"["+parentApplicationName+"]";
      						 	}
      					
      						 icdArrayValuNew[count] = appName;
             					  count++;
      						 //appName =  appName1+"["+appPId+"]"+"["+parentApplicationName+"]";
      						// alert(appName);
      						// appArray.push(appName);
      					}  
      				  
      				  }
                     
                     
                     if(globalFlag!="" && globalFlag=="updateformReportUserMan"){ 
                    	 var count=0; 
                    	 var dataList2 = response.data;
            			 
           			  for(i=0;i<dataList2.length;i++){
           				 var appId = dataList2[i].applicationId;	
           				 var applicationStatus = dataList2[i].applicationStatus;				 
           				 var appUrl = dataList2[i].applicationUrl;
           				 var applicationName = dataList2[i].applicationName;
           				  var parentApplicationName = dataList2[i].parentApplicationName;
           				  
           				  var parentId = dataList2[i].parentId;
           				  if(parentApplicationName == undefined){
           					  applicationName = applicationName+"["+appId+"]";
           				 	}else{
           				 		applicationName = applicationName+"["+appId+"]"+"["+parentApplicationName+"]";
           				 	}
           				  
           				icdArrayValuNew[count] = applicationName;
   					  count++;
           				  //applicationArry.push(applicationName);
           				  
           			}  
           			  //autocomplete(document.getElementById("searchApplicationName"), applicationArry);  
           				
           		}
             
                     
                     if(globalFlag!="" && (globalFlag=="store_pvms" || globalFlag=="store_adj_pvms")){
   						itemDataList = response.storeItemList;
   						for(i in itemDataList){
   							itemId = itemDataList[i].itemId;
   							
   							storePvmsList = itemDataList[i].pvmsNumber;
   							storePvmsName = storePvmsList;
   							icdArrayValuNew[i] = storePvmsName;
   						}
                       }
                      
                     
                     if(globalFlag!="" && (globalFlag=="store_nomen")){
 						itemDataList = response.storeItemList;
 						var cityId='0';
 						try{
 						cityId=$('#cityId').val();
 						}
 						catch(e){}
 						for(i in itemDataList){
 						   var inactiveForEntry    = itemDataList[i].inactiveForEntry;
 						   if( cityId=='0' || cityId=="" || (inactiveForEntry!="y" && inactiveForEntry!="Y")){
 							itemId = itemDataList[i].itemId;
 							nomenclatureList = itemDataList[i].nomenclature;
 							nomenclatureName = nomenclatureList + "[" + itemId
 									+ "]";
 							icdArrayValuNew[i] = nomenclatureName;
 						}
 						}
                     }
                
                   
                     if(globalFlag!="" && (globalFlag=="store_adj_nomen")){
 						itemDataList = response.storeItemList;
 					 	for(i in itemDataList){
 						   itemId = itemDataList[i].itemId;
 							nomenclatureList = itemDataList[i].nomenclature;
 							nomenclatureName = nomenclatureList + "[" + itemId
 									+ "]";
 							icdArrayValuNew[i] = nomenclatureName;
 						
 						}
                     }
                
                
               if(globalFlag!="" && (globalFlag=="investigationMe" || globalFlag=="investigationMeDg" || globalFlag=="masterInvestigationMe")){
                         
                     	globalArray1=response.InvestigationList;
        	 			investigationForUom=response.InvestigationList;
        	 		
                     	for (var i = 0; i < globalArray1.length; i++) {
         				var investigationNewUpdate=globalArray1[i];
    	 				var investigationId= investigationNewUpdate[0];
    	 				var investigationName = investigationNewUpdate[1];
    	 				if(investigationNewUpdate[3]!=null)
    	 				var uomName = investigationNewUpdate[3];
    	 				var inves=investigationName+"["+investigationId +"]"
    	 				 icdArrayValuNew[i] = inves;
                     }
                     }
               
               if(globalFlag!="" && (globalFlag=="investigationPrinting")){
                   
                	globalArray1=response.InvestigationList;
   	 		
                	for (var i = 0; i < globalArray1.length; i++) {
    				var investigationNewUpdate=globalArray1[i];
	 				var investigationName = globalArray1[i].investigationName;
	 				if(investigationName != undefined){
	 					icdArrayValuNew[i] = investigationName;
	 					}
                	}
                }
                    
                     if(globalFlag!="" && (globalFlag=="compositeCategory" ||globalFlag=='compositeCategoryForDetail')){
                         
                    	 mcData = response.masMedicalCategoryList;
                      	autoMedicalCategoryData=response.masMedicalCategoryList;
                      	if(mcData!=null && mcData.length!=0)
                          for (var i = 0; i < mcData.length; i++) {
                              var mcId = mcData[i].medicalCategoryId;
                              var mcCode = mcData[i].medicalCategoryCode;
                              var mcName = mcData[i].medicalCategoryName;

                              var medicalCategoryData = mcName + "[" + mcCode + "]"
                              icdArrayValuNew[i] = medicalCategoryData;
                          }
                     	}    
                       
                     
                     if(globalFlag!="" && (globalFlag=="newNib"  || globalFlag=="newNibLp")){
  						globalArray1 = response.MasStoreItemList;
  		 				//For NewNib User  
  						nipDataforItem=response.MasStoreItemList; 
                         //var autoList = [];
                         for (var i = 0; i < globalArray1.length; i++) {
                        	 var itemIdNip= globalArray1[i].itemId;
     	 					 var masNomenclatureNip=globalArray1[i].nomenclature;
     	 					 var auName = globalArray1[i].storeUnitName;
     	 					 var aNomNip=masNomenclatureNip+"["+itemIdNip +"]";
         				     icdArrayValuNew[i] = aNomNip;
                         }
  						}
                     
                     	if(globalFlag!="" && globalFlag=="expiry_nomen"){
                     		if (response.status == "1") {
            					itemDataList = response.storeItemList;
            					for (i = 0; i < itemDataList.length; i++) {
            						nomenclatureList = itemDataList[i].nomenclature;
            						icdArrayValuNew.push(nomenclatureList);
            						/*pvmsNumberList = itemDataList[i].pvmsNumber;
            						pvmsNumberArry.push(pvmsNumberList);*/
            					}
            				}
             	  		}
                     	if(globalFlag!="" && globalFlag=="expiry_pvms"){
                     		if (response.status == "1") {
            					itemDataList = response.storeItemList;
            					for (i = 0; i < itemDataList.length; i++) {
            						pvmsNumberList = itemDataList[i].pvmsNumber;
            						icdArrayValuNew.push(pvmsNumberList);
            					}
            				}
             			
             	  		}
                     	
                     	if(globalFlag!="" && globalFlag=="icd_dignosis"){
                     		icdData = response.ICDList;
                     		autoIcdCode=response.ICDList;
                     		
	                     	var autoIcdList = [];
	                     	for (var i = 0; i < icdData.length; i++) {
		                     		var icdId = icdData[i].icdId;
		                     		var icdCode = icdData[i].icdCode;
		                     		var icdName = icdData[i].icdName;
		                     	   // var a = icdName + "[" + icdCode + "]"
		
		                     		var icdId = icdName + "[" + icdId + "]"
		                     		icdArrayValuNew[i] = icdName+'['+ icdCode +']';
	                     	 }
             			
             	  		}
                     	
                     	if(globalFlag!="" && globalFlag=="linen"){
                     		var list = response.storeItemList;
                     		jsonGlobal = response.storeItemList;
                     		for (var i = 0; i < list.length; i++) {
                     			icdArrayValuNew[i] = list[i].nomenclature;
                     		}
                     	}
                     	
                     	if(globalFlag!="" && (globalFlag=="rankList" || globalFlag=="rankList")){
                            
                        	globalArray1=response.rankList;
                        	autoRankData=response.rankList;
                        	for (var i = 0; i < globalArray1.length; i++) {
                        	var rankIdValue= globalArray1[i];  
                        	var rankId= rankIdValue[0];
            				var rankName = rankIdValue[2];
            				var a=rankName+"["+rankId +"]"
            				 icdArrayValuNew[i] = a;
                        }
                        }
                     	
                     	if(globalFlag!="" && (globalFlag=="unitShipList" || globalFlag=="unitShipList")){
                           	globalArray1=response.getUnitShipList;
                           	autoUnitData=response.getUnitShipList;
                        	for (var i = 0; i < globalArray1.length; i++) {
                        	var unitIdValue= globalArray1[i];  
                        	var unitId= unitIdValue[0];
            				var unitName = unitIdValue[2];
            				var a=unitName+"["+unitId +"]"
            				 icdArrayValuNew[i] = a;
                        }
                        }
                     
                        if(globalFlag!="" && (globalFlag=="branchTradeList" || globalFlag=="branchTradeList")){
                           	globalArray1=response.getBranchTradeList;
                           	autoBranchData=response.getBranchTradeList;
                        	for (var i = 0; i < globalArray1.length; i++) {
                        	var tradeIdValue= globalArray1[i];  
                        	var tradeId= tradeIdValue[0];
            				var tradeName = tradeIdValue[2];
            				var a=tradeName+"["+tradeId +"]"
            				 icdArrayValuNew[i] = a;
                        }
                        }
                        
                        if(globalFlag!="" && (globalFlag=="hospitalList" || globalFlag=="hospitalList")){
                           	globalArray1=response.getHospitalList;
                           	autoHospitalData=response.getHospitalList;
                        	for (var i = 0; i < globalArray1.length; i++) {
                        	var hospitalIdValue= globalArray1[i];  
                        	var hospitalId= hospitalIdValue[0];
            				var hospitalName = hospitalIdValue[2];
            				var a=hospitalName+"["+hospitalId +"]"
            				 icdArrayValuNew[i] = a;
                        }
                        }
                        
                        if(globalFlag!="" && (globalFlag=="signAndSymptoms")){
     						globalArray1 = response.list;
     						signAndSymptomsGlobalArray = response.list;
                            for (var i = 0; i < globalArray1.length; i++) {
            				     icdArrayValuNew[i] = globalArray1[i].name;
                            }
                            
     					}
                        
                        if(globalFlag!="" && (globalFlag=="wardCityAndDistrict")){
     						globalArray1 = response.list;
     						wardGlobalJson = response.list;
                            for (var i = 0; i < globalArray1.length; i++) {
            				     icdArrayValuNew[i] = globalArray1[i].wardNameWithCode;
                            }
                            
     					}
                        
 					 	var html = '';
 					 	if(icdArrayValuNew!=null && icdArrayValuNew.length>0){
 					 	 for(var i=0;i<icdArrayValuNew.length;i++){
  					    	html += '<div onclick="selectItemFromNomenclatureList(this)">'+ icdArrayValuNew[i] +'</div>';
  					     }
 					 	 
 					 	
 					 	 
 					   $('#'+divIdGen).html(html);
 					   $("#"+divIdGen).animate({ scrollTop: 0 }, "fast");
 					   $('#'+divIdGen).show();
 					 	}
 					 	else{
   						   $('#'+divIdGen).html('<strong><div>No Record found</div></strong></br>');
   						   /*if(flagForTakenItem=='1'){
   							   $('#'+divIdGen).append('<strong><div><a href="javascript:void(0)" onclick="addNewItemForCommon(this,\'' + globalFlag + '\');">Add New ICD Diagnosis</a></div></strong>');
   							}*/
   						$('#'+divIdGen).show();
   					
   					}
 					 
 					    
 					}else{
 						   $('#'+divIdGen).html('<strong><div>No Record found</div></strong></br>');
 						  /*if(flagForTakenItem=='1'){
 						   $('#'+divIdGen).append('<strong><div><a href="javascript:void(0)" onclick="addNewItemForCommon(this,\'' + globalFlag + '\');">Add New ICD</a></div></strong>');
 						  }*/
 						  $('#'+divIdGen).show();
 					
 					}
 						
 				},
 				error : function(msg) {
 					alert("An error has occurred while contacting the server");
 				}
 			});
 }
 
 function getAutocompleteDataForOpd(item){
	 mainItemReferenceForNomenclature = item;
	 
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/"
		+ accessGroup +"/"+ globalURL+"/"+globalURL2;
	 var id = item.id;
	 //var icgName = $(item).val();
	 var counter = 0;
	 
	var divIdGen=$(item).siblings("div.autocomplete-itemsNew").attr("id");
 	
 	var userId = '';
 	if(globalFlag!="indent" ||globalFlag!="MIitem" ){
 		userId=$('#userId').val();
 	}
 	 var params = {};
 	   
 
				if(globalFlag!="" && globalFlag=="signAndSymptoms" || globalFlag=="dignosis"){
					params = {
				  			
				  			 'name':'',
				  			 'opdFlag':opdGlobalFlag
				  	 	}
			  	}
				
				
		
 			$.ajax({
 				type : "POST",
 				contentType : "application/json",
 				url : url,
 				data : JSON.stringify(params),
 				dataType : "json",
 				cache : false,
 				async: true,
 				success : function(response) {
 					if (response.status == "1") {
 						icdArrayValuNew=[];
 					    if(globalFlag!="" && (globalFlag=="signAndSymptoms")){
     						globalArray1 = response.list;
     						signAndSymptomsGlobalArray = response.list;
                            for (var i = 0; i < globalArray1.length; i++) {
            				     icdArrayValuNew[i] = globalArray1[i].name;
                            }
                            
     					}
 					    
 					   if(globalFlag!="" && (globalFlag=="dignosis" || globalFlag=="dignosisSHO"
 							|| globalFlag=="diagnosisForReferal" || globalFlag=="diagnosisMe" || globalFlag=="diagnosisMe18" || globalFlag=="diagnosismi")){
 							icdData = response.ICDList;
 							autoIcdCode=response.ICDList;
 							 
 					     
 	                        var autoIcdList = [];
		 	                for (var i = 0; i < icdData.length; i++) {
		 	                    var icdId = icdData[i].icdId;
		 	                    var icdCode = icdData[i].icdCode;
		 	                    var icdName = icdData[i].icdName;
		 	                   // var a = icdName + "[" + icdCode + "]"
		
		 	                    var icdId = icdName + "[" + icdId + "]"
		 	                    icdArrayValuNew[i] = icdName+'['+ icdCode +']';
		 	                }
		 				   }
                                                                    
 					 	var html = '';
 					 	if(icdArrayValuNew!=null && icdArrayValuNew.length>0){
 					 	 for(var i=0;i<icdArrayValuNew.length;i++){
  					    	html += '<div onclick="selectItemFromNomenclatureList(this)">'+ icdArrayValuNew[i] +'</div>';
  					     }
 					 	 
 					 	
 					 	 
 					   $('#'+divIdGen).html(html);
 					   $("#"+divIdGen).animate({ scrollTop: 0 }, "fast");
 					   $('#'+divIdGen).show();
 					 	}
 					 	else{
   						   $('#'+divIdGen).html('<strong><div>No Record found</div></strong></br>');
   						   /*if(flagForTakenItem=='1'){
   							   $('#'+divIdGen).append('<strong><div><a href="javascript:void(0)" onclick="addNewItemForCommon(this,\'' + globalFlag + '\');">Add New ICD Diagnosis</a></div></strong>');
   							}*/
   						$('#'+divIdGen).show();
   					
   					}
 					 
 					    
 					}else{
 						   $('#'+divIdGen).html('<strong><div>No Record found</div></strong></br>');
 						  /*if(flagForTakenItem=='1'){
 						   $('#'+divIdGen).append('<strong><div><a href="javascript:void(0)" onclick="addNewItemForCommon(this,\'' + globalFlag + '\');">Add New ICD</a></div></strong>');
 						  }*/
 						  $('#'+divIdGen).show();
 					
 					}
 						
 				},
 				error : function(msg) {
 					alert("An error has occurred while contacting the server");
 				}
 			});
 }
 
 function selectItemFromNomenclatureList(item){
	   
	   $(mainItemReferenceForNomenclature).val();
	   var nomenclature = $j(item).html();
	   $(mainItemReferenceForNomenclature).val(nomenclature);
	   
	  if(globalFlag=='dignosis' || globalFlag=="diagnosisForReferal"|| globalFlag=='dignosisSHO' || globalFlag=="diagnosismi" || globalFlag=="masterInvestigationMe"){
		   window[functionNameGlobal](nomenclature,'1',mainItemReferenceForNomenclature);
		   
		   if(globalFlag=="diagnosisForReferal"){
			   functionNameGlobal='fillReferalDiagnosisVal2';
			   window[functionNameGlobal](mainItemReferenceForNomenclature,nomenclature);
		   }
		   }
		if(globalFlag=='investigation' || globalFlag=='numenclature' || globalFlag=='newNib' || globalFlag=="newNibLp"
			|| globalFlag=="procedureNursing" || globalFlag=="investigationMe" || globalFlag=="investigationMeDg"
				||  globalFlag=="immunizationFlag" || globalFlag=="investigationTemplate" || globalFlag=="immunizationFlagForTem" ){
			window[functionNameGlobal](nomenclature,1,mainItemReferenceForNomenclature);
		}
		
		
		 if(globalFlag!="" && globalFlag=="formReportUserMan"){
			 window[functionNameGlobal](nomenclature);
				   functionNameGlobal='fillDataUrl';
				   window[functionNameGlobal](mainItemReferenceForNomenclature);
			   
		 }
		 
		 if(globalFlag!="" && globalFlag=="updateformReportUserMan"){
			// window[functionNameGlobal](nomenclature);
				   functionNameGlobal='fillDataUrl';
				  // window[functionNameGlobal](mainItemReferenceForNomenclature);
			   
		 }
		 
		
		 if(globalFlag!="" && (globalFlag=="indent" || globalFlag=="budgetary" || globalFlag=="MIitem")){
		   window[functionNameGlobal](nomenclature,'1',mainItemReferenceForNomenclature);
		  // functionNameGlobal='getAvailableStock';
		   if(globalFlag=="MIitem"){
			    functionNameGlobal='getEquipmentDetailsByItemId';
			   window[functionNameGlobal](nomenclature,'1',mainItemReferenceForNomenclature);
		   }
		   if(globalFlag=="indent"){
			   functionNameGlobal='getAvailableStock';
			   window[functionNameGlobal](nomenclature,'1',mainItemReferenceForNomenclature);
		   }
		   if(globalFlag=="budgetary"){
			   functionNameGlobal='getLpRate';
		   window[functionNameGlobal](nomenclature,'1',mainItemReferenceForNomenclature);
		   }
	   }
	    if(globalFlag=="compositeCategory" || globalFlag=="diagnosisMe"  || globalFlag=="diagnosisMe18"){
			 window[functionNameGlobal](nomenclature,mainItemReferenceForNomenclature);
		 }
		
	    if(globalFlag=="compositeCategoryForDetail"){
	    	if(checkForCategoryDetail(mainItemReferenceForNomenclature)){
			 window[functionNameGlobal](nomenclature,mainItemReferenceForNomenclature);
	    	}
	    	else{
	    		alert("Please enter atleast two records in list of medical category before entering a present medical category(composite).");
	    		
	    	}
	    	}
		 if(globalFlag!="" && (globalFlag=="store_nomen" || globalFlag=="store_pvms"  || globalFlag=="store_adj_nomen" || globalFlag=="store_adj_pvms")){
			 window[functionNameGlobal](mainItemReferenceForNomenclature.id,mainItemReferenceForNomenclature.value);
		 }
		 if(globalFlag=='icd_dignosis'){
			   window[functionNameGlobal](nomenclature);
		  }
		 if(globalFlag=='signAndSymptoms'){
			   window[functionNameGlobal](nomenclature);
		  }
		 if(globalFlag=='employee'){
			   window[functionNameGlobal](nomenclature);
		  }
		 if(globalFlag=='wardCityAndDistrict'){
			   window[functionNameGlobal](nomenclature);
		  }
		 if(globalFlag=='linen'){
			   window[functionNameGlobal](nomenclature,mainItemReferenceForNomenclature);
		  }
		 if(globalFlag=='hospitalList'){
			   window[functionNameGlobal](nomenclature,mainItemReferenceForNomenclature);
		  }
		  if(globalFlag=='branchTradeList'){
			   window[functionNameGlobal](nomenclature,mainItemReferenceForNomenclature);
		  }
		  if(globalFlag=='unitShipList'){
			   window[functionNameGlobal](nomenclature,mainItemReferenceForNomenclature);
		  }
		  if(globalFlag=='rankList'){
			   window[functionNameGlobal](nomenclature,mainItemReferenceForNomenclature);
		  }
		 
		 //functionNameGlobal
		
	   var divIdGen=$(mainItemReferenceForNomenclature).siblings("div.autocomplete-itemsNew").attr("id");
	   $('#'+divIdGen).empty();
	   $('#'+divIdGen).hide();
}
  

function restrictCallingService(e){
	
	 if (e.keyCode == 40) { 		// If the arrow Down key is pressed
		return true;
	 }
	 
	 else if (e.keyCode == 38) { 	//If the arrow UP key is pressed
		return true;
	 }
	 
	 else if (e.keyCode == 13) {	//If the ENTER key is pressed			
		 return true;
	 
	 }else{
		 return false;
	 }	
	
}

var currentItemFocus = -1;


$(document).on("keydown",'.autocomplete input', function(e) {
	
	 console.log($(this).attr('id'));
	 var x =$(this).siblings('.autocomplete-itemsNew');
	 
	 if(x) {
		 x = $(x).children();
	 }
	 
	 if (e.keyCode == 40) { 		// If the arrow Down key is pressed
		 currentItemFocus++;
		 addActiveItem(x);
	 }
	 
	 else if (e.keyCode == 38) { 	//If the arrow UP key is pressed
		 currentItemFocus--;
		 addActiveItem(x);
	 }
	 
	 else if (e.keyCode == 13) {	//If the ENTER key is pressed			
		 e.preventDefault();
		 if (currentItemFocus > -1) {	          
         if (x) x[currentItemFocus].click();
         
		 }
	 }
	 
 });

 function addActiveItem(x) {
	    
	    if (!x) return false;
 
	    removeActiveItem(x);
	    
	    if (currentItemFocus >= x.length) currentItemFocus = 0;
	    if (currentItemFocus < 0) currentItemFocus = (x.length - 1);
	    
	    x[currentItemFocus].classList.add("autocomplete-active-item");
	    
	    var parentElem = $('.autocomplete-itemsNew');
	    var parentHeight = $('.autocomplete-itemsNew').height();
	    
	    if( x[currentItemFocus].offsetTop > (parentHeight-20)  ){
	    	parentElem.scrollTop(x[currentItemFocus].offsetTop);
	    }
	    else if( x[currentItemFocus].offsetTop < (parentHeight-20) ){
	    	parentElem.scrollTop(x[currentItemFocus].offsetTop);
	    }
  	}
 
  function removeActiveItem(x) {
	  $('.autocomplete-itemsNew div').removeClass('autocomplete-active-item');		    
	}
  
 
 	$(document).mouseup(function(e) 
		 {
		     var container = $('.autocomplete-itemsNew');

		     // if the target of the click isn't the container nor a descendant of the container
		     if (!container.is(e.target) && container.has(e.target).length === 0) 
		     {
		         container.hide();
		     }
		 });
 	
 	
 	

 	function decodeHtml(html) {
 	    var txt = document.createElement("textarea");
 	    txt.innerHTML = html;
 	    return txt.value;
 	}
 	
 	
 