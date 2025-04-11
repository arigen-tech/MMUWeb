/**
 * 
 */

function getApprovalProcessForCommon(MODE,className)
	 {
	 	var userId = $('#userId').val();
		var unitId = $('#hospitalId').val();
		var serviceNo = $('#serviceNo').val();
	 	var selectedMenu,selectedSubMenu;
		var flag="";
	    $(' #side-menu .nav-second-level a').each(function(){
	    		    	
			
			if($(this).hasClass('active')){
				
				selectedMenu = $(this).attr('data-name');
				selectedSubMenu = $(this).find('span').attr('id');
				//console.log(selectedSubMenu);
			}
		})
		var meMbFlag='';
		if(selectedMenu == 'inbox' && selectedSubMenu=='mexam'){
			flag='af';
			meMbFlag="ME";
		}else if(selectedMenu == 'approved' && selectedSubMenu=='mexamApp'){
			flag='ac';
			meMbFlag="ME";
		}else if(selectedMenu == 'rejected' && selectedSubMenu=='mexamRej'){
			flag='rj';
			meMbFlag="ME";
		}
		else if(selectedMenu == 'inbox' && selectedSubMenu=='mbxam'){
			flag='af';
			meMbFlag="MB";
		}
		else if(selectedMenu == 'approved' && selectedSubMenu=='mbxamApp'){
			flag='ac';
			meMbFlag="MB";
		}else if(selectedMenu == 'rejected' && selectedSubMenu=='mbxamRej'){
			meMbFlag="MB";
			flag='rj';
		}
	    
		else if(selectedMenu == 'digiRejected' && selectedSubMenu=='digiRej'){
			meMbFlag="digiForMe";
			flag='rj';
		}
		
		else if(selectedMenu == 'digiApproved' && selectedSubMenu=='digiAppr'){
			meMbFlag="digiForMe";
			flag='app';
		}
		
		
	 if(MODE == 'ALL'){
		 var data = {"pageNo":nPageNo,"flag":flag,'userId' : userId,'unitId':unitId,'serviceNo':'',"membFlab":meMbFlag};		
		}
	else
		{
		var data = {"pageNo":nPageNo,"flag":flag,'userId' : userId,'unitId':unitId,'serviceNo':serviceNo,"membFlab":meMbFlag};
		} 
	 $('#approvalFlg').val(flag);
	 	var pathname = window.location.pathname;
		 var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup+"/medicalexam/getApprovalListByFlag";
		 
		 if(selectedSubMenu=='mbxam' || selectedSubMenu=='mbxamApp'||selectedSubMenu=='mbxamRej'){
			 var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup+"/medicalexam/getApprovalListByFlag";
		 }
		 if(selectedSubMenu=='mexam'||selectedSubMenu=='mexamApp'||selectedSubMenu=='mexamRej'){
			 var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup+"/medicalexam/getApprovalListByFlag";
		 }
			
		 if(selectedSubMenu=='digiRejected'){
			 var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup+"/digifileupload/digiReject";
		 }
		 if(selectedSubMenu=='digiApproved'){
			 var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup+"/digifileupload/digiApproved";
		 }
		 
		 
		 
		 
			var bClickable = true;
		 	GetJsonDataForCommon('tblListOfME',data,url,bClickable,"waitingImgId",className,'tblListOfME','resultnavigation');
		
	 
	 }



function makeTableCommon(jsonData,gridId)
{
	if(gridId=="tblListOfME"){
	 var medicalExamList = jsonData.data;
	 getMedicalExamDetail(medicalExamList,gridId);
	 }
	 
	/*if(flagCheck=="masDesignationGrid"){
		var dataDesignationList  = jsonData.dataDesignationList;
		getMasDesinationDetail(dataDesignationList)
	 }
	 
	if(flagCheck=="unitAdminForNormalUser"){
		var dataUserList  = jsonData.dataUserList;
		getUnitAdminDetailForNormalUser(dataUserList)
	 }
	*/
}

function getMedicalExamDetail(dataList,gridId){
	var htmlTable="";
	var statusActive="y";
	var statusDeActive="n";
	var count=0;
	if(dataList!=null && dataList.length >= 0)
		for(i=0;i<dataList.length;i++)
			{		
				htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
			 
				htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].patientId+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rankName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].meAgeNew+"</td>";			
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].gender+"</td>";
				if(dataList[i].mediceExamDate!="" && dataList[i].mediceExamDate!=undefined)
				{	
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mediceExamDate+"</td>";
				}
				else{
					htmlTable = htmlTable +"<td style='width: 100px;'></td>";
				}
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].medicalCategory+"</td>";			
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meTypeName+"</td>";
				/*htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].moUser+" </td>";*/
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rMoUser+" </td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].miRoom+"</td>";			
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rhqValue+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].status+"</td>";
				
				htmlTable = htmlTable+"</tr>";
				count++;
			}
		if(dataList==null || dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
			}			
		$("#"+gridId).html(htmlTable);
		
		$j("#search").hide();	
		$j("#indenttb").hide();
		
		$('#search').show();
		$('#medicalExam').show();
		
}


function showResultPage(pageNo,gridId)
{
	nPageNo = pageNo;	
	if(gridId=="tblListOfME"){
		getApprovalProcessForCommon('FILTER',"SearchStatus");
	}
	
	/*if(flagCheck=="masDesignationGrid"){
		getAllMasDesinationDetail('FILTER',"SearchStatusForMassDesignation");
	 	}
	
	if(flagCheck=="unitAdminForNormalUser"){
		getAllUnitAdminDetailForNormalUser('FILTER',"SearchStatusForUnitAdminNorUser");
	}*/
}
