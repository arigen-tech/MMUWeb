function ajaxFunctionForAutoComplete(formName,action,rowVal) {
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
  
  
  ////new ajax by yogesh 
  function ajaxFunctionForAutoCompleteForAdjustment(formName,action,rowVal) {
  var xmlHttp;
 // alert('in ajaxFunctionForAutoCompleteForAdjustment');
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
	        var nomenclature  = item.getElementsByTagName("nomenclature")[0];
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('nameItem'+rowVal).value=nomenclature.childNodes[0].nodeValue+"["+pvms.childNodes[0].nodeValue+"]"
        	
        	var batchs =item.getElementsByTagName('batchs')[0] ;
        	
        	var selectbatch = document.getElementById('itemBatchNoCombo'+rowVal);
        	var selectQty = document.getElementById('itemClosingStock'+rowVal);
        	
        	for(loop1 = 0 ; loop1<batchs.childNodes.length ; loop1++){
        	
        		var batch = batchs.childNodes[loop1] ;
        		
        			var batchId = batch.getElementsByTagName("batchId")[0];
        		    var brandId = batch.getElementsByTagName("brandId")[0];
        		    var batchnumber = batch.getElementsByTagName("batchNumber")[0];
        			var expiry = batch.getElementsByTagName("expiry")[0];
        			var closingStock = batch.getElementsByTagName("closingStock")[0];
        			document.getElementById('itemExpiryDate'+rowVal).value=expiry.childNodes[0].nodeValue
        			document.getElementById('itemBrandId'+rowVal).value=brandId.childNodes[0].nodeValue
        			var myOption = document.createElement("Option");
        			var QtyOption = document.createElement("Option");
        			myOption.value=batchnumber.childNodes[0].nodeValue //batchId.childNodes[0].nodeValue
        			myOption.text=batchnumber.childNodes[0].nodeValue
        			QtyOption.value=closingStock.childNodes[0].nodeValue
        			QtyOption.text=closingStock.childNodes[0].nodeValue
        			selectbatch.appendChild(myOption);
        			selectQty.appendChild(QtyOption);
        		
        	}
      		
      	} 
                 	
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  ////end of ajax by yogesh
   
  
  
   function fillGridIssueToOTAFU(formName,action,rowVal) {
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
      	if(items.childNodes.length==0){
      	alert("Item not found with given LotNo...!")
      	document.getElementById('lotNo'+rowVal).value=""
      	return false;
      	}
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
        	document.getElementById('nameItem'+rowVal).value = name.childNodes[0].nodeValue
        		document.getElementById('issuedItemId'+rowVal).value = id.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
  }
  
   
  
 //------------------------------------ start of functions by mansi--------------------------- 
  function ajaxFunctionForAutoCompleteInBalance(formName,action,rowVal) {
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
	        var brandLength  = item.getElementsByTagName("brands")[0];
	  //      var batchNo  = item.getElementsByTagName("batchNo")[0];
	            
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
      //  	document.getElementById('batchNo'+rowVal).value = batchNo.childNodes[0].nodeValue
        	document.getElementById('ajaxFunctionForAutoCompleteInBalance'+rowVal).value = stockIn.childNodes[0].nodeValue
        	
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
  
  function ajaxFunctionForAutoCompleteB(formName,action,rowVal) {
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
        	
        	document.getElementById('qtyInHand'+rowVal).value = stock.childNodes[0].nodeValue
        	document.getElementById('qtyInHandTemp'+rowVal).value = stock.childNodes[0].nodeValue
        	document.getElementById('mmfVarTemp'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
        	document.getElementById('mmfVar'+rowVal).value = qtyInMMF.childNodes[0].nodeValue
        	document.getElementById('section'+rowVal).value = section.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
  function ajaxFunctionForAutoAA(formName,action,rowVal) {
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
		
		var manufacturerId ="manuId"+rowVal;
		obj1 = document.getElementById(manufacturerId); 
		obj1.length = 1;
		
      	for (loop = 0; loop < items.childNodes.length; loop++) {
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var nomenclature  = item.getElementsByTagName("nomenclature")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        
	        var brandLength  = item.getElementsByTagName("brands")[0];
	       
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('nameItem'+rowVal).value = nomenclature.childNodes[0].nodeValue + "["+pvms.childNodes[0].nodeValue+"]"
        	
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
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
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
    
  //------------------------------------ end of functions by mansi---------------------------
    
  
  // Start of functions By Deepti

function ajaxFunctionForAutoCompleteForPurchase(formName,action,rowVal) {
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
    var url=action
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    xmlHttp.onreadystatechange=function()
    {
      if(xmlHttp.readyState==4){
      	var items =xmlHttp.responseXML.getElementsByTagName('items')[0];
      	var brandId="brandId"+rowVal;
		obj =document.getElementById(brandId); 
		obj.length = 1;
		
		var manufacturerId="manufacturerId"+rowVal;
		obj1 =document.getElementById(manufacturerId); 
		obj1.length = 1;
      	
      	for (loop = 0; loop < items.childNodes.length; loop++) 
      	{
	   	    var item = items.childNodes[loop];
	        var id  = item.getElementsByTagName("id")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	       // var name  = item.getElementsByTagName("name")[0];
	        var dispType = item.getElementsByTagName("dispType")[0];
	        var brandLength  = item.getElementsByTagName("brands")[0];
	        
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	//document.getElementById('dispenseType'+rowVal).value = dispType.childNodes[0].nodeValue 
            var dispenseType ="dispenseType"+rowVal;
            obj2 = document.getElementById(dispenseType);
            
           	obj2.length=1;
			obj2.options[obj2.length-1].value = dispType.childNodes[0].nodeValue;
			obj2.options[obj2.length-1].text  = dispType.childNodes[0].nodeValue;
        	
        	for(innerLoop = 0;innerLoop < brandLength.childNodes.length;innerLoop++)
        	{
        		var brand = brandLength.childNodes[innerLoop];
	        	var brandId  = brand.getElementsByTagName("brandId")[0];
	        	var brandName  = brand.getElementsByTagName("brandName")[0];
	        	var manufacturerId = brand.getElementsByTagName("manufacturerId")[0];
	        	var manufacturerName = brand.getElementsByTagName("manufacturerName")[0];
	        	
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
}

// End Of Functions By Deepti
  //-----------------------------------Start of Function written By Vivek------------------------------------------
  function checkHinExistence(formName,action,rowVal) {
 
  if(rowVal==""){
  return false
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
	        var hinNo  = item.getElementsByTagName("hinNo")[0];
	       
        	if( hinNo.childNodes[0].nodeValue=="Yes"){
        	return true;
        	}else{
        		alert("Wrong Hin No ...!")
        		document.getElementById('patientName').value =""
        		
        		return false
        	}
       
        	
      	} 
      }
    }
    var url=action
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
   function ajaxFunctionForAutoCompleteDepartmentIssueNE(formName,action,rowVal) {
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
	        var stockIn  = item.getElementsByTagName("stockIn")[0];
	        var serialNo  = item.getElementsByTagName("serialNo")[0];
        	document.getElementById('codeItem'+rowVal).value = pvms.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('stockIn'+rowVal).value = stockIn.childNodes[0].nodeValue
        	document.getElementById('lotNo'+rowVal).value = serialNo.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
  //-----------------------------------Start of Function written By Vivek------------------------------------------
  
  //---------------Added at Bangalore on 10-07-08----------
   
   function checkBedForWard(selectedward, currentWard, otId, displayDiv, bedNoFieldId, bedIdFieldId,currentBedNo, currentBedId, bedDiv, wardFieldId, doctorDropListId, procedureDiv){
	   document.getElementById(bedDiv).style.display = 'block';
	   if(selectedward==otId)
		   {
		      document.getElementById(procedureDiv).style.display = 'block';
		   }
	   else
		   {
		   document.getElementById(procedureDiv).style.display = 'none';
		   }
	   
	   if(selectedward==currentWard || selectedward==otId )
		   {
		   alert("No need to Doctor")
	
		   document.getElementById(doctorDropListId).innerHTML = "";
		   document.getElementById(bedNoFieldId).value = currentBedNo;
		   document.getElementById(bedIdFieldId).value = currentBedId;
		    document.getElementById(displayDiv).style.display = 'none';
		    
		    if(selectedward==otId)
		    	 document.getElementById(bedDiv).style.display = 'none';
		    
	         return false;
		   }
	   document.getElementById(bedNoFieldId).value = "";
	   document.getElementById(bedIdFieldId).value = "";
	    document.getElementById(displayDiv).style.display = 'block';
	    
	   //var wardId=document.getElementById("wardId").value
	    var wardId=selectedward;
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
	   	        var bedId  = item.getElementsByTagName("bedId")[0];
	   	        
	   	       if(bedStatus.childNodes[0].nodeValue=='yes'){
	   	    	openPopupWindowForBedSelectionLrTransfer(selectedward,bedNoFieldId, bedIdFieldId);
	   	       //	document.getElementById("bedId").value=bedId.childNodes[0].nodeValue
	   	       return true
	   	       }else{

	   	       	alert("No Bed Available in this ward..!")
	   	       	document.getElementById(wardFieldId).selectedIndex=0;
	   	       	document.getElementById(doctorDropListId).innerHTML = "";
	   	     document.getElementById(bedNoFieldId).value = "";
	   	     document.getElementById(displayDiv).style.display = 'none';
	   	       	
	   	       		//document.getElementById("bedId").value=0
	   	       	return false;
	   	       }
	           	
	         	} 
	         }
	         }
	       var url="/hms/hms/adt?method=chechBed&wardId="+wardId
	        
	       xmlHttp.open("GET",url,true);
	       xmlHttp.setRequestHeader("Content-Type", "text/xml");
	       xmlHttp.send(null);
	     //  alert("reached here");
	       //return true;
	   }
   
   function checkBedTransferFromOT(selectedward, currentWard, displayDiv, bedNoFieldId, bedIdFieldId,currentBedNo, currentBedId, bedDiv, wardFieldId, doctorDropListId){
	   document.getElementById(bedDiv).style.display = 'block';
	   
	   if(selectedward==currentWard)
		   {
		   alert("No need to Doctor")
	
		   document.getElementById(doctorDropListId).innerHTML = "";
		   document.getElementById(bedNoFieldId).value = currentBedNo;
		   document.getElementById(bedIdFieldId).value = currentBedId;
		    document.getElementById(displayDiv).style.display = 'none';
		    
	         return false;
		   }
	   document.getElementById(bedNoFieldId).value = "";
	   document.getElementById(bedIdFieldId).value = "";
	    document.getElementById(displayDiv).style.display = 'block';
	    
	   //var wardId=document.getElementById("wardId").value
	    var wardId=selectedward;
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
	   	        var bedId  = item.getElementsByTagName("bedId")[0];
	   	        
	   	       if(bedStatus.childNodes[0].nodeValue=='yes'){
	   	    	openPopupWindowForBedSelectionLrTransfer(selectedward,bedNoFieldId, bedIdFieldId);
	   	       //	document.getElementById("bedId").value=bedId.childNodes[0].nodeValue
	   	       return true
	   	       }else{

	   	       	alert("No Bed Available in this ward..!")
	   	       	document.getElementById(wardFieldId).selectedIndex=0;
	   	       	document.getElementById(doctorDropListId).innerHTML = "";
	   	     document.getElementById(bedNoFieldId).value = "";
	   	     document.getElementById(displayDiv).style.display = 'none';
	   	       	
	   	       		//document.getElementById("bedId").value=0
	   	       	return false;
	   	       }
	           	
	         	} 
	         }
	         }
	       var url="/hms/hms/adt?method=chechBed&wardId="+wardId
	        
	       xmlHttp.open("GET",url,true);
	       xmlHttp.setRequestHeader("Content-Type", "text/xml");
	       xmlHttp.send(null);
	     //  alert("reached here");
	       //return true;
	   }
function checkBed(){
var wardId=document.getElementById("wardId").value
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
	        var bedId  = item.getElementsByTagName("bedId")[0];
	        
	       if(bedStatus.childNodes[0].nodeValue=='yes'){
	    		openPopupWindowForBedSelection(document.getElementById("wardId").value);
	       //	document.getElementById("bedId").value=bedId.childNodes[0].nodeValue
	       return true
	       }else{
	       	alert("No Bed Available in this ward..!")
	       	document.getElementById("wardId").selectedIndex=0
	       		document.getElementById("bedId").value=0
	       	return false;
	       }
        	
      	} 
      }
      }
    var url="/hms/hms/adt?method=chechBed&wardId="+wardId
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);

}


function checkBedForTransfer(){
var wardId=document.getElementById("wardId").value
if(parseInt(wardId)!=0)
	{
var fromWardId=document.getElementById("fromWardId").value
var wardId=document.getElementById("wardId").value
var fromBedId=0;
if(parseInt(wardId)==parseInt(fromWardId))
	{
	 fromBedId=document.getElementById("fromBedId").value
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
	        var bedStatus  = item.getElementsByTagName("bedStatus")[0];
	        var bedId  = item.getElementsByTagName("bedId")[0];
	        
	       if(bedStatus.childNodes[0].nodeValue=='yes'){
	    		openPopupWindowForBedSelectionForTransfer(document.getElementById("wardId").value, fromBedId);
	       //	document.getElementById("bedId").value=bedId.childNodes[0].nodeValue
	       return true
	       }else{
	       	alert("No Bed Available in this ward..!")
	       	document.getElementById("wardId").selectedIndex=0
	       		document.getElementById("bedId").value=0
	       	return false;
	       }
        	
      	} 
      }
      }
    var url="/hms/hms/adt?method=chechBed&wardId="+wardId+"&fromBedId="+fromBedId
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
}

}

function openPopupWindowForBedSelection(wardId)
{
 var url="/hms/hms/adt?method=showAvailableBedStatus&wardId="+wardId;
 newwindow=window.open(url,'name',"left=100,top=100,height=160,width=475,status=1,scrollbars=0,resizable=0");
}

function openPopupWindowForBedSelectionLrTransfer(wardId, bedNoFieldId, bedIdFieldId)
{
 var url="/hms/hms/lr?method=showAvailableBedStatus&wardId="+wardId+"&bedNoFieldId="+bedNoFieldId+"&bedIdFieldId="+bedIdFieldId;
 newwindow=window.open(url,'name',"left=100,top=100,height=160,width=475,status=1,scrollbars=0,resizable=0");
}

function openPopupWindowForBedSelectionForTransfer(wardId, fromBedId)
{
 var url="/hms/hms/adt?method=showAvailableBedStatus&wardId="+wardId+"&fromBedId="+fromBedId;
 newwindow=window.open(url,'name',"left=100,top=100,height=160,width=475,status=1,scrollbars=0,resizable=0");
}
function checkAdNoDuplication(adNo){

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
	        var adStatus  = item.getElementsByTagName("adStatus")[0];
	        
	       if(adStatus.childNodes[0].nodeValue=='yes'){
	       	alert("Given Ad No already exists...!")
	       	//document.getElementById("oldAdNoId").value=""
	       return false
	       }else{
	       	return true;
	       }
        	
      	} 
      }
      }
    var url="/hms/hms/adt?method=checkAdNoDuplication&adNo="+adNo
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);


}
function checkForDuplicateOfAdnoInAttach(){
var serviceNo=document.getElementById("serviceNo").value
var serviceTypeId=document.getElementById("serviceTypeId").value
var relationId=document.getElementById("rel").value

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
	        var info  = item.getElementsByTagName("info")[0];
	        var uniqueRelId  = item.getElementsByTagName("uniqueRelId")[0];
	        if(uniqueRelId.childNodes[0].nodeValue >0){
		        alert("Patient Already Admitted ");
		        alert(info.childNodes[0].nodeValue)
		        document.getElementById("rel").selectedindex =0
		        return false;
	        }
	      alert(info.childNodes[0].nodeValue)
	       }
        	
      	
      }
      }
    var url="/hms/hms/adt?method=checkForDuplicateOfAdnoInAttach&serviceNo="+serviceNo+"&serviceTypeId="+serviceTypeId+"&relationId="+relationId
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
}


 function getIcdStringSilDil(){
 //=========To get Icd String with icd code==========================
var icdCode =document.getElementById("icdCode").value
 if(icdCode !="")
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
	         icdString  = item.getElementsByTagName("icdString")[0];
	         	
	        if(icdString.childNodes[0].nodeValue !="NO"){
	        	icdString=icdString.childNodes[0].nodeValue
	        	
	        	document.getElementById("icd").value =icdString
	        	document.getElementById("icdCode").value =""
	        	return true;
	        }else{
	      	 alert("ICD Code does not exists...!")
	      	 document.getElementById("icdCode").value =""
	       return false;
	        }
	       }
      }
      }
    var url="/hms/hms/adt?method=getIcdWithIcdCode&icdCode="+encodeURIComponent(icdCode)
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
  
  }
  //==================End of Icd String block======================
}

	 function ajaxFunctionForAutoCompleteIssueToDispensaryByPvmsNo(formName,action,rowVal) {
	
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
	        var nomenclature  = item.getElementsByTagName("nomenclature")[0];
	        var pvms  = item.getElementsByTagName("pvms")[0];
	        var au  = item.getElementsByTagName("au")[0];
	        var name  = item.getElementsByTagName("name")[0];
	        
	        
	        var nomenclature= nomenclature.childNodes[0].nodeValue
	        var pvms=pvms.childNodes[0].nodeValue
	        document.getElementById('nameItem'+rowVal).value=nomenclature+"["+pvms+"]"
	      //  alert(document.getElementById('nameItem'+rowVal).value)
        	//document.getElementById('nameItem'+rowVal).value = nomenclature.childNodes[0].nodeValue
        	document.getElementById('idItem'+rowVal).value = id.childNodes[0].nodeValue
        	document.getElementById('idAu'+rowVal).value = au.childNodes[0].nodeValue
        	document.getElementById('issuedName'+rowVal).value = name.childNodes[0].nodeValue
        	document.getElementById('issuedItemId'+rowVal).value = id.childNodes[0].nodeValue
      	} 
      }
    }
    var url=action+"&"+getNameAndData(formName)
     
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
    
    
  }
  
function generateServiveNo(){
 //=========To get Icd String with icd code==========================
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
	         serviceNo  = item.getElementsByTagName("serviceNo")[0];
	        if(serviceNo.childNodes[0].nodeValue !="no"){
	        if(true){
	        	document.getElementById("serviceNoId").value =serviceNo.childNodes[0].nodeValue
	        	return true;
	        	}else{
	        	document.getElementById("serviceNoId").value =""
	        	}
	        }else{
	      	 document.getElementById("serviceNoId").value =""
	       return false;
	        }
	       }
      }
      }
    var url="/hms/hms/registration?method=generateServiveNo"
    xmlHttp.open("GET",url,true);
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send(null);
  
 
  //==================End of Icd String block======================
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
  		        var medExamDate=item.getElementsByTagName("medExamDate")[0];
  	        	document.getElementById('avic34Id'+rowVal).value = avic34Id.childNodes[0].nodeValue
  	        	
  	        	document.getElementById('name'+rowVal).value = name.childNodes[0].nodeValue
  	        	document.getElementById('appointmentDate'+rowVal).value = appointmentDate.childNodes[0].nodeValue
  	        	document.getElementById('medExamDate'+rowVal).value = medExamDate.childNodes[0].nodeValue
  	      	} 
  	      }
  	    }
  		    var url=action+"&"+getNameAndData(formName)
  		     
  		    xmlHttp.open("GET",url,true);
  		    xmlHttp.setRequestHeader("Content-Type", "text/xml");
  		    xmlHttp.send(null);
  		    
  		  }
  
}