var clickedMenu = localStorage['myKey'];

var dynamicDataValue="";
function getDynamicMenu(flag){
	 var countValue=0;
		var dynamicValueeee=localStorage.getItem("dynamicLeftMenu");
	if(dynamicValueeee!="" && dynamicValueeee!=null ){
			$('#side-menu').append(dynamicValueeee);
			 $('#side-menu').show();
			 scrolling();
			 initMetisMenu2();
			 initActiveMenu2();
			// var myVar = setInterval(getApprovalFormatData, 5000);
			 getApprovalFormatData();
			 return countValue;
		}
	else{
		var userId=$('#userIdLeft').val();
		var serviceNo="123457";
		var roles = ["RECEPTIONIST","ADMIN","DOCTOR"];
		var hospitalIdForMas=$('#hospitalIdForMas').val();
		var params = {
				"serviceNo" : serviceNo,
				"roles":roles,
				"userId":userId,
				"hospitalIdForMas":hospitalIdForMas
		}
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : '/MMUWeb/dashboard/showApplicationsOnRoleBaseNew',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				var map1 =response.listOfKeyyy;
				var listOfSubChild =response.applicationListSubchild;
				var map2 =response.keyOfRole;
				 var keys = [];
				 var templateValue="";
				 var finaltemplate="";
				 var dynamicValueUsedAfter=""
					 var pageContextAfterValue=pageContaxValue;
					/*for(var k in map1){ 
							keys.push(k);
					}*/
					for(var k in map2){ 
						keys.push(map2[k]);
				}
				 $('#dynamicValue').show(). before("<li class='menu-title'>Menu====</li>");
				 
				/* $('#dynamicValue').show(). before("<li class='active'><a href='"+pageContaxValue+"/dashboard/homePage'><i class='ion-md-home'></i><span>SIMHA HOME old </span> </a></li>");*/
			var ashaSimha=0;
			var ashaDashBoard=0;
				 for(var i = 0; i < keys.length; i++){
					 if(keys[i]=="A206"){
						 ashaSimha++;
					 }
					 if(keys[i]=="A208"){
						 ashaDashBoard++;
					 }
				 }
				 
				 //if(ashaSimha>0)
				 $('#dynamicValue').show(). before("<li class='active'><a href='"+pageContaxValue+"/dashboard/homePage'><i class='ion-md-home'></i><span> Simha Home  </span> </a></li>");
				// if(ashaDashBoard>0){
				 $('#dynamicValue').show(). before("<li class='active'><a href='"+pageContaxValue+"/dashboard/dashboard'><i class='fa fa-columns'></i><span> Dashboard </span> </a></li>");
				 //}
				 
				 
					for(var i = 0; i < keys.length; i++){
						templateValue="";
						 if(keys[i]=="A1"){
							   templateValue="";
							     if(map1.A1.length>0){
						 	      for(var j=0;j<map1.A1.length;j++){
						 	    	 if(map1.A1[j].url=='#'  && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A1[j].url+"'>"+map1.A1[j].appName);
							    	if(map1.A1[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A1[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      }
						 	    
							     
							     $('#dynamicValue').show().before("<li><a href='#homeSubmenu1' aria-expanded='false' ><i class='fa fa-user-plus'></i> <span>Reception</span> <span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu1'>"+templateValue+"</ul></li>");
						   }
						 }
						
						 
						 if(keys[i]=="A2"){
							   templateValue="";
							     if(map1.A2.length>0){
						 	      for(var j=0;j<map1.A2.length;j++){
						 	    	 if(map1.A2[j].url=='#'  && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A2[j].url+"'>"+map1.A2[j].appName);
							    	if(map1.A2[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A2[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      }
						 	    
							     
						 	     $('#dynamicValue').show().before("<li><a href='#homeSubmenu2' aria-expanded='false'><i class='fa fa-user-md'></i><span>OPD</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu2'>"+templateValue+"</ul></li>");
						   }
						 }
						 
						 
						   if(keys[i]=="A4"){
							   templateValue="";
							   if(map1.A4.length>0){
						 	      for(var j=0;j<map1.A4.length;j++){
						 	    	 if(map1.A4[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A4[j].url+"'  >"+map1.A4[j].appName);
							    	var count=0;
							    	if(map1.A4[j].appId!=null){
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A4[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      }
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu3' aria-expanded='false'><i class='fa fa-notes-medical'></i><span>Medical Exam</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu3'>"+templateValue+"</ul></li>");
						   }
						   }
						   
						   if(keys[i]=="A5"){
							   templateValue="";
							   if(map1.A5.length>0){
						 	      for(var j=0;j<map1.A5.length;j++){
						 	    	  
						 	    	 if(map1.A5[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
					 	    	  
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A5[j].url+"'  >"+map1.A5[j].appName);
								
							    	if(map1.A5[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A5[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu4' data-toggle='collapse' ><i class='fa fa-file-medical'></i><span>Medical Board</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu4'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A7"){
							   templateValue="";
							   if(map1.A7.length>0){
						 	      for(var j=0;j<map1.A7.length;j++){
						 	    	  if(map1.A7[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
							 	    		 pageContaxValue="";
							 	    	  }
							 	    	  else{
							 	    		 pageContaxValue=pageContextAfterValue;
							 	    	  }
						 	    	  
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A7[j].url+"' >"+map1.A7[j].appName);
								
						 	      
							    	if(map1.A7[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A7[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu5' aria-expanded='false' ><i class='fa fa-flask'></i><span>Laboratory</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu5'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A8"){
							   templateValue="";
							   if(map1.A8.length>0){
						 	      for(var j=0;j<map1.A8.length;j++){
							    	
						 	    	  if(map1.A8[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
							 	    		 pageContaxValue="";
							 	    	  }
							 	    	  else{
							 	    		 pageContaxValue=pageContextAfterValue;
							 	    	  }
						 	    	  
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A8[j].url+"'  >"+map1.A8[j].appName);
								
							    	if(map1.A8[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A8[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu6' aria-expanded='false' ><i class='fa fa-dna'></i><span>Radiology</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu6'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   
						   if(keys[i]=="A3"){
							   templateValue="";
							   
							   if(map1.A3.length>0){
						 	      for(var j=0;j<map1.A3.length;j++){
						 	    	  
						 	    	  if(map1.A3[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A3[j].url+"'>"+map1.A3[j].appName);
							    	
							    	if(map1.A3[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A3[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
							    	
						 	      }
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu7' id='dispensaryMenu' aria-expanded='false' ><i class='fa fa-first-aid'></i><span>Dispensary</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' data-id='dispensaryMenu' id='homeSubmenu7'>"+templateValue+"</ul></li>");
							   }
						   }
						   
						   
						   
						   if(keys[i]=="A6"){
							   templateValue="";
							   if(map1.A6.length>0){
						 	      for(var j=0;j<map1.A6.length;j++){
						 	    	 if(map1.A6[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
						 	    	  
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A6[j].url+"'>"+map1.A6[j].appName);
							    	if(map1.A6[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		var jj=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(jj;jj<listOfSubChild.length;jj++){
								    		
										   if(map1.A6[j].appId==listOfSubChild[jj].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+jj+" href='"+pageContextAfterValue+listOfSubChild[jj].url+"'>"+listOfSubChild[jj].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu8' id='storesMenu' aria-expanded='false' ><i class='fa fa-building'></i><span>Stores</span><span class='menu-arrow'></span></a><ul data-id='storesMenu' class='nav-second-level collapse' id='homeSubmenu8'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A19"){
							   templateValue="";
							   if(map1.A19.length>0){
						 	      for(var j=0;j<map1.A19.length;j++){
						 	    	 if(map1.A19[j].url=='#'  && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
						 	    	  
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A19[j].url+"'>"+map1.A19[j].appName);
								
							    	if(map1.A19[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A19[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu9'' aria-expanded='false' ><i class='fa fa-door-open'></i><span>WARD</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu9'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A20"){
							   templateValue="";
							   if(map1.A20.length>0){
						 	      for(var j=0;j<map1.A20.length;j++){
						 	    	 if(map1.A20[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A20[j].url+"'  >"+map1.A20[j].appName);
								
						 	      
							    	if(map1.A20[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    	
										   if(map1.A20[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu10' aria-expanded='false'><i class='fa fa-id-badge'></i><span>MI ADMINISTRATION</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu10'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   
						   if(keys[i]=="A21"){
							   templateValue="";
							   if(map1.A21.length>0){
						 	      for(var j=0;j<map1.A21.length;j++){
						 	    	  
						 	    	 if(map1.A21[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A21[j].url+"'>"+map1.A21[j].appName);
								
						 	      

							    	if(map1.A21[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    	
										   if(map1.A21[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
							    	
						 	      
						 	      }
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu11' aria-expanded='false'><i class='fa fa-users'></i><span>FWC</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu11'>"+templateValue+"</ul></li>");
						   }
						   }
						   
						   if(keys[i]=="A221"){
							   templateValue="";
							   if(map1.A22.length>0){
						 	      for(var j=0;j<map1.A22.length;j++){
						 	    	 if(map1.A22[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
						 	    	  
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A22[j].url+"'  >"+map1.A22[j].appName);
								
							    	if(map1.A22[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    	
										   if(map1.A22[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu12' aria-expanded='false'><i class='fa fa-ambulance'></i><span>SHO</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu12'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A10"){
							   templateValue="";
							   if(map1.A10.length>0){
						 	      for(var j=0;j<map1.A10.length;j++){
						 	    	 if(map1.A10[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
						 	    	  
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A10[j].url+"' >"+map1.A10[j].appName);
								
							    	if(map1.A10[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A10[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu13' aria-expanded='false' ><i class='fa fa-user-cog'></i><span>User Management</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu13'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   
						   if(keys[i]=="A11"){
							   templateValue="";
							   if(map1.A11.length>0){
						 	      for(var j=0;j<map1.A11.length;j++){
						 	    	  
						 	    	 if(map1.A11[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A11[j].url+"'  >"+map1.A11[j].appName);
								
							    	if(map1.A11[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    	
										   if(map1.A11[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu14' aria-expanded='false' ><i class='fa fa-server'></i><span>Masters</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu14'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A9"){
							   templateValue="";
							   if(map1.A9.length>0){
						 	      for(var j=0;j<map1.A9.length;j++){
						 	    	  
						 	    	 if(map1.A9[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  } 
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A9[j].url+"'  >"+map1.A9[j].appName);
								
							    	if(map1.A9[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A9[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu15' aria-expanded='false' ><i class='fa fa-user-shield'></i><span>Admin</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu15'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A12"){
							   templateValue="";
							   if(map1.A12.length>0){
						 	      for(var j=0;j<map1.A12.length;j++){
						 	    	 if(map1.A12[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  } 
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A12[j].url+"'  >"+map1.A12[j].appName);
								
							    	if(map1.A12[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A12[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu16' aria-expanded='false'><i class='fa fa-wrench'></i><span>Utility</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu16'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   
						   if(keys[i]=="A13"){
							   templateValue="";
							   if(map1.A13.length>0){
						 	      for(var j=0;j<map1.A13.length;j++){
						 	    	 if(map1.A13[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  } 
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A13[j].url+"'  >"+map1.A13[j].appName);
								
							    	if(map1.A13[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A13[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu157' aria-expanded='false'><i class='fa fa-question-circle'></i><span>Help</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu157'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   
						   if(keys[i]=="A14"){
							   templateValue="";
							   if(map1.A14.length>0){
						 	      for(var j=0;j<map1.A14.length;j++){
						 	    	  var className="";
						 	    	  var idName="";
						 	    	  var meSubchild="";
						 	    	 if( map1.A14[j].appName=='ME Inbox' || map1.A14[j].appName=='ME INBOX' || map1.A14[j].appName=='Me Inbox'){
						 	    		 meSubchild='mexam';  
						 	    	  }
					 	    	  else if(map1.A14[j].appName=='MB INBOX' || map1.A14[j].appName=='MB Inbox' || map1.A14[j].appName=='Mb Inbox'){
						 	    		 meSubchild='mbxam';  
						 	    	  }
					 	    	  else{
					 	    		 meSubchild='';
					 	    	  }
						 	    	  templateValue+=("<li><a class='updateBrowserUrl'   data-name='inbox' href='"+pageContextAfterValue+map1.A14[j].url+"'  >"+map1.A14[j].appName+" <span class='badge m-l-10 mn-t-2'  id='"+meSubchild+"'>0</span></a></li>");
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li class='inPageLeftMenu'><a onclick='#' data-name='MedicalExam' href='#homeSubmenu16' aria-expanded='false'><i class='fa fa-inbox'></i><span>Inbox</span><span class='badge m-l-10' id='inbox'>0</span><span class='menu-arrow' ></span></a><ul class='nav-second-level collapse' id='homeSubmenu16'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A22"){
							   templateValue="";
							   if(map1.A22.length>0){
						 	      for(var j=0;j<map1.A22.length;j++){
						 	    	  var className="";
						 	    	  var idName="";
						 	    	  var meSubchild="";
						 	    	 if(map1.A22[j].appName=='ME APPROVED' || map1.A22[j].appName=='Me Approved' || map1.A22[j].appName=='ME Approved'){
						 	    		 meSubchild='mexamApp';  
						 	    	  }
						 	    	else if(map1.A22[j].appName=='MB APPROVED' || map1.A22[j].appName=='Mb Approved' || map1.A22[j].appName=='MB Approved'){
						 	    		 meSubchild='mbxamApp';  
						 	    	  }
						 	    	 else{
						 	    		 meSubchild='';
						 	    	  }
						 	    	  templateValue+=("<li><a class='updateBrowserUrl'   data-name='approved' href='"+pageContextAfterValue+map1.A22[j].url+"'  >"+map1.A22[j].appName+" <span class='badge m-l-10 mn-t-2'  id='"+meSubchild+"'>0</span></a></li>");
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li class='inPageLeftMenu'><a onclick='#' data-name='MedicalExam' href='#homeSubmenu16' aria-expanded='false'><i class='fa fa-check-circle'></i><span>Approved</span><span class='badge m-l-10' id='approve'>0</span><span class='menu-arrow' ></span></a><ul class='nav-second-level collapse' id='homeSubmenu16'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A23"){
							   templateValue="";
							   if(map1.A23.length>0){
						 	      for(var j=0;j<map1.A23.length;j++){
						 	    	  var className="";
						 	    	  var idName="";
						 	    	  var meSubchild="";
						 	    	 if(map1.A23[j].appName=='ME REJECT' || map1.A23[j].appName=='Me Reject' || map1.A23[j].appName=='ME Reject'){
						 	    		 meSubchild='mexamRej';  
						 	    	  }
						 	    	else if(map1.A23[j].appName=='MB REJECT' || map1.A23[j].appName=='Mb Reject'  || map1.A23[j].appName=='MB Reject'){
						 	    		 meSubchild='mbxamRej';  
						 	    	  }
						 	    	 else{
						 	    		 meSubchild='';
						 	    	  }
						 	    	  templateValue+=("<li><a class='updateBrowserUrl'   data-name='rejected' href='"+pageContextAfterValue+map1.A23[j].url+"'  >"+map1.A23[j].appName+" <span class='badge m-l-10 mn-t-2'  id='"+meSubchild+"'>0</span></a></li>");
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li class='inPageLeftMenu'><a onclick='#' data-name='MedicalExam' href='#homeSubmenu16' aria-expanded='false'><i class='fa fa-times-circle'></i><span>Reject</span><span class='badge m-l-10' id='reject'>0</span><span class='menu-arrow' ></span></a><ul class='nav-second-level collapse' id='homeSubmenu16'>"+templateValue+"</ul></li>");
							   } 
						   }
						   
						 //sho Local
						   /*if(keys[i]=="A169"){
							   
							   templateValue="";
							   if(map1.A169.length>0){
						 	      for(var j=0;j<map1.A169.length;j++){
						 	    	 if(map1.A169[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  } 
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A169[j].url+"'  >"+map1.A169[j].appName);
								
							    	if(map1.A169[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A169[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu169' aria-expanded='false'><i class='fa fa-question-circle'></i><span>SHO</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu169'>"+templateValue+"</ul></li>");
						   } 
						  }*/
						   
						 //sho production
						   if(keys[i]=="A175"){
							   
							   templateValue="";
							   if(map1.A175.length>0){
						 	      for(var j=0;j<map1.A175.length;j++){
						 	    	 if(map1.A175[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  } 
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A175[j].url+"'  >"+map1.A175[j].appName);
								
							    	if(map1.A175[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A175[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu175' aria-expanded='false'><i class='fa fa-ambulance'></i><span>SHO</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu175'>"+templateValue+"</ul></li>");
						   } 
						  }
						   
						   
						   if(keys[i]=="A171"){
							   
							   templateValue="";
							   if(map1.A171.length>0){
						 	      for(var j=0;j<map1.A171.length;j++){
						 	    	 if(map1.A171[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  } 
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A171[j].url+"'  >"+map1.A171[j].appName);
								
							    	if(map1.A171[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A171[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu175' aria-expanded='false'><i class='fa fa-print'></i><span>Digitization of documents</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu175'>"+templateValue+"</ul></li>");
						   } 
						  }
  
  
						   if(keys[i]=="A196"){
							   
							   templateValue="";
							   if(map1.A196.length>0){
						 	      for(var j=0;j<map1.A196.length;j++){
						 	    	 if(map1.A196[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  } 
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A196[j].url+"'  >"+map1.A196[j].appName);
								
							    	if(map1.A196[j].appId!=null){
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A196[j].appId==listOfSubChild[j1].parentId)	{
											   if(count==0){
												   templateValue+= ("<span class='menu-arrow2'></span></a><ul class='nav-third-level'>");
											   }
											   templateValue+=("<li><a data-id="+keys[i]+j+"s"+j1+" href='"+pageContextAfterValue+listOfSubChild[j1].url+"'>"+listOfSubChild[j1].appName+"</a></li>");  
											   count+=1;
										   }
								    		 
										} 
							    		if(count>0)
							    			templateValue+=("</ul>");
							    		if(count==0)
							    			templateValue+=("</a>");
								    	}
							    	templateValue+=("</li>");
						 	      
						 	      }
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu175' aria-expanded='false'><i class='fa fa-door-open'></i><span>MI Room</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu175'>"+templateValue+"</ul></li>");
						   } 
						  }
  
						   
						   
						   
						   countValue++; 
					   }
					//$('#dynamicValue').show(). after("<li class='active'><a href='"+pageContaxValue+"/medicalexam/getHistory'><i class='fa fa-columns'></i><span>ME/MB HISTORY</span> </a></li>");
					//$('#dynamicValue').show(). after("<li class='active'><a href='"+pageContaxValue+"/digifileupload/waitingTagAndDataEntry'><i class='fa fa-columns'></i><span>Waiting Tag And Data Entry</span> </a></li>");
				    //$('#dynamicValue').show(). after("<li class='active'><a href='"+pageContaxValue+"/digifileupload/waitingListOfVerify'><i class='fa fa-columns'></i><span>Verify List</span> </a></li>");
				 //  $('#dynamicValue').show(). after("<li class='active'><a href='"+pageContaxValue+"/medicalexam/validateMEWaitingForMa'><i class='fa fa-columns'></i><span>Validate Investigation of ME( Medical Exam For MA)</span> </a></li>");	
				 //  $('#dynamicValue').show(). after("<li class='active'><a href='"+pageContaxValue+"/medicalexam/validateMEWaitingForMaTest'><i class='fa fa-columns'></i><span>Validate Investigation of METest( Medical Exam For MA)</span> </a></li>");
				   var dynamicValueee= $('#side-menu').html() ;
					  //sessionStorage.setItem("dynamicLeftMenu",dynamicValueee);
					 	localStorage.setItem("dynamicLeftMenu",dynamicValueee);
					 	getApprovalFormatData();
					 	scrolling();
					 	initMetisMenu2();
					 	initActiveMenu2();
					}, 
				error : function(response) {
					alert(""+resourceJSON.msgServerError);
				 
			}
				 
		});
		
		
		
	}
}

function scrolling(){
	
	 $('.slimscroll-menu').slimscroll({
         height: 'auto',
         position: 'right',
         size: "5px",
         color: '#9ea5ab',
         wheelStep: 5,
         touchScrollStep: 50
     });
	
}
function initMetisMenu2() {
    //metis menu
    $("#side-menu").metisMenu();
}
function initActiveMenu2() {
    
	
	var divContainer = $('.slimscroll-menu'); // === for scrolling menu item to view
	
	// === following js will activate the menu in left side bar based on url ====
	
    $("#sidebar-menu a").each(function () {
        var pageUrl = window.location.href.split(/[?#]/)[0];
        if (this.href == pageUrl) {
        	
        	if(clickedMenu != 'defaultValue' && typeof clickedMenu != "undefined"){
        		
        		var $this = $('a[data-id="'+clickedMenu+'"]')
    			
        		$this.addClass("active"); // a tag
        		$this.parent().addClass("active"); // add active to li of the current link
        		$this.parent().parent().addClass("in"); // ul tag
	            //$(this).parent().parent().attr("aria-expanded","true"); // ul tag
        		$this.parent().parent().prev().addClass("active"); // add active class to a tag
	            //$(this).parent().parent().prev().attr("aria-expanded","true"); // add active class to a tag
	            
        		$this.parent().parent().parent().addClass("active"); // li tag
	           
	           // used for third level menu 
        		$this.parent().parent().parent().parent().addClass("in"); // add active to li of the current link
        		$this.parent().parent().parent().parent().parent().addClass("active");
	           
	           // === for scrolling menu item to view
	           var scrollThis = $this;
	           divContainer.animate({scrollTop: (scrollThis.offset().top - 100) - divContainer.offset().top + 
	    			divContainer.scrollTop()},200);
        	} 
        	
        	else{
	            $(this).addClass("active"); // a tag
	            $(this).parent().addClass("active"); // add active to li of the current link
	            $(this).parent().parent().addClass("in"); // ul tag
	            //$(this).parent().parent().attr("aria-expanded","true"); // ul tag
	            $(this).parent().parent().prev().addClass("active"); // add active class to a tag
	            //$(this).parent().parent().prev().attr("aria-expanded","true"); // add active class to a tag
	            
	            $(this).parent().parent().parent().addClass("active"); // li tag
	           
	           // used for third level menu 
	           $(this).parent().parent().parent().parent().addClass("in"); // add active to li of the current link
	           $(this).parent().parent().parent().parent().parent().addClass("active");
	           
	           // === for scrolling menu item to view
	           var scrollThis = $(this);
	           divContainer.animate({scrollTop: (scrollThis.offset().top - 100) - divContainer.offset().top + 
	    			divContainer.scrollTop()},200);
        	}
         
        }
        
    });
    
}


function showList1(value){
	
	if(value=='Indent')
	 GetListOfIndent('ALL');
	else if(value=='MedicalExam')
		getApprovalProcessForCommon('ALL','SearchStatus');
		else if(value=='MedicalBoard')
			 GetListOfMedicalBoard('ALL');
}




var dictionary ="";
var approvalData="";

var selectedbtn="";
function getApprovalFormatData(){
	 var  hospitalId=$('#hospitalId').val();
 	 var data = {
				 "hospitalId":hospitalId
			};
	 $.ajax({
			type : "POST",
			contentType : "application/json",
			url : '/AshaShipWeb/approve/getApprovalFormatDataProcessing',
			data : JSON.stringify(data),
			dataType : "json",
			 asyn: false,

			success : function(response) {
				dictionary = response;
			    approvalData=dictionary.data;
			    $("#inbox").html(approvalData.inbox);
		        $("#approve").html(approvalData.approve);
		        $("#reject").html(approvalData.reject);
		        $("#mexam").html(approvalData.meInbox);
		        $("#mexamApp").html(approvalData.meApprove);
		        $("#mexamRej").html(approvalData.meReject);
		        
		        
		        $("#mbxam").html(approvalData.mbInbox);
		        $("#mbxamApp").html(approvalData.mbApprove);
		        $("#mbxamRej").html(approvalData.mbReject);
			        //$("#mboard").html(approvalData.mbInbox);
			       
			        //$("#indent").html(approvalData.indentInbox);
			        //$("#search").hide();	
			        //$("#indenttb").hide();
			   
			}
	 });
	 
}
 

