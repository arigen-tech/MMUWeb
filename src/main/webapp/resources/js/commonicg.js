var S_Search_Searching = 'Refreshing...';
var S_Search_Error = '<span class="labelError">An error has occurred while contacting the server.</span>'
var S_Search_Single_Match = "match";
var S_Search_Multi_Matches = "matches";
var S_Search_NoMatches  = '<span class="labelError"><b>No Record Found</b></span>';
var departmentArray = new Array();


function isNumber(event)
{
	
	       var charCode = (event.which) ? event.which : event.keyCode
	    		  
	       if (charCode != 46 && charCode > 31 && (charCode< 48 || charCode > 57))
	    	   {
	          	return false;
	    	   }

	       return true;
	
}



var commonArray = new Array();
var codeNameArray = new Array();
var userArray = new Array();
var userArray2 = new Array();

var departmentArray = new Array();

errorMsg = "";
function submitForm(formName,action,extraFunction,extraFunction2,extraFunction3){

	errorMsg="";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		if(eval("window."+extraFunction))
	    	ob1 =  eval(extraFunction+"()")
	        
			if(eval("window."+extraFunction2))
	        	ob2 = eval(extraFunction2+"()")
	        
			if(eval("window."+extraFunction3))
	        	ob3 = eval(extraFunction3+"()")        	
	    	
			if(validateFields(formName)== true & ob1 & ob2 &ob3){
			if(formName=="admissionByHin"){
				obj.Submit11.disabled=true
			}
			if(formName=="attachPhoto"){
			if(obj.Submit13!=null){
			obj.Submit13.disabled=true
			}
			}
			if(formName=="dischargeByHin"){

                  if(obj.Submit12 != null){                 

                  obj.Submit12.disabled=true

                  }

                  }
           
			if(formName=="transferByHin"){

                         if(obj.Submit10 != null){  

                        obj.Submit10.disabled=true

                  }
           } 
		
			if(obj.Submit11){
				obj.Submit11.disabled=true;
				}
	        	obj.action = action;
				obj.submit();
	    	
			}else{
	    	   	
				if(errorMsg != ""){
					alert(errorMsg);
		       		return false;	
		       	}
		       	return true;
	    	}
	}


errorMsg1 = "";
function submitForm1(formName,action,extraFunction,extraFunction2,extraFunction3){
	
errorMsg1="";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
	//	alert(action+obj+formName)
		if(eval("window."+extraFunction))
	    	ob1 =  eval(extraFunction+"()")
	        
			if(eval("window."+extraFunction2))
	        	ob2 = eval(extraFunction2+"()")
	        
			if(eval("window."+extraFunction3))
	        	ob3 = eval(extraFunction3+"()")        	
	    	
			if(validateFields(formName)== true & ob1 & ob2 &ob3){     
	        	obj.action = action;
				obj.submit();
	    	
			}else{
	    	   	
				if(errorMsg1 != ""){
					alert(errorMsg1);
		       		return false;	
		       	}
		       	return true;
	    	}
	}

errorMsgDisableSubmit = "";	
function submitFormToDisableSubmit(formName,action,extraFunction,extraFunction2,extraFunction3){
errorMsgDisableSubmit="";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName);
		
		if(eval("window."+extraFunction))
	    	ob1 =  eval(extraFunction+"()")
	        
			if(eval("window."+extraFunction2))
	        	ob2 = eval(extraFunction2+"()")
	        
			if(eval("window."+extraFunction3))
	        	ob3 = eval(extraFunction3+"()")        	
	    	
			if(validateFieldsForDisableSubmit(formName)== true & ob1 & ob2 &ob3){
				if(document.getElementById('submitForDisable') != null){
					document.getElementById('submitForDisable').disabled=true
				}
	        	obj.action = action;
				obj.submit();
			}else{
				if(errorMsgDisableSubmit != ""){
					alert(errorMsgDisableSubmit);
		       		return false;	
		       	}
		       	return true;
	    	}
	}
    
function validateFields(formName){
		
		focusFlag = false;
		errors = "";
		errorMsg += loopThroughElements(formName);
		if(errorMsg == "")
			return true;
		else{
			return errorMsg;
		    }
	}

function validateFieldsForDisableSubmit(formName){
		
		focusFlag = false;
		errorsForDisableSubmit = "";
		errorMsgDisableSubmit += loopThroughElements(formName);
		if(errorMsgDisableSubmit == "")
			return true;
		else{
			return errorMsgDisableSubmit;
		}
	}
	
function submitFormForButton(formName,action,extraFunction,extraFunction2,extraFunction3){

	
errorMsg="";
  ob1 = true;
  ob2 = true;
  ob3 = true;
  obj = eval('document.'+formName)
  if(eval("window."+extraFunction))
      ob1 =  eval(extraFunction+"()")
         
   if(eval("window."+extraFunction2))
          ob2 = eval(extraFunction2+"()")
         
   if(eval("window."+extraFunction3))
          ob3 = eval(extraFunction3+"()")         
      
   if(ob1 & ob2 & ob3){
     obj.action = action;
     obj.submit();
      
   }else{
          
    if(errorMsg != ""){
     alert(errorMsg);
           return false; 
          }
          return true;
      }
 }
 
function checkFoodData(formName){
		
		var breakFastStatus=document.getElementById('breakFastStatus').value
		var lunchStatus=document.getElementById('lunchStatus').value
		var dinnerStatus=document.getElementById('dinnerStatus').value
		
		
		 obj = eval('document.'+formName)
		 
		
		if(breakFastStatus == "" && lunchStatus == "" && dinnerStatus == "")
		{
		 alert("Please Enter The Food Details")
		}
		
		if(breakFastStatus != "" && lunchStatus == "" && dinnerStatus == "" )
		{
		 //alert(formName)
		  url = "/hms/hms/ipd?method=insertFoodTesting&status="+breakFastStatus;
		  	obj.action = url;
   			obj.submit();
		}
		if(lunchStatus != "" && breakFastStatus=="" && dinnerStatus == "")
		{
			//alert(formName)
 		  url = "/hms/hms/ipd?method=insertFoodTesting&status="+lunchStatus;
		  	obj.action = url;
   			obj.submit();
		}
		if(dinnerStatus != "" && lunchStatus == "" && breakFastStatus=="")
		{
		//alert(formName)
		  url = "/hms/hms/ipd?method=insertFoodTesting&status="+dinnerStatus;
		  	obj.action = url;
   			obj.submit();
		}
		if(breakFastStatus != "" && lunchStatus != "" && dinnerStatus == ""  )
		{
		//alert(formName)
		  url = "/hms/hms/ipd?method=insertFoodTesting&breakFastStatus="+breakFastStatus+"&lunchStatus="+lunchStatus;
		  	obj.action = url;
   			obj.submit();
		}
		if(breakFastStatus != "" && lunchStatus == "" && dinnerStatus != ""  )
		{
		//alert(formName)
		  url = "/hms/hms/ipd?method=insertFoodTesting&breakFastStatus="+breakFastStatus+"&dinnerStatus="+dinnerStatus;   
		  	obj.action = url;
   			obj.submit();
		}
		if(breakFastStatus =="" && lunchStatus != "" && dinnerStatus != ""  )
		{
		//alert(formName)
		  url = "/hms/hms/ipd?method=insertFoodTesting&lunchStatus="+lunchStatus+"&dinnerStatus="+dinnerStatus;   
		  	obj.action = url;
   			obj.submit();
		}
		if(breakFastStatus !="" && lunchStatus != "" && dinnerStatus != ""  )
		{
		//alert(formName)
		  url = "/hms/hms/ipd?method=insertFoodTesting&lunchStatus="+lunchStatus+"&dinnerStatus="+dinnerStatus+"&breakFastStatus="+breakFastStatus;   
		  	obj.action = url;
   			obj.submit();
		}
		
	}
	
function validateRadio(){
			
			 for(var i = 0; i < document.getElementsByName('parent').length; i++){
			//alert("i-- "+i)
			//alert("document.getElementsByName('parent').length"+ document.getElementsByName('parent').length)
			  if(document.getElementsByName('parent')[i].checked == true)
              {
				
				return true;
			  }		
  		}
  		alert("Please select the patient")
		return false;
		
	}
	function validateRadioForSecurity(){
			
			 for(var i = 0; i < document.getElementsByName('userId').length; i++){
			//alert("i-- "+i)
			//alert("document.getElementsByName('parent').length"+ document.getElementsByName('parent').length)
			  if(document.getElementsByName('userId')[i].checked == true)
              {
				
				return true;
			  }		
  		}
  		alert("Please Select the User")
		return false;
		
	}
	
	function validateVisit(){
			
			
		 for(var i = 0; i < document.getElementsByName('parent').length; i++){
			//alert("i-- "+i)
			//alert("document.getElementsByName('parent').length"+ document.getElementsByName('parent').length)
			  if(document.getElementsByName('parent')[i].checked == true)
              {
				
				return true;
			  }		
  		}
  		alert("Please select the purticular Visit of the patient")
		return false;
		
		 
		
	}
 

function checkHospitalName(){
errorMsg="";
  	  obj1 = document.getElementById('loginName');          
      loginName = obj1.value;  
      var obj2;  
      if(!(loginName == "superadmin"))
		{		
		 	if(document.getElementById('defaultList').style.display == 'inline'){
			   	 obj2 = document.getElementById('hospital');
			}else{
			 obj2 = document.getElementById('hospitalName');
			}
		    hospitalName = obj2.value;
	        if(hospitalName == 0)
	         {
		       errorMsg += "Hospital Name cannot be blank.\n";
		       return errorMsg;
	        }else
	          return true;
       }else
          return true;
   }
 
 
   
function loopThroughElements(frmName){
		
		var inputs = eval('document.'+frmName+'.elements');
		
		errors = "";
		
		for(i=0;i<inputs.length;i++){
			if(inputs[i].type == 'text' 
				|| inputs[i].type == 'select-one'
				|| inputs[i].type == 'select-multiple'
				|| inputs[i].type == 'textarea' 
				|| inputs[i].type == 'password'){
					
				if(!inputs[i].getAttribute('validate'))
						continue;
				name = inputs[i].getAttribute('validate').substring(0,
					   inputs[i].getAttribute('validate').indexOf(','));
				type = inputs[i].getAttribute('validate').substring(inputs[i].getAttribute('validate').indexOf(',')+1,
					   inputs[i].getAttribute('validate').lastIndexOf(','));
	    		mandatory = inputs[i].getAttribute('validate').substring((inputs[i].
	    				getAttribute('validate').lastIndexOf(',')+1)); 
	    		
		    	textValue = trimAll(inputs[i].value);	
				textValueForSpaces=(inputs[i].value);
				if(mandatory == "yes" & trimAll(textValue) == "" & trimAll(textValueForSpaces) == ""){
					errors += name + " cannot be blank.\n";
				}else if(mandatory == "yes" & textValue == '0' & textValueForSpaces == '0'){
					errors += "Select "+name + ".\n";
				}
					if(textValue.toLowerCase() != 'onmouseover'){
					if(textValue!= "" & type == 'alphanumeric'){
						if(! validateAlphaNumeric(textValue))
							errors +="Field "+ name +" is not valid.\n";
					}else if(textValue!= "" & type == 'alphaspace'){
						if(!validateAlphaSpace(textValue))
							errors += "Field " + name + " is not valid.\n";						
					}else if(textValue!= "" & textValue!= 'undefined' & type == 'goodString'){
					 	if(!validateGoodString(textValue))
							errors +="Field "+ name +" is not valid.\n";
					}else if(textValue!= "" & type == 'num'){
						if(!validateNumeric(textValue))
							errors += name + " should be a number.\n";
					}else if(textValue!= "" & type == 'phone'){
						if(!validatePhone(textValue))
							errors += name + " should be a valid phone number.\n";
					}else if(textValue!= "" & type == 'email'){
						if(!validateEmail(textValue))
							errors +=name + " should be a valid Email-Id.\n";						
					}
					else if(textValue!= "" & type == 'address'){
						if(!validateAddress(textValue))
							errors += "Field " + name + " should contain only valid characters.\n";					
					}
					else if(textValue!= "" & type == 'int'){
					if(!validateInteger(trimAll(textValue)))
						errors += name + " should be a number(without spaces).\n";						
					}	
					else if(textValue!= "" & type == 'name'){
						if(!chkSpaces(textValue))
							errors += name + " cannot contain spaces.\n";						
						else if(!validateName(textValue))
							errors += name + " is not a valid name.\n";						
					}
					else if(textValue!= "" & type == 'remarks'){
					if(!validateRemarks(textValue))
						errors += name + " is not valid.\n";						
					}
					else if(textValue!= "" & type == 'dateOfAdmission'){
					if(!validateDateOfAdmission(textValue))
						errors += name + " is not valid.\n";
					}
					else if(textValue!= "" & type == 'deliveryDate'){
					if(!validateDeliveryDate(textValue))
						errors += name + " is not valid.\n";
					}
					else if(textValue!= "" & type == 'fullName'){
					if(!validateFullName(textValue))
						errors += name + " is not a valid name.\n";						
					}else if(textValue!= "" & type == 'float'){
					if(!validateFloat(textValue))
						errors +=  name + " should contain integer or decimal value.\n";	
					}else if(textValue!= "" & type == 'date'){
				    	if(!validateDate(textValue))
				    	 errors += name + " is not a valid date (dd/mm/yyyy).\n";
	                }else if(textValue!= "" & type == 'numWithSlash'){
				    	if(!validateNumericWithSlash(textValue))
				    	 errors += name + " is not a valid .\n";
	                }else if(textValueForSpaces!= "" & type == 'numWithoutSpaces'){
				    	if(!validateInteger(textValueForSpaces))
				    	 errors += name + " should be a number(without spaces).\n";
	                }else if(textValueForSpaces!= "" & type == 'floatWithoutSpaces'){
				    	if(!validateFloat(textValueForSpaces))
				    	 errors += name + " should be a number(without spaces).\n";
				    }else if(textValue!= "" & type == 'metachar'){
							if(! validateMetaCharacters(textValue))
								errors +="Field "+ name +" is not valid.\n";
					}else if(textValue!= "" & type == 'metacharAddress'){
						if(! validateMetaAddressCharacters(textValue))
							errors +="Field "+ name +" is not valid.\n";
				    }else if(textValue!= "" & type == 'alphanumeric1'){
						if(! validateAlphaNumericForPvms(textValue))
							errors +="Field "+ name +" is not valid.\n";
					}else if(textValue!= "" & type == 'alphanumericSlash'){
						if(! validateAlphaNumericWithoutSlash(textValue))
							errors +="Field "+ name +" is not valid.\n";
					}else if(textValue!= "" & type == 'regName'){
						if(!validateRegName(textValue))
							errors += "Field " + name + " is not valid.\n";						
					}else if(textValue!= "" & type == 'icd'){
						if(!validateICD(textValue))
							errors += "Field " + name + " is not valid.\n";						
					}
					else if(textValue!= "" & type == 'frdate'){
						if(!isGoodDate(textValue))
							errors += "Field " + name + " is not valid.\n";						
					}
					
					else if(textValue!= "" & type == 'LifeStyle'){
						if(! validateLifeStyleFactor(textValue))
							errors +="Field "+ name +" is not valid.\n";
				}
					else if(textValue!= "" & type == 'metacharBrac'){
						if(! validateMetaCharactersWithBrace(textValue))
							errors +="Field "+ name +" is not valid.\n";
				}
					else if(textValue!= "" & type == 'metacharSpac'){
						if(! validateMetaCharactersWithSpace(textValue))
							errors +="Field "+ name +" is not valid.\n";
				}
				else if(textValue!= "" & type == 'metacharSpacBrac'){
					if(! validateMetaCharactersWithSpaceAndBrac(textValue))
						errors +="Field "+ name +" is not valid.\n";
			}
				else if(textValue!= "" & type == 'examType'){
					if(! validateMetaCharactersExam(textValue))
						errors +="Field "+ name +" is not valid.\n";
			}	
				else if(textValue!= "" & type == 'metacharSpacDas'){
					if(! validateMetaCharactersWithSpaceDas(textValue))
						errors +="Field "+ name +" is not valid.\n";
			}	
				else if(textValue!= "" & type == 'metacharSlash'){
					if(! validateMetaCharactersWithSlash(textValue))
						errors +="Field "+ name +" is not valid.\n";
			}
			else if(textValue!= "" & type == 'metacharSpaceSlash'){
				if(! validateMetaCharactersWithSpaceAndSlash(textValue))
					errors +="Field "+ name +" is not valid.\n";
		}else if(textValue!= "" & type == 'metacharSpaceSlashDash'){
			if(!validateMetaCharWithSpaceSlashDash(textValue))
					errors +="Field "+ name +" is not valid.\n";
		}
					
				}else{
					errors +="Field "+ name +" is not valid.\n";
				}
			}
		}
		return errors;
}

function  validateName( strValue ) {
  var objRegExp = /[^a-z\d]/i;
  if(!(parseInt(strValue)>0))
  		return !objRegExp.test(strValue);
  return false;
}

function chkSpaces(strValue){
	for(j=0; j<strValue.length; j++){
		if(strValue[j]==" ")
			return false;
	}
	return true;
}

function validateInteger( strValue ) {
  var objRegExp  = /(^\d\d*$)/;
  return objRegExp.test(strValue);
}

function validateRemarks( strValue ){
	var objRegExp  = /[^a-z*(\.\-\&\d\s\:\@\#\$\^\*\(\)\{\}\[\]\;\"\,\<\>\?\/\_\\\+\=)]/i;
	if(strValue.substring(0,1) == "." || strValue.substring(0,1) == "-" || strValue.substring(0,1) == "&"){
			return false;
	}
	else{
		return !objRegExp.test(strValue);
	}
}

function validateDateOfAdmission(strValue) {
   	dateOfJoining = new Date(strValue.substring(6),(strValue.substring(3,5) - 1) ,strValue.substring(0,2));
 	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);
	if(dateOfJoining > currentDate)
 	{
		return false;
 	}
	 return true;
}
function validateDeliveryDate(strValue) {
   	dateOfJoining = new Date(strValue.substring(6),(strValue.substring(3,5) - 1) ,strValue.substring(0,2));
 	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);
	if(dateOfJoining < currentDate)
 	{
		return false;
 	}
	 return true;
}
function validateFullName( strValue ) {
	
	var objRegExp  = /[^a-z*(\.\, )]/i;
	if(parseInt(strValue)>0){
		return false;
	}
	else if(strValue.substring(0,1) == ".")
	{
			return false;
	}
	else{
			return !objRegExp.test(strValue);
	}
}
function  validateNumeric( strValue ) {
  var objRegExp  =  /(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)/;
  return objRegExp.test(strValue);
}
	
	function validateGoodString( strValue )
{
	if (validateNumeric(strValue)) return false;
	
	if (validateAlphaNumeric(strValue)) 
		return true; 
	else 
		return false;
}
function validateAlphaNumeric( strValue ) {
	
	//var objRegExp  = /[^a-z*(\d)]/i;
	//Change by tarun
	var objRegExp=/(\s{2,})|([\\\/\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\n\r])/i

	//Change by tarun to allow ".","-",","
	//var objRegExp=/(\s{2,})|([\\\/\(\)\_\:\@\$\*\"\&\`\#\ï¿½\ï¿½\?\n\r])/i
	
	return !objRegExp.test(strValue);
	
}

function validateICD( strValue ) {
	
	var objRegExp=/(\s{2,})|([\\\/\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\n\r])/i


function validateICD( strValue ) {
	
	var objRegExp=/(\s{2,})|([\\\/\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
	
}

	return !objRegExp.test(strValue);
	
}
function validateAlphaNumericWithoutSlash( strValue ) {
	
	//var objRegExp  = /[^a-z*(\d)]/i;
	//Change by tarun
	var objRegExp=/(\s{2,})|([\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\n\r])/i

	//Change by tarun to allow ".","-",","
	//var objRegExp=/(\s{2,})|([\\\/\(\)\_\:\@\$\*\"\&\`\#\ï¿½\ï¿½\?\n\r])/i
	
	return !objRegExp.test(strValue);
	
}
function validateMetaCharacters( strValue ) {
	var objRegExp=/(\s{2,})|([\\\/\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
	
}
// javed khan on 25/10/2013
function validateMetaCharactersWithSlash( strValue ) {
	var objRegExp=/(\s{2,})|([\\\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);	
}

//Vinay saini on 08/03/2016
function validateMetaAddressCharacters( strValue ) {
	//alert("ss");
	var objRegExp=/([\\\_\:\@\$\*\"\&\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
		return !objRegExp.test(strValue);
}
//javed khan on 07/11/2013
function validateMetaCharactersWithSpace( strValue ) {
	var objRegExp=/([\\\/\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
}

//javed khan on 07/11/2013
function validateMetaCharactersWithBrace( strValue ) {
	var objRegExp=/(\s{2,})|([\\\/\.\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
	
}

//javed khan on 08/11/2013
function validateMetaCharactersWithSpaceAndBrac( strValue ) {
	var objRegExp=/([\\\/\.\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
}

//javed khan on 08/11/2013
function validateMetaCharactersExam( strValue ) {
	var objRegExp=/([\\\_\:\@\$\*\"\&\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
	
}
function validateMetaCharWithSpaceSlashDash( strValue ) {
	var objRegExp=/([\\\.\(\)\_\:\@\$\*\"\&\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
}

//javed khan on 07/11/2013
function validateMetaCharactersWithSpaceDas( strValue ) {
	var objRegExp=/([\\\/\.\(\)\_\:\@\$\*\"\&\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
}
function validateMetaCharactersWithSpaceAndSlash( strValue ) {
	var objRegExp=/([\\\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
}
function isGoodDate(dt){
  //  var reGoodDate = /^(?:(0[1-9]|1[012])[\/.](0[1-9]|[12][0-9]|3[01])[\/.](19|20)[0-9]{2})$/;
    //var reGoodDate = /^(?:(0[1-9]|[12][0-9]|3[01])[\/.](0[1-9]|1[012])[\/.](19|20)[0-9]{2})$/;
	var reGoodDate = /^(?:(0[1-9]|[12][0-9]|3[01])[\/.](0[1-9]|1[012])[\/.](19|20)[0-9]{2})$/;
    return reGoodDate.test(dt);
}

function validatePvms( strValue ) {
	
	var objRegExp=/(\s{2,})|([\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
	return !objRegExp.test(strValue);
	
}


function validateButton( strValue ) {
	
	var objRegExp=/(\s{2,})|([\\\/\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i

	return !objRegExp.test(strValue);
	
}

function validateLifeStyleFactor(strValue)
{
	
	var objRegExp=/([\\\.\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\%\&\<\>\=\n\r])/i
		return !objRegExp.test(strValue);
	}

function validateRegName( strValue ) {
	
	var objRegExp  = /[^a-z*(\d\,\\\/\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\n\r )]/i;
	if(!(parseInt(strValue)>0)){
		if(strValue.substring(0,1)=="," || strValue.substring(0,1) == "." || strValue.substring(0,1) == "-" || strValue.substring(0,1) == "'" ){
			return false;
		}
		else{
			return !objRegExp.test(strValue);
		}
	}
  	return false;
}

function validateAlphaSpace( strValue ) {
	
	var objRegExp  = /[^a-z*(\d\,\\\/\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\n\r )]/i;
	if(!(parseInt(strValue)>0)){
		if(strValue.substring(0,1)=="," || strValue.substring(0,1) == "." || strValue.substring(0,1) == "-" || strValue.substring(0,1) == "'" ){
			return false;
		}
		else{
			return !objRegExp.test(strValue);
		}
	}
  	return false;
}

function validatePhone( strValue ) {
		var objRegExp  = /^((\+\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,5})|(\(?\d{2,6}\)?))(-| )?(\d{3,4})(-| )?(\d{4})(( x| ext)\d{1,5}){0,1}$/
  		return objRegExp.test(strValue);
}

function validateInteger( strValue ) {
  var objRegExp  = /(^\d\d*$)/;
  return objRegExp.test(strValue);
}

function validateAddress(strValue) {
	 var objRegExp = /[^a-z*(\d\,\\\/\.\(\)\_\:\"\&\-\'\`\#\ï¿½\ï¿½\n\r )]/i;
     if(strValue.substring(0,1)=="," || strValue.substring(0,1) == "." || strValue.substring(0,1) == "-" || strValue.substring(0,1) == "'" ){
             return false;
     }
     else{
             return !objRegExp.test(strValue);
     }
     return false;

}

function validateEmail(strValue) {
	//var objRegExp  =/^([a-zA-Z_\.\-][\w]*[a-zA-Z0-9\_])+\@(([a-zA-Z0-9\-])+\.)+(([a-zA-Z]{2,4})*([a-zA-Z]{2,4}))+$/;
	var objRegExp  = /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/;
	return objRegExp.test(strValue);
//if(objRegExp.test(strValue))
   //return checkEmail(strValue);

}

function validateFloat( strValue ) {
 	//var objRegExp  =/^((\+|-)\d)?\d*(\.\d{2})?$/;
 //	var objRegExp  =/^([+\-])?\d*([\.])?\d*([eE]([+\-])?)?\d*$/;
//	var objRegExp  =/^d*([\.])?\d*([eE]([+\-])?)?\d*$/;
	var objRegExp  = /^(?=.+)(?:[1-9]\d*|0)?(?:\.\d+)?$/;
 	return objRegExp.test(strValue);
}


function checkEmail(strValue)
	{
		var checkEmail=true;
 		var mytool_array=strValue.split("@");
		var afterRateArray= mytool_array[1].split(".");	

 		if(afterRateArray.length>3) {
 			checkEmail=false;
 		}
 		else if(afterRateArray.length == 3){ 
 		   if(afterRateArray[1].length>2 || afterRateArray[2].length>2){
 		    checkEmail=false;
 		   }
 		}   
 		else if(afterRateArray.length == 2){
 		   if(afterRateArray[1].length>3 || afterRateArray[1].length == 2){
 		   checkEmail=false;
 		   }
 		}
 	
 		if(!checkEmail)
 		{
 			return false;
 		}
 		
 		return true;
 	}


function submitFormCancel(formName,action){ 
			obj = eval('document.'+formName)
			obj.action = action;
		
			obj.submit();
			return true;
}

function checkBlankForAdd(){
  
	var code = document.getElementById("id").value;
	if(trimAll(code) == ""){
			errorMsg += "Code cannot be blank.\n";
		return false;	
	}
		return true;
}
// -------------------------- Room -------------------
function checkBlankForAddRoom(){
  
  	var depName = document.getElementById("depName").value;
	var roomType = document.getElementById("roomType").value;
	if(trimAll(depName) == ""){
			errorMsg += "Department Name cannot be blank.\n";
	}
	if(trimAll(roomType) == ""){
			errorMsg += "Room Type cannot be blank.\n";
		
	}
		return true;
}

function checkBlankForAddDistrict(){
  
  	var state = document.getElementById("state").value;
  	var code = document.getElementById("id").value;
	if(trimAll(code) == ""){
			errorMsg += "Code cannot be blank.\n";
		return false;	
	}
	if(trimAll(state) == ""){
			errorMsg += "State cannot be blank.\n";
		
	}
		return true;
		
}

function checkBlankCountry(){
var countName=document.getElementById("countName").value;
if (trimAll(countName) == ""){
errorMsg += "Currency Name cannot be blank.\n";
}
return true;
}

function checkBlank(){

	var id = document.getElementById('commonId').value;
	var name = document.getElementById('searchname').value;
	
	if(id == 0 && trimAll(name) == ""){
		errorMsg += "Please select any Name.\n";
		return false;
	}
	if(id != 0 && trimAll(name) == ""){
		errorMsg += "Name cannot be blank.\n";
		return false;
	}
	
	return true;
}

function checkBlankForAddBed(){
  
	var ward = document.getElementById("wardId").value;
	var room = document.getElementById("roomId").value;
	var bedStatus = document.getElementById("bedStatusId").value;
	
	if(trimAll(ward) == ""){
			errorMsg += "Ward cannot be blank.\n";
	}
	if(trimAll(room) == ""){
			errorMsg += "Room Code cannot be blank.\n";
	}
	if(trimAll(bedStatus) == ""){
			errorMsg += "Bed Status cannot be blank.\n";
	}
		return true;
}

function checkBlankCountry(){
	var countName=document.getElementById("countName").value;
	var id = document.getElementById("id").value;
	if(trimAll(id) == ""){
				errorMsg += "Code cannot be blank.\n";
		}
	if (trimAll(countName) == ""){
	errorMsg += "Currency Name cannot be blank.\n";
	}
	return true;
}

function checkBlankState(){
	var countName=document.getElementById("countName").value;
	var id = document.getElementById("id").value;
	if(trimAll(id) == ""){
				errorMsg += "Code cannot be blank.\n";
		}
	if (trimAll(countName) == ""){
	errorMsg += "Country Name cannot be blank.\n";
	}
	return true;
}

function checkBlankForAddDepartment(){
  
	var departmentType = document.getElementById("departmentTypeId").value;
	var costCenter = document.getElementById("costCenterId").value;
	var id = document.getElementById("id").value;
	
	if(trimAll(id) == ""){
			errorMsg += "Code cannot be blank.\n";
	}
	if(trimAll(departmentType) == ""){
			errorMsg += "Department Type cannot be blank.\n";
	}
	if(trimAll(costCenter) == ""){
			errorMsg += "Cost Center cannot be blank.\n";
	}
	return true;
}


//Added by tarun to change the date from yyyymmdd (stored in database) to ddmmyyyy
function changeDateToddMMyyyy(strDate)
{
	var strNewDate="",year="",ch="",dt="",month="";
	
	year=strDate.substring(0,4);
	month=strDate.substring(5,7);
	dt=strDate.substring(8,10);
	strNewDate= (dt + "/" + month + "/" + year);
	return strNewDate;
}




//-----------------Added By Ruchi ----------------------------------------------

function fetchValue(obj,formName){
                      
  object =    eval('document.'+formName)
     if(obj.value != ""){
     for(var i = 0;i<commonArray.length;i++ ){
      if(commonArray[i][0] == obj.value){
      	 
      	   object.code.value = commonArray[i][1];
           object.search_name.value = commonArray[i][2];
           object.changed_by.value = commonArray[i][4];
           object.changed_date.value = changeDateToddMMyyyy(commonArray[i][5]);
           object.changed_time.value = commonArray[i][6];
           if(commonArray[i][3] == "y")
               object.status[0].checked = true;
           else
               object.status[1].checked = true;
           break;
       } 
   }
  } 
  else{
           object.code.value = "";
           object.search_name.value = "";
           object.changed_by.value = "";
           object.changed_date.value = "";
           object.changed_time.value = "";
           object.status[0].checked = true;
 } 
  
}

function fetchName(obj,formName){
  var object =    eval('document.'+formName)
  if(obj.value != ""){
    for(var i = 0;i<codeNameArray.length;i++ ){
      if(codeNameArray[i][0] == obj.value){
          
           object.related_table_id.value = codeNameArray[i][2];
          
           break;
       } 
   }
  } 
  else{
             object.related_table_id.value = "";
  } 
    
}

function fetchAllValue(obj,formName){
        
  object =    eval('document.'+formName)
  if(obj.value != ""){
   for(var i = 0;i<commonArray.length;i++ ){
      if(commonArray[i][0] == obj.value){
          
           object.code.value = commonArray[i][1];
           object.search_name.value = commonArray[i][2];
           object.changed_by.value = commonArray[i][5];
           object.changed_date.value = changeDateToddMMyyyy(commonArray[i][6]);
           object.changed_time.value = commonArray[i][7];
           if(commonArray[i][4] == "y")
               object.status[0].checked = true;
           else
               object.status[1].checked = true;
               
       
           for(var j= 0;j<codeNameArray.length;j++){
                 if(commonArray[i][3] == codeNameArray[j][0]) {
                    object.related_table_id.value = commonArray[i][3];
                    object.related_table_name.value = codeNameArray[j][2];
                    break;
                 }     
           }    
           break;
       } 
   }
  } 
  else{
           object.code.value = "";
           object.search_name.value = "";
           object.changed_by.value = "";
           object.changed_date.value = "";
           object.changed_time.value = "";
           object.status[0].checked = true;
           object.related_table_id.value = "";
           object.related_table_name.value = "";
 } 
  
}


function fetchDepartmentValue(obj,formName){
           
  object = eval('document.'+formName)
  if(obj.value != ""){
   for(var i = 0;i<commonArray.length;i++ ){
      if(commonArray[i][0] == obj.value){
          
           object.code.value = commonArray[i][1];
           object.search_name.value = commonArray[i][2];
           object.department_type_id.value = commonArray[i][3];
           object.cost_center_id.value = commonArray[i][4];
           object.changed_by.value = commonArray[i][6];
           object.changed_date.value = changeDateToddMMyyyy(commonArray[i][7]);
           object.changed_time.value = commonArray[i][8];
           if(commonArray[i][5] == "y")
               object.status[0].checked = true;
           else
               object.status[1].checked = true;
           break;
       } 
   }
  } 
  else{
           object.code.value = "";
           object.search_name.value = "";
           object.department_type_id.value = "";
           object.cost_center_id.value = "";
           object.changed_by.value = "";
           object.changed_date.value = "";
           object.changed_time.value = "";
           object.status[0].checked = true;
 } 
  
}

function fetchDistrictValue(obj,formName){
           
  object = eval('document.'+formName)
  if(obj.value != ""){
   for(var i = 0;i<commonArray.length;i++ ){
      if(commonArray[i][0] == obj.value){
          
           object.code.value = commonArray[i][1];
           object.search_name.value = commonArray[i][2];
           object.state_id.value = commonArray[i][3];
           object.changed_by.value = commonArray[i][5];
           object.changed_date.value = changeDateToddMMyyyy(commonArray[i][6]);
           object.changed_time.value = commonArray[i][7];
           object.state.value = commonArray[i][8];
           if(commonArray[i][4] == "y")
               object.status[0].checked = true;
           else
               object.status[1].checked = true;
           break;
       } 
   }
  } 
  else{
           object.code.value = "";
           object.search_name.value = "";
           object.state_id.value = "";
           object.changed_by.value = "";
           object.changed_date.value = "";
           object.changed_time.value = "";
           object.status[0].checked = true;
 } 
  
  
}


function fetchHospitalDetails(obj,formName){
           
  object = eval('document.'+formName)
  if(obj.value != ""){
   for(var i = 0;i<commonArray.length;i++ ){
      if(commonArray[i][0] == obj.value){
          
           object.hospital_code.value = commonArray[i][1];
           object.search_name.value = commonArray[i][2];
           object.address.value = commonArray[i][3];
           object.contact_number.value = commonArray[i][4];
           object.changed_by.value = commonArray[i][6];
           object.changed_date.value = changeDateToddMMyyyy(commonArray[i][7]);
           object.changed_time.value = commonArray[i][8];
           if(commonArray[i][5] == "y")
               object.status[0].checked = true;
           else
               object.status[1].checked = true;
           break;
       } 
   }
  } 
  else{
           object.hospital_code.value = "";
           object.search_name.value = "";
           object.address.value = "";
           object.contact_number.value = "";
           object.changed_by.value = "";
           object.changed_date.value = "";
           object.changed_time.value = "";
           object.status[0].checked = true;
 } 
  
  
}


//////////////////////////////////End ////////////////////////////////////////////////////////

function trimAll( strValue ) {
 var objRegExp = /^(\s*)$/;

    //check for all spaces
    if(objRegExp.test(strValue)){
       strValue = strValue.replace(objRegExp, '');
       if( strValue.length == 0)
          return strValue;
    }

   //check for leading & trailing spaces
   objRegExp = /^(\s*)([\W\w]*)(\b\s*$)/;
   if(objRegExp.test(strValue)) {
       //remove leading and trailing whitespace characters
       strValue = strValue.replace(objRegExp, '$2');
    }
  return strValue;
}

currentRowClicked=""
function clearRecords(obj){
		if(document.getElementById('multiplebutton'))
			document.getElementById('multiplebutton').style.display = "none";	
	if(currentRowClicked != ""){
		editRecord(document.getElementById(currentRowClicked),formName)

	}
	
	obj.blur();
}
//////////////////////////////////////////    Charge Code by Mansi ///////////////////////

function results(obj){
	if(obj.checked == true){
		
		document.getElementById('show').style.display = "block";
		}
	else{
		document.getElementById('show').style.display = "none";
		}
}

function multipleResults(obj){
	if(obj.checked == true){
		
		document.chargeCode.multiple.style.display = "block";
		}
	else{
		document.chargeCode.multiple.style.display = "none";
		}
}


showOnSamePage = true;
addAction = true;
rowsPerPage = 5;
totalPages =""
currentColor = "odd";

function intializeHover(id, nodeName, className){
	navRoot = document.getElementById(id);
	if(!navRoot)
		return;
	for (i=0; i<navRoot.childNodes.length; i++) {
		node = navRoot.childNodes[i];
		if (node.nodeName==nodeName) {
			node.onmouseover=function() {
				this.className+= className;
			}
			node.onmouseout=function() {
				this.className=this.className.replace(className, "");
			}
		}
	}
}

/*--------------Hover on TR's for IE Ends-----------------------------*/
/*----------------------------Set Scrolling Area of every page according to screen resolution--------------*/

function checkSize() {
  var myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    //Non-IE
    myHeight = window.innerHeight-138;
  } 
  else {
  	  if( document.documentElement &&
	    ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
      //IE 6+ in 'standards compliant mode'
      myHeight = document.documentElement.clientHeight-168;
    } 
	else {
      if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
        //IE 4 compatible
        myHeight = document.body.clientHeight-142;
      }
    }
  }
  return myHeight;
}

/*----------------------------Set Scrolling Area Ends--------------------*/


/*-------------------Some General Functions---------------------------*/
function findDiv(obj){
	while(obj.nodeName != 'DIV'){
			obj = obj.nextSibling;
	}
	return obj;
}
window.onresize = function (){
	if(document.getElementById('content')){
		document.getElementById('content').style.height = checkSize()+"px";
	}
}


function editForm(formName,action){
		errorMsg = "";
		if(currentRowClicked == ""){
			alert("Select a record to update");
			return false;
		}
		obj = eval('document.'+formName) 
		if(validateFields(formName)== true){
			undoDisabled();		
			obj.action = action;
			obj.submit();
		}
		else{
	    	alert(errorMsg);
	       	return false;			
		}
}

deleteMessage ="Are you sure to InActivate this record?"
function deleteForm(formName,action){
		obj = eval('document.'+formName) 
		if(currentRowClicked == ""){
			alert("Select a record to InActivate");
			return false;
		}

		undoDisabled();
		if(confirm(deleteMessage)){
			obj.action = action;
			obj.submit();
		}
}


subtest_arr = new Array();
data_arr = new Array();
currentRowClicked=""
nonEditable="";
nonEditable1="";


function editRecord(obj,formName)
{
	
	tmptext = ""
	if(formName == 'users'){
		 		var e3 = document.getElementById('pwd').disabled=true;
		   		e3.length = 0;
			}
	if(currentRowClicked != "" )
	{
		if(subtest_arr.length>0)
		{
			document.chargeCode.multipleresults.checked= false;
			document.getElementById('multiplebutton').style.display = 'none';
		}
		if(nonEditable)
		{
			for(m=0;m<nonEditable.length;m++)
			{
				nonEditableObj = eval("document."+ formName + "."  + nonEditable[m])
				if(nonEditableObj)
				{
					if(nonEditableObj.type == "select-one")
					{
						nonEditableObj.disabled = false;			
					}
					else
						nonEditableObj.readOnly = false;
				}
			}
		}
					
		if(document.getElementById(currentRowClicked))
			document.getElementById(currentRowClicked).style.backgroundColor = "";
		document.getElementById('edited').innerHTML = " "
		if(document.getElementById('addbutton'))
			document.getElementById('addbutton').style.display = 'inline'
		if(document.getElementById('editbutton')) {	
	 		/*if(formName == 'item'){
		 		var e3 = document.getElementById('item_master_brand');
		   		e3.length = 0;
			}*/
			document.getElementById('editbutton').style.display = 'none';
		}	
		if(document.getElementById('deletebutton'))	
			document.getElementById('deletebutton').style.display = 'none';			
		
		for(i=0;i<formFields.length;i++)
		{
			temp = eval("document."+ formName + "." +  formFields[i][1]);
			if(formName == 'chargeCode'){
				document.getElementById('goDiv').style.display='none';
			}
			if(temp)
			{
				if (temp.type == "select-one")
					temp.selectedIndex = 0;
				else if(temp.type == "checkbox")
				{
						temp.checked = false;
				}
				else	temp.value = "";
			}
		}
	}
	
	if(currentRowClicked != obj.id)
	{	
		
		changeButton(obj.id,formName);
		deleteobj = eval("document."+ formName )
		deleteTd = data_arr[findArrayElement(data_arr,obj.id)][statusTd]
		if(deleteTd.toLowerCase()=="inactive")
		{
			if(document.getElementById('editbutton'))
			document.getElementById('editbutton').style.display = 'none'
		}
		else if(document.getElementById('editbutton')){
			if(formName == 'item'){
				submitProtoAjaxWithDivName('item','/hms/hms/pharmacy?method=showMatchedBrandList&itemId='+obj.id,'testDivForBrand')
//				submitProtoAjax('item','/hms/hms/pharmacy?method=showMatchedBrandList&itemId='+obj.id);
			}
						
			document.getElementById('editbutton').style.display = 'inline'
		}
		if(document.getElementById('deletebutton')){
			if((formName == 'menuItemFormula' || formName == 'extraItemFormula' || formName == 'indentItemFormula') && deleteTd.toLowerCase() == "inactive"){
				document.getElementById('deletebutton').style.display = 'none'
				}else{
				if(formName != 'OtListChange1')
					document.getElementById('deletebutton').style.display = 'inline'
				}
		}	
			
		if(document.getElementById('addbutton'))	
			document.getElementById('addbutton').style.display = 'none';
		if(subtest_arr.length>0){
			chkMultipleTest(obj.id);
		}
		if(nonEditable)
		{
			for(m=0;m<nonEditable.length;m++)
			{
				nonEditableObj = eval("document."+ formName + "."  + nonEditable[m])
				if(nonEditableObj){
					if(nonEditableObj.type == "select-one"){
						nonEditableObj.disabled = true;			
					}
					else
						nonEditableObj.readOnly = true;
				}
			}
		}

		obj.style.backgroundColor = '#9CCEF8'
		currentRowClicked=obj.id;
		for(i=0;i<formFields.length;i++){
			temp = eval("document."+ formName + "."  +  formFields[i][1]);
			
			if(formFields[i][1] == "addEditBy" && formName!='chargeCode'){
				tmptext += "<label >last Edited By:</label><span style='width: 180px'>"+ obj.cells[formFields[i][0]-1].childNodes[0].innerHTML +"</span>"
			}else if(formFields[i][1] == "addEditBy"){
				tmptext += "<label style='display:none;'>last Edited By:</label><span style='width: 180px; display:none;'>"+ obj.cells[formFields[i][0]-1].childNodes[0].innerHTML +"</span>"
			}
			if(formFields[i][1] == "addEditOn" && formName!='chargeCode'){
				tmptext += "<label style='float: left; width: 90px'>On:</label><span style='width: 180px'>"+ obj.cells[formFields[i][0]-1].childNodes[0].innerHTML +"</span>"				
			}else if(formFields[i][1] == "addEditOn"){
				tmptext += "<label style='float: left; width: 90px; display:none;'>On:</label><span style='width: 180px; display:none;'>"+ obj.cells[formFields[i][0]-1].childNodes[0].innerHTML +"</span>"			
			}

			if(temp){
				
				if(temp.type == "select-one"){
					if(formName == "subTest"){
						temp.selectedIndex = findElementIndex(temp, obj.cells[formFields[i][0]-1].innerHTML);
					}
					else{
						if(formName == "chargeCode"){
							var tempValue = obj.cells[formFields[i][0]-1].childNodes[0].innerHTML;
							
							if(tempValue.indexOf('&amp;') != -1){
								tempValue = replaceSubstring(tempValue, '&amp;', '&');
							}
							if(temp.id == 'investigationType'){
								if(tempValue == 't' || tempValue == 'm'){
									document.getElementById('goDiv').style.display='inline';
								}else{
									document.getElementById('goDiv').style.display='none';
								}
							}
							temp.selectedIndex = findElementIndex(temp, tempValue);
						}else{
							temp.selectedIndex = findElementIndex(temp, obj.cells[formFields[i][0]-1].childNodes[0].innerHTML);
						}
						//temp.selectedIndex = findElementIndex(temp, obj.cells[formFields[i][0]-1].childNodes[0].innerHTML);
					}
				}
				else if(temp.type == "radio"){
					if(obj.cells[formFields[i][0]-1].childNodes[0].innerHTML == '1' || obj.cells[formFields[i][0]-1].childNodes[0].innerHTML == 'y')
						temp.checked = obj.cells[formFields[i][0]-1].childNodes[0].innerHTML;
				}
				else if(temp.type == "checkbox"){
					if(obj.cells[formFields[i][0]-1].childNodes[0].innerHTML == '1' || 	obj.cells[formFields[i][0]-1].childNodes[0].innerHTML=='y'){
						temp.checked = obj.cells[formFields[i][0]-1].childNodes[0].innerHTML;
					}
				}
				else if(temp.type == "select-multiple")
				{   
					if (temp.id == "item_master_brand")
					{
							var brand_ids =  obj.cells[formFields[i][0]-1].childNodes[0].innerHTML;
							bar = new Array();
			  				bar  = brand_ids.split(",");
			  				var all_brand = document.getElementById('all_item_master_brand')
			  				temp.options.length=0;
			  				for(var l=0; l<all_brand.length;l++)
							{
								for(var m=0; m<bar.length;m++)
								{
									if (all_brand[l].value == bar[m])
									{ 
									temp.length++;
									temp.options[temp.length-1].value=all_brand.options[l].value;
									temp.options[temp.length-1].text=all_brand.options[l].text;
									break;
									}
								}
							}
					}
					else
					{
						if(formName == "dietMenuItem"){
							temp.selectedIndex = findElementIndex(temp, obj.cells[formFields[i][0]-1].childNodes[0].innerHTML);
						}else{
				    		var brand_ids =  obj.cells[formFields[i][0]-1].childNodes[0].innerHTML;
							bar = new Array();
			  				bar  = brand_ids.split(",");
		
							for(var k=0; k<temp.length;k++)
			  				{
			  					temp[k].selected = false;
			  				}
			  				
		  					for(var l=0; l<temp.length;l++)
							{
								for(var m=0; m<bar.length;m++)
								{
									if (temp[l].value == bar[m])
									{ 
									temp[l].selected = true;
									break;
									}
								}
							}
						}
					}
				}
				else{
					if(i==0)
						temp.value = obj.id;
					else{
						if(formName == "subTest"){
							temp.value = obj.cells[formFields[i][0]-1].innerHTML;
						}
						else
							temp.value = obj.cells[formFields[i][0]-1].childNodes[0].innerHTML;
						if(temp.value.indexOf('&amp;') != -1){
							temp.value = replaceSubstring(temp.value, '&amp;', '&')
						}
					}
				}
			}
		}
	}
	else if(currentRowClicked == obj.id){
		if(subtest_arr.length>0){
			document.chargeCode.multipleresults.checked= false;
			document.getElementById('multiplebutton').style.display = 'none';
		}
		currentRowClicked = "";
	}
	if(tmptext != ""){
		document.getElementById('edited').innerHTML = tmptext;	
	}
	// Added for SMQ Master ---------------------------
	
	var smq = data_arr[findArrayElement(data_arr,obj.id)][7]
if(document.getElementById('smqStatus')){
	if(smq == "Occupied" ){
		document.getElementById('smqStatus').style.display = 'none';
		document.getElementById('smq').style.display = 'none';
	}else{
		document.getElementById('smqStatus').style.display = 'inline';
		document.getElementById('smq').style.display = 'inline';
	}
}
	//-------------------------------------------------------	
}

function undoDisabled(){
	for(m=0;m<nonEditable.length;m++){
		nonEditableObj = eval("document."+ formName + "."  + nonEditable[m])
			if(nonEditableObj){
				if(nonEditableObj.type == "select-one"){
					nonEditableObj.disabled = false;
				}
			}
	}
}
function findArrayElement(arr, findWhat){
	for(cnt=0;cnt<arr.length;cnt++){
		if(arr[cnt][0]==findWhat){
			return cnt;
		}
	}
}
statusTd = "";
function changeButton(id,formName){
	if(statusTd!=""){
		deleteTd = data_arr[findArrayElement(data_arr,id)][statusTd]
		if(deleteTd != ""){
			if(formName != "OtListChange1"){
		fobj = eval("document."+formName);
		if(deleteTd.toLowerCase()=="active"){
			fobj.Delete.value="InActivate"
		}
		else{
					if(formName != "menuItemFormula"  || formName != 'extraItemFormula' || formName != 'indentItemFormula'){
			fobj.Delete.value="Activate"
					}else{
					document.getElementById('deletebutton').style.display = 'none'
					}
				}
			}
		}
		
	}
}

function findElementIndex(obj, txt){
	for(j=0;j<obj.length;j++){
		if(trimAll(obj[j].text) == trimAll(txt) || trimAll(obj[j].value) == trimAll(txt)){
			return j;
		}
	}
}


showOnSamePage = true;
addAction = true;
rowsPerPage = 5;

totalPages =""
currentColor = "odd";
	
function makeTable(starter, end){
	console.log(formName);
	console.log("aaas");
	
if(document.getElementById("rowsPerPageForItem")!=null)
		{
        
		if(document.getElementById("rowsPerPageForItem").value == 10){
		rowsPerPage = 10;
		}
		}
			
    totalPages = Math.ceil(data_arr.length/rowsPerPage);
    document.getElementById("total").innerHTML=totalPages
  
    if(data_arr.length<5)
    {
    	//document.getElementById("currEnd").innerHTML=data_arr.length
    	document.getElementById("currEnd").value=data_arr.length
    }
    //document.getElementById("totalRecs").innerHTML=data_arr.length
    document.getElementById("totalRecs").value=data_arr.length
    if(totalPages==0){
	    document.getElementById('searchtable').style.width = "50%"
    	document.getElementById('searchtable').style.textAlign = "left"
        document.getElementById('searchtable').innerHTML = '<h4>No Records Found</h4>'
		document.getElementById('resultnavigation').style.display="none";
        return;
    }
    else if(totalPages == 1){
		document.paging.lastpage.disabled= true;
		document.paging.nextpage.disabled= true;
		document.paging.lastpage.className="nextDisable"
		document.paging.nextpage.className="singleNext"    
    }
    document.getElementById('resultnavigation').style.display="inline";
    //document.getElementById('pageno').length=totalPages
    for(pg=1;pg<=totalPages;pg++){
        //document.getElementById('pageno')[pg-1].value = pg
        //document.getElementById('pageno')[pg-1].text = pg            
    }
    	
    start = starter;
    //alert("2");
    
    if(data_header){
                tempTable = '<div class="clear"></div><div class="cmntable"><table border="0" cellspacing="0"  cellpadding="0" ><thead><tr>'
        for(cols=0;cols<data_header.length;cols++){
            if(data_header[cols][1]=="data"){
                tempTable += '<th  width="';
                if(data_header[cols][2]!=0)
                    tempTable +=  data_header[cols][2];
          //      tempTable += '">'+data_header[cols][0]+'<a href="javascript:sortTable('+cols+',\'up\')"><img src="/hms/jsp/images/arrowUp.gif" /></a><a href="javascript:sortTable('+cols+',\'dn\')"><img src="/hms/jsp/images/arrowDown.gif" /></a></th>'
                tempTable += '">'+data_header[cols][0]+'</th>'
            }
            else if(data_header[cols][1]=="hide"){
                    tempTable += '<th class="hide">&nbsp;</th>'
            }else if(data_header[cols][1]=="radio"){
            		 tempTable += '<th class="gridheadtext" width="';
                if(data_header[cols][2]!=0)
                    tempTable +=  data_header[cols][2];
                tempTable += '">'+data_header[cols][0]+'</th>'
            	}
        }
        tempTable += '<tr></thead><tbody id="searchresulttable">'
    console.log(formName)
        for(rows=start;rows<end; rows++){
        	if(formName == "pendingSampleCollection" || formName == "pendingSampleValidation"){
				tempTable += '<tr id="'+data_arr[rows][0]+'" class="default'  
				tempTable += '"'; 
            	if(data_arr[rows][12] == "1"){
            		tempTable +=' bgcolor="#FA7676" '
            	}else if(data_arr[rows][12] == "2"){
            		tempTable +=' bgcolor="#F7ED9B" '
            	}else if(data_arr[rows][12] == "3"){
            		tempTable +=' bgcolor="#A0E0AA" '
            	}
            	
            }else if(formName == "issuedPrescription"){
				tempTable += '<tr  id="'+data_arr[rows][0]+'" class="default'  
				tempTable += '"'; 
				tempTable +=' bgcolor="#C7B097" disabled="true"'
            }     
            else if(formName == "completedCollection"){
				tempTable += '<tr  id="'+data_arr[rows][0]+'" class="default'  
				tempTable += '"'; 
				tempTable +=' bgcolor="#B4B4B4" disabled="true"'
            } 
            else if(formName == "pendingPrescription"){
				tempTable += '<tr  id="'+data_arr[rows][0]+'" class="default'  
				tempTable += '"'; 
            	if(data_arr[rows][14] == "Pending"){
            		//alert(data_arr[rows][19])
            		tempTable +=' bgcolor="#FA7676" disabled="true"'
            	}else{
            		tempTable +=' bgcolor="#A0E0AA" '
            	}
            }
            else if(formName == "pendingNIPPrescription"){
            	tempTable += '<tr  id="'+data_arr[rows][0]+'" class="default'  
				tempTable += '"'; 
            	if(data_arr[rows][13] == "Approved"){
            		//alert(data_arr[rows][19])
            		tempTable +=' bgcolor="#FA7676" disabled="true"'
            	}else{
            		tempTable +=' bgcolor="#A0E0AA" '
            	}
            }        	
            else if(formName == "pendingResultForLab"){
				tempTable += '<tr id="'+data_arr[rows][0]+'" class="default'  
				tempTable += '"'; 
            	if(data_arr[rows][18] == "1"){
            		tempTable +=' bgcolor="#FA7676" '
            	}else if(data_arr[rows][18] == "2"){
            		tempTable +=' bgcolor="#F7ED9B" '
            	}else if(data_arr[rows][18] == "3"){
            		tempTable +=' bgcolor="#A0E0AA" '
            	}
            }else if(formName == "pendingResultValidationLab"){
				tempTable += '<tr id="'+data_arr[rows][0]+'" class="default'  
				tempTable += '"'; 
            	
            	
            	if(data_arr[rows][18] == "6hrs")
            		{
            			tempTable +=' bgcolor="#FF0000" '
            		}
            	else
            		{
	            		if(data_arr[rows][17] == "1"){
	                		tempTable +=' bgcolor="#FA7676" '
	                	}else if(data_arr[rows][17] == "2"){
	                		tempTable +=' bgcolor="#F7ED9B" '
	                	}else if(data_arr[rows][17] == "3"){
	                		tempTable +=' bgcolor="#A0E0AA" '
	                	}
            		}
            	
            }else{
        	
               if(formName == "movementIn"){
                tempTable += '<tr id="'+data_arr[rows][0]+'" class="'
                }else{
                tempTable += '<tr id="'+data_arr[rows][0]+'" class="'
                }
                
				if(rows%rowsPerPage == 0 && rows != 0){
			
					currentColor = "odd"	
				}

                tempTable += currentColor;   	            
				currentColor = (currentColor == "odd")?"even" : "odd";
				tempTable += '"'; 
            }
            tempTable += '>'
                
                for(columns=1;columns<=data_header.length;columns++){
                	if(formName!='opdPatientPrevVisitForViewScreen' && formName!='phyWaitingList'){
                    tempTable += '<td '
                  
                    if(data_header[columns-1][1] == "hide")
                        tempTable += 'class="hide"';
                    	tempTable +='>';
                    if (formName=='patientEnquiry'  || formName=='patientSearch'||formName=='preAnaesthesiaPatientSearch' || formName=='patientEnquiry1')
                    {   
                       	tempTable += '<a href="javascript:Request((\''+data_arr[rows][2]+'\'),\''+formName+'\')">';
                    }
                    else if(formName=='postAnaesthesiaPatientSearch' || formName=='otProcedureNotesEntry' || formName=='specimenDispatchEntryPatientSearch' || formName=='dentalWaitingList'  ||   formName=='pendingForPreOperativeCheckList' ||   formName=='pendingForSurgeryConsentForm' || formName =='transferToWardPatientSearch' || formName =='pendingSurgeryWaitingList' || formName =='lrWaitingList' || formName =='laborPatientTransfer'|| formName =='pacList'|| formName =='preAnaesthesiaWaitingList' ||formName=='emergencyOPDWaitingList' ) 
                    {
                    	tempTable += '<a href="javascript:Request((\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     /*;;;;;;;;;;;;;;;;; add by yogesh ;;;;;;;;;;;;;;;;;;;;;;;;*/
               //    else if(formName=="searchGrn")
                    // {
                //     tempTable += '<a href="javascript:RequestForLoanInUpdate(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                  //   }
                     else if(formName == "employeeUpdate")
                    {
                   		tempTable += '<a href="javascript:RequestForEmployeeUpdate(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }else if(formName == 'opdPatientPrevVisitForViewScreen')
                    {
                    	
                    	tempTable += '<a href="javascript:RequestForViewScreen((\''+data_arr[rows][13]+'\'),(\''+data_arr[rows][14]+'\'),(\''+data_arr[rows][3]+'\'),(\''+data_arr[rows][17]+'\'),\''+formName+'\')">';
                    }else if(formName == 'opd_previousVisitForMedicalExamp')
                    {
                    	tempTable += '<a href="javascript:showmedicalBoardMedicalOfficersearch(\''+data_arr[rows][8]+'\',\''+data_arr[rows][11]+'\',\''+formName+'\',\''+data_arr[rows][0]+'\')">';
                    }else if(formName == 'opd_previousVisitForMedicalBoard')
                    {
                    	
                    	tempTable += '<a href="javascript:showmedicalBoardMedicalOfficerInitial(\''+data_arr[rows][13]+'\',\''+data_arr[rows][14]+'\',\''+formName+'\',\''+data_arr[rows][15]+'\')">';
                    }else if(formName == 'opd_previousVisitForHospitality')
                    {
                    	
                    	tempTable += '<a href="javascript:showmedicalBoardMedicalOfficersearch(\''+data_arr[rows][13]+'\'),(\''+data_arr[rows][14]+'\'),(\''+data_arr[rows][3]+'\'),(\''+data_arr[rows][17]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "otherPersonUpdate")
                    {
                   		tempTable += '<a href="javascript:RequestForotherPersonUpdate(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     else if(formName == "postedOut")
                    {
                    	tempTable += '<a href="javascript:RequestForPostedOut(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    } /*else if(formName == "leave")
                    {
                        tempTable += '<a href="javascript:RequestForLeaveEntry(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }*/
                     else if(formName == "leaveRestriction")
                    {
                     tempTable += '<a href="javascript:RequestForLeaveRestriction(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "leaveApplicationUpdate")
                    {
                     tempTable += '<a href="javascript:RequestForLeaveApplication(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     else if(formName == "updateProposalHRO")
                    {
                        tempTable += '<a href="javascript:RequestForSearchProposal(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     else if(formName == "updateHROEntry")
                    {
                        tempTable += '<a href="javascript:RequestForSearchHro(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
		   
                      else if(formName == "movementOut")
                    {
                        tempTable += '<a href="javascript:RequestForMovementOut(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][4]+'\',\''+formName+'\')">';
                    }
                    else if(formName == "movementIn")
                    {
                        tempTable += '<a href="javascript:RequestForMovementIn(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][4]+'\',\''+formName+'\')">';
                    }
                    else if(formName == "dutySearch")
                    {
                        tempTable += '<a href="javascript:RequestForDutySearch(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "leaveSearch")
                    {
                        tempTable += '<a href="javascript:RequestForLeaveSearch(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "leavePending")
                    {
                        tempTable += '<a href="javascript:RequestForLeavePending(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "updateArrival")
                    {
                        tempTable += '<a href="javascript:RequestForUpdateArrival(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName=='internalReferal' || formName=='searchExpiryDetails' || formName=='surgeryEnquiry' || formName=='patientVisit' || formName=='updateOrder' || formName=='updateRegistrationByName' || formName=='patientAdmission' || formName=='patientTransfer' || formName=='patientDischarge' && formName != 'finalDischarge'  || formName == "patientAdvance" || formName == "finalSettlement" || formName == "pendingSampleCollection" || formName == "pendingSampleValidation" ||formName=='patientSearchForDisposal' || formName=='patientSearchForEmergencyOTBooking' || formName=='patientSearchForPreAnesthesia' || formName=='orderNoList' || formName == 'pendingSampleValidationLab' || formName == 'patientVisitPhysiotherapy')
                    {
                     	tempTable += '<a href="javascript:Request(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                     }
                   else if(formName == "pendingResult"  || formName == 'partialPrescriptionForWard' || formName == 'pendingPrescriptionForWard' || formName == 'pendingPrescriptionForWardPartial' || formName == 'pendingPresWithoutBarCode' || formName=='minorWorkDetailSearch' || formName=='minorWorkDetailsApproval' ||  formName=='minorWorkDetailSearchForCompletionWork' || formName=='agendaPointsSearch' || formName=='medicalBoardProceedingSearch' || formName=='medicalBoardProceedingSearchForEmployee' || formName=='instructionToCandidateSearch' || formName=='certificateByTheCandidateSearch' || formName=='resultOfAppealMedicalboardSearch' || formName =='medicalBoardPreceedingsSearch1' || formName=='agendaPointsUpdateSearch' || formName == "majorWorkDetailSearch1" || formName=="momWorkDetailAgendaSearch1" || formName=="medicalBoardPreceedingsPrint" || formName=="medicalExaminationBoardPrint" || formName=="instructionToCandidatePrint" || formName=="certificateByTheCandidatePrint" || formName=="resultOfAppealMedicalboardPrint" || formName=="agendaPointsDetailSearch"  || formName == 'pendingPrescription1' || formName == 'pendingForPACConsulation' ||formName == 'pendingForAnesthesiaRecord')

                    {
                   		tempTable += '<a href="javascript:RequestForCharge(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                   else if(formName == 'pendingPrescription')

                   {
                	   if(data_arr[rows][14] == "Pending"){
                   		//alert(data_arr[rows][19])
                		   tempTable += '<a >';
                   	}else{
                   		tempTable += '<a href="javascript:RequestForCharge(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                   	}
                   }
                  		
                	   else if(formName == 'pendingNIPPrescription')

                       {
                    	   if(data_arr[rows][13] == "Approved"){
                       		//alert(data_arr[rows][19])
                    		   tempTable += '<a >';
                       	}else{
                       		tempTable += '<a href="javascript:RequestForCharge(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                       	}
                   }
                   else if(formName == 'pendingPrescriptionFAC')

                   {
                	   if(data_arr[rows][14] == "Pending"){
                   		//alert(data_arr[rows][19])
                		   tempTable += '<a >';
                   	}else{
                   		tempTable += '<a href="javascript:RequestForCharge(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                   	}
                  		
                   }
                    
                   else if(formName == 'pendingPrescriptionCorporateFAC')

                   {
                	   if(data_arr[rows][14] == "Pending"){
                   		//alert(data_arr[rows][19])
                		   tempTable += '<a >';
                   	}else{
                   		tempTable += '<a href="javascript:RequestForCharge(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                   	}
                  		
                   }
                    
                    
                   else  if(formName=='consent11'  || formName=='intraOperativeTimeOut'  || formName=='otSignOut' || formName=='surgeryCheckList')
                   {                    	
                   	tempTable += '<a href="javascript:Request((\''+data_arr[rows][8]+'\'),\''+formName+'\')">';
                   }
                    
                     else if(formName == 'bloodRequestEntry'  || formName == 'pendingBloodSampleCollection' || formName == 'pendingBloodSampleValidation' || formName == 'pendingBloodSampleScreeningTest' || formName == "pendingBloodIssue" || formName == "donorPendingBloodSampleScreening"  || formName == "searchReactionEntry"  || formName == "searchBloodTransfusion" || formName == "searchBloodDonor"  || formName == "searchReaction" || formName == "searchTest" || formName ==  "searchPndTransReaction" || formName=='pendingBloodDiscard' || formName ==  "personnelDetail" || formName == 'searchSpecialInvestigation' || formName == 'searchContingentBill' || formName == 'searchGeneralClaim' || formName == 'searchCardicClaim' || formName == 'searchCardicContingentBill' || formName == 'searchBillMovement' || formName == "personnelDetailForCalculation" || formName== 'updatePersonnelDetailForCalculation' || formName =='personnelDetailForDataSheet' || formName == 'updatePersonnelsearchForDataSheet' || formName== 'personnelsearchForForm7' || formName == 'updatePersonnelsearchForForm7' || formName == 'personnelSearchForForm8'|| formName =='updatePersonnelsearchForForm8' || formName == 'searchCardicClaimTracking' || formName =='searchUpdateSpecialInvestigation' || formName=='searchUpdateCardicAdvance' || formName =='searchUpdateCardicBill' || formName == 'searchUpdateMedicalBill' || formName == 'searchUpdateCoveringLetter' || formName == 'personnelSearchForRetirementEntry' || formName == 'updatePersonnelsearchForRetirementForm' || formName == 'bookIssue' || formName == 'searchBookReturn' || formName == 'bookStock' || formName == 'pendingAvAppointment' || formName == 'appSearchContingentBill')
					  { 
					    tempTable += '<a href="javascript:Request(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
					  }
                    else if(formName == "pendingResultForLab")
                    {
                   		tempTable += '<a href="javascript:RequestForChargeLab(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }                    
                    else if(formName == "pendingResultForEmpanelledLab")
                    {                    	
                   		tempTable += '<a href="javascript:RequestForChargeLab(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "pendingResultValidationLab")
                    {
                    	tempTable += '<a href="javascript:RequestForResultValidationLab(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "pendingResultUpdationLab")
                    {
                    	tempTable += '<a href="javascript:RequestForResultUpdationLab(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "resultEntryForCorrectionLab" || formName=='medicalExaminationBoardSearch1' )
                    {
                    	tempTable += '<a href="javascript:RequestForResultEntryCorrectionLab(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "pendingResultValidation")
                    {
                    	tempTable += '<a href="javascript:RequestForResultValidation(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName == "reportCollection" || formName == 'otPacClearedList')
                    {
                    	tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    
                    
                    else if(formName == 'preAnaesthesiaWaitingList')
                    {
                    	tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName=='pendingResultValidationForFilmUpdate'){
	                    tempTable += '<a href="javascript:RequestForUpdateFilmSize(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                    else if(formName=='orderNoListForOrderStatus'){
                    	if(columns != 1){
		                    tempTable += '<a href="javascript:RequestForViewTestCodeDetails(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][13]+'\',\''+formName+'\')">';
                    	}
                    }
                    else if(formName=='orderNoListForConfidential'){
                    	if(columns != 1){
	                    	tempTable += '<a href="javascript:RequestForViewConfidentialTestDetails(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
	                    }                    
                    }
                    else if(formName=='ipdOrderBookingForRadioLab'){
	                    tempTable += '<a href="javascript:RequestForIpdOrderBooking(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     else if(formName == "smqVacationAirmen" || formName == "smqVacationOfficer")
					{
					tempTable += '<a href="javascript:RequestForSmqVacationAirmen(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
					}
					 else if(formName == "relegation")
					 {
					 tempTable += '<a href="javascript:RequestForRelegationProcess(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
					 }
					 else if(formName == "journalReceipt")
					 {
					 tempTable += '<a href="javascript:RequestForJournalReceipt(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
					 } else if(formName == "supplyOrder")
                    {
                   		tempTable += '<a href="javascript:RequestForSupplyOrder(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     else if(formName == "crv" || formName == "searchDefectiveDrug" || formName == "searchDefectiveDrug1" || formName=='poDetails' || formName=='searchBalance')
                    {
                   		tempTable += '<a href="javascript:RequestForLibCrv(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     else if(formName == "cancel")
                    {
                   		tempTable += '<a href="javascript:RequestForCancel(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     else if(formName == "cancelOfficer")
                    {
                   		tempTable += '<a href="javascript:RequestForCancelOfficer(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }
                     /*else if(formName == "leave")
                    {
                        tempTable += '<a href="javascript:RequestForLeaveEntry(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }*/
                     else if(formName == "leaveRestriction")
                    {
                     tempTable += '<a href="javascript:RequestForLeaveRestriction(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }else if(formName=='meWaitingList'){
                    	 
                   	  tempTable += '<a href="javascript:showMedicalExamJsp(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][1]+'\',\''+formName+'\')">';
                     }
	            	 else if(formName=='waitingListForAviationMA' || formName== 'waitingListForAviationMO'){
	            		tempTable += '<a href="javascript:showWaitingListForAviation(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][1]+'\',\''+formName+'\')">';
	                }
                     else if(formName=='medicalBoardMedicalOfficer'){
                    	
                      	  tempTable += '<a href="javascript:showmedicalBoardMedicalOfficer(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                     }else if(formName=='medicalExamPerAuthorityAFRO'){
                     	
                     	  tempTable += '<a href="javascript:showmedicalExamPerAuthourityAFRO(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                     }else if(formName=='medicalExamPerAuthourity'){
                      	
                    	  tempTable += '<a href="javascript:showmedicalExamPersuingAuthourity(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                    }else if(formName=='medicalBoardMedicalOfficersearch'){
                    	
                      	  tempTable += '<a href="javascript:showmedicalBoardMedicalOfficersearch(\''+data_arr[rows][8]+'\',\''+data_arr[rows][7]+'\',\''+formName+'\',\''+data_arr[rows][9]+'\')">';
                      }
                     else if(formName=='pendingClwatingList'){
                     	  tempTable += '<a href="javascript:showpendingClwatingList(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                     }
                     else if(formName=='pendingMowatingList'){
                    	  tempTable += '<a href="javascript:showpendingMOwatingList(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                    }
                     else if(formName=='pendingMDWatingList'){
                    	  tempTable += '<a href="javascript:showpendingMDWatingList(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                    }else if(formName=='mbWaitingList'){
                     	  tempTable += '<a href="javascript:showMedicalBoardJsp(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][1]+'\',\''+formName+'\')">';
                     	
               }else if(formName=='medicalBoardMedicalOfficerInitial'){
               	
               	  tempTable += '<a href="javascript:showMedicalBoardMedicalOfficer(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
               }else if(formName=='specialopenionjsp'){
                  	
                	  tempTable += '<a href="javascript:showspecialopenionjsp(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                }else if(formName=='mb_CommandofficerList'){
                  	
              	  tempTable += '<a href="javascript:showmb_CommandofficerListjsp(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                      }
                          else if(formName == 'opdPatientBillStatus')
                {
                 	tempTable += '<a href="javascript:RequestForOpBillService(\''+data_arr[rows][6]+'\',\''+formName+'\')">';
                }
                          else if(formName == 'OtherPatientBillStatus')
                          {
                           	tempTable += '<a href="javascript:RequestForOtherPatientBillService(\''+data_arr[rows][2]+'\',\''+formName+'\')">';
                          }
                    else if(showOnSamePage && formName != 'finalDischarge' && formName!="opdPatientPrevVisitForReport")
                    {
                    	//alert("formName-->"+formName);
                    	if(formName == 'employee'){
                    		//alert("employee");
                    		//tempTable += '<a href="javascript:displayDepartments(\''+data_arr[rows][0]+'\',\''+data_arr[rows][9]+'\');testing('+data_arr[rows][0]+');displayAuthoriz(\''+data_arr[rows][15]+'\',\''+data_arr[rows][38]+'\');editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');disableTemplateDetails('+data_arr[rows][0]+');ssdisplayDepartmentNo(\''+data_arr[rows][12]+'\');">';
                    		/*tempTable += '<a href="javascript:contract(\''+data_arr[rows][29]+'\');displayDepartments(\''+data_arr[rows][0]+'\',\''+data_arr[rows][9]+'\');displayAuthoriz(\''+data_arr[rows][15]+'\',\''+data_arr[rows][38]+'\');testing('+data_arr[rows][0]+');displayAuthoriz(\''+data_arr[rows][15]+'\',\''+data_arr[rows][38]+'\');editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');disableTemplateDetails('+data_arr[rows][0]+');">';*/
                    		tempTable += '<a href="javascript:contract(\''+data_arr[rows][29]+'\');displayAuthoriz(\''+data_arr[rows][15]+'\',\''+data_arr[rows][38]+'\');testing('+data_arr[rows][0]+');displayAuthoriz(\''+data_arr[rows][15]+'\',\''+data_arr[rows][38]+'\');editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');disableTemplateDetails('+data_arr[rows][0]+');">';
                    		
                    	}else if(formName == 'hospital'){
                    			//tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');disableSMCLoginDetails();">';
                    		tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');displayAdminDetails('+data_arr[rows][0]+');">';
                    	}
                    	else if(formName == 'employeeDependent'){
                    		//tempTable += '<a href="javascript:displayDepartments(\''+data_arr[rows][0]+'\',\''+data_arr[rows][9]+'\');testing('+data_arr[rows][0]+');displayAuthoriz(\''+data_arr[rows][15]+'\',\''+data_arr[rows][38]+'\');editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');disableTemplateDetails('+data_arr[rows][0]+');ssdisplayDepartmentNo(\''+data_arr[rows][12]+'\');">';
                    		tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');testingImg('+data_arr[rows][0]+');">';
                    		
                    	}
                    	
                    	else if(formName == 'internalReferal'){
                			//tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\');disableSMCLoginDetails();">';
                		tempTable += '<a href="javascript:Request(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                	}else{
                    			tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    	}
                    }
               		else if(addAction && formName != 'finalDischarge' && formName!="opdPatientPrevVisitForReport")
               		{
                    	tempTable += '<a href="'+ goToUrl +'&id='+data_arr[rows][0]+'">';
               		//	tempTable += '<a href="#" onclick="parent.location=\''+ goToUrl +'&id='+data_arr[rows][0]+'\'">';
                   	}
                    else if(formName != 'finalDischarge' && formName!="opdPatientPrevVisitForReport")
                    {
                    	tempTable += '<a href="'+ goToUrl +'&'+data_arr[rows][0]+'.action">';
                    }
                   tempTable +=data_arr[rows][columns]
                    tempTable +='</a></td>'  
                	}else if(formName == 'opdPatientPrevVisitForViewScreen')
                    {
                    	//alert("else")
                    	tempTable += '<td '

                		if(data_header[columns-1][1] == "hide")
                			tempTable += 'class="hide"';
                    	tempTable +='>';
                    	if(columns!=1){
                    		tempTable += '<a href="javascript:RequestForViewScreen((\''+data_arr[rows][13]+'\'),(\''+data_arr[rows][14]+'\'),(\''+data_arr[rows][3]+'\'),(\''+data_arr[rows][17]+'\'),\''+formName+'\')">';
                    	}
                    	tempTable +=data_arr[rows][columns]
                    	                           tempTable +='</a></td>'  
                    }else if(formName == 'phyWaitingList' )
                    {
                    	//alert("else")
                    	tempTable += '<td '
    		if(data_header[columns-1][1] == "hide")
                			tempTable += 'class="hide"';
                    	tempTable +='>';
                    	if(columns!=1){
                    		tempTable += '<a href="javascript:RequestForPhy(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',(\''+data_arr[rows][15]+'\'),(\''+data_arr[rows][16]+'\'),(\''+data_arr[rows][18]+'\'))">';
                    	}
                    	tempTable +=data_arr[rows][columns]
                    	                           tempTable +='</a></td>'  
                    }
                    
                }
               tempTable += '</tr>'
        }
        tempTable += '</tbody></table></div>'
                            
        document.getElementById('searchtable').innerHTML = tempTable;
    }
    
    if(document.paging.pageno.value == 1){
		document.paging.firstpage.disabled= true;
		document.paging.prevpage.disabled= true;
		document.paging.firstpage.className="previousDisable"
		document.paging.prevpage.className="singlePrevDisable"    
    
    }    
     if(formName == 'finalDischarge'){
    	if(document.getElementById('dischargeButton'))	
			document.getElementById('dischargeButton').style.display = 'inline';
			document.getElementById('dsPrint').style.display = 'inline';	
			
		}
		if(document.getElementById('addInfoId')){
			document.getElementById('addInfoId').style.display = 'inline';	
		}
}

function makeTable1(starter1, end1){
	//alert(end1);
	formName = "opdPatientPrevVisitForViewScreen1"
	if(document.getElementById("rowsPerPageForItem")!=null)
			{
	        
			if(document.getElementById("rowsPerPageForItem").value == 10){
			rowsPerPage = 10;
			}
			}
				
	    totalPages1 = Math.ceil(data_arr1.length/rowsPerPage);
	    //alert("totalPages1="+totalPages1);
	    document.getElementById("total1").innerHTML=totalPages1
	  
	    if(data_arr1.length<5)
	    {
	    	//document.getElementById("currEnd").innerHTML=data_arr1.length
	    	document.getElementById("currEnd1").value=data_arr1.length
	    }
	    //document.getElementById("totalRecs").innerHTML=data_arr1.length
	    document.getElementById("totalRecs1").value=data_arr1.length
	    if(totalPages1==0){
		    document.getElementById('searchtable1').style.width = "50%"
	    	document.getElementById('searchtable1').style.textAlign = "left"
	        document.getElementById('searchtable1').innerHTML = '<h4>No Records Found</h4>'
			document.getElementById('resultnavigation1').style.display="none";
	        return;
	    }
	    else if(totalPages1 == 1){
			document.paging1.lastpage1.disabled= true;
			document.paging1.nextpage1.disabled= true;
			document.paging1.lastpage1.className="nextDisable"
			document.paging1.nextpage1.className="singleNext"    
	    }
	    document.getElementById('resultnavigation1').style.display="inline";
	    //document.getElementById('pageno').length=totalPages
	    for(pg=1;pg<=totalPages1;pg++){
	        //document.getElementById('pageno')[pg-1].value = pg
	        //document.getElementById('pageno')[pg-1].text = pg            
	    }
	    	
	    start1 = starter1;
	    //alert("1");
	   // alert("formName="+formName);
	    
	    if(data_header1){
	                tempTable = '<div class="clear"></div><div><table border="0" cellspacing="0"  cellpadding="0" ><thead><tr>'
	        for(cols=0;cols<data_header1.length;cols++){
	            if(data_header1[cols][1]=="data"){
	                tempTable += '<th  width="';
	                if(data_header1[cols][2]!=0)
	                    tempTable +=  data_header1[cols][2];
	          //      tempTable += '">'+data_header1[cols][0]+'<a href="javascript:sortTable('+cols+',\'up\')"><img src="/hms/jsp/images/arrowUp.gif" /></a><a href="javascript:sortTable('+cols+',\'dn\')"><img src="/hms/jsp/images/arrowDown.gif" /></a></th>'
	                tempTable += '">'+data_header1[cols][0]+'</th>'
	            }
	            else if(data_header1[cols][1]=="hide"){
	                    tempTable += '<th class="hide">&nbsp;</th>'
	            }else if(data_header1[cols][1]=="radio"){
	            		 tempTable += '<th class="gridheadtext" width="';
	                if(data_header1[cols][2]!=0)
	                    tempTable +=  data_header1[cols][2];
	                tempTable += '">'+data_header1[cols][0]+'</th>'
	            	}
	        }
	        tempTable += '<tr></thead><tbody id="searchresulttable1">'
	       
	        for(rows=start1;rows<end1; rows++){
	        	if(formName == "pendingSampleCollection" || formName == "pendingSampleValidation"){
					tempTable += '<tr id="'+data_arr1[rows][0]+'" class="default'  
					tempTable += '"'; 
	            	if(data_arr1[rows][12] == "1"){
	            		tempTable +=' bgcolor="#FA7676" '
	            	}else if(data_arr1[rows][12] == "2"){
	            		tempTable +=' bgcolor="#F7ED9B" '
	            	}else if(data_arr1[rows][12] == "3"){
	            		tempTable +=' bgcolor="#A0E0AA" '
	            	}
	            }else if(formName == "pendingResultForLab"){
					tempTable += '<tr id="'+data_arr1[rows][0]+'" class="default'  
					tempTable += '"'; 
	            	if(data_arr1[rows][18] == "1"){
	            		tempTable +=' bgcolor="#FA7676" '
	            	}else if(data_arr1[rows][18] == "2"){
	            		tempTable +=' bgcolor="#F7ED9B" '
	            	}else if(data_arr1[rows][18] == "3"){
	            		tempTable +=' bgcolor="#A0E0AA" '
	            	}
	            }else if(formName == "pendingResultValidationLab"){
					tempTable += '<tr id="'+data_arr1[rows][0]+'" class="default'  
					tempTable += '"'; 
	            	if(data_arr1[rows][17] == "1"){
	            		tempTable +=' bgcolor="#FA7676" '
	            	}else if(data_arr1[rows][17] == "2"){
	            		tempTable +=' bgcolor="#F7ED9B" '
	            	}else if(data_arr1[rows][17] == "3"){
	            		tempTable +=' bgcolor="#A0E0AA" '
	            	}
	            }else{
	        	
	               if(formName == "movementIn"){
	                tempTable += '<tr id="'+data_arr1[rows][0]+'" class="'
	                }else{
	                tempTable += '<tr id="'+data_arr1[rows][0]+'" class="'
	                }
	                
					if(rows%rowsPerPage == 0 && rows != 0){
				
						currentColor = "odd"	
					}

	                tempTable += currentColor;   	            
					currentColor = (currentColor == "odd")?"even" : "odd";
					tempTable += '"'; 
	            }
	            tempTable += '>'
	                
	                for(columns=1;columns<=data_header1.length;columns++){
	                	if(formName!='opdPatientPrevVisitForViewScreen1' && formName!='phyWaitingList')
	                	{
	                		
	                	}else if(formName == 'opdPatientPrevVisitForViewScreen1')
	                    {
	                    	//alert("else")
	                    	tempTable += '<td '

	                		if(data_header1[columns-1][1] == "hide")
	                			tempTable += 'class="hide"';
	                    	tempTable +='>';
	                    	/*if(columns!=1){
	                    		tempTable += '<a href="javascript:RequestForViewScreen((\''+data_arr1[rows][3]+'\'),(\''+data_arr1[rows][6]+'\'),(\''+data_arr1[rows][7]+'\'),(\''+data_arr1[rows][17]+'\'),\''+formName+'\')">';
	                    	}*/
	                    	tempTable +=data_arr1[rows][columns]
	                    	                           tempTable +='</a></td>'  
	                    }else if(formName == 'phyWaitingList' )
	                    {
	                    	//alert("else")
	                    	tempTable += '<td '
	    		if(data_header1[columns-1][1] == "hide")
	                			tempTable += 'class="hide"';
	                    	tempTable +='>';
	                    	if(columns!=1){
	                    		tempTable += '<a href="javascript:RequestForPhy(document.getElementById(\''+data_arr1[rows][0]+'\'),\''+formName+'\',(\''+data_arr1[rows][15]+'\'),(\''+data_arr1[rows][16]+'\'),(\''+data_arr1[rows][18]+'\'))">';
	                    	}
	                    	tempTable +=data_arr1[rows][columns]
	                    	                           tempTable +='</a></td>'  
	                    }
	                    
	                }
	               tempTable += '</tr>'
	        }
	        tempTable += '</tbody></table></div>'
	                            
	        document.getElementById('searchtable1').innerHTML = tempTable;
	    }
	    
	    if(document.paging1.pageno1.value == 1){
			document.paging1.firstpage1.disabled= true;
			document.paging1.prevpage1.disabled= true;
			document.paging1.firstpage1.className="previousDisable"
			document.paging1.prevpage1.className="singlePrevDisable"    
	    
	    }    
	     if(formName == 'finalDischarge'){
	    	if(document.getElementById('dischargeButton'))	
				document.getElementById('dischargeButton').style.display = 'inline';
				document.getElementById('dsPrint').style.display = 'inline';	
				
			}
			if(document.getElementById('addInfoId')){
				document.getElementById('addInfoId').style.display = 'inline';	
			}
	}

function showMedicalBoardJsp(obj,medExamType,formName){
	visitId = obj.id;
    obj1 = eval('document.'+formName)
    var url ="";
   
    if((medExamType=='Initial Medical Board AFMSF 15')||(medExamType=='Medical Board Review AFMSF 15')){
    	
    	url = "/hms/hms/medicalBoard?method=showInitialMedicalBoardMedExamJsp&visitId="+encodeURIComponent(visitId)+"&medExamType="+encodeURIComponent(medExamType);
  
    }
    if((medExamType=='Medical Board Rel/Invalidment AFMSF 16')){
    	url = "/hms/hms/medicalBoard?method=showMedBoardMAForm16&visitId="+visitId+"&medExamType="+medExamType;
    }
    
    
   	obj1.action = url;
    obj1.submit();
	
}  

function showMedicalExamJsp(obj,medExamType,formName){
	
	visitId = obj.id;
    obj1 = eval('document.'+formName)
    var url ="";
    if(medExamType=='Primary/Extension Med. Exam(AFMSF-2A)'){
    	url = "/hms/hms/medicalExam?method=showPrimaryExtMedExamJsp&visitId="+visitId;
    }else if((medExamType=='Annual Medical Exam(AFMSF-3B)')||(medExamType=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(medExamType=='High Altitude Med. Exam(AFMSF-3B)'))
    {   	url = "/hms/hms/medicalExam?method=showAnnualMedExamJsp&visitId="+visitId+"&medExamType="+medExamType;
    }else if(medExamType=='Med. Exam On Release/Discharge(AFMSF-18)')
    {
    	url = "/hms/hms/medicalExam?method=showReleaseDischargeJsp&visitId="+visitId+"&medExamType="+medExamType;
    	
    }
   	obj1.action = url;
    obj1.submit();
	
}

function showspecialopenionjsp(obj,boj2,formName,obj3){
	
	
	obj1 = eval('document.'+formName)
    var url ="";
	url = "/hms/hms/medicalBoard?method=getCaseSheetDetails&visitId="+obj+"&medExamId="+obj3;
    obj1.action = url;
    obj1.submit();
  
} 
function showmb_CommandofficerListjsp(obj,boj2,formName,obj3){
	

	obj1 = eval('document.'+formName)
    var url ="";
	url = "/hms/hms/medicalBoard?method=getCommandingOfficerDetails&visitId="+obj+"&medExamId="+obj3;
    obj1.action = url;
    obj1.submit();
  
} 

function showMedicalBoardMedicalOfficer(obj,boj2,formName,obj3){
	obj1 = eval('document.'+formName)
    var url ="";
	  
    if(formName == 'medicalBoardMedicalOfficerInitial'){
        url = "/hms/hms/medicalBoard?method=showMedicalOfficerInitial&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+boj2+"&search="+false;
        }
   
    obj1.action = url;
    obj1.submit();
} 

function showWaitingListForAviation(obj,boj2,formName){
	obj1 = eval('document.'+formName)
    var url ="";
    if(formName == 'waitingListForAviationMA'){
    	url = "/hms/hms/aviationMedicine?method=showCivilAviationMedExamMAJsp&avica34Id="+obj.id+"&visitId="+boj2;
    }else if(formName == 'waitingListForAviationMO'){
    	url = "/hms/hms/aviationMedicine?method=showCivilAviationMedExamMOJsp&medExamMaMoId="+obj.id+"&visitId="+boj2;
    }
    obj1.action = url;
    obj1.submit();
} 
function showmedicalBoardMedicalOfficersearch(obj,boj2,formName,obj3){
	
	
	obj1 = eval('document.'+formName)
    var url ="";
	
	
    if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')){
    	
    url = "/hms/hms/medicalExam?method=showMedicalOfficerMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2+"&search="+true;
   // url = "/hms/hms/medicalExam?method=showMedicalOfficerMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
    //alert("url---"+url);
    }
    
    if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
    	
        url = "/hms/hms/medicalExam?method=showMOPrimaryMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&search="+true;
      //  url = "/hms/hms/medicalExam?method=showMOPrimaryMedExamJsp&visitId="+obj+"&medExamId="+obj3;
        }
    if(boj2=='Med. Exam On Release/Discharge(AFMSF-18)'){
          url = "/hms/hms/medicalExam?method=showMedicalOfficerReleaseDischarge&visitId="+obj+"&medExamId="+obj3+"&search="+true;
        //  url = "/hms/hms/medicalExam?method=showMedicalOfficerReleaseDischarge&visitId="+obj+"&medExamId="+obj3;
          }
   // alert("hi 1")
    obj1.action = url;
    obj1.submit();
	
}

function showmedicalBoardMedicalOfficer(obj,boj2,formName,obj3){
	
	
	obj1 = eval('document.'+formName)
    var url ="";
	
	
    if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')){
    	
   // url = "/hms/hms/medicalExam?method=showMedicalOfficerMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2+"&search="+true;
    url = "/hms/hms/medicalExam?method=showMedicalOfficerMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
  //  alert("url---"+url);
    }
    
    if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
    	
        //url = "/hms/hms/medicalExam?method=showMOPrimaryMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&search="+true;
        url = "/hms/hms/medicalExam?method=showMOPrimaryMedExamJsp&visitId="+obj+"&medExamId="+obj3;
        }
    if(boj2=='Med. Exam On Release/Discharge(AFMSF-18)'){
          //url = "/hms/hms/medicalExam?method=showMedicalOfficerReleaseDischarge&visitId="+obj+"&medExamId="+obj3+"&search="+true;
          url = "/hms/hms/medicalExam?method=showMedicalOfficerReleaseDischarge&visitId="+obj+"&medExamId="+obj3;
          }
   
    obj1.action = url;
    obj1.submit();
	
}
function showmedicalExamPerAuthourityAFRO(obj,boj2,formName,obj3)
{
	
	//alert("Hi....")
	obj1 = eval('document.'+formName)
    var url ="";
	
	
	 if(boj2=='Med. Exam On Release/Discharge(AFMSF-18)'){
		    	
      url = "/hms/hms/medicalExam?method=showMedicalExamPersuingAuthorityAFROJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
    }
    
  
   
    obj1.action = url;
    obj1.submit();
	
}
function showmedicalExamPersuingAuthourity(obj,boj2,formName,obj3)
{
	obj1 = eval('document.'+formName)
    var url ="";
	
	
    if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')||(boj2=='Med. Exam On Release/Discharge(AFMSF-18)')){
    	
     url = "/hms/hms/medicalExam?method=showMedicalExamPersuingAuthorityJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
    }
    
    if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
    	
        url = "/hms/hms/medicalExam?method=showMOPrimaryMedExamJsp&visitId="+obj+"&medExamId="+obj3;
    }
   
   
    obj1.action = url;
    obj1.submit();
	
}

function showpendingMOwatingList(obj,boj2,formName,obj3){
	
	
	obj1 = eval('document.'+formName)
    var url ="";
	//alert("boj2---"+boj2)
	if((boj2=='InitialMedicalBoardAFMSF15')||(boj2=='Medical Board Review AFMSF 15')){

		url = "/hms/hms/medicalBoard?method=showMOFormJsp&visitId="+obj+"&medExamId="+obj3+"&jsp=CommandLevel"+"&medExamType="+boj2;
    
    }
	if((boj2=='Medical Board Rel/Invalidment AFMSF 16')){

		url = "/hms/hms/medicalBoard?method=showForm16Jsp&visitId="+obj+"&medExamId="+obj3+"&jsp=CommandLevel"+"&medExamType="+boj2;
    
    }

  
   	obj1.action = url;
    obj1.submit();
	
}

function showpendingClwatingList(obj,boj2,formName,obj3){
	
	
	obj1 = eval('document.'+formName)
    var url ="";
	//alert("boj2---"+obj3)
    if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')){
    	
    url = "/hms/hms/medicalExam?method=showCommandLevelJsp&visitId="+obj+"&medExamId="+obj3+"&jsp=CommandLevel"+"&medExamType="+boj2;
    
    }
    if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
    	
        url = "/hms/hms/medicalExam?method=showPrimaryMedExamCommandJsp&visitId="+obj+"&medExamId="+obj3+"&jsp=CommandLevel";
        
        }
    if(boj2=='Med. Exam On Release/Discharge(AFMSF-18)'){
        url = "/hms/hms/medicalExam?method=showCLReleaseDischarge&visitId="+obj+"&medExamId="+obj3+"&jsp=CommandLevel";
        }

   	obj1.action = url;
    obj1.submit();
	
}
function showpendingMDWatingList(obj,boj2,formName,obj3){
	
	
	obj1 = eval('document.'+formName)
    var url ="";
	//alert("boj2---"+obj3)
    if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')){
    	
    url = "/hms/hms/medicalExam?method=showMDLevelJsp&visitId="+obj+"&medExamId="+obj3+"&jsp=MDLevel"+"&medExamType="+boj2;
    
    }
    if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
    	
        url = "/hms/hms/medicalExam?method=showPrimaryMedExamMDJsp&visitId="+obj+"&medExamId="+obj3+"&jsp=MDLevel";
        
        }
if(boj2=='Med. Exam On Release/Discharge(AFMSF-18)'){
    	
        url = "/hms/hms/medicalExam?method=ReleaseDischargeMD&visitId="+obj+"&medExamId="+obj3+"&jsp=MDLevel";
        
        }

    obj1.action = url;
    obj1.submit();
	
}
function RequestForCharge(obj,formName)
{
	sampleCollectionDetail = obj.id;
   obj1 = eval('document.'+formName)
    var url;
    if(formName == 'pendingResult')
   		url = "/hms/hms/investigation?method=searchPatient&sampleCollectionDetailId="+sampleCollectionDetail;
    else if(formName == 'minorWorkDetailSearch')
   		url = "/hms/hms/minorWorkDetailsUpdate?method=showMinorWorkDetailsUpdateJsp&minorWorkDetailId="+sampleCollectionDetail;
   	else if(formName == 'minorWorkDetailsApproval')
   		url = "/hms/hms/approvalOfMinorWorkDetail?method=showApprovalOfMinorWorkDetailJsp&minorWorkDetailId="+sampleCollectionDetail;
   	else if(formName == 'minorWorkDetailSearchForCompletionWork')
   		url = "/hms/hms/completionOfMinorWorkDetails?method=showCompletionOfMinorWorkDetailsJsp&minorWorkDetailId="+sampleCollectionDetail;
   	else if(formName == 'agendaPointsSearch')
   		url = "/hms/hms/updateAgendaPointsForWorkServices?method=showUpdateAgendaPointsForWorkServicesJsp&agendaId="+sampleCollectionDetail;
   		else if(formName == 'agendaPointsUpdateSearch')
   		url = "/hms/hms/updateAgendaPoints?method=showUpdateAgendaPointsForWorkServicesJsp&agendaId="+sampleCollectionDetail;

     	else if(formName=='majorWorkDetailSearch1')
      url="/hms/hms/majorWorkDetailUpdate?method=showMajorWorkDetailUpdateJsp&sampleCollectionDetailId="+sampleCollectionDetail;
     if(formName=='momWorkDetailAgendaSearch1')
    {
    url="/hms/hms/momDetailAgainstAgenda?method=showMomDetailAgainstAgendaJsp&sampleCollectionDetailId="+sampleCollectionDetail;
     }
     if(formName=='medicalBoardProceedingSearch')
    {
    url="/hms/hms/medicalBoardUpdate?method=showMedicalBoardProceedingJsp&medicalBoardProceedingId="+sampleCollectionDetail;
     }
       if(formName=='medicalBoardProceedingSearchForEmployee')
    {
    url="/hms/hms/medicalBoardUpdate?method=showMedicalBoardProceedingFroEmployeeJsp&medicalBoardProceedingId="+sampleCollectionDetail;
     }
     if(formName=='instructionToCandidateSearch')
    {
    url="/hms/hms/instructionToCandidatesUpdate?method=showInstructionToCandidatesUpdateJsp&instructionToCandidateId="+sampleCollectionDetail;
     }
      if(formName=='certificateByTheCandidateSearch')
    {
    url="/hms/hms/certificateByTheCandidatesUpdate?method=showCertificateByTheCandidatesUpdateJsp&certificateByTheCandidateId="+sampleCollectionDetail;
     }
      if(formName=='resultOfAppealMedicalboardSearch')
    {
    url="/hms/hms/resultOfAppealMedicalboardUpdate?method=showResultOfAppealMedicalboardUpdateJsp&resultOfAppealMedicalboardId="+sampleCollectionDetail;
     }
     if(formName=='medicalBoardPreceedingsSearch1')
      {
       url="/hms/hms/medicalboardUpdate?method=showMedicalBoardUpdateJsp&sampleCollectionDetailId="+sampleCollectionDetail;
      }

        if(formName=='medicalBoardPreceedingsPrint')
      {
       url="/hms/hms/medicalboardUpdate?method=printMedicalBoard&Id="+sampleCollectionDetail;
      }
        if(formName=='medicalExaminationBoardPrint')
      {
       url="/hms/hms/medicalExaminationBoard?method=printMedicalBoard&Id="+sampleCollectionDetail;
      }
        if(formName=='instructionToCandidatePrint')
      {
       url="/hms/hms/instructionToCandidatesUpdate?method=printMedicalBoard&Id="+sampleCollectionDetail;
      }
        if(formName=='certificateByTheCandidatePrint')
      {
       url="/hms/hms/certificateByTheCandidatesUpdate?method=printMedicalBoard&Id="+sampleCollectionDetail;
      }
        if(formName=='resultOfAppealMedicalboardPrint')
      {
       url="/hms/hms/resultOfAppealMedicalboardUpdate?method=printMedicalBoard&Id="+sampleCollectionDetail;
      }
       if(formName=='agendaPointsDetailSearch')
      {

       url="/hms/hms/agenda?method=showAgendaMeetingDetailsJsp&Id="+sampleCollectionDetail;
      }
      if(formName == 'pendingPrescription')
      {
    	  url = "/hms/hms/stores?method=showOPDPatientIssue&hinId="+sampleCollectionDetail;
   		//url = "/hms/hms/opd?method=searchPatientPrescription&prescriptionId="+sampleCollectionDetail;
      }
      if(formName == 'pendingPrescriptionFAC')
      {
    	  url = "/hms/hms/stores?method=showOPDPatientIssueFAC&prescriptionId="+sampleCollectionDetail;
   		
      }
      if(formName == 'pendingPrescriptionCorporateFAC')
      {
    	  url = "/hms/hms/stores?method=showOPDPatientIssueCorporateFAC&prescriptionId="+sampleCollectionDetail;
   		
      }
      if(formName == 'pendingNIPPrescription')
      {
    	  url = "/hms/hms/stores?method=showOPDPatientNIPIssue&hinId="+sampleCollectionDetail;
   		//url = "/hms/hms/opd?method=searchPatientPrescription&prescriptionId="+sampleCollectionDetail;
      }
      if(formName == 'pendingPrescriptionForWard')
      {
    	  url = "/hms/hms/stores?method=showIPDPatientIssue&wardId="+sampleCollectionDetail;
   		//url = "/hms/hms/opd?method=searchPatientPrescription&prescriptionId="+sampleCollectionDetail;
      }
      
      if(formName == 'pendingPrescriptionForWardPartial')
      {
    	  url = "/hms/hms/stores?method=showIPDPatientIssuePartial&wardId="+sampleCollectionDetail;
   		//url = "/hms/hms/opd?method=searchPatientPrescription&prescriptionId="+sampleCollectionDetail;
      }
      
      if(formName == 'partialPrescriptionForWard')
      {
    	  url = "/hms/hms/stores?method=showIPDPatientPartialIssue&prescriptionId="+sampleCollectionDetail;
   		//url = "/hms/hms/opd?method=searchPatientPrescription&prescriptionId="+sampleCollectionDetail;
      }
      if(formName == 'pendingPrescription1')
      {
    	  url = "/hms/hms/stores?method=showOPDPatientIssue&flag=loanout&prescriptionId="+sampleCollectionDetail;
   		//url = "/hms/hms/opd?method=searchPatientPrescription&prescriptionId="+sampleCollectionDetail;
      }
      if(formName == 'pendingPresWithoutBarCode')
      {
    	  url = "/hms/hms/stores?method=showOPDPatientIssueWithoutBarCode&prescriptionId="+sampleCollectionDetail;
   		//url = "/hms/hms/opd?method=searchPatientPrescription&prescriptionId="+sampleCollectionDetail;
      }
      
      if(formName == 'pendingForPACConsulation')
      {
    	  url = "/hms/hms/ot?method=showPreAnethesiaFormForAdvice&surgeryId="+sampleCollectionDetail;

      }
      
      if(formName == 'pendingForAnesthesiaRecord')
      {
    	  url = "/hms/hms/ot?method=showUploadingDocumentsJspForAnesthesiaRecord&bookingId="+sampleCollectionDetail;

      }
    
   	obj1.action = url;
    obj1.submit();
}
/*;;;;;;;;;;;;;;;;;;;;;;;;Add by yogesh ;;;;;;;;;;;;;;;;;;;*/
/*
function RequestForLoanInUpdate(obj , formName )
{
	loanInMId = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'searchGrn')
   		url = "/hms/hms/stores?method=modifyScreenForLoanin&parent="+loanInMId;
   	obj1.action = url;
    obj1.submit();
}*/
function RequestForEmployeeUpdate(obj,formName)
{
	employeeId = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'employeeUpdate')
   		url = "/hms/hms/hrOrderly?method=showEmployeeUpdateJsp&employeeId="+employeeId;
   	obj1.action = url;
    obj1.submit();
}
function RequestForotherPersonUpdate(obj,formName)
{
	employeeId = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'otherPersonUpdate')
   		url = "/hms/hms/hrOrderly?method=showUpdatePersonnelFromOtherUnitJsp&personelId="+employeeId;
    
   	obj1.action = url;
    obj1.submit();
}
function RequestForPostedOut(obj,formName)
{
	employeeId = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'postedOut')
   		url = "/hms/hms/hrOrderly?method=showPostedOutJsp&employeeId="+employeeId;
    
   	obj1.action = url;
    obj1.submit();
}
function RequestForLeaveEntry(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leave'){
         url = "/hms/hms/hrOrderly?method=showLeaveApplicationJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForLeaveRestriction(obj,formName)
{
 leaveRestrictionId = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leaveRestriction'){
     url = "/hms/hms/hrOrderly?method=showLeaveRestrictionUpdateJsp&leaveRestrictionId="+leaveRestrictionId;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForLeaveApplication(obj,formName)
{
 LeaveAppID = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leaveApplicationUpdate'){
     url = "/hms/hms/hrOrderly?method=showLeaveApplicationUpdateJsp&LeaveAppID="+LeaveAppID;
    obj.action = url;
    obj.submit();
 }  
 }
 function RequestForSearchProposal(obj,formName)
{
   proposal = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'updateProposalHRO'){
         url = "/hms/hms/hrOrderly?method=showUpdateProposalJsp&proposalId="+proposal;
    obj.action = url;
    obj.submit();
 }
 }
 
 function RequestForSearchHro(obj,formName)
{
   hro = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'updateHROEntry'){
         url = "/hms/hms/hrOrderly?method=showUpdateHroEntryJsp&hroId="+hro;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForMovementOut(obj,obj1,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'movementOut'){
         url = "/hms/hms/hrOrderly?method=showMovementOutJsp&employeeId="+employee+"&employeecode="+obj1;
    obj.action = url;
    obj.submit();
 }
 }
 
 function RequestForMovementIn(obj,obj1,formName)
{
   employee = obj.id;
   
    obj = eval('document.'+formName)
   
    var url;
    if(formName == 'movementIn'){
         url = "/hms/hms/hrOrderly?method=showMovementInJsp&employeeId="+employee+"&employeecode="+obj1;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForDutySearch(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'dutySearch'){
         url = "/hms/hms/hrRelated?method=showDutyExemptionEntryJsp&empId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
  function RequestForLeaveSearch(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leaveSearch'){
         url = "/hms/hms/hrRelated?method=showLeaveMaintenanceEntryJsp&empId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForLeavePending(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leavePending'){
         url = "/hms/hms/hrRelated?method=showLeavePendingEntryJsp&empId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForUpdateArrival(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'updateArrival'){
         url = "/hms/hms/hrRelated?method=showUpdateArrivalEntryJsp&empId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
function RequestForChargeLab(obj,formName)
{
	sampleCollectionDetail = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'pendingResultForLab')
   		url = "/hms/hms/investigation?method=searchPatientForLab&sampleCollectionDetailId="+sampleCollectionDetail;
    
    if(formName == 'pendingResultForEmpanelledLab')
   		url = "/hms/hms/investigation?method=searchPatientForEmpanelledLab&sampleCollectionDetailId="+sampleCollectionDetail;
    
   	obj1.action = url;
    obj1.submit();
}

function RequestForChargeEmpanelledLab(obj,formName)
{
	alert(formName);
	sampleCollectionDetail = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'pendingResultForEmpanelledLab')
   		url = "/hms/hms/investigation?method=searchPatientForEmpanelledLab&sampleCollectionDetailId="+sampleCollectionDetail;
    
   	obj1.action = url;
    obj1.submit();
}

function RequestForResultValidation(obj,formName)
{

	result = obj.id;

    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'pendingResultValidation')
   		url = "/hms/hms/investigation?method=searchPatientForResultValidation&resultId="+result;
    
   	obj1.action = url;
    obj1.submit();
}

function RequestForResultValidationLab(obj,formName)
{

	result = obj.id;
	
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'pendingResultValidationLab')
   		url = "/hms/hms/investigation?method=searchPatientForResultValidationLab&resultId="+result;
    
   	obj1.action = url;
    obj1.submit();
}

function RequestForResultUpdationLab(obj,formName)
{

	result = obj.id;
	
    obj1 = eval('document.'+formName)
    
    var url;
    if(formName == 'pendingResultUpdationLab')
   		url = "/hms/hms/investigation?method=searchPatientForResultUpdationLab&resultId="+result;
    
   	obj1.action = url;
    obj1.submit();
}

function RequestForResultEntryCorrectionLab(obj,formName)
{

	result = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'resultEntryForCorrectionLab')
   		url = "/hms/hms/investigation?method=searchPatientForResultEntryCorrectionLab&resultId="+result;
    if(formName == 'medicalExaminationBoardSearch1')
   		url = "/hms/hms/medicalExaminationBoard?method=showMedicalExaminationBoardUpdateJsp&sampleCollectionDetailId="+result;
    
    
   	obj1.action = url;
    obj1.submit();
}

function RequestForUpdateFilmSize(obj,formName){
	result = obj.id;

    obj1 = eval('document.'+formName)
    var url;
    
    if(formName == 'pendingResultValidationForFilmUpdate'){
   		//url = "/hms/hms/investigation?method=searchPatientForResultValidation&resultId="+result;
	    submitProtoAjax('pendingResultValidationForFilmUpdate','/hms/hms/investigation?method=searchPatientForFilmValidation&resultId='+result);
   	}
   	//obj1.action = url;
    //obj1.submit();
}
function RequestForBrandList(obj,formName){
	result = obj.id;

    obj1 = eval('document.'+formName)
    var url;
    
    if(formName == 'pendingResultValidationForFilmUpdate'){
   		//url = "/hms/hms/investigation?method=searchPatientForResultValidation&resultId="+result;
	    submitProtoAjax('pendingResultValidationForFilmUpdate','/hms/hms/investigation?method=searchPatientForFilmValidation&resultId='+result);
   	}
   	//obj1.action = url;
    //obj1.submit();
}

currentRowForOrderStatus = "";
function RequestForViewTestCodeDetails(obj,obj1,formName){

	if(currentRowForOrderStatus != "")
	{
		if(document.getElementById(currentRowForOrderStatus)){
			document.getElementById(currentRowForOrderStatus).style.backgroundColor = "";
		}
		obj.style.backgroundColor = '#9CCEE4';
		currentRowForOrderStatus = obj.id;
	}else if(currentRowForOrderStatus == ""){
		obj.style.backgroundColor = '#9CCEE4';
		currentRowForOrderStatus = obj.id;
	}
	result = obj.id;
    obj1 = eval('document.'+formName);
    var url;

    if(formName == 'orderNoListForOrderStatus'){
	  //  url = "/hms/hms/lab?method=viewAllTestForOrderNo&dgOrderHdId="+result;
    	 url = "/hms/hms/lab?method=viewIpdTestForOrderNo&dgOrderHdId="+result+"&dischargeSummaryFlag="+obj1;
	    submitProtoAjax('orderNoListForOrderStatus',url);
   	}
}
currentRowForConfidentialOrderStatus = "";
function RequestForViewConfidentialTestDetails(obj,formName){
	if(currentRowForConfidentialOrderStatus != "")
	{
		if(document.getElementById(currentRowForConfidentialOrderStatus)){
			document.getElementById(currentRowForConfidentialOrderStatus).style.backgroundColor = "";
		}
		obj.style.backgroundColor = '#9CCEE4';
		currentRowForConfidentialOrderStatus = obj.id;
	}else if(currentRowForConfidentialOrderStatus == ""){
		obj.style.backgroundColor = '#9CCEE4';
		currentRowForConfidentialOrderStatus = obj.id;
	}
	
	result = obj.id;

    obj1 = eval('document.'+formName)
    var url;
    
    if(formName == 'orderNoListForConfidential'){
	    url = "/hms/hms/lab?method=viewAllConfidentialTestForOrderNo&dgOrderHdId="+result;
	    submitProtoAjax('orderNoListForConfidential',url);
   	}
}
function RequestForIpdOrderBooking(obj,formName){
	result = obj.id;

    obj1 = eval('document.'+formName)
    var url;
    
    if(formName == 'ipdOrderBookingForRadioLab'){
   	   	url = "/hms/hms/lab?method=searchPatientDetailsForIPD&inpatientId="+result;
    	obj1 .action = url;
		obj1 .submit();
    }
   //	obj1.action = url;
    //obj1.submit();
}

function RequestForReportCollection(obj,formName)
{
	
	hin = obj.id;
	result = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'reportCollection')
   		url = "/hms/hms/investigation?method=searchPatientForReportCollection&resultId="+result;
    
     if(formName == 'otPacClearedList')
    	url = "/hms/hms/ot?method=showOTBookingJsp&surgeryId="+hin;
    
     if(formName == 'preAnaesthesiaWaitingList')
     	url = "/hms/hms/ot?method=form&surgeryId="+hin;
    
     
   	obj1.action = url;
    obj1.submit();
}

function Request(obj,formName)
{
  obj1 = eval('document.'+formName)
if( formName != 'patientEnquiry'){
	hin = obj.id;
  
    //alert(obj1)
}
	
    var url;
    if(formName == 'patientVisit'){
   		url = "/hms/hms/registration?method=showVisitDetails&hinId="+hin;
   		obj1 .action = url;
		obj1 .submit();
    }/*else if(formName == 'patientAdmission'){
       url = "/hms/hms/adt?method=searchPatientDetailsForAdmission&hinId="+hin;
       obj1 .action = url;
		obj1 .submit();
    }*/ else if(formName == 'patientTransfer'){
        url = "/hms/hms/adt?method=searchPatientDetailsForTransfer&inpatientId="+hin;
        obj1 .action = url;
		obj1 .submit();
    }else if(formName=="patientDischarge"){
    	url = "/hms/hms/adt?method=searchPatientDetailsForDischarge&inpatientId="+hin;
    	obj1 .action = url;
		obj1 .submit();
    }else if(formName == 'updateRegistrationByName'){
        url = "/hms/hms/registration?method=searchPatient&hin="+hin+"&selectedRadio=2";
        obj1 .action = url;
		obj1 .submit();
    }else if(formName == 'patientEnquiry'){
        url = "/hms/hms/enquiry?method=showPatientDetails&hinNo="+obj;
        obj = eval('document.'+formName)
        obj.action = url;
		obj.submit();
    }else if(formName == 'patientAdvance'){
    	url = "/hms/hms/billing?method=searchPatient&flag=deposit&hinId="+hin;
    	obj1 .action = url;
		obj1 .submit();
    }else if(formName == 'searchExpiryDetails'){
    	url = "/hms/hms/adt?method=showExpiryDetails&adNo="+hin;
    	obj1 .action = url;
		obj1 .submit();
    }else if(formName == 'finalSettlement'){
    	url = "/hms/hms/billing?method=searchPatient&flag=finalSettlement&hinId="+hin;
    	obj1 .action = url;
		obj1 .submit();
    }else if(formName == 'pendingSampleCollection'){
    	var deptType1=document.getElementById('deptType1').value;
    	url = "/hms/hms/lab?method=searchPatient&orderId="+hin+"&flag=DIAG&deptType1="+deptType1;
    	obj1 .action = url;
		obj1 .submit();
    }else if(formName == 'pendingSampleValidation'){
    	//url = "/hms/hms/lab?method=searchPatientForValidation&orderId="+hin;
    	var deptType1=document.getElementById('deptType1').value;
    	url = "/hms/hms/lab?method=searchPatient&orderId="+hin+"&flag=RADIO&deptType1="+deptType1;
    	obj1 .action = url;
		obj1 .submit();
    }
   	else if(formName == 'patientSearch'){
    	url = "/hms/hms/opd?method=showSurgeryRequisitionJspFromPatientList&hinNo="+obj;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'updateOrder'){
    	url = "/hms/hms/lab?method=getPatientDetailsForOrderUpdate&orderId="+hin;
    	obj1 .action = url;
		obj1 .submit();
    } 
    else if(formName == 'preAnaesthesiaPatientSearch'){
    	url = "/hms/hms/ot?method=showPreAneaesthesiaProcNotesEntryJsp&hinNo="+obj;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'otProcedureNotesEntry'){
    	url = "/hms/hms/ot?method=showOtProcedureNotesEntryJsp&hinNo="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 
    else if(formName == 'leaveSearch'){
    	url = "/hms/hms/hrRelated?method=showLeaveMaintenanceEntryJsp&empId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'dutySearch'){
    	url = "/hms/hms/hrRelated?method=showDutyExemptionEntryJsp&empId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'updateArrival'){
    	url = "/hms/hms/hrRelated?method=showUpdateArrivalEntryJsp&empId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'leavePending'){
    	url = "/hms/hms/hrRelated?method=showLeavePendingEntryJsp&empId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'postAnaesthesiaPatientSearch'){
    	
    	url = "/hms/hms/ot?method=showPostAnaesthesiaJspFromPatientList&bookingId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 	 	
    
    else if(formName == 'transferToWardPatientSearch'){
    	
    	url = "/hms/hms/ot?method=showOtPatientToWard&bookingId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 	 	
    else if(formName == 'pendingForSurgeryConsentForm'){
    	
    	url = "/hms/hms/ot?method=showConsentEntryJsp&bookingId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 	
    else if(formName == 'pendingSurgeryWaitingList'){
    	
    	url = "/hms/hms/ot?method=showOTBookingJsp&PacHdId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 	
    
    else if(formName == 'preAnaesthesiaWaitingList'){
    	
    	url = "/hms/hms/ot?method=showPreAneaesthesiaProcNotesEntryJsp&surgeryHdId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 	
    
    
   else if(formName == 'pacList'){
    	
    	url = "/hms/hms/ot?method=showPreAnesthesiaForm&opdSurgeryId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 
    
   else if(formName == 'emergencyOPDWaitingList'){
   	url = "/hms/hms/opd?method=showEmergencyRecallJsp&visitId="+obj;
   	obj1 .action = url;
		obj1 .submit();
   } 
    
    else if(formName == 'lrWaitingList'){
    	
    	url = "/hms/hms/lr?method=showLaborRoomSubmitJsp&inpatientId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 	
    else if(formName == 'laborPatientTransfer'){
    	
    	url = "/hms/hms/lr?method=transferPatientJsp&inpatientId="+obj;
    	obj1 .action = url;
		obj1 .submit();
    } 	
    
    
    else if(formName == 'specimenDispatchEntryPatientSearch'){
    	url = "/hms/hms/ot?method=showSpecimenDispatchEntryJspFromPatientList&hinNo="+obj;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'patientSearchForDisposal'){
      
    	url = "/hms/hms/ot?method=showHumanBodyPartsDisposalJsp&hinNo="+hin;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'patientSearchForEmergencyOTBooking'){
      
    	url = "/hms/hms/ot?method=showEmergencyOTBookingJsp&hinNo="+hin;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'patientSearchForPreAnesthesia'){
     
    	url = "/hms/hms/ot?method=viewPreAnesthesiaDetails&preAnesthesiaDetailId="+hin;
    	obj1 .action = url;
		obj1 .submit();
    }
    else if(formName == 'orderNoList'){

    	url = "/hms/hms/lab?method=viewTestDetailsForCanceling&dgOrderHdId="+hin;
    	obj1 .action = url;
		obj1 .submit();
    } else if(formName == 'surgeryEnquiry'){
         
    //	url = "/hms/hms/ot?method=getSurgeryDetails&hinNo="+hin;
    	submitProtoAjax('surgeryEnquiry','/hms/hms/ot?method=getSurgeryDetails&hinNo='+hin)
    	//obj1 .action = url;
		//obj1 .submit();
    }else if(formName == 'pendingSampleValidationLab'){

    	url = "/hms/hms/lab?method=searchPatientForSampleValidationLab&combinedIds="+hin;
    	obj1 .action = url;
		obj1 .submit();
    } else if(formName == 'patientVisitPhysiotherapy'){
    	url = "/hms/hms/opd?method=showVisitDetails&hinId="+hin;
    	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'personnelSearchForForm8'){
	     url = "/hms/hms/pension?method=showForm8Jsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'updatePersonnelsearchForForm8'){
	     url = "/hms/hms/pension?method=showUpdateForm8Jsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateSpecialInvestigation'){
		url = "/hms/hms/mediClaim?method=showUpdateSpecialInvestigation&specInvHdId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateCardicAdvance'){
		url = "/hms/hms/mediClaim?method=showUpdateCardicClaim&cardicClaimId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateCardicBill'){
		url = "/hms/hms/mediClaim?method=showUpdateCardicBill&contingentHdID="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateMedicalBill'){
		url = "/hms/hms/mediClaim?method=showUpdateMedicalBill&contingentHdID="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateCoveringLetter'){
	url = "/hms/hms/mediClaim?method=showUpdateCoveringLetter&coveringLetterId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'personnelSearchForRetirementEntry'){
	     url = "/hms/hms/pension?method=showRetirementEntryFormJsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'updatePersonnelsearchForRetirementForm'){
	     url = "/hms/hms/pension?method=showUpdateRetirementEntryFormJsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
} else 
if(formName == 'bloodRequestEntry'){
    	url = "/hms/hms/bloodBank?method=showBloodRequestEntryJsp&hinId="+hin;
    	obj1 .action = url;
		obj1 .submit();
   }else if(formName == 'pendingBloodSampleCollection'){
	   	url = "/hms/hms/bloodBank?method=showBloodSampleColletionJsp&requestId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'pendingBloodSampleValidation'){
	   	url = "/hms/hms/bloodBank?method=showBloodSampleValidationJsp&sampleId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'pendingBloodSampleScreeningTest'){
		url = "/hms/hms/bloodBank?method=showBloodSampleScreeningTest&sampleId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'pendingBloodIssue'){
		url = "/hms/hms/bloodBank?method=showBloodIssueJsp&screeningId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'donorPendingBloodSampleScreening'){
	   	url = "/hms/hms/bloodBank?method=showDonorSampleScreeningJsp&donationId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchBloodTransfusion'){
	   	url = "/hms/hms/bloodBank?method=showConsentBloodTransfusion&inpatientId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchBloodDonor'){
	   	url = "/hms/hms/bloodBank?method=showUpdateDonationEntry&bloodDonationId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchReaction'){
	   	url = "/hms/hms/bloodBank?method=showUpdateReactionEntry&bloodReactionId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchTest'){
	   	url = "/hms/hms/bloodBank?method=showUpdateTestEntry&bloodTestId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchReactionEntry'){
	   	url = "/hms/hms/bloodBank?method=showReactionFormEntryJsp&inpatientId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchPndTransReaction'){
	   	url = "/hms/hms/bloodBank?method=showTransfussionReaction&bloodReactionId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'pendingBloodDiscard'){
	url = "/hms/hms/bloodBank?method=showBloodDiscardJsp&bloodStockDetailId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName=='personnelDetail'){
		url = "/hms/hms/pension?method=showUpdatePersonnelSearchJsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchSpecialInvestigation'){
   		url = "/hms/hms/mediClaim?method=showPatientDetails&hinId="+hin;
   		obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchContingentBill'){
	   	url = "/hms/hms/mediClaim?method=showPatientDetailsForContingentBill&specInvHdId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'personnelDetailForCalculation'){
   		url = "/hms/hms/pension?method=showCalculationSheet&personnelId="+hin;
   		obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'updatePersonnelDetailForCalculation'){
   		url = "/hms/hms/pension?method=showUpdateCalculationSheet&personnelId="+hin;
   		obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'personnelDetailForDataSheet'){
   		url = "/hms/hms/pension?method=showDataSheetJsp&personnelId="+hin;
   		obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'updatePersonnelsearchForDataSheet'){
   		url = "/hms/hms/pension?method=showUpdateDataSheetJsp&personnelId="+hin;
   		obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'personnelsearchForForm7'){
	
   		url = "/hms/hms/pension?method=showForm7Jsp&personnelId="+hin;
   		obj1 .action = url;
		obj1 .submit();
	}	else if(formName == 'searchGeneralClaim'){
		url = "/hms/hms/mediClaim?method=showPatientDetailsForGeneralTracking&contingentHdID="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchCardicClaim'){
		url = "/hms/hms/mediClaim?method=showPatientDetailsCardicClaim&hinId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchCardicContingentBill'){
	     url = "/hms/hms/mediClaim?method=showPatientDetailsForCardicReimbursement&cardicClaimId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchBillMovement'){
		url = "/hms/hms/mediClaim?method=showPatientDetailsForBillMovement&contingentHdID="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchCardicClaimTracking'){
		url = "/hms/hms/mediClaim?method=showPatientDetailsForCardicTracking&billMovementID="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}	else if(formName == 'updatePersonnelsearchForForm7'){
	     url = "/hms/hms/pension?method=showUpdateForm7Jsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'personnelSearchForForm8'){
	     url = "/hms/hms/pension?method=showForm8Jsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'updatePersonnelsearchForForm8'){
	     url = "/hms/hms/pension?method=showUpdateForm8Jsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateSpecialInvestigation'){
		url = "/hms/hms/mediClaim?method=showUpdateSpecialInvestigation&specInvHdId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateCardicAdvance'){
		url = "/hms/hms/mediClaim?method=showUpdateCardicClaim&cardicClaimId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateCardicBill'){
		url = "/hms/hms/mediClaim?method=showUpdateCardicBill&contingentHdID="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateMedicalBill'){
		url = "/hms/hms/mediClaim?method=showUpdateMedicalBill&contingentHdID="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'searchUpdateCoveringLetter'){
	url = "/hms/hms/mediClaim?method=showUpdateCoveringLetter&coveringLetterId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'personnelSearchForRetirementEntry'){
	     url = "/hms/hms/pension?method=showRetirementEntryFormJsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'updatePersonnelsearchForRetirementForm'){
	     url = "/hms/hms/pension?method=showUpdateRetirementEntryFormJsp&personnelId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'bookIssue'){
	     url = "/hms/hms/lib?method=showUpdateBlookissue&bookIssueHdId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'dentalWaitingList'){
	     url = "/hms/hms/dental?method=showDentalTreatmentJsp&visitId="+obj;
		   	obj1 .action = url;
			obj1 .submit();
	}
	
	else if(formName == 'pendingForPreOperativeCheckList'){
	     url = "/hms/hms/ot?method=showPreOperativeCheckListEntryJsp&bookingId="+obj;
		   	obj1 .action = url;
			obj1 .submit();
	}
    
	else if(formName == 'searchBookReturn'){
	     url = "/hms/hms/lib?method=showUpdateBookReturn&bookReturnHdId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}	else if(formName == 'bookStock'){
	   url = "/hms/hms/lib?method=showUpdateBookStock&bookStockHdId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName == 'pendingAvAppointment'){
	   url = "/hms/hms/aviationMedicine?method=showAvCA34FromWaitingJsp&avCA34Id="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}
	else if(formName == 'patientEnquiry1'){

        url = "/hms/hms/enquiry?method=showPatientDetails1&hinNo="+obj;

        obj = eval('document.'+formName)

        obj.action = url;
        obj.submit();
    }	else if(formName == 'meWaitingList'){
 	   url = "/hms/hms/medicalExam?method=showPrimaryExtMedExamJsp&visitId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}else if(formName=='mbWaitingList'){
                   	  tempTable += '<a href="javascript:showMedicalExamJsp(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][1]+'\',\''+formName+'\')">';
   }else if(formName == 'appSearchContingentBill'){
	   	url = "/hms/hms/mediClaim?method=showApprovePatientContBill&contHdId="+hin;
	   	obj1 .action = url;
		obj1 .submit();
	}
   else if(formName=='internalReferal')
	{
	/*url = "/hms/hms/ipd?method=showDetailsReferalRecord&reamrksId="+obj.id;*/
	/*url = "/hms/hms/ipd?method=showDetailsReferalRecord&parent="+obj.id;*/
	url = "/hms/hms/ipd?method=showConsultationEntryDetailsJsp&parent="+obj.id;
	obj1 .action = url;
	obj1 .submit();
	
	
	}
  

   // new Ajax.Updater('statusMessage', url, {asynchronous:true, evalScripts:true});
}
function RequestForPhy(obj,formName,flag,headerId,visitId){
	  obj1 = eval('document.'+formName)
	  
	  	id = obj.id;
	   
	  //	alert("headerId"+headerId)
	   if(flag=='OPD'){
	   url = "/hms/hms/physiotherapy?method=showPhysiotherapyJsp&physioTharapyHeaderId="+id+"&flag="+flag+"&visitId="+visitId;
	   obj1 .action = url;
	   obj1 .submit();
	   }else if(flag=='Appointment'){
			   url = "/hms/hms/physiotherapy?method=showPhysiotherapyVisitAppointmentJsp&physioTharapyAppointmentHeaderId="+id+"&physioRequisitionHeaderId="+headerId;
			   obj1 .action = url;
			   obj1 .submit();
	   }
	
}

function RequestForViewScreen(visitId,serviceNo,hinNo,token)
{
	
	
	document.getElementById('serviceNoForReport').value = serviceNo;
	document.getElementById('hospitalIdForReport').value = 1; 
	document.getElementById('hinNoForReport').value = hinNo;  
	document.getElementById('visitId').value = visitId;  
	submitFormForPrescriptionReport()
	/*showPreviousVisit(hinId,deptId,visitNo,token);*/
}


function dateCompare(){

var nowDate=new Date();

obj1 = eval('document.'+formName+'.validFromDate')
obj2 = eval('document.'+formName+'.validToDate')
		
if(obj1.value != "" && obj2.value != "")
	{

	validFromDate=new Date(obj1.value.substring(6),(obj1.value.substring(3,5) - 1) ,obj1.value.substring(0,2));
	validToDate=new Date(obj2.value.substring(6),(obj2.value.substring(3,5) - 1) ,obj2.value.substring(0,2));
				
		if(validFromDate<=nowDate)
			{
				if(validFromDate > validToDate)
				{
						errorMsg = "From Date should be smaller than To Date\n";
				}
			}
			
		else
			{
			errorMsg ="From Date should not be greater than Current date\n";
			}
	
	}
	return true;
}





function navigate1(obj){
	document.paging.firstpage.style.border = "none"
	document.paging.nextpage.style.border = "none"
	document.paging.lastpage.style.border = "none"
	document.paging.prevpage.style.border = "none"		
	//currentPage = document.paging.pageno.value;
	initTabButtons()
	if(obj.value == 'f' && data_arr.length>rowsPerPage){
		makeTable(0,rowsPerPage);
		//document.getElementById('pageno').value=1
		document.getElementById("current").innerHTML=1
	
		document.getElementById("currStart").value=1
		document.getElementById("currEnd").value=10
		document.paging.firstpage.disabled= true;
		document.paging.prevpage.disabled= true;
		document.paging.firstpage.className="previousDisable"
		document.paging.prevpage.className="singlePrevDisable"	

		document.paging.lastpage.disabled= false;
		document.paging.nextpage.disabled= false;
		document.paging.lastpage.className="next"
		document.paging.nextpage.className="singleNext"			
	}
	else if(obj.value == 'p'){
		if(start-rowsPerPage>=0){
			document.paging.lastpage.disabled= false;
			document.paging.nextpage.disabled= false;
			document.paging.lastpage.className="next"
			document.paging.nextpage.className="singleNext"	
			if(start==rowsPerPage){
				document.paging.firstpage.disabled= true;
				document.paging.prevpage.disabled= true;
				document.paging.firstpage.className="previousDisable"
				document.paging.prevpage.className="singlePrevDisable"	
			}
			else{
				document.paging.firstpage.disabled= false;
				document.paging.prevpage.disabled= false;
				document.paging.firstpage.className="previous"
				document.paging.prevpage.className="singlePrev"	
			}
			makeTable(start-rowsPerPage,start);
			//document.getElementById('pageno').value--;
			document.getElementById("currStart").value=(document.getElementById("current").innerHTML-2)*10+1
				document.getElementById("currEnd").value=(document.getElementById("current").innerHTML-1)*10
				document.getElementById("current").innerHTML--;
		}

	}
	else if(obj.value == 'n'){
		if(start+rowsPerPage*2<data_arr.length){
			makeTable(start+rowsPerPage,start+(rowsPerPage*2));
			
			//document.getElementById('pageno').value++;
			var tt=document.getElementById("current").innerHTML;
			
			document.getElementById("currStart").value=(tt)*10+1
			document.getElementById("currEnd").value=((tt*1)+1)*10
			document.getElementById("current").innerHTML++;
			
			document.paging.firstpage.disabled= false;
			document.paging.prevpage.disabled= false;
			document.paging.firstpage.className="previous"
			document.paging.prevpage.className="singlePrev"					
			
		}
		else if(start+rowsPerPage<data_arr.length){
			makeTable(start+rowsPerPage,data_arr.length);
			//document.getElementById('pageno').value++;		
			document.getElementById("currStart").value=(document.getElementById("current").innerHTML)*10+1
			document.getElementById("currEnd").value=data_arr.length
			document.getElementById("current").innerHTML++;	
			document.paging.lastpage.disabled= true;
			document.paging.nextpage.disabled= true;
			document.paging.lastpage.className="nextDisable"
			document.paging.nextpage.className="singleNext"	
			
			document.paging.firstpage.disabled= false;
			document.paging.prevpage.disabled= false;
			document.paging.firstpage.className="previous"
			document.paging.prevpage.className="singlePrev"							
		}
	}
	else if(obj.value == 'l'){
		if(data_arr.length % rowsPerPage == 0) {
			makeTable(data_arr.length - rowsPerPage, data_arr.length);
			//document.getElementById('pageno').value=totalPages;
			document.getElementById("currStart").value=data_arr.length-9
			document.getElementById("currEnd").value=data_arr.length
			document.getElementById("current").innerHTML=totalPages
		} else {
			makeTable((data_arr.length - (data_arr.length % rowsPerPage)), data_arr.length);
			//document.getElementById('pageno').value=totalPages;
			document.getElementById("currStart").value=data_arr.length-9
			document.getElementById("currEnd").value=data_arr.length
			document.getElementById("current").innerHTML=totalPages
		}
		document.paging.lastpage.disabled= true;
		document.paging.nextpage.disabled= true;
		document.paging.lastpage.className="nextDisable"
		document.paging.nextpage.className="singleNextDisable "	
		
		document.paging.firstpage.disabled= false;
		document.paging.prevpage.disabled= false;
		document.paging.firstpage.className="previous"
		document.paging.prevpage.className="singlePrev"	
	}
	if(!obj.disabled){
		obj.style.border = "1px solid yellow"
	}
}

function navigate11(obj){
	document.paging1.firstpage1.style.border = "none"
	document.paging1.nextpage1.style.border = "none"
	document.paging1.lastpage1.style.border = "none"
	document.paging1.prevpage1.style.border = "none"		
	//currentPage = document.paging.pageno.value;
		/*alert("start1="+start1)
		alert("rowsPerPage="+rowsPerPage);
		alert("data_arr1.length="+data_arr1.length);*/
	initTabButtons()
	
	if(obj.value == 'f' && data_arr1.length>rowsPerPage){
		makeTable1(0,rowsPerPage);
		//document.getElementById('pageno').value=1
		document.getElementById("current1").innerHTML=1
	
		document.getElementById("currStart1").value=1
		document.getElementById("currEnd1").value=10
		document.paging1.firstpage1.disabled= true;
		document.paging1.prevpage1.disabled= true;
		document.paging1.firstpage1.className="previousDisable"
		document.paging1.prevpage1.className="singlePrevDisable"	

		document.paging1.lastpage1.disabled= false;
		document.paging1.nextpage1.disabled= false;
		document.paging1.lastpage1.className="next"
		document.paging1.nextpage1.className="singleNext"			
	}
	else if(obj.value == 'p'){
		if(start1-rowsPerPage>=0){
			document.paging1.lastpage1.disabled= false;
			document.paging1.nextpage1.disabled= false;
			document.paging1.lastpage1.className="next"
			document.paging1.nextpage1.className="singleNext"	
			if(start1==rowsPerPage){
				document.paging1.firstpage1.disabled= true;
				document.paging1.prevpage1.disabled= true;
				document.paging1.firstpage1.className="previousDisable"
				document.paging1.prevpage1.className="singlePrevDisable"	
			}
			else{
				document.paging1.firstpage1.disabled= false;
				document.paging1.prevpage1.disabled= false;
				document.paging1.firstpage1.className="previous"
				document.paging1.prevpage1.className="singlePrev"	
			}
			makeTable1(start1-rowsPerPage,start1);
			//document.getElementById('pageno').value--;
			document.getElementById("currStart1").value=(document.getElementById("current1").innerHTML-2)*10+1
				document.getElementById("currEnd1").value=(document.getElementById("current1").innerHTML-1)*10
				document.getElementById("current1").innerHTML--;
		}

	}
	else if(obj.value == 'n'){
		
		
		if(start1+rowsPerPage*2<data_arr1.length){
		
			makeTable1(start1+rowsPerPage,start1+(rowsPerPage*2));
			
			//document.getElementById('pageno').value++;
			var tt=document.getElementById("current1").innerHTML;
			
			document.getElementById("currStart1").value=(tt)*10+1
			document.getElementById("currEnd1").value=((tt*1)+1)*10
			document.getElementById("current1").innerHTML++;
			
			document.paging1.firstpage1.disabled= false;
			document.paging1.prevpage1.disabled= false;
			document.paging1.firstpage1.className="previous"
			document.paging1.prevpage1.className="singlePrev"					
			
		}
		else if(start1+rowsPerPage<data_arr1.length){
			
			makeTable1(start1+rowsPerPage,data_arr1.length);
			//document.getElementById('pageno').value++;		
			document.getElementById("currStart1").value=(document.getElementById("current1").innerHTML)*10+1
			document.getElementById("currEnd1").value=data_arr1.length
			document.getElementById("current1").innerHTML++;	
			document.paging1.lastpage1.disabled= true;
			document.paging1.nextpage1.disabled= true;
			document.paging1.lastpage1.className="nextDisable"
			document.paging1.nextpage1.className="singleNext"	
			
			document.paging1.firstpage1.disabled= false;
			document.paging1.prevpage1.disabled= false;
			document.paging1.firstpage1.className="previous"
			document.paging1.prevpage1.className="singlePrev"							
		}
	}
	else if(obj.value == 'l'){
		if(data_arr.length1 % rowsPerPage == 0) {
			makeTable1(data_arr1.length - rowsPerPage, data_arr1.length);
			//document.getElementById('pageno').value=totalPages;
			document.getElementById("currStart1").value=data_arr1.length-9
			document.getElementById("currEnd1").value=data_arr1.length
			document.getElementById("current1").innerHTML=totalPages1
		} else {
			makeTable1((data_arr1.length - (data_arr1.length % rowsPerPage)), data_arr1.length);
			//document.getElementById('pageno').value=totalPages;
			document.getElementById("currStart1").value=data_arr1.length-9
			document.getElementById("currEnd1").value=data_arr1.length
			document.getElementById("current1").innerHTML=totalPages1
		}
		document.paging1.lastpage1.disabled= true;
		document.paging1.nextpage1.disabled= true;
		document.paging1.lastpage1.className="nextDisable"
		document.paging1.nextpage1.className="singleNextDisable "	
		
		document.paging1.firstpage1.disabled= false;
		document.paging1.prevpage1.disabled= false;
		document.paging1.firstpage1.className="previous"
		document.paging1.prevpage1.className="singlePrev"	
	}
	if(!obj.disabled){
		obj.style.border = "1px solid yellow"
	}
}


function navigate(obj){
 
	document.paging.firstpage.style.border = "none"
	document.paging.nextpage.style.border = "none"
	document.paging.lastpage.style.border = "none"
	document.paging.prevpage.style.border = "none"		
	//currentPage = document.paging.pageno.value;
		//alert("start="+start)
		//alert("rowsPerPage="+rowsPerPage);
		//alert("data_arr1.length="+data_arr.length);
	initTabButtons()
	if(obj.value == 'f' && data_arr.length>rowsPerPage){
	
		makeTable(0,rowsPerPage);
		//document.getElementById('pageno').value=1
		
		document.getElementById("current").innerHTML=1
	
		document.getElementById("currStart").innerHTML=1
		if(document.getElementById("rowsPerPageForItem")!=null)
		{

		if(document.getElementById("rowsPerPageForItem").value == 10){
		rowsPerPage = 10;
		document.getElementById("currEnd").innerHTML=10
		}
		}
		else{
		document.getElementById("currEnd").innerHTML=5
		}
		document.paging.firstpage.disabled= true;
		document.paging.prevpage.disabled= true;
		document.paging.firstpage.className="previousDisable"
		document.paging.prevpage.className="singlePrevDisable"	

		document.paging.lastpage.disabled= false;
		document.paging.nextpage.disabled= false;
		document.paging.lastpage.className="next"
		document.paging.nextpage.className="singleNext"			
	}
	else if(obj.value == 'p'){
		if(start-rowsPerPage>=0){
			document.paging.lastpage.disabled= false;
			document.paging.nextpage.disabled= false;
			document.paging.lastpage.className="next"
			document.paging.nextpage.className="singleNext"	
			if(start==rowsPerPage){
				document.paging.firstpage.disabled= true;
				document.paging.prevpage.disabled= true;
				document.paging.firstpage.className="previousDisable"
				document.paging.prevpage.className="singlePrevDisable"	
			}
			else{
				document.paging.firstpage.disabled= false;
				document.paging.prevpage.disabled= false;
				document.paging.firstpage.className="previous"
				document.paging.prevpage.className="singlePrev"	
			}
			makeTable(start-rowsPerPage,start);
			//document.getElementById('pageno').value--;
		if(document.getElementById("rowsPerPageForItem")!=null)
		{

			if(document.getElementById("rowsPerPageForItem").value == 10){
			rowsPerPage = 10;
		document.getElementById("currStart").innerHTML=(document.getElementById("current").innerHTML-2)*10+1
				document.getElementById("currEnd").innerHTML=(document.getElementById("current").innerHTML-1)*10
				document.getElementById("current").innerHTML--;
			}
		}
		else{
		document.getElementById("currStart").innerHTML=(document.getElementById("current").innerHTML-2)*5+1
				document.getElementById("currEnd").innerHTML=(document.getElementById("current").innerHTML-1)*5
				document.getElementById("current").innerHTML--;
		}
			
			
		}

	}
	else if(obj.value == 'n'){
		if(start+rowsPerPage*2<data_arr.length){
			makeTable(start+rowsPerPage,start+(rowsPerPage*2));
			
			//document.getElementById('pageno').value++;
			var tt=document.getElementById("current").innerHTML;
			if(document.getElementById("rowsPerPageForItem")!=null)
		{

		if(document.getElementById("rowsPerPageForItem").value == 10){
		document.getElementById("currStart").innerHTML=(tt)*10+1
				document.getElementById("currEnd").innerHTML=((tt*1)+1)*10
			document.getElementById("current").innerHTML++;
		}
		}
		else{
		document.getElementById("currStart").innerHTML=(tt)*5+1
				document.getElementById("currEnd").innerHTML=((tt*1)+1)*5
			document.getElementById("current").innerHTML++;
		}
			
			
			document.paging.firstpage.disabled= false;
			document.paging.prevpage.disabled= false;
			document.paging.firstpage.className="previous"
			document.paging.prevpage.className="singlePrev"					
			
		}
		else if(start+rowsPerPage<data_arr.length){
			makeTable(start+rowsPerPage,data_arr.length);
			//document.getElementById('pageno').value++;
		if(document.getElementById("rowsPerPageForItem")!=null)
		{

		if(document.getElementById("rowsPerPageForItem").value == 10){
	document.getElementById("currStart").innerHTML=(document.getElementById("current").innerHTML)*10+1
		}
		}
		else{
	document.getElementById("currStart").innerHTML=(document.getElementById("current").innerHTML)*5+1
		}	
			
				document.getElementById("currEnd").innerHTML=data_arr.length
			document.getElementById("current").innerHTML++;	
			document.paging.lastpage.disabled= true;
			document.paging.nextpage.disabled= true;
			document.paging.lastpage.className="nextDisable"
			document.paging.nextpage.className="singleNext"	
			
			document.paging.firstpage.disabled= false;
			document.paging.prevpage.disabled= false;
			document.paging.firstpage.className="previous"
			document.paging.prevpage.className="singlePrev"								
		}
	}
	else if(obj.value == 'l'){
		if(data_arr.length % rowsPerPage == 0) {
			makeTable(data_arr.length - rowsPerPage, data_arr.length);
			//document.getElementById('pageno').value=totalPages;
			document.getElementById("currStart").innerHTML=data_arr.length-4
				document.getElementById("currEnd").innerHTML=data_arr.length
			document.getElementById("current").innerHTML=totalPages
		} else {
			makeTable((data_arr.length - (data_arr.length % rowsPerPage)), data_arr.length);
			//document.getElementById('pageno').value=totalPages;
			document.getElementById("currStart").innerHTML=data_arr.length-4
				document.getElementById("currEnd").innerHTML=data_arr.length
			document.getElementById("current").innerHTML=totalPages
		}
		document.paging.lastpage.disabled= true;
		document.paging.nextpage.disabled= true;
		document.paging.lastpage.className="nextDisable"
		document.paging.nextpage.className="singleNextDisable "	
		
		document.paging.firstpage.disabled= false;
		document.paging.prevpage.disabled= false;
		document.paging.firstpage.className="previous"
		document.paging.prevpage.className="singlePrev"	
	}
	if(!obj.disabled){
		obj.style.border = "1px solid yellow"
	}
	
}

function goToPage(pageno){
	
	if(pageno == ""){
		alert("Please Enter Page No.")
		return false;
	}
	if( (pageno>totalPages) || (pageno<=0) || (pageno%1!=0) )
	{
		alert("Please Enter Correct Page No.")
	document.paging.pageno.value=""
	return false;
	}
	if(pageno == 1){
		document.paging.firstpage.disabled= true;
		document.paging.prevpage.disabled= true;
		document.paging.firstpage.className="previousDisable"
		document.paging.prevpage.className="singlePrevDisable"		
	
		document.paging.lastpage.disabled= false;
		document.paging.nextpage.disabled= false;
		document.paging.lastpage.className="next"
		document.paging.nextpage.className="singleNext"	
	}
	else if(pageno == totalPages){
		document.paging.firstpage.disabled= false;
		document.paging.prevpage.disabled= false;
		document.paging.firstpage.className="previous"
		document.paging.prevpage.className="singlePrev"		
	
		document.paging.lastpage.disabled= true;
		document.paging.nextpage.disabled= true;
		document.paging.lastpage.className="nextDisable"
		document.paging.nextpage.className="singleNext"		
	}
	else{
		document.paging.firstpage.disabled= false;
		document.paging.prevpage.disabled= false;
		document.paging.firstpage.className="previous"
		document.paging.prevpage.className="singlePrev"		
	
		document.paging.lastpage.disabled= false;
		document.paging.nextpage.disabled= false;
		document.paging.lastpage.className="next"
		document.paging.nextpage.className="singleNext"		
	}
	if(pageno*rowsPerPage<data_arr.length)
		makeTable(pageno*rowsPerPage-rowsPerPage,pageno*rowsPerPage)
	else
		makeTable(pageno*rowsPerPage-rowsPerPage,data_arr.length)
		if(document.getElementById("rowsPerPageForItem")!=null)
		{

		if(document.getElementById("rowsPerPageForItem").value == 10){
	document.getElementById("currStart").innerHTML=(pageno-1)*10+1
		document.getElementById("currEnd").innerHTML=(pageno)*10
		}
		}
		else{
	document.getElementById("currStart").innerHTML=(pageno-1)*5+1
		document.getElementById("currEnd").innerHTML=(pageno)*5
		}
		
		
		document.getElementById("current").innerHTML=pageno
	
	
	document.paging.pageno.value=""	
	
}

function multipleResults(obj){
	if(obj.checked == true){
		
		document.chargeCode.multiple.style.display = "inline";
		}
	else{
		
		document.chargeCode.multiple.style.display = "none";
		}
}
function checkMultiple(){

	

if (!window.window2) {
        // has not yet been defined
        window2 = window.open('/hms/jsp/sub_test.jsp','windowRef','width=600,height=400,scrollbars = yes');
    }
    else {
        // has been defined
        if (!window2.closed) {
            // still open
            window2.focus();
        }
        else {
            window2 = window.open('/hms/jsp/sub_test.jsp','windowRef','width=600,height=400,scrollbars = yes');
        }
    }

	
}

function doneSubTest(){
if(parent.document.subTest.length >0)
  {
		document.chargeCode.subTest.value=subTest1;
  }
	window.close()

}	

function chkMultipleTest(id){
	count = 0;	
	for(b=0;b<subtest_arr.length;b++){
		if(id == subtest_arr[b][3]){
			count++;
		}
	}
	if(count>0){
		document.chargeCode.multipleresults.checked = true;
		multipleResults(document.chargeCode.multipleresults)
		document.chargeCode.multiple.value= "Multiple Results ("+count+")";
	}
}
function submitForm1(chargeDetails,div,action){
	obj = eval('document.'+chargeDetails) 
	if(validateFields(document.getElementById(div))){
		obj.action = action;
		obj.submit();
	}
}
var date1,date2;
function compareDates(){
	dateobj1 = new Date(date1)
	dateobj2 = new Date(date2)	
	if(dateobj1>dateobj2){
		errorMsg+= 'Field From Date cannot be greater than field To Date';
		return false; 
	}
	return true;
}
function compareCurrentDate(date1, date2, fieldName){
	dateobj1 = new Date(date1)
	dateobj2 = new Date(date2)	
	alert(dateobj1)
	alert(dateobj2)
	if(dateobj1>dateobj2){
		errorMsg+= 'Field '+fieldName+' should not be greater than todays date';
		return false; 
	}
	return true;
}

function replaceSubstring(inputString, fromString, toString) {
   var temp = inputString;
   if (fromString == "") {
      return inputString;
   }
   if (toString.indexOf(fromString) == -1) { // If the string being replaced is not a part of the replacement string (normal situation)
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } else { // String being replaced is part of replacement string (like "+" being replaced with "++") - prevent an infinite loop
      var midStrings = new Array("~", "`", "_", "^", "#");
      var midStringLen = 1;
      var midString = "";
      // Find a string that doesn't exist in the inputString to be used
      // as an "inbetween" string
      while (midString == "") {
         for (var i=0; i < midStrings.length; i++) {
            var tempMidString = "";
            for (var j=0; j < midStringLen; j++) { tempMidString += midStrings[i]; }
            if (fromString.indexOf(tempMidString) == -1) {
               midString = tempMidString;
               i = midStrings.length + 1;
            }
         }
      } // Keep on going until we build an "inbetween" string that doesn't exist
      // Now go through and do two replaces - f, replace the "fromString" with the "inbetween" string
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + midString + toTheRight;
      }
      // n, replace the "inbetween" string with the "toString"
      while (temp.indexOf(midString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(midString));
         var toTheRight = temp.substring(temp.indexOf(midString)+midString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } // Ends the check to see if the string being replaced is part of the replacement string or not
   return temp; // Send the updated string back to the user
} // Ends the "replaceSubstring" function


/*-------------------------------Sorting start-----------------------*/
var sortNo;
function sortTable(no,dir){
	document.paging.firstpage.disabled= true;
	document.paging.prevpage.disabled= true;
	document.paging.firstpage.className="previousDisable"
	document.paging.prevpage.className="singlePrevDisable"	
	document.paging.lastpage.disabled= false;
	document.paging.nextpage.disabled= false;
	document.paging.lastpage.className="next"
	document.paging.nextpage.className="singleNext"		
    sortNo = no;
    data_arr.sort(mysortfn)
        if(dir == 'dn'){
            data_arr.reverse();
        }
      
    if(data_arr.length<rowsPerPage)    
  	  makeTable(0,data_arr.length)
  	else
	    makeTable(0,rowsPerPage)
    //document.getElementById('pageno').value=1
    document.getElementById("currStart").innerHTML=1
				document.getElementById("currEnd").innerHTML=5
    document.getElementById("current").innerHTML=1
}
function mysortfn(a,b) {
var a1 = a[sortNo+1].toString().toUpperCase();
var b1 = b[sortNo+1].toString().toUpperCase();

  if (a1<b1) return -1;
  if (a1>b1) return 1;
  return 0;
}

/*-------------------------------Sorting ends-----------------------*/

function initFocus(){
	if(!document.getElementById('contentspace'))
		return;
	inps = document.getElementById('contentspace').getElementsByTagName('input')
	for(v=0;v<inps.length;v++){
		if(inps[v].type == 'button' || inps[v].type == 'submit'){
			inps[v].onfocus = showFocus;
			inps[v].onblur = hideFocus;			
		}
	}
}
function showFocus(){
	//this.setAttribute('border',1)
}
function hideFocus(){
	//this.style.borderWidth ="0px";
}

function initTabButtons(){
    buttonObj = document.getElementsByTagName('input')
    if(buttonObj){
        for(i=0;i<buttonObj.length;i++){
            if(buttonObj[i].className=="button"){
                buttonObj[i].onfocus = setBorder;
                buttonObj[i].onblur = resetBorder;
           }
       }    
    }
}
function setBorder(){
//	this.style.border = "#146faa"
//	this.style.width = "18px"
//	this.style.height= "19px";
}

function resetBorder(){
	this.style.border = "none"
}



function getDaysInMonth(dobMonth, dobDay, curDay){
    dayinMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
    usrMonth = dobMonth - 1;
    usrDay = dobDay;
    day = curDay;
    daysinMonth = dayinMonth[usrMonth];
    outDay = daysinMonth - usrDay;
    outDay = outDay + day
    return outDay;

}

function clearRecords(obj){
		if(document.getElementById('multiplebutton'))
			document.getElementById('multiplebutton').style.display = "none";	
	if(currentRowClicked != ""){
		editRecord(document.getElementById(currentRowClicked),formName)

	}
	
	obj.blur();
}


function fetchUserValue(obj,formName){
           
  object = eval('document.'+formName)
  if(obj.value != ""){
  	
   		for(var i = 0;i<userArray.length;i++ ){
   		
      if(userArray[i][0] == obj.value){
          
         
           object.loginName.value = userArray[i][0];
           object.userName.value = userArray[i][1];
           object.EmployeeCode.value = userArray[i][2];
           object.password.value = userArray[i][3];
           object.changed_by.value = userArray[i][5];
           object.changed_date.value = userArray[i][6];
           object.changed_time.value = userArray[i][7];
           object.userId.value = userArray[i][8];
           if(userArray[i][4] == "1"){
               userArray[i][4]
               object.status[0].checked = true;
               }
           else
               object.status[1].checked = true;
           break;
       } 
   }
  } 
  else{
           object.code.value = "";
           object.search_name.value = "";
           object.changed_by.value = "";
           object.changed_date.value = "";
           object.changed_time.value = "";
           object.status[0].checked = true;
 } 
  
  
}


function checkSearch(){

	if(document.getElementById('searchField').value == ''){
		alert("Please enter value in textfield");

		return false;
	}else
		return true;
}

function checkBlankSoc1(){
var id = document.getElementById('radio').value;

	if(id == 0 ){
		errorMsg += "Please select Option.\n";
		return false;
	}
	
	return true;
	
	
}
function checkBlankSoc1(){

	var id = document.getElementById('radio').value;

	if(id == 0 ){
		errorMsg += "Please select Option.\n";
		return false;
	}
	
	return true;
	
	
}
function fetchUserValue2(obj,formName){
          
  object = eval('document.'+formName)
  if(obj.value != ""){
  	 
   		for(var i = 0;i<userArray2.length;i++ ){
   		 
      if(userArray2[i][0] == obj.value){
          
         
           object.loginName.value = userArray2[i][0];
           object.userName.value = userArray2[i][1];
           object.EmployeeCode.value = userArray2[i][2];
           object.password.value = userArray2[i][3];
           object.changed_by.value = userArray2[i][5];
           object.changed_date.value = userArray2[i][6];
           object.changed_time.value = userArray2[i][7];
           object.userId.value = userArray2[i][8];
           
           break;
       } 
   }
  } 
  else{
           object.code.value = "";
           object.search_name.value = "";
           object.changed_by.value = "";
           object.changed_date.value = "";
           object.changed_time.value = "";
           object.status[0].checked = true;
 } 
  
  }
  
function checkMaxLength(obj){
      if(window.event){
          keyObj = window.event.keyCode
          if(keyObj == 9 || keyObj == 8 ||keyObj == 46 || keyObj == 16 || keyObj == 37 || keyObj == 36 || keyObj == 35 || window.event.ctrlKey )
              return true;
      }
      if(obj.getAttribute("maxlength")){
		if(obj.value.length>obj.getAttribute("maxlength")-1){    
  	        return false;
      	}

      }
}
pasteFlag = false
function checkOnPaste(obj){
 pasteFlag = true;
 /*   txt =window.clipboardData.getData("Text", obj.value)
    if(obj.getAttribute("maxlength")){
     if((txt.length+obj.value.length)>obj.getAttribute("maxlength")-1){
	        obj.value = obj.value.substring(0,obj.getAttribute("maxlength"));
    	    return false;
    	}
    }*/
}
function checkMaxLengthMoz(obj){
    if(obj.getAttribute("maxlength")){
     if(obj.value.length>obj.getAttribute("maxlength")-1){
         obj.value = obj.value.substring(0,obj.getAttribute("maxlength"))
	        return false;
    	}
    }
}
function finalCheck(obj){
 if(obj.getAttribute("maxlength")){
       	if(pasteFlag){
    		obj.value = obj.value.substring(0,obj.getAttribute("maxlength"));
    		pasteFlag = false;
    	}
    }
}  
   
function alertBeforeSubmit(){
	if(confirm("Are you Sure, you want to submit the details ?"))
		return true;
	return false;
}


function resetCheck(){
	document.getElementById('addbutton').style.display = 'inline';
	document.getElementById('reset').style.display = 'inline';
	document.getElementById('editbutton').style.display = 'none';
	document.getElementById('deletebutton').style.display = 'none';
	document.getElementById('codeId').readOnly = false;
}




//Function to toggle Div, with Plus/Minus image :: By Subin Feb 11 08

function togPlus(objDiv,objImg)
{
	
	if(document.getElementById(objDiv))
	{
		var myElement = document.getElementById(objDiv);    
		if (myElement.style.display == "none")
		{
     	 	myElement.style.display = "block";
    	 	objImg.src = "/hms/jsp/images/minus1.gif";
		}
		else{
	      	myElement.style.display = "none";
	      	objImg.src = "/hms/jsp/images/plus1.gif";
		}
	}
}

//End of Function to toggle Div, with Plus/Minus image 


//-----------------For submit form on Enter key Press  -----------------------

function submitenter(myfield,e,url,extraFunction)
{
	
	obj1 = true;
	var keycode;
	if (window.event)
		 keycode = window.event.keyCode;
	else if (e) 
		keycode = e.which;
	else return true;
	if (keycode == 13)
	   {
		//alert(keycode)
	   	if(eval("window."+extraFunction))
	    	obj1 =  eval(extraFunction+"()")
	   		
	   if(obj1){
	       if(myfield.form.name == "mmfForm" || myfield.form.name == "indentForm"){
	       	jsSubmit();
	       }else{
		  	 myfield.form.action = url;
		  	 myfield.form.submit();
		  	 }
		   return true;
		}else{
		   return false;
		  }
	   }
	
}

function validateDate( strValue ) {
  var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/
 
  if(!objRegExp.test(strValue))
    return false; 
  else{
    var strSeparator = strValue.substring(2,3) 

    var arrayDate = strValue.split(strSeparator); 
    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
                        '08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
 var intDay = parseInt(arrayDate[0],10);
  

    if(arrayLookup[arrayDate[1]] != null) {
      if(intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
        return true; 
    }
 var intMonth = parseInt(arrayDate[1], 10);

    if (intMonth == 2) { 
       var intYear = parseInt(arrayDate[2]);
       if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
          return true;
       }
  }
  return false; 
}

//------------------ Start For Dynamic Grid---------------------------------------

//This function is used for adding a row dynamically to a table
//At a time generateRow() will one to table
	   function generateRow(idName) {
    	
		var d=document.getElementById(idName).getElementsByTagName("tr");
		lastTr = d[d.length-1]
		clone = lastTr.cloneNode(true);
		clone.id = parseInt(lastTr.id);
		lastTr.parentNode.insertBefore(clone,lastTr.nextSibling)
		var tblCtrl = d[d.length-1].getElementsByTagName("input"); 
		tblCtrl[1].value=d.length-1;
		for(var i=4;i<tblCtrl.length;i++)
			tblCtrl[i].value="";
			
		}
		
function generateRowWithoutSrNo(idName) {
    	
		var d=document.getElementById(idName).getElementsByTagName("tr");
		lastTr = d[d.length-1]
		var noOfRows=d.length
		clone = lastTr.cloneNode(true);
		clone.id = parseInt(lastTr.id);
		lastTr.parentNode.insertBefore(clone,lastTr.nextSibling)
		var tblCtrl = d[d.length-1].getElementsByTagName("input"); 
		for(var i=0;i<tblCtrl.length;i++)
			tblCtrl[i].value="";
			if(document.getElementById('amcTDetailsListSize'))
				document.getElementById('amcTDetailsListSize').value=noOfRows
			
		}
		
//This function is used for deleting multiple rows at time
		function removeRow(argIndex,idName){
	
	         var table=document.getElementById(idName);
	         var tblRows  = table.getElementsByTagName("tr");
	         var check=0;
	         
	         for(i=tblRows.length-1;i>0;i--)
	        {         
	         var tblCtrl =  tblRows[i].getElementsByTagName("input"); 
	         
	         
	               for(j=0;j<tblCtrl.length;j++)
	               {
	                  if(tblCtrl[j].type == 'checkbox')
	                   {    
	                    if(tblCtrl [j].checked)
	                              check=check+1;
	                   }
	               }
	        }
	         if(tblRows.length-1==check){
	         	alert("Can not delete all rows")
	         	return false;
	         }
			
	        for(i=tblRows.length-1;i>0;i--)
	        {         
	         var tblCtrl =  tblRows[i].getElementsByTagName("input"); 
	         
	               for(j=0;j<tblCtrl.length;j++)
	               {
	                  if(tblCtrl[j].type == 'checkbox')
	                   {    
	                    if(tblCtrl [j].checked){
	                    	// var k=argIndex.parentNode.parentNode.rowIndex;
	                    	   // tbl.deleteRow(k);
	                           document.getElementById(idName).deleteRow(i);
	                    }
	                   }
	               }
	        }
     }
     
 //------------------ End For Dynamic Grid---------------------------------------
   
   
//------------------ This is For SOC Indent---------------------------------------   
function submitFormSOC(formName,action,extraFunction,extraFunction2,extraFunction3){
errorMsg="";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		if(eval("window."+extraFunction))
	    	ob1 =  eval(extraFunction+"()")
	        
			if(eval("window."+extraFunction2))
	        	ob2 = eval(extraFunction2+"()")
	        
			if(eval("window."+extraFunction3))
	        	ob3 = eval(extraFunction3+"()")        	
	    	
			if(validateFields(formName)== true & ob1 & ob2 &ob3){
	        	return true;
	    	
			}else{
	    	   	
				if(errorMsg != ""){
					alert(errorMsg);
		       		return false;	
		       	}
		       	return true;
	    	}
	}
    
	//------------ function for adding no. of days to a date--------
	// Added by Priyanka Garg
	function submitEDReturns(formName,extraFunction1,extraFunction2,extraFunction3,extraFunction4)
	{
		visitId = document.getElementById('visitId').value;
		edDate=document.getElementById('edDate').value;
		edDays=document.getElementById('edDays').value;
		edDispose=document.getElementById('edDispose').value;
		edDate1=document.getElementById('edDate1').value;
		edDate2=document.getElementById('edDate2').value;
		edDate3=document.getElementById('edDate3').value;
		diagnosisId=document.getElementById('diagnosisId').value;
		//ldDate=document.getElementById('ldDate').value;
		//ldDays=document.getElementById('ldDays').value;
	
	
		ob1=true;
		ob2=true;
		ob3=true;
		ob4=true;
		obj = eval('document.'+formName)
		if(eval("window."+extraFunction1))
	    	ob1 =  eval(extraFunction1+"()")
	    	
	    if(eval("window."+extraFunction2))
	    	ob2 =  eval(extraFunction2+"()")
	    	
	    if(eval("window."+extraFunction3))
	    	ob3 =  eval(extraFunction3+"()")
	    	
	     if(eval("window."+extraFunction4))
	    	ob4 =  eval(extraFunction4+"()")
	
   
    	var url;
   		if(formName == 'EDDetails')
    	url = "/hms/hms/mis?method=editEDReturns&visitId="+visitId
    	      +"&edDays="+edDays+"&edDate="+edDate+"&edDispose="+edDispose
    	      +"&edDate1="+edDate1+"&edDate2="+edDate2+"&edDate3="+edDate3+"&diagnosisId="+diagnosisId;
    	      
   
     	if(ob1 & ob2 & ob3 & ob4)
    	{
	    	obj.action = url;
			obj.submit();
	    	
		}else{
		return false;	
	}
   	
//    new Ajax.Updater('statusMessage', url, {asynchronous:true, evalScripts:true});
}
function checkEdReturnField()
{

  var noOfEdDays=document.getElementById("edDays").value;
//  var noOfLdDays=document.getElementById("ldDays").value;
  var edStartDate=document.getElementById("edDate").value;
 // var ldStartDate=document.getElementById("ldDate").value;
  var dispose=document.getElementById("edDispose").value;
  
  if(((noOfEdDays!="" && edStartDate!="")||(noOfLdDays!="" && ldStartDate!="")) && dispose!="")
 	{
  		
  		return true;
  	}
  else
  {
  		alert("Enter Data for mandatory fields");
  		return false;
  }
}
function submitEdReturnForm()
{ 
  var noOfEdDays=document.getElementById("edDays").value;
 // var noOfLdDays=document.getElementById("ldDays").value;
  var edStartDate=document.getElementById("edDate").value;
  //var ldStartDate=document.getElementById("ldDate").value;
  var edDispose=document.getElementById("edDispose").value;
  var formatEdDate=new Date(edStartDate.substring(6),(edStartDate.substring(3,5) - 1) ,edStartDate.substring(0,2));
  //var formatLdDate=new Date(ldStartDate.substring(6),(ldStartDate.substring(3,5) - 1) ,ldStartDate.substring(0,2));
  var currentDate=new Date();
  
 
    	if(noOfEdDays!="" && edStartDate=="")
  		{
  			alert("Provide Start Date !!");
  			document.getElementById("edDate").focus;
  			return false;
  			
 		 }
 		 if(noOfEdDays=="" && edStartDate!="")
 		 {
  			alert("Provide No. of days !!");
  			document.getElementById("edDays").focus;
  			return false;
  		}
  /*if (noOfLdDays!="" && ldStartDate=="")
  {
  		alert("Provide LD Start Date !!");
  		document.getElementById("ldDate").focus;
  		return false;
  }
  if(noOfLdDays=="" && ldStartDate!="")
 	{
 		alert("Provide no. of days of LD !!");
  		document.getElementById("ldDays").focus;
 		return false;
 	}*/
  	if(formatEdDate>currentDate)
  	{	
  		alert("Start Date should be less than Today's Date!");
  		return false;
  	}
 /*if(formatLdDate>currentDate)
  {
  		alert("LD Start Date should be less than Today's Date!");
  		return false;
  }*/	
  
  	if(edDispose=="ED")
 	{
 		if(noOfEdDays>2)
 		{
 			alert("Not more than 2 ED allowed!!");
 			document.getElementById("edDays").value="";
 			document.getElementById("edDays").focus;
 			return false;
 		}
 		else
 		{
 			addDays();
 			
 		}
 	}
 	else if(edDispose=="LD" || edDispose=="MD")
 	{
 		if(noOfEdDays<=0)
 		{
 			alert("Invalid Data in No. of days!!");
 			document.getElementById("edDays").value="";
 			document.getElementById("edDays").focus;
 			return false;
 		}
 		else
 		{
 			document.getElementById("edDate1").value="";
			document.getElementById("edDate2").value="";
			document.getElementById("edDate3").value="";
 		}
 	}
  		return true;
}
	function addDays()
	{
		if(document.getElementById("edDispose").value=="ED")
		{
			document.getElementById("edDate1").value="";
			document.getElementById("edDate2").value="";
			document.getElementById("edDate3").value="";
			edDays=document.EDReturns.edDays.value;
			var currentDate=new Date();
			var edStartDate=document.getElementById("edDate").value;
			var edDate = new Date(edStartDate.substring(6),(edStartDate.substring(3,5) - 1) ,edStartDate.substring(0,2))
			var calculatedDate=new Array();
			var counter=0;
			while(counter<edDays)
			{
				calculatedDate[counter]=new Date(edDate.getTime()+counter*24*60*60*1000);
				counter++;
				
			}
			if(calculatedDate[0]!=null)
				document.getElementById("edDate1").value=calculatedDate[0].getDate()+"/"+eval(calculatedDate[0].getMonth()+1)+"/"+calculatedDate[0].getFullYear();
			if(calculatedDate[1]!=null)
				document.getElementById("edDate2").value=calculatedDate[1].getDate()+"/"+eval(calculatedDate[1].getMonth()+1)+"/"+calculatedDate[1].getFullYear();
			if(calculatedDate[2]!=null)
				document.getElementById("edDate3").value=calculatedDate[2].getDate()+"/"+eval(calculatedDate[2].getMonth()+1)+"/"+calculatedDate[2].getFullYear();
		}
	}
    
 
function validateSearchForAdt(){

	var searchValue;
	var serviceNo;
	var hinNo;
	var patientName;
	var adNo;
		
	if(document.getElementById('searchField'))
	 	searchValue = document.getElementById('searchField').value;
	if(document.getElementById('serviceNo'))
		serviceNo = document.getElementById('serviceNo');
	if(document.getElementById('hinNo'))
		hinNo = document.getElementById('hinNo');
	if(document.getElementById('patientName'))
		patientName = document.getElementById('patientName');
	if(document.getElementById('adNoId'))
		adNo = document.getElementById('adNoId');
	
	
	if(trimAll(searchValue) == ''){
		alert("Please enter value in textfield.");
		return false;
	}else{
		if(serviceNo.checked){
			if(!validateAlphaNumeric(trimAll(searchValue))){
				alert("Employee No is not valid.");
				document.getElementById('searchField').value = "";
				return false;
			}
		}else if(hinNo.checked){
			if(!validateNumeric(trimAll(searchValue))){
				alert("Hin No is not valid.");
				document.getElementById('searchField').value = "";
				return false;
			}
		}else if(patientName.checked){
			if(!validateAlphaSpace(trimAll(searchValue))){
				alert("Patient Name is not valid.");
				document.getElementById('searchField').value = "";
				return false;
			}
		}else if(adNo.checked){
			if(!validateNumericWithSlash(trimAll(searchValue))){
				alert("Ad No is not valid.");
				document.getElementById('searchField').value = "";
				return false;
			}
		}
	}
	return true;
}

function validateNumericWithSlash(strValue){
	var objRegExp = /^(\d{1,}[\/]\d*[\/]\d*[\/]\d*)$/
	return objRegExp.test(strValue);
	
}
function checkBlankForPatientSearch(){
			
			var serviceNo=document.getElementById("serviceNo").value
			var hinNo=document.getElementById("hinNo").value
			var admissionNo=document.getElementById("admissionNo").value
			
			//alert("hinNo--:"+hinNo+"---serviceNo-----:"+trimAll(serviceNo)+"admissionNo----:"+admissionNo)
			if(serviceNo != "" || hinNo != "" || admissionNo != 0 )
			{
				if(serviceNo != "")
				{
					  if(!chkSpaces(serviceNo))
					  {
					  	alert("Please Enter The Service Number without Spaces.")
					  	return false;
					  }
					if(trimAll(serviceNo) =="" )
					{
							alert("Please Enter the correct value of Employee No without spaces.")
							return false;
					}
				}
				if(hinNo != "")	
				{
				
					if(!chkSpaces(hinNo))
					  {
					  	alert("Please Enter The HIN Number without Spaces.")
					  	return false;
					  }
				  if(trimAll(hinNo) =="" )
					{
						alert("Please Enter the correct value of HIN No without spaces.")
						return false;
					}
						
				}	
				 return true;
			}
			if(serviceNo == "" && hinNo == "" && admissionNo == 0 )
			{
			 alert("Please select the value for searching the patient")
			 return false;
			}
		   return true;
		}
		function checkFromNTodata()
{
	
	var fromDateForm=document.getElementById("fromDateId").value;
	var toDateForm=document.getElementById("ToDateId").value;
	var fromDate=new Date(fromDateForm.substring(6),(fromDateForm.substring(3,5) - 1) ,fromDateForm.substring(0,2));
	var toDate=new Date(toDateForm.substring(6),(toDateForm.substring(3,5) - 1) ,toDateForm.substring(0,2));
	var currentDate=new Date();
	if((fromDate>currentDate)|| (fromDate>toDate))
	{
		alert("Invalid Date in From Date!!");
		return false;
	}
	if((toDate>currentDate)||(toDate<fromDate))
	{
		alert("Invalid To Date!!");
		return false;
	}
	return true;
}
function checkDateNotGreaterThanCurrentDate()
{
	var inputDate=document.getElementById("inputDate").value;
	var currentDate=new Date();
	var formatInputDate=new Date(inputDate.substring(6),(inputDate.substring(3,5) - 1) ,inputDate.substring(0,2));
	if(formatInputDate>currentDate)
	{
		alert("Wrong Date entered !");
		return false;
	}
	else 
		return true;
}


//=======
/*function freight(){
var freight = document.getElementById('freightDuty').value
if(!validateFloat(freight)){
alert(" Freight Duty should be an integer or float");
}
}

function excise(){
var exciseDuty = document.getElementById('exciseDuty').value
if(!validateFloat(excise)){
alert(" Excise Duty should be an integer or float");
}
}

function custom(){
var customDuty = document.getElementById('customDuty').value
if(!validateFloat(custom)){
alert(" Custom Duty should be an integer or float");
}
}

function octroi(){
var octroi = document.getElementById('octroi').value
if(!validateFloat(octroi)){
alert(" Octroi should be an integer or float");
}
}


function insurance(){
var insuranceCharges = document.getElementById('insuranceCharges').value
if(!validateFloat(insurance)){
alert(" Insurance Charges should be an integer or float");
}
}


function otherCharges(){
var otherCharges = document.getElementById('otherCharges').value
if(!validateFloat(otherCharges)){
alert(" Other Charges should be an integer or float");
}
}


function custom(){
var customDuty = document.getElementById('customDuty').value
if(!validateFloat(custom)){
alert(" Custom Duty should be an integer or float");
}
}
*/
//---------Added By Othi-----------------
function validateRadioForGroup()
	{
			 for(var i = 0; i < document.getElementsByName('groupHospitalId').length; i++){
			  if(document.getElementsByName('groupHospitalId')[i].checked == true)
              {
				return true;
			  }		
  		}
  		alert("Please select the Group")
		return false;
	}




// ------- For Setting target of form --- By Ritu-----------------------

function checkTargetForYes(){
	var aTags = document.getElementsByTagName('form');
	for (i=0; i < aTags.length; i++) {
			aTags[i].setAttribute("target", "_blank");
		}
	return true;
}

function checkTargetForNo(){
	var aTags = document.getElementsByTagName('form');
	for (i=0; i < aTags.length; i++) {
			aTags[i].setAttribute("target", "_self");
		}
	return true;
}

//---------------------------------------------------
function multiplResults(obj){
if(obj.checked == true){
var url;
url="/hms/hms/investigation?method=showNormalValue";
alert(url);
obj.action=url;
obj.submit();
}else{
}
}
//-------------------- Added by Priyanka Fro Appointment Module --------------

	
function validateCriteria(){
			
			 for(var i = 0; i < document.getElementsByName('selectedRadio').length; i++){
			//alert("i-- "+i)
			//alert("document.getElementsByName('parent').length"+ document.getElementsByName('parent').length)
			  if(document.getElementsByName('selectedRadio')[i].value != "0" )
              {
				if(document.getElementsByName('selectedRadio')[i].value=="serviceNo")
				{
					document.getElementsByName('serviceNo')[i].value!="" 
					return true;
				}
				else if(document.getElementsByName('hinNo')[i].value=="hinNo")
				{
					document.getElementsByName('hinNo')[i].value!="" 
					return true;
				}
				
			  }		
  		}
		return false;
		
}
//-----------------Function By Dipali--------------
 function selectAccepted()
{
	if(document.getElementById('validated').checked==true)
	{
		document.getElementById('accepted').checked=true;
	}
	else
	{
		document.getElementById('accepted').checked=false;
	}
}

function compareTime(formName)
{
	if(document.formName.fromTime.value >= document.formName.toTime)
	{
		alert("From Time should be less than To Time");
		return false;
	}
	return true;
		 
}

		function isApptGrCurrentDate(formName)
		{
			var msg="";
			var dept=document.getElementById('departmentId').value;
			var appointmentDate=document.getElementById('appointmentdate').value;
			if(formName='investigationAppointments')
			{
					var equipment=document.getElementById('equipmentId').value;
					if (dept==0 )
					{
						msg="Select Department"+".\n";
							
					}
					if(appointmentDate=="")
					{
						msg="Select Appointment Date"+".\n";
					}
					if(msg!="")
					{
						alert(msg);
						return false;
					}
					
			}
			else if (formName='patientAppointments')
			{
				if(dept==0)
				{
					alert("Select department!!");
					return false;
				}
			
			}
			
			
				apmtDate = new Date(appointmentDate.substring(6),(appointmentDate.substring(3,5) - 1) ,appointmentDate.substring(0,2));
			 	currentDate = new Date();
				var month = currentDate.getMonth() + 1
				var day = currentDate.getDate()
				var year = currentDate.getFullYear()
				var seperator = "/"
				currentDate = new Date(month + seperator + day + seperator + year);
				if(apmtDate < currentDate)
				{	
					alert("Appointment Date should be greater than Today's date!!");
					document.getElementById('appointmentdate').value="";
					return false;
				}
				else
				{
				
					return true;
				}
			
			
		}
		
		function isApptGrCurrentDate1()
		{
			var msg="";
			var dept=document.getElementById('departmentId').value;
			var appointmentDate=document.getElementById('appointmentdate').value;
			if(dept==0)
			{
					alert("Select department!!");
					return false;
			}
			apmtDate = new Date(appointmentDate.substring(6),(appointmentDate.substring(3,5) - 1) ,appointmentDate.substring(0,2));
			 	currentDate = new Date();
				var month = currentDate.getMonth() + 1
				var day = currentDate.getDate()
				var year = currentDate.getFullYear()
				var seperator = "/"
				currentDate = new Date(month + seperator + day + seperator + year);
				if(apmtDate < currentDate)
				{	
					alert("Appointment Date should be greater than Today's date!!");
					document.getElementById('appointmentdate').value="";
					return false;
				}
				else
				{
				
					return true;
				}
			
			
		}
		
		function isOtGrCurrentDate1()
		{
			if(document.getElementById('newBookingDate').value!="")
			{
				var msg="";
				var bookingDate=document.getElementById('newBookingDate').value;
				apmtDate = new Date(bookingDate.substring(6),(bookingDate.substring(3,5) - 1) ,bookingDate.substring(0,2));
				 	currentDate = new Date();
					var month = currentDate.getMonth() + 1
					var day = currentDate.getDate()
					var year = currentDate.getFullYear()
					var seperator = "/"
					currentDate = new Date(month + seperator + day + seperator + year);
					if(apmtDate < currentDate)
					{	
						alert("OT Surgery Date should be greater than Today's date!!");
						document.getElementById('newBookingDate').value="";
						return false;
					}
					else
					{
					
						return true;
					}
				}
				else
				{
					return true;
				}
			
			
		}
		
		
		function checkForHoliday()
		{
			if(holidayArray.length>0)
			{
				for(i=0;i<holidayArray.length;i++)
				{
					if(holidayArray[i][1]==document.getElementById('appointmentdate').value)
					{
						alert(holidayArray[i][1]+" is Holiday on the Ocasion of "+holidayArray[i][0]);
						document.getElementById('appointmentdate').value="";
						return false;
					}
				}
			}
			return true;
		}
		
		/*  method for opd module in surgery requisition form for opd patient and In patient    */
		
	function validateSurgeryForAutoComplete( strValue,inc ) {
 			 
 			var index1 = strValue.lastIndexOf("[");
		    var index2 = strValue.lastIndexOf("]");
		    index1++;
		    var id = strValue.substring(index1,index2);
		    //alert("id----"+id)
		    
		    if(id =="")
		    {
		    		document.getElementById('chargeCodeName'+inc).value="";
	   				document.getElementById('chargeCode'+inc).value="";
 					return ;
 			}
 			return true;
		}	

			
		
		
function goToPageOnThisValue(pageno){

	if(pageno!="")
	{
	if( (pageno>totalPages) || (pageno<=0) || (pageno%1!=0) )
	{
		alert("Please Enter Correct Page No.")
		document.paging.pageno.value=""
		return false;
	}
	if(pageno == 1){
		document.paging.firstpage.disabled= true;
		document.paging.prevpage.disabled= true;
		document.paging.firstpage.className="previousDisable"
		document.paging.prevpage.className="singlePrevDisable"		
	
		document.paging.lastpage.disabled= false;
		document.paging.nextpage.disabled= false;
		document.paging.lastpage.className="next"
		document.paging.nextpage.className="singleNext"	
	}
	else if(pageno == totalPages){
		document.paging.firstpage.disabled= false;
		document.paging.prevpage.disabled= false;
		document.paging.firstpage.className="previous"
		document.paging.prevpage.className="singlePrev"		
	
		document.paging.lastpage.disabled= true;
		document.paging.nextpage.disabled= true;
		document.paging.lastpage.className="nextDisable"
		document.paging.nextpage.className="singleNext"		
	}
	else{
		document.paging.firstpage.disabled= false;
		document.paging.prevpage.disabled= false;
		document.paging.firstpage.className="previous"
		document.paging.prevpage.className="singlePrev"		
	
		document.paging.lastpage.disabled= false;
		document.paging.nextpage.disabled= false;
		document.paging.lastpage.className="next"
		document.paging.nextpage.className="singleNext"		
	}
	}
	if(pageno*rowsPerPage<data_arr.length)
		makeTable(pageno*rowsPerPage-rowsPerPage,pageno*rowsPerPage)
	else
		makeTable(pageno*rowsPerPage-rowsPerPage,data_arr.length)
		
		document.getElementById("currStart").innerHTML=(pageno-1)*5+1
		document.getElementById("currEnd").innerHTML=(pageno)*5
		
		document.getElementById("current").innerHTML=pageno
	
	
	document.paging.pageno.value=""	
	
}
/** code by abha for phase 3 **/

function resetCheckForSmq(){
	document.getElementById('addbutton').style.display = 'inline';
	document.getElementById('reset').style.display = 'inline';
	document.getElementById('editbutton').style.display = 'none';
	document.getElementById('deletebutton').style.display = 'none';
	document.getElementById('codeId').readOnly = false;
	document.getElementById('smq').style.display = 'inline';
	document.getElementById('smqStatus').style.display = 'inline';
}
function checkMarriageDate(){
	
	var marriageDateForm=document.getElementById("ameDateId").value;
	
	var marriageDate=new Date(marriageDateForm.substring(6),(marriageDateForm.substring(3,5) - 1) ,marriageDateForm.substring(0,2));
	var currentDate=new Date();
	if((marriageDate>currentDate))
	{
		alert("Marriage Date should not be future date!!");
		return false;
	}
	
	return true;
}
function checkSrMarriageDateForReg(){
	
	var marriageDateForm=document.getElementById("srMarriageDateId").value;
	if(document.getElementById("srMarriageDateId").value!=''){
	var mrDate=new Date(marriageDateForm.substring(6),(marriageDateForm.substring(3,5) - 1) ,marriageDateForm.substring(0,2));
	var currentDate=new Date();
	if((mrDate>currentDate))
	{
		alert("Marriage Date should not be future date!!");
		return false;
	}

	var toDate=new Date();
	var month = toDate.getMonth() + 1
	var day = toDate.getDate()
	var year = toDate.getFullYear()
	var seperator = "/"
	dob = new Date(month + seperator + day + seperator + year);	
	
	var age = document.getElementById('srAgeId').value;
	

	dob.setYear(dob.getFullYear()-parseInt(age)); 
	
	 if(mrDate<dob){
	    	alert("Please enter valid Marriage Date.");
	    	document.getElementById("srMarriageDateId").value='';
	    	return false;
	    }
	}
	/*//var one_day=1000*60*60*24; 
    var marriageDate=marriageDateForm.split("/");
    var date2=new Date(marriageDate[2],(marriageDate[1]-1),marriageDate[0])
 
    diff=date1.getFullYear()-date2.getFullYear();
 
    if(diff>age){
    	alert("Please enter valid Marriage Date.");
    	document.getElementById("srMarriageDateId").value='';
    	return false;
    }
	}*/
    
	return true;
}
function checkAntiSeniorityDate(){
	var seniorityDate=document.getElementById("antiDateId").value;
	var regDate=document.getElementById("regDateId").value;
	var senDate=new Date(seniorityDate.substring(6),(seniorityDate.substring(3,5) - 1) ,seniorityDate.substring(0,2));
	var RegisDate=new Date(regDate.substring(6),(regDate.substring(3,5) - 1) ,regDate.substring(0,2));
	var currentDate=new Date();
	if (senDate>RegisDate)
	{
		alert("Seniority date cant be greater than Registration date!!");
		return false;
	}
	
	return true;
}
	
function RequestForSmqVacationAirmen(obj,formName)
{
	allotment = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'smqVacationAirmen'){
   		url = "/hms/hms/accom?method=showSmqVacationAirmen&allotmentId="+allotment;
    obj1.action = url;
    obj1.submit();
    }else if(formName == 'smqVacationOfficer'){
   		url = "/hms/hms/accom?method=showSmqVacationOfficer&allotmentId="+allotment;
    obj1.action = url;
    obj1.submit();
    }
}
function RequestForRelegationProcess(obj,formName)
{

	vacation = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'relegation'){
   		url = "/hms/hms/accom?method=showRelegationProcessOfficer&vacationId="+vacation;
    obj1.action = url;
    obj1.submit();
 }  
 }
 function RequestForJournalReceipt(obj1,formName)
{
	receipt = obj1.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'journalReceipt'){
   		url = "/hms/hms/lib?method=showEditJournalReceiptEntry&receiptId="+receipt;
    obj1.action = url;
    obj1.submit();
 }  
 }
 
  function RequestForSupplyOrder(obj,formName)
{

	supply = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'supplyOrder'){
   		url = "/hms/hms/lib?method=showEditSupplyOrderEntry&supplyId="+supply;
    obj1.action = url;
    obj1.submit();
 }  
 }
   
   
   function RequestForLibCrv(obj,formName)
{
	  
	crv = obj.id;
	obj1 = eval('document.'+formName)
    var url;
    if(formName == 'crv'){
   		url = "/hms/hms/lib?method=showEditLibCrv&crvId="+crv;
    obj1.action = url;
    obj1.submit();
 }  else if(formName=='searchDefectiveDrug'){
	 url = "/hms/hms/stores?method=modifyDefectiveDrug&entryId="+crv;
	    obj1.action = url;
	    obj1.submit();
	    
 }  else if(formName=='searchDefectiveDrug1'){
	 
	 url = "/hms/hms/stores?method=modifySampleTestEntry&entryId="+crv;
	    obj1.action = url;
	    obj1.submit();
 }else if(formName == 'poDetails'){
	   //url = "/hms/hms/purchaseOrder?method=poModifyJsp&poDetailId="+crv;
	  //	obj1 .action = url;
		//obj1 .submit();
 }else if(formName == 'searchBalance'){
	 url = "/hms/hms/stores?method=modifyBalance&balanceId="+crv;
	  	obj1 .action = url;
		obj1 .submit();
 }
 }
 function RequestForCancel(obj,formName)
{
	allotment = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'cancel'){
   		url = "/hms/hms/accom?method=showCancelForAirmen&allotmentId="+allotment;
    obj1.action = url;
    obj1.submit();
 }  
 }
  function RequestForCancelOfficer(obj,formName)
{
	allotment = obj.id;
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'cancelOfficer'){
   		url = "/hms/hms/accom?method=showCancelForOfficer&allotmentId="+allotment;
    obj1.action = url;
    obj1.submit();
 }  
 }
 function RequestForLeave(obj,formName)
{
	employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leave'){
   		url = "/hms/hms/hrOrderly?method=showLeaveApplicationJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }  
 }
/** end of code by Abha **/
function checkSearchForAgendaPoints(){

	if(document.getElementById('searchField1').value == '' && document.getElementById('searchField2').value == '' && document.getElementById('searchField3').value == ''){
		alert("Please enter a search criteria");

		return false;
	}else
		return true;
}

function checkSearchForDate(){
   
    var strValue = document.getElementById("searchField1").value;
    var strTodate = document.getElementById("searchField2").value;
    fromDate= new Date(strValue.substring(6),(strValue.substring(3,5) - 1) ,strValue.substring(0,2)); 	
 	
 	if(strTodate==""){
 	
 	toDate = new Date();
 	var month = toDate.getMonth() + 1
	var day = toDate.getDate()
	var year = toDate.getFullYear()
	var seperator = "/"
	toDate = new Date(month + seperator + day + seperator + year);	
	
 	}else 	
 	toDate=new Date(strTodate.substring(6),(strTodate.substring(3,5) - 1) ,strTodate.substring(0,2));
	
	
	
	if(fromDate > toDate)
 	{
 		alert("From date can not be greater then To date");
		return false;
 	}
 	else if(fromDate == toDate)
	 return true;
	else 
	 return true;
}

function checkSearchForWorkService()
{

var searchField1=document.getElementById('searchField1').value;
var searchField2=document.getElementById('searchField2').value;
var searchField3=document.getElementById('searchField3').value;
var searchField4=document.getElementById('searchField4').value;
var searchField5=document.getElementById('searchField5').value;
var searchField6=document.getElementById('searchField6').value;
var searchField7=document.getElementById('searchField7').value;

	if( searchField1 ==0 && searchField2 ==0 && searchField3 ==0 && searchField4 ==0 && searchField5 ==0 && searchField6 ==0 && searchField7 ==0){
		alert("Please enter a search criteria");
		return false;
	}else
		return true;
}

function checkSearchForSingleWorkService()
{

var searchField1=document.getElementById('searchField1').value;

	if( searchField1 ==0){
		alert("Please enter a search criteria");
		return false;
	}else
		return true;
}

function validateDutyStartDate()
{
	
	if(document.getElementById("fromDate").value!="")
	{
		var dutyStart=document.getElementById("fromDate").value;
		var dutyEnd=document.getElementById("toDate").value;
		dutyStartDate=new Date(dutyStart.substring(6),(dutyStart.substring(3,5) - 1) ,dutyStart.substring(0,2));
		dutyEndDate=new Date(dutyEnd.substring(6),(dutyEnd.substring(3,5) - 1) ,dutyEnd.substring(0,2));
		if(dutyStartDate>dutyEndDate)
		{
			alert("Duty Start Date should be less than Duty End Date");
			document.getElementById("toDate").value="";
			return false;
		}
	}
	else
	{
		alert("First fill Duty Start Date");
		document.getElementById("toDate").value="";
		return false;
	}
	return true;
}

 function generateRowMedicalBoard(idName) {    
	   document.getElementById("noOfRecords").value = parseInt(document.getElementById("noOfRecords").value)+1	
		var d=document.getElementById(idName).getElementsByTagName("tr");
		lastTr = d[d.length-1]		
		clone = lastTr.cloneNode(true);
		clone.id = parseInt(lastTr.id);
		lastTr.parentNode.insertBefore(clone,lastTr.nextSibling)
		var tblCtrl = d[d.length-1].getElementsByTagName("input"); 
		tblCtrl[0].value=d.length-1;
		var temp=d.length-1
				for(var i=1;i<tblCtrl.length;i++)
			tblCtrl[i].value="";			
		}
		
		function removeRowMedicalBoard(argIndex,idName){
		//alert("remove row called"+ argIndex +""+idName)
	  document.getElementById("noOfRecords").value = parseInt(document.getElementById("noOfRecords").value)-1	
	         var table=document.getElementById(idName);
	         var tblRows  = table.getElementsByTagName("tr");
	         var check=0;
	         
	         for(i=tblRows.length-1;i>0;i--)
	        {         
	         var tblCtrl =  tblRows[i].getElementsByTagName("input"); 
	         
	         
	               for(j=0;j<tblCtrl.length;j++)
	               {
	                  if(tblCtrl[j].type == 'checkbox')
	                   {    
	                    if(tblCtrl [j].checked)
	                              check=check+1;
	                   }
	               }
	        }
	         if(tblRows.length-1==check){
	         	alert("Can not delete all rows")
	         	return false;
	         }
			
	        for(i=tblRows.length-1;i>0;i--)
	        {         
	         var tblCtrl =  tblRows[i].getElementsByTagName("input"); 
	         
	               for(j=0;j<tblCtrl.length;j++)
	               {
	                  if(tblCtrl[j].type == 'checkbox')
	                   {    
	                    if(tblCtrl [j].checked)
	                              document.getElementById(idName).deleteRow(i);
	                   }
	               }
	        }
     }
//--------------------------By Bhavya----------------------
function RequestForLeaveEntry(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leave'){
         url = "/hms/hms/hrOrderly?method=showLeaveApplicationJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForPostedOut(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'postedOut'){
         url = "/hms/hms/hrOrderly?method=showPostedOutJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
 function RequestForSearchPostedOut(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'searchPostedOut'){
         url = "/hms/hms/hrOrderly?method=showPostedOutJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
 
  function RequestForSearchProposal(obj,formName)
{
   proposal = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'updateProposalHRO'){
         url = "/hms/hms/hrOrderly?method=showUpdateProposalJsp&proposalId="+proposal;
    obj.action = url;
    obj.submit();
 }
 }
 
 function RequestForSearchHro(obj,formName)
{
   hro = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'updateHROEntry'){
         url = "/hms/hms/hrOrderly?method=showUpdateHroEntryJsp&hroId="+hro;
    obj.action = url;
    obj.submit();
 }
 }

 function RequestForUpdatePosted(obj,formName)
{
   posted = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'updatePostedOut'){
         url = "/hms/hms/hrOrderly?method=showUpdatePostedOutJsp&postedId="+posted;
    obj.action = url;
    obj.submit();
 }
 }

 
 function RequestForMovementOut(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'movementOut'){
         url = "/hms/hms/hrOrderly?method=showMovementOutJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }
 }
 
 function RequestForMovementIn(obj,formName)
{
   employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'movementIn'){
         url = "/hms/hms/hrOrderly?method=showMovementInJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }
 }



function RequestForLeaveRestriction(obj,formName)
{
 leaveRestrictionId = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leaveRestriction'){
     url = "/hms/hms/hrOrderly?method=showLeaveRestrictionUpdateJsp&leaveRestrictionId="+leaveRestrictionId;
    obj.action = url;
    obj.submit();
 }
 }

/*function RequestForLeaveApplication(obj,formName)
{
 employee = obj.id;
    obj = eval('document.'+formName)
    var url;
    if(formName == 'leaveApplicationUpdate'){
     url = "/hms/hms/hrOrderly?method=showLeaveApplicationUpdateJsp&employeeId="+employee;
    obj.action = url;
    obj.submit();
 }  
 }*/
function compareDateForMedicalBoard(){
   
   var fromDateForm=document.getElementById("entryDate").value;
   var toDateForm=document.getElementById("dateOfAddmission").value;
   var fromDate=new Date(fromDateForm.substring(6),(fromDateForm.substring(3,5) - 1) ,fromDateForm.substring(0,2));
   var toDate=new Date(toDateForm.substring(6),(toDateForm.substring(3,5) - 1) ,toDateForm.substring(0,2));
   var currentDate=new Date();
   if((fromDate>currentDate)|| (fromDate<toDate))
   {
      alert("Entry Date should be greater than Adminssion Date!!");
      return false;
   }  
   return true;
}

function checkSearchForMedicalBoard(){
var i =0;
   if(!document.getElementById('searchField1').value == '')
   i++;
   if(document.getElementById('searchField2').value != '0')
   {   
   i++;
   }
   if(!document.getElementById('searchField3').value == '')
   i++;
   if(!document.getElementById('searchField4').value == '')
    i++;
   if(!document.getElementById('searchField5').value == '')
    i++;  
   if(i<=1)
   {
   alert("Please select at least two search criteria")
      return false;
   }else
    return true;
     
}
function maxLimit()
{
var maxLimit = document.getElementById('maxLimitValue').value
var currentLimitSelected = document.getElementById('maxLimit').value
if(currentLimitSelected > maxLimit)
{
alert("Max limit can not be greater than "+ maxLimit);
return false;
}
else
return true;
}

function compareDateForMajorWork(fromDateForm1,toDateForm1,currentValue1,checkDependentDate,displayMessage){  
   var fromDateForm = fromDateForm1.value;
   var toDateForm = toDateForm1.value;
   var isDateEntered = checkDependentDate.value;
   var fromDate=new Date(fromDateForm.substring(6),(fromDateForm.substring(3,5) - 1) ,fromDateForm.substring(0,2));
   var toDate=new Date(toDateForm.substring(6),(toDateForm.substring(3,5) - 1) ,toDateForm.substring(0,2));
   var currentDate=new Date();
   if((fromDate > toDate) && toDateForm!="" )
   {
      alert("Date should be greater than Major Work Date !!");   
      toDateForm1.value= currentValue1.value;     
      return false;
   }  
   else if(isDateEntered =="" && toDateForm!=""){
   alert("Please Enter "+displayMessage+" Date First");  
    toDateForm1.value= "";    
   return false;
   }else
   {   
   return true;
   }
}

function submitForMedicalBoard(formName)
{
   
    obj1 = eval('document.'+formName)
    var url;
    if(formName == 'medicalBoardProceeding')
         url = "/hms/hms/medicalboardSearch?method=showMedicalBoardSearchJsp";
    if(formName == 'instructionToCandidate')
         url = "/hms/hms/instructionToCandidateSearch?method=showInstructionToCandidateSearchJsp";
    if(formName == 'certificateByTheCandidate')
         url = "/hms/hms/certificateByTheCandidateSearch?method=showCertificateByTheCandidateSearchJsp";
    if(formName == 'resultOfAppealMedicalboard')
         url = "/hms/hms/resultOfAppealMedicalboardSearch?method=showResultOfAppealMedicalboardSearchJsp";
    if(formName == 'medicalBoardExaminationReport')
         url = "/hms/hms/medicalExaminationBoard?method=showMedicalExaminationBoardsSearchJsp";
    
    
    obj1.action = url;
    obj1.submit();
}
function checkValidTime(timeStr,fieldId) {
	// Checks if time is in HH:MM:SS format.
	// The seconds are optional.
	
	var obj = document.getElementById(fieldId)
	//alert(obj.value)
	var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;
	
	var matchArray = timeStr.match(timePat);
	if (obj.value!="" && matchArray == null) {
		alert("Time should be in HH:MM format!!.");
		obj.value = "";
		obj.focus();
		return false;
	}
	
	hour = matchArray[1];
	minute = matchArray[2];
	second = matchArray[4];
	ampm = matchArray[6];
	
	if (second=="") { second = null; }
	if (ampm=="") { ampm = null }
	
	if (hour < 0  || hour > 23) {
		alert("Hour must be between 0 and 23.");
		obj.value = "";
		obj.focus();
		return false;
	}
	if (minute<0 || minute > 59) {
		alert ("Minute must be between 0 and 59.");
		obj.value = "";
		obj.focus();
		return false;
	}
	
	return false;
}


/** end of code by abha **/






function Pager(tableName, itemsPerPage) {

 this.tableName = tableName;
this.itemsPerPage = itemsPerPage;
this.currentPage = 1;
this.pages = 0;
this.inited = false;

this.showRecords = function(from, to) {
    var rows = document.getElementById(tableName).rows;
    // i starts from 1 to skip table header row
    for (var i = 0; i < rows.length; i++) {
        if (i < from || i > to)
            rows[i].style.display = 'none';
        else
            rows[i].style.display = '';
    }
}

this.showPage = function(pageNumber) {
	if (! this.inited) {
		alert("not inited");
		return;
	}
if(document.getElementById('pageEditNo'))
		document.getElementById('pageEditNo').value = pageNumber;

    var oldPageAnchor = document.getElementById('pg'+this.currentPage);
    oldPageAnchor.className = 'pg-normal';

    this.currentPage = pageNumber;
    var newPageAnchor = document.getElementById('pg'+this.currentPage);
    newPageAnchor.className = 'pg-selected';

    var from = (pageNumber - 1) * itemsPerPage;

    var to = from + itemsPerPage - 1;

    this.showRecords(from, to);
}

this.prev = function() {
    if (this.currentPage > 1)
        this.showPage(this.currentPage - 1);
}

this.next = function() {
    if (this.currentPage < this.pages) {
        this.showPage(this.currentPage + 1);
    }
}

this.init = function() {
    var rows = document.getElementById(tableName).rows;
    var records = (rows.length);
    this.pages = Math.ceil(records / itemsPerPage);
    this.inited = true;
}

this.showPageNav = function(pagerName, positionId) {
	if (! this.inited) {
		alert("not inited");
		return;
	}
	var element = document.getElementById(positionId);
	var pagerHtml=""
	pagerHtml = '<span onclick="' + pagerName + '.prev();" class="previous">Prev</span> | ';

    for (var page = 1; page <= this.pages; page++)
        pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> | ';
    pagerHtml += '<span onclick="'+pagerName+'.next();" class="next">Next</span>';

    element.innerHTML = pagerHtml;
}


}


/*
 * Code By Mukesh
 * 19 Jun 2012
 */
function disableLoginDetails(templateCounter1){
	
	document.getElementById('loginRequired').disabled=true;
	document.getElementById('loginName').disabled=true;
	document.getElementById('password').disabled=true;
	//document.getElementById('appGroupId').disabled=true;
	//document.getElementById('empGroupId').disabled=true;
	document.getElementById('userDepartmentId').disabled=true;
	//var templateCounter=0;
	//templateCounter=document.getElementById('templateCounter').value;
	if(parseInt(templateCounter1) > 0){
		for(var i=1;i<=templateCounter1;i++){
			document.getElementById('templetId'+i).disabled=true;
		}
	}
} 
/*
 * Code By Mukesh
 * 19 Oct 2012
 */
function disableTemplateDetails(employeeId){
	
	submitProtoAjax('employee','/hms/hms/personnel?method=showEmployeeTemplate&empId='+employeeId);
} 
/*
 * Code By Mukesh
 * 10 Aug 2012
 */

function validateAlphaNumericForPvms( strValue ) {

	//var objRegExp  = /[^a-z*(\d)]/i;
	//Change by tarun
	var objRegExp=/(\s{2,})|([\\\.\(\)\_\:\@\$\*\"\&\-\'\`\#\ï¿½\ï¿½\?\n\r])/i
	
	//Change by tarun to allow ".","-",","
	//var objRegExp=/(\s{2,})|([\\\/\(\)\_\:\@\$\*\"\&\`\#\ï¿½\ï¿½\?\n\r])/i
	
	return !objRegExp.test(strValue);
	
}

function disableSMCLoginDetails(){
	
	document.getElementById('empDiv').style.display="none";
	document.getElementById('serviceNo').disabled=true;
	document.getElementById('serviceNo').value="";
	document.getElementById('rankId').disabled=true;
	document.getElementById('rankId').value=0;
	document.getElementById('titleId').disabled=true;
	document.getElementById('titleId').value=0;
	document.getElementById('unitId').disabled=true;
	document.getElementById('unitId').value=0;
	document.getElementById('firstName').disabled=true;
	document.getElementById('middleName').disabled=true;
	document.getElementById('lastName').disabled=true;
	document.getElementById('firstName').value="";
	document.getElementById('middleName').value="";
	document.getElementById('lastName').value="";
	
	document.getElementById('employeeCategoryId').disabled=true;
	document.getElementById('employeeCategoryId').value=0;
	document.getElementById('departmentId').disabled=true;
	document.getElementById('departmentId').value=0;
	document.getElementById('TradeId').disabled=true;
	document.getElementById('TradeId').value=0;
	
	document.getElementById('offPhone').disabled=true;
	document.getElementById('offPhone').value="";
	
	document.getElementById('loginName').disabled=true;
	document.getElementById('password').disabled=true;
	document.getElementById('loginName').value="";
	document.getElementById('password').value="";
}

function checkBlankSearch(formName){
	var inputs = eval('document.'+formName+'.elements');
	var flag ='';
	for(i=0;i<inputs.length;i++){
		if(inputs[i].value!='' && inputs[i].value!='0' ){
			flag = 'true';
			break;
		}
	}
	if(flag=='true'){
		return true;
	}else{
		alert("Please enter value to search.")
		return false;
	}

}

function displayAdminDetails(hospitalId){
	submitProtoAjaxWithDivName('hospital','/hms/hms/user?method=getAdminDetailsForHospital&hospitalId='+hospitalId,'empDiv');
}
function RequestForOpBillService(orderId,formName)
{
    obj1 = eval('document.'+formName)
    var url;
   		url = "/hms/hms/billing?method=getPatientDetailsForOpBilling&registered=yes&orderId="+orderId;;
   	obj1.action = url;
    obj1.submit();
}

function RequestForOtherPatientBillService(hinNo,formName)
{
    obj1 = eval('document.'+formName)
    var url;
   		url = "/hms/hms/billing?method=getOtherPatientDetailsForBilling&registered=yes&hinNo="+hinNo;;
   	obj1.action = url;
    obj1.submit();
}

function displayDepartments(idVal,dividID){
		submitProtoAjaxWithDivName('employee','personnel?method=getDepartmentForDisplay&employeeId='+idVal+'&divisionName='+dividID,'departmentDiv');
}

function contract(statusVal)
{
	
	if(statusVal=='Contract'){
		document.getElementById('contractDiv').style.display='inline';
	}else{
		document.getElementById('contractDiv').style.display='none';
	}
	
	if(statusVal=='Extension'){
		document.getElementById('extensionDiv').style.display='inline';
	}else{
		document.getElementById('extensionDiv').style.display='none';
	}
	
}


function testing(idVal)
{			
	 var pathh="/hms/hms/personnel?method=displayImage&employeeId="+idVal;
	 	//pathh = pathh+'&'+csrfTokenName+'='+csrfTokenValue; // added by amit das on 07-07-2016
	 document.getElementById("imageIDD").style.display='block';
	 document.getElementById("imageIDD").src = pathh;

		 /*new Ajax.Request('registration?method=displayImage&patientHinNo='+hinNo, {});*/
}
function testingImg(idVal)
{			
	
	 var pathh="/hms/hms/personnel?method=displayImageEmployeeDependent&employeeDependentId="+idVal;
	 	//pathh = pathh+'&'+csrfTokenName+'='+csrfTokenValue; // added by amit das on 07-07-2016
	 document.getElementById("imageIDD").style.display='block';
	 document.getElementById("imageIDD").src = pathh;

		 /*new Ajax.Request('registration?method=displayImage&patientHinNo='+hinNo, {});*/
}
function displayAuthoriz(wardId,authoriz){
	if(wardId=='Doctor'){
		document.getElementById('doctorDiv').style.display='block';
		if(authoriz=='y')
			document.getElementById('authoriz').checked=true;
		else
			document.getElementById('authoriz').checked=false;
	}else{
		document.getElementById('doctorDiv').style.display='none';
		document.getElementById('authoriz').checked=false;
	}
}


function ssdisplayDepartmentNo(deptNo){
	if(deptNo!=""){
	document.getElementById('deptNo').readOnly=true;
	}	
	
}


function startEndDateValidation(){
	var day1, day2;
	var month1, month2;
	var year1, year2;
	var starDate = document.getElementById('fromDate').value;
	var endDate = document.getElementById('toDate').value;
	
	var sDate= document.getElementById('Label1').innerText.replace(/\*/g, ' ');
	var lDate= document.getElementById('Label2').innerText.replace(/\*/g, ' '); 
	
	
	day1 = starDate.substring (0, starDate.indexOf ("/"));
	month1 = starDate.substring (starDate.indexOf ("/")+1, starDate.lastIndexOf ("/"));
	year1 = starDate.substring (starDate.lastIndexOf ("/")+1, starDate.length);

	day2 = endDate.substring (0, endDate.indexOf ("/"));
	month2 = endDate.substring (endDate.indexOf ("/")+1, endDate.lastIndexOf ("/"));
	year2 = endDate.substring (endDate.lastIndexOf ("/")+1, endDate.length); 


	var chDate1 = new Date(year1, month1, day1); 
	var chDate2 = new Date(year2, month2, day2); 


	if(endDate){
	if(chDate2.getTime() < chDate1.getTime()) { 
	alert(lDate+"cannot less than"+sDate);
	document.getElementById('toDate').value="";
	return false; 
			}
		}
	}


function refreshLengthWithoutMeter(id,maxLen)
{
		var len = document.getElementById(id).value.length;
  	if(len>maxLen)
		{
			document.getElementById(id).value = txt;
  	}
		
		len = document.getElementById(id).value.length;
	
	
}


function refreshLengthWithoutMeter1(id,maxLen)
{
		var len = document.getElementById(id).value.length;
  	if(len<=maxLen)
		{
		txt=document.getElementById(id).value;
	}
  	refreshLengthWithoutMeter(id,maxLen);
	
}

function openPopUp(url)
{
		/*url = url+'&'+tokenName+'='+tokenValue;*/
		var actionUrl = url;
		var formName = 'popUpForm';
		var formObj = document.getElementById(formName);
		formObj.action = actionUrl;
		window.open('', 'mywindow','menubar=no,location=no,resizable=no,scrollbars=no,status=no,width=1020,height=500,top=100,left=150');
		document.getElementById('popUpForm').submit();
		
}