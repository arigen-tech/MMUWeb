 /*Grid for Ward Mgmt. By VIKAS------------*/  
showOnSamePage = true;
addAction = true;
rowsPerPage = 10;
totalPages =""
currentColor = "odd";
function makeGridForPatient(starter, end)
{
	
	
    totalPages = Math.ceil(data_arr.length/rowsPerPage);
	document.getElementById("total").innerHTML=totalPages
	//document.getElementById("totalRecs").innerHTML=data_arr.length
	document.getElementById("totalRecs").value=data_arr.length
	if(totalPages==0){
        document.getElementById('searchtable').style.width = "100%"
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
   // for(pg=1;pg<=totalPages;pg++){
        //document.getElementById('pageno')[pg-1].value = pg
        //document.getElementById('pageno')[pg-1].text = pg            
   // }
    start = starter;
    if(data_header){
             if(formName == "otPacClearedList"){
                tempTable = '<table border="0" cellspacing="0"  cellpadding="0"><thead><tr>'
                }else{
                tempTable = '<table border="0" cellspacing="0"  cellpadding="0"><thead><tr>'
                }
        for(cols=0;cols<data_header.length;cols++){
            if(data_header[cols][1]=="data"){
                tempTable += '<th width="';
                if(data_header[cols][2]!=0)
                    tempTable +=  data_header[cols][2];
                //tempTable += '">'+data_header[cols][0]+'<a href="javascript:sortGrid('+cols+',\'up\')"><img src="/hms/jsp/images/arrowUp.gif" /></a><a href="javascript:sortGrid('+cols+',\'dn\')"><img src="/hms/jsp/images/arrowDown.gif" /></a></th>'
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
        for(rows=start;rows<end; rows++){
                
				if(formName == "opdPatientList"){
					tempTable += '<tr id="'+data_arr[rows][0]+'" class="default'  
					tempTable += '"'; 
                	if(data_arr[rows][2] == "1"){
                		//alert(data_arr[rows][19])
                		tempTable +=' bgcolor="#FA7676" '
                	}else if(data_arr[rows][2] == "2"){
                		tempTable +=' bgcolor="#F7ED9B" '
                	}else if(data_arr[rows][2] == "3"){
                		tempTable +=' bgcolor="#A0E0AA" '
                	}
                }
				
				else if(formName == "opdOphthalPatientList"){
					tempTable += '<tr id="'+data_arr[rows][0]+'" class="default'  
					tempTable += '"'; 
                	if(data_arr[rows][2] == "1"){
                		//alert(data_arr[rows][19])
                		tempTable +=' bgcolor="#FA7676" '
                	}else if(data_arr[rows][2] == "2"){
                		tempTable +=' bgcolor="#F7ED9B" '
                	}else if(data_arr[rows][2] == "3"){
                		tempTable +=' bgcolor="#A0E0AA" '
                	}
                }
				else if(formName == "meWaitingList"){
					tempTable += '<tr id="'+data_arr[rows][0]+'"';  
					//tempTable += '"'; 
                	/*
					if(data_arr[rows][11] == "1"){
                		//alert(data_arr[rows][19])
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][11] == "0"){
                		tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][11] == "2"){
                		tempTable +=' class="signPriority1" '
                	}
                	*/
					/*
					 * Code By Mukesh 
					 * Date 03 feb 2012
					 */
					/* Priority Color Coding  Priority Color Coding By Mukesh
					*		    	 	  	Normal	Urgent	Very Urgent
					* New Data	   	   		3		   2		1
		    	    * Pending For Result	6		   5	 	4
		    	    * Rejected By MO		9		   8		7
		    	    */
					if(data_arr[rows][11] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][11] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "2"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][11] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "6"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][11] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                	//mbWaitingList//ma_status
                }else if(formName == "mbWaitingList"){//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][12] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][12] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "2"){
                		//alert("data_arr[rows][12]-->"+data_arr[rows][12]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "3"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][12] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][12] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }else if(formName == "medicalBoardMedicalOfficerInitial"){//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][12] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][12] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "2"){
                		//alert("data_arr[rows][12]-->"+data_arr[rows][12]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][12] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][12] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }else if(formName == "medicalBoardSpecialist"){//class="default"'
                	// Code By Mukesh Date 04 Apr 2012
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][12] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][12] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "2"){
                		//alert("data_arr[rows][12]-->"+data_arr[rows][12]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][12] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][12] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }
                else if(formName == "medicalBoardApprovingAuthority"){//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][11] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][11] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "2"){
                		//alert("data_arr[rows][11]-->"+data_arr[rows][11]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][11] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][11] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }   else if(formName == "medicalBoardConfirmingAuthority"){//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][11] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][11] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "2"){
                		//alert("data_arr[rows][11]-->"+data_arr[rows][11]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][11] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][11] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }  else if(formName == "medicalBoardAcceptingAuthority"){//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][11] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][11] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "2"){
                		//alert("data_arr[rows][11]-->"+data_arr[rows][11]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][11] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][11] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                } 
                else if(formName == "medicalBoardPerusingAuthority"){
                	//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][11] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][11] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "2"){
                		//alert("data_arr[rows][11]-->"+data_arr[rows][11]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][11] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][11] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][11] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][11] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }else if(formName == "medicalBoardCommandingOfficer"){//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][12] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][12] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "2"){
                		//alert("data_arr[rows][12]-->"+data_arr[rows][12]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][12] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][12] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }else if(formName == "medicalBoardOpinion"){//class="default"'
					tempTable += '<tr id="'+data_arr[rows][0]+'"' ;  
					//tempTable += '"'; 
					if(data_arr[rows][12] == "0"){
						tempTable +=' bgcolor="#FFFFFF" '
                	}else if(data_arr[rows][12] == "1"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "2"){
                		//alert("data_arr[rows][12]-->"+data_arr[rows][12]);
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "3"){
                		tempTable +=' class="signPriority3" '
                	}else if(data_arr[rows][12] == "4"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "5"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "6"){
                		tempTable +=' class="signPriority3" '
                	}if(data_arr[rows][12] == "7"){
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][12] == "8"){
                		tempTable +=' class="signPriority2" '
                	}else if(data_arr[rows][12] == "9"){
                		tempTable +=' class="signPriority3" '
                	}
                }
                else if(formName == "medicalBoardMedicalOfficer")
                {
					tempTable += '<tr id="'+data_arr[rows][0]+'"';  
					//tempTable += '"'; 
                	if(data_arr[rows][12] == "4")
                	{
                		tempTable +=' class="signPriority1" '
                	}else if(data_arr[rows][13] == "1")
                	{                		
                		tempTable +=' class="signPriority3" '
                	}else
                	{
                		tempTable +=' class="default" '
                	}	
                }else if(formName == "medicalExamApprovingAuthourity")
                {
					tempTable += '<tr id="'+data_arr[rows][0]+'"';  
					//tempTable += '"'; 
                	if(data_arr[rows][12] == "6")
                	{
                		tempTable +=' class="signPriority1"'
                	}else
                	{
                		tempTable +=' class="default" '
                	}	
                }else if(formName == "medicalExamOCUnitWaitingJsp")
                {
					tempTable += '<tr id="'+data_arr[rows][0]+'"';  
					//tempTable += '"'; 
                	if(data_arr[rows][12] == "6")
                	{
                		tempTable +=' class="signPriority1"'
                	}else
                	{
                		tempTable +=' class="default" '
                	}	
                }else if(formName == "medicalExamPerAuthourity")
                {
					tempTable += '<tr id="'+data_arr[rows][0]+'"';  
					//tempTable += '"'; 
                	if(data_arr[rows][12] == "8")
                	{
                		tempTable +=' class="signPriority1"'
                	}else
                	{
                		tempTable +=' class="default" '
                	}	
                }
				
				if(formName == "opdVaccinePatientList"){
					tempTable += '<tr id="'+data_arr[rows][0]+'" class="default'  
					tempTable += '"'; 
                	if(data_arr[rows][2] == "1"){
                		//alert(data_arr[rows][19])
                		tempTable +=' bgcolor="#FA7676" '
                	}else if(data_arr[rows][2] == "2"){
                		tempTable +=' bgcolor="#F7ED9B" '
                	}else if(data_arr[rows][2] == "3"){
                		tempTable +=' bgcolor="#A0E0AA" '
                	}
                }
				
				else{
                	tempTable += '<tr id="'+data_arr[rows][0]+'" class="'  
    				if(rows%rowsPerPage == 0 && rows != 0){
    					currentColor = "odd"	
    				}

                    tempTable += currentColor;   	            
    				currentColor = (currentColor == "odd")?"even" : "odd";
    				
    				tempTable += '"'; 
                }
                tempTable += '>'
                	//alert(end+"<--data_header.length-->"+data_header.length);
                for(columns=1;columns<=data_header.length;columns++){
                    tempTable += '<td '
                    if(data_header[columns-1][1] == "hide")
                        tempTable += 'class="hide"';
                	if(data_header[columns-1][3] == "ma_status"){
                		/*  Priority Color Coding By Mukesh
        				*		    	 	  	Normal	Urgent	Very Urgent
        				* New Data	   	   		3		   2		1
        	    	    * Pending For Result	6		   5	 	6
        	    	    * Rejected By MO		9		   8		7
        	    	    */
                		if(data_arr[rows][11] == "1"){//1,2,3---> White
                				tempTable +=' style="background-color: #FFFFFF" '
                        	}else if(data_arr[rows][11] == "2"){
                        		tempTable +=' style="background-color: #FFFFFF" '
                        	}else if(data_arr[rows][11] == "3"){
                        		tempTable +=' style="background-color: #FFFFFF" '
                        	}if(data_arr[rows][11] == "4"){//4,5,6-->dark green
                        		tempTable +=' style="background-color: #54CF68" '
                        	}else if(data_arr[rows][11] == "5"){
                        		tempTable +=' style="background-color: #54CF68" '
                        	}else if(data_arr[rows][11] == "6"){
                        		tempTable +=' style="background-color: #54CF68" '
                        	}if(data_arr[rows][11] == "7"){//7,8,9-->red
                        		tempTable +=' style="background-color: #B70202; color:#ffffff;" '
                        	}else if(data_arr[rows][11] == "8"){
                        		tempTable +=' style="background-color: #B70202; color:#ffffff;" '
                        	}else if(data_arr[rows][11] == "9"){
                        		tempTable +=' style="background-color: #B70202; color:#ffffff;" '
                        	}		
                	}
                    tempTable +='>'
                    if(formName=="opdPatientList" ||formName=="opdPatientVisit" || formName == "opdPatientVisitFromOPDScreen" || formName=="opdRecallPatientList" || formName=="opdOphthalPatientList" ||formName=="opdVaccinePatientList"  ){
                    	if(formName == "opdPatientVisitFromOPDScreen"){
	                     	tempTable += '<a href="javascript:RequestForPrevFromOPD(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\')">';
                    	}else{
                    		tempTable += '<a href="javascript:RequestForToken(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\',\''+data_arr[rows][3]+'\',\''+data_arr[rows][22]+'\')">';                    	
                    	}
                    	
                    }else if(formName == "otPacClearedList"){
                            tempTable += '<a href="javascript:RequestForReportCollection(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    }else if(formName=='mbWaitingList'){
                  	  
                   	  tempTable += '<a href="javascript:showMedicalBoardJsp(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][1]+'\',\''+formName+'\')">';
                   		
                     }else if(formName=='medicalBoardMedicalOfficerInitial'){
                      	tempTable += '<a href="javascript:showMedBrdMedicalOfficer(\''+data_arr[rows][0]+'\',\''+data_arr[rows][1]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                     }else if(formName=='medicalBoardSpecialist' || formName=='medicalExamSpecialist'){
                      	tempTable += '<a href="javascript:showMedBrdMedicalSpecialistOpinion(\''+data_arr[rows][0]+'\',\''+formName+'\',\''+data_arr[rows][10]+'\')">';
                     }else if(formName=='medicalBoardCommandingOfficer'){
                  	tempTable += '<a href="javascript:showMedBrdCommandingOfficer(\''+data_arr[rows][0]+'\',\''+data_arr[rows][1]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                     }else if(formName=='medicalBoardOpinion'){
                  	tempTable += '<a href="javascript:showMedicalBoardOpinion(\''+data_arr[rows][0]+'\',\''+data_arr[rows][1]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                     }
                     else if(formName=='medicalBoardApprovingAuthority'){
                  	tempTable += '<a href="javascript:showMedBrdApproveAuth(\''+data_arr[rows][0]+'\',\''+data_arr[rows][1]+'\',\''+formName+'\',\''+data_arr[rows][13]+'\')">';
                     }
                     else if(formName=='medicalBoardConfirmingAuthority'){
                       	tempTable += '<a href="javascript:showMedBrdConfirmAuth(\''+data_arr[rows][0]+'\',\''+data_arr[rows][1]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                  }
                  else if(formName=='medicalBoardAcceptingAuthority'){
             	tempTable += '<a href="javascript:showMedBrdAcceptAuth(\''+data_arr[rows][0]+'\',\''+data_arr[rows][1]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                }
                     else if(formName=='medicalBoardPerusingAuthority'){
                       	tempTable += '<a href="javascript:showMedBrdPerusingAuth(\''+data_arr[rows][0]+'\',\''+data_arr[rows][1]+'\',\''+formName+'\',\''+data_arr[rows][13]+'\')">';
                      }else if(formName=='meWaitingList')
                    {
                     	  tempTable += '<a href="javascript:showMedicalExamJsp(document.getElementById(\''+data_arr[rows][0]+'\'),\''+data_arr[rows][1]+'\',\''+formName+'\')">';
                    }else if(formName=='medicalBoardMedicalOfficer'){
                    	  tempTable += '<a href="javascript:showmedicalBoardMedicalOfficer(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                   }else if(formName=='medicalExamPerAuthourity' )
                   {
                    	
                  	  tempTable += '<a href="javascript:showmedicalExamPerAuthourity(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                   }else if(formName=='medicalExamApprovingAuthourity' || formName=='medicalExamOCUnitWaitingJsp')
                   {
                   	
                   	  tempTable += '<a href="javascript:showmedicalExamApprovingAuthourity(\''+data_arr[rows][9]+'\',\''+data_arr[rows][10]+'\',\''+formName+'\',\''+data_arr[rows][11]+'\')">';
                    }
                    
                    else if(formName=="fwcPatientList" ||formName=="fwcPatientVisit" || formName == "fwcPatientVisitFromFWCScreen"  ){
                    	if(formName == "fwcPatientVisitFromFWCScreen"){
	                     	tempTable += '<a href="javascript:RequestForPrevFromFWC(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\')">';
                    	}else{
                    		tempTable += '<a href="javascript:RequestForFWC(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\',\''+data_arr[rows][2]+'\',\''+data_arr[rows][9]+'\',\''+data_arr[rows][11]+'\')">';
                    		
                    	}
                    }else if(formName=="waitingListForSterilisation"){
                    		tempTable += '<a href="javascript:RequestForSterilization(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\')">';                    	
                    }
                    else if(formName == "otPacClearedList" || formName=="smoWaitingList" || formName=="smoWaitingList1"){
                            tempTable += '<a href="javascript:RequestForReportCollection(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    } 
                    else if(formName == "otPacClearedList" || formName=="notifiableWaitingList" || formName=="notifiableWaitingList"){
                        tempTable += '<a href="javascript:RequestForReportCollection(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                } 
                    
                    else if(formName=="op_nursingcare_Waiting_List"){
                     	tempTable += '<a href="javascript:RequestForToken(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\',\''+data_arr[rows][4]+'\',\''+data_arr[rows][12]+'\')">';
                    }
                    
                    else if(formName=="physiotherapy_nursingcare_Waiting_List"){
                     	tempTable += '<a href="javascript:RequestForToken(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\',\''+data_arr[rows][4]+'\',\''+data_arr[rows][12]+'\')">';
                    }
                    else if(formName=="therapy_Waiting_List"){
                     	tempTable += '<a href="javascript:RequestForToken(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\',\''+data_arr[rows][4]+'\',\''+data_arr[rows][12]+'\')">';
                    }
                    else if(formName=="facWaitingList"){
                     	tempTable += '<a href="javascript:RequestForToken(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\',\''+rows+'\',\''+data_arr[rows][4]+'\',\''+data_arr[rows][12]+'\')">';
                    }
                    else if(showOnSamePage){
                    if(formName!="nursingCareEntryDetail" && formName != "patientList"){                    
                    	tempTable += '<a href="javascript:editRecord(document.getElementById(\''+data_arr[rows][0]+'\'),\''+formName+'\')">';
                    	}
               		}else if(addAction){
                   	tempTable += '<a href="'+ goToUrl +'&id='+data_arr[rows][0]+'">';
               		//	tempTable += '<a href="#" onclick="parent.location=\''+ goToUrl +'&id='+data_arr[rows][0]+'\'">';
               		}else 
                    	tempTable += '<a href="'+ goToUrl +'&'+data_arr[rows][0]+'.action">';
                    
                    tempTable +=data_arr[rows][columns]
                    tempTable +='</a></td>'                    
                }
               tempTable += '</tr>'
        }
        tempTable += '</tbody></table>'
                            
        document.getElementById('searchtable').innerHTML = tempTable;
    }

    if(document.paging.pageno.value == 1){
		document.paging.firstpage.disabled= true;
		document.paging.prevpage.disabled= true;
		document.paging.firstpage.className="previousDisable"
		document.paging.prevpage.className="singlePrevDisable"    
    
    }    
	
}
function RequestForToken(obj,formName,rowVal,tokenObj,extraArg)
{
	if(formName == 'opdPatientList' || formName == 'opdRecallPatientList'){
		
		if(bReleaseClick == 'N')
		{
		 if(rowVal==0)
		 {
			visit = obj.id;
			token = tokenObj;
		    obj1 = eval('document.'+formName)
		    
		    var url;
		    if(formName == 'opdPatientList')
		    	{
		    	if(extraArg!="")
		    		{
		    		if(extraArg=="dental")
		    		 url = "/hms/hms/opd?method=showOPDDentalJsp&visitId="+visit+"&token="+token+"&department="+extraArg;
		    		else if(extraArg=="obj")
		    		 url = "/hms/hms/opd?method=showOPDOBGJsp&visitId="+visit+"&token="+token+"&department="+extraArg;
		    		}
		    	else
		    		url = "/hms/hms/opd?method=showOPDMainJsp&visitId="+visit+"&token="+token;
		    	}
		    
		    if(formName == 'opdRecallPatientList')
	    	{
	    	//if(extraArg!="")
	   		//url = "/hms/hms/opd?method=showOPDDentalJsp&visitId="+visit+"&token="+token+"&department="+extraArg;
	    	//else
	    		url = "/hms/hms/opd?method=updateOPDPatientDetailsJsp&visitId="+visit+"&token="+token;
	    	}
		    
		    
			obj1.action = url;
			obj1.submit();
		 }else{
		   if(alertBeforeSubmit())
		   {
		    visit = obj.id;
		    token = tokenObj;
		    obj1 = eval('document.'+formName)
		    var url;
		    if(formName == 'opdPatientList')
		    /*	if(extraArg!="")
			   		url = "/hms/hms/opd?method=showOPDDentalJsp&visitId="+visit+"&token="+token+"&department="+extraArg;*/
		    	if(extraArg!="")
	    		{
	    		if(extraArg=="dental")
	    		 url = "/hms/hms/opd?method=showOPDDentalJsp&visitId="+visit+"&token="+token+"&department="+extraArg;
	    		else if(extraArg=="obj")
	    		 url = "/hms/hms/opd?method=showOPDOBGJsp&visitId="+visit+"&token="+token+"&department="+extraArg;
	    		}
			    else
			    	url = "/hms/hms/opd?method=showOPDMainJsp&visitId="+visit+"&token="+token;
		    
		    if(formName == 'opdRecallPatientList')
	    	{
	    	//if(extraArg!="")
	   		//url = "/hms/hms/opd?method=showOPDDentalJsp&visitId="+visit+"&token="+token+"&department="+extraArg;
	    	//else
	    		url = "/hms/hms/opd?method=updateOPDPatientDetailsJsp&visitId="+visit+"&token="+token;
	    	}
		   	obj1.action = url;
		    obj1.submit();
		   }
		 }
		}
		} // close if bReleaseClick
	
	
		if(formName == 'opdVaccinePatientList'){
			
			
			var visitId = obj.id;
			obj1 = eval('document.'+formName)
		    var url = "/hms/hms/opd?method=showOPDVaccineJsp&visitId="+visitId;
			obj1.action = url;
			obj1.submit();
		
		}
	if(formName == 'opdOphthalPatientList'){
		
	
		var visitId = obj.id;
		obj1 = eval('document.'+formName)
	    var url = "/hms/hms/opd?method=showOphthalmolgyScreen&visitId="+visitId;
		obj1.action = url;
		obj1.submit();
	
	}
	
	if(formName == 'op_nursingcare_Waiting_List'){
		
		var injAppId = obj.id;
		var date= tokenObj;
		var visitId = extraArg;
		obj1 = eval('document.'+formName)
	    var url = "/hms/hms/opd?method=getOPNursingCareScreenJSP&injAppId="+injAppId+"&opdDate="+date+"&visitId="+visitId;
		obj1.action = url;
		obj1.submit();
	
	}
	if(formName == 'physiotherapy_nursingcare_Waiting_List'){
		
		//var injAppId = obj.id;
		var date= tokenObj;
		var visitId = extraArg;
		obj1 = eval('document.'+formName)
	    var url = "/hms/hms/opd?method=getPhysiotherapyNursingCareScreen&opdDate="+date+"&visitId="+visitId;
		obj1.action = url;
		obj1.submit();
	
	}
	
	
	if(formName == 'therapy_Waiting_List'){
		
		var injAppId = obj.id;
		var date= tokenObj;
		var visitId = extraArg;
		obj1 = eval('document.'+formName)
	    var url = "/hms/hms/opd?method=getTherapyScreenJSP&injAppId="+injAppId+"&opdDate="+date+"&visitId="+visitId;
		obj1.action = url;
		obj1.submit();
	
	}

	if(formName == 'facWaitingList'){
		
		//var pphId = obj.id;
		var visitId = obj.id;
		obj1 = eval('document.'+formName)
	    //var url = "/hms/hms/opd?method=getUpdateFACScreenJSP&pphId="+pphId;
		var url = "/hms/hms/opd?method=getUpdateFACScreenJSP&visitId="+visitId;
		obj1.action = url;
		obj1.submit();
	
	}
	
	 }

 function RequestForFWC(obj,formName,rowVal,tokenObj,category,hin){
	
		 if(rowVal==0)
			 {	 
			 	
				visit = obj.id;
				token = tokenObj;
			    obj1 = eval('document.'+formName)
			    var url;
			    if(formName == 'fwcPatientList')
			    	if(category == 'ANC'){
				   		url = "/hms/hms/fwc?method=showAntCardJsp&visitId="+visit+"&token="+token+"&category="+category;
				    	}else if(category == 'PNC'){
				   		 url = "/hms/hms/fwc?method=showPNCJsp&visitId="+visit+"&token="+token+"&category="+category;
				    	}else if(category == 'WELL BABY'){
				   		 url = "/hms/hms/fwc?method=showPediatricJsp&visitId="+visit+"&token="+token+"&category="+category;
				    	}else if(category == 'FAMILY PLANNING'){
				   		 url = "/hms/hms/fwc?method=showFamilyPlanningJsp&visitId="+visit+"&token="+token+"&category="+category;
				    	}else if(category == 'IMMUNIZATION'){
				   		 url = "/hms/hms/fwc?method=showImmunisationJsp&visitId="+visit+"&token="+token+"&category="+category;
				    	}
				    	else if(category == 'ANC FOLLOW UP'){
					   		 url = "/hms/hms/fwc?method=showAntCardFollowUpJsp&visitId="+visit+"&token="+token+"&hinId="+hin+"&category="+category;
					    	}
			    
				obj1.action = url;
				obj1.submit();
			 }else{
				
			   if(alertBeforeSubmit())
			   {
			    visit = obj.id;
			    token = tokenObj;
			    obj1 = eval('document.'+formName)
			    var url;
			    if(formName == 'fwcPatientList'){
			    	if(category == 'ANC'){
			   		url = "/hms/hms/fwc?method=showAntCardJsp&visitId="+visit+"&token="+token+"&category="+category;
			    	}else if(category == 'PNC'){
			   		 url = "/hms/hms/fwc?method=showPNCJsp&visitId="+visit+"&token="+token+"&category="+category;
			    	}else if(category == 'WELL BABY'){
				   		 url = "/hms/hms/fwc?method=showPediatricJsp&visitId="+visit+"&token="+token+"&category="+category;
			    	}else if(category == 'FAMILY PLANNING'){
				   		 url = "/hms/hms/fwc?method=showFamilyPlanningJsp&visitId="+visit+"&token="+token+"&category="+category;
			    	}else if(category == 'IMMUNIZATION'){
				   		 url = "/hms/hms/fwc?method=showImmunisationJsp&visitId="+visit+"&token="+token+"&category="+category;
				    }	else if(category == 'ANC FOLLOW UP'){
				   		 url = "/hms/hms/fwc?method=showAntCardFollowUpJsp&visitId="+visit+"&token="+token+"&hinId="+hin+"&category="+category;
				    	}
			     }
			   	obj1.action = url;
			    obj1.submit();
			   }
			 }
		 }
	


function showmedicalExamApprovingAuthourity(obj,boj2,formName,obj3)
{
	obj1 = eval('document.'+formName)
    var url ="";
		
    if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')){
    	
      url = "/hms/hms/medicalExam?method=showMedicalExamApprovingAuthorityJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
    }
    
    if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
        url = "/hms/hms/medicalExam?method=showPrimaryMedExamAAJsp&visitId="+obj+"&medExamId="+obj3;
        }
    if(boj2=='Med. Exam On Release/Discharge(AFMSF-18)'){
          url = "/hms/hms/medicalExam?method=showMedicalExamOCUnitJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
          }
    
    //----by kiran
    if(boj2=='Form-44'){
        url = "/hms/hms/medicalExam?method=showMeForm44JSP&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
        }
    
    obj1.action = url;
    obj1.submit();
}

function showmedicalExamPerAuthourity(obj,boj2,formName,obj3)
{
     obj1 = eval('document.'+formName)
     var url ="";
 	
 	
     if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')||(boj2=='Med. Exam On Release/Discharge(AFMSF-18)')){
     	
      url = "/hms/hms/medicalExam?method=showMedicalExamPersuingAuthorityJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
     }
     
     if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
     	
         url = "/hms/hms/medicalExam?method=showPrimaryMedExamPAJsp&visitId="+obj+"&medExamId="+obj3;
     }
    
    obj1.action = url;
    obj1.submit();
	
}

function showmedicalBoardMedicalOfficer(obj,boj2,formName,obj3){
	
	
	obj1 = eval('document.'+formName)
    var url ="";
	
	
    if((boj2=='Annual Medical Exam(AFMSF-3B)')||(boj2=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(boj2=='High Altitude Med. Exam(AFMSF-3B)')){
     url = "/hms/hms/medicalExam?method=showMedicalOfficerMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
    }
    if(boj2=='Primary/Extension Med. Exam(AFMSF-2A)'){
     url = "/hms/hms/medicalExam?method=showMOPrimaryMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+boj2;
     }
    if(boj2=='Med. Exam On Release/Discharge(AFMSF-18)'){
     url = "/hms/hms/medicalExam?method=showMedicalOfficerReleaseDischarge&visitId="+obj+"&medExamId="+obj3;
      }
   
    obj1.action = url;
    obj1.submit();
	
}


		function Request(obj,formName,rowVal)
		{

		if(formName == 'opdPatientList'){
		 if(rowVal==0)
		 {
			visit = obj.id;
			token = obj.tokenNo;
			alert()
		    obj1 = eval('document.'+formName)
		    var url;
		    if(formName == 'opdPatientList')
		    {
		    	url = "/hms/hms/opd?method=showOPDMainJsp&visitId="+visit+"&token="+token;
		    }
		  	    
		   	obj1.action = url;
		    obj1.submit();
		 }else{
		   if(alertBeforeSubmit())
		   {
		    visit = obj.id;
		    obj1 = eval('document.'+formName)
		    var url;
		    if(formName == 'opdPatientList')
		    {
		   		url = "/hms/hms/opd?method=showOPDMainJsp&visitId="+visit;
		    }
		   	obj1.action = url;
		    obj1.submit();
		   }
		 }
		 }
		else if(formName == 'fwcPatientList'){
		{
			 if(rowVal==0)
			 {
				visit = obj.id;
				token = obj.tokenNo;
				alert()
			    obj1 = eval('document.'+formName)
			    var url;
			    if(formName == 'fwcPatientList')
			    {
			       	url = "/hms/hms/fwc?method=showFWCMainJsp&visitId="+visit+"&token="+token;
			    }
			    
			   	obj1.action = url;
			    obj1.submit();
			 }else{
			   if(alertBeforeSubmit())
			   {
			    visit = obj.id;
			    obj1 = eval('document.'+formName)
			    var url;
			    if(formName == 'fwcPatientList')
			    {
			   	   	url = "/hms/hms/fwc?method=showFWCMainJsp&visitId="+visit+"&token="+token;
			    }
			   	obj1.action = url;
			    obj1.submit();
			   }
			 }
		}
		}
		else{
		    visit = obj.id;
		    obj1 = eval('document.'+formName)
		    var url;
		    if(formName == 'opdPatientVisit')
		   		url = "/hms/hms/opd?method=viewPreviousVisit&visitId="+visit;
		    
		   	obj1.action = url;
		    obj1.submit();
		 }
		 
		 
		 
		}
	function RequestForPrevFromOPD(obj,formName,rowVal){
			visit = obj.id;
		    obj1 = eval('document.'+formName)
		    var url;
		    if(formName == 'opdPatientVisitFromOPDScreen')
		   		url = "/hms/hms/opd?method=viewPreviousVisitForOPDMain&visitId="+visit;

		   	obj1.action = url;
		    obj1.submit();
	}	
	function RequestForPrevFromFWC(obj,formName,rowVal){
		visit = obj.id;
	    obj1 = eval('document.'+formName)
	    var url;
	    if(formName == 'fwcPatientVisitFromFWCScreen')
	   		url = "/hms/hms/fwc?method=viewPreviousVisitForFWCMain&visitId="+visit;

	   	obj1.action = url;
	    obj1.submit();
}	
	function RequestForSterilization(obj,formName,rowVal){
		visit = obj.id;
	    obj1 = eval('document.'+formName)
	    var url;
	    if(formName == 'waitingListForSterilisation')
	   		url = "/hms/hms/fwc?method=showIssueSterilizationCertificateJsp&visitId="+visit;

	   	obj1.action = url;
	    obj1.submit();
}	
	function RequestForReportCollection(obj,formName)
{
	
	hin = obj.id;
	result = obj.id;
	hin1 = obj.id;
	counsellingId=obj.id;
	opdId=obj.id;
	//alert("formName"+formName);
    obj1 = eval('document.'+formName)   
    var url;
    if(formName == 'reportCollection')
   		url = "/hms/hms/investigation?method=searchPatientForReportCollection&resultId="+result;
    
     if(formName == 'otPacClearedList')
    	url = "/hms/hms/ot?method=showOTBookingJsp&surgeryId="+hin;
    
      if(formName == 'smoWaitingList')
    	  url = "/hms/hms/mis?method=showSMOWaitingJsp&hinId="+hin1;
      //alert("counsellingId"+counsellingId);
      if(formName == 'smoWaitingList1')
    	  url = "/hms/hms/mis?method=showSMOWaitingJspForCounselling&counsellingId="+counsellingId;
      
      if(formName == 'notifiableWaitingList')
    	  //alert("notifiableWaitingList  in grid js "+opdId)
    	  url = "/hms/hms/mis?method=showNotifiableDiseaseWLJsp&opdId="+opdId;
      
      
   	obj1.action = url;
    obj1.submit();
}

	function showMedicalBoardJsp(obj,medExamType,formName){
		visitId = obj.id;
	    obj1 = eval('document.'+formName)
	    var url ="";
	   
	    if((medExamType=='Initial Medical Board AFMSF 15')||(medExamType=='Medical Board Review AFMSF 15')){
	    	if(validateMetaCharacters1(visitId)){
	    	url = "/hms/hms/medicalBoard?method=showInitialMedicalBoardMedExamJsp&visitId="+encodeURIComponent(visitId)+"&medExamType="+encodeURIComponent(medExamType);
	    	}
	    }
	    if((medExamType=='Medical Board AFMSF 16')){
	    	if(validateMetaCharacters1(visitId)){
	    	url = "/hms/hms/medicalBoard?method=showMedBoardMAForm16&visitId="+encodeURIComponent(visitId)+"&medExamType="+encodeURIComponent(medExamType);
	    	}
	    }
	    if(medExamType=='Form - 10'){
	    	if(validateMetaCharacters1(visitId)){
	    	url = "/hms/hms/medicalBoard?method=showMedBoardForm10&visitId="+encodeURIComponent(visitId)+"&medExamType="+encodeURIComponent(medExamType);
	    	}
	    }
	    if((medExamType=='Annual Medical Exam(AFMSF-3B)')||(medExamType=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(medExamType=='High Altitude Med. Exam(AFMSF-3B)')){
	    	if(validateMetaCharacters1(visitId)){
	    	url = "/hms/hms/medicalExam?method=showAnnualMedExamJsp&visitId="+encodeURIComponent(visitId)+"&medExamType="+encodeURIComponent(medExamType);
	    	}
	    }
	    if(medExamType=='Primary/Extension Med. Exam(AFMSF-2A)'){
	    	if(validateMetaCharacters1(visitId)){
	    	 url = "/hms/hms/medicalExam?method=showPrimaryExtMedExamJsp&visitId="+encodeURIComponent(visitId);
	    	}
	    }
	    //--by kiran
	    if((medExamType=='Form-44')){
	    	if(validateMetaCharacters1(visitId)){
	    	url = "/hms/hms/medicalBoard?method=showMbForm44JSP&visitId="+encodeURIComponent(visitId)+"&medExamType="+encodeURIComponent(medExamType);
	    	}
	    }
	    if((medExamType=='Form-44 (Interim Category)')){
	    	if(validateMetaCharacters1(visitId)){
	    	url = "/hms/hms/medicalBoard?method=showMbForm44IntermeJSP&visitId="+encodeURIComponent(visitId)+"&medExamType="+encodeURIComponent(medExamType);
	    	}
	    }
	    
	   	obj1.action = url;
	    obj1.submit();
	}  

	function showMedBrdMedicalOfficer(obj,medExamType,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		  
		if((medExamType=='Initial Medical Board AFMSF 15') ||(medExamType=='Medical Board Review AFMSF 15') ){
	        url = "/hms/hms/medicalBoard?method=showMedicalOfficerInitial&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	        }
		if(medExamType=='Medical Board AFMSF 16' ){
			url = "/hms/hms/medicalBoard?method=showMedBoardMOForm16&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	      }
		if((medExamType=='Annual Medical Exam(AFMSF-3B)')||(medExamType=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(medExamType=='High Altitude Med. Exam(AFMSF-3B)')){
		    	url = "/hms/hms/medicalExam?method=showMedicalOfficerMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+medExamType;
		 }
		if(medExamType=='Primary/Extension Med. Exam(AFMSF-2A)'){
		     url = "/hms/hms/medicalExam?method=showMOPrimaryMedExamJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+medExamType;
		     }
	    obj1.action = url;
	    obj1.submit();
	}
	/*
	 * Code By Mukesh
	 * Code for Specialist Opinion
	 * Date 03 Apr 2012 
	 */
	/*
	 * function openPopupForSpecialistOpinion(visitId,medExamId){
		var url="/hms/hms/medicalBoard?method=showSpecialistOpinionJsp&visitId="+visitId+"&medExamId="+medExamId;
	   newwindow=window.open(url,'mbSpecialistOpinion','left=0,top=0,height=800,width=1002,status=1,scrollbars=1,resizable=1');
	}

	 */
	function showMedBrdMedicalSpecialistOpinion(obj,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		/*
		 * directFlag=D means Direct from waiting list else from medical board MO
		 */
		if(formName == 'medicalBoardSpecialist'){
		url="/hms/hms/medicalBoard?method=showSpecialistOpinionJsp&visitId="+obj+"&SecialFlag=D&directFlag=D&medExamId="+obj3;
		}else{
			url="/hms/hms/medicalExam?method=showSpecialistOpinionJspForExam&visitId="+obj+"&SecialFlag=D&directFlag=D&medExamId="+obj3;
		}
	    obj1.action = url;
	    obj1.submit();
	}
	function showMedBrdCommandingOfficer(obj,medExamType,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		if(medExamType=='Medical Board AFMSF 16' ){
			url = "/hms/hms/medicalBoard?method=showCommandOfficerForm16&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	  }
	    obj1.action = url;
	    obj1.submit();
	}
	
	function showMedicalBoardOpinion(obj,medExamType,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		if(medExamType=='Medical Board AFMSF 16' ){
			url = "/hms/hms/medicalBoard?method=showMedicalBoardForm16&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	  }
	    obj1.action = url;
	    obj1.submit();
	}
	function showMedBrdApproveAuth(obj,medExamType,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		if((medExamType=='Initial Medical Board AFMSF 15') ||(medExamType=='Medical Board Review AFMSF 15') ){
	        url = "/hms/hms/medicalBoard?method=showInitialMedicalBoardAppAuthJsp&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	        }
		if(medExamType=='Medical Board AFMSF 16' ){
			url = "/hms/hms/medicalBoard?method=showInitialMedicalBoardAppAuthForm16Jsp&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	      }
		 if((medExamType=='Annual Medical Exam(AFMSF-3B)')||(medExamType=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(medExamType=='High Altitude Med. Exam(AFMSF-3B)')){
		    	
		      url = "/hms/hms/medicalExam?method=showMedicalExamApprovingAuthorityJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
		    }
		    
		    if(medExamType=='Primary/Extension Med. Exam(AFMSF-2A)'){
		        url = "/hms/hms/medicalExam?method=showPrimaryMedExamAAJsp&visitId="+obj+"&medExamId="+medExamType+"&search="+false;
		        }
			
	    obj1.action = url;
	    obj1.submit();
	} 
	
	function showMedBrdConfirmAuth(obj,medExamType,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		if(medExamType=='Medical Board AFMSF 16' ){
			url = "/hms/hms/medicalBoard?method=showMBConfirmingAuthorityWaitList&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	      }
	    obj1.action = url;
	    obj1.submit();
	} 
	function showMedBrdAcceptAuth(obj,medExamType,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		if(medExamType=='Medical Board AFMSF 16' ){
			url = "/hms/hms/medicalBoard?method=showMBAcceptAuthForm16Jsp&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	      }

	    obj1.action = url;
	    obj1.submit();
	}
	function showMedBrdPerusingAuth(obj,medExamType,formName,obj3){
		obj1 = eval('document.'+formName)
	    var url ="";
		if((medExamType=='Initial Medical Board AFMSF 15') ||(medExamType=='Medical Board Review AFMSF 15') ){
	        url = "/hms/hms/medicalBoard?method=showInitialMedicalBoardPerusingAuthJsp&visitId="+obj+"&accessjsp=CommandLevel&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;
	        }
		  if((medExamType=='Annual Medical Exam(AFMSF-3B)')||(medExamType=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(medExamType=='High Altitude Med. Exam(AFMSF-3B)')){
		    	
			  url = "/hms/hms/medicalExam?method=showMedicalExamPersuingAuthorityJsp&visitId="+obj+"&medExamId="+obj3+"&medExamType="+medExamType+"&search="+false;;
		    }
	    obj1.action = url;
	    obj1.submit();
	} 
	function showMedicalExamJsp(obj,medExamType,formName)
	{
		
		visitId = obj.id;
	    obj1 = eval('document.'+formName)
	    var url ="";
	    if(medExamType=='Primary/Extension Med. Exam(AFMSF-2A)'){
	    	url = "/hms/hms/medicalExam?method=showPrimaryExtMedExamJsp&visitId="+visitId;
	    }else if((medExamType=='Annual Medical Exam(AFMSF-3B)')||(medExamType=='Prior To Proceedings Abroad Med. Exam(AFMSF-3B)')||(medExamType=='High Altitude Med. Exam(AFMSF-3B)'))
	    {   
	    	if(validateMetaCharactersExam(medExamType)){
	    		url = "/hms/hms/medicalExam?method=showAnnualMedExamJsp&visitId="+visitId+"&medExamType="+medExamType;
	    	}
	    }else if(medExamType=='Med. Exam On Release/Discharge(AFMSF-18)')
	    {
	    	if(validateMetaCharactersExam(medExamType)){
	    	url = "/hms/hms/medicalExam?method=showReleaseDischargeJsp&visitId="+visitId+"&medExamType="+medExamType;
	    	}
	    }else if(medExamType == 'Medical Case Sheet(AFMSF-7A)'){
	    	url = "/hms/hms/opd?method=showOPDMainJsp&visitId="+visitId;
	    	
	    }else if(medExamType == 'Form-44(AFMSF-44)'){
	    	url = "/hms/hms/opd?method=showOPDMainJsp&visitId="+visitId;
	    }	    
	    else if(medExamType=='AFMSF-7A')
	    { 
	    	url = "/hms/hms/medicalExam?method=showAFMSF7AJsp&visitId="+visitId+"&medExamType="+medExamType;
	    }
	    //-by kiran
	    else if(medExamType == 'Form-44')
	    {
	    	url = "/hms/hms/medicalExam?method=showMeForm44JSP&visitId="+visitId;
	    }
	   	obj1.action = url;
	    obj1.submit();
		
	} 
	

	function validateMetaCharactersExam( strValue ) {
		var objRegExp=/([\\\_\:\@\$\*\"\&\'\`\#\�\�\?\%\&\<\>\=\n\r])/i
		return !objRegExp.test(strValue);
		
	}
	
	function validateMetaCharacters1( strValue ) {
		var objRegExp=/(\s{2,})|([\\\/\.\(\)\_\:\@\$\*\"\&\-\'\`\#\�\�\?\%\&\<\>\=\n\r])/i
		return !objRegExp.test(strValue);
		
	}
	
	function alertBeforeSubmit(){
	if(confirm("Are you jumping the queue?"))
		return true;
	return false;
}
/*
  for editing the grid
  */
	subtest_arr = new Array();
	currentRowClicked=""
	nonEditable="";


function editRecord(obj,formName){

	tmptext = ""	
	if(currentRowClicked != "" ){
		if(subtest_arr.length>0){
			document.chargeCode.multipleresults.checked= false;
			document.getElementById('multiplebutton').style.display = 'none';
		}
		if(nonEditable){
			for(m=0;m<nonEditable.length;m++){
				nonEditableObj = eval("document."+ formName + "."  + nonEditable[m])
				if(nonEditableObj){
					if(nonEditableObj.type == "select-one"){
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
			document.getElementById('addbutton').style.display = 'none'
		if(document.getElementById('editbutton'))	
			document.getElementById('editbutton').style.display = 'none';	
		if(document.getElementById('deletebutton'))	
			document.getElementById('deletebutton').style.display = 'none';			
		for(i=0;i<formFields.length;i++){
			
			temp = eval("document."+ formName + "." +  formFields[i][1])
			if(temp){
				if(temp.type == "select-one")
					temp.selectedIndex = 0;
				else if(temp.type == "checkbox"){
						temp.checked = false;
				}
				else
					temp.value = "";
			}
		}
	}
	
	if(currentRowClicked != obj.id){
		
		if(document.getElementById('editbutton'))
			document.getElementById('editbutton').style.display = 'inline'
		if(document.getElementById('deletebutton'))
			document.getElementById('deletebutton').style.display = 'inline'		
		if(document.getElementById('addbutton'))	
			document.getElementById('addbutton').style.display = 'none';
		if(subtest_arr.length>0){
			chkMultipleTest(obj.id);
		}
		if(nonEditable){
			for(m=0;m<nonEditable.length;m++){
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
			temp = eval("document."+ formName + "."  +  formFields[i][1])
			if(formFields[i][1] == "addEditBy")
				tmptext += "<label style='float: left; width: 230px'>last Edited By:</label><span style='width: 180px'>"+ obj.cells[formFields[i][0]-1].childNodes[0].innerHTML +"</span>"
			if(formFields[i][1] == "addEditOn")
				tmptext += "<label style='float: left; width: 90px'>On:</label><span style='width: 180px'>"+ obj.cells[formFields[i][0]-1].childNodes[0].innerHTML +"</span>"				
			if(temp){
				if(temp.type == "select-one"){
					if(formName == "subTest")
						temp.selectedIndex = findElementIndex(temp, obj.cells[formFields[i][0]-1].innerHTML);
					else
						temp.selectedIndex = findElementIndex(temp, obj.cells[formFields[i][0]-1].childNodes[0].innerHTML);
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
}
  
  /*
  for editing the grid
  */
  
function navigateIPD(obj){
	document.paging.firstpage.style.border = "none"
	document.paging.nextpage.style.border = "none"
	document.paging.lastpage.style.border = "none"
	document.paging.prevpage.style.border = "none"		
	//currentPage = document.paging.pageno.value;
	initTabButtons()
	if(obj.value == 'f' && data_arr.length>rowsPerPage){
		makeGridForPatient(0,rowsPerPage);
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
			makeGridForPatient(start-rowsPerPage,start);
			//document.getElementById('pageno').value--;
			document.getElementById("currStart").value=(document.getElementById("current").innerHTML-2)*10+1
				document.getElementById("currEnd").value=(document.getElementById("current").innerHTML-1)*10
				document.getElementById("current").innerHTML--;
		}

	}
	else if(obj.value == 'n'){
		if(start+rowsPerPage*2<data_arr.length){
			makeGridForPatient(start+rowsPerPage,start+(rowsPerPage*2));
			
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
			makeGridForPatient(start+rowsPerPage,data_arr.length);
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
			makeGridForPatient(data_arr.length - rowsPerPage, data_arr.length);
			//document.getElementById('pageno').value=totalPages;
			document.getElementById("currStart").value=data_arr.length-9
			document.getElementById("currEnd").value=data_arr.length
			document.getElementById("current").innerHTML=totalPages
		} else {
			makeGridForPatient((data_arr.length - (data_arr.length % rowsPerPage)), data_arr.length);
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

var sortNo;
function sortGrid(no,dir){
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
  	  makeGridForPatient(0,data_arr.length)
  	else
	    makeGridForPatient(0,rowsPerPage)
    //document.getElementById('pageno').value=1
    document.getElementById("currStart").value=1
    document.getElementById("currEnd").value=10
    document.getElementById("current").innerHTML=1
}

function goToPageForPatient(pageno){
	
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
	if(pageno*rowsPerPage<data_arr.length){
		makeGridForPatient(pageno*rowsPerPage-rowsPerPage,pageno*rowsPerPage)
	}
	else
	{
		makeGridForPatient(pageno*rowsPerPage-rowsPerPage,data_arr.length)
	}	
	
	document.getElementById("currStart").value=(pageno-1)*10+1
		
		document.getElementById("currEnd").value=(pageno)*10
		
		document.getElementById("current").innerHTML=pageno
	
}
/*Grid for Ward Mgmt. By VIKAS---------Ends*/