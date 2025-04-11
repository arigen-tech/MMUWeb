var clickedMenu = localStorage['myKey'];
var clickedParent = localStorage['myMenu'];

var dynamicDataValue="";
function getDynamicMenu(flag){
	
	var countValue=0;
	//alert("call dynamic");
	
	//alert("fiest="+localStorage.getItem("dynamicLeftMenu"));
	 
		var dynamicValueeee=localStorage.getItem("dynamicLeftMenu");
		
		//alert(dynamicValueeee)
	if(dynamicValueeee!="" && dynamicValueeee!=null ){
			$('#side-menu').append(dynamicValueeee);
			 $('#side-menu').show();
			 scrolling();
			 initMetisMenu2();
			 initActiveMenu2();
			// var myVar = setInterval(getApprovalFormatData, 5000);
			// getApprovalFormatData();
			 return countValue;
		}
		
		
	else{
		
		
		var userId=$('#userIdLeft').val();
		
		console.log(userId);
		
		var serviceNo="123457";
		var roles = ["RECEPTIONIST","ADMIN","DOCTOR"];
		var hospitalIdForMas=$('#hospitalIdForMas').val();
		var importToShip="";
		try{
			importToShip=$('#importToShip').val();
		}catch(e){}
		  
		var params = {
				"serviceNo" : serviceNo,
				"roles":roles,
				"userId":userId,
				"hospitalIdForMas":hospitalIdForMas,
				"importToShip":importToShip
		}
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : '../dashboard/showApplicationsOnRoleBaseNew',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				if(response.status==0 && response.importToSip!='yes'){
					alert("Role are not associated with user. Please contact with admin");
				}
				
				//alert(response.listOfKeyyy)
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
				 $('#dynamicValue').show(). before("<li class='menu-title'>Menu</li>");
				 
				/* $('#dynamicValue').show(). before("<li class='active'><a href='"+pageContaxValue+"/dashboard/homePage'><i class='ion-md-home'></i><span>SIMHA HOME old </span> </a></li>");*/
			//var ashaSimha=0;
			//var ashaDashBoard=0;
				/* for(var i = 0; i < keys.length; i++){
					 if(keys[i]=="A206"){
						 ashaSimha++;
					 }
					 if(keys[i]=="A208"){
						 ashaDashBoard++;
					 }
				 }
				 */
				 //if(ashaSimha>0)
				 /*$('#dynamicValue').show(). before("<li class='active'><a href='"+pageContaxValue+"/dashboard/homePage'><i class='ion-md-home'></i><span> Simha Home  </span> </a></li>");*/
				// if(ashaDashBoard>0){
				// $('#dynamicValue').show(). before("<li class='active'><a href='"+pageContaxValue+"/dashboard/dashboard'><i class='fa fa-columns'></i><span> Dashboard </span> </a></li>");
				 //}
				 
				 
				 
				 
					for(var i = 0; i < keys.length; i++){
						
						console.log(keys[i])
						console.log(keys.length)
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
						 	    
							     
							     $('#dynamicValue').show().before("<li><a href='#homeSubmenu1' aria-expanded='false' ><i class='fa fa-server'></i> <span>Master</span> <span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu1'>"+templateValue+"</ul></li>");
						   }
						 }
						 
						 
						 if(keys[i]=="A66"){
							   templateValue="";
							     if(map1.A66.length>0){
						 	      for(var j=0;j<map1.A66.length;j++){
						 	    	 if(map1.A66[j].url=='#'  && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
							    	templateValue+=("<li><a data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A66[j].url+"'>"+map1.A66[j].appName);
							    	if(map1.A66[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A66[j].appId==listOfSubChild[j1].parentId)	{
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
						 	    
							     
						 	     $('#dynamicValue').show().before("<li><a href='#homeSubmenu2' aria-expanded='false'><i class='fa fa-question-circle'></i><span>Help</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu2'>"+templateValue+"</ul></li>");
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
						 	    
							     
						 	     $('#dynamicValue').show().before("<li><a href='#homeSubmenu2' aria-expanded='false'><i class='fa fa-user-plus'></i><span>Reception</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu2'>"+templateValue+"</ul></li>");
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
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A3[j].url+"'  >"+map1.A3[j].appName);
							    	var count=0;
							    	if(map1.A3[j].appId!=null){
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
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu3' aria-expanded='false'><i class='fa fa-user-md'></i><span>OPD</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu3'>"+templateValue+"</ul></li>");
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
								
							    	if(map1.A4[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
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
						 	    
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu4' data-toggle='collapse' ><i class='fa fa-flask'></i><span>Laboratory</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu4'>"+templateValue+"</ul></li>");
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
						 	    	  
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A5[j].url+"' >"+map1.A5[j].appName);
								
						 	      
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
						 	    
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu5' aria-expanded='false' ><i class='fa fa-user-cog'></i><span>User Management</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu5'>"+templateValue+"</ul></li>");
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
						 	    	  
						 	    	  templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A6[j].url+"'  >"+map1.A6[j].appName);
								
							    	if(map1.A6[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(var j1=0;j1<listOfSubChild.length;j1++){
								    		
										   if(map1.A6[j].appId==listOfSubChild[j1].parentId)	{
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
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu6' aria-expanded='false' ><i class='fa fa-dna'></i><span>Dispensary</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu6'>"+templateValue+"</ul></li>");
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
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A7[j].url+"'>"+map1.A7[j].appName);
							    	
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
							    $('#dynamicValue').show().before("<li><a href='#homeSubmenu7' id='dispensaryMenu' aria-expanded='false' ><i class='fa fa-user-shield'></i><span>Admin</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' data-id='dispensaryMenu' id='homeSubmenu7'>"+templateValue+"</ul></li>");
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
						 	    	  
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A8[j].url+"'>"+map1.A8[j].appName);
							    	if(map1.A8[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		var jj=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(jj;jj<listOfSubChild.length;jj++){
								    		
										   if(map1.A8[j].appId==listOfSubChild[jj].parentId)	{
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
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu8' id='storesMenu' aria-expanded='false' ><i class='fa fa-file-medical'></i><span>MIS</span><span class='menu-arrow'></span></a><ul data-id='storesMenu' class='nav-second-level collapse' id='homeSubmenu8'>"+templateValue+"</ul></li>");
						   } 
						   }
						   
						   if(keys[i]=="A62"){
							   
							   
							   templateValue="";
							   if(map1.A62.length>0){
						 	      for(var j=0;j<map1.A62.length;j++){
						 	    	 if(map1.A62[j].url=='#' && pageContaxValue!="" && pageContaxValue!=null){
						 	    		 pageContaxValue="";
						 	    	  }
						 	    	  else{
						 	    		 pageContaxValue=pageContextAfterValue;
						 	    	  }
						 	    	  
							    	templateValue+=("<li><a class='updateBrowserUrl' data-id="+keys[i]+j+" href='"+pageContaxValue+map1.A62[j].url+"'>"+map1.A62[j].appName);
							    	if(map1.A62[j].appId!=null){
							    		var	 templateValueChilde="";
							    		var count=0;
							    		var jj=0;
							    		if(listOfSubChild!=null && listOfSubChild.length>0)
							    		for(jj;jj<listOfSubChild.length;jj++){
								    		
										   if(map1.A62[j].appId==listOfSubChild[jj].parentId)	{
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
						 	    
							    $('#dynamicValue').show() .before("<li><a href='#homeSubmenu8' id='storesMenu' aria-expanded='false' ><i class='fa fa-building'></i><span>Dashboard</span><span class='menu-arrow'></span></a><ul data-id='storesMenu' class='nav-second-level collapse' id='homeSubmenu8'>"+templateValue+"</ul></li>");
						   }
						   }
						   
						  
						   
						  /////////////////////////////////////////////////////////////End of Digitizatrion 
						 countValue++; 
					   }
					
					$('#dynamicValue').show(). before("<li><a href='#homeSubmenu9' aria-expanded='false'><i class='fa fa-mobile-alt'></i><span>Download App</span><span class='menu-arrow'></span></a><ul class='nav-second-level collapse' id='homeSubmenu9'><li data-id='asome1'><a href='https://play.google.com/store/apps/details?id=mmssy.health' target='_blank'>Android App</a></li><li data-id='asome1'><a href='javascript:void(0)' target='_blank'>iOS App</a></li></ul></li>");
					
				   var dynamicValueee= $('#side-menu').html() ;
					 	localStorage.setItem("dynamicLeftMenu",dynamicValueee);
					 	//getApprovalFormatData();
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
    	
    	var pageUrlComponent = window.location.href.split(/[/]/)[4];
    	
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
        
        // === keep parent menu open if shown page is continuation of previous page ====
        else{       	
        	
        	var thisParent = $(this).attr('href').split(/[/]/)[2];        	
        	
        	if(thisParent == pageUrlComponent && typeof clickedParent !== 'undefined' && clickedParent !== 'defaultValue' ){
        		
        		var $this = $('a[data-id="'+clickedParent+'"]');
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
        		return false;
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



