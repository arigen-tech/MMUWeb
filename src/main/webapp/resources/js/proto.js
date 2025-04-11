document.write("<script type='text/javascript' src='resources/js/prototype.js'></script>");
document.write("<script type='text/javascript' src='resources/js/divideprototype.js'></script>");


function submitRadioAjax(formName,action,temp){

		errorMsg = "";
			
		obj = eval('document.'+formName)
				
		       obj.action = action;
		       
	    	   	 var url=action+"&radioForPvms="+temp
	        
	        	new Ajax.Updater('testDiv',url,
				   {asynchronous:true, evalScripts:true }); 
				
			
		       	return true;
	    	}


	function submitProtoAjax(formName,action){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	new Ajax.Updater('testDiv',url,
				   {asynchronous:true, evalScripts:true }); 
				return true;
	    	}
			
	function submitProtoAjax1(formName,action){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		//alert(action);
		
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action;
	        	new Ajax.Updater('testDiv',url,
				   {asynchronous:true, evalScripts:true }); 
				return true;
	    	}
	
	 function submitProtoAjaxNew(formName,action,divName){

			errorMsg = "";
			ob1 = true;
			ob2 = true;
			ob3 = true;
			obj = eval('document.'+formName)
			action = action;
		    	         	
			obj.action = action;
					
		        	new Ajax.Updater(divName,action,
					   {asynchronous:true, evalScripts:true });

			       	return true;
		    	}
	function submitProtoAjaxdiv(formName,action){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	new Ajax.Updater('testDivR',url,{asynchronous:true, evalScripts:true }); 
				return true;
	    	} 	
	
	function submitProtoAjaxdiv2(formName,action){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	new Ajax.Updater('testDivR2',url,{asynchronous:true, evalScripts:true }); 
				return true;
	    	} 	
	
/*	function submitProtoAjaxStock(formName,action){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	new Ajax.Updater('testDivR',url,{asynchronous:true, evalScripts:true }); 
				return true;
	    	} */
	    	
/*	function submitProtoAjaxforGrid(formName,action){
	alert('submitProtoAjaxforGrid')
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	
	        	new Ajax.Updater('gridDiv',url,
				   {asynchronous:true, evalScripts:true }); 
		       	return true;
	    	}
*/	    		    	
	// submitProtoAjaxWithDivName added By Priyanka on 2 April 08
	function submitProtoAjaxWithDivName(formName,action,divName){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		//alert('::formName::-'+formName+'\n::action::-'+action+'\n::divName::-'+divName);
		obj = eval('document.'+formName)
		       	obj.action = action;
				obj.method = "POST";
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	if(divName == "defaultList"){
	        	document.getElementById('defaultList').style.display = 'inline';
	        	}
	        	new Ajax.Updater(divName,url,
				   {asynchronous:true, evalScripts:true,method: 'POST' }); 
				
			
		       	return true;
	    }
	function submitProtoAjaxWithDivNameWithoutFormData(formName,action,divName){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		//alert('::formName::-'+formName+'\n::action::-'+action+'\n::divName::-'+divName);
		obj = eval('document.'+formName)
		       	obj.action = action;
				obj.method = "POST";
	    	   	 var url=action
	        	if(divName == "defaultList"){
	        	document.getElementById('defaultList').style.display = 'inline';
	        	}
	        	new Ajax.Updater(divName,url,
				   {asynchronous:true, evalScripts:true,method: 'POST' }); 
				
			
		       	return true;
	    }
	function submitProtoAjaxWithDivNameToShowStatus(formName,action,divName){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)

		       	obj.action = action;
	    	   	var url=action+"&"+getNameAndData(formName)
	            
	            var oOptions = {
	                asynchronous:true, evalScripts:true,
	                onFailure: function () {
	                    alert("An error occurred: " );
	                },
	                onLoaded : function () {
	                   document.getElementById(divName).innerHTML='<font id="error">Loading...</font>'
	                },
	                onInteractive :function () {
	                   document.getElementById(divName).innerHTML='<font id="error">Loading...</font>'
	                }
	               // onLoading : function () {
	               //    document.getElementById(divName).innerHTML='<font id="error">Loading...</font>'
	               // }
	                
	            };
				
				var oRequest = new Ajax.Updater(divName, url,oOptions);
			
		       	return true;
	    }
	    
	    	// submitProtoAjaxWithDivName added By Priyanka on 2 April 08
	function submitProtoAjaxWithDivEmpName(formName,action){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	new Ajax.Updater(url,
				   {asynchronous:true, evalScripts:true }); 
				
			
		       	return true;
	    }
	 function submitProtoAjaxForEDReturns(formName,action,divName){
	 
	 		var fromDateForm=document.getElementById("fromDateId").value;
		var toDateForm=document.getElementById("toDateId").value;
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
		else{
	 
	 	var fromDate=document.getElementById("fromDateId").value;
	 	var toDate=document.getElementById("toDateId").value;
	 	var category=document.getElementById("categoryId").value;
	 	
	 	
	 	errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&fromDate="+fromDate+"&toDate="+toDate+"&category="+category
	        	 new Ajax.Updater(divName,url,{asynchronous:true, evalScripts:true });
	     } 
		       	return true;
	   }
function checkDateForIssueCiv(){
		var demandDate=document.getElementById("requestDate").value;
		var issueDate=document.getElementById("issueDate").value;
		var fromDate=new Date(demandDate.substring(6),(demandDate.substring(3,5) - 1) ,demandDate.substring(0,2));
		
		
		var toDate=new Date(issueDate.substring(6),(issueDate.substring(3,5) - 1) ,issueDate.substring(0,2));
		
		var currentDate=new Date();
		if((fromDate>currentDate) )
		{
			alert("Demand Date cant be greater than current date!!");
			return false;
		}
		if(fromDate>toDate){
		alert("Demand Date cant be greater than date of issue!!");
			return false;
		}
		if((toDate>currentDate))
		{
			alert("Issue Date cant be greater than current date !!");
			return false;
		}
		if(toDate<fromDate){
		alert("Issue Date cant be less than demand date !!");
			return false;
		}
	 
	 	
		       	return true;
	}
	function submitPeriodical(formName,action,extraFunction,extraFunction2,extraFunction3){

		errorMsg = "";
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
	        	obj.action = action;
	        	 var url=action+"&"+getNameAndData(formName)
	        	
	        	    	alert(url)
	        	    new Ajax.PeriodicalUpdater('statusMessage',url,
					  {
					    method: 'get',
					    insertion: Insertion.Top,
					    asynchronous:true,
					    evalScripts:true,
					    frequency: 1,
					    decay: 1
					  });
	        
									
			}else{
				if(errorMsg != ""){
					alert(errorMsg);
		       		return false;	
		       	}
		       	return true;
	    	}
	}
function getNameAndData(formName) {
   var str="";
   inputs = eval('document.'+formName+'.elements');
   for(i=0;i<inputs.length;i++){
   	str=str+inputs[i].name+"="+inputs[i].value+"&"
   }
   return str;
}


function calculateAge(){
		dob=document.getElementById('dobId').value;
		if(checkDob('dobId')){
		action="/hms/hms/registration?method=calculateAge";	
		obj = eval('document.registration')
				
		       obj.action = action;
	    	   	 var url=action+"&dateOfBirth="+dob
	        
	        	new Ajax.Updater('ageDiv',url,
				   {asynchronous:true, evalScripts:true }); 
     			   	return true;
		       	}
}

function checkDob(fieldId){
	var dob = document.getElementById(fieldId).value;
	dateOfBirth = new Date(dob.substring(6),(dob.substring(3,5) - 1) ,dob.substring(0,2));
 	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);
	
	if(dateOfBirth > currentDate)
 	{
 		alert("Date of Birth is not valid.");
 		document.getElementById(fieldId).value = "";
 		if(fieldId=='dobId'){
 			document.getElementById('idForAge').value = "";
 			document.getElementById('idForAge').style.display = 'none';
 		}
		//document.getElementById('tempId1').style.display = 'block';
	//	document.getElementById('tempId2').style.display = 'block';
		return false;
 	}
	 return true;
	
}
function getHinNo(formName,action){
	var serviceNoObj = eval('document.'+formName+'.serviceNo')
	var servNo = serviceNoObj.value;
		errorMsg ="";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		if(servNo != ""){
			obj = eval('document.'+formName)
			       	obj.action = action;
		    	   	 var url=action+"&"+getNameAndData(formName)
		        	
		        	new Ajax.Updater('hinDiv',url,
					   {asynchronous:true, evalScripts:true }); 
		}	
		return true;
}

function checkPatientRegistration(){
	var serviceType = document.getElementById('serviceTypeId').value;
	if(serviceType != "8"){
		
		var serviceNo = document.getElementById('serviceNoId').value;
		var relation = document.getElementById('relationId').value;
		//var serviceStatus = document.getElementById('serviceStatusId').value;
		//var pName = document.getElementById('pFirstNameId').value;
		var pName = document.getElementById('sFNameId').value;
		if(relation == '8'){
			/*	document.getElementById('reportinForId').disabled=false;
			document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,yes');
		*/}
		else{
			if(document.getElementById('selfHinNo'))
				document.getElementById('selfHinNo').value="";
		//	document.getElementById('reportinForId').disabled=true;
		//	document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,no');
		//	document.getElementById('pFirstNameId').value = "";
		//	document.getElementById('pMiddleNameId').value = "";
		//	document.getElementById('pLastNameId').value = "";
		//	document.getElementById('gender').value = "0";
			
		}
		action="/hms/hms/registration?method=checkPatientRegistration";	
		obj = eval('document.registration')
				
		       obj.action = action;
	    	   	 //var url=action+"&serviceNo="+serviceNo+"&serviceTypeId="+serviceType+"&relationId="+relation+"&serviceStatus="+serviceStatus+"&patientName="+pName;
	   	 var url=action+"&serviceNo="+serviceNo+"&serviceTypeId="+serviceType+"&relationId="+relation+"&patientName="+pName;
	        	new Ajax.Updater('statusMessage',url,
				   {asynchronous:true, evalScripts:true }); 
				   return true;
			}
	
			return true;
}

function checkPatientRegistrationHAL(){
	
	if(true){
		
		var serviceNo = document.getElementById('serviceNoId').value;
		var relation = document.getElementById('relationId').value;
		//var serviceStatus = document.getElementById('serviceStatusId').value;
		//var pName = document.getElementById('pFirstNameId').value;
		var pName = document.getElementById('sFNameId').value;
	
		
		/*	if(document.getElementById('selfHinNo'))
				document.getElementById('selfHinNo').value="";*/
		//	document.getElementById('reportinForId').disabled=true;
		//	document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,no');
		//	document.getElementById('pFirstNameId').value = "";
		//	document.getElementById('pMiddleNameId').value = "";
		//	document.getElementById('pLastNameId').value = "";
		//	document.getElementById('gender').value = "0";
			
	
		action="/hms/hms/registration?method=checkPatientRegistrationHAL";	
		obj = eval('document.visitEmployee')
				
		       obj.action = action;
	    	   	 //var url=action+"&serviceNo="+serviceNo+"&serviceTypeId="+serviceType+"&relationId="+relation+"&serviceStatus="+serviceStatus+"&patientName="+pName;
	   	 var url=action+"&serviceNo="+serviceNo+"&relationId="+relation+"&patientName="+pName;
	        	new Ajax.Updater('statusMessage',url,
				   {asynchronous:true, evalScripts:true }); 
				   return true;
			}
	
			return true;
}

function getDiagnosisForReport(formName,action){
	
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	new Ajax.Updater('diagnosisDiv',url,{asynchronous:true, evalScripts:true }); 
		       	return true;
}


function show111(){

	alert("www")
}

function submitProtoAjaxDynamic(formName,action,divName){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		obj.action = action;
	    var url=action+"&"+getNameAndData(formName)
       	new Ajax.Updater(divName,url,{asynchronous:true, evalScripts:true }); 
       	return true;
	    	}
	
//================Ajax multiple ids updating=================

  
  function ajaxFunctionForAutoCompleteIndentToDepotSt(formName,action,rowVal) {
  
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];

	        var oldPvms  = item.getElementsByTagName("oldPvms")[0];
	        var stock  = item.getElementsByTagName("stock")[0];
	        var qtyInMMF  = item.getElementsByTagName("qtyInMMF")[0];
	        var section  = item.getElementsByTagName("section")[0];
	        var demandVar=item.getElementsByTagName("demandVar")[0];

        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	//if(oldPvms.childNodes[0].nodeValue != 0)
        	//document.getElementById('oldNiv'+rowVal).value = oldPvms.childNodes[0].nodeValue
        	if(document.getElementById('qtyInHand'+rowVal))
        		document.getElementById('qtyInHand'+rowVal).value = stock.childNodes[0].nodeValue
        	//document.getElementById('qtyInHandTemp'+rowVal).value = stock.childNodes[0].nodeValue

        	if(document.getElementById('mmfVarTemp'+rowVal))
        		document.getElementById('mmfVarTemp'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
        	if(document.getElementById('mmfVar'+rowVal))
        		document.getElementById('mmfVar'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
        	if(document.getElementById('section'+rowVal))
        		document.getElementById('section'+rowVal).value = section.childNodes[0].nodeValue
        	if(document.getElementById('demandVar'+rowVal))
        		document.getElementById('demandVar'+rowVal).value = demandVar.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  // Add by Sanjay Yadav
  function ajaxFunctionForAutoCompleteIndentToDepot1(formName,action,rowVal)
  {
	  
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	//var batchs = xmlHttp.responseXML.getElementByTagName('batchs')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var id  = item.getElementsByTagName("id")[0];
		        var pvms  = item.getElementsByTagName("pvms")[0];
		        var au  = item.getElementsByTagName("au")[0];
		        var name  = item.getElementsByTagName("name")[0];

		        var oldPvms  = item.getElementsByTagName("oldPvms")[0];
		       
		        var stock  = item.getElementsByTagName("stock")[0];
		        //var qtyInMMF  = item.getElementsByTagName("qtyInMMF")[0];
		       // var section  = item.getElementsByTagName("section")[0];
		        //var demandVar=item.getElementsByTagName("demandVar")[0];

	        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
	        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
	        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
	        	document.getElementById("stockAvailable"+rowVal).value=stock.childNodes[0].nodeValue;
	            //document.getElementById('qtyInHand'+rowVal).value = stock.childNodes[0].nodeValue
	        	//if(oldPvms.childNodes[0].nodeValue != 0)
	        	//document.getElementById('oldNiv'+rowVal).value = oldPvms.childNodes[0].nodeValue
	        	
	        	
	        	//document.getElementById('qtyInHandTemp'+rowVal).value = stock.childNodes[0].nodeValue

	        	//document.getElementById('mmfVarTemp'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
	        	//document.getElementById('mmfVar'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
	        	//document.getElementById('section'+rowVal).value = section.childNodes[0].nodeValue
	    
	        	//document.getElementById('demandVar'+rowVal).value = demandVar.childNodes[0].nodeValue
		      
	      	} 
	      }
	    }
	    var url=action+"&"+getNameAndData(formName)
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	    
	    
	  }
  
  function ajaxFunctionForAutoCompleteMMF(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	       
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('issuedName'+rowVal).value = name.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
        
  }
  //================Ajax multiple ids updating=================
function ajaxFunctionForAutoCompleteInSOC(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	var brandId="brandId"+rowVal;
		obj =document.getElementById(brandId); 
		obj.length = 1;
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	         var stockIn  = item.getElementsByTagName("stockIn")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('qtyInHand'+rowVal).value = stockIn.childNodes[0].nodeValue
        	document.getElementById('qtyInHandTemp'+rowVal).value = stockIn.childNodes[0].nodeValue
        	
        	for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++){
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=brandId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=brandName.childNodes[0].nodeValue;
	        	
        	}
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
  function ajaxFunctionForcheckForSocNe(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	       if(id.childNodes[0].nodeValue ==0)
	       {
	       		alert("Wrong entry in Nomenclature of Item...! ")
	       		document.getElementById("itemName").value=""; 
	       }else{
	       }
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
 //=========================Start ofFunctions for MMF Indent=================
 function importingMmfIndent(formName,action){
 
 var year=document.getElementById('mmfForTheYear').value
 
 new Ajax.Request(action+'&mmfForTheYear='+year,
  {
    method:'get',
    onSuccess: function(transport){
      var response = transport.responseText || "no response text";
      document.getElementById('testDiv').innerHTML =response
    },
    onFailure: function(){ alert('Something went wrong...') },
    onLoading: function(){ }
    });
  
 
 }
 //=========================End ofFunctions for MMF Indent=================
 
 //-----------------------------------------------------------------------------------------------------------------
 //------------------------------------Start of Functions Written By Vivek------------------------------------------
 //-----------------------------------------------------------------------------------------------------------------
 function getManufacturerNameInAjax(brandId,rowVal){
 
 
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var manufacturerName  = item.getElementsByTagName("manufacturerName")[0];
	        var mId  = item.getElementsByTagName("mId")[0];
        	document.getElementById('manuId'+rowVal).value = manufacturerName.childNodes[0].nodeValue
        	document.getElementById('manuIdTemp'+rowVal).value = mId.childNodes[0].nodeValue
        	
      	} 
      }
    }
     url="stores?method=getManufacturerNameInAjax&brandId="+brandId;
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
 }
  function ajaxFunctionForVendorReturn(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var brandId  = item.getElementsByTagName("brandId")[0];
	       
	        var name  = item.getElementsByTagName("name")[0];
        	document.getElementById('pvmsNo'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('nomenclature'+rowVal).value = name.childNodes[0].nodeValue
        	document.getElementById('itemId'+rowVal).value = id.childNodes[0].nodeValue
       
        	var url="/hms/hms/stores?method=showStockDetailsForVendorReturn&brandId="+brandId.childNodes[0].nodeValue+"&rowVal="+rowVal;
        	 popwindow(url);
      	} 
      }
    }
    var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
 
 //-----------------------------------------------------------------------------------------------------------------
 //-------------------------------------End of Functions Written By Vivek-------------------------------------------
 //-----------------------------------------------------------------------------------------------------------------
 
 
 //-----------------------------------Start of Function written By Vikas------------------------------------------
 function ajaxFunctionForAutoCompletePatientIssue(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	        var nomenclature  = item.getElementsByTagName("au")[0];
	        var itemId  = item.getElementsByTagName("id")[0];
        	document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
        	document.getElementById('nomenclature'+rowVal).value = nomenclature.childNodes[0].nodeValue
        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
      	} 
      	openPopupForPatientIssue(rowVal);
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  function openPopupForPatientIssue(rowVal){
	 itemId=document.getElementById('itemId'+rowVal).value
	
		if(itemId !=""){
		var url="/hms/hms/ipd?method=showPatientIssueStockDetailsJsp&itemId="+itemId+"&rowVal="+rowVal;
        newwindow=window.open(url,'name',"height=500,width=800,status=1");
        }
     }
  function ajaxFunctionForAutoCompleteOPDPatient(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	       
	        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var itemId  = item.getElementsByTagName("id")[0];
	        
	     	document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
        	document.getElementById('nomenclature'+rowVal).value = au.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
   function ajaxFunctionForAutoCompleteLotNO(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	       
	        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	        var nomenclature  = item.getElementsByTagName("nomenclature")[0];
	        var itemId  = item.getElementsByTagName("itemId")[0];
	        
	       
	       
        	document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
        	document.getElementById('nomenclature'+rowVal).value = nomenclature.childNodes[0].nodeValue
        	
        	
        	
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
   function ajaxFunctionForAutoCompleteWardConsumption(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	        var nomenclature  = item.getElementsByTagName("au")[0];
	        var itemId  = item.getElementsByTagName("id")[0];
        	document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
        	document.getElementById('nomenclature'+rowVal).value = nomenclature.childNodes[0].nodeValue
        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
      	} 
      	openPopupForWardConsumption(rowVal);
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  function openPopupForWardConsumption(rowVal){
	 itemId=document.getElementById('itemId'+rowVal).value
	 var ipissueno = document.getElementById('ipissueno1').value
	 var fromdate = document.getElementById('frDate').value
	 var todate = document.getElementById('toDate').value
		if(itemId !=""){
		var url="/hms/hms/ipd?method=showWardConsumptionIssueStockDetailsJsp&itemId="+itemId+"&rowVal="+rowVal+"&ipissueno="+ipissueno+'&fromDate='+fromdate+'&todate='+todate;
        newwindow=window.open(url,'name',"height=500,width=1010,status=1");
        }
     }
  //-----------------------------------End of Function written By Vikas------------------------------------------
  
  
  // function by abha
  function submitProtoAjaxforIndent(formName,action){
	  	errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	
	        	new Ajax.Updater('indentDiv',url,
				   {asynchronous:true, evalScripts:true }); 
		       	return true;
	    	}
  
  function submitProtoAjaxforProformaNo(formName,action){
	  	errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	
	        	new Ajax.Updater('proformaDiv',url,
				   {asynchronous:true, evalScripts:true }); 
		       	return true;
	    	}
  
  
  function submitProtoAjaxforIndentAMFSD(formName,action){	
	errorMsg = "";
	ob1 = true;
	ob2 = true;
	ob3 = true;
	obj = eval('document.'+formName)
	       	obj.action = action;
  	   	 var url=action+"&"+getNameAndData(formName)

      	new Ajax.Updater('indentDiv',url,
			   {asynchronous:true, evalScripts:true }); 
	       	return true;
  	}
  function submitProtoAjaxforIndent1(formName,action){
			errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	
	        	new Ajax.Updater('gridDiv',url,
				   {asynchronous:true, evalScripts:true }); 
		       	return true;
   }
	    		
	    function submitProtoAjaxforGrid(formName,action){
    	errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	
	        	new Ajax.Updater('gridDiv',url,
				   {asynchronous:true, evalScripts:true }); 
		       	return true;
	    	}
	    	
		function submitProtoAjaxforATSODate(formName,action)
	    {
		
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	
	        	new Ajax.Updater('atsoDateDiv',url,
				   {asynchronous:true, evalScripts:true }); 
		       	return true;
	    }
	    

	   function submitProtoAjaxforSupplier(formName,action){
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	        	new Ajax.Updater('suppDiv',url,
				   {asynchronous:true, evalScripts:true });
		       	return true;
	    	}  
	   
	   function submitProtoAjaxforExel(formName,url){
			errorMsg = "";
			ob1 = true;
			ob2 = true;
			ob3 = true;
		        	new Ajax.Updater('exelImp',url,
					   {asynchronous:true, evalScripts:true });
			       	return true;
		    	} 
	   function submitProtoAjaxforClearDiv(formName,url){
		   errorMsg = "";
			ob1 = true;
			ob2 = true;
			ob3 = true;
		        	new Ajax.Updater('gridDiv',url,
					   {asynchronous:true, evalScripts:true });
			       	return true;
		    	} 
	    	


 function ajaxFunctionForAutoCompleteInGrn(formName,action,rowVal) {
	
 var sos = document.getElementById('sourceCombo').value
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	var brandId="brandId"+rowVal;
		obj = document.getElementById(brandId); 
		obj.length = 1;

		var manufacturerId ="manufacturerId"+rowVal;
		obj1 = document.getElementById(manufacturerId); 
		obj1.length = 1;
		
	//	var dispenseType ="dispenseType"+rowVal;
	//	obj2 = document.getElementById(dispenseType); 
	
      	for (loop = 0; loop < items.childNodes.length; loop++) 
      	{
      	 	var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	      //  var formula  = item.getElementsByTagName("formula")[0];
	       // var conversionFactor  = item.getElementsByTagName("conversionFactor")[0];
	        var name  = item.getElementsByTagName("name")[0];

	        var brandLength  = item.getElementsByTagName("brands")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	        var poRate  = item.getElementsByTagName("poRate")[0];
	        var poTax = item.getElementsByTagName("poTax")[0];
	      //  var poDiscount = item.getElementsByTagName("poDiscount")[0];
	        var dispType = item.getElementsByTagName("dispType")[0];
	        var bgItem=item.getElementsByTagName("bgItem")[0];
	

	       
	        
	    
	        
	        
	        var dispenseType ="dispenseType"+rowVal;
            obj2 = document.getElementById(dispenseType);
         	obj2.length=1;
			obj2.options[obj2.length-1].value = dispType.childNodes[0].nodeValue;
			obj2.options[obj2.length-1].text  = dispType.childNodes[0].nodeValue;
			
		


	        //var poMdqValue = item.getElementsByTagName("poMdqValue")[0];
	        var poRatePerMdq = item.getElementsByTagName("poRatePerMdq")[0];
	        var poBrandId = item.getElementsByTagName("poBrandId")[0];
	        var poManufacturerId = item.getElementsByTagName("poManufacturerId")[0];
	     //   var poFreeQty = item.getElementsByTagName("poFreeQty")[0];
	     //   var poFreeItem = item.getElementsByTagName("poFreeItem")[0];
	     //   var expiry = item.getElementsByTagName("expiry")[0];
	        
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	
			//document.getElementById('idBranGen1'+rowVal).value = bgItem.childNodes[0].nodeValue;
        	 
   
        
        
        //	document.getElementById('freeQty'+rowVal).value = poFreeQty.childNodes[0].nodeValue
        //	document.getElementById('expiry'+rowVal).value = expiry.childNodes[0].nodeValue
        	//document.getElementById('formula'+rowVal).value = formula.childNodes[0].nodeValue
        //	document.getElementById('conversionFactor'+rowVal).value = conversionFactor.childNodes[0].nodeValue
        	
        	
        	//obj2.length=1;
			//obj2.options[obj2.length-1].value = poDispType.childNodes[0].nodeValue;
			//obj2.options[obj2.length-1].text  = poDispType.childNodes[0].nodeValue;
        	
        
        	
        	for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++)
        	{
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	var manufacturerId = brand.getElementsByTagName("manufacturerId")[0];
	        	var manufacturerName  = brand.getElementsByTagName("manufacturerName")[0];	        	
	        	
	        	obj.length++;
				obj.options[obj.length-1].value=brandId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=brandName.childNodes[0].nodeValue;
				
				
				obj1.length++;
				obj1.options[obj1.length-1].value=manufacturerId.childNodes[0].nodeValue;
				obj1.options[obj1.length-1].text=manufacturerName.childNodes[0].nodeValue;
	        	
        	}
        	//document.getElementById('discountVar'+rowVal).value =poDiscount.childNodes[0].nodeValue
        //	document.getElementById('tax_amt_mdq'+rowVal).value =poTax.childNodes[0].nodeValue
        	//document.getElementById('mdq'+rowVal).value =poMdqValue.childNodes[0].nodeValue
        //	document.getElementById('ratePerMdq'+rowVal).value =poRatePerMdq.childNodes[0].nodeValue
        	
        	
        	var brandCombo = document.getElementById('brandId'+rowVal);
        	
        /*	for(var i=0;i<brandCombo.length;i++)
        	{
        		if (brandCombo[i].value == poBrandId.childNodes[0].nodeValue)
        			brandCombo.selectedIndex = i;
        	}
        	
        	
        	var manufacturerCombo = document.getElementById('manufacturerId'+rowVal);
        	
        	for(var i=0;i<manufacturerCombo.length;i++)
        	{
        		if (manufacturerCombo[i].value == poManufacturerId.childNodes[0].nodeValue)
        			manufacturerCombo.selectedIndex = i;
        	}*/
        	
        //	var freeItemCombo = document.getElementById('freeItem'+rowVal);
        	
        	//for(var i=0;i<freeItemCombo.length;i++)
        //	{
        //		if (freeItemCombo[i].value == poFreeItem.childNodes[0].nodeValue)
        		//	freeItemCombo.selectedIndex = i;
        //	}
        	
      	} 
      }
    }
   	 var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
  }
 
 
//=====================AT BANGALORE===================
function ajaxFunctionForAutoCompleteInGrnGeneral(formName,action,rowVal) {
 
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	var brandId="brandId"+rowVal;
		obj = document.getElementById(brandId); 
		obj.length = 1;

		var manufacturerId ="manufacturerId"+rowVal;
		obj1 = document.getElementById(manufacturerId); 
		obj1.length = 1;
		
		
		//var dispenseType ="dispenseType"+rowVal;
		//obj2 = document.getElementById(dispenseType); 
			
      	for (loop = 0; loop < items.childNodes.length; loop++) 
      	{
      	 	var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var dispType = item.getElementsByTagName("dispType")[0];
	        var formula = item.getElementsByTagName("formula")[0];
	        var conversionFactor = item.getElementsByTagName("conversionFactor")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	        var expiry = item.getElementsByTagName("expiry")[0];
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('expiry'+rowVal).value = expiry.childNodes[0].nodeValue
	       	document.getElementById('formula'+rowVal).value = formula.childNodes[0].nodeValue
        	document.getElementById('conversionFactor'+rowVal).value = conversionFactor.childNodes[0].nodeValue
        	obj2.length=1;
			obj2.options[obj2.length-1].value = dispType.childNodes[0].nodeValue;
			obj2.options[obj2.length-1].text  = dispType.childNodes[0].nodeValue;
        	
        	for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++)
        	{
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	var manufacturerId = brand.getElementsByTagName("manufacturerId")[0];
	        	var manufacturerName  = brand.getElementsByTagName("manufacturerName")[0];	        	
	        	
	        	obj.length++;
				obj.options[obj.length-1].value=brandId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=brandName.childNodes[0].nodeValue;
				
				
				obj1.length++;
				obj1.options[obj1.length-1].value=manufacturerId.childNodes[0].nodeValue;
				obj1.options[obj1.length-1].text=manufacturerName.childNodes[0].nodeValue;
	        	
        	}
      	} 
      }
    }
   	 var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }


  //---- For Loan In---------------------
  function ajaxFunctionForAutoCompleteInLoanIn(formName,action,rowVal) {
  var po_id = document.getElementById('poId').value
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	var brandId="brandId"+rowVal;
		obj =document.getElementById(brandId); 
		obj.length = 1;
		
		var manufacturerId ="manufacturerId"+rowVal;
		obj1 =document.getElementById(manufacturerId); 
		obj1.length = 1;
		
		var dispenseType ="dispenseType"+rowVal;
		
		obj2 = document.getElementById(dispenseType); 
	
			
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        var expiry  = item.getElementsByTagName("expiry")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	        var DispType = item.getElementsByTagName("dispType")[0];
	        if(po_id != ""){
	        var poRate  = item.getElementsByTagName("poRate")[0];
	        var poTax = item.getElementsByTagName("poTax")[0];
	        var poDiscount = item.getElementsByTagName("poDiscount")[0];
	        var poDispType = item.getElementsByTagName("poDispType")[0];
	        var poMdqValue = item.getElementsByTagName("poMdqValue")[0];
	        var poRatePerMdq = item.getElementsByTagName("poRatePerMdq")[0];
	        var poBrandId = item.getElementsByTagName("poBrandId")[0];
	        var poManufacturerId = item.getElementsByTagName("poManufacturerId")[0];
	        var poFreeQty = item.getElementsByTagName("poFreeQty")[0];
	        var poFreeItem = item.getElementsByTagName("poFreeItem")[0];
	        }
	        var formula  = item.getElementsByTagName("formula")[0];
     		var conversionFactor  = item.getElementsByTagName("conversionFactor")[0];
	        
	        
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('expiry'+rowVal).value = expiry.childNodes[0].nodeValue
        	document.getElementById('formula'+rowVal).value = formula.childNodes[0].nodeValue
			document.getElementById('conversionFactor'+rowVal).value = conversionFactor.childNodes[0].nodeValue
			
        	obj2.length=1;
        	obj2.options[obj2.length-1].value = DispType.childNodes[0].nodeValue;
        	obj2.options[obj2.length-1].text = DispType.childNodes[0].nodeValue;
        	
        	for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++)
        	{
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	var manufacturerId  = brand.getElementsByTagName("manufacturerId")[0];
	        	var manufacturerName = brand.getElementsByTagName("manufacturerName")[0];
	        	
	        	obj.length++;
				obj.options[obj.length-1].value=brandId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=brandName.childNodes[0].nodeValue;
				
				obj1.length++;
				obj1.options[obj1.length-1].value=manufacturerId.childNodes[0].nodeValue;
				obj1.options[obj1.length-1].text=manufacturerName.childNodes[0].nodeValue;
        	}
        	
        	if(po_id != ""){
        	document.getElementById('freeQty'+rowVal).value = poFreeQty.childNodes[0].nodeValue
        	document.getElementById('discountVar'+rowVal).value =poDiscount.childNodes[0].nodeValue
        	document.getElementById('taxVar'+rowVal).value =poTax.childNodes[0].nodeValue
        	document.getElementById('mdq'+rowVal).value =poMdqValue.childNodes[0].nodeValue
        	document.getElementById('ratePerMdq'+rowVal).value =poRatePerMdq.childNodes[0].nodeValue
        	}
        	
        	
        	var brandCombo = document.getElementById('brandId'+rowVal);
        	
        	for(var i=0;i<brandCombo.length;i++)
        	{
        		if (brandCombo[i].value == poBrandId.childNodes[0].nodeValue)
        			brandCombo.selectedIndex = i;
        	}
        	
        	
        	var manufacturerCombo = document.getElementById('manufacturerId'+rowVal);
        	
        	for(var i=0;i<manufacturerCombo.length;i++)
        	{
        		if (manufacturerCombo[i].value == poManufacturerId.childNodes[0].nodeValue)
        			manufacturerCombo.selectedIndex = i;
        	}
        	
        	var freeItemCombo = document.getElementById('freeItem'+rowVal);
        	
        	for(var i=0;i<freeItemCombo.length;i++)
        	{
        		if (freeItemCombo[i].value == poFreeItem.childNodes[0].nodeValue)
        			freeItemCombo.selectedIndex = i;
        	}
        	
        	
      	} 
      }
    }
   	 var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
  }


 // defect Drugs
 function ajaxFunctionForAutoCompleteInDefectiveDrugs(formName,action,rowVal) {

  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	var brandId="brandId"+rowVal;
      	var batchId="batchId"+rowVal;
		obj1 =document.getElementById(brandId); 
		obj = document.getElementById(batchId);
		obj.length = 1;
		obj1.length =1;
			
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	         var batchLength  = item.getElementsByTagName("batchs")[0];
	     
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	
        	   var bg  = item.getElementsByTagName("BG")[0];
        	
        	for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
        	{
        		var batch = batchLength.childNodes[innerLoop];
	        	var batchId  = batch.getElementsByTagName("batchId")[0];
	        	var batchName  = batch.getElementsByTagName("batchName")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
	        	
        	}
       
        	 for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++){
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	
	        	obj1.length++;
				obj1.options[obj1.length-1].value=brandId.childNodes[0].nodeValue;
				obj1.options[obj1.length-1].text=brandName.childNodes[0].nodeValue;
	        	
        	}
        	 
        	 
        	 for(innerLoop = 0;innerLoop <bg.childNodes.length;innerLoop++){
            		var brandGeneric = bg.childNodes[innerLoop];
     	        	var bgId  = brandGeneric.getElementsByTagName("brandGId")[0];
     	        	var bgName  = brandGeneric.getElementsByTagName("brandGName")[0];
     	        	
     	        	
     	        	//document.getElementById('bg'+rowVal).value=bgName.childNodes[0].nodeValue;
     				
     	        	
            	}
        		
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
 
 // javed  for Turn over Register 
 function ajaxFunctionForAutoCompleteInTurnOver(formName,action) {
  var xmlHttp;
    var f=formName;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	//var brandId="brandId";
      	var batchId="batchId";
		//obj1 =document.getElementById(brandId); 
      	if(f=="grnGrid"){
		obj = document.getElementById(batchId);
		obj.length = 1;
      	}
		//obj1.length =1;
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	         var batchLength  = item.getElementsByTagName("batchsForTurn")[0];
        	document.getElementById('codeItem1').value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem1').value = id.childNodes[0].nodeValue
        	document.getElementById('idAu1').value = au.childNodes[0].nodeValue
        	
        	
        	
        	for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
        	{
        		var batch = batchLength.childNodes[innerLoop];
	        	var batchId  = batch.getElementsByTagName("batchIdForTurn")[0];
	        	var batchName  = batch.getElementsByTagName("batchNameForTurn")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
	        	
        	}
       
        	/* for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++){
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	
	        	obj1.length++;
				obj1.options[obj1.length-1].value=brandId.childNodes[0].nodeValue;
				obj1.options[obj1.length-1].text=brandName.childNodes[0].nodeValue;
	        	
        	}*/
        		
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
 
//javed  for Drug Cost Entry
 function ajaxFunctionForAutoCompleteInDrugCostEntry(formName,action) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	var brandId="brandId";
      	var batchId="batchId";
 		obj1 =document.getElementById(brandId); 
 		/*obj = document.getElementById(batchId);
 		obj.length = 1;*/
 		obj1.length =1;
 		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
 	   	    var item = items.childNodes[loop];
 	        var id  = item.getElementsByTagName("id")[0];
 	        var pvms  = item.getElementsByTagName("pvms")[0];
 	        var au  = item.getElementsByTagName("au")[0];
 	        var name  = item.getElementsByTagName("name")[0];
 	        var brandLength  = item.getElementsByTagName("brands")[0];
 	         var batchLength  = item.getElementsByTagName("batchsForTurn")[0];
 	         var manufacturer  = item.getElementsByTagName("manu")[0];
        	document.getElementById('codeItem1').value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem1').value = id.childNodes[0].nodeValue
        	document.getElementById('idAu1').value = au.childNodes[0].nodeValue
        	document.getElementById('manu').value = manufacturer.childNodes[0].nodeValue
        	
        	
        	/*for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
        	{
        		var batch = batchLength.childNodes[innerLoop];
 	        	var batchId  = batch.getElementsByTagName("batchIdForTurn")[0];
 	        	var batchName  = batch.getElementsByTagName("batchNameForTurn")[0];
 	        	obj.length++;
 				obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
 				obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
 	        	
        	}*/
       
        	 for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++){
        		var brand = brandLength.childNodes[innerLoop];
 	        	var brandId  = brand.getElementsByTagName("brandId")[0];
 	        	var brandName  = brand.getElementsByTagName("brandName")[0];
 	        	
 	        	obj1.length++;
 				obj1.options[obj1.length-1].value=brandId.childNodes[0].nodeValue;
 				obj1.options[obj1.length-1].text=brandName.childNodes[0].nodeValue;
 	        	
        	}
        		
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
 
 // javed  for  retrun dispensary
 function ajaxFunctionForAutoCompleteInReturn(formName,action,rowVal) {
  var xmlHttp;
   
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	
      	var batchId="batchId"+rowVal;
		      
		obj = document.getElementById(batchId);
		obj.length = 1;
      
				
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	         var batchLength  = item.getElementsByTagName("batchsForTurn")[0];
        
        	
        	
        	document.getElementById('itemId'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('pvmsNo'+rowVal).value = pvms.childNodes[0].nodeValue
        	//document.getElementById('nomenclature'+rowVal).value = name.childNodes[0].nodeValue
        	document.getElementById('au'+rowVal).value = au.childNodes[0].nodeValue
        	//document.getElementById('batchNo'+rowVal).value = batchno.childNodes[0].nodeValue
        	//document.getElementById('expiryDate'+rowVal).value = expirydate.childNodes[0].nodeValue 
        	//document.getElementById('stockId'+rowVal).value = BatchStockId.childNodes[0].nodeValue 
        	
        	for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
        	{
        		var batch = batchLength.childNodes[innerLoop];
	        	var batchId  = batch.getElementsByTagName("batchIdForTurn")[0];
	        	var batchName  = batch.getElementsByTagName("batchNameForTurn")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
	        	
        	}
       
        
        		
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
 
 // javed  for Turn over Register 
 function ajaxFunctionForAutoCompleteInMMF(formName,action) {
  var xmlHttp;
    var f=formName;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	//var brandId="brandId";
      	var batchId="batchId";
		//obj1 =document.getElementById(brandId); 
      	if(f=="grnGrid"){
		obj = document.getElementById(batchId);
		obj.length = 1;
      	}
		//obj1.length =1;
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var nomen  = item.getElementsByTagName("nomen")[0];
	       
	       
        	document.getElementById('codeItem1').value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem1').value = id.childNodes[0].nodeValue
        	document.getElementById('idAu1').value = au.childNodes[0].nodeValue
        	document.getElementById('nameItem1').value = nomen.childNodes[0].nodeValue+"["+pvms.childNodes[0].nodeValue+"]";
        	
        	
        	
        	
        	
       
        	
        		
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
 // Sanjay Yadav
 function ajaxFunctionForAutoCompleteInBoardofSurvey(formName,action)
  {  var xmlHttp;
    var f=formName;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	//var brandId="brandId";
      //	var batchId="batchId";
		//obj1 =document.getElementById(brandId); 
      	if(f=="grnGrid"){
		obj = document.getElementById(batchId);
		obj.length = 1;
      	}
		//obj1.length =1;
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var qty  = item.getElementsByTagName("qty")[0];
	       
	       
        	document.getElementById('codeItem1').value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem1').value = id.childNodes[0].nodeValue
        	document.getElementById('qty1').value = qty.childNodes[0].nodeValue
        	document.getElementById('idAu').value = au.childNodes[0].nodeValue
        	      	
        	
        	
       
        	
        		
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
 
 // Add By Sanjay Yadav
 
 function  ajaxFunctionForAutoCompleteInMeScale(formName,action,rowVal){
	 var xmlHttp;
	    var f=formName;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      
	      	//var brandId="brandId";
	      //	var batchId="batchId";
			//obj1 =document.getElementById(brandId); 
	      	if(f=="grnGrid"){
			obj = document.getElementById(batchId);
			obj.length = 1;
	      	}
			//obj1.length =1;
			
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var id  = item.getElementsByTagName("id")[0];
		        var pvms  = item.getElementsByTagName("pvms")[0];
		        var au  = item.getElementsByTagName("au")[0];
		        var qty  = item.getElementsByTagName("qty")[0];
	        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
	        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
	        	document.getElementById("qty"+rowVal).value=qty.childNodes[0].nodeValue;    	
	        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
	        	
	        	
	       
	        	
	        		
	      	} 
	      }
	    }
	    var url=action+"&"+getNameAndData(formName)
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	 
 }
 
 // Add By sanjay Yadav
 function ajaxFunctionForAutoCompleteIndentToDepot(formName,action)
 {  var xmlHttp;
   var f=formName;
 try {
   // Firefox, Opera 8.0+, Safari
   xmlHttp=new XMLHttpRequest();
 }catch (e){
   // Internet Explorer
   try{
     xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
   }catch (e){
   	alert(e)
     try{
       xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
     }catch (e){
       alert("Your browser does not support AJAX!");
       return false;
     }
    }
  }
   xmlHttp.onreadystatechange=function()
   {
     if(xmlHttp.readyState==4){
     
     	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
     
     	//var brandId="brandId";
     	var batchId="batchId";
		//obj1 =document.getElementById(brandId); 
     	if(f=="grnGrid"){
		obj = document.getElementById(batchId);
		obj.length = 1;
     	}
		//obj1.length =1;
		
     	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	       
	       
       	document.getElementById('codeItem1').value = pvms.childNodes[0].nodeValue
       	document.getElementById('idItem1').value = id.childNodes[0].nodeValue
       	document.getElementById('idAu').value = au.childNodes[0].nodeValue
       	
       	
       	
       	
      
       	
       		
     	} 
     }
   }
   var url=action+"&"+getNameAndData(formName)
    
   xmlHttp.open("GET",url,true);
   xmlHttp.setRequestHeader("Content-Type", "text/xml");
   xmlHttp.send(null);
   
   
 }
 
  ///=========== FOR NON EXPANDABLE 
  function ajaxFunctionForAutoCompleteInNeGrn(formName,action,rowVal) {
 
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	//alert("items"+items)
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	
        	
      	} 
      }
    }
       var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
  function ajaxFunctionForAutoCompleteInNeLoanIn(formName,action,rowVal) {
 
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	//alert("items"+items)
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	
        	
      	} 
      }
    }
       var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
   
   
   function ajaxFunctionForAutoCompleteInWorkOrder(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      		//var batchId="batchId"+rowVal;
      		
      		//obj = document.getElementById(batchId);
		//obj.length = 1;
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	         var batchLength  = item.getElementsByTagName("batchs")[0];
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	
        	for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
        	{
        		var batch = batchLength.childNodes[innerLoop];
	        	var batchId  = batch.getElementsByTagName("batchId")[0];
	        	var batchName  = batch.getElementsByTagName("batchName")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
	        	
        	}
        	
      	} 
      }
    }
       var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
//--------------------------------------------- Mansi-----------------------------------
function ajaxFunctionForAutoCompleteNomenclature(formName,action,rowVal) 
  { 
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	       
	        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	        var itemId  = item.getElementsByTagName("id")[0];
        	document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
       
      	} 
      }
    }
    var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
 }

 //================= condemnation entry ==================
  function ajaxFunctionForAutoCompleteInCondemnation(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      		var batchId="batchId"+rowVal;
      		
      		obj = document.getElementById(batchId);
		obj.length = 1;
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	      
	        var name  = item.getElementsByTagName("name")[0];
	         var batchLength  = item.getElementsByTagName("batchs")[0];
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	
        	
        	for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
        	{
        		var batch = batchLength.childNodes[innerLoop];
	        	var batchId  = batch.getElementsByTagName("batchId")[0];
	        	var batchName  = batch.getElementsByTagName("batchName")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
	        	
        	}
        	
      	} 
      }
    }
       var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
 
 
 
 //================Balance Ajax multiple ids updating=================

  
  
  // ************************Start Of DEEPTI Tevatia*********************************

 function ajaxFunctionForDepartmentReturn(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	alert("---->"+items.childNodes.length);
     	if(items.childNodes.length > 0){
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var name = item.getElementsByTagName("name")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var batchno  = item.getElementsByTagName("batchno")[0];
	        var expirydate  = item.getElementsByTagName("expirydate")[0];
	        var BatchStockId=item.getElementsByTagName("BatchStockId")[0]
	       
	        
	        document.getElementById('itemId'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('pvmsNo'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('nomenclature'+rowVal).value = name.childNodes[0].nodeValue
        	document.getElementById('au'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('batchNo'+rowVal).value = batchno.childNodes[0].nodeValue
        	document.getElementById('expiryDate'+rowVal).value = expirydate.childNodes[0].nodeValue 
        	document.getElementById('stockId'+rowVal).value = BatchStockId.childNodes[0].nodeValue 
        	var url="/hms/hms/stores?method=showStockDetailsForReturnDispensary&brandId="+brandId.childNodes[0].nodeValue+"&rowVal="+rowVal;
        	popwindow(url);
      	} 
     	}else{alert("No item");}
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
//***************************End Of Deepti Tevatia*******************************


//***************************Functions By Ritu*******************************

  function getServicePersonName(formName,action){
		var serviceTypeId = document.getElementById('serviceTypeId').value;
  		var serviceNo = document.getElementById('serviceNoId').value;
  		var serviceStatusId = document.getElementById('serviceStatusId').value;
  		var prefix = document.getElementById('prefix').value;
  		var suffix = document.getElementById('suffixId').value;
  		var echs='';
  		if(document.getElementById('echs'))
  			echs = document.getElementById('echs').value;
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
		     //  	if(serviceTypeId != 0 && serviceNo != ''){
	    	   	 var url=action+"&serviceNo="+serviceNo+"&serviceTypeId="+serviceTypeId+"&serviceStatusId="+serviceStatusId+"&echs="+echs+"&prefix="+prefix+"&suffix="+suffix;
	        	
	        	new Ajax.Updater('sNameDiv',url,
				   {asynchronous:true, evalScripts:true }); 
				  // }
				return true;
	    	}
  
  function getServicePersonNameHAL(formName,action){
	    
		var serviceTypeId = document.getElementById('serviceTypeId').value;
		var serviceNo = document.getElementById('serviceNoId').value;
		var serviceStatusId = document.getElementById('serviceStatusId').value;
	/*	var prefix = document.getElementById('prefix').value;
		var suffix = document.getElementById('suffixId').value;*/						
		
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
		     //  	if(serviceTypeId != 0 && serviceNo != ''){
	    	   	 var url=action+"&serviceNo="+serviceNo+"&serviceTypeId="+serviceTypeId+"&serviceStatusId="+serviceStatusId;
	        	
	        	/*new Ajax.Updater('sNameDiv',url,
				   {asynchronous:true, evalScripts:true, onSuccess: function(request){getHinHAL(formName, 8)} }); */
	        	new Ajax.Updater('sNameDiv',url,
	 				   {asynchronous:true, evalScripts:false, onSuccess: function(request){	 					
	 					  document.getElementById("dobId").onblur();
	 				   } }); 
				  // }	
	        	
				
	    	}
  
  function getServicePersonNameHALForOnlineVisit(formName, relationId, action){
		var serviceTypeId = document.getElementById('serviceTypeId').value;
		var serviceNo = document.getElementById('serviceNoId').value;
		var serviceStatusId = document.getElementById('serviceStatusId').value;
	/*	var prefix = document.getElementById('prefix').value;
		var suffix = document.getElementById('suffixId').value;*/						
		var echs='';
		if(document.getElementById('echs'))
			echs = document.getElementById('echs').value;
		errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
		     //  	if(serviceTypeId != 0 && serviceNo != ''){
	    	   	 var url=action+"&serviceNo="+serviceNo+"&serviceTypeId="+serviceTypeId+"&serviceStatusId="+serviceStatusId+"&echs="+echs;
	        	
	        	/*new Ajax.Updater('sNameDiv',url,
				   {asynchronous:true, evalScripts:true, onSuccess: function(request){getHinHAL(formName, 8)} }); */
	        	new Ajax.Updater('sNameDiv',url,
	 				   {asynchronous:true, evalScripts:false, onSuccess: function(request){displayPatientInfoHAL(relationId);
	 					 changerel(relationId);} }); 
				  // }	        	
				
	    	}
  
 
//----Function for age through ajax---------- 	    	
  function calculateAgeInAjax() {
  dob=document.getElementById('dobId').value;
  var  theForms = document.getElementsByTagName("form");  
  
  		if(dob!= ""){
			if(checkDob('dobId')){
			action="/hms/hms/registration?method=calculateAgeInAjax&dateOfBirth="+dob;	
			obj = eval('document.'+theForms[2].name)
			       obj.action = action;
		    	   	 var url=action
			}
  		}
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var age  = item.getElementsByTagName("age")[0];
	        var period  = item.getElementsByTagName("period")[0];
	       obj=eval(document.getElementById('ageId'))
	       if(age.childNodes[0].nodeValue == "0"){
	       obj.value=0;
	       }else{
		   obj.value=age.childNodes[0].nodeValue}
		    temp = eval("document.registration.ageUnit");
		   temp.value=period.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  function calculateSRAgeInAjax() {
	  var action='';
	  dob=document.getElementById('srdobId').value;
	  var  theForms = document.getElementsByTagName("form");  
	  		if(dob!= ""){
				if(checkDob('srdobId')){
				action="/hms/hms/registration?method=calculateAgeInAjax&dateOfBirth="+dob;	
				obj = eval('document.'+theForms[2].name)
				       obj.action = action;
			    	   	 var url=action
				}
	  		
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var age  = item.getElementsByTagName("age")[0];
		        var period  = item.getElementsByTagName("period")[0];
		       obj=eval(document.getElementById('srAgeId'))
		       if(age.childNodes[0].nodeValue == "0"){
		       obj.value="0"
		       }else{
		    	 if(age.childNodes[0].nodeValue < '16'){
		    		 alert("Please check Service Person Age.");
		    		 document.getElementById('srdobId').value="";
		    		 document.getElementById('dobId').value="";
		    		 document.getElementById('ageId').value="";
		    		 return false;
		    	 }
			   obj.value=age.childNodes[0].nodeValue}
			    temp = eval("document.registration.srAgeUnit");
			   temp.value=period.childNodes[0].nodeValue
	      	} 
	      }
	    }
	    var url=action
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	  		}
	    
	    
	  }
function ajaxFunctionForAutoCompleteChargeCode(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
   totalChargeAmt=0;
       totalNetAmt=0;
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	for (loop = 0; loop < items.childNodes.length; loop++) {
      		if( document.getElementById('disamount'+rowVal).value != ""){
            	 document.getElementById('disamount'+rowVal).value ="";
            }	
	   	    var item = items.childNodes[loop];
	        var chargeId  = item.getElementsByTagName("chargeId")[0];
	        var amount  = item.getElementsByTagName("amount")[0];
	        document.getElementById('qty'+rowVal).value = '1'
	        document.getElementById('rate'+rowVal).value = amount.childNodes[0].nodeValue
        	document.getElementById('amount'+rowVal).value = amount.childNodes[0].nodeValue
        	document.getElementById('netamount'+rowVal).value = amount.childNodes[0].nodeValue
        	document.getElementById('chargeCodeId'+rowVal).value = chargeId.childNodes[0].nodeValue
        	var amt = document.getElementById('amount'+rowVal).value;
        	totalChargeAmt = parseInt(totalChargeAmt)+parseInt(amt);
        	totalNetAmt = parseInt(totalNetAmt)+parseInt(document.getElementById('netamount'+rowVal).value);
        	document.getElementById('qty'+rowVal).readOnly = false;
        	document.getElementById('disamount'+rowVal).readOnly = false;
      	} 
      }
        var totalAmtVal = document.getElementById('totalAmtId').value;
		if(totalAmtVal == ''){
			document.getElementById('totalAmtId').value=totalChargeAmt
		}else{
			document.getElementById('totalAmtId').value=parseInt(totalChargeAmt)+parseInt(totalAmtVal)
		}
			
		var totalNetAmtVal = document.getElementById('totalNetId').value;
		if(totalNetAmtVal == ''){
			document.getElementById('totalNetId').value=totalNetAmt
		}else{
			document.getElementById('totalNetId').value=parseInt(totalNetAmt)+parseInt(totalNetAmtVal)
		}		
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    }
  
  function ajaxFunctionForAutoCompleteChargeCodeName(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 	var valueChargeCode = document.getElementById('chargeCode'+rowVal).value;
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var chargeId  = item.getElementsByTagName("chargeId")[0];
	        var chargeName  = item.getElementsByTagName("chargeName")[0];
	        var mainChargeId  = item.getElementsByTagName("mainChargeId")[0];
	        var subChargeId  = item.getElementsByTagName("subChargeId")[0];
	        document.getElementById('qty'+rowVal).value = '1'
        	document.getElementById('chargeCodeId'+rowVal).value = chargeId.childNodes[0].nodeValue
        	//var tempChargeCode = chargeName.childNodes[0].nodeValue
        	//alert(tempChargeCode);
        	//var tempChargeCodeArray = chargeName.split('0');
			//for(var m=0; m<tempChargeCodeArray.length;m++){
        	//	alert(tempChargeCodeArray[m]);
        	//}
        	document.getElementById('chargeName'+rowVal).value = chargeName.childNodes[0].nodeValue
        	document.getElementById('mainChargeId'+rowVal).value = mainChargeId.childNodes[0].nodeValue
        	document.getElementById('subChargeId'+rowVal).value = subChargeId.childNodes[0].nodeValue
        	
        	document.getElementById('chargeCode'+rowVal).value = valueChargeCode;
        	document.getElementById('submitButton').disabled = false;
      		//submitButton.setAttribute('disabled','enabled');
      	} 
      }else{
      		
      		document.getElementById('chargeCode'+rowVal).value = 'Please Wait system is getting important data.......';
      		document.getElementById('submitButton').disabled = true;
      		//var submitButton = document.getElementById('submitButton');
      		//submitButton.setAttribute('disabled','disabled');
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  function ajaxFunctionForAutoCompleteChargeName(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var chargeId  = item.getElementsByTagName("chargeId")[0];
        	document.getElementById('chargeCodeId'+rowVal).value = chargeId.childNodes[0].nodeValue
      	} 
      }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  


//----------------Added at Bangalore--------------------
function  getEchsNo(){
if(document.getElementById("serviceStatusId").value ==2){
	new Ajax.Updater('exServiceId','/hms/hms/registration?method=getEchsNo',{asynchronous:true, evalScripts:true });
	document.getElementById('unitId').setAttribute('validate','Unit,string,no');
	if(document.getElementById('echs'))
		document.getElementById('exServiceId').style.display='block';
}else if(document.getElementById("serviceStatusId").value == 1){
	document.getElementById('unitId').setAttribute('validate','Unit,string,yes');
	if(document.getElementById('echs'))
		document.getElementById('exServiceId').style.display='none';
}
} 

 function populatePatientDetails() {
	 
  		var serviceTypeId = document.getElementById('serviceTypeId').value;
  		var serviceNo = document.getElementById('serviceNoId').value;
  		var serviceStatusId = document.getElementById('serviceStatusId').value;
	//	if(checkDob()){
		action="/hms/hms/registration?method=populatePatientDetails&serviceTypeId="+serviceTypeId+"&serviceNo="+serviceNo+"&serviceStatusId="+serviceStatusId;	
		obj = eval('document.registration')
		       obj.action = action;
	    	   	 var url=action
	// }
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	       var address  = item.getElementsByTagName("address")[0];
	       var blockId  = item.getElementsByTagName("blockId")[0];
	       var stateId  = item.getElementsByTagName("stateId")[0];
	       var cityId  = item.getElementsByTagName("cityId")[0];
	       var countryId  = item.getElementsByTagName("countryId")[0];
	       var pinCode  = item.getElementsByTagName("pinCode")[0];
	       var patientDistrict  = item.getElementsByTagName("patientDistrict")[0];
	       var postOff  = item.getElementsByTagName("postOff")[0];
	       var policeStation  = item.getElementsByTagName("policeStation")[0];
	       var phoneNo  = item.getElementsByTagName("phoneNo")[0];
	       var mobileNo  = item.getElementsByTagName("mobileNo")[0];
	         var religionId  = item.getElementsByTagName("religionId")[0];
	         
	         
	        if(address.childNodes[0] != undefined){  
	        	if(document.getElementById("addr"))
	        		document.getElementById("addr").value = address.childNodes[0].nodeValue
	        }
	    
	        if(document.getElementById("stateId")){
	        	document.getElementById("stateId").selectedIndex = stateId.childNodes[0].nodeValue
	        	//populateDistrict(stateId.childNodes[0].nodeValue,'registration')
	        }
		
		   if(phoneNo.childNodes[0] !=undefined)
			   document.getElementById("phoneNo").value =phoneNo.childNodes[0].nodeValue
		   if(mobileNo.childNodes[0] !=undefined)
			   document.getElementById("mobileNo").value =mobileNo.childNodes[0].nodeValue
		 if(cityId.childNodes[0]!=undefined){
			   if(document.getElementById("cityId"))
			   document.getElementById("cityId").selectedIndex = cityId.childNodes[0].nodeValue;
		 }	
		  
      	} 
      }
    }
    var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }

 
 function populatePatientDetailsHAL() {
	 
		/*var serviceTypeId = document.getElementById('serviceTypeId').value;*/
		var serviceNo = document.getElementById('serviceNoId').value;
		var serviceStatusId = document.getElementById('serviceStatusId').value;
	//	if(checkDob()){
		action="/hms/hms/registration?method=populatePatientDetailsHAL&serviceNo="+serviceNo+"&serviceStatusId="+serviceStatusId;	
		obj = eval('document.registration')
		       obj.action = action;
	    	   	 var url=action
	// }
var xmlHttp;
try {
 // Firefox, Opera 8.0+, Safari
 xmlHttp=new XMLHttpRequest();
}catch (e){
 // Internet Explorer
 try{
   xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
 }catch (e){
 	alert(e)
   try{
     xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
   }catch (e){
     alert("Your browser does not support AJAX!");
     return false;
   }
  }
}
 xmlHttp.onreadystatechange=function()
 {
   if(xmlHttp.readyState==4){
   	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
   	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	       var address  = item.getElementsByTagName("address")[0];
	       var blockId  = item.getElementsByTagName("blockId")[0];
	       var stateId  = item.getElementsByTagName("stateId")[0];
	       var cityId  = item.getElementsByTagName("cityId")[0];
	       var countryId  = item.getElementsByTagName("countryId")[0];
	       var pinCode  = item.getElementsByTagName("pinCode")[0];
	       var patientDistrict  = item.getElementsByTagName("patientDistrict")[0];
	       var postOff  = item.getElementsByTagName("postOff")[0];
	       var policeStation  = item.getElementsByTagName("policeStation")[0];
	       var phoneNo  = item.getElementsByTagName("phoneNo")[0];
	       var mobileNo  = item.getElementsByTagName("mobileNo")[0];
	         var religionId  = item.getElementsByTagName("religionId")[0];
	         
	         
	        if(address.childNodes[0] != undefined){  
	        	if(document.getElementById("addr"))
	        		document.getElementById("addr").value = address.childNodes[0].nodeValue
	        }
	    
	        if(document.getElementById("stateId")){
	        	document.getElementById("stateId").selectedIndex = stateId.childNodes[0].nodeValue
	        	//populateDistrict(stateId.childNodes[0].nodeValue,'registration')
	        }
		
		   if(phoneNo.childNodes[0] !=undefined)
			   document.getElementById("phoneNo").value =phoneNo.childNodes[0].nodeValue
		   if(mobileNo.childNodes[0] !=undefined)
			   document.getElementById("mobileNo").value =mobileNo.childNodes[0].nodeValue
		 if(cityId.childNodes[0]!=undefined){
			   if(document.getElementById("cityId"))
			   document.getElementById("cityId").selectedIndex = cityId.childNodes[0].nodeValue;
		 }	
		  
   	} 
   }
 }
 var url=action
  
 xmlHttp.open("GET",url,true);
 xmlHttp.setRequestHeader("Content-Type", "text/xml");
 xmlHttp.send(null);
 
 
}
 
 
 function populatePatientDetailsHAL() {
	 
		/*var serviceTypeId = document.getElementById('serviceTypeId').value;*/
		var serviceNo = document.getElementById('serviceNoId').value;
		var serviceStatusId = document.getElementById('serviceStatusId').value;
	//	if(checkDob()){
		action="/hms/hms/registration?method=populatePatientDetailsHAL&serviceNo="+serviceNo+"&serviceStatusId="+serviceStatusId;	
		obj = eval('document.registration')
		       obj.action = action;
	    	   	 var url=action
	// }
var xmlHttp;
try {
 // Firefox, Opera 8.0+, Safari
 xmlHttp=new XMLHttpRequest();
}catch (e){
 // Internet Explorer
 try{
   xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
 }catch (e){
 	alert(e)
   try{
     xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
   }catch (e){
     alert("Your browser does not support AJAX!");
     return false;
   }
  }
}
 xmlHttp.onreadystatechange=function()
 {
   if(xmlHttp.readyState==4){
   	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
   	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	       var address  = item.getElementsByTagName("address")[0];
	       var blockId  = item.getElementsByTagName("blockId")[0];
	       var stateId  = item.getElementsByTagName("stateId")[0];
	       var cityId  = item.getElementsByTagName("cityId")[0];
	       var countryId  = item.getElementsByTagName("countryId")[0];
	       var pinCode  = item.getElementsByTagName("pinCode")[0];
	       var patientDistrict  = item.getElementsByTagName("patientDistrict")[0];
	       var postOff  = item.getElementsByTagName("postOff")[0];
	       var policeStation  = item.getElementsByTagName("policeStation")[0];
	       var phoneNo  = item.getElementsByTagName("phoneNo")[0];
	       var mobileNo  = item.getElementsByTagName("mobileNo")[0];
	         var religionId  = item.getElementsByTagName("religionId")[0];
	         
	         
	        if(address.childNodes[0] != undefined){  
	        	if(document.getElementById("addr"))
	        		document.getElementById("addr").value = address.childNodes[0].nodeValue
	        }
	    
	        if(document.getElementById("stateId")){
	        	document.getElementById("stateId").selectedIndex = stateId.childNodes[0].nodeValue
	        	//populateDistrict(stateId.childNodes[0].nodeValue,'registration')
	        }
		
		   if(phoneNo.childNodes[0] !=undefined)
			   document.getElementById("phoneNo").value =phoneNo.childNodes[0].nodeValue
		   if(mobileNo.childNodes[0] !=undefined)
			   document.getElementById("mobileNo").value =mobileNo.childNodes[0].nodeValue
		 if(cityId.childNodes[0]!=undefined){
			   if(document.getElementById("cityId"))
			   document.getElementById("cityId").selectedIndex = cityId.childNodes[0].nodeValue;
		 }	
		  
   	} 
   }
 }
 var url=action
  
 xmlHttp.open("GET",url,true);
 xmlHttp.setRequestHeader("Content-Type", "text/xml");
 xmlHttp.send(null);
 
 
}
 
function getDischargeDetails(serviceNo){
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		obj =document.getElementById("adNoId"); 
		obj.length = 1;
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var brandLength  = item.getElementsByTagName("adLists")[0];
	      
        	for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++){
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("adId")[0];
	        	var brandName  = brand.getElementsByTagName("adNo")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=brandId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=brandName.childNodes[0].nodeValue;
	        	
        	}
      	} 
      }
    }
   var url="/hms/hms/adt?method=getDischargeDetails&serviceNo="+serviceNo
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    

}

function getDetailsOfDischarge(inpatientId){
var admissionNo ="";
var obj = document.getElementById("adNoId");
var val = obj.value;
for(i=0;i<obj.length;i++)
{
	if(obj.options[i].value == val)
	{
		admissionNo = obj.options[i].text
		break;
	}
}

 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    
	   	    var item = items.childNodes[loop];
	      
	       var sName  = item.getElementsByTagName("sName")[0];
	       var pName  = item.getElementsByTagName("pName")[0];
	       var doa  = item.getElementsByTagName("doa")[0];
	       var relation  = item.getElementsByTagName("relation")[0];
	       var age  = item.getElementsByTagName("age")[0];
	       var sex  = item.getElementsByTagName("sex")[0];
		    var dId  = item.getElementsByTagName("dId")[0];
		    var hinId  = item.getElementsByTagName("hinId")[0];
		      var deptId  = item.getElementsByTagName("deptId")[0];
		      
		    
		   document.getElementById("sName").value = sName.childNodes[0].nodeValue
		   document.getElementById("pName").value = pName.childNodes[0].nodeValue
		   document.getElementById("doa").value = doa.childNodes[0].nodeValue
		   document.getElementById("relation").value = relation.childNodes[0].nodeValue
		   document.getElementById("age").value = age.childNodes[0].nodeValue
		   document.getElementById("sex").value = sex.childNodes[0].nodeValue
		    document.getElementById("hinId").value = hinId.childNodes[0].nodeValue
		    document.getElementById("deptId").value = deptId.childNodes[0].nodeValue
		    var url2="/hms/hms/adt?method=getDetailsOfDischarge2&inpatientId="+inpatientId+"&admissionNo="+admissionNo
		    submitProtoAjax('updateDischarge',url2);
        	}
      	} 
      }
  
   var url="/hms/hms/adt?method=getDetailsOfDischarge&inpatientId="+inpatientId+"&admissionNo="+admissionNo
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
}

function checkCancelAdmissionState(inpatientId,parentAdNo){
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var cancelState  = item.getElementsByTagName("cancelState")[0];
	        if(cancelState.childNodes[0].nodeValue =="no"){
	        	alert("Can not Cancel the Admission");
	        }else{
	      if(checkForCancel()){
	        submitForm('updateAdmission','/hms/hms/adt?method=cancelAdmissionInformation&parentAdNo='+parentAdNo);
	      }
	      
	        }
	      
        	
      	} 
      }
    }
   var url="/hms/hms/adt?method=checkCancelAdmissionState&inpatientId="+inpatientId
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    

}
	function checkRegNo(regNo,type){
	
	var regNo =trimAll(regNo);
	
	
	 var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var exists  = item.getElementsByTagName("exists")[0];
	      // alert("a::::;"+exists.childNodes[0].nodeValue);
	        if(exists.childNodes[0].nodeValue =="yes"){
	        
	        	alert("Registration No already Exists");
	        	document.getElementById("regId").value=""
	        	return true;
	        }
	   	} 
      }
    }
   var url="/hms/hms/mis?method=checkRegNo&regNo="+regNo+"&type="+type
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);

}
function checkForCancel()
{
		if(confirm("Are You sure, You want Cancel admission ?"))
			return true;
		else
			return false;
}

// Added by Kalyan
function displayUnitAddress(unitId){
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    
	   	    var item = items.childNodes[loop];
	      
	       var sUnitAddress  = item.getElementsByTagName("sUnitAddress")[0];
	       var sLocalUnit  = item.getElementsByTagName("sLocalUnit")[0];
	       document.getElementById("sUnitAddress").value = sUnitAddress.childNodes[0].nodeValue
		   if(sLocalUnit.childNodes[0].nodeValue == "y"){
		    document.getElementById("sLocalUnit").checked = true;
		   }else if(sLocalUnit.childNodes[0].nodeValue == "n"){
		    document.getElementById("sLocalUnit").checked = false; 
		   }
		   //document.getElementById("sLocalUnit").value = sLocalUnit.childNodes[0].nodeValue
		  //  var url2="/hms/hms/adt?method=getDetailsOfDischarge2&inpatientId="+inpatientId+"&admissionNo="+admissionNo
		   // submitProtoAjax('unitValidate',url2);
        	}
      }
    }
    var url="/hms/hms/adt?method=getNewUnitDetails&NewUnitId="+unitId
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
}

function populateHinNo(serviceNo){
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		obj =document.getElementById("hinNoId"); 
		obj.length = 1;
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var hinLength  = item.getElementsByTagName("hinLists")[0];
        	for(innerLoop = 0;innerLoop < hinLength.childNodes.length;innerLoop++){
        		var hin = hinLength.childNodes[innerLoop];
	        	var hinId  = hin.getElementsByTagName("hinId")[0];
	        	var hinNo  = hin.getElementsByTagName("hinNo")[0];
	        	obj.length++;
				obj.options[obj.length-1].value=hinId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=hinNo.childNodes[0].nodeValue;
	        	
        	}
      	} 
      }
    }
   var url="/hms/hms/mis?method=populateHinNo&serviceNo="+serviceNo
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
}


function getFRWDetails(hinId){
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var rank  = item.getElementsByTagName("rank")[0];
	       document.getElementById("rankName").value=rank.childNodes[0].nodeValue
	       
	        var trade  = item.getElementsByTagName("trade")[0];
	       document.getElementById("tradeName").value=trade.childNodes[0].nodeValue
	       
	        var pName  = item.getElementsByTagName("pName")[0];
	       document.getElementById("patientName").value=pName.childNodes[0].nodeValue
	       
	        var sex  = item.getElementsByTagName("sex")[0];
	       document.getElementById("sex").value=sex.childNodes[0].nodeValue
	       
	        var unit  = item.getElementsByTagName("unit")[0];
	       document.getElementById("unitName").value=unit.childNodes[0].nodeValue
	       
	        var hinId  = item.getElementsByTagName("hinId")[0];
	       document.getElementById("hinId").value=hinId.childNodes[0].nodeValue
      	} 
      }
    }
   var url="/hms/hms/mis?method=getFRWDetails&hinId="+hinId
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
}
// add by kalyan 


function populateEmpName(serviceNo){
	
	 document.getElementById("employeeId").value="";
     
     document.getElementById("employeeName").value="";
     
     document.getElementById("lastName").value=""
     
     
     document.getElementById("codeId").value="";
     document.getElementById("pwd").value="";
	
	  var xmlHttp;
	 if(trimAll(serviceNo) != ""){
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
	
	  	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	   
	   	    
	       var empName  = item.getElementsByTagName("employeeName")[0];
	       if(empName ==  undefined)
	    	   {
	    	   	alert("Employee No. does not exist.");
	    	   	return;
	    	   }
	       var lName = item.getElementsByTagName("lastName")[0];
	       var empId = item.getElementsByTagName("employeeId")[0];
	       var existuser = item.getElementsByTagName("existuser")[0];
	      
	       
	       //alert(existuser.childNodes[0].nodeValue);
	       if(existuser.childNodes[0].nodeValue == "true")
	    	   {
		    	   	alert("User already exist for this Employee No.");
		    	   	return;
	    	   }
	       
	      // document.getElementById("employeeName").value=empName.childNodes[0].nodeValue
	      //var valueOfCombo=empId.childNodes[0].nodeValue
	      //alert("empId.childNodes[0].nodeValue=="+empId.childNodes[0].nodeValue);
	       if(document.getElementById("employeeId"))
	       document.getElementById("employeeId").value=empId.childNodes[0].nodeValue;
	       
	       document.getElementById("employeeName").value=empName.childNodes[0].nodeValue;
	       if(document.getElementById("lastName").value!=''){
	       document.getElementById("lastName").value=lName.childNodes[0].nodeValue;
	       }
	       //document.getElementById("search_name").value=serviceNo;
	       document.getElementById("codeId").value=serviceNo;
	       document.getElementById("pwd").value=serviceNo;
	     
	       
	       
	   } 
      }
    }
   
   var url="/hms/hms/user?method=getEmpName&serviceNo="+serviceNo
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    }
}
 function ajaxFunctionForAutoCompletePVMS(formName,action) {
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	       
	        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	        var itemId  = item.getElementsByTagName("id")[0];
        	document.getElementById('pvmsNo').value = pvmsNo.childNodes[0].nodeValue
        	document.getElementById('itemId').value = itemId.childNodes[0].nodeValue
        	
      	} 
      }
    }
    var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
    function ajaxFunctionForAutoCompleteChargeCodeCode(formName,action) {
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var chargeCodes =xmlHttp.responseXML.getElementsByTagName('chargeCodes')[0];
      	
      	for (loop = 0; loop < chargeCodes.childNodes.length; loop++) {
	   	    var chargeCode = chargeCodes.childNodes[loop];
	       
	        var chargeCodeCode  = chargeCode.getElementsByTagName("chargeCodeCode")[0];
	        var chargeCodeId  = chargeCode.getElementsByTagName("id")[0];
        	document.getElementById('chargeCodeCode').value = chargeCodeCode.childNodes[0].nodeValue
        	document.getElementById('chargeCodeId').value = chargeCodeId.childNodes[0].nodeValue
        	
      	} 
      }
    }
    var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
  function add_more_upload() 
  {	
  	var new_total = Math.round(document.Uploader.TOTAL_FILE.value) + 1;	
  	document.getElementById('attach_'  + document.Uploader.TOTAL_FILE.value).innerHTML = "<input type='file' size='60' name='theFile[" +  new_total  + "]' /></p><p id='attach_" + new_total  + "'>";	
  	document.Uploader.TOTAL_FILE.value++;
  }
  
  function checkPatientVisit(){
	var hinId = document.getElementById('hinId').value;
	var visitDate = document.getElementById('visitDateId').value;
		
		action="/hms/hms/registration?method=checkPatientVisit";	
		obj = eval('document.visitByHin')
				
		       obj.action = action;
	    	   	 var url=action+"&hinId="+hinId+"&visitDate="+visitDate;
	        
	        	new Ajax.Updater('statusMessage',url,
				   {asynchronous:true, evalScripts:true }); 
				   return true;
	
	}
  
  

// ::::::::::::::this methos for pickup the data group wise in TenderCreation:::::::::::::::
function getImportProposals(groupId){
  
  if(trimAll(groupId) != ""){
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
    
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	   
	  	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    
	       var stp  = item.getElementsByTagName("STPStatus")[0];
	      
	      if(stp.childNodes[0].nodeValue == 'YES'){
	      document.getElementById('STP').style.display = 'inline';
	      }else if(stp.childNodes[0].nodeValue == 'NO'){
	      document.getElementById('STP').style.display = 'none';
	      }
	    //   document.getElementById("employeeName").value=empName.childNodes[0].nodeValue
	       
	   } 
      }
    }
   
   var url="/hms/hms/tender?method=getImportProposals&groupId="+groupId
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
   }
}
  /** code of phase 3 by abha **/
  /** code of phase 3 by abha **/
  function ajaxFunctionForMA(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	   
	   	    var servicePersonName = item.getElementsByTagName("servicePersonName")[0];
	   	    if(servicePersonName.childNodes[0].nodeValue != '-'){
	   	     document.getElementById('servicePersonName').value = servicePersonName.childNodes[0].nodeValue
	   	   }else{
	   	   alert('This Employee No Doesnot exist')
	   	   document.getElementById('servicePersonName').value = ""
	   	   document.getElementById('serviceNo').value = ""
	   	   return true;
	   	   }
	      
      	} 
      }
      }
       
    xmlHttp.open("GET",'accom?method=fillServiceNo&serviceNo='+document.getElementById("serviceNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
 function ajaxFunctionForAutoCompleteBook(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
   
      if(xmlHttp.readyState==4){
      
      	var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var bookId  = item.getElementsByTagName("bookId")[0];
	        var author = item.getElementsByTagName("author")[0];
	        var publisher =  item.getElementsByTagName("publisher")[0];
	        var publisherId =  item.getElementsByTagName("publisherId")[0];
	        var publication  = item.getElementsByTagName("publication")[0];
	        var edition =  item.getElementsByTagName("edition")[0];
	        document.getElementById('author'+rowVal).value =  author.childNodes[0].nodeValue
	        document.getElementById('bookId'+rowVal).value = bookId.childNodes[0].nodeValue
        	document.getElementById('publisher'+rowVal).value = publisher.childNodes[0].nodeValue
        	document.getElementById('publisherId'+rowVal).value = publisherId.childNodes[0].nodeValue
        	document.getElementById('publication'+rowVal).value = publication.childNodes[0].nodeValue
        	document.getElementById('edition'+rowVal).value = edition.childNodes[0].nodeValue
      	} 
      }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
  function ajaxFunctionForAutoCompleteForCRV(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
	 xmlHttp.onreadystatechange=function()
    {
   
      if(xmlHttp.readyState==4){
      
      	var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var bookId  = item.getElementsByTagName("bookId")[0];
	        var bookNo  = item.getElementsByTagName("bookNo")[0];
	        var author = item.getElementsByTagName("author")[0];
	        var publisher =  item.getElementsByTagName("publisher")[0];
	        var publisherId =  item.getElementsByTagName("publisherId")[0];
	        var publication  = item.getElementsByTagName("publication")[0];
	        var volume  = item.getElementsByTagName("volume")[0];
	        document.getElementById('bookId'+rowVal).value = bookId.childNodes[0].nodeValue
	        document.getElementById('bookNo'+rowVal).value = bookNo.childNodes[0].nodeValue
	        document.getElementById('author'+rowVal).value =  author.childNodes[0].nodeValue
	        document.getElementById('publisher'+rowVal).value = publisher.childNodes[0].nodeValue
        	document.getElementById('publisherId'+rowVal).value = publisherId.childNodes[0].nodeValue
        	document.getElementById('publication'+rowVal).value = publication.childNodes[0].nodeValue
        	//document.getElementById('volume'+rowVal).value = volume.childNodes[0].nodeValue
      	} 
      }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
  /** end of functions by Abha **/
  
  //blood bank
  function ajaxFunctionForTestPatient(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var name =  item.getElementsByTagName("name")[0];
	   	    var rankId = item.getElementsByTagName("rankId")[0];
	   	    var hinId = item.getElementsByTagName("hinId")[0];
	   	    var sexId = item.getElementsByTagName("sexId")[0];
	   	    var unitId =  item.getElementsByTagName("unitId")[0];
	   	    var relationId =  item.getElementsByTagName("relationId")[0];
	        var age = item.getElementsByTagName("age")[0];
	        var teleNo =  item.getElementsByTagName("teleNo")[0];
	        
        	document.getElementById('name').value = name.childNodes[0].nodeValue
        	document.getElementById('rankId').value = rankId.childNodes[0].nodeValue
        	document.getElementById('hinId').value = hinId.childNodes[0].nodeValue
        	document.getElementById('sexId').value = sexId.childNodes[0].nodeValue
        	document.getElementById('unitId').value = unitId.childNodes[0].nodeValue
        	document.getElementById('relationId').value = relationId.childNodes[0].nodeValue
        	document.getElementById('age').value = age.childNodes[0].nodeValue
        	document.getElementById('teleNo').value = teleNo.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'bloodBank?method=fillTestPatientDetail&serviceNo='+document.getElementById("serviceNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
   function ajaxFunctionForBagNoReaction(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var donorName = item.getElementsByTagName("donorName")[0];
	   	     var bloodGroupId = item.getElementsByTagName("bloodGroupId")[0];
	   	     var stockId = item.getElementsByTagName("stockId")[0];
	        
	        document.getElementById('donorName').value = donorName.childNodes[0].nodeValue
        	document.getElementById('bloodGroupId').value = bloodGroupId.childNodes[0].nodeValue
        	document.getElementById('stockId').value = stockId.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'bloodBank?method=fillBloodbagForReaction&bloodBagNo='+document.getElementById("bloodBagNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
  
   function ajaxFunctionServiceNo(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var employeeId = item.getElementsByTagName("employeeId")[0];
	   	    var name =  item.getElementsByTagName("name")[0];
	   	    var rankId = item.getElementsByTagName("rankId")[0];
	        
        	document.getElementById('employeeId').value = employeeId.childNodes[0].nodeValue
        	document.getElementById('name').value = name.childNodes[0].nodeValue
        	document.getElementById('rankId').value = rankId.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'lib?method=fillServiceDetail&serviceNo='+document.getElementById("serviceNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
   /** code of phase 3 by abha **/
 function ajaxFunctionForAutoCompleteBookName(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
   
      if(xmlHttp.readyState==4){
      
      	var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var bookId  = item.getElementsByTagName("bookId")[0];
	        var bookNo = item.getElementsByTagName("bookNo")[0];
	        document.getElementById('bookNo'+rowVal).value =  bookNo.childNodes[0].nodeValue
	        document.getElementById('bookId'+rowVal).value = bookId.childNodes[0].nodeValue
      	} 
      }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
   function ajaxFunctionForMA(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var servicePersonName = item.getElementsByTagName("servicePersonName")[0];
	        var rankId = item.getElementsByTagName("rankId")[0];
	        var tradeId =  item.getElementsByTagName("tradeId")[0];
	        var unitId =  item.getElementsByTagName("unitId")[0];
	         document.getElementById('servicePersonName').selectedIndex = servicePersonName.childNodes[0].nodeValue
	        document.getElementById('rankId').selectedIndex = rankId.childNodes[0].nodeValue
        	document.getElementById('tradeId').value = tradeId.childNodes[0].nodeValue
        	document.getElementById('unitId').value = unitId.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'accom?method=fillServiceNo&serviceNo='+document.getElementById("serviceNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
// end kalyan

//abha for library
 function ajaxFunctionForIssueNo(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var issueId = item.getElementsByTagName("issueId")[0];
	   	    var issueDate = item.getElementsByTagName("issueDate")[0];
	   	    var serviceNo =  item.getElementsByTagName("serviceNo")[0];
	   	    var name =  item.getElementsByTagName("name")[0];
	   	    var rankId = item.getElementsByTagName("rankId")[0];
	   	    var rankName = item.getElementsByTagName("rankName")[0];
	        
	        document.getElementById('issueId').value = issueId.childNodes[0].nodeValue
	        document.getElementById('issueDate').value = issueDate.childNodes[0].nodeValue
	        document.getElementById('serviceNo').value = serviceNo.childNodes[0].nodeValue
        	document.getElementById('name').value = name.childNodes[0].nodeValue
        	//document.getElementById('rankId').value = rankId.childNodes[0].nodeValue
        	
        	document.getElementById('rankId').value = rankName.childNodes[0].nodeValue
        	submitProtoAjaxWithDivName('bookReturn','lib?method=fillIssueBookDetail','abcd')
      	} 
      }
      }
       
    xmlHttp.open("GET",'lib?method=fillIssueDetail&issueNo='+document.getElementById("issueNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
   function ajaxFunctionForIssuedBook(formName,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var issueDtId = item.getElementsByTagName("issueDtId")[0];
	   	    var accountNo = item.getElementsByTagName("accountNo")[0];
	   	    var bookName =  item.getElementsByTagName("bookName")[0];
	   	    var quantity =  item.getElementsByTagName("quantity")[0];
	        
	        document.getElementById('issueDtId').value = issueDtId.childNodes[0].nodeValue
	        document.getElementById('accountNo').value = accountNo.childNodes[0].nodeValue
	        document.getElementById('bookName').value = bookName.childNodes[0].nodeValue
        	document.getElementById('quantity').value = quantity.childNodes[0].nodeValue
        	
      	} 
      }
      }
       
    xmlHttp.open("GET",'lib?method=fillIssueBookDetail&issueNo='+document.getElementById("issueNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  //end abha
  
  function ajaxFunctionForUnitAddress(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var unitId = item.getElementsByTagName("unitId")[0];
	   	    var unitAddress = item.getElementsByTagName("unitAddress")[0];
	        
	        document.getElementById('unitId').value = unitId.childNodes[0].nodeValue
	        document.getElementById('unitAddress').value = unitAddress.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'mediClaim?method=fillUnitAddress&unitName='+document.getElementById("unitName").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }// end depali for mediclaim
  
  //-----Function OF Blood Bank ---
  function ajaxFunctionForTestPatient(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var name =  item.getElementsByTagName("name")[0];
	   	    var rankId = item.getElementsByTagName("rankId")[0];
	   	    var hinId = item.getElementsByTagName("hinId")[0];
	   	    var sexId = item.getElementsByTagName("sexId")[0];
	   	    var unitId =  item.getElementsByTagName("unitId")[0];
	   	    var relationId =  item.getElementsByTagName("relationId")[0];
	        var age = item.getElementsByTagName("age")[0];
	        var teleNo =  item.getElementsByTagName("teleNo")[0];
	        
        	document.getElementById('name').value = name.childNodes[0].nodeValue
        	document.getElementById('rankId').value = rankId.childNodes[0].nodeValue
        	document.getElementById('hinId').value = hinId.childNodes[0].nodeValue
        	document.getElementById('sexId').value = sexId.childNodes[0].nodeValue
        	document.getElementById('unitId').value = unitId.childNodes[0].nodeValue
        	document.getElementById('relationId').value = relationId.childNodes[0].nodeValue
        	document.getElementById('age').value = age.childNodes[0].nodeValue
        	document.getElementById('teleNo').value = teleNo.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'bloodBank?method=fillTestPatientDetail&serviceNo='+document.getElementById("serviceNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }

   function ajaxFunctionForBagNoReaction(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var donorName = item.getElementsByTagName("donorName")[0];
	   	     var bloodGroupId = item.getElementsByTagName("bloodGroupId")[0];
	   	     var stockId = item.getElementsByTagName("stockId")[0];
	        
	        document.getElementById('donorName').value = donorName.childNodes[0].nodeValue
        	document.getElementById('bloodGroupId').value = bloodGroupId.childNodes[0].nodeValue
        	document.getElementById('stockId').value = stockId.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'bloodBank?method=fillBloodbagForReaction&bloodBagNo='+document.getElementById("bloodBagNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
 function ajaxFunctionForAutoCompleteComponentName(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var componentId  = item.getElementsByTagName("componentId")[0];
	      //  var componentCode  = item.getElementsByTagName("componentCode")[0];
			        var quantity = item.getElementsByTagName("quantity")[0];
			        
			        var expiryDate = item.getElementsByTagName("expiryDate")[0];
			     //    document.getElementById('componentCode'+rowVal).value =  componentCode.childNodes[0].nodeValue
			        document.getElementById('quantity'+rowVal).value =  quantity.childNodes[0].nodeValue
			        if(expiryDate.childNodes[0] != 'undefined')
			        	document.getElementById('expiryDate'+rowVal).value =  expiryDate.childNodes[0].nodeValue
			        document.getElementById('bloodComponentId'+rowVal).value = componentId.childNodes[0].nodeValue
		      	} 
	       }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
  function ajaxFunctionForAutoCompleteInvestigationName(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var investigationCodeId  = item.getElementsByTagName("investigationCodeId")[0];
	        document.getElementById('investigationId'+rowVal).value = investigationCodeId.childNodes[0].nodeValue
      	} 
      }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
   function ajaxFunctionForPatient(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var rankId = item.getElementsByTagName("rankId")[0];
	        var donerName =  item.getElementsByTagName("donerName")[0];
	        var hinId =  item.getElementsByTagName("hinId")[0];
	        var bloodGroupId =  item.getElementsByTagName("bloodGroupId")[0];
	        var unitAddress =  item.getElementsByTagName("unitAddress")[0];
	         document.getElementById('hinId').value = hinId.childNodes[0].nodeValue
	        document.getElementById('rankId').value = rankId.childNodes[0].nodeValue
        	document.getElementById('donerName').value = donerName.childNodes[0].nodeValue
        	document.getElementById('bloodGroupId').value = bloodGroupId.childNodes[0].nodeValue
        	document.getElementById('unitAddress').value = unitAddress.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'bloodBank?method=fillPatientDetail&serviceNo='+document.getElementById("serviceNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
  //-------Function for blood donor By dipali
 function ajaxFunctionForDonor(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var hinNo = item.getElementsByTagName("hinNo")[0];
	   	    var donorName =  item.getElementsByTagName("donorName")[0];
	   	    var rankId = item.getElementsByTagName("rankId")[0];
	   	     var occupId = item.getElementsByTagName("occupId")[0];
	   	    var hinId = item.getElementsByTagName("hinId")[0];
	   	    var sexId = item.getElementsByTagName("sexId")[0];
	   	    var unitAddress =  item.getElementsByTagName("unitAddress")[0];
	        var teleNo = item.getElementsByTagName("teleNo")[0];
	        var stateId = item.getElementsByTagName("stateId")[0];
	         var age = item.getElementsByTagName("age")[0];
	         var donorType=item.getElementsByTagName("donorType")[0];
	        
	        document.getElementById('hinNo').value = hinNo.childNodes[0].nodeValue
        	document.getElementById('donorName').value = donorName.childNodes[0].nodeValue
        	document.getElementById('rankId').value = rankId.childNodes[0].nodeValue
        	document.getElementById('occupId').value = occupId.childNodes[0].nodeValue
        	document.getElementById('hinId').value = hinId.childNodes[0].nodeValue
        	document.getElementById('sexId').value = sexId.childNodes[0].nodeValue
        	document.getElementById('unitAddress').value = unitAddress.childNodes[0].nodeValue
        	document.getElementById('teleNo').value = teleNo.childNodes[0].nodeValue
        	document.getElementById('stateId').value = stateId.childNodes[0].nodeValue
        	document.getElementById('age').value = age.childNodes[0].nodeValue
        	document.getElementById('donorType').value = donorType.childNodes[0].nodeValue
      	} 
      }
      }
       
    xmlHttp.open("GET",'bloodBank?method=fillDonorDetail&serviceNo='+document.getElementById("serviceNo").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }

 
 function ajaxFunctionForAutoCompleteUnitName(formName,action) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var unitId  = item.getElementsByTagName("unitId")[0];
	        var unitAddress  = item.getElementsByTagName("unitAddress")[0];
        	document.getElementById('unitId').value = unitId.childNodes[0].nodeValue
        	document.getElementById('unitAddress').value = unitAddress.childNodes[0].nodeValue
      	} 
      }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  
 function ajaxFunctionForAutoCompleteComponentNameForSeparition(formName,action,rowVal) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
     alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
       var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
       for (loop = 0; loop < items.childNodes.length; loop++) {
         var item = items.childNodes[loop];
         var componentId  = item.getElementsByTagName("componentId")[0];
       var componentCode  = item.getElementsByTagName("componentCode")[0];
         var quantity =  item.getElementsByTagName("quantity")[0];
       document.getElementById('componentCode'+rowVal).value =  componentCode.childNodes[0].nodeValue
         document.getElementById('quantity'+rowVal).value =  quantity.childNodes[0].nodeValue
         document.getElementById('bloodComponentId'+rowVal).value = componentId.childNodes[0].nodeValue
       } 
      }
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  //----End Of Function Of Blood Bank
  
  //added by vineet for complaint monitoring
  
  
  function ajaxFunctionForAutoCompleteComplaintNo(formName,action,rowVal,complaintId) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    { 
    var complaintNo ;
      if(xmlHttp.readyState==4){
       	var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    complaintNo  = item.getElementsByTagName("complaintNo")[0];
	        var complaintDate = item.getElementsByTagName("complaintDate")[0];
	       //document.getElementById(complaintId).value =  complaintNo.childNodes[0].nodeValue
	  
	        document.getElementById(rowVal).value = complaintDate.childNodes[0].nodeValue
      	}     
      	
      }    
      }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  //======= Add by Dipali for Pension Entry Form=============
  function ajaxFunctionForRetire(formName) {
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
 
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    var retierYear = item.getElementsByTagName("retierYear")[0];
	        document.getElementById('retierYear').value = retierYear.childNodes[0].nodeValue
      	} 
      }
      }
    xmlHttp.open("GET",'pension?method=fillRetier&designationId='+document.getElementById("designationId").value,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
  }
  function ajaxFunctionForAutoCompleteInLoanIn1(formName,action,rowVal) {
  var po_id = document.getElementById('poId').value
  var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
        
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	
      	var brandId="brandId"+rowVal;
		obj =document.getElementById(brandId); 
				
		var manufacturerId ="manufacturerId"+rowVal;
		obj1 =document.getElementById(manufacturerId); 
		
		
		var dispenseType ="dispenseType"+rowVal;
		
		obj2 = document.getElementById(dispenseType); 
	    
			
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        var expiry  = item.getElementsByTagName("expiry")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	        var DispType = item.getElementsByTagName("dispType")[0];
	        if(po_id != ""){
	        var poRate  = item.getElementsByTagName("poRate")[0];
	        var poTax = item.getElementsByTagName("poTax")[0];
	        var poDiscount = item.getElementsByTagName("poDiscount")[0];
	        var poDispType = item.getElementsByTagName("poDispType")[0];
	        var poMdqValue = item.getElementsByTagName("poMdqValue")[0];
	        var poRatePerMdq = item.getElementsByTagName("poRatePerMdq")[0];
	        var poBrandId = item.getElementsByTagName("poBrandId")[0];
	        var poManufacturerId = item.getElementsByTagName("poManufacturerId")[0];
	        var poFreeQty = item.getElementsByTagName("poFreeQty")[0];
	        var poFreeItem = item.getElementsByTagName("poFreeItem")[0];
	        }
	        var formula  = item.getElementsByTagName("formula")[0];
     		var conversionFactor  = item.getElementsByTagName("conversionFactor")[0];
	               
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('expiry'+rowVal).value = expiry.childNodes[0].nodeValue
        	document.getElementById('formula'+rowVal).value = formula.childNodes[0].nodeValue
			document.getElementById('conversionFactor'+rowVal).value = conversionFactor.childNodes[0].nodeValue
			
        	obj2.length=1;
        	obj2.options[obj2.length-1].value = DispType.childNodes[0].nodeValue;
        	obj2.options[obj2.length-1].text = DispType.childNodes[0].nodeValue;
        	
        	for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++)
        	{
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	var manufacturerId  = brand.getElementsByTagName("manufacturerId")[0];
	        	var manufacturerName = brand.getElementsByTagName("manufacturerName")[0];
	        	var brandOption = document.createElement("Option");
        		var manufactureOption  = document.createElement("Option");
	        	
				brandOption.value=brandId.childNodes[0].nodeValue;
				brandOption.text=brandName.childNodes[0].nodeValue;
						
				manufactureOption.value=manufacturerId.childNodes[0].nodeValue;
				manufactureOption.text=manufacturerName.childNodes[0].nodeValue;
				
				obj.appendChild(brandOption);
				obj1.appendChild(manufactureOption);
        	}
        	
        	if(po_id != ""){
        	document.getElementById('freeQty'+rowVal).value = poFreeQty.childNodes[0].nodeValue
        	document.getElementById('discountVar'+rowVal).value =poDiscount.childNodes[0].nodeValue
        	document.getElementById('taxVar'+rowVal).value =poTax.childNodes[0].nodeValue
        	document.getElementById('mdq'+rowVal).value =poMdqValue.childNodes[0].nodeValue
        	document.getElementById('ratePerMdq'+rowVal).value =poRatePerMdq.childNodes[0].nodeValue
        	}
        	
        	
        	var brandCombo = document.getElementById('brandId'+rowVal);
        	
        	for(var i=0;i<brandCombo.length;i++)
        	{
        		if (brandCombo[i].value == poBrandId.childNodes[0].nodeValue)
        			brandCombo.selectedIndex = i;
        	}
        	
        	
        	var manufacturerCombo = document.getElementById('manufacturerId'+rowVal);
        	
        	for(var i=0;i<manufacturerCombo.length;i++)
        	{
        		if (manufacturerCombo[i].value == poManufacturerId.childNodes[0].nodeValue)
        			manufacturerCombo.selectedIndex = i;
        	}
        	
        	var freeItemCombo = document.getElementById('freeItem'+rowVal);
        	
        	for(var i=0;i<freeItemCombo.length;i++)
        	{
        		if (freeItemCombo[i].value == poFreeItem.childNodes[0].nodeValue)
        			freeItemCombo.selectedIndex = i;
        	}
        	
        	
      	} 
      }
    }
   	 var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
  }
  //======= Add by Dipali for Pension Entry Form=============
  

//===========Function End=====================================

  //------------Function for certificate Stock taking---

  function getComputedStock(pvmsNo , StockTakingMId){
     
 	var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var cmpStock  = item.getElementsByTagName("cmpStock")[0];
	        
	       document.getElementById("cmpStock").value=cmpStock.childNodes[0].nodeValue
      	} 
      }
    }
   var url="/hms/hms/stores?method=onclickTotalItemWise&pvms="+pvmsNo+"&StockTakingMId="+StockTakingMId
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
}
  
  
  function getPrescriptionNo(formName,action){
	 
		var prescriptionNoObj = eval('document.'+formName+'.prescriptionNo')
		var servNo = prescriptionNoObj.value;
			errorMsg ="";
			ob1 = true;
			ob2 = true;
			ob3 = true;
			if(servNo != ""){
				obj = eval('document.'+formName)
				       	obj.action = action;
			    	   	 var url=action+"&"+getNameAndData(formName)
			        	
			        	new Ajax.Updater('prescriptionDiv',url,
						   {asynchronous:true, evalScripts:true }); 
			}	
			return true;
	}
  
  //---------End of---Function for certificate Stock taking---
  
  
  function getPatientDetails(action){
	 	var xmlHttp;
		  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	    var message = item.getElementsByTagName("message")[0];
		   	 //   if(message == undefined){
			        var depname  = item.getElementsByTagName("depname")[0];
			        var dob  = item.getElementsByTagName("dob")[0];
			      //  var empFName  = item.getElementsByTagName("empFName")[0];
			        //var empMName  = item.getElementsByTagName("empMName")[0];
			        //var empLName  = item.getElementsByTagName("empLName")[0];
			        var relation  = item.getElementsByTagName("relation")[0];
			      //  var rank  = item.getElementsByTagName("rank")[0];
			        //var unit  = item.getElementsByTagName("unit")[0];
			     //   var address  = item.getElementsByTagName("address")[0];
			        var gender  = item.getElementsByTagName("gender")[0];
			        var hinId = item.getElementsByTagName("hinId")[0];
			        
			        var depAge  = item.getElementsByTagName("depAge")[0];
			        var authority = item.getElementsByTagName("authority")[0];
			        var depDate = item.getElementsByTagName("depDate")[0];
			        var occupation = item.getElementsByTagName("occupation")[0];
			        var income = item.getElementsByTagName("income")[0];
			        
			        var pFName ="";
			        var pMName ="";
			        var pLName ="";
			       if((depname.childNodes[0].nodeValue).indexOf(' ') >= 0)
			        	pFName = (depname.childNodes[0].nodeValue).substring(0,(depname.childNodes[0].nodeValue).indexOf(' '))
			       else
			        	pFName = (depname.childNodes[0].nodeValue);
			       if((depname.childNodes[0].nodeValue).indexOf(' ') >= 0 && (depname.childNodes[0].nodeValue).lastIndexOf(' ') >=0)
			        	pMName = (depname.childNodes[0].nodeValue).substring((depname.childNodes[0].nodeValue).indexOf(' '),(depname.childNodes[0].nodeValue).lastIndexOf(' '))
			    
			        if((depname.childNodes[0].nodeValue).lastIndexOf(' ') >=0)
			             pLName = (depname.childNodes[0].nodeValue).substring((depname.childNodes[0].nodeValue).lastIndexOf(' '))
			       document.getElementById("pFirstNameId").value=pFName;
		           document.getElementById("pMiddleNameId").value=pMName;
		           document.getElementById("pLastNameId").value=pLName;
		           if(dob.childNodes[0]!=undefined){
		        	   document.getElementById("dobId").value=dob.childNodes[0].nodeValue;
		           }
			      /* document.getElementById("sFNameId").value=empFName.childNodes[0].nodeValue;
			       if(empMName.childNodes[0]!=undefined)
			    	   document.getElementById("sMNameId").value=empMName.childNodes[0].nodeValue;
			       if(empLName.childNodes[0]!=undefined)
			    	   document.getElementById("sLNameId").value=empLName.childNodes[0].nodeValue; */

			       document.getElementById("relationId").value=relation.childNodes[0].nodeValue;
			      /* if(document.getElementById("rankId"))
			    	   document.getElementById("rankId").value=rank.childNodes[0].nodeValue;
			       if(document.getElementById("unitId"))
			    	   document.getElementById("unitId").value=unit.childNodes[0].nodeValue;
			       if(address.childNodes[0]!=undefined)
			    	   document.getElementById("addr").value=address.childNodes[0].nodeValue;*/
			       if(gender.childNodes[0]!=undefined){
		    		   document.getElementById("gender").value=gender.childNodes[0].nodeValue;
			       }else{
			    	   document.getElementById("gender").value='0';
			       }
			       if(depAge.childNodes[0]!=undefined){
		    		   document.getElementById("ageId").value=depAge.childNodes[0].nodeValue;
			       }else{
			    	   document.getElementById("ageId").value='0';
			       }
			       if(authority.childNodes[0]!=undefined){
		    		   document.getElementById("authority").value=authority.childNodes[0].nodeValue;
			       }else{
			    	   document.getElementById("authority").value='';
			       }
			       if(depDate.childNodes[0]!=undefined){
		    		   document.getElementById("depDate").value=depDate.childNodes[0].nodeValue;
			       }else{
			    	   document.getElementById("depDate").value='';
			       }
			       if(occupation.childNodes[0]!=undefined){
		    		   document.getElementById("occupation").value=occupation.childNodes[0].nodeValue;
			       }else{
			    	   document.getElementById("occupation").value='';
			       }
			       if(income.childNodes[0]!=undefined){
		    		   document.getElementById("income").value=income.childNodes[0].nodeValue;
			       }else{
			    	   document.getElementById("income").value='';
			       }
			       document.getElementById("relationId").focus();
			       if(relation.childNodes[0].nodeValue!='8'){
			    	   document.getElementById("reportinForId").disabled = true;
			    	   document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,no');
			       }else{
			    	   document.getElementById("reportinForId").disabled = false;
			    	   document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,yes');
			       }
			      
			       if(message == undefined){
			    	  
			    	   getHin();
			       }else{
			    		document.getElementById('hinNoDivId').innerHTML='';
				    	document.getElementById('hinNoId').value='';
				    	if(hinId != undefined){
				    		document.getElementById('regHinId').value = hinId.childNodes[0].nodeValue;
				    	}
			       }
		   	  //  }else{
		   	  //  	alert(message.childNodes[0].nodeValue);
		   	  //  }
			      
	      	} 
	      }
	    }
	   var url=action+"&"+getNameAndData('registration');
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	}
// Dinesh  
  function ajaxFunctionForAutoCompleteOPDPatientInfo(formName,action,rowVal) {
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		       
		        var pvmsNo  = item.getElementsByTagName("pvms")[0];
		        var au  = item.getElementsByTagName("au")[0];
		        var itemId  = item.getElementsByTagName("itemId")[0];
		       
		        var strength = item.getElementsByTagName("strength")[0];
				var totalQty = item.getElementsByTagName("totalQty")[0];
				document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
				document.getElementById('au'+rowVal).value = au.childNodes[0].nodeValue
	        	document.getElementById('strength'+rowVal).value=strength.childNodes[0].nodeValue
	        	document.getElementById('stockAvailable'+rowVal).value=totalQty.childNodes[0].nodeValue	
	        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
	        	
				
				
	      	} 
	      }
	    }
	    var url=action+"&"+getNameAndData(formName)
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
  }
	   
  
	   
  
  function ajaxFunctionForAutoCompleteIssueToDispensary(formName,action,rowVal) {
	 
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	    	  var lotNo="lotNo"+rowVal;
	    	  
	    	  
	    	  obj = document.getElementById(lotNo);
				obj.length = 1;
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	//var stock =xmlHttp.responseXML.getElementsByTagName('items')[1];
	      	
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var id  = item.getElementsByTagName("id")[0];
		        var pvms  = item.getElementsByTagName("pvms")[0];
		        var au  = item.getElementsByTagName("au")[0];
		        var name  = item.getElementsByTagName("name")[0];
		        var BG  = item.getElementsByTagName("BrandG")[0];
		        var stock  = item.getElementsByTagName("stock")[0];
		        var batchLength  = item.getElementsByTagName("batches")[0];
	        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
	        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
	        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
	        	document.getElementById('issuedName'+rowVal).value = name.childNodes[0].nodeValue
	        	
	        	document.getElementById('issuedItemId'+rowVal).value = id.childNodes[0].nodeValue
	        	document.getElementById('idBG'+rowVal).value = BG.childNodes[0].nodeValue
	        	document.getElementById("qtyStock"+rowVal).value=stock.childNodes[0].nodeValue;
	        	for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
	        	{
	        		var batch = batchLength.childNodes[innerLoop];
		        	var batchId  = batch.getElementsByTagName("batchId")[0];
		        	var batchName  = batch.getElementsByTagName("batchName")[0];
		        	//alert(batchId.childNodes[0].nodeValue+"<<<abtch >  "+batchName.childNodes[0].nodeValue)
		        	obj.length++;
					//obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
		        	obj.options[obj.length-1].value=batchName.childNodes[0].nodeValue;
					obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
		        	
	        	}
	       
	        	
	      	} 
	      	
	     /* 	for (loop = 0; loop < stock.childNodes.length; loop++) 
	      	{
		   	    var stk = stock.childNodes[loop];
		   	    var stock_value = stk.getElementsByTagName("stk")[0];
		        alert(stock_value);
	      	} */
	      	
	      }
	    }
	   
	    //var url=action+"&"+getNameAndData(formName)
	    
	    var url=action;
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	    
	  }
  
  function displayPatientInfo(hinId){
	  
	 	var xmlHttp;
		  try {
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	document.getElementById('hinNoDivId').innerHTML='';
	    	document.getElementById('hinNoId').value='';
		      
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	  
			        var title  = item.getElementsByTagName("title")[0];
			        var fName  = item.getElementsByTagName("fName")[0];
			        var mName  = item.getElementsByTagName("mName")[0];
			        var lName  = item.getElementsByTagName("lastName")[0];
			        var sex  = item.getElementsByTagName("sex")[0];
			        var dob  = item.getElementsByTagName("dob")[0];
			        var age  = item.getElementsByTagName("age")[0];
			        var ageunit  = item.getElementsByTagName("ageunit")[0];
			        var occu  = item.getElementsByTagName("occu")[0];
			        var mrstatus  = item.getElementsByTagName("mrstatus")[0];
			        var relation  = item.getElementsByTagName("relation")[0];
			        var bldGrp  = item.getElementsByTagName("bldGrp")[0];
			        var add  = item.getElementsByTagName("add")[0];
			        var district  = item.getElementsByTagName("district")[0];
			        var state  = item.getElementsByTagName("state")[0];
			        var contactNo  = item.getElementsByTagName("contactNo")[0];
			        var income  = item.getElementsByTagName("income")[0];
			        var authority  = item.getElementsByTagName("authority")[0];
			        var depDate  = item.getElementsByTagName("depDate")[0];
			        var depRemovalDate  = item.getElementsByTagName("depRemovalDate")[0];
			        var visitNo  = item.getElementsByTagName("visitNo")[0];
			        var hinNo  = item.getElementsByTagName("hinNo")[0];
			       var famHisIds = item.getElementsByTagName("famHisIds")[0];
			       var mobileNo  = item.getElementsByTagName("mobileNo")[0];
			        var policeStation  = item.getElementsByTagName("policeStation")[0];
			        var pincode  = item.getElementsByTagName("pincode")[0];
			        var smokerLess10  = item.getElementsByTagName("smokerLess10")[0];
			       var smokerMore10 = item.getElementsByTagName("smokerMore10")[0];
			       var alcohol = item.getElementsByTagName("alcohol")[0];
			       var allergy = item.getElementsByTagName("allergy")[0];
			       var marriageDate = item.getElementsByTagName("marriageDate")[0];
			       var idMark1 = item.getElementsByTagName("idMark1")[0];
			       var idMark2 = item.getElementsByTagName("idMark2")[0];
			       var patientStatus = item.getElementsByTagName("patientStatus")[0];
			       
			       var nok1Name = item.getElementsByTagName("nok1Name")[0];
			       var nok1Relation = item.getElementsByTagName("nok1Relation")[0];
			       var nok1Contact = item.getElementsByTagName("nok1Contact")[0];
			       var nok1Address = item.getElementsByTagName("nok1Address")[0];
			       var nok1PoliceStn = item.getElementsByTagName("nok1PoliceStn")[0];
			       var nok1PinCode = item.getElementsByTagName("nok1PinCode")[0];
			       var nok2Name = item.getElementsByTagName("nok2Name")[0];
			       var nok2Relation = item.getElementsByTagName("nok2Relation")[0];
			       var nok2Contact = item.getElementsByTagName("nok2Contact")[0];
			       var nok2Address = item.getElementsByTagName("nok2Address")[0];
			       var nok2PoliceStn = item.getElementsByTagName("nok2PoliceStn")[0];
			       var nok2PinCode = item.getElementsByTagName("nok2PinCode")[0];
			       
			       document.getElementById("titleId").value=title.childNodes[0].nodeValue;
			       document.getElementById("pFirstNameId").value=fName.childNodes[0].nodeValue;
			     
			      if(mName.childNodes[0] !=undefined)
			    	   document.getElementById("pMiddleNameId").value=mName.childNodes[0].nodeValue;
			      else
			    	 document.getElementById("pMiddleNameId").value ="";
			      if(lName.childNodes[0] !=undefined)
			    	 document.getElementById("pLastNameId").value=lName.childNodes[0].nodeValue;
			      else
			    	 document.getElementById("pLastNameId").value = "";
			    	 
			       document.getElementById("gender").value=sex.childNodes[0].nodeValue;
		           if(dob.childNodes[0] !=undefined)
		        	   document.getElementById("dobId").value=dob.childNodes[0].nodeValue;
		           else
				    	 document.getElementById("dobId").value = "";
		           /*if(age.childNodes[0] !=undefined)
		        	   document.getElementById("ageId").value=age.childNodes[0].nodeValue;*/
		         /*  if(ageunit.childNodes[0] !=undefined)
		        	   document.getElementById("ageUnitId").selectedText=ageunit.childNodes[0].nodeValue;
		           if(document.getElementById("occupation")){
			           if(occu.childNodes[0] !=undefined)
			        	   document.getElementById("occupation").value=occu.childNodes[0].nodeValue;
			           else
					    	 document.getElementById("occupation").value = "";
	      			}	*/
		        /*   if(mrstatus.childNodes[0] !=undefined)
		        	   document.getElementById("mrstatus").value=mrstatus.childNodes[0].nodeValue;
		           else
				    	 document.getElementById("mrstatus").value = "";
			       document.getElementById("relationId").value=relation.childNodes[0].nodeValue;
			       */
			      /* if(relation.childNodes[0].nodeValue == '8'){
			    	   document.getElementById('reportinForId').disabled=false;
			   			document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,yes');
			       }else{
			    	   document.getElementById('reportinForId').disabled=true;
			   			document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,no');
			       }*/
			       
			       if(bldGrp.childNodes[0] !=undefined)
			    	   document.getElementById("bldGrp").value=bldGrp.childNodes[0].nodeValue;
			       else
				    	 document.getElementById("bldGrp").value = "";
			       if(document.getElementById("addr")){
				       if(add.childNodes[0] !=undefined)
				    	   document.getElementById("addr").value=add.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("addr").value = "";
			       }
			       if(document.getElementById("cityId")){
				       if(district.childNodes[0] !=undefined)
				    	   document.getElementById("cityId").value=district.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("cityId").value = "";
	      			}
			       if(document.getElementById("stateId")){
				       if(state.childNodes[0] !=undefined)
				    	   document.getElementById("stateId").value=state.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("stateId").value = "";
			       }
			       if(document.getElementById("contactNo")){
				       if(contactNo.childNodes[0] !=undefined)
				    	   document.getElementById("contactNo").value=contactNo.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("contactNo").value = "";
			       }
			       if(document.getElementById("income")){
				       if(income.childNodes[0] !=undefined)
				    	   document.getElementById("income").value=income.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("income").value = "";
			       }
			       if(document.getElementById("authority")){
				       if(authority.childNodes[0] !=undefined)
				    	   document.getElementById("authority").value=authority.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("authority").value = "";
			       }
			       if(document.getElementById("depDate")){
				       if(depDate.childNodes[0] !=undefined)
				    	   document.getElementById("depDate").value=depDate.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("depDate").value = "";
			       }
			       if(document.getElementById("depRemovalDate")){
				       if(depRemovalDate.childNodes[0] !=undefined)
				    	   document.getElementById("depRemovalDate").value=depRemovalDate.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("depRemovalDate").value = "";
			       }
			       
			       if(visitNo.childNodes[0] !=undefined)
			    	   document.getElementById("visitNo").value=visitNo.childNodes[0].nodeValue;
			       else
				       document.getElementById("visitNo").value = "";
			       if(document.getElementById('selfHinNo'))
			       document.getElementById('selfHinNo').value=hinNo.childNodes[0].nodeValue;
			    
			       document.getElementById('printHinNo').value = hinNo.childNodes[0].nodeValue;
			       
			       var obj = document.getElementById('familyHistory');
			       if(obj.length > 0){
				       for(var k=0; k<obj.length;k++)
				       {
				    	   obj[k].selected = false;
				       }
			       }
			       if(famHisIds.childNodes[0] !=undefined){

			    	   famHisId = famHisIds.childNodes[0].nodeValue;
			    	   bar = new Array();
			    	   bar  = famHisId.split(",");

			    	   if(obj.length > 0){
			    		   
			    		   for(var i=0;i<obj.length;i++){
			    			   for(var m=0; m<bar.length;m++)
			    			   {
			    				   if (obj[i].value == bar[m])
			    				   { 
			    					   obj[i].selected = true;
			    					   break;
			    				   }
			    			   }
			    		   }
			    	   }
			       }
			    
				    if(relation.childNodes[0].nodeValue == '8'){
				   		document.getElementById('medCatDiv').style.display='block';
				    }else{
				   		document.getElementById('medCatDiv').style.display='none';
				   	}
				    
				    if(document.getElementById("depmobileNo")){
					       if(mobileNo.childNodes[0] !=undefined)
					    	   document.getElementById("depmobileNo").value=mobileNo.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("depmobileNo").value = "";
				    }
				    if(document.getElementById("deppoliceStation")){
					       if(policeStation.childNodes[0] !=undefined)
					    	   document.getElementById("deppoliceStation").value=policeStation.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("deppoliceStation").value = "";
				    }
				    if(document.getElementById("deppinCode")){
					       if(pincode.childNodes[0] !=undefined)
					    	   document.getElementById("deppinCode").value=pincode.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("deppinCode").value = "";
				    }
				    if(document.getElementById("alcohol")){
					       if(alcohol.childNodes[0] !=undefined)
					    	   document.getElementById("alcohol").value=alcohol.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("alcohol").value = "";
				    }
				    
				    if(document.getElementById("smokerLess10")){
					       if(smokerLess10.childNodes[0] !=undefined && smokerLess10.childNodes[0].nodeValue=='y')
					    	   document.getElementById("smokerLess10").checked=true;
					       else
						    	 document.getElementById("smokerLess10").checked=false;
				    }
				    if(document.getElementById("smokerMore10")){
					       if(smokerMore10.childNodes[0] !=undefined && smokerMore10.childNodes[0].nodeValue=='y')
					    	   document.getElementById("smokerMore10").checked=true;
					       else
						    	 document.getElementById("smokerMore10").checked=false;
				    }
				    if(document.getElementById("allergies")){
					       if(allergy.childNodes[0] !=undefined)
					   	   document.getElementById("allergies").value=allergy.childNodes[0].nodeValue;
					       else
						    document.getElementById("allergies").value = "";
				   }
			
				    if(document.getElementById("depMarriageDateId")){
					       if(marriageDate.childNodes[0] !=undefined)
					   	   document.getElementById("depMarriageDateId").value=marriageDate.childNodes[0].nodeValue;
					       else
						    document.getElementById("depMarriageDateId").value = "";
				   }
				    if(document.getElementById("depIdentificationMark1")){
					       if(idMark1.childNodes[0] !=undefined)
					   	   document.getElementById("depIdentificationMark1").value=idMark1.childNodes[0].nodeValue;
					       else
						    document.getElementById("depIdentificationMark1").value = "";
				   }
				    if(document.getElementById("depIdentificationMark2")){
					       if(idMark2.childNodes[0] !=undefined)
					   	   document.getElementById("depIdentificationMark2").value=idMark2.childNodes[0].nodeValue;
					       else
						    document.getElementById("depIdentificationMark2").value = "";
				   }
				   if(document.getElementById("patientStatus")){
				       if(patientStatus.childNodes[0] !=undefined)
				   	   document.getElementById("patientStatus").value=patientStatus.childNodes[0].nodeValue;
				       else
					    document.getElementById("patientStatus").value = "";
				  }
				   if(document.getElementById("nokNameId")){
				       if(nok1Name.childNodes[0] !=undefined)
				    	   document.getElementById("nokNameId").value=nok1Name.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nokNameId").value = "";
			       }
				   if(document.getElementById("relId")){
				       if(nok1Relation.childNodes[0] !=undefined)
				    	   document.getElementById("relId").value=nok1Relation.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("relId").value = "";
			       }
				  
				   if(document.getElementById("nok1Phone")){
				       if(nok1Contact.childNodes[0] !=undefined)
				    	   document.getElementById("nok1Phone").value=nok1Contact.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1Phone").value = "";
			       }
				   if(document.getElementById("nextOfKinAdd")){
				       if(nok1Address.childNodes[0] !=undefined)
				    	   document.getElementById("nextOfKinAdd").value=nok1Address.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nextOfKinAdd").value = "";
			       }
				   if(document.getElementById("nok1PoliceStation")){
				       if(nok1PoliceStn.childNodes[0] !=undefined)
				    	   document.getElementById("nok1PoliceStation").value=nok1PoliceStn.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1PoliceStation").value = "";
			       }
				   if(document.getElementById("nok1PinCode")){
				       if(nok1PinCode.childNodes[0] !=undefined)
				    	   document.getElementById("nok1PinCode").value=nok1PinCode.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1PinCode").value = "";
			       }
				   
				   if(document.getElementById("nok2NameId")){
				       if(nok2Name.childNodes[0] !=undefined)
				    	   document.getElementById("nok2NameId").value=nok2Name.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2NameId").value = "";
			       }
				   if(document.getElementById("nok2RelId")){
				       if(nok2Relation.childNodes[0] !=undefined)
				    	   document.getElementById("nok2RelId").value=nok2Relation.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2RelId").value = "";
			       }
				   if(document.getElementById("nok2Contact")){
				       if(nok2Contact.childNodes[0] !=undefined)
				    	   document.getElementById("nok2Contact").value=nok2Contact.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2Contact").value = "";
			       }
				   if(document.getElementById("nok2Add")){
				       if(nok2Address.childNodes[0] !=undefined)
				    	   document.getElementById("nok2Add").value=nok2Address.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2Add").value = "";
			       }
				   if(document.getElementById("nok2PoliceStation")){
				       if(nok2PoliceStn.childNodes[0] !=undefined)
				    	   document.getElementById("nok2PoliceStation").value=nok2PoliceStn.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2PoliceStation").value = "";
			       }
				   if(document.getElementById("nok2PinCode")){
				       if(nok2PinCode.childNodes[0] !=undefined)
				    	   document.getElementById("nok2PinCode").value=nok2PinCode.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2PinCode").value = "";
			       }
				   
	      	} 
	      }
	    }
 		document.getElementById('regHinId').value=hinId;
	   var url='/hms/hms/registration?method=displayPatientInfo&hinId='+hinId;
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);

	  
  }
  
  function displayPatientInfoHALForFAC(hinId){
	  
	 	var xmlHttp;
		  try {
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      /*	document.getElementById('hinNoDivId').innerHTML='';
	    	document.getElementById('hinNoId').value='';*/
		      
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	  
//			        var title  = item.getElementsByTagName("title")[0];
			        var fName  = item.getElementsByTagName("fName")[0];
			        var mName  = item.getElementsByTagName("mName")[0];
			        var lName  = item.getElementsByTagName("lastName")[0];
			        var sex  = item.getElementsByTagName("sex")[0];
			        var dob  = item.getElementsByTagName("dob")[0];
			        var age  = item.getElementsByTagName("age")[0];
			        var ageunit  = item.getElementsByTagName("ageunit")[0];
			        var occu  = item.getElementsByTagName("occu")[0];
			        var mrstatus  = item.getElementsByTagName("mrstatus")[0];
			        var relation  = item.getElementsByTagName("relation")[0];
			        var bldGrp  = item.getElementsByTagName("bldGrp")[0];
			        var add  = item.getElementsByTagName("add")[0];
			        var district  = item.getElementsByTagName("district")[0];
			        var state  = item.getElementsByTagName("state")[0];
			        var contactNo  = item.getElementsByTagName("contactNo")[0];
			        var income  = item.getElementsByTagName("income")[0];
			        var authority  = item.getElementsByTagName("authority")[0];
			        var depDate  = item.getElementsByTagName("depDate")[0];
			        var depRemovalDate  = item.getElementsByTagName("depRemovalDate")[0];
			        var visitNo  = item.getElementsByTagName("visitNo")[0];
			        var hinNo  = item.getElementsByTagName("hinNo")[0];
			       var famHisIds = item.getElementsByTagName("famHisIds")[0];
			       var mobileNo  = item.getElementsByTagName("mobileNo")[0];
			        var policeStation  = item.getElementsByTagName("policeStation")[0];
			        var pincode  = item.getElementsByTagName("pincode")[0];
			        var smokerLess10  = item.getElementsByTagName("smokerLess10")[0];
			       var smokerMore10 = item.getElementsByTagName("smokerMore10")[0];
			       var alcohol = item.getElementsByTagName("alcohol")[0];
			       var allergy = item.getElementsByTagName("allergy")[0];
			       var marriageDate = item.getElementsByTagName("marriageDate")[0];
			       var idMark1 = item.getElementsByTagName("idMark1")[0];
			       var idMark2 = item.getElementsByTagName("idMark2")[0];
			       var patientStatus = item.getElementsByTagName("patientStatus")[0];
			       
			       var nok1Name = item.getElementsByTagName("nok1Name")[0];
			       var nok1Relation = item.getElementsByTagName("nok1Relation")[0];
			       var nok1Contact = item.getElementsByTagName("nok1Contact")[0];
			       var nok1Address = item.getElementsByTagName("nok1Address")[0];
			       var nok1PoliceStn = item.getElementsByTagName("nok1PoliceStn")[0];
			       var nok1PinCode = item.getElementsByTagName("nok1PinCode")[0];
			       var nok2Name = item.getElementsByTagName("nok2Name")[0];
			       var nok2Relation = item.getElementsByTagName("nok2Relation")[0];
			       var nok2Contact = item.getElementsByTagName("nok2Contact")[0];
			       var nok2Address = item.getElementsByTagName("nok2Address")[0];
			       var nok2PoliceStn = item.getElementsByTagName("nok2PoliceStn")[0];
			       var nok2PinCode = item.getElementsByTagName("nok2PinCode")[0];
			       var bloodGroupId = item.getElementsByTagName("bloodGroupId")[0];
			       
			       
			       
			     /*  document.getElementById("pFirstNameId").value=fName.childNodes[0].nodeValue;
			     
			      if(mName.childNodes[0] !=undefined)
			    	   document.getElementById("pMiddleNameId").value=mName.childNodes[0].nodeValue;
			      else
			    	 document.getElementById("pMiddleNameId").value ="";
			      if(lName.childNodes[0] !=undefined)
			    	 document.getElementById("pLastNameId").value=lName.childNodes[0].nodeValue;
			      else
			    	 document.getElementById("pLastNameId").value = "";
			    	 
			       document.getElementById("gender").value=sex.childNodes[0].nodeValue;
		           if(dob.childNodes[0] !=undefined)
		        	   document.getElementById("dobId").value=dob.childNodes[0].nodeValue;
		           else
				    	 document.getElementById("dobId").value = "";
		         
			       
			       if(bldGrp.childNodes[0] !=undefined)
			    	   document.getElementById("bldGrp").value=bldGrp.childNodes[0].nodeValue;
			       else
				    	 document.getElementById("bldGrp").value = "";
			       
			       
			       if(bloodGroupId !=undefined)
			    	   document.getElementById("bloodGroupId").value=bloodGroupId.innerHTML;
			       else
				    	 document.getElementById("bloodGroupId").value = "";
			       
			       if(document.getElementById("addr")){
				       if(add.childNodes[0] !=undefined)
				    	   document.getElementById("addr").value=add.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("addr").value = "";
			       }
			       if(document.getElementById("cityId")){
				       if(district.childNodes[0] !=undefined)
				    	   document.getElementById("cityId").value=district.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("cityId").value = "";
	      			}
			       if(document.getElementById("stateId")){
				       if(state.childNodes[0] !=undefined)
				    	   document.getElementById("stateId").value=state.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("stateId").value = "";
			       }
			       if(document.getElementById("contactNo")){
				       if(contactNo.childNodes[0] !=undefined)
				    	   document.getElementById("contactNo").value=contactNo.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("contactNo").value = "";
			       }
			       if(document.getElementById("income")){
				       if(income.childNodes[0] !=undefined)
				    	   document.getElementById("income").value=income.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("income").value = "";
			       }
			       if(document.getElementById("authority")){
				       if(authority.childNodes[0] !=undefined)
				    	   document.getElementById("authority").value=authority.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("authority").value = "";
			       }
			       if(document.getElementById("depDate")){
				       if(depDate.childNodes[0] !=undefined)
				    	   document.getElementById("depDate").value=depDate.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("depDate").value = "";
			       }
			       if(document.getElementById("depRemovalDate")){
				       if(depRemovalDate.childNodes[0] !=undefined)
				    	   document.getElementById("depRemovalDate").value=depRemovalDate.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("depRemovalDate").value = "";
			       }
			       
			       if(visitNo.childNodes[0] !=undefined)
			    	   document.getElementById("visitNo").value=visitNo.childNodes[0].nodeValue;
			       else
				       document.getElementById("visitNo").value = "";
			    
			       
			       var obj = document.getElementById('familyHistory');
			       if(obj.length > 0){
				       for(var k=0; k<obj.length;k++)
				       {
				    	   obj[k].selected = false;
				       }
			       }
			       if(famHisIds.childNodes[0] !=undefined){

			    	   famHisId = famHisIds.childNodes[0].nodeValue;
			    	   bar = new Array();
			    	   bar  = famHisId.split(",");

			    	   if(obj.length > 0){
			    		   
			    		   for(var i=0;i<obj.length;i++){
			    			   for(var m=0; m<bar.length;m++)
			    			   {
			    				   if (obj[i].value == bar[m])
			    				   { 
			    					   obj[i].selected = true;
			    					   break;
			    				   }
			    			   }
			    		   }
			    	   }
			       }*/
			    
			
				    
				  /*  if(document.getElementById("depmobileNo")){
					       if(mobileNo.childNodes[0] !=undefined)
					    	   document.getElementById("depmobileNo").value=mobileNo.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("depmobileNo").value = "";
				    }
				    if(document.getElementById("deppoliceStation")){
					       if(policeStation.childNodes[0] !=undefined)
					    	   document.getElementById("deppoliceStation").value=policeStation.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("deppoliceStation").value = "";
				    }
				    if(document.getElementById("deppinCode")){
					       if(pincode.childNodes[0] !=undefined)
					    	   document.getElementById("deppinCode").value=pincode.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("deppinCode").value = "";
				    }
				    if(document.getElementById("alcohol")){
					       if(alcohol.childNodes[0] !=undefined)
					    	   document.getElementById("alcohol").value=alcohol.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("alcohol").value = "";
				    }
				    
				    if(document.getElementById("smokerLess10")){
					       if(smokerLess10.childNodes[0] !=undefined && smokerLess10.childNodes[0].nodeValue=='y')
					    	   document.getElementById("smokerLess10").checked=true;
					       else
						    	 document.getElementById("smokerLess10").checked=false;
				    }
				    if(document.getElementById("smokerMore10")){
					       if(smokerMore10.childNodes[0] !=undefined && smokerMore10.childNodes[0].nodeValue=='y')
					    	   document.getElementById("smokerMore10").checked=true;
					       else
						    	 document.getElementById("smokerMore10").checked=false;
				    }
				    if(document.getElementById("allergies")){
					       if(allergy.childNodes[0] !=undefined)
					   	   document.getElementById("allergies").value=allergy.childNodes[0].nodeValue;
					       else
						    document.getElementById("allergies").value = "";
				   }
			
				    if(document.getElementById("depMarriageDateId")){
					       if(marriageDate.childNodes[0] !=undefined)
					   	   document.getElementById("depMarriageDateId").value=marriageDate.childNodes[0].nodeValue;
					       else
						    document.getElementById("depMarriageDateId").value = "";
				   }
				    if(document.getElementById("depIdentificationMark1")){
					       if(idMark1.childNodes[0] !=undefined)
					   	   document.getElementById("depIdentificationMark1").value=idMark1.childNodes[0].nodeValue;
					       else
						    document.getElementById("depIdentificationMark1").value = "";
				   }
				    if(document.getElementById("depIdentificationMark2")){
					       if(idMark2.childNodes[0] !=undefined)
					   	   document.getElementById("depIdentificationMark2").value=idMark2.childNodes[0].nodeValue;
					       else
						    document.getElementById("depIdentificationMark2").value = "";
				   }
				   if(document.getElementById("patientStatus")){
				       if(patientStatus.childNodes[0] !=undefined)
				   	   document.getElementById("patientStatus").value=patientStatus.childNodes[0].nodeValue;
				       else
					    document.getElementById("patientStatus").value = "";
				  }
				   if(document.getElementById("nokNameId")){
				       if(nok1Name.childNodes[0] !=undefined)
				    	   document.getElementById("nokNameId").value=nok1Name.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nokNameId").value = "";
			       }
				   if(document.getElementById("relId")){
				       if(nok1Relation.childNodes[0] !=undefined)
				    	   document.getElementById("relId").value=nok1Relation.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("relId").value = "";
			       }
				  
				   if(document.getElementById("nok1Phone")){
				       if(nok1Contact.childNodes[0] !=undefined)
				    	   document.getElementById("nok1Phone").value=nok1Contact.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1Phone").value = "";
			       }
				   if(document.getElementById("nextOfKinAdd")){
				       if(nok1Address.childNodes[0] !=undefined)
				    	   document.getElementById("nextOfKinAdd").value=decodeURIComponent(nok1Address.childNodes[0].nodeValue);
				       else
					    	 document.getElementById("nextOfKinAdd").value = "";
			       }
				   if(document.getElementById("nok1PoliceStation")){
				       if(nok1PoliceStn.childNodes[0] !=undefined)
				    	   document.getElementById("nok1PoliceStation").value=nok1PoliceStn.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1PoliceStation").value = "";
			       }
				   if(document.getElementById("nok1PinCode")){
				       if(nok1PinCode.childNodes[0] !=undefined)
				    	   document.getElementById("nok1PinCode").value=nok1PinCode.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1PinCode").value = "";
			       }
				   
				   if(document.getElementById("nok2NameId")){
				       if(nok2Name.childNodes[0] !=undefined)
				    	   document.getElementById("nok2NameId").value=nok2Name.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2NameId").value = "";
			       }
				   if(document.getElementById("nok2RelId")){
				       if(nok2Relation.childNodes[0] !=undefined)
				    	   document.getElementById("nok2RelId").value=nok2Relation.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2RelId").value = "";
			       }
				   
				   if(document.getElementById("nok2Contact")){
				       if(nok2Contact.childNodes[0] !=undefined)
				    	   document.getElementById("nok2Contact").value=nok2Contact.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2Contact").value = "";
			       }
				   if(document.getElementById("nok2Add")){
				       if(nok2Address.childNodes[0] !=undefined)
				    	   document.getElementById("nok2Add").value=decodeURIComponent(nok2Address.childNodes[0].nodeValue);
				       else
					    	 document.getElementById("nok2Add").value = "";
			       }
				   if(document.getElementById("nok2PoliceStation")){
				       if(nok2PoliceStn.childNodes[0] !=undefined)
				    	   document.getElementById("nok2PoliceStation").value=nok2PoliceStn.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2PoliceStation").value = "";
			       }
				   if(document.getElementById("nok2PinCode")){
				       if(nok2PinCode.childNodes[0] !=undefined)
				    	   document.getElementById("nok2PinCode").value=nok2PinCode.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2PinCode").value = "";
			       }*/
				   
	      	} 
	     
	      	/*getHinHAL('visitEmployee', hinId);*/
	      /*	document.getElementById("dobId").onblur();*/
	      }
	    }
		/*document.getElementById('regHinId').value=hinId;*/	   
		var serviceNo = document.getElementById('serviceNo').value;
	   var url='/hms/hms/registration?method=displayPatientInfoHAL&hinId='+hinId+'&serviceNo='+serviceNo;
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    

	  
}
  
  function displayPatientInfoHAL(hinId){
	  
	 	var xmlHttp;
		  try {
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	document.getElementById('hinNoDivId').innerHTML='';
	    	document.getElementById('hinNoId').value='';
		      
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	  
//			        var title  = item.getElementsByTagName("title")[0];
			        var fName  = item.getElementsByTagName("fName")[0];
			        var mName  = item.getElementsByTagName("mName")[0];
			        var lName  = item.getElementsByTagName("lastName")[0];
			        var sex  = item.getElementsByTagName("sex")[0];
			        var dob  = item.getElementsByTagName("dob")[0];
			        var age  = item.getElementsByTagName("age")[0];
			        var ageunit  = item.getElementsByTagName("ageunit")[0];
			        var occu  = item.getElementsByTagName("occu")[0];
			        var mrstatus  = item.getElementsByTagName("mrstatus")[0];
			        var relation  = item.getElementsByTagName("relation")[0];
			        var bldGrp  = item.getElementsByTagName("bldGrp")[0];
			        var add  = item.getElementsByTagName("add")[0];
			        var district  = item.getElementsByTagName("district")[0];
			        var state  = item.getElementsByTagName("state")[0];
			        var contactNo  = item.getElementsByTagName("contactNo")[0];
			        var income  = item.getElementsByTagName("income")[0];
			        var authority  = item.getElementsByTagName("authority")[0];
			        var depDate  = item.getElementsByTagName("depDate")[0];
			        var depRemovalDate  = item.getElementsByTagName("depRemovalDate")[0];
			        var visitNo  = item.getElementsByTagName("visitNo")[0];
			        var hinNo  = item.getElementsByTagName("hinNo")[0];
			       var famHisIds = item.getElementsByTagName("famHisIds")[0];
			       var mobileNo  = item.getElementsByTagName("mobileNo")[0];
			        var policeStation  = item.getElementsByTagName("policeStation")[0];
			        var pincode  = item.getElementsByTagName("pincode")[0];
			        var smokerLess10  = item.getElementsByTagName("smokerLess10")[0];
			       var smokerMore10 = item.getElementsByTagName("smokerMore10")[0];
			       var alcohol = item.getElementsByTagName("alcohol")[0];
			       var allergy = item.getElementsByTagName("allergy")[0];
			       var marriageDate = item.getElementsByTagName("marriageDate")[0];
			       var idMark1 = item.getElementsByTagName("idMark1")[0];
			       var idMark2 = item.getElementsByTagName("idMark2")[0];
			       var patientStatus = item.getElementsByTagName("patientStatus")[0];
			       
			       var nok1Name = item.getElementsByTagName("nok1Name")[0];
			       var nok1Relation = item.getElementsByTagName("nok1Relation")[0];
			       var nok1Contact = item.getElementsByTagName("nok1Contact")[0];
			       var nok1Address = item.getElementsByTagName("nok1Address")[0];
			       var nok1PoliceStn = item.getElementsByTagName("nok1PoliceStn")[0];
			       var nok1PinCode = item.getElementsByTagName("nok1PinCode")[0];
			       var nok2Name = item.getElementsByTagName("nok2Name")[0];
			       var nok2Relation = item.getElementsByTagName("nok2Relation")[0];
			       var nok2Contact = item.getElementsByTagName("nok2Contact")[0];
			       var nok2Address = item.getElementsByTagName("nok2Address")[0];
			       var nok2PoliceStn = item.getElementsByTagName("nok2PoliceStn")[0];
			       var nok2PinCode = item.getElementsByTagName("nok2PinCode")[0];
			       var bloodGroupId = item.getElementsByTagName("bloodGroupId")[0];
			       
			       
			       /*document.getElementById("titleId").value=title.childNodes[0].nodeValue;*/
			       document.getElementById("pFirstNameId").value=fName.childNodes[0].nodeValue;
			     
			      if(mName.childNodes[0] !=undefined)
			    	   document.getElementById("pMiddleNameId").value=mName.childNodes[0].nodeValue;
			      else
			    	 document.getElementById("pMiddleNameId").value ="";
			      if(lName.childNodes[0] !=undefined)
			    	 document.getElementById("pLastNameId").value=lName.childNodes[0].nodeValue;
			      else
			    	 document.getElementById("pLastNameId").value = "";
			    	 
			       document.getElementById("gender").value=sex.childNodes[0].nodeValue;
		           if(dob.childNodes[0] !=undefined)
		        	   document.getElementById("dobId").value=dob.childNodes[0].nodeValue;
		           else
				    	 document.getElementById("dobId").value = "";
		           /*if(age.childNodes[0] !=undefined)
		        	   document.getElementById("ageId").value=age.childNodes[0].nodeValue;*/
		         /*  if(ageunit.childNodes[0] !=undefined)
		        	   document.getElementById("ageUnitId").selectedText=ageunit.childNodes[0].nodeValue;
		           if(document.getElementById("occupation")){
			           if(occu.childNodes[0] !=undefined)
			        	   document.getElementById("occupation").value=occu.childNodes[0].nodeValue;
			           else
					    	 document.getElementById("occupation").value = "";
	      			}	*/
		        /*   if(mrstatus.childNodes[0] !=undefined)
		        	   document.getElementById("mrstatus").value=mrstatus.childNodes[0].nodeValue;
		           else
				    	 document.getElementById("mrstatus").value = "";
			       document.getElementById("relationId").value=relation.childNodes[0].nodeValue;
			       */
			      /* if(relation.childNodes[0].nodeValue == '8'){
			    	   document.getElementById('reportinForId').disabled=false;
			   			document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,yes');
			       }else{
			    	   document.getElementById('reportinForId').disabled=true;
			   			document.getElementById('reportinForId').setAttribute('validate','Reporting For,string,no');
			       }*/
			       
			       if(bldGrp.childNodes[0] !=undefined)
			    	   document.getElementById("bldGrp").value=bldGrp.childNodes[0].nodeValue;
			       else
				    	 document.getElementById("bldGrp").value = "";
			       
			       
			       if(bloodGroupId !=undefined)
			    	   document.getElementById("bloodGroupId").value=bloodGroupId.innerHTML;
			       else
				    	 document.getElementById("bloodGroupId").value = "";
			       
			       if(document.getElementById("addr")){
				       if(add.childNodes[0] !=undefined)
				    	   document.getElementById("addr").value=add.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("addr").value = "";
			       }
			       if(document.getElementById("cityId")){
				       if(district.childNodes[0] !=undefined)
				    	   document.getElementById("cityId").value=district.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("cityId").value = "";
	      			}
			       if(document.getElementById("stateId")){
				       if(state.childNodes[0] !=undefined)
				    	   document.getElementById("stateId").value=state.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("stateId").value = "";
			       }
			       if(document.getElementById("contactNo")){
				       if(contactNo.childNodes[0] !=undefined)
				    	   document.getElementById("contactNo").value=contactNo.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("contactNo").value = "";
			       }
			       if(document.getElementById("income")){
				       if(income.childNodes[0] !=undefined)
				    	   document.getElementById("income").value=income.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("income").value = "";
			       }
			       if(document.getElementById("authority")){
				       if(authority.childNodes[0] !=undefined)
				    	   document.getElementById("authority").value=authority.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("authority").value = "";
			       }
			       if(document.getElementById("depDate")){
				       if(depDate.childNodes[0] !=undefined)
				    	   document.getElementById("depDate").value=depDate.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("depDate").value = "";
			       }
			       if(document.getElementById("depRemovalDate")){
				       if(depRemovalDate.childNodes[0] !=undefined)
				    	   document.getElementById("depRemovalDate").value=depRemovalDate.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("depRemovalDate").value = "";
			       }
			       
			       if(visitNo.childNodes[0] !=undefined)
			    	   document.getElementById("visitNo").value=visitNo.childNodes[0].nodeValue;
			       else
				       document.getElementById("visitNo").value = "";
			      /* if(document.getElementById('selfHinNo'))
			       document.getElementById('selfHinNo').value=hinNo.childNodes[0].nodeValue;
			    
			       document.getElementById('printHinNo').value = hinNo.childNodes[0].nodeValue;*/
			       
			       var obj = document.getElementById('familyHistory');
			       if(obj.length > 0){
				       for(var k=0; k<obj.length;k++)
				       {
				    	   obj[k].selected = false;
				       }
			       }
			       if(famHisIds.childNodes[0] !=undefined){

			    	   famHisId = famHisIds.childNodes[0].nodeValue;
			    	   bar = new Array();
			    	   bar  = famHisId.split(",");

			    	   if(obj.length > 0){
			    		   
			    		   for(var i=0;i<obj.length;i++){
			    			   for(var m=0; m<bar.length;m++)
			    			   {
			    				   if (obj[i].value == bar[m])
			    				   { 
			    					   obj[i].selected = true;
			    					   break;
			    				   }
			    			   }
			    		   }
			    	   }
			       }
			    
				  /*  if(relation.childNodes[0].nodeValue == '8'){
				   		document.getElementById('medCatDiv').style.display='block';
				    }else{
				   		document.getElementById('medCatDiv').style.display='none';
				   	}*/
				    
				    if(document.getElementById("depmobileNo")){
					       if(mobileNo.childNodes[0] !=undefined)
					    	   document.getElementById("depmobileNo").value=mobileNo.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("depmobileNo").value = "";
				    }
				    if(document.getElementById("deppoliceStation")){
					       if(policeStation.childNodes[0] !=undefined)
					    	   document.getElementById("deppoliceStation").value=policeStation.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("deppoliceStation").value = "";
				    }
				    if(document.getElementById("deppinCode")){
					       if(pincode.childNodes[0] !=undefined)
					    	   document.getElementById("deppinCode").value=pincode.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("deppinCode").value = "";
				    }
				    if(document.getElementById("alcohol")){
					       if(alcohol.childNodes[0] !=undefined)
					    	   document.getElementById("alcohol").value=alcohol.childNodes[0].nodeValue;
					       else
						    	 document.getElementById("alcohol").value = "";
				    }
				    
				    if(document.getElementById("smokerLess10")){
					       if(smokerLess10.childNodes[0] !=undefined && smokerLess10.childNodes[0].nodeValue=='y')
					    	   document.getElementById("smokerLess10").checked=true;
					       else
						    	 document.getElementById("smokerLess10").checked=false;
				    }
				    if(document.getElementById("smokerMore10")){
					       if(smokerMore10.childNodes[0] !=undefined && smokerMore10.childNodes[0].nodeValue=='y')
					    	   document.getElementById("smokerMore10").checked=true;
					       else
						    	 document.getElementById("smokerMore10").checked=false;
				    }
				    if(document.getElementById("allergies")){
					       if(allergy.childNodes[0] !=undefined)
					   	   document.getElementById("allergies").value=allergy.childNodes[0].nodeValue;
					       else
						    document.getElementById("allergies").value = "";
				   }
			
				    if(document.getElementById("depMarriageDateId")){
					       if(marriageDate.childNodes[0] !=undefined)
					   	   document.getElementById("depMarriageDateId").value=marriageDate.childNodes[0].nodeValue;
					       else
						    document.getElementById("depMarriageDateId").value = "";
				   }
				    if(document.getElementById("depIdentificationMark1")){
					       if(idMark1.childNodes[0] !=undefined)
					   	   document.getElementById("depIdentificationMark1").value=idMark1.childNodes[0].nodeValue;
					       else
						    document.getElementById("depIdentificationMark1").value = "";
				   }
				    if(document.getElementById("depIdentificationMark2")){
					       if(idMark2.childNodes[0] !=undefined)
					   	   document.getElementById("depIdentificationMark2").value=idMark2.childNodes[0].nodeValue;
					       else
						    document.getElementById("depIdentificationMark2").value = "";
				   }
				   if(document.getElementById("patientStatus")){
				       if(patientStatus.childNodes[0] !=undefined)
				   	   document.getElementById("patientStatus").value=patientStatus.childNodes[0].nodeValue;
				       else
					    document.getElementById("patientStatus").value = "";
				  }
				   if(document.getElementById("nokNameId")){
				       if(nok1Name.childNodes[0] !=undefined)
				    	   document.getElementById("nokNameId").value=nok1Name.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nokNameId").value = "";
			       }
				   if(document.getElementById("relId")){
				       if(nok1Relation.childNodes[0] !=undefined)
				    	   document.getElementById("relId").value=nok1Relation.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("relId").value = "";
			       }
				  
				   if(document.getElementById("nok1Phone")){
				       if(nok1Contact.childNodes[0] !=undefined)
				    	   document.getElementById("nok1Phone").value=nok1Contact.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1Phone").value = "";
			       }
				   if(document.getElementById("nextOfKinAdd")){
				       if(nok1Address.childNodes[0] !=undefined)
				    	   document.getElementById("nextOfKinAdd").value=decodeURIComponent(nok1Address.childNodes[0].nodeValue);
				       else
					    	 document.getElementById("nextOfKinAdd").value = "";
			       }
				   if(document.getElementById("nok1PoliceStation")){
				       if(nok1PoliceStn.childNodes[0] !=undefined)
				    	   document.getElementById("nok1PoliceStation").value=nok1PoliceStn.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1PoliceStation").value = "";
			       }
				   if(document.getElementById("nok1PinCode")){
				       if(nok1PinCode.childNodes[0] !=undefined)
				    	   document.getElementById("nok1PinCode").value=nok1PinCode.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok1PinCode").value = "";
			       }
				   
				   if(document.getElementById("nok2NameId")){
				       if(nok2Name.childNodes[0] !=undefined)
				    	   document.getElementById("nok2NameId").value=nok2Name.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2NameId").value = "";
			       }
				   if(document.getElementById("nok2RelId")){
				       if(nok2Relation.childNodes[0] !=undefined)
				    	   document.getElementById("nok2RelId").value=nok2Relation.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2RelId").value = "";
			       }
				   
				   if(document.getElementById("nok2Contact")){
				       if(nok2Contact.childNodes[0] !=undefined)
				    	   document.getElementById("nok2Contact").value=nok2Contact.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2Contact").value = "";
			       }
				   if(document.getElementById("nok2Add")){
				       if(nok2Address.childNodes[0] !=undefined)
				    	   document.getElementById("nok2Add").value=decodeURIComponent(nok2Address.childNodes[0].nodeValue);
				       else
					    	 document.getElementById("nok2Add").value = "";
			       }
				   if(document.getElementById("nok2PoliceStation")){
				       if(nok2PoliceStn.childNodes[0] !=undefined)
				    	   document.getElementById("nok2PoliceStation").value=nok2PoliceStn.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2PoliceStation").value = "";
			       }
				   if(document.getElementById("nok2PinCode")){
				       if(nok2PinCode.childNodes[0] !=undefined)
				    	   document.getElementById("nok2PinCode").value=nok2PinCode.childNodes[0].nodeValue;
				       else
					    	 document.getElementById("nok2PinCode").value = "";
			       }
				   
	      	} 
	     
	      	getHinHAL('visitEmployee', hinId);
	      	document.getElementById("dobId").onblur();
	      }
	    }
		/*document.getElementById('regHinId').value=hinId;*/	   
		var serviceNo = document.getElementById('serviceNoId').value;
	   var url='/hms/hms/registration?method=displayPatientInfoHAL&hinId='+hinId+'&serviceNo='+serviceNo;
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    

	  
}
  
  function getPatientDetailsForDMO(action){
	 	var xmlHttp;
		  try {
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var servType  = item.getElementsByTagName("servType")[0];
		        var servStatus  = item.getElementsByTagName("servStatus")[0];
		        var rank  = item.getElementsByTagName("rank")[0];
		        var rankId  = item.getElementsByTagName("rankId")[0];
		        var fName  = item.getElementsByTagName("fName")[0];
		        var mName  = item.getElementsByTagName("mName")[0];
		        var lastName  = item.getElementsByTagName("lastName")[0];
		        var sex  = item.getElementsByTagName("sex")[0];
		        var dob  = item.getElementsByTagName("dob")[0];
		        var age  = item.getElementsByTagName("age")[0];
		        var command  = item.getElementsByTagName("command")[0];
		        var station  = item.getElementsByTagName("station")[0];
		        var unit  = item.getElementsByTagName("unit")[0];
		        var unitId  = item.getElementsByTagName("unitId")[0];
		        var section  = item.getElementsByTagName("section")[0];
		        var trade  = item.getElementsByTagName("trade")[0];
		        var service  = item.getElementsByTagName("service")[0];
		        var bldGrp  = item.getElementsByTagName("bldGrp")[0];
		        var phoneNo  = item.getElementsByTagName("phoneNo")[0];
		        var contactNo  = item.getElementsByTagName("contactNo")[0];
		        var mrstatus  = item.getElementsByTagName("mrstatus")[0];
		        var relation  = item.getElementsByTagName("relation")[0];
		        var relationId  = item.getElementsByTagName("relationId")[0];
		        var visitId  = item.getElementsByTagName("visitId")[0];
		        var serPersName  = item.getElementsByTagName("serPersName")[0];
		        
		        if(document.getElementById("servType"))
		        	document.getElementById("servType").value=servType.childNodes[0].nodeValue;
	            if(document.getElementById("servStatus"))
	            	document.getElementById("servStatus").value=servStatus.childNodes[0].nodeValue;
	            if(document.getElementById("rank"))
	            	document.getElementById("rank").value=rank.childNodes[0].nodeValue;
	            
	            if(document.getElementById("rankId"))
	            	document.getElementById("rankId").value=rankId.childNodes[0].nodeValue;
	            
	            if(document.getElementById("fName")){
	            	document.getElementById("fName").value=fName.childNodes[0].nodeValue;
		        	if(mName.childNodes[0] != undefined)
		        		document.getElementById("mName").value=mName.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("mName").value= "";
		        	if(lastName.childNodes[0] != undefined)
		        		document.getElementById("lName").value=lastName.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("lName").value="";
	            }else if(document.getElementById("patientName")){
	            	var midName = "";
	            	var lName = "";
	            	
	            	if(mName.childNodes[0] != undefined)
	            		midName=mName.childNodes[0].nodeValue;
	            	
		        	if(lastName.childNodes[0] != undefined)
		        		lName=lastName.childNodes[0].nodeValue;
		        	document.getElementById("patientName").value = fName.childNodes[0].nodeValue+" "+midName+" "+lName;
	            }
	            
	            if(document.getElementById("serPersName"))
	            	document.getElementById("serPersName").value=serPersName.childNodes[0].nodeValue;
	            if(document.getElementById("sex"))
	            	document.getElementById("sex").value=sex.childNodes[0].nodeValue;
	            
	            if(document.getElementById("dob")){
			        if(dob.childNodes[0] != undefined)
			        	document.getElementById("dob").value=dob.childNodes[0].nodeValue;
			        else
			        	document.getElementById("dob").value= "";
	            }
	            if(document.getElementById("age"))
	            	document.getElementById("age").value=age.childNodes[0].nodeValue;
		        
	            if(document.getElementById("command")){
			        if(command.childNodes[0] != undefined)
			        	document.getElementById("command").value=command.childNodes[0].nodeValue;
			        else
			        	document.getElementById("command").value="";
	            }
	            
	            if(document.getElementById("station")){
			        if(station.childNodes[0] != undefined)
			        	document.getElementById("station").value=station.childNodes[0].nodeValue;
			        else
			        	document.getElementById("station").value= "";
	            }
		        if(document.getElementById("mobileNo")){
		        	if(contactNo.childNodes[0] != undefined)
		        		document.getElementById("mobileNo").value=contactNo.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("mobileNo").value="";
		        }
       	     
		        if(document.getElementById("unit"))
		        	document.getElementById("unit").value=unit.childNodes[0].nodeValue;
		        
		        if(document.getElementById("unitId"))
		        	document.getElementById("unitId").value=unitId.childNodes[0].nodeValue;
       	    
		        if(document.getElementById("section")){
       	        	if(section.childNodes[0] != undefined )
       	        		document.getElementById("section").value=section.childNodes[0].nodeValue;
       	        	else
       	        		document.getElementById("section").value="";
       	        }
		        if(document.getElementById("trade")){
	       	        if(trade.childNodes[0] != undefined)
	       	        	document.getElementById("trade").value=trade.childNodes[0].nodeValue;
	       	        else
	       	        	document.getElementById("trade").value= "" ;
		        }
       	        if(document.getElementById("service")){
       	        	if(service.childNodes[0] != undefined)
       	        		document.getElementById("service").value=service.childNodes[0].nodeValue;
       	        	else
       	        		document.getElementById("service").value= "";
       	        }
       	        if(document.getElementById("bldGrp")){
			        if(bldGrp.childNodes[0] != undefined)
			        	document.getElementById("bldGrp").value=bldGrp.childNodes[0].nodeValue;
			        else
			        	document.getElementById("bldGrp").value="";
       	        }
		        if(document.getElementById("contactNo")){
			        if(phoneNo.childNodes[0] != undefined)
			        	document.getElementById("contactNo").value=phoneNo.childNodes[0].nodeValue;
			        else
			        	document.getElementById("contactNo").value="";
		        }
		        if(document.getElementById("mrstatus")){
		        	if(mrstatus.childNodes[0] != undefined)
		        		document.getElementById("mrstatus").value=mrstatus.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("mrstatus").value= "";
		        }
		        if(document.getElementById("relation")){
		        	if(relation.childNodes[0] != undefined)
		        		document.getElementById("relation").value=relation.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("relation").value= "";
		        }
		        if(document.getElementById("relationId")){
		        	if(relationId.childNodes[0] != undefined)
		        		document.getElementById("relationId").value=relationId.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("relationId").value= "";
		        }
		        
		        if(document.getElementById("visitId")){
		        	if(visitId.childNodes[0] != undefined)
		        		document.getElementById("visitId").value=visitId.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("visitId").value= "";
		        }
	      	} 
	      }
	    }
	   var url=action;
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	}
  
  function ajaxFunctionForAutoCompletedDepartmentIndent(formName,action,rowVal) {
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		       
		        var pvmsNo  = item.getElementsByTagName("pvms")[0];
		        var au  = item.getElementsByTagName("au")[0];
		        var itemId  = item.getElementsByTagName("id")[0];
		        var stock  = item.getElementsByTagName("stock")[0];
		        var name  = item.getElementsByTagName("name")[0];
		        
		     	document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
	        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
	        	//document.getElementById('nomenclature'+rowVal).value = name.childNodes[0].nodeValue
	        	document.getElementById('au'+rowVal).value = au.childNodes[0].nodeValue
	        	document.getElementById('stock'+rowVal).value = stock.childNodes[0].nodeValue
	        	document.getElementById('qtyDemand'+rowVal).value='0';
	      	} 
	      }
	    }
	    var url=action+"&"+getNameAndData(formName)
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	  }
  function submitProtoAjaxForBarcodeData(formName,action,rowVal) {
	
	 
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){

	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	if(items.childNodes.length!=0){
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
	      		alert("============"+availableStock.childNodes[0].nodeValue);
		   	    var item = items.childNodes[loop];
		       // var id  = item.getElementsByTagName("id")[0];
		     var pvms  = item.getElementsByTagName("pvms")[0];
		      //  var au  = item.getElementsByTagName("au")[0];
		      //  var name  = item.getElementsByTagName("name")[0];
		       var batchNo=item.getElementsByTagName("batchNo")[0];
		      // var barcodeNo=item.getElementsByTagName("barCodeNo")[0];
		      // var availableStock=item.getElementsByTagName("availableStock")[0];
		       var expiryDate=item.getElementsByTagName("expiryDate")[0];
		       var manuDate=item.getElementsByTagName("dom")[0];
	        	if(document.getElementById("codeItem"+rowVal).value!=""){
	        		alert(availableStock.childNodes[0].nodeValue);
	        	if(pvms.childNodes[0].nodeValue==document.getElementById('codeItem'+rowVal).value){
	        	document.getElementById("batchNo"+rowVal).value=batchNo.childNodes[0].nodeValue;
	        	//document.getElementById("availableStock"+rowVal).value=availableStock.childNodes[0].nodeValue;
	        	document.getElementById("expiryDate"+rowVal).value=expiryDate.childNodes[0].nodeValue;

	        	document.getElementById("qtyIssued"+rowVal).readOnly=false;
	        	document.getElementById("qtyIssued"+rowVal).focus();
	        	
	        	}
	        	else{
	        	alert("The Barcode you entered is not For this item..");
	        	document.getElementById("barCodeNo"+rowVal).value="";
	        	}
	        	}
	        	else{
	        	//document.getElementById("codeItem"+rowVal).value=pvms.childNodes[0].nodeValue;
	        	document.getElementById("batchNo"+rowVal).value=batchNo.childNodes[0].nodeValue;
	        	//document.getElementById("au"+rowVal).value=au.childNodes[0].nodeValue;
	        	//document.getElementById("nameItem"+rowVal).value=name.childNodes[0].nodeValue;
	        	//document.getElementById("availableStock"+rowVal).value=availableStock.childNodes[0].nodeValue;
	        	document.getElementById("expiryDate"+rowVal).value=expiryDate.childNodes[0].nodeValue;
	        	document.getElementById("manuDate"+rowVal).value=manuDate.childNodes[0].nodeValue;
	        	alert(availableStock.childNodes[0].nodeValue);
	        	document.getElementById("batchStock"+rowVal).value=availableStock.childNodes[0].nodeValue;
	        	}

	      	}
	      	}
	      	else{
	      	alert("There are No items for this Barcode ");
	      document.getElementById("barCodeNo"+rowVal).value="";
	      	}
	      }
	    }
	    //var url=action+"&"+getNameAndData(formName)
	    var url=action+"&"+getNameAndData(formName)

	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);

	  }
  
  
  function calculateTotalService(comDate){
	  if(comDate != ""){
		 var commissionDate = new Date(comDate.substring(6),(comDate.substring(3,5) - 1) ,comDate.substring(0,2));
		 currentDate = new Date();
		 var month = currentDate.getMonth() + 1
		 var day = currentDate.getDate()
		 var year = currentDate.getFullYear()
		 var seperator = "/"
		 currentDate = new Date(month + seperator + day + seperator + year);
		 if(commissionDate > currentDate ){
			 alert("Date of Com/Enrolmt should not be greater than current date.");
			 document.getElementById('commissionDateId').value="";
		 }else{
			action="/hms/hms/registration?method=calculateAgeInAjax&dateOfBirth="+comDate;	
			obj = eval('document.registration')
		    obj.action = action;
		   	var url=action
				
		var xmlHttp;
		try {
		  // Firefox, Opera 8.0+, Safari
		  xmlHttp=new XMLHttpRequest();
		}catch (e){
		  // Internet Explorer
		  try{
		    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		  }catch (e){
		  	alert(e)
		    try{
		      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		    }catch (e){
		      alert("Your browser does not support AJAX!");
		      return false;
		    }
		   }
		 }
		  xmlHttp.onreadystatechange=function()
		  {
		    if(xmlHttp.readyState==4){
		    	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		    	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			        var age  = item.getElementsByTagName("age")[0];
			        var period  = item.getElementsByTagName("period")[0];
			       obj=eval(document.getElementById('totalServ'))
			       if(age.childNodes[0].nodeValue == "0"){
			       obj.value=0;
			       }else{
				   obj.value=age.childNodes[0].nodeValue}
				    temp = eval("document.registration.totalServicePeriod");
				   temp.value=period.childNodes[0].nodeValue
		    	} 
		    }
		  }
		  var url=action
		   
		  xmlHttp.open("GET",url,true);
		  xmlHttp.setRequestHeader("Content-Type", "text/xml");
		  xmlHttp.send(null);  
		 }
	  }else{
		  document.getElementById('totalServ').value = "0";
	  }
  }
 
//ashutosh................. 
  
  function getBatchNo(formName,action){

		var serviceNoObj = eval('document.'+formName+'.serviceNo')
			
		var servNo = serviceNoObj.value;

			errorMsg ="";
			ob1 = true;
			ob2 = true;
			ob3 = true;
			if(servNo != ""){
				obj = eval('document.'+formName)
				       	obj.action = action;
			    	   	 var url=action+"&"+getNameAndData(formName)

			        	new Ajax.Updater('hinDiv',url,
						   {asynchronous:true, evalScripts:true }); 
			}	
			return true;
	} 
  function submitBarcodeAjax(formName,action)
  {
	  errorMsg = "";
		ob1 = true;
		ob2 = true;
		ob3 = true;
		obj = eval('document.'+formName)
		       	obj.action = action;
	    	   	 var url=action+"&"+getNameAndData(formName)
	
	        	new Ajax.Updater('testDiv',url,
				   {asynchronous:true, evalScripts:true }); 
				return true;
	    	}
  
  function getPatientDetailsForMinorSurgery(action){
	 	var xmlHttp;
		  try {
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var servType  = item.getElementsByTagName("servType")[0];
		        var servStatus  = item.getElementsByTagName("servStatus")[0];
		        var rank  = item.getElementsByTagName("rank")[0];
		        var pName  = item.getElementsByTagName("pName")[0];
		        var servPerName  = item.getElementsByTagName("servPerName")[0];
		        var age  = item.getElementsByTagName("age")[0];
		        var unit  = item.getElementsByTagName("unit")[0];
		        var trade  = item.getElementsByTagName("trade")[0];
		 /*       var visitNo  = item.getElementsByTagName("visitNo")[0];
		        var visitId  = item.getElementsByTagName("visitId")[0];
		        var doctor  = item.getElementsByTagName("doctor")[0];
		        var diag  = item.getElementsByTagName("diag")[0];*/
		        var relation  = item.getElementsByTagName("relation")[0];
		        
		        if(document.getElementById("servType"))
		        	document.getElementById("servType").value=servType.childNodes[0].nodeValue;
	            if(document.getElementById("servStatus"))
	            	document.getElementById("servStatus").value=servStatus.childNodes[0].nodeValue;
	            if(document.getElementById("rank"))
	            	document.getElementById("rank").value=rank.childNodes[0].nodeValue;
	            
	            if(document.getElementById("patientName")){
	            	document.getElementById("patientName").value=pName.childNodes[0].nodeValue;
		        	
	            }
	            if(document.getElementById("sNameId"))
	            	document.getElementById("sNameId").value=servPerName.childNodes[0].nodeValue;
	          
	            if(document.getElementById("age") && age.childNodes[0]!=undefined)
	            	document.getElementById("age").value=age.childNodes[0].nodeValue;
		        
		        if(document.getElementById("unit"))
		        	document.getElementById("unit").value=unit.childNodes[0].nodeValue;
       	    
		        if(document.getElementById("trade")){
	       	        if(trade.childNodes[0] != undefined)
	       	        	document.getElementById("trade").value=trade.childNodes[0].nodeValue;
	       	        else
	       	        	document.getElementById("trade").value= "" ;
		        }
		        if(document.getElementById("relation")){
		        	if(relation.childNodes[0] != undefined)
		        		document.getElementById("relation").value=relation.childNodes[0].nodeValue;
		        	else
		        		document.getElementById("relation").value= "";
		        }
       	    /*    if(document.getElementById("doctor")){
			        if(doctor.childNodes[0] != undefined)
			        	document.getElementById("doctor").value=doctor.childNodes[0].nodeValue;
			        else
			        	document.getElementById("doctor").value="";
       	        }
		        if(document.getElementById("diag")){
			        if(diag.childNodes[0] != undefined)
			        	document.getElementById("diag").value=diag.childNodes[0].nodeValue;
			        else
			        	document.getElementById("diag").value="";
		        }*/
		        
	      	} 
	      }
	    }
	   var url=action;
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	}
  
 function getHinNoForAppointment(url,rowVal){
	 var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	  obj = document.getElementById('hinNo'+rowVal);
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
    	  obj.length =1;
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		       
		        var hinNo  = item.getElementsByTagName("hinNo")[0];
		        var hinId  = item.getElementsByTagName("hinId")[0];
	        	
	        	obj.length++;
				obj.options[obj.length-1].value=hinId.childNodes[0].nodeValue;
				obj.options[obj.length-1].text=hinNo.childNodes[0].nodeValue;		        
		 //    	document.getElementById('hinNo'+rowVal).value = hinNo.childNodes[0].nodeValue
	        
	      	} 
	      }
	    }
	 //   var url=action+"&"+getNameAndData(formName)
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	 
 }
 
 
 function getDetailsForHinNo(url,rowVal){
			 var xmlHttp;
			  try {
			    // Firefox, Opera 8.0+, Safari
			    xmlHttp=new XMLHttpRequest();
			  }catch (e){
			    // Internet Explorer
			    try{
			      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			    }catch (e){
			    	alert(e)
			      try{
			        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			      }catch (e){
			        alert("Your browser does not support AJAX!");
			        return false;
			      }
			     }
			   }
			 
			    xmlHttp.onreadystatechange=function()
			    {
			      if(xmlHttp.readyState==4){
			      
			      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
			      
			      	for (loop = 0; loop < items.childNodes.length; loop++) {
				   	    var item = items.childNodes[loop];
				       
				        var name  = item.getElementsByTagName("name")[0];
				        var contactNo  = item.getElementsByTagName("contactNo")[0];
				        var age  = item.getElementsByTagName("age")[0];
				        var sex  = item.getElementsByTagName("sex")[0];
			        	
				        document.getElementById('patientName'+rowVal).value = name.childNodes[0].nodeValue;
				        if(contactNo.childNodes[0]!=undefined)
				        document.getElementById('contactNo'+rowVal).value = contactNo.childNodes[0].nodeValue;
				        document.getElementById('age'+rowVal).value = age.childNodes[0].nodeValue;
				        document.getElementById('sex'+rowVal).value = sex.childNodes[0].nodeValue;
			        
			      	} 
			      }
			    }
			 //   var url=action+"&"+getNameAndData(formName)
			     
			    xmlHttp.open("GET",url,true);
			    xmlHttp.setRequestHeader("Content-Type", "text/xml");
			    xmlHttp.send(null);
			 
		 }	   
 

 function displayOtherInfo(hinId,counter){
 var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	   	    
	        var relation  = item.getElementsByTagName("relation")[0];
	        var rank  = item.getElementsByTagName("rank")[0];
	        var relationId  = item.getElementsByTagName("relationId")[0];
	        var rankId  = item.getElementsByTagName("rankId")[0];
	        var sname  = item.getElementsByTagName("sname")[0];
	        var unit  = item.getElementsByTagName("unit")[0];
	        var pname  = item.getElementsByTagName("pname")[0];
	        var age  = item.getElementsByTagName("age")[0];
	        var sex  = item.getElementsByTagName("sex")[0];
	        var serviceTypeId  = item.getElementsByTagName("serviceTypeId")[0];
	        var hinId  = item.getElementsByTagName("hinId")[0];
	        if( document.getElementById('relation'+counter))
	        	document.getElementById('relation'+counter).value = relation.childNodes[0].nodeValue;
	        if(document.getElementById('rank'+counter))
	        	document.getElementById('rank'+counter).value = rank.childNodes[0].nodeValue;
	        if(document.getElementById('relationId'+counter))
	        	document.getElementById('relationId'+counter).value = relationId.childNodes[0].nodeValue;
	        if(document.getElementById('rankId'+counter))
	        	document.getElementById('rankId'+counter).value = rankId.childNodes[0].nodeValue;
	        if(document.getElementById('servPersName'+counter))
	        	document.getElementById('servPersName'+counter).value = sname.childNodes[0].nodeValue;
	        if(document.getElementById('unit'+counter))
	        	document.getElementById('unit'+counter).value = unit.childNodes[0].nodeValue;
	        if(document.getElementById('patientName'+counter))
	        	document.getElementById('patientName'+counter).value = pname.childNodes[0].nodeValue;
	        if(document.getElementById('age'+counter))
	        	document.getElementById('age'+counter).value = age.childNodes[0].nodeValue;
	        if(document.getElementById('sex'+counter))
	        	document.getElementById('sex'+counter).value = sex.childNodes[0].nodeValue;
	        if(document.getElementById('serviceTypeId'+counter))
	        	document.getElementById('serviceTypeId'+counter).value = serviceTypeId.childNodes[0].nodeValue;
	        if(document.getElementById('hinId'+counter))
	        	document.getElementById('hinId'+counter).value = hinId.childNodes[0].nodeValue;
      	} 
      }
    }
 //   var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",'/hms/hms/adt?method=getPatientDetailsForApp&hinId='+hinId+'&counter='+counter,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	 
 }	   
 
 
 
function calculateIdealWeight(){
		
 var height = document.getElementById('height').value;
 var age = document.getElementById('ageId').value;
 var genderId = document.getElementById('genderId').value;
		var xmlHttp;
		  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
		     }
		   }
		 
		    xmlHttp.onreadystatechange=function()
		    {
		      if(xmlHttp.readyState==4){
		      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		      	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			   	  
			        var weight  = item.getElementsByTagName("weight")[0];
			        var sd = item.getElementsByTagName("sd")[0];
			       document.getElementById('idealWeightId').value = weight.childNodes[0].nodeValue;
			       if(document.getElementById('sdVal'))
			    	   document.getElementById('sdVal').value = sd.childNodes[0].nodeValue;
		      	} 
		      }
		      }
		    var url="/hms/hms/opd?method=calculateIdealWeight&height="+height+"&age='"+age+"'&genderId="+genderId;
		    xmlHttp.open("GET",url,true);
		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
		    xmlHttp.send(null);


		}




function checkItem(iteration){

//var tbl = document.getElementById('grid');
//var lastRow = tbl.rows.length;
//var iteration = lastRow-1;

var pvmsNo='';
if(document.getElementById("pvmsNo"+iteration))
	pvmsNo = document.getElementById("pvmsNo"+iteration).value;
var nomenclature = '';

if(document.getElementById("nomenclature"+iteration))
	nomenclature = document.getElementById("nomenclature"+iteration).value

var visitId=0;
if(document.getElementById("visitId"))
	visitId = document.getElementById("visitId").value
var xmlHttp;
  try {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }catch (e){
    // Internet Explorer
    try{
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e){
    	alert(e)
      try{
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }catch (e){
        alert("Your browser does not support AJAX!");
        return false;
      }
     }
   }

    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){

      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var bedStatus  = item.getElementsByTagName("bedStatus")[0];
	         if(bedStatus.childNodes[0].nodeValue=='yes'){
	           	alert("This Drug is Alergic for this patient..!")
	        if(document.getElementById("nomenclature"+iteration))
	        	document.getElementById("nomenclature"+iteration).value = ""
       		if(document.getElementById("pvmsNo"+iteration))
       			document.getElementById("pvmsNo"+iteration).value= ""
	       	pvmsNo=pvmsNo.childNodes[0].nodeValue
	       return true
	       }else{
    	   if(document.getElementById("visitId"))
    		   document.getElementById("visitId").selectedIndex=0
	        pvmsNo=0
	       	return false;
	       }

      	}
      	
      }
      
      }
  //  if(nomenclature!="")
  //  {
        
  	  checkForNomenclature(nomenclature,iteration)
   // }
    var url="/hms/hms/opd?method=checkItem&pvmsNo="+pvmsNo+"&visitId="+visitId

    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);

}
/*
function displayAu(val,inc){
	if(val != "")
	{
	    var index1 = val.lastIndexOf("[");
	    var indexForBrandName=index1;
	    var index2 = val.lastIndexOf("]");
	    index1++;
	    var pvmsNo = val.substring(index1,index2);
	    var indexForBrandName=indexForBrandName--;
	    var brandName=val.substring(0,indexForBrandName);
	   //  alert("pvms no--"+pvmsNo)
  if(pvmsNo == "")
  {
   // alert("pvms no1111--"+pvmsNo)
   	document.getElementById('nomenclature'+inc).value="";
    document.getElementById('pvmsNo'+inc).value="";
   return;
   }
   else
      //document.getElementById('pvmsNo'+inc).value=pvmsNo
      //alert(pvmsNo);
	var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	 
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var au  = item.getElementsByTagName("au")[0];
		        var actualDispensingQty = item.getElementsByTagName("actualDispensingQty")[0];
		        if(au.childNodes[0] != undefined){
		          document.getElementById('au'+inc).value = au.childNodes[0].nodeValue;
		        }
		          if(actualDispensingQty!=undefined && actualDispensingQty.childNodes[0]!= undefined && document.getElementById('actualDispensingQty'+inc)){
			          document.getElementById('actualDispensingQty'+inc).value = actualDispensingQty.childNodes[0].nodeValue;
			       }else{
			    	   document.getElementById('actualDispensingQty'+inc).value = '';
			       }
	      	} 
	       }
	      }
	    var url="/hms/hms/opd?method=displayAU&pvmsNo="+pvmsNo;
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	}
}*/

function getExpiryDate(val,inc){
	if(val != "0")
	{
		
	var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var expiryDate  = item.getElementsByTagName("expiryDate")[0];
		       
		        var stock  = item.getElementsByTagName("stock")[0];
	      
	            if(expiryDate.childNodes[0]!= undefined && document.getElementById('expiryDate'+inc)){
		          document.getElementById('expiryDate'+inc).value = expiryDate.childNodes[0].nodeValue;
		        }
	            if(stock.childNodes[0]!= undefined && document.getElementById('stockQty'+inc)){
			          document.getElementById('stockQty'+inc).value = stock.childNodes[0].nodeValue;
		        }
	          
	      	} 
	       }
	      }
	    var url="/hms/hms/ipd?method=getBatchExpiryDate&batchId="+val;
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	}
	
}
function calculateAVAgeInAjax() {
	  var action=
	  dob=document.getElementById('srdobId').value;
		if(dob!= ""){
			if(checkDob('srdobId')){
				action="/hms/hms/registration?method=calculateAgeInAjax&dateOfBirth="+dob;	
				if(document.renewableApp)
					obj = eval('document.renewableApp')
				else if(document.caForm34A)
					obj = eval('document.caForm34A')
		        obj.action = action;
	    	   	var url=action
			}
		}
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var age  = item.getElementsByTagName("age")[0];
		        var period  = item.getElementsByTagName("period")[0];
		       obj=eval(document.getElementById('srAgeId'))
		       if(age.childNodes[0].nodeValue == "0"){
		       obj.value="0"
		       }else{
		    	 if(age.childNodes[0].nodeValue < '16'){
		    		 alert("Please check Person Age.");
		    		 document.getElementById('srdobId').value="";
		    		 document.getElementById('dobId').value="";
		    		 document.getElementById('ageId').value="";
		    		 return false;
		    	 }
			   obj.value=age.childNodes[0].nodeValue}
		       if(document.renewableApp)
		    	   temp = eval("document.renewableApp.srAgeUnit");
				else if(document.caForm34A)
					temp = eval("document.caForm34A.srAgeUnit");
		       
			    
			   temp.value=period.childNodes[0].nodeValue
	      	} 
	      }
	    }
	    var url=action
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	    
	  }
function calculate34AgeInAjax() {
	  var action=
	  dob=document.getElementById('srdobId').value;
		if(dob!= ""){
			if(checkDob('srdobId')){
			action="/hms/hms/registration?method=calculateAgeInAjax&dateOfBirth="+dob;	
			obj = eval('document.caForm34A')
			       obj.action = action;
		    	   	 var url=action
			}
		}
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var age  = item.getElementsByTagName("age")[0];
		        var period  = item.getElementsByTagName("period")[0];
		       obj=eval(document.getElementById('srAgeId'))
		       if(age.childNodes[0].nodeValue == "0"){
		       obj.value="0"
		       }else{
		    	 if(age.childNodes[0].nodeValue < '16'){
		    		 alert("Please check Person Age.");
		    		 document.getElementById('srdobId').value="";
		    		 document.getElementById('dobId').value="";
		    		 document.getElementById('ageId').value="";
		    		 return false;
		    	 }
			   obj.value=age.childNodes[0].nodeValue}
			    temp = eval("document.caForm34A.srAgeUnit");
			   temp.value=period.childNodes[0].nodeValue
	      	} 
	      }
	    }
	    var url=action
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	  }
function ajaxFunctionForLicenceNo(formName,action,rowVal) {
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	 	var valueChargeCode = document.getElementById('licenceNo'+rowVal).value;
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		        var avic34Id  = item.getElementsByTagName("avic34Id")[0];
		        var name  = item.getElementsByTagName("name")[0];
		        var appointmentDate  = item.getElementsByTagName("appointmentDate")[0];
		        var receivedDate= item.getElementsByTagName("receivedDate")[0];
		        var receivedBy= item.getElementsByTagName("receivedBy")[0];
		        var examinationDate=item.getElementsByTagName("examinationDate")[0];
		        var dispatchDate=item.getElementsByTagName("dispatchDate")[0];
		        var dispatchedBy=item.getElementsByTagName("dispatchedBy")[0];
		        var remarks=item.getElementsByTagName("remarks")[0];
		        
	        	document.getElementById('avic34Id'+rowVal).value = avic34Id.childNodes[0].nodeValue
	        	
	        	document.getElementById('name'+rowVal).value = name.childNodes[0].nodeValue
	        	document.getElementById('appointmentDate'+rowVal).value = appointmentDate.childNodes[0].nodeValue
	        	document.getElementById('receivedDate'+rowVal).value = receivedDate.childNodes[0].nodeValue
	        	document.getElementById('receivedBy'+rowVal).value = receivedBy.childNodes[0].nodeValue
	        	if(examinationDate.childNodes[0] != undefined){
	        	document.getElementById('examinationDate'+rowVal).value = examinationDate.childNodes[0].nodeValue
	        	}if(dispatchDate.childNodes[0] != undefined){
	        	document.getElementById('dispatchDate'+rowVal).value = dispatchDate.childNodes[0].nodeValue
	        	}
	        	if(dispatchedBy.childNodes[0] != undefined){
	        	document.getElementById('dispatchedBy'+rowVal).value = dispatchedBy.childNodes[0].nodeValue
	        	}if(remarks.childNodes[0] != undefined){
	        	document.getElementById('remarks'+rowVal).value = remarks.childNodes[0].nodeValue
	        	}
	      	} 
	      }
	    }
		    var url=action+"&"+getNameAndData(formName)
		     
		    xmlHttp.open("GET",url,true);
		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
		    xmlHttp.send(null);
		    
		  }

function ajaxFunctionAVService(formName,rowVal,serviceNo) {
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	 
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	    var rankName = item.getElementsByTagName("rankName")[0];
		   	    var rankId = item.getElementsByTagName("rankId")[0];
		   	    var sName =  item.getElementsByTagName("sName")[0];
		   	    var hinId = item.getElementsByTagName("hinId")[0];
		   	    document.getElementById('rankName'+rowVal).value = rankName.childNodes[0].nodeValue
		   	    document.getElementById('rankId'+rowVal).value = rankId.childNodes[0].nodeValue
	        	document.getElementById('sName'+rowVal).value = sName.childNodes[0].nodeValue
	        	document.getElementById('hinId'+rowVal).value = hinId.childNodes[0].nodeValue
	      	} 
	      }
	      }
	       
	    xmlHttp.open("GET",'aviationMedicine?method=fillAVServiceDetail&serviceNo='+serviceNo,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	  }

function ajaxFunctionSHOService(formName,rowVal,serviceNo) {
	
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	 
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	    	        
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	    var nameofSanitaryRound =  item.getElementsByTagName("nameofSanitaryRound")[0];
		   	    
		   	    var hinId = item.getElementsByTagName("hinId")[0];
		   	    var sanitaryBranch = item.getElementsByTagName("sanitaryBranch")[0];
		   	    
		   	    var branchId = item.getElementsByTagName("branchId")[0];
	        	document.getElementById('nameofSanitaryRound'+rowVal).value = nameofSanitaryRound.childNodes[0].nodeValue
	        	document.getElementById('hinId'+rowVal).value = hinId.childNodes[0].nodeValue
	        	document.getElementById('sanitaryBranch'+rowVal).value = sanitaryBranch.childNodes[0].nodeValue
	        	document.getElementById('branchId'+rowVal).value = branchId.childNodes[0].nodeValue
	      	} 
	      }
	      }
	       
	    xmlHttp.open("GET",'mis?method=fillAVServiceDetail&serviceNo='+serviceNo,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	  }

function ajaxFunctionAVPilotRegService(formName,rowVal,serviceNo) {
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	 
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	     var rankId = item.getElementsByTagName("rankId")[0];
		   	    var sName =  item.getElementsByTagName("sName")[0];
		   	    var hinId = item.getElementsByTagName("hinId")[0];
		   	    var age = item.getElementsByTagName("age")[0];
		   	    var medCatId = item.getElementsByTagName("medCatId")[0];
		   	 
		   	  
		   	    document.getElementById('rankId'+rowVal).value = rankId.childNodes[0].nodeValue
	        	document.getElementById('sName'+rowVal).value = sName.childNodes[0].nodeValue
	        	document.getElementById('age'+rowVal).value = age.childNodes[0].nodeValue
	           	
	         	if(hinId.childNodes[0].nodeValue!=undefined)
	        		document.getElementById('hinId'+rowVal).value = hinId.childNodes[0].nodeValue
        		else
        			document.getElementById('hinId'+rowVal).value = 0;

	        	var rankCombo = document.getElementById('rankId'+rowVal);
	        	
	        	for(var i=0;i<rankCombo.length;i++)
	        	{
	        		if (rankCombo[i].value == rankId.childNodes[0].nodeValue)
	        			rankCombo.selectedIndex = i;
	        	}
	        	
	        	var medCombo = document.getElementById('medCatId'+rowVal);
	        	
	        	for(var i=0;i<medCombo.length;i++)
	        	{
	        		if (medCombo[i].value == medCatId.childNodes[0].nodeValue)
	        			medCombo.selectedIndex = i;
	        	}
	        	
	        
	        	
	      	} 
	      }
	      }
	       
	    xmlHttp.open("GET",'aviationMedicine?method=fillAVPilotRegServiceDetail&serviceNo='+serviceNo,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	  }
function ajaxFunctionPilotRegService(formName,rowVal,serviceNo) {
	  var xmlHttp;
	  try {
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
	  }catch (e){
	    // Internet Explorer
	    try{
	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }catch (e){
	    	alert(e)
	      try{
	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }catch (e){
	        alert("Your browser does not support AJAX!");
	        return false;
	      }
	     }
	   }
	 
	    xmlHttp.onreadystatechange=function()
	    {
	      if(xmlHttp.readyState==4){
	      
	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	      	for (loop = 0; loop < items.childNodes.length; loop++) {
		   	    var item = items.childNodes[loop];
		   	    var rankId = item.getElementsByTagName("rankId")[0];
		   	    var sName =  item.getElementsByTagName("sName")[0];
		   	    var hinId = item.getElementsByTagName("hinId")[0];
		   	    var age = item.getElementsByTagName("age")[0];
		   	  var pilotId = item.getElementsByTagName("pilotId")[0];
		   	 
		   	    
		   	    document.getElementById('rankId'+rowVal).value = rankId.childNodes[0].nodeValue
	        	document.getElementById('sName'+rowVal).value = sName.childNodes[0].nodeValue
	        	document.getElementById('age'+rowVal).value = age.childNodes[0].nodeValue
	        	
	        	if(hinId.childNodes[0].nodeValue!=undefined)
	        		document.getElementById('hinId'+rowVal).value = hinId.childNodes[0].nodeValue
        		else
        			document.getElementById('hinId'+rowVal).value = 0;
		   	    
		   		if(pilotId.childNodes[0].nodeValue!=undefined)
	        		document.getElementById('pilotId'+rowVal).value = pilotId.childNodes[0].nodeValue
        		else
        			document.getElementById('pilotId'+rowVal).value = 0;


	        	var rankCombo = document.getElementById('rankId'+rowVal);
	        	
	        	for(var i=0;i<rankCombo.length;i++)
	        	{
	        		if (rankCombo[i].value == rankId.childNodes[0].nodeValue)
	        			rankCombo.selectedIndex = i;
	        	}
	        
	        	
	      	} 
	      }
	      }
	       
	    xmlHttp.open("GET",'registration?method=fillAVPilotRegServiceDetail&serviceNo='+serviceNo,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	  }
	  function calculateAVTotalService(comDate){
	  if(comDate != ""){
		 var commissionDate = new Date(comDate.substring(6),(comDate.substring(3,5) - 1) ,comDate.substring(0,2));
		 currentDate = new Date();
		 var month = currentDate.getMonth() + 1
		 var day = currentDate.getDate()
		 var year = currentDate.getFullYear()
		 var seperator = "/"
		 currentDate = new Date(month + seperator + day + seperator + year);
		 if(commissionDate > currentDate ){
			 alert("Date of Com/Enrolmt should not be greater than current date.");
			 document.getElementById('commissionDateId').value="";
		 }else{
			action="/hms/hms/registration?method=calculateAgeInAjax&dateOfBirth="+comDate;	
			obj = eval('document.casualtyAirEvacuation')
		    obj.action = action;
		   	var url=action
				
		var xmlHttp;
		try {
		  // Firefox, Opera 8.0+, Safari
		  xmlHttp=new XMLHttpRequest();
		}catch (e){
		  // Internet Explorer
		  try{
		    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		  }catch (e){
		  	alert(e)
		    try{
		      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		    }catch (e){
		      alert("Your browser does not support AJAX!");
		      return false;
		    }
		   }
		 }
		  xmlHttp.onreadystatechange=function()
		  {
		    if(xmlHttp.readyState==4){
		    	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		    	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			        var age  = item.getElementsByTagName("age")[0];
			        var period  = item.getElementsByTagName("period")[0];
			       obj=eval(document.getElementById('totalServ'))
			       if(age.childNodes[0].nodeValue == "0"){
			       obj.value=0;
			       }else{
				   obj.value=age.childNodes[0].nodeValue}
				    temp = eval("document.registration.totalServicePeriod");
				   temp.value=period.childNodes[0].nodeValue
		    	} 
		    }
		  }
		  var url=action
		   
		  xmlHttp.open("GET",url,true);
		  xmlHttp.setRequestHeader("Content-Type", "text/xml");
		  xmlHttp.send(null);  
		 }
	  }else{
		  document.getElementById('totalServ').value = "0";
	  }
  }  
	  
	  function ajaxFunctionMBService(formName) {
		  var xmlHttp;
		  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
		     }
		   }
		 
		    xmlHttp.onreadystatechange=function()
		    {
		      if(xmlHttp.readyState==4){
		      
		      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		      	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			   	    var name =  item.getElementsByTagName("name")[0];
			   	    var rankId = item.getElementsByTagName("rankId")[0];
			   	    var hinId = item.getElementsByTagName("hinId")[0];
			   	    var sexId = item.getElementsByTagName("sexId")[0];
			        var unitId = item.getElementsByTagName("unitId")[0];
			        var age = item.getElementsByTagName("age")[0];
			        var commandId = item.getElementsByTagName("commandId")[0];
			        
		        	document.getElementById('name').value = name.childNodes[0].nodeValue
		        	document.getElementById('rankId').value = rankId.childNodes[0].nodeValue
		        	document.getElementById('hinId').value = hinId.childNodes[0].nodeValue
		        	document.getElementById('sexId').value = sexId.childNodes[0].nodeValue
		        	document.getElementById('age').value = age.childNodes[0].nodeValue
		        	//document.getElementById('unitId').value = unitId.childNodes[0].nodeValue
		        	document.getElementById('commandId').value = commandId.childNodes[0].nodeValue
		        	var unitCombo = document.getElementById('unitId');
		        	
		        	for(var i=0;i<unitCombo.length;i++)
		        	{
		        		if (unitCombo[i].value == unitId.childNodes[0].nodeValue)
		        			unitCombo.selectedIndex = i;
		        	}
		        	
		        	var medCatCombo = document.getElementById('medcatId');
		        	
		        	for(var i=0;i<medCatCombo.length;i++)
		        	{
		        		if (medCatCombo[i].value == medcatId.childNodes[0].nodeValue)
		        			medCatCombo.selectedIndex = i;
		        	}
		      	} 
		      }
		      }
		    xmlHttp.open("GET",'medicalBoard?method=fillServiceDetail&serviceNo='+document.getElementById("serviceNo").value,true);
		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
		    xmlHttp.send(null);
		    
		  }
	  
	  function showRegisterDetail(formName,serviceNo,rowVal) {
		  var xmlHttp;
		  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
		     }
		   }
		 
		    xmlHttp.onreadystatechange=function()
		    {
		      if(xmlHttp.readyState==4){
		      
		      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		      	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			   	    var name =  item.getElementsByTagName("name")[0];
			   	    var rankId = item.getElementsByTagName("rankId")[0];
			   	    var hinId = item.getElementsByTagName("hinId")[0];
			   	    var sexId = item.getElementsByTagName("sexId")[0];
			        var unitId = item.getElementsByTagName("unitId")[0];
			        var age = item.getElementsByTagName("age")[0];
			        var categoryId=item.getElementsByTagName("categoryId")[0];
			        
		        	document.getElementById('name'+rowVal).value = name.childNodes[0].nodeValue
		        	document.getElementById('hinId'+rowVal).value = hinId.childNodes[0].nodeValue
		        	document.getElementById('age'+rowVal).value = age.childNodes[0].nodeValue
		        	
		        	var unitCombo = document.getElementById('unitId'+rowVal);
		        	
		        	for(var i=0;i<unitCombo.length;i++)
		        	{
		        		if (unitCombo[i].value == unitId.childNodes[0].nodeValue)
		        			unitCombo.selectedIndex = i;
		        	}
		        	
		        	var rankCombo = document.getElementById('rankId'+rowVal);
		        	
		        	for(var i=0;i<rankCombo.length;i++)
		        	{
		        		if (rankCombo[i].value == rankId.childNodes[0].nodeValue)
		        			rankCombo.selectedIndex = i;
		        	}
		        	
		        	var sexCombo = document.getElementById('sexId'+rowVal);
		        	
		        	for(var i=0;i<sexCombo.length;i++)
		        	{
		        		if (sexCombo[i].value == sexId.childNodes[0].nodeValue)
		        			sexCombo.selectedIndex = i;
		        	}
		        	
		        	var medCombo = document.getElementById('categoryId'+rowVal);
		        	
		        	for(var i=0;i<medCombo.length;i++)
		        	{
		        		if (medCombo[i].value == categoryId.childNodes[0].nodeValue)
		        			medCombo.selectedIndex = i;
		        	}
		      	} 
		      }
		      }
		    xmlHttp.open("GET",'aviationMedicine?method=fillRegisterDetail&serviceNo='+document.getElementById("serviceNo"+rowVal).value,true);
		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
		    xmlHttp.send(null);
		    
		  }
	  


	  function checkGrnNo(val){
		  
		  if(val!=''){
			  var str1 = val.charAt(val.length-6);
			  var str2 = val.charAt(val.length-3);
			  if(str1=="/" && str2=="-"){ //CRV No. should contain '/' and '-'
				  var xmlHttp;
				  try {
					  // Firefox, Opera 8.0+, Safari
					  xmlHttp=new XMLHttpRequest();
				  }catch (e){
					  // Internet Explorer
					  try{
						  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
					  }catch (e){
						  alert(e)
						  try{
							  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
						  }catch (e){
							  alert("Your browser does not support AJAX!");
							  return false;
						  }
					  }
				  }

				  xmlHttp.onreadystatechange=function()
				  {
					  if(xmlHttp.readyState==4){

						  var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
						  for (loop = 0; loop < items.childNodes.length; loop++) {
							  var item = items.childNodes[loop];
							  var message =  item.getElementsByTagName("message")[0];
							  if(message.childNodes[0]!=undefined){
								  alert(message.childNodes[0].nodeValue);
								  document.getElementById('grnNo').value = "";
								  document.getElementById('grnNo').focus();
							  } 
						  }
					  }
				  }
				  xmlHttp.open("GET",'/hms/hms/stores?method=checkGrnNo&grnNo='+val,true);
				  xmlHttp.setRequestHeader("Content-Type", "text/xml");
				  xmlHttp.send(null);
			  }else{
				  alert("CRV/RV No. is not valid series.\n It should contain '2 or 3digit(Seq.No.)/yy-yy(Financial Year)'.\n For example 111/12-13");
				  document.getElementById('grnNo').value = "";
				  document.getElementById('grnNo').focus();
			  }
		  }
		    
	  }
	  function ajaxFunctionForEquipmentLoanOut(formName,action,rowVal)
	  {  var xmlHttp;
	  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
		     }
		   }
		    xmlHttp.onreadystatechange=function()
		    {
		      if(xmlHttp.readyState==4){
		      
		      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		      
		      	var lotNo="batchIdd"+rowVal;
		    	  obj = document.getElementById(lotNo);
					obj.length = 1;
					
		      	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			        var id  = item.getElementsByTagName("id")[0];
			        var pvms  = item.getElementsByTagName("pvms")[0];
			        var au  = item.getElementsByTagName("au")[0];
			        var name  = item.getElementsByTagName("name")[0];
			         var availableStock  = item.getElementsByTagName("availableStock")[0];
			         var batchLength  = item.getElementsByTagName("batches")[0];
			         
		        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
		        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
		        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
		        	document.getElementById('availableStock'+rowVal).value = availableStock.childNodes[0].nodeValue
		        	
		        	for(innerLoop = 0;innerLoop < batchLength.childNodes.length;innerLoop++)
		        	{
		        		var batch = batchLength.childNodes[innerLoop];
			        	var batchId  = batch.getElementsByTagName("batchId")[0];
			        	var batchName  = batch.getElementsByTagName("batchName")[0];
			        	obj.length++;
						obj.options[obj.length-1].value=batchName.childNodes[0].nodeValue;
						obj.options[obj.length-1].text=batchName.childNodes[0].nodeValue;
			        	
		        	}
		        		
		      	} 
		      }
		    }
	    var url=action+"&"+getNameAndData(formName)
	     
	    xmlHttp.open("GET",url,true);
	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	    xmlHttp.send(null);
	    
	  }
	  function ajaxFunctionForAutoCompleteIndentToDepot1(formName,action,rowVal)
	  {
		  
		  var xmlHttp;
		  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
		     }
		   }
		    xmlHttp.onreadystatechange=function()
		    {
		      if(xmlHttp.readyState==4){
		      
		      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		      	//var batchs = xmlHttp.responseXML.getElementByTagName('batchs')[0];
		      	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			        var id  = item.getElementsByTagName("id")[0];
			        var pvms  = item.getElementsByTagName("pvms")[0];
			        var au  = item.getElementsByTagName("au")[0];
			        var name  = item.getElementsByTagName("name")[0];

			        var oldPvms  = item.getElementsByTagName("oldPvms")[0];
			       
			        var stock  = item.getElementsByTagName("stock")[0];
			        var qtyMeScale  = item.getElementsByTagName("qtyMeScale")[0];
			        //var qtyInMMF  = item.getElementsByTagName("qtyInMMF")[0];
			       // var section  = item.getElementsByTagName("section")[0];
			        //var demandVar=item.getElementsByTagName("demandVar")[0];
		        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
		        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
		        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
		        	document.getElementById("stockAvailable"+rowVal).value=stock.childNodes[0].nodeValue;
		        	if(qtyMeScale.childNodes[0].nodeValue != undefined){
		        		document.getElementById("qtyAuth"+rowVal).value=qtyMeScale.childNodes[0].nodeValue;
		        	}
		            //document.getElementById('qtyInHand'+rowVal).value = stock.childNodes[0].nodeValue
		        	//if(oldPvms.childNodes[0].nodeValue != 0)
		        	//document.getElementById('oldNiv'+rowVal).value = oldPvms.childNodes[0].nodeValue
		        	
		        	
		        	//document.getElementById('qtyInHandTemp'+rowVal).value = stock.childNodes[0].nodeValue

		        	//document.getElementById('mmfVarTemp'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
		        	//document.getElementById('mmfVar'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
		        	//document.getElementById('section'+rowVal).value = section.childNodes[0].nodeValue
		    
		        	//document.getElementById('demandVar'+rowVal).value = demandVar.childNodes[0].nodeValue
			      
		      	} 
		      }
		    }
		    var url=action+"&"+getNameAndData(formName)
		     
		    xmlHttp.open("GET",url,true);
		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
		    xmlHttp.send(null);
		    
		    
		  }

	  function getServiceNoDetails(formName,action,rowVal) {
		  var xmlHttp;
		  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
		     }
		   }
		 
		    xmlHttp.onreadystatechange=function()
		    {
		      if(xmlHttp.readyState==4){
		      
		      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		      	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			   	     var rank = item.getElementsByTagName("rank")[0];
			   	    var name =  item.getElementsByTagName("name")[0];
			   	    var hinId = item.getElementsByTagName("hinId")[0];
			   	    var age = item.getElementsByTagName("age")[0];
			   	    var unit = item.getElementsByTagName("unit")[0];
			   	    var trade = item.getElementsByTagName("trade")[0];
			   	  
			   	    document.getElementById('rank'+rowVal).value = rank.childNodes[0].nodeValue
		        	document.getElementById('name'+rowVal).value = name.childNodes[0].nodeValue
		        	if(document.getElementById('age'+rowVal))
		        		document.getElementById('age'+rowVal).value = age.childNodes[0].nodeValue
		        	if(document.getElementById('unit'+rowVal))
		        		document.getElementById('unit'+rowVal).value = unit.childNodes[0].nodeValue
		        	
		        	if(document.getElementById('trade'+rowVal) && trade.childNodes[0] !=undefined)
		        		document.getElementById('trade'+rowVal).value = trade.childNodes[0].nodeValue
		           	
		         	if(hinId.childNodes[0]!=undefined)
		        		document.getElementById('hinId'+rowVal).value = hinId.childNodes[0].nodeValue
	        		else
	        			document.getElementById('hinId'+rowVal).value = 0;
		           	
		        
		        	
		      	} 
		      }
		      }
		       
		    xmlHttp.open("GET",action);
		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
		    xmlHttp.send(null);
		    
		  }
	  

	  function ajaxFunctionForAutoCompleteOPDPatientInfo1(formName,action,rowVal) {
	  	  var xmlHttp;
	  	  try {
	  	    // Firefox, Opera 8.0+, Safari
	  	    xmlHttp=new XMLHttpRequest();
	  	  }catch (e){
	  	    // Internet Explorer
	  	    try{
	  	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	  	    }catch (e){
	  	    	alert(e)
	  	      try{
	  	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	  	      }catch (e){
	  	        alert("Your browser does not support AJAX!");
	  	        return false;
	  	      }
	  	     }
	  	   }
	  	    xmlHttp.onreadystatechange=function()
	  	    {
	  	      if(xmlHttp.readyState==4){
	   			var batchNo="batchNo"+rowVal;
	  	    	  
	  	    	  obj = document.getElementById(batchNo);
	  				obj.length = 1;
	  	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	  	      	
	  	      	for (loop = 0; loop < items.childNodes.length; loop++) {
	  		   	    var item = items.childNodes[loop];
	  		       
	  		        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	  		        var au  = item.getElementsByTagName("au")[0];
	  		        var itemId  = item.getElementsByTagName("itemId")[0];
	  		       
	  		        var strength = item.getElementsByTagName("strength")[0];
	  				var totalQty = item.getElementsByTagName("totalQty")[0];
	  				var totalStockQty=item.getElementsByTagName("totalStockQty")[0];
	  				document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
	  				document.getElementById('au'+rowVal).value = au.childNodes[0].nodeValue
	  				
	  				if(strength.childNodes[0].nodeValue!="null")
	  				{
	  	        	document.getElementById('strength'+rowVal).value=strength.childNodes[0].nodeValue
	  				}
	  				else
	  				{
	  					document.getElementById('strength'+rowVal).value="";
	  				}
	  	        	document.getElementById('stockAvailable'+rowVal).value=totalQty.childNodes[0].nodeValue
	  	        	document.getElementById('qtyStock'+rowVal).value=totalStockQty.childNodes[0].nodeValue
	  	        	
	  	        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
	  	        	
	  				
	  				var batchs  = item.getElementsByTagName("batchs")[0];
	  	        	
	  	        	for(innerLoop = 0;innerLoop <batchs.childNodes.length;innerLoop++)
	  	        	{
	  	        		var batch = batchs.childNodes[innerLoop];
	  		        	var batchId  = batch.getElementsByTagName("batchId")[0];
	  		        	var batchNumber  = batch.getElementsByTagName("batchNumber")[0];
	  		        	//alert(batchId.childNodes[0].nodeValue+"<<<abtch >  "+batchName.childNodes[0].nodeValue)
	  		        	obj.length++;
	  					//obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
	  		        	obj.options[obj.length-1].value=batchNumber.childNodes[0].nodeValue;
	  					obj.options[obj.length-1].text=batchNumber.childNodes[0].nodeValue;
	  		        	
	  	        	}
	  	        	 var dangerousDrug = item.getElementsByTagName("dangerousDrug")[0];
	  			        if(dangerousDrug.childNodes[0].nodeValue == 'y'){
	  			        	alert("This drug is dangerous.");
	  			        }


	  			    if(totalQty.childNodes[0].nodeValue != '0.0'){
	  			    	document.getElementById('qtyIssued'+rowVal).readOnly = false;
	  			    	document.getElementById('lo'+rowVal).disabled = true;
	  			    	document.getElementById('lotQty'+rowVal).readOnly=true;
	  			    	document.getElementById('lp'+rowVal).disabled = true;
	  			    	document.getElementById('lpQty'+rowVal).readOnly=true;
	  			    }
	  			    if(totalQty.childNodes[0].nodeValue == '0.0' && totalStockQty.childNodes[0].nodeValue != '0.0' ){
	  			    	document.getElementById('qtyIssued'+rowVal).readOnly = true;
	  			    	document.getElementById('lp'+rowVal).disabled = true;
	  			    	document.getElementById('lpQty'+rowVal).readOnly=true;
	  			    	document.getElementById('lo'+rowVal).disabled = false;
	  			    	document.getElementById('lotQty'+rowVal).readOnly=false;
	  			    }
	  			  
	  			    if(totalQty.childNodes[0].nodeValue == '0.0' && totalStockQty.childNodes[0].nodeValue == '0.0' ){
	  			    	document.getElementById('qtyIssued'+rowVal).readOnly = true;
	  			    	document.getElementById('lo'+rowVal).disabled = true;
	  			    	document.getElementById('lotQty'+rowVal).readOnly=true;
	  			    	document.getElementById('lp'+rowVal).disabled = false;
	  			    	document.getElementById('lpQty'+rowVal).readOnly=false;
	  			    }
	  	      	} 
	  	      }
	  	    }
	  	   var url=action+"&"+getNameAndData(formName)
		   // var url=action;
	  	     
	  	    xmlHttp.open("GET",url,true);
	  	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	  	    xmlHttp.send(null);
	  	    
	  }
	  
	  function ajaxFunctionForAutoCompleteOPDPatientInfo2(formName,action,rowVal) {
	  	  var xmlHttp;
	  	  try {
	  	    // Firefox, Opera 8.0+, Safari
	  	    xmlHttp=new XMLHttpRequest();
	  	  }catch (e){
	  	    // Internet Explorer
	  	    try{
	  	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	  	    }catch (e){
	  	    	alert(e)
	  	      try{
	  	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	  	      }catch (e){
	  	        alert("Your browser does not support AJAX!");
	  	        return false;
	  	      }
	  	     }
	  	   }
	  	    xmlHttp.onreadystatechange=function()
	  	    {
	  	      if(xmlHttp.readyState==4){
	   			var batchNo="batchNo"+rowVal;
	  	    	  
	  	    	  obj = document.getElementById(batchNo);
	  				obj.length = 1;
	  	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	  	      	
	  	      	for (loop = 0; loop < items.childNodes.length; loop++) {
	  		   	    var item = items.childNodes[loop];
	  		       
	  		        var pvmsNo  = item.getElementsByTagName("pvms")[0];
	  		        var au  = item.getElementsByTagName("au")[0];
	  		        var itemId  = item.getElementsByTagName("itemId")[0];
	  		       
	  		        var strength = item.getElementsByTagName("strength")[0];
	  				var totalQty = item.getElementsByTagName("totalQty")[0];
	  				var totalStockQty=item.getElementsByTagName("totalStockQty")[0];
	  				document.getElementById('pvmsNo'+rowVal).value = pvmsNo.childNodes[0].nodeValue
	  				document.getElementById('au'+rowVal).value = au.childNodes[0].nodeValue
	  				
	  				if(strength.childNodes[0].nodeValue!="null")
	  				{
	  	        	document.getElementById('strength'+rowVal).value=strength.childNodes[0].nodeValue
	  				}
	  				else
	  				{
	  					document.getElementById('strength'+rowVal).value="";
	  				}
	  	        	document.getElementById('stockAvailable'+rowVal).value=totalQty.childNodes[0].nodeValue
	  	        	document.getElementById('qtyStock'+rowVal).value=totalStockQty.childNodes[0].nodeValue
	  	        	
	  	        	document.getElementById('itemId'+rowVal).value = itemId.childNodes[0].nodeValue
	  	        	
	  				
	  				var batchs  = item.getElementsByTagName("batchs")[0];
	  	        	
	  	        	for(innerLoop = 0;innerLoop <batchs.childNodes.length;innerLoop++)
	  	        	{
	  	        		var batch = batchs.childNodes[innerLoop];
	  		        	var batchId  = batch.getElementsByTagName("batchId")[0];
	  		        	var batchNumber  = batch.getElementsByTagName("batchNumber")[0];
	  		        	//alert(batchId.childNodes[0].nodeValue+"<<<abtch >  "+batchName.childNodes[0].nodeValue)
	  		        	obj.length++;
	  					//obj.options[obj.length-1].value=batchId.childNodes[0].nodeValue;
	  		        	obj.options[obj.length-1].value=batchNumber.childNodes[0].nodeValue;
	  					obj.options[obj.length-1].text=batchNumber.childNodes[0].nodeValue;
	  		        	
	  	        	}
	  	        	 var dangerousDrug = item.getElementsByTagName("dangerousDrug")[0];
	  			        if(dangerousDrug.childNodes[0].nodeValue == 'y'){
	  			        	alert("This drug is dangerous.");
	  			        }


	  			    if(totalQty.childNodes[0].nodeValue != '0.0'){
	  			    	document.getElementById('qtyIssued'+rowVal).readOnly = false;
	  			    	document.getElementById('lo'+rowVal).disabled = true;
	  			    	document.getElementById('lotQty'+rowVal).readOnly=true;
	  			    	document.getElementById('lp'+rowVal).disabled = true;
	  			    	document.getElementById('lpQty'+rowVal).readOnly=true;
	  			    }
	  			    if(totalQty.childNodes[0].nodeValue == '0.0' && totalStockQty.childNodes[0].nodeValue != '0.0' ){
	  			    	document.getElementById('qtyIssued'+rowVal).readOnly = true;
	  			    	document.getElementById('lp'+rowVal).disabled = true;
	  			    	document.getElementById('lpQty'+rowVal).readOnly=true;
	  			    	document.getElementById('lo'+rowVal).disabled = false;
	  			    	document.getElementById('lotQty'+rowVal).readOnly=false;
	  			    }
	  			  
	  			    if(totalQty.childNodes[0].nodeValue == '0.0' && totalStockQty.childNodes[0].nodeValue == '0.0' ){
	  			    	document.getElementById('qtyIssued'+rowVal).readOnly = true;
	  			    	document.getElementById('lo'+rowVal).disabled = true;
	  			    	document.getElementById('lotQty'+rowVal).readOnly=true;
	  			    	document.getElementById('lp'+rowVal).disabled = false;
	  			    	document.getElementById('lpQty'+rowVal).readOnly=false;
	  			    }
	  	      	} 
	  	      }
	  	    }
	  	   // var url=action+"&"+getNameAndData(formName)
		    var url=action;
	  	     
	  	    xmlHttp.open("GET",url,true);
	  	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	  	    xmlHttp.send(null);
	  	    
	  }
	  

	  function getICDID(formName,val) {
	  	  var xmlHttp;
	  	  try {
	  	    // Firefox, Opera 8.0+, Safari
	  	    xmlHttp=new XMLHttpRequest();
	  	  }catch (e){
	  	    // Internet Explorer
	  	    try{
	  	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	  	    }catch (e){
	  	    	alert(e)
	  	      try{
	  	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	  	      }catch (e){
	  	        alert("Your browser does not support AJAX!");
	  	        return false;
	  	      }
	  	     }
	  	   }
	  	 
	  	    xmlHttp.onreadystatechange=function()
	  	    {
	  	      if(xmlHttp.readyState==4){
	  	      
	  	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	  	      	for (loop = 0; loop < items.childNodes.length; loop++) {
	  		   	    var item = items.childNodes[loop];
	  		   	     var icd = item.getElementsByTagName("icdId")[0];	  		   	   
	  		   	    document.getElementById('icdId').value = icd.childNodes[0].nodeValue	  	        	
	  	           	
	  	        
	  	        	
	  	      	} 
	  	      }
	  	      }
	  	    xmlHttp.open("GET",'/hms/hms/registration?method=getIcdId&icdNo='+val);
	  	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	  	    xmlHttp.send(null);
	  	    
	  	  }
	  ////////////////////////////////////////////////////////////Added By SKY/////////////////////////
	  function getPvmsID(formName,val) {
	  	  var xmlHttp;
	  	  try {
	  	    // Firefox, Opera 8.0+, Safari
	  	    xmlHttp=new XMLHttpRequest();
	  	  }catch (e){
	  	    // Internet Explorer
	  	    try{
	  	      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	  	    }catch (e){
	  	    	alert(e)
	  	      try{
	  	        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	  	      }catch (e){
	  	        alert("Your browser does not support AJAX!");
	  	        return false;
	  	      }
	  	     }
	  	   }
	  	 
	  	    xmlHttp.onreadystatechange=function()
	  	    {
	  	      if(xmlHttp.readyState==4){
	  	      
	  	      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	  	      	for (loop = 0; loop < items.childNodes.length; loop++) {
	  		   	    var item = items.childNodes[loop];
	  		   	     var icd = item.getElementsByTagName("pvmsId")[0];	  		   	   
	  		   	    document.getElementById('pvmsId').value = icd.childNodes[0].nodeValue	  	        	
	  	           	
	  	        
	  	        	
	  	      	} 
	  	      }
	  	      }
	  	    xmlHttp.open("GET",'/hms/hms/store?method=getPvmsID&pvmsNiv='+val);
	  	    xmlHttp.setRequestHeader("Content-Type", "text/xml");
	  	    xmlHttp.send(null);
	  	    
	  	  }
	  
	//added by babita
	  function checkShowButton(id) {
		  if(document.getElementById("showButtonStatus").value=="n")
			  {
			  alert("please click show setup button");
			  if(id!=undefined)
			   document.getElementById(id).value="";
			  return false;
			  }
	 return true;
	  }
  function resetShowButton() {
		  document.getElementById("showButtonStatus").value="n";
	  }
	  
	  function getDetails() {
			var deptId = document.getElementById("deptId").value;
			var docId = document.getElementById("doctorId").value;
			var sesId = document.getElementById("sesId").value;
			
			if(deptId==0 || docId==0 || sesId==0)
			{
	         if(deptId==0)
		       {
			     alert("Please select Department");
			   }
			 else if(docId==0)
			   {
				alert("Please select Doctor");
			   }
			
			else if(sesId==0)
			   {
				alert("Please select Session");
			   }
		
		        return false;
			}
			
			//document.getElementById("appSetup").reset();
			  document.getElementById("showButtonStatus").value="y";
			var totalRow=document.getElementById('totalRowId').value;
			
	/*		for(var k=0;k<totalRow;k++){
				document.getElementById('TokenStart'+k).value = "";
				document.getElementById('TokenInterval'+k).value = "";
				document.getElementById('TotalToken'+k).value = "";
				document.getElementById('TotalOnlineToken'+k).value = "";
				document.getElementById('maxDays'+k).value = "";
				document.getElementById('minDays'+k).value = "";
			
			}*/

			
			
			action="/hms/hms/appointment?method=getAppDetails&deptId="+deptId+"&docId="+docId+"&sesId="+sesId;
			obj = eval('document.appSetup')
			       obj.action = action;
		    	   	 var url=action;
			    	 	//url = url+'&'+csrfTokenName+'='+csrfTokenValue; // added by amit das on 07-07-2016

	var xmlHttp=null;
	try {
	// Firefox, Opera 8.0+, Safari
	xmlHttp=new XMLHttpRequest();
	}catch (e){
	// Internet Explorer
	try{
	xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	}catch (e){
		alert(e)
	try{
	  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}catch (e){
	  alert("Your browser does not support AJAX!");
	  return false;
	}
	}
	}
	var inc=0;
	var status=false; 
	xmlHttp.onreadystatechange=function()
	{
	if(xmlHttp.readyState==4){
		var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		if( items.childNodes.length>0){
		var item1 = items.childNodes[0];
		   var timeTaken  = item1.getElementsByTagName("timeTaken")[0];
		   var startTime  = item1.getElementsByTagName("startTime")[0];
		   var endTime  = item1.getElementsByTagName("endTime")[0];
		   
		   if(undefined !=startTime.childNodes[0]){
				 document.getElementById("startTime").value = startTime.childNodes[0].nodeValue
				 }
				 else{
					 document.getElementById("startTime").value ="";
				 }
		   
		   if(undefined !=endTime.childNodes[0] && endTime.childNodes[0]!=null){
				 document.getElementById("endTime").value = endTime.childNodes[0].nodeValue
				 }
				 else{
					 document.getElementById("endTime").value ="";
				 }
		   
		   if(undefined !=timeTaken.childNodes[0]){
				 document.getElementById("timeTaken").value = timeTaken.childNodes[0].nodeValue
				 }else{
					 document.getElementById("timeTaken").value =""; 
				 }
		}
		
		for (loop = 0; loop < items.childNodes.length; loop++) {
			
		   	    var item = items.childNodes[loop];
		   	
		       var appId  = item.getElementsByTagName("appId")[0];
		       var tokenStartNo  = item.getElementsByTagName("tokenStartNo")[0];
		       var tokenInterval  = item.getElementsByTagName("tokenInterval")[0];
		       var totalToken  = item.getElementsByTagName("totalToken")[0];
		       var totalOnlineToken  = item.getElementsByTagName("totalOnlineToken")[0];
		       var maxDaysNo  = item.getElementsByTagName("maxDaysNo")[0];
		       var minDaysNo  = item.getElementsByTagName("minDaysNo")[0];
		       //var timeTaken  = item.getElementsByTagName("timeTaken")[0];
		       
		       var day = item.getElementsByTagName("day")[0];
		 for(inc=0 ; inc < 7; inc++)
		     {
		 if(day.childNodes[0] && day.childNodes[0].nodeValue==inc)      
		   {    
		if(undefined !=tokenStartNo.childNodes[0]){
		 document.getElementById("TokenStart"+inc).value = tokenStartNo.childNodes[0].nodeValue
		 status=true;
		}
		 else{
			 document.getElementById("TokenStart"+inc).value =""
		 }
		 if(undefined !=tokenInterval.childNodes[0]){
		 document.getElementById("TokenInterval"+inc).value = tokenInterval.childNodes[0].nodeValue
		 status=true;
		 }
		 else{
			 document.getElementById("TokenInterval"+inc).value = "";
		 }
		 if(undefined !=totalToken.childNodes[0]){
		 document.getElementById("TotalToken"+inc).value = totalToken.childNodes[0].nodeValue
		 status=true;
		 }
		 else{
			 document.getElementById("TotalToken"+inc).value ="";
		 }
		 
		 if(undefined !=totalOnlineToken.childNodes[0]){
			 document.getElementById("TotalOnlineToken"+inc).value = totalOnlineToken.childNodes[0].nodeValue
			 status=true;
			 }
			 else{
				 document.getElementById("TotalOnlineToken"+inc).value ="";
			 }
		 if(undefined !=maxDaysNo.childNodes[0]){
		 document.getElementById("maxDays"+inc).value = maxDaysNo.childNodes[0].nodeValue
		 }
		 else{
			 document.getElementById("maxDays"+inc).value = ""; 
		 }
		 if(undefined !=minDaysNo.childNodes[0]){
		 document.getElementById("minDays"+inc).value = minDaysNo.childNodes[0].nodeValue
		 }else{
			 document.getElementById("minDays"+inc).value =""; 
		 }
		 if(undefined !=appId.childNodes[0]){
		 document.getElementById("appointmentId"+inc).value = appId.childNodes[0].nodeValue
		 }
		 else{
			 document.getElementById("appointmentId"+inc).value ="";
		 }
			
	/*	 if(undefined !=timeTaken.childNodes[0]){
			 document.getElementById("timeTaken"+inc).value = timeTaken.childNodes[0].nodeValue
			 }else{
				 document.getElementById("timeTaken"+inc).value =""; 
			 }*/
		 
		}
		 //inc++;
		}		   
				   
		 if(status){
		document.getElementById("updateId").style.display = 'block';
			document.getElementById("addId").style.display = 'none';
		 }
		 else{
			 document.getElementById("updateId").style.display = 'none';
				document.getElementById("addId").style.display = 'block';
		 }
		
		}
	}
	}
	var url=action;
	//	url = url+'&'+csrfTokenName+'='+csrfTokenValue; // added by amit das on 07-07-2016

	xmlHttp.open("GET",url,false);
	xmlHttp.setRequestHeader("Content-Type", "text/xml");
	xmlHttp.send(null);


	}
	  //================================Accounts Method ========================================

	  function showCrBalanceInAjax(formName){
		var subledId;
	  	var accountId=document.getElementById('mainAccountId').value;
	   	var voucherDate=document.getElementById('voucherDate').value;
	   	if(document.getElementById('subLedId')!=null){
	 		subledId =document.getElementById('subLedId').value;
	 	 		
	 	}
	   	 	
	  	if(accountId != 0){
	  		
	  		if(subledId){
	  			action="/hms/hms/account?method=showAccountCrBalance&accountId="+accountId+"&subledId="+subledId+"&voucherDate="+voucherDate;
			}else{
				action="/hms/hms/account?method=showAccountCrBalance&accountId="+accountId;
			}
	  		
	  		obj = eval('document.'+formName)
	  		       obj.action = action;
	  	    	   	 var url=action
		 
			    	   	 
	    var xmlHttp;
	    try {
	      // Firefox, Opera 8.0+, Safari
	      xmlHttp=new XMLHttpRequest();
	    }catch (e){
	      // Internet Explorer
	      try{
	        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	      }catch (e){
	      	alert(e)
	        try{
	          xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	        }catch (e){
	          alert("Your browser does not support AJAX!");
	          return false;
	        }
	       }
	     }
	      xmlHttp.onreadystatechange=function()
	      {
	        if(xmlHttp.readyState==4){
	        	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	        	for (loop = 0; loop < items.childNodes.length; loop++) {
	  	   	    var item = items.childNodes[loop];
	  	        var balance  = item.getElementsByTagName("balance")[0];
	  	         obj=eval(document.getElementById('balanceId'))
	  	      if(balance.childNodes[0].nodeValue != undefined){
	  	      document.getElementById('balanceId').value=balance.childNodes[0].nodeValue;
	  	       }
	  	       var groupId  = item.getElementsByTagName("groupId")[0];
	  	        obj=eval(document.getElementById('groupId'))
	  	         if(groupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('groupId').value=groupId.childNodes[0].nodeValue;
	  	       }
	  	       var subGroupId  = item.getElementsByTagName("subGroupId")[0];
	  	        obj=eval(document.getElementById('subGroupId'))
	  	         if(subGroupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('subGroupId').value=subGroupId.childNodes[0].nodeValue;
	  	       }
	        	}
	        }
	      }
	      var url=action

	      xmlHttp.open("GET",url,true);
	      xmlHttp.setRequestHeader("Content-Type", "text/xml");
	      xmlHttp.send(null);

	      }
	   }

	  function showAllBalanceInAjaxSub(formName,inc){
	  	if(document.getElementById('accountNameBankId'+inc)!= null )
	  	{
	  		if( document.getElementById('accountNameBankId'+inc).value != "")
	  		{
	  			var accountNameId1=document.getElementById('accountNameBankId'+inc).value;
	  		}	
	  	}
	  	 //if(document.getElementById('accountNameId'+inc)!= null )
	  	 if(document.getElementById('accountNameId'+inc) != null )
	  	 {	
	  		 if( document.getElementById('accountNameId'+inc).value!= "")
	  		 {
	  		var accountNameId1=document.getElementById('accountNameId'+inc).value;
	  		 }
	  	}
	   	var resrate =document.getElementById('resrate'+inc).value;
	   	var voucherDate=document.getElementById('voucherDate').value;
	   		 	//alert("showCrBalanceInAjax method==="+accountId);
	  	if(accountNameId1 != null && accountNameId1!=""){		
	  			action="/hms/hms/account?method=showAccountBal&accountNameId="+accountNameId1+"&resrate="+resrate+"&voucherDate="+voucherDate;
	  		}
	  		obj = eval('document.'+formName)
	  		       obj.action = action;
	  	    	   	 var url=action

	    var xmlHttp;
	    try {
	      // Firefox, Opera 8.0+, Safari
	      xmlHttp=new XMLHttpRequest();
	    }catch (e){
	      // Internet Explorer
	      try{
	        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	      }catch (e){
	      	alert(e)
	        try{
	          xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	        }catch (e){
	          alert("Your browser does not support AJAX!");
	          return false;
	        }
	       }
	     }
	      xmlHttp.onreadystatechange=function()
	      {
	        if(xmlHttp.readyState==4){
	        	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	        	/*alert(items);*/
	        	for (loop = 0; loop < items.childNodes.length; loop++) {
	  	   	    var item = items.childNodes[loop];
	  	        var balance  = items.getElementsByTagName("balance")[0];
	  	         obj=eval(document.getElementById('balanceId'))
	  	      if(balance.childNodes[0].nodeValue != undefined){
	  	      document.getElementById('balanceId').value=balance.childNodes[0].nodeValue;
	  	       }
	  	       var groupId  = item.getElementsByTagName("groupId")[0];
	  	        obj=eval(document.getElementById('groupId'))
	  	         if(groupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('groupId').value=groupId.childNodes[0].nodeValue;
	  	       }
	  	       var subGroupId  = item.getElementsByTagName("subGroupId")[0];
	  	        obj=eval(document.getElementById('subGroupId'))
	  	         if(subGroupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('subGroupId').value=subGroupId.childNodes[0].nodeValue;
	  	       }
	        	}
	        }
	      }
	      var url=action

	      xmlHttp.open("GET",url,true);
	      xmlHttp.setRequestHeader("Content-Type", "text/xml");
	      xmlHttp.send(null);

	      }
	   

	  function showAllBalanceInAjax(formName,inc){
	  	
	  if(document.getElementById('accountNameBankId'+inc)!= null )
	  {
	  	if( document.getElementById('accountNameBankId'+inc).value != "")
	  	{
	  	var accountNameId1=document.getElementById('accountNameBankId'+inc).value;
	  	}
	  }
	   //if(document.getElementById('accountNameId'+inc)!= null )
	   if(document.getElementById('accountNameId'+inc) != null )
	   {	
	  	 if( document.getElementById('accountNameId'+inc).value!= "")
	  	 {
	  	var accountNameId1=document.getElementById('accountNameId'+inc).value;
	  	 }
	   }
	   	var voucherDate=document.getElementById('voucherDate').value;
	   		 	//alert("showCrBalanceInAjax method==="+accountId);
	   		if(accountNameId1 != null && accountNameId1!=""){		
	  		action="/hms/hms/account?method=showAccountBal&accountNameId="+accountNameId1+"&voucherDate="+voucherDate;
	  		obj = eval('document.'+formName)
	  		       obj.action = action;
	  	    	   	 var url=action
	    var xmlHttp;
	    try {
	      // Firefox, Opera 8.0+, Safari
	      xmlHttp=new XMLHttpRequest();
	    }catch (e){
	      // Internet Explorer
	      try{
	        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	      }catch (e){
	      	alert(e)
	        try{
	          xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	        }catch (e){
	          alert("Your browser does not support AJAX!");
	          return false;
	        }
	       }
	     }
	      xmlHttp.onreadystatechange=function()
	      {
	        if(xmlHttp.readyState==4){
	        	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	        	/*alert(items);*/
	        	for (loop = 0; loop < items.childNodes.length; loop++) {
	  	   	    var item = items.childNodes[loop];
	  	        var balance  = items.getElementsByTagName("balance")[0];
	  	         obj=eval(document.getElementById('balanceId'))
	  	      if(balance.childNodes[0].nodeValue != undefined){
	  	      document.getElementById('balanceId').value=balance.childNodes[0].nodeValue;
	  	       }
	  	       var groupId  = item.getElementsByTagName("groupId")[0];
	  	        obj=eval(document.getElementById('groupId'))
	  	         if(groupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('groupId').value=groupId.childNodes[0].nodeValue;
	  	       }
	  	       var subGroupId  = item.getElementsByTagName("subGroupId")[0];
	  	        obj=eval(document.getElementById('subGroupId'))
	  	         if(subGroupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('subGroupId').value=subGroupId.childNodes[0].nodeValue;
	  	       }
	        	}
	        }
	      }
	      var url=action

	      xmlHttp.open("GET",url,true);
	      xmlHttp.setRequestHeader("Content-Type", "text/xml");
	      xmlHttp.send(null);

	      }
	   }



	  function showBalanceInAjax(formName){
	   	var accountId=document.getElementById('mainAccountId').value;
	   	//alert("showBalanceInAjax method==="+accountId);
	  	if(accountId != 0){
	  		action="/hms/hms/account?method=showAccountBalance&accountId="+accountId;
	  		obj = eval('document.'+formName)
	  		       obj.action = action;
	  	    	   	 var url=action

	    var xmlHttp;
	    try {
	      // Firefox, Opera 8.0+, Safari
	      xmlHttp=new XMLHttpRequest();
	    }catch (e){
	      // Internet Explorer
	      try{
	        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	      }catch (e){
	      	alert(e)
	        try{
	          xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	        }catch (e){
	          alert("Your browser does not support AJAX!");
	          return false;
	        }
	       }
	     }
	      xmlHttp.onreadystatechange=function()
	      {
	        if(xmlHttp.readyState==4){
	        	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	        	for (loop = 0; loop < items.childNodes.length; loop++) {
	  	   	    var item = items.childNodes[loop];
	  	        var balance  = item.getElementsByTagName("balance")[0];
	  	         obj=eval(document.getElementById('balanceId'))
	  	      if(balance.childNodes[0].nodeValue != undefined){
	  	      document.getElementById('balanceId').value=balance.childNodes[0].nodeValue;
	  	       }
	  	        var groupId  = item.getElementsByTagName("groupId")[0];
	  	        obj=eval(document.getElementById('groupId'))
	  	         if(groupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('groupId').value=groupId.childNodes[0].nodeValue;
	  	       }
	  	       var subGroupId  = item.getElementsByTagName("subGroupId")[0];
	  	        obj=eval(document.getElementById('subGroupId'))
	  	         if(subGroupId.childNodes[0].nodeValue != undefined){
	  	     	 document.getElementById('subGroupId').value=subGroupId.childNodes[0].nodeValue;
	  	       }
	        	}
	        }
	      }
	      var url=action

	      xmlHttp.open("GET",url,true);
	      xmlHttp.setRequestHeader("Content-Type", "text/xml");
	      xmlHttp.send(null);

	      }
	   }

	  //by:Ujjwal on behalf of Nilay Shankar
	  function ajaxFunctionForPatientNameTitle(formName) {
	         var xmlHttp;
	        try {
	          // Firefox, Opera 8.0+, Safari
	          xmlHttp=new XMLHttpRequest();
	        }catch (e){
	          // Internet Explorer
	          try{
	            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	          }catch (e){
	                  alert(e)
	            try{
	              xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	            }catch (e){
	              alert("Your browser does not support AJAX!");
	              return false;
	            }
	           }
	         }

	          xmlHttp.onreadystatechange=function()
	          {
	            if(xmlHttp.readyState==4){titleName
	                  
	                    var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	                    for (loop = 0; loop < items.childNodes.length; loop++) {
	                             var item = items.childNodes[loop];
	                             var name =  item.getElementsByTagName("name")[0];
	                             var titleId = item.getElementsByTagName("titleId")[0];
	                          var titleName = item.getElementsByTagName("titleName")[0];
	                        
	                          document.getElementById('name').value = name.childNodes[0].nodeValue
	                         document.getElementById('titleId').value = titleId.childNodes[0].nodeValue
	                         document.getElementById('titleName').value = titleName.childNodes[0].nodeValue
	                
	                    }
	            }
	            }

	          xmlHttp.open("GET",'/hms/hrms/training?method=getNameTitle&hinNo='+document.getElementById("hinNo").value,true);
	          xmlHttp.setRequestHeader("Content-Type", "text/xml");
	          xmlHttp.send(null);

	        }

	  function ajaxFunctionForEmployeeNameDepartment(formName) {
	      //alert("in proto .js");
	      //alert("formName >"+formName);
	        var xmlHttp;
	        try {
	          // Firefox, Opera 8.0+, Safari
	          xmlHttp=new XMLHttpRequest();
	        }catch (e){
	          // Internet Explorer
	          try{
	            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	          }catch (e){
	                  alert(e)
	            try{
	              xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	            }catch (e){
	              alert("Your browser does not support AJAX!");
	              return false;
	            }
	           }
	         }

	          xmlHttp.onreadystatechange=function()
	          {
	            if(xmlHttp.readyState==4){departmentName
	                  // alert("hi--"+xmlHttp.responseXML.getElementsByTagName('items')[0]);
	                    var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	                    for (loop = 0; loop < items.childNodes.length; loop++) {
	                             var item = items.childNodes[loop];
	                             var name =  item.getElementsByTagName("name")[0];
	                             var departmentId = item.getElementsByTagName("departmentId")[0];
	                          var departmentName = item.getElementsByTagName("departmentName")[0];
	                        
	                          document.getElementById('name').value = name.childNodes[0].nodeValue
	                         document.getElementById('departmentId').value = departmentId.childNodes[0].nodeValue
	                         document.getElementById('departmentName').value = departmentName.childNodes[0].nodeValue
	                
	                    }
	            }
	            }

	          xmlHttp.open("GET",'/hms/hrms/training?method=getNameDepartment&empCode='+document.getElementById("empCode").value,true);
	          xmlHttp.setRequestHeader("Content-Type", "text/xml");
	          xmlHttp.send(null);

	        }
	  //---------------By Ujjwal
	  function submitProtoAjaxWithDivNameForAppointment(formName,action,divName){

	  	errorMsg = "";
	  	ob1 = true;
	  	ob2 = true;
	  	ob3 = true;
	  	obj = eval('document.'+formName)

	  	       	obj.action = action;
	  	       // var url=action+"&"+getNameAndData(formName)
	  	        var url=action;
	          	new Ajax.Updater(divName,url,
	  			   {asynchronous:true, evalScripts:true });

	  	       	return true;
	      }
	  
	  function addAccountsNarrationInAjax(formName,inc){
		 	var accountNarration=document.getElementById('accountNarrationId'+inc).value;

			if(accountNarration!= ""){
				action="/hms/hms/account?method=showAccountNarration&accountNarration="+accountNarration;
				/*var obj = eval('document.'+formName)
				       obj.action = action;
			    	   	 var url=action;*/

		  var xmlHttp;
		  try {
		    // Firefox, Opera 8.0+, Safari
		    xmlHttp=new XMLHttpRequest();
		  }catch (e){
		    // Internet Explorer
		    try{
		      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		    }catch (e){
		    	alert(e)
		      try{
		        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }catch (e){
		        alert("Your browser does not support AJAX!");
		        return false;
		      }
		     }
		   }
		    xmlHttp.onreadystatechange=function()
		    {
		      if(xmlHttp.readyState==4){
		      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
		      	for (loop = 0; loop < items.childNodes.length; loop++) {
			   	    var item = items.childNodes[loop];
			        var message  = item.getElementsByTagName("message")[0];
			      if(message.childNodes[0] != undefined)
				 	alert(message.childNodes[0].nodeValue);

		      	}
		      }
		    }
		    var url=action;

		     // xmlHttp.open("GET",url,true);
		    // commented by amit das on 24-01-2017
		   // added by amit das on 24-01-2017
		    /*url = url+'&'+tokenName+'='+tokenValue;*/
		     xmlHttp.open("POST",url,true);
		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
		    xmlHttp.send(null);

		    }else {
		    	alert("Please enter Narration.")
		    	return false;
		    }
		 }
	  


	  function addNarrationInAjax(formName){
	   	var voucherNarration=document.getElementById('voucherNarrationId').value;

	  	if(voucherNarration != ""){
	  		action="/hms/hms/account?method=addVoucherNarration&voucherNarration="+voucherNarration;
	  		obj = eval('document.'+formName)
	  		       obj.action = action;
	  	    	   	 var url=action

	    var xmlHttp;
	    try {
	      // Firefox, Opera 8.0+, Safari
	      xmlHttp=new XMLHttpRequest();
	    }catch (e){
	      // Internet Explorer
	      try{
	        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	      }catch (e){
	      	alert(e)
	        try{
	          xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	        }catch (e){
	          alert("Your browser does not support AJAX!");
	          return false;
	        }
	       }
	     }
	      xmlHttp.onreadystatechange=function()
	      {
	        if(xmlHttp.readyState==4){
	        	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
	        	for (loop = 0; loop < items.childNodes.length; loop++) {
	  	   	    var item = items.childNodes[loop];
	  	        var message  = item.getElementsByTagName("message")[0];
	  	      if(message.childNodes[0] != undefined)
	  		 	alert(message.childNodes[0].nodeValue);

	        	}
	        }
	      }
	      var url=action;

	   // xmlHttp.open("GET",url,true);
	      // commented by amit das on 24-01-2017
	      
	  	  // added by amit das on 24-01-2017
	      /*url = url+'&'+tokenName+'='+tokenValue;*/
	       xmlHttp.open("POST",url,true);
	      xmlHttp.setRequestHeader("Content-Type", "text/xml");
	      xmlHttp.send(null);

	      }else {
	      	alert("Please enter Narration to add to template.")
	      	return false;
	      }
	   }
	  
	  
	  
	  /*
	  Table sorting script, taken from http://www.kryogenix.org/code/browser/sorttable/ .
	  Distributed under the MIT license: http://www.kryogenix.org/code/browser/licence.html .

	  Adaptation by Joost de Valk ( http://www.joostdevalk.nl/ ) to add alternating row classes as well.

	  Copyright (c) 1997-2006 Stuart Langridge, Joost de Valk.
	  */

	  
	  //sorttable Account.js
	  
	  /* Change these values */
	  var image_path = "/erp/jsp/images/";
	  var image_up = "arrowUp.gif";
	  var image_down = "arrowDown.gif";
	  var image_none = "arrow-none.gif";

	  /* Don't change anything below this unless you know what you're doing */
	  addEvent(window, "load", sortables_init);

	  var SORT_COLUMN_INDEX;

	  function sortables_init() {
	  	// Find all tables with class sortable and make them sortable
	  	if (!document.getElementsByTagName) return;
	  	tbls = document.getElementsByTagName("table");
	  	for (ti=0;ti<tbls.length;ti++) {
	  		thisTbl = tbls[ti];
	  		if (((' '+thisTbl.className+' ').indexOf("sortable") != -1) && (thisTbl.id)) {
	  			//initTable(thisTbl.id);
	  			ts_makeSortable(thisTbl);
	  			//sum_up(thisTbl);
	  		}
	  	}
	  }

	  function ts_makeSortable(table) {
	  	if (table.rows && table.rows.length > 0) {
	  		var firstRow = table.rows[0];
	  	}
	  	if (!firstRow) return;
	  	// We have a first row: assume it's the header, and make its contents clickable links
	  	for (var i=0;i<firstRow.cells.length;i++) {
	  		var cell = firstRow.cells[i];
	  		var txt = ts_getInnerText(cell);
	  		if (cell.className != "unsortable" && cell.className.indexOf("unsortable") == -1) {
	  			cell.innerHTML = '<a href="#" onclick="ts_resortTable(this);return false;">'+txt+'<img src="'+ image_path + image_up + '" alt="&darr;"/></a>';
	  		}
	  	}
	  	//alternate(table);
	  }

	  function ts_getInnerText(el) {
	  	if (typeof el == "string") return el;
	  	if (typeof el == "undefined") { return el };
	  	if (el.innerText) return el.innerText;	//Not needed but it is faster
	  	var str = "";

	  	var cs = el.childNodes;
	  	var l = cs.length;
	  	for (var i = 0; i < l; i++) {
	  		switch (cs[i].nodeType) {
	  			case 1: //ELEMENT_NODE
	  				str += ts_getInnerText(cs[i]);
	  				break;
	  			case 3:	//TEXT_NODE
	  				str += cs[i].nodeValue;
	  				break;
	  		}
	  	}
	  	return str;
	  }

	  function ts_resortTable(lnk) {
	  	// get the span
	  	var span;
	  	for (var ci=0;ci<lnk.childNodes.length;ci++) {
	  		if (lnk.childNodes[ci].tagName && lnk.childNodes[ci].tagName.toLowerCase() == 'span') span = lnk.childNodes[ci];
	  	}
	  	var spantext = ts_getInnerText(span);
	  	var td = lnk.parentNode;
	  	var column = td.cellIndex;
	  	var table = getParent(td,'TABLE');

	  	// Work out a type for the column
	  	if (table.rows.length <= 1) return;
	  	var itm = ts_getInnerText(table.rows[1].cells[column]);
	  	sortfn = ts_sort_caseinsensitive;
	  	if (itm.match(/^\d\d[\/-]\d\d[\/-]\d\d\d\d$/)) sortfn = ts_sort_date;
	  	if (itm.match(/^\d\d[\/-]\d\d[\/-]\d\d$/)) sortfn = ts_sort_date;
	  	if (itm.match(/^[£$€]/)) sortfn = ts_sort_currency;
	  	if (itm.match(/^[\d\.]+$/)) sortfn = ts_sort_numeric;
	  	SORT_COLUMN_INDEX = column;
	  	var firstRow = new Array();
	  	var newRows = new Array();
	  	for (i=0;i<table.rows[0].length;i++) {
	  		firstRow[i] = table.rows[0][i];
	  	}
	  	for (j=1;j<table.rows.length;j++) {
	  		newRows[j-1] = table.rows[j];
	  	}

	  	newRows.sort(sortfn);

	  	if (span.getAttribute("sortdir") == 'down') {
	  			ARROW = '&nbsp;&nbsp;<img src="'+ image_path + image_up + '" alt="&uarr;"/>';
	  			newRows.reverse();
	  			span.setAttribute('sortdir','up');
	  	} else {
	  			ARROW = '&nbsp;&nbsp;<img src="'+ image_path + image_down + '" alt="&darr;"/>';
	  			span.setAttribute('sortdir','down');
	  	}

	      // We appendChild rows that already exist to the tbody, so it moves them rather than creating new ones
	      // don't do sortbottom rows
	      for (i=0; i<newRows.length; i++) {
	  		if (!newRows[i].className || (newRows[i].className && (newRows[i].className.indexOf('sortbottom') == -1))) {
	  			table.tBodies[0].appendChild(newRows[i]);
	  		}
	  	}
	      // do sortbottom rows only
	      for (i=0; i<newRows.length; i++) {
	  		if (newRows[i].className && (newRows[i].className.indexOf('sortbottom') != -1))
	  			table.tBodies[0].appendChild(newRows[i]);
	  	}

	  	// Delete any other arrows there may be showing
	  	var allspans = document.getElementsByTagName("span");
	  	for (var ci=0;ci<allspans.length;ci++) {
	  		if (allspans[ci].className == 'sortarrow') {
	  			if (getParent(allspans[ci],"table") == getParent(lnk,"table")) { // in the same table as us?
	  				allspans[ci].innerHTML = '&nbsp;&nbsp;<img src="'+ image_path + image_up + '" alt="&darr;"/>';
	  			}
	  		}
	  	}

	  	span.innerHTML = ARROW;
//	  	alternate(table);
	  }

	  function getParent(el, pTagName) {
	  	if (el == null) {
	  		return null;
	  	} else if (el.nodeType == 1 && el.tagName.toLowerCase() == pTagName.toLowerCase()) {	// Gecko bug, supposed to be uppercase
	  		return el;
	  	} else {
	  		return getParent(el.parentNode, pTagName);
	  	}
	  }
	  function ts_sort_date(a,b) {
	  	// y2k notes: two digit years less than 50 are treated as 20XX, greater than 50 are treated as 19XX
	  	aa = ts_getInnerText(a.cells[SORT_COLUMN_INDEX]);
	  	bb = ts_getInnerText(b.cells[SORT_COLUMN_INDEX]);
	  	if (aa.length == 10) {
	  			dt1 = aa.substr(6,4)+aa.substr(3,2)+aa.substr(0,2);
	  	} else {
	  			yr = aa.substr(6,2);
	  			if (parseInt(yr) < 50) {
	  				yr = '20'+yr;
	  			} else {
	  				yr = '19'+yr;
	  			}
	  			dt1 = yr+aa.substr(3,2)+aa.substr(0,2);
	  	}
	  	if (bb.length == 10) {
	  			dt2 = bb.substr(6,4)+bb.substr(3,2)+bb.substr(0,2);
	  	} else {
	  			yr = bb.substr(6,2);
	  			if (parseInt(yr) < 50) {
	  				yr = '20'+yr;
	  			} else {
	  				yr = '19'+yr;
	  			}
	  			dt2 = yr+bb.substr(3,2)+bb.substr(0,2);
	  	}
	  	if (dt1==dt2) {
	  		return 0;
	  	}
	  	if (dt1<dt2) {
	  		return -1;
	  	}
	  	return 1;
	  }

	  function ts_sort_currency(a,b) {
	  	aa = ts_getInnerText(a.cells[SORT_COLUMN_INDEX]).replace(/[^0-9.]/g,'');
	  	bb = ts_getInnerText(b.cells[SORT_COLUMN_INDEX]).replace(/[^0-9.]/g,'');
	  	return parseFloat(aa) - parseFloat(bb);
	  }

	  function ts_sort_numeric(a,b) {
	  	aa = parseFloat(ts_getInnerText(a.cells[SORT_COLUMN_INDEX]));
	  	if (isNaN(aa)) {
	  		aa = 0;
	  	}
	  	bb = parseFloat(ts_getInnerText(b.cells[SORT_COLUMN_INDEX]));
	  	if (isNaN(bb)) {
	  		bb = 0;
	  	}
	  	return aa-bb;
	  }

	  function ts_sort_caseinsensitive(a,b) {
	  	aa = ts_getInnerText(a.cells[SORT_COLUMN_INDEX]).toLowerCase();
	  	bb = ts_getInnerText(b.cells[SORT_COLUMN_INDEX]).toLowerCase();
	  	if (aa==bb) {
	  		return 0;
	  	}
	  	if (aa<bb) {
	  		return -1;
	  	}
	  	return 1;
	  }

	  function ts_sort_default(a,b) {
	  	aa = ts_getInnerText(a.cells[SORT_COLUMN_INDEX]);
	  	bb = ts_getInnerText(b.cells[SORT_COLUMN_INDEX]);
	  	if (aa==bb) {
	  		return 0;
	  	}
	  	if (aa<bb) {
	  		return -1;
	  	}
	  	return 1;
	  }

	  function addEvent(elm, evType, fn, useCapture)
	  // addEvent and removeEvent
	  // cross-browser event handling for IE5+,	NS6 and Mozilla
	  // By Scott Andrew
	  {
	  	if (elm.addEventListener){
	  		elm.addEventListener(evType, fn, useCapture);
	  		return true;
	  	} else if (elm.attachEvent){
	  		var r = elm.attachEvent("on"+evType, fn);
	  		return r;
	  	} else {
	  		alert("Handler could not be removed");
	  	}
	  }

	  function replace(s, t, u) {
	    /*
	    **  Replace a token in a string
	    **    s  string to be processed
	    **    t  token to be found and removed
	    **    u  token to be inserted
	    **  returns new String
	    */
	    i = s.indexOf(t);
	    r = "";
	    if (i == -1) return s;
	    r += s.substring(0,i) + u;
	    if ( i + t.length < s.length)
	      r += replace(s.substring(i + t.length, s.length), t, u);
	    return r;
	  }

	  function alternate(table) {
	  	// Take object table and get all it's tbodies.
	  	var tableBodies = table.getElementsByTagName("tbody");
	  	// Loop through these tbodies
	  	for (var i = 0; i < tableBodies.length; i++) {
	  		// Take the tbody, and get all it's rows
	  		var tableRows = tableBodies[i].getElementsByTagName("tr");
	  		// Loop through these rows
	  		// Start at 1 because we want to leave the heading row untouched
	  		for (var j = 1; j < tableRows.length; j++) {
	  			// Check if j is even, and apply classes for both possible results
	  			if ( (j % 2) == 0  ) {
	  				if (tableRows[j].className == 'odd' || !(tableRows[j].className.indexOf('odd') == -1) ) {
	  					tableRows[j].className = replace(tableRows[j].className, 'odd', 'even');
	  				} else {
	  					tableRows[j].className += " even";
	  				}
	  			} else {
	  				if (tableRows[j].className == 'even' || !(tableRows[j].className.indexOf('even') == -1) ) {
	  					tableRows[j].className = replace(tableRows[j].className, 'even', 'odd');
	  				}
	  				tableRows[j].className += " odd";
	  			}
	  		}
	  	}
	  }
	  
	  
	  