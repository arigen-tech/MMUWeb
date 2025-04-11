var nPageNo = 1;
var TotalNumberOfPages=0;
var goToFlag;
var $j = jQuery.noConflict();


$j(document).ready(function(){
/////////////////////////Added by Avinash////////////////
	var dateRangValue=resourceJSON.dateDisablePre;
	var dateOfMmuStart=resourceJSON.dateDisableMMUStart;
	/////////////////////////Added by Avinash////////////////
	/*$j('#fromdate-pick').datepicker({ showOn: "button",
		buttonImage: "/hms/jsp/images/calendar.gif",		
		buttonImageOnly: true,
		buttonText: 'Select Date',
		yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:true});
	
	$j('#todate-pick').datepicker({ showOn: "button",
		buttonImage: "/hms/jsp/images/calendar.gif",		
		buttonImageOnly: true,
		buttonText: 'Select Date',
		yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:true});

	$j('body').on("focus",".input_date", function() {
    	
    	 $j(this).datepicker({ showOn: "button",
    			buttonImage: "/hms/jsp/images/calendar.gif",		
    			buttonImageOnly: true,
    			yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false});    
 				
 		
    }); 
	
	$j('body').on("focus",".calDate", function() {
    	
   	 $j(this).datepicker({ showOn: "button",
   			buttonImage: "/hms/jsp/images/calendar.gif",		
   			buttonImageOnly: true,
   			yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false});       
		
		
		
   }); */
	
	$j('body').on("focus",".input_date", function() {
    	
   	 $j(this).datepicker({ showOn: "button",
   		buttonImage: "../resources/images/calendar.gif",
   		dateFormat: 'dd/mm/yy',
		buttonImageOnly: true,
		buttonText: 'Select Date',
		yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false});  
				
		
   }); 
	
	$j('document').on("focus",".input_date", function() {
    	
	   	 $j(this).datepicker({ showOn: "button",
	   		buttonImage: "../resources/images/calendar.gif",		
			buttonImageOnly: true,
			dateFormat: 'dd/mm/yy',
			buttonText: 'Select Date',
			yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false});  
					
			
	   }); 
	
	$j('body').on("focus",".noFuture_date", function() {
    	
	   	 $j(this).datepicker({ showOn: "button",
	   		buttonImage: "../resources/images/calendar.gif",		
			buttonImageOnly: true,
			dateFormat: 'dd/mm/yy',
			buttonText: 'Select Date',
			selectWeek:false,
			closeOnSelect:true,  
			changeMonth: true, 
			changeYear: true,
			clickInput:false,
			yearRange: '1900:2090',
			maxDate: new Date()
	   	 });  
			
	   });
	
	$j('body').on("focus",".noBack_date", function() {
    	
	   	 $j(this).datepicker({ showOn: "button",
	   		buttonImage: "../resources/images/calendar.gif",		
			buttonImageOnly: true,
			dateFormat: 'dd/mm/yy',
			buttonText: 'Select Date',
			selectWeek:false,
			closeOnSelect:true,  
			changeMonth: true, 
			changeYear: true,
			clickInput:false,
			yearRange: '1900:2090',
			minDate: new Date()
	   	 });  
			
	   });
	
	$j(".noFuture_date2").datepicker({ showOn: "button",
		buttonImage: "../resources/images/calendar.gif",
		dateFormat: 'dd/mm/yy',
		buttonImageOnly: true,
		buttonText: 'Select Date',
		yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false,maxDate: new Date()});
	
	$j(".noFuture_datePos").datepicker({ showOn: "button",
		buttonImage: "../resources/images/calendar.gif",
		dateFormat: 'dd/mm/yy',
		buttonImageOnly: true,
		buttonText: 'Select Date',
		beforeShow: function()  {
			if($(this).closest('.dateRightPosition').length>0){
				$('#ui-datepicker-div').addClass('dateRightModal');
			}
		},
		onClose:function(){
			$('#ui-datepicker-div').removeClass('dateRightModal');
		},
		yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false,maxDate: new Date()});
	
	$j(".noBack_date2").datepicker({ showOn: "button",
		buttonImage: "../resources/images/calendar.gif",
		dateFormat: 'dd/mm/yy',
		buttonImageOnly: true,
		buttonText: 'Select Date',
		yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false,minDate: new Date()});
	
	
	$j(".calDate").datepicker({ showOn: "button",
		buttonImage: "../resources/images/calendar.gif",
		dateFormat: 'dd/mm/yy',
		buttonImageOnly: true,
		buttonText: 'Select Date',
		yearRange: '2020:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false,minDate: dateOfMmuStart});
	
	/////////////////////Added by Avinash/////////////////////////
	$j(".noBack_dateReport").datepicker({ showOn: "button",
		buttonImage: "../resources/images/calendar.gif",
		dateFormat: 'dd/mm/yy',
		buttonImageOnly: true,
		buttonText: 'Select Date',
		yearRange: '2020:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false,minDate: dateRangValue});
	/////////////////////Added by Avinash/////////////////////////	
	

	
	
	// disable copy paste on input elements	
	$j(document).on('copy paste','.disablecopypaste,.disablecopypasteDiv input', function (e) {
	       e.preventDefault();
	       alert("You cannot paste into this text field.");
    });
	
	// get file name in label for custom file upload input
	$(document).on('change','.inputUpload',function() {
	    if ($(this).val()) {	         
	    	var uploadFilePathName = $(this).val(),uploadFileName;	        
	        uploadFileName = uploadFilePathName.split(/[\\\/]/).pop();	        
	        $(this).siblings('.inputUploadFileName').html(uploadFileName);
	        
	        //To show remove file icon
	        $(this).parent('.fileUploadDiv').addClass('hasFile');
	        $(this).siblings('.inputUploadlabel').text('Remove File');
	    }
	  });
	
	//To show remove file icon functionality
	$(document).on('click','.fileUploadDiv.hasFile',function(e) {	    	
			e.preventDefault();
	        $(this).removeClass('hasFile');
	        $(this).children('.inputUpload').val('');
	        $(this).children('.inputUploadFileName').html('No File Chosen');
	        $(this).children('.inputUploadlabel').text('Choose File');	
	       try{
	        var radionButtonCheckId= $(this).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	         var radioValue =$('#'+radionButtonCheckId).is(':checked');
	        if(!radioValue){
	        	 $("#"+radionButtonCheckId).attr('checked', 'checked');
	        	 updateNewIdWhenRadioCheck(this);
	        }
	       }
	       catch(e){}
	  });
});


function removeRow(tableId,extraFunc)
{
	
	var valCheckBox = new Array();
	$j('[id="chk"]:checked').each(function(j)
			{
				
				valCheckBox[j] = $j(this).val();
			});
	//alert(valCheckBox);
	if(valCheckBox == "")
		alert("Please select the rows that you want to delete.");
	
	for(var i=0;i<valCheckBox.length;i++)
		{
		
			$j("#"+tableId+" tr[id='"+valCheckBox[i]+"']").remove();
		}
	var valRowId = new Array();
	$j("#"+tableId+" tr[id!='th']").each(function(j)
			{
				valRowId[j] =$j(this).attr("id");
			});
	$j("#tableRowId").val(valRowId);
	eval(extraFunc); 
}

function checkAll()
{	
	if($j('#chkAll').prop("checked") == "true" || $j('#chkAll').prop("checked") == true || $j('#chkAll').prop("checked") == "checked")
	{
		
		$j('[id="chk"]:checkbox').prop("checked","checked");	
		
	}
	else
	{		
		
		$j('[id="chk"]:checkbox').removeAttr("checked");
	}
	
}

function createPaginating(NumberOfPages)
{
	TotalNumberOfPages=NumberOfPages;
	nPageNo = 1 * nPageNo;
	var nextValue = nPageNo + 1;
	var PreValue = nPageNo - 1;
	
	
	
	/*if(NumberOfPages==1)
	{
	  
	  $j("#resultnavigation").append("Page <span id=\"current\">"+nPageNo+"</span> of <span id=\"total\">"+NumberOfPages+"</span>");
	   		 
	   
	}*/
	if(NumberOfPages>0)
		{
		  $j("#resultnavigation").append("Go To Page <input class=\"form-control pageInput m-r-5\" type=\"text\" id=\"goToPage\" name=\"gotopageinput\"\" >");
		  $j("#resultnavigation").append("<input class=\"btn btn-sm btn-primary noMinWidth goToBtn\" style=\"margin-top:-2px;\" type=\"button\"  value=\"Go\" name=\"gotopage\" onclick=\"goToSpecificPage()\" >");
		  $j("#resultnavigation").append("<input class=\"previous\" type=\"button\"  value=\"f\" name=\"firstpage\" onclick=\"showResultPage('1')\" >");
		  $j("#resultnavigation").append("<input class=\"singlePrev\" type=\"button\"  value=\"f\" name=\"prevpage\"  onclick=\"showResultPage('"+PreValue+"')\" >");
		  $j("#resultnavigation").append("Page <span id=\"current\">"+nPageNo+"</span> of <span id=\"total\">"+NumberOfPages+"</span>");
		  $j("#resultnavigation").append("<input class=\"singleNext\" type=\"button\"  value=\"f\" name=\"nextpage\"  onclick=\"showResultPage('"+nextValue+"')\">");
		  $j("#resultnavigation").append("<input class=\"next\" type=\"button\"  value=\"f\" name=\"lastpage\" onclick=\"showResultPage("+NumberOfPages+")\">"); 		 
		   
		}
	
	
}

function goToSpecificPage(){
	var goToPageVal = document.getElementById('goToPage').value ;
	
	if( goToPageVal == '' || goToPageVal == 0 || goToPageVal > TotalNumberOfPages)
		{
			alert('Please specify a valid page no.');
		}
	else{
		showResultPage(goToPageVal);
	}
}

function createPaginatingModel(NumberOfPages)
{
	TotalNumberOfPages=NumberOfPages;
	nPageNo = 1 * nPageNo;
	var nextValue = nPageNo + 1;
	var PreValue = nPageNo - 1;
	

	if(NumberOfPages>0)
		{
		  $j("#resultnavigationModel").append("Go To Page <input class=\"form-control pageInput m-r-5\" type=\"text\" id=\"goToPageModel\" name=\"gotopageinput\"\" >");
		  $j("#resultnavigationModel").append("<input class=\"btn btn-sm btn-primary noMinWidth goToBtn\" style=\"margin-top:-2px;\" type=\"button\"  value=\"Go\" name=\"gotopage\" onclick=\"goToSpecificPageModel()\" >");
		  $j("#resultnavigationModel").append("<input class=\"previous\" type=\"button\"  value=\"f\" name=\"firstpage\" onclick=\"showResultPage('1')\" >");
		  $j("#resultnavigationModel").append("<input class=\"singlePrev\" type=\"button\"  value=\"f\" name=\"prevpage\"  onclick=\"showResultPage('"+PreValue+"')\" >");
		  $j("#resultnavigationModel").append("Page <span id=\"current\">"+nPageNo+"</span> of <span id=\"total\">"+NumberOfPages+"</span>");
		  $j("#resultnavigationModel").append("<input class=\"singleNext\" type=\"button\"  value=\"f\" name=\"nextpage\"  onclick=\"showResultPage('"+nextValue+"')\">");
		  $j("#resultnavigationModel").append("<input class=\"next\" type=\"button\"  value=\"f\" name=\"lastpage\" onclick=\"showResultPage("+NumberOfPages+")\">"); 		 
		   
		}
	
	
}

function goToSpecificPageModel(){
	var goToPageValModel = document.getElementById('goToPageModel').value ;
	
	if( goToPageValModel == '' || goToPageValModel == 0 || goToPageValModel > TotalNumberOfPages)
		{
			alert('Please specify a valid page no.');
		}
	else{
		showResultPage(goToPageValModel);
	}
}

function DoEnableDisabledPaging(NumberOfPages)
{
	
	if(nPageNo == 1 && nPageNo >0 )
		{
			$j(".previous").addClass("previousDisable");
			$j(".singlePrev").addClass("singlePrevDisable");
			$j(".previous").attr("disabled","disabled");
			$j(".singlePrev").attr("disabled","disabled");
		}
	
	if(nPageNo == NumberOfPages)
	{		
		$j(".next").addClass("nextDisable");
		$j(".singleNext").addClass("singleNextDisable");
		$j(".next").attr("disabled","disabled");
		$j(".singleNext").attr("disabled","disabled");
	}
	
	if(NumberOfPages == 1)
	{
	$j(".goToBtn").attr("disabled","disabled");
	}
	
		
}

function GetJsonData(tableId,data,url,bClickable,waitingImgId)
{
	
	$j("#"+waitingImgId).show();
	
	$j('.SearchStatus').css('color','green');
	$j('.SearchStatus').html('<i class="fa fa-spinner fa-spin"></i> '+S_Search_Searching);
	
			$j.ajax({
				type:"POST",
				contentType : "application/json",
				url: url,
				data : JSON.stringify(data),
				dataType: "json",			
				cache: false,
				async: true,
				success: function(msg)
				{
					$j("#"+waitingImgId).hide();
					var jsonData = msg;		
					
					//alert(msg)
					
						
							var totalMatches = jsonData.count;
							//alert(jsonData.count);
							var totalRecordsForPagination = 0;
							
							//alert(totalRecordsForPagination);
							
							if(totalMatches>0)
								{
									totalRecordsForPagination = jsonData.count;
								}
							var NumberOfPages = Math.ceil(totalRecordsForPagination/paginationCount);
							$j("#resultnavigation").html("");
							createPaginating(NumberOfPages);
							
							DoEnableDisabledPaging(NumberOfPages);	
							
							
							if(NumberOfPages == 1)
								{
									//$j("#resultnavigation").html("");
								}
							if(totalRecordsForPagination == 0)
								{									
									$j('.SearchStatus').html(S_Search_NoMatches);
								}
							 if(totalRecordsForPagination == 1)
								{
									$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Single_Match);	
								}	
							 if(totalRecordsForPagination > 1)
								{
									$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Multi_Matches);	
								}	
							  
							  makeTable(jsonData);
							  //alert(bClickable)
							  if(totalRecordsForPagination != 0 && bClickable )
								  {
									  $j("#"+tableId+" tr[id!='0']").hover(
										      function () {										          
										          //$j(this).css("background-color", "#EDF4DA");		
										          if(bClickable == true)
										        	  {
										        	  	$j(this).css("cursor","pointer");
										        	  }
										        }, 
										        function () {
										        
										          $j(this).css("background-color", "");
										        }
											)
											.click(
												function(){
													if(bClickable == true)
														{
															executeClickEvent($j(this).attr("id"),jsonData);
														}
												}
											);
								  }
							 
							
						
					
				},
				error: function(msg)
				{					
					
					alert("An error has occurred while contacting the server");
					$j('.SearchStatus').css('color','red');
					$j('.SearchStatus').html(S_Search_Error);
					$j("#"+waitingImgId).hide();
					
				}
				
				
			});
}



function GetJsonDataForModel(tableId,data,url,bClickable,resultnavigationModel,waitingImgId)
{
	
	$j("#"+waitingImgId).show();
	$j('.SearchStatus1').css('color','green');
	$j('.SearchStatus1').html('<i class="fa fa-spinner fa-spin"></i> '+S_Search_Searching);
	
			$j.ajax({
				type:"POST",
				contentType : "application/json",
				url: url,
				data : JSON.stringify(data),
				dataType: "json",			
				cache: false,
				success: function(msg)
				{
					$j("#"+waitingImgId).hide();
					var jsonData = msg;		
							var totalMatches = jsonData.count;
							var totalRecordsForPagination = 0;
							if(totalMatches>0)
								{
									totalRecordsForPagination = jsonData.count;
								}
							var NumberOfPages = Math.ceil(totalRecordsForPagination/paginationCount);
							$j("#"+resultnavigationModel).html("");
							createPaginatingModel(NumberOfPages);
							DoEnableDisabledPaging(NumberOfPages);	
							if(NumberOfPages == 1)
								{
									//$j("#resultnavigation").html("");
								}
							if(totalRecordsForPagination == 0)
								{									
									$j('.SearchStatus1').html(S_Search_NoMatches);
								}
							 if(totalRecordsForPagination == 1)
								{
									$j('.SearchStatus1').html(totalRecordsForPagination + " " +S_Search_Single_Match);	
								}	
							 if(totalRecordsForPagination > 1)
								{
									$j('.SearchStatus1').html(totalRecordsForPagination + " " +S_Search_Multi_Matches);	
								}	
							 makeTableModel(jsonData);
							  if(totalRecordsForPagination != 0 && bClickable )
								  {
									  $j("#"+tableId+" tr[id!='0']").hover(
										      function () {										          
										          if(bClickable == true)
										        	  {
										        	  	$j(this).css("cursor","pointer");
										        	  }
										        }, 
										        function () {
										        
										          $j(this).css("background-color", "");
										        }
											)
											.click(
												function(){
													if(bClickable == true)
														{
															executeClickEvent($j(this).attr("id"),jsonData);
														}
												}
											);
								  }
							 
							
						
					
				},
				error: function(msg)
				{					
					
					alert("An error has occurred while contacting the server");
					$j('.SearchStatus1').css('color','red');
					$j('.SearchStatus1').html(S_Search_Error);
					$j("#"+waitingImgId).hide();
				}
			});
}







function GetOpdJsonData(tableId,data,url,bClickable,waitingImgId)
{
	
	$j("#"+waitingImgId).show();
	
	$j('.SearchStatus').css('color','green');
	$j('.SearchStatus').html('<i class="fa fa-spinner fa-spin"></i> '+S_Search_Searching);
	
			$j.ajax({
				type:"POST",
				contentType : "application/json",
				url: url,
				data : JSON.stringify(data),
				dataType: "json",			
				cache: false,
				success: function(msg)
				{
					$j("#"+waitingImgId).hide();
					var jsonData = msg;		
					
					//alert(msg)
					
						
							var totalMatches = jsonData.count;
							//alert(jsonData.count);
							var totalRecordsForPagination = 0;
							
							//alert(totalRecordsForPagination);
							
							if(totalMatches>0)
								{
									totalRecordsForPagination = jsonData.count;
								}
							var NumberOfPages = Math.ceil(totalRecordsForPagination/paginationCount);
							$j("#resultnavigation").html("");
							createPaginating(NumberOfPages);
							
							DoEnableDisabledPaging(NumberOfPages);	
							
							
							if(NumberOfPages == 1)
								{
									//$j("#resultnavigation").html("");
								}
							if(totalRecordsForPagination == 0)
								{									
									$j('.SearchStatus').html(S_Search_NoMatches);
								}
							 if(totalRecordsForPagination == 1)
								{
									$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Single_Match);	
								}	
							 if(totalRecordsForPagination > 1)
								{
									$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Multi_Matches);	
								}	
							  
							  makeTable(jsonData);
							  //alert(bClickable)
							  if(totalRecordsForPagination != 0 && bClickable )
								  {
									  $j("#"+tableId+" tr[id!='0']").hover(
										      function () {										          
										         // $j(this).css("background-color", "#EDF4DA");		
										          if(bClickable == true)
										        	  {
										        	  	$j(this).css("cursor","pointer");
										        	  }
										        }, 
										        function () {
										        
										         // $j(this).css("background-color", "");
										        }
											)
											.click(
												function(){
													if(bClickable == true)
														{
															executeClickEvent($j(this).attr("id"),jsonData);
														}
												}
											);
								  }
							 
							
						
					
				},
				error: function(msg)
				{					
					
					alert("An error has occurred while contacting the server");
					$j('.SearchStatus').css('color','red');
					$j('.SearchStatus').html(S_Search_Error);
					$j("#"+waitingImgId).hide();
					
				}
				
				
			});
}

function removeRow_FromDatabase(tableId,ObjectName,headerId,extraFunc)
{
	//alert(headerId);
	var valCheckBox = new Array();
	$j('[id="chk"]:checked').each(function(j)
			{
				
				valCheckBox[j] = $j(this).val();
			});
	//alert(valCheckBox);
	if(valCheckBox == "")
		{
			alert("Please select the rows that you want to delete.");
			return;
		}
	
	if(confirm("Are you sure you want to delete the details?"))
	{		
		DeleteFromDatabase_AddRemoveGrid(tableId,ObjectName,valCheckBox,headerId,extraFunc);	   
		
	}
	else
		{				
			return;
		}
	
	
} 

function DeleteFromDatabase_AddRemoveGrid(tableId,ObjectName,valCheckBox,headerId,extraFunc)
{	
	var data = "valCheckBox="+valCheckBox+"&ObjectName="+ObjectName+"&headerId="+headerId;
	
	//alert(data+tableId+headerId);
	
		
	$j("#imgRemoveDetails").show();
	
	
	$j.ajax({
		type:"GET",
		data: data,
		url:'stores?method=DeleteFromDatabase_AddRemoveGrid',		
		cache: false,
		success: function(msg)
		{			
			if(msg.indexOf("success~~") != -1)
				{					
					for(var i=0;i<valCheckBox.length;i++)
					{		   
					   
					   $j("#"+tableId+" tr[id='"+valCheckBox[i]+"']").remove();   	
						
					}
					
					eval(extraFunc);
				}
			else
				{
					alert("Not Delete");
				}
			$j("#imgRemoveDetails").hide();
					
		},
		error: function(msg)
		{		
			alert("Some error Occured. Please try again.")
			$j("#imgRemoveDetails").hide();
		}
			
		
	});
}



function removeRow_FromDatabaseRC(tableId,ObjectName,headerId)
{
	//alert(headerId);
	var valCheckBox = new Array();
	$j('[id="chk"]:checked').each(function(j)
			{
				
				valCheckBox[j] = $j(this).val();
			});
	//alert(valCheckBox);
	if(valCheckBox == "")
		{
			alert("Please select the rows that you want to delete.");
			return;
		}
	
	if(confirm("Are you sure you want to delete the details?"))
	{		
		DeleteFromDatabase_AddRemoveGridRC(tableId,ObjectName,valCheckBox,headerId);	   
		
	}
	else
		{				
			return;
		}
	
	
} 

function DeleteFromDatabase_AddRemoveGridRC(tableId,ObjectName,valCheckBox,headerId)
{	
	var data = "valCheckBox="+valCheckBox+"&ObjectName="+ObjectName+"&headerId="+headerId;
	
	
	
		
	$j("#imgRemoveDetails").show();
	
	
	$j.ajax({
		type:"GET",
		data: data,
		url:'stores?method=DeleteFromDatabase_AddRemoveGridRC',		
		cache: false,
		success: function(msg)
		{			
			if(msg.indexOf("success~~") != -1)
				{					
					for(var i=0;i<valCheckBox.length;i++)
					{		   
					   
					   $j("#"+tableId+" tr[id='"+valCheckBox[i]+"']").remove();   	
						
					}
					
//					eval(extraFunc);
				}
			else
				{
					alert("Not Delete");
				}
			$j("#imgRemoveDetails").hide();
					
		},
		error: function(msg)
		{		
			alert("Some error Occured. Please try again.")
			$j("#imgRemoveDetails").hide();
		}
			
		
	});
}

function checkDuplicateItemInGrid(data, itemId,itemName)
{
 
	var data = ""+data+""; 	
	var arry = new Array();
	arry = data.split(",");
	bDuplicate = false;
	
	var counter = 0;
	
	for(i=0;i<arry.length;i++)
		{	
			var tempValue = $j("#"+itemId+arry[i]).val();
			
		           for(var j=0;j<arry.length;j++)
		        	   {
		        	   if(i != j)
		        		   {		        		       
								if(tempValue == $j("#"+itemId+arry[j]).val())
								{
									if(itemName == undefined)
										{
											alert("You have inserted the duplicate entry.");
										}
									else
										{
											alert("You have inserted the duplicate "+itemName+" "+tempValue+".");
										}
									
									bDuplicate = "true";									
									return false;									
								}
		        		   }
		        	   }
			
		}
	return true;
	
}


function SendJsonData(url,data)
{	
	var successIcon = '<i class="fa fa-check-circle m-r-5"></i>';
	var errorIcon = '<i class="fa fa-times-circle m-r-5"></i>';
	

			$j.ajax({
				 crossOrigin: true,
				    method: "POST",
				    header:{
				    	'Access-Control-Allow-Origin': '*'
				    	},
				    	crossDomain:true,
				    url: url,
				    data: JSON.stringify(data),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result)
				    {
				    	
				    	
						$('#btnAddBloodGroup').prop("disabled", false);		
						$('#btnAddRange').prop("disabled",false);
						$('#btnAddDisposal').prop("disabled", false);
						$('#addIdealWeight').prop("disabled", false);						
						$('#btnAddAppointmentType').prop("disabled", false);						
						$('#btnAddPhysiotherapy').prop("disabled", false);
						$('#btnAddServiceType').prop("disabled",false);
						$('#btnAddStoreGroup').prop("disabled",false);						
						$('#btnAddStoreSection').prop("disabled",false);						
						$('#btnAdd').prop("disabled",false);
						$('#btnAddMedicalCategory').prop("disabled",false);
						$('#btnAddMEMB').prop("disabled",false);
						$('#btnAddMEInv').prop("disabled",false);
						$('#btnAddItemClass').prop("disabled",false);											
						$('#btnAddItem').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddVendor').prop("disabled",false);
						$('#btnAddSupplierType').prop("disabled",false);						
						$('#btnAddSubChargecode').prop("disabled",false);
						$('#btnAddBedStatus').prop("disabled",false);
						$('#btnAddDischargeStatus').prop("disabled",false);
						$('#btnAddDisease').prop("disabled",false);
						$('#btnAddDocument').prop("disabled",false);
						$('#btnAddAccountType').prop("disabled",false);
						$('#btnAddReligion').prop("disabled",false);
						$('#btnAddDiagnosis').prop("disabled",false);
						$('#btnAddMedicalExamSchedule').prop("disabled",false);
						$('#btnAddDiseaseType').prop("disabled",false);
						$('#btnAddDiseaseMapping').prop("disabled",false);
						$('#btnAddIdentificationType').prop("disabled",false);
						$j('#btnAddMMU').prop("disabled",false); 
						$j('#btnAddUserType').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddUom').prop("disabled",false);
						$('#btnAddSample').prop("disabled", false);
						$('#btnAddSample').prop("disabled",false);
						$('#btnAddMainChargecode').prop("disabled",false);	
						$('#btnAddEmpanelledHospital').prop("disabled", false);
						$('#btnAddItemUnit').prop("disabled", false);
						$('#btnAddItemType').prop("disabled",false);
						$('#btnAddItem').prop("disabled",false);
						$('#btnAddCity').prop("disabled",false);
						$j('#btnAddZone').prop("disabled",false);
						$j('#btnAddApplication').prop("disabled",false);
						$('#btnAddRole').prop("disabled", false);
						$j('#btnAdd').prop("disabled",false);
						$j('#btnAddWard').prop("disabled",false);
						$j('#btnAddDistrict').prop("disabled",false);
						$j('#btnAddInstructions').prop("disabled",false);
						$j('#btnAddSymtoms').prop("disabled",false);
						$('#btnAddDepartment').prop("disabled", false);
						$('#btnAddFrequency').prop("disabled", false);
						$('#btnAddLabour').prop("disabled", false);
						$('#btnDeptMapping').prop("disabled", false);
						$('#btnAddAdvice').prop("disabled", false);
						if($('#addPenaltyForm') && $('#addPenaltyForm').length > 0 && $('#addPenaltyForm')[0])
						    $('#addPenaltyForm')[0].reset();

						$('select, textarea').val('').prop('checked', false);
				    	if(result.status==1){
				    	//alert(result.msg);
				    		alert(result.msg+'S');
				    		showAll('ALL')		
				        	//document.getElementById("messageId").innerHTML = successIcon + result.msg;
				    		//$("#messageId").css("color", "#0abb87");
				    		//$("#messageId").css("background", "rgba(29, 201, 183, 0.1");
				    		/*$j("#messageId").slideDown(500);*/
				    		//$j("#messageId").animate({height: "34px"},500);
				    		/*setTimeout(function() {
								
				    			$j("#messageId").animate({height: "0px"},500);
					
						    },3000);*/
				        	
				        }
				        
				    	else if(result.status==0)
				    	{
				        	
				        	if(result.msg != undefined)
				        		{
					        		document.getElementById("messageId").innerHTML = errorIcon + result.msg;
					        		$("#messageId").css("color", "#de5e6a");
					        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
					        		/*$j("#messageId").slideDown(500);*/
					        		$j("#messageId").animate({height: "34px"},500);
					        		setTimeout(function() {
										
					        			$j("#messageId").animate({height: "0px"},500);
							
								    },3000);
						        	
				        		}
				        	if(result.err_mssg != undefined)
			        		{
				        		document.getElementById("messageId").innerHTML = errorIcon + result.err_mssg;
				        		$("#messageId").css("color", "#de5e6a");
				        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
				        		/*$j("#messageId").slideDown(500);*/
				        		$j("#messageId").animate({height: "34px"},500);
				        		setTimeout(function() {
									
				        			$j("#messageId").animate({height: "0px"},500);
						
							    },3000);
					        	
			        		}
				        	
				        }
				    	
				    	else
				    	{
				        	
				        	if(result.msg != undefined)
				        		{
					        		document.getElementById("messageId").innerHTML = errorIcon + result.msg;
					        		$("#messageId").css("color", "#de5e6a");
					        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
					        		/*$j("#messageId").slideDown(500);*/
					        		$j("#messageId").animate({height: "34px"},500);
					        		setTimeout(function() {
										
					        			$j("#messageId").animate({height: "0px"},500);
							
								    },3000);
						        	
				        		}
				        	if(result.err_mssg != undefined)
			        		{
				        		document.getElementById("messageId").innerHTML = errorIcon + result.err_mssg;
				        		$("#messageId").css("color", "#de5e6a");
				        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
				        		/*$j("#messageId").slideDown(500);*/
				        		$j("#messageId").animate({height: "34px"},500);
				        		setTimeout(function() {
									
				        			$j("#messageId").animate({height: "0px"},500);
						
							    },3000);
					        	
			        		}
				        	
				        }
				    },
					error: function(result)
					{	
						//$('#btnAddRole').prop("disabled", false);
						$('#btnAddDepartment').prop("disabled", false);
						$('#btnAddBloodGroup').prop("disabled", false);
						$('#btnAddSample').prop("disabled", false);
						$('#btnAddItemUnit').prop("disabled", false);
						$('#btnAddRange').prop("disabled",false);
						$('#btnAddDisposal').prop("disabled", false);
						$('#addIdealWeight').prop("disabled", false);
						$('#btnAddFrequency').prop("disabled", false);
						$('#btnAddAppointmentType').prop("disabled", false);
						$('#btnAddEmpanelledHospital').prop("disabled", false);
						$('#btnAddPhysiotherapy').prop("disabled", false);
						$('#btnAddServiceType').prop("disabled",false);
						$('#btnAddStoreGroup').prop("disabled",false);
						$('#btnAddItemType').prop("disabled",false);
						$('#btnAddStoreSection').prop("disabled",false);
						$('#btnAddItem').prop("disabled",false);
						$('#btnAdd').prop("disabled",false);
						$('#btnAddMedicalCategory').prop("disabled",false);
						$('#btnAddMEMB').prop("disabled",false);
						$('#btnAddMEInv').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddItemClass').prop("disabled",false);
						$('#btnAddSample').prop("disabled",false);
						$('#btnAddUom').prop("disabled",false);
						$('#btnAddItem').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddVendor').prop("disabled",false);
						$('#btnAddSupplierType').prop("disabled",false);
						$('#btnAddMainChargecode').prop("disabled",false);
						$('#btnAddSubChargecode').prop("disabled",false);
						$('#btnAddBedStatus').prop("disabled",false);
						$('#btnAddDischargeStatus').prop("disabled",false);
						$('#btnAddDisease').prop("disabled",false);
						$('#btnAddDocument').prop("disabled",false);
						$('#btnAddAccountType').prop("disabled",false);
						$('#btnAddReligion').prop("disabled",false);
						$('#btnAddDiagnosis').prop("disabled",false);
						$('#btnAddMedicalExamSchedule').prop("disabled",false);
						$j('#btnAddMMU').prop("disabled",false);
						$j('#btnAddUserType').prop("disabled",false); 
						$('#btnAddCity').prop("disabled",false);
						$j('#btnAddZone').prop("disabled",false);
						$j('#btnAddApplication').prop("disabled",false);
						$('#btnAddRole').prop("disabled", false);
						$j('#btnAdd').prop("disabled",false);
						$j('#btnAddWard').prop("disabled",false);
						$j('#btnAddDistrict').prop("disabled",false);
						$j('#btnAddInstructions').prop("disabled",false);
						$j('#btnAddSymtoms').prop("disabled",false);
						$('#btnAddLabour').prop("disabled", false);
						$('#btnDeptMapping').prop("disabled", false);
						$('#btnAddAdvice').prop("disabled", false);
						alert("An error has occurred while contacting the server"+ result);
						
						
					}
				
				
			});
			
}

function dateFormat(inputdate) {
	var daynmonth = inputdate.split("-");
	var formated_date = daynmonth[2] + '-' + daynmonth[1] + '-' + daynmonth[0];
	return formated_date;
}

function process(date){
	   var parts = date.split("/");
	   return new Date(parts[2], parts[1]-1, parts[0]);
}

function GetJsonDataForCommon(tableId,data,url,bClickable,waitingImgId,className,flagForCallingMethod,resultNavigation1)
{
	$j("#"+waitingImgId).show();
	$j('.'+className).css('color','green');
	$j('.'+className).html('<i class="fa fa-spinner fa-spin"></i> '+S_Search_Searching);
	
			$j.ajax({
				type:"POST",
				contentType : "application/json",
				url: url,
				data : JSON.stringify(data),
				dataType: "json",			
				cache: false,
				success: function(msg)
				{
					$j("#"+waitingImgId).hide();
					var jsonData = msg;		
					
					//alert(msg)
					
						
							var totalMatches = jsonData.count;
							//alert(jsonData.count);
							var totalRecordsForPagination = 0;
							
							//alert(totalRecordsForPagination);
							
							if(totalMatches>0)
								{
									totalRecordsForPagination = jsonData.count;
								}
							var NumberOfPages = Math.ceil(totalRecordsForPagination/paginationCount);
							$j("#"+resultNavigation1).html("");
							createPaginatingCommon(NumberOfPages,flagForCallingMethod,resultNavigation1);
						
							DoEnableDisabledPaging2(NumberOfPages,resultNavigation1);	
							
							
							if(NumberOfPages == 1)
								{
									//$j("#resultnavigation").html("");
								}
							if(totalRecordsForPagination == 0)
								{									
									$j('.'+className).html(S_Search_NoMatches);
								}
							 if(totalRecordsForPagination == 1)
								{
									$j('.'+className).html(totalRecordsForPagination + " " +S_Search_Single_Match);	
								}	
							 if(totalRecordsForPagination > 1)
								{
									$j('.'+className).html(totalRecordsForPagination + " " +S_Search_Multi_Matches);	
								}	
							  
							  makeTableCommon(jsonData,flagForCallingMethod);
							  if(totalRecordsForPagination != 0 && bClickable )
								  {
									  $j("#"+tableId+" tr[id!='0']").hover(
										      function () {										          
										          //$j(this).css("background-color", "#EDF4DA");		
										          if(bClickable == true)
										        	  {
										        	  	$j(this).css("cursor","pointer");
										        	  }
										        }, 
										        function () {
										        
										          $j(this).css("background-color", "");
										        }
											)
											.click(
												function(){
													if(bClickable == true)
														{
															executeClickEventCommon($j(this).attr("id"),jsonData);
														}
												}
											);
								  }
							 
							
						
					
				},
				error: function(msg)
				{					
					
					alert("An error has occurred while contacting the server");
					$j('.'+className).css('color','red');
					$j('.'+className).html(S_Search_Error);
					$j("#"+waitingImgId).hide();
					
				}
				
				
			});
}

function createPaginatingCommon(NumberOfPages,flagForCallingMethod,resultNavigation1)
{
	TotalNumberOfPages=NumberOfPages;
	nPageNo = 1 * nPageNo;
	var nextValue = nPageNo + 1;
	var PreValue = nPageNo - 1;
	goToFlag=flagForCallingMethod;
	/*if(NumberOfPages==1)
	{
	  
	  $j("#resultnavigation").append("Page <span id=\"current\">"+nPageNo+"</span> of <span id=\"total\">"+NumberOfPages+"</span>");
	   		 
	   
	}*/
	
	if(NumberOfPages>0)
		{
		  $j("#"+resultNavigation1).append("Go To Page <input class=\"form-control pageInput m-r-5\" type=\"text\" id=\"goToPageN2\" name=\"gotopageinput\"\" >");
		  $j("#"+resultNavigation1).append("<input class=\"btn btn-sm btn-primary noMinWidth goToBtn\" style=\"margin-top:-2px;\" type=\"button\"  value=\"Go\" name=\"gotopage\" onclick=\"goToSpecificPageN2()\" >");
		  $j("#"+resultNavigation1).append("<input class=\"previous\" type=\"button\"  value=\"f\" name=\"firstpage\" onclick=\"showResultPage('1',\'"+flagForCallingMethod+"\')\" >");
		  $j("#"+resultNavigation1).append("<input class=\"singlePrev\" type=\"button\"  value=\"f\" name=\"prevpage\"  onclick=\"showResultPage('"+PreValue+"',\'"+flagForCallingMethod+"\')\" >");
		  $j("#"+resultNavigation1).append("Page <span id=\"current\">"+nPageNo+"</span> of <span id=\"total\">"+NumberOfPages+"</span>");
		  $j("#"+resultNavigation1).append("<input class=\"singleNext\" type=\"button\"  value=\"f\" name=\"nextpage\"  onclick=\"showResultPage('"+nextValue+"',\'"+flagForCallingMethod+"\')\">");
		  $j("#"+resultNavigation1).append("<input class=\"next\" type=\"button\"  value=\"f\" name=\"lastpage\" onclick=\"showResultPage("+NumberOfPages+",\'"+flagForCallingMethod+"\')\">"); 		 
		   
		}
	
	
}

function goToSpecificPageN2(){
	var goToPageValN2 = document.getElementById('goToPageN2').value ;
	
	if( goToPageValN2 == '' || goToPageValN2 == 0 || goToPageValN2 > TotalNumberOfPages)
		{
			alert('Please specify a valid page no.');
		}
	else{
		showResultPage(goToPageValN2,goToFlag);
	}
}


function DoEnableDisabledPaging2(NumberOfPages,resultNavigation1)
{
	
	if(nPageNo == 1 && nPageNo >0 )
		{
			$j("#"+resultNavigation1+" .previous").addClass("previousDisable");
			$j("#"+resultNavigation1+" .singlePrev").addClass("singlePrevDisable");
			$j("#"+resultNavigation1+" .previous").attr("disabled","disabled");
			$j("#"+resultNavigation1+" .singlePrev").attr("disabled","disabled");
		}
	
	if(nPageNo == NumberOfPages)
	{		
		$j("#"+resultNavigation1+" .next").addClass("nextDisable");
		$j("#"+resultNavigation1+" .singleNext").addClass("singleNextDisable");
		$j("#"+resultNavigation1+" .next").attr("disabled","disabled");
		$j("#"+resultNavigation1+" .singleNext").attr("disabled","disabled");
	}
	
	if(NumberOfPages == 1)
	{
	$j("#"+resultNavigation1+" .goToBtn").attr("disabled","disabled");
	}
}


//dd/mm/yyyy
function currentDateInddmmyyyy(){
	var d2 = new Date().toISOString().slice(0,10); 
	var date = d2.split("-");
	return date[2]+"/"+date[1]+"/"+date[0];
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

// reset form
function resetForm() {
	$('input,select,textarea').not('[readonly],[disabled],[type="submit"],:button').val('');
	$('input[type="checkbox"]').not('[readonly],[disabled]').prop('checked',false);
}




/******lab history UHID wise****/

function GetJsonDataForUhid(tableId,data,url,bClickable,waitingImgId)
{
	$j("#"+waitingImgId).show();
	
	$j('.SearchStatus').css('color','green');
	$j('.SearchStatus').html('<i class="fa fa-spinner fa-spin"></i> '+S_Search_Searching);
	
			$j.ajax({
				type:"POST",
				contentType : "application/json",
				url: url,
				data : JSON.stringify(data),
				dataType: "json",			
				cache: false,
				success: function(msg)
				{
					$j("#"+waitingImgId).hide();
					var jsonData = msg;		
					
					//alert(msg)
					
						
							var totalMatches = jsonData.count;
							
							var totalRecordsForPagination = 0;
							
							//alert(totalRecordsForPagination);
							
							if(totalMatches>0)
								{
									totalRecordsForPagination = jsonData.count;
								}
							var NumberOfPages = Math.ceil(totalRecordsForPagination/paginationCount);
							$j("#resultnavigation").html("");
							createPaginatingForUhid(NumberOfPages);
							
							DoEnableDisabledPagingForUhid(NumberOfPages);	
							
							
							if(NumberOfPages == 1)
								{
									//$j("#resultnavigation").html("");
								}
							if(totalRecordsForPagination == 0)
								{									
									$j('.SearchStatus').html(S_Search_NoMatches);
								}
							 if(totalRecordsForPagination == 1)
								{
									$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Single_Match);	
								}	
							 if(totalRecordsForPagination > 1)
								{
									$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Multi_Matches);	
								}	
							  
							  makeTableForUhid(jsonData);
							  //alert(bClickable)
							  if(totalRecordsForPagination != 0 && bClickable )
								  {
									  $j("#"+tableId+" tr[id!='0']").hover(
										      function () {										          
										          //$j(this).css("background-color", "#EDF4DA");		
										          if(bClickable == true)
										        	  {
										        	  	$j(this).css("cursor","pointer");
										        	  }
										        }, 
										        function () {
										        
										          $j(this).css("background-color", "");
										        }
											)
											.click(
												function(){
													if(bClickable == true)
														{
															executeClickEvent($j(this).attr("id"),jsonData);
														}
												}
											);
								  }
							 
							
						
					
				},
				error: function(msg)
				{					
					
					alert("An error has occurred while contacting the server");
					$j('.SearchStatus').css('color','red');
					$j('.SearchStatus').html(S_Search_Error);
					$j("#"+waitingImgId).hide();
					
				}
				
				
			});
}

function createPaginatingForUhid(NumberOfPages)
{
	TotalNumberOfPages=NumberOfPages;
	nPageNo = 1 * nPageNo;
	var nextValue = nPageNo + 1;
	var PreValue = nPageNo - 1;
	
	if(NumberOfPages>0)
		{
		  $j("#resultnavigation").append("Go To Page <input class=\"form-control pageInput m-r-5\" type=\"text\" id=\"goToPage\" name=\"gotopageinput\"\" >");
		  $j("#resultnavigation").append("<input class=\"btn btn-sm btn-primary noMinWidth goToBtn\" style=\"margin-top:-2px;\" type=\"button\"  value=\"Go\" name=\"gotopage\" onclick=\"showResultPage(document.getElementById(\'goToPage\').value)\" >");
		  $j("#resultnavigation").append("<input class=\"previous\" type=\"button\"  value=\"f\" name=\"firstpage\" onclick=\"showResultPageForUhid('1')\" >");
		  $j("#resultnavigation").append("<input class=\"singlePrev\" type=\"button\"  value=\"f\" name=\"prevpage\"  onclick=\"showResultPageForUhid('"+PreValue+"')\" >");
		  $j("#resultnavigation").append("Page <span id=\"current\">"+nPageNo+"</span> of <span id=\"total\">"+NumberOfPages+"</span>");
		  $j("#resultnavigation").append("<input class=\"singleNext\" type=\"button\"  value=\"f\" name=\"nextpage\"  onclick=\"showResultPageForUhid('"+nextValue+"')\">");
		  $j("#resultnavigation").append("<input class=\"next\" type=\"button\"  value=\"f\" name=\"lastpage\" onclick=\"showResultPageForUhid("+NumberOfPages+")\">"); 		 
		   
		}
	
}

function DoEnableDisabledPagingForUhid(NumberOfPages)
{
	
	if(nPageNo == 1 && nPageNo >0 )
		{
			$j(".previous").addClass("previousDisable");
			$j(".singlePrev").addClass("singlePrevDisable");
			$j(".previous").attr("disabled","disabled");
			$j(".singlePrev").attr("disabled","disabled");
		}
	
	if(nPageNo == NumberOfPages)
	{		
		$j(".next").addClass("nextDisable");
		$j(".singleNext").addClass("singleNextDisable");
		$j(".next").attr("disabled","disabled");
		$j(".singleNext").attr("disabled","disabled");
	}
	if(NumberOfPages == 1)
	{
	$j(".goToBtn").attr("disabled","disabled");
	}
	
}

function getCurrentTimeInTwoDigitFormat(){
	var today = new Date();
	var hours = today.getHours();
	if(hours.length == 1){
		hours = '0'+ hours;
	}
	var mins = today.getMinutes();
	if(mins.length == 1){
		mins = '0'+mins;
	}			
	var time = hours + ":" + mins;
	return time;
}

function checkForFileCondition(str){ 
	 var specialChars = "<>@!#$%^&*()+[]{}?:;|'\"\\,/~`=";
	// var checkForSpecialChar = function(string){
	  for(i = 0; i < specialChars.length;i++){
	    if(str.indexOf(specialChars[i]) > -1){
	        return true
	     }
	  }
	  return false;
	 //}

	// var str = "YourText_.pdf";
	/* if(checkForSpecialChar(str)){
	   alert("Not Valid");
	 } else {
	     alert("Valid");
	 }*/
	}

function getFilenameAndReplcePath(fileNameValue){
	 var filenameWithExtension ="";
	 if(fileNameValue!="" && fileNameValue!=undefined && fileNameValue!=null){
	   filenameWithExtension = fileNameValue.replace(/^.*[\\\/]/, '');
	 }
	 return filenameWithExtension;
}

function SendMultipartData(url,formData,successCallback,$elementObj)
{
	var successIcon = '<i class="fa fa-check-circle m-r-5"></i>';
	var errorIcon = '<i class="fa fa-times-circle m-r-5"></i>';


			$j.ajax({
				    method: "POST",
				    header:{
				        'Access-Control-Allow-Origin': '*'
				    },
				    crossOrigin: true,
                    method: "POST",
                    crossDomain:true,
                    url: url,
                    data: formData,
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    dataType: "json",
				    success: function(result)
				    {
						$('#btnAddBloodGroup').prop("disabled", false);
						$('#btnAddRange').prop("disabled",false);
						$('#btnAddDisposal').prop("disabled", false);
						$('#addIdealWeight').prop("disabled", false);
						$('#btnAddAppointmentType').prop("disabled", false);
						$('#btnAddPhysiotherapy').prop("disabled", false);
						$('#btnAddServiceType').prop("disabled",false);
						$('#btnAddStoreGroup').prop("disabled",false);
						$('#btnAddStoreSection').prop("disabled",false);
						$('#btnAdd').prop("disabled",false);
						$('#btnAddMedicalCategory').prop("disabled",false);
						$('#btnAddMEMB').prop("disabled",false);
						$('#btnAddMEInv').prop("disabled",false);
						$('#btnAddItemClass').prop("disabled",false);
						$('#btnAddItem').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddVendor').prop("disabled",false);
						$('#btnAddSupplierType').prop("disabled",false);
						$('#btnAddSubChargecode').prop("disabled",false);
						$('#btnAddBedStatus').prop("disabled",false);
						$('#btnAddDischargeStatus').prop("disabled",false);
						$('#btnAddDisease').prop("disabled",false);
						$('#btnAddDocument').prop("disabled",false);
						$('#btnAddAccountType').prop("disabled",false);
						$('#btnAddReligion').prop("disabled",false);
						$('#btnAddDiagnosis').prop("disabled",false);
						$('#btnAddMedicalExamSchedule').prop("disabled",false);
						$('#btnAddDiseaseType').prop("disabled",false);
						$('#btnAddDiseaseMapping').prop("disabled",false);
						$('#btnAddIdentificationType').prop("disabled",false);
						$j('#btnAddMMU').prop("disabled",false);
						$j('#btnAddUserType').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddUom').prop("disabled",false);
						$('#btnAddSample').prop("disabled", false);
						$('#btnAddSample').prop("disabled",false);
						$('#btnAddMainChargecode').prop("disabled",false);
						$('#btnAddEmpanelledHospital').prop("disabled", false);
						$('#btnAddItemUnit').prop("disabled", false);
						$('#btnAddItemType').prop("disabled",false);
						$('#btnAddItem').prop("disabled",false);
						$('#btnAddCity').prop("disabled",false);
						$j('#btnAddZone').prop("disabled",false);
						$j('#btnAddApplication').prop("disabled",false);
						$('#btnAddRole').prop("disabled", false);
						$j('#btnAdd').prop("disabled",false);
						$j('#btnAddWard').prop("disabled",false);
						$j('#btnAddDistrict').prop("disabled",false);
						$j('#btnAddInstructions').prop("disabled",false);
						$j('#btnAddSymtoms').prop("disabled",false);
						$('#btnAddDepartment').prop("disabled", false);
						$('#btnAddFrequency').prop("disabled", false);
						$('#btnAddLabour').prop("disabled", false);
						$('#btnDeptMapping').prop("disabled", false);
				    	if(result.status==1){
				    		alert(result.msg+'S');
				    		//showAll('ALL')
				        	successCallback($elementObj);
				        }

				    	else if(result.status==0)
				    	{

				        	if(result.msg != undefined)
				        		{
					        		document.getElementById("messageId").innerHTML = errorIcon + result.msg;
					        		$("#messageId").css("color", "#de5e6a");
					        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
					        		/*$j("#messageId").slideDown(500);*/
					        		$j("#messageId").animate({height: "34px"},500);
					        		setTimeout(function() {

					        			$j("#messageId").animate({height: "0px"},500);

								    },3000);

				        		}
				        	if(result.err_mssg != undefined)
			        		{
				        		document.getElementById("messageId").innerHTML = errorIcon + result.err_mssg;
				        		$("#messageId").css("color", "#de5e6a");
				        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
				        		/*$j("#messageId").slideDown(500);*/
				        		$j("#messageId").animate({height: "34px"},500);
				        		setTimeout(function() {

				        			$j("#messageId").animate({height: "0px"},500);

							    },3000);

			        		}

				        }

				    	else
				    	{

				        	if(result.msg != undefined)
				        		{
					        		document.getElementById("messageId").innerHTML = errorIcon + result.msg;
					        		$("#messageId").css("color", "#de5e6a");
					        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
					        		/*$j("#messageId").slideDown(500);*/
					        		$j("#messageId").animate({height: "34px"},500);
					        		setTimeout(function() {

					        			$j("#messageId").animate({height: "0px"},500);

								    },3000);

				        		}
				        	if(result.err_mssg != undefined)
			        		{
				        		document.getElementById("messageId").innerHTML = errorIcon + result.err_mssg;
				        		$("#messageId").css("color", "#de5e6a");
				        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
				        		/*$j("#messageId").slideDown(500);*/
				        		$j("#messageId").animate({height: "34px"},500);
				        		setTimeout(function() {

				        			$j("#messageId").animate({height: "0px"},500);

							    },3000);

			        		}

				        }
				    },
					error: function(result)
					{
						//$('#btnAddRole').prop("disabled", false);
						$('#btnAddDepartment').prop("disabled", false);
						$('#btnAddBloodGroup').prop("disabled", false);
						$('#btnAddSample').prop("disabled", false);
						$('#btnAddItemUnit').prop("disabled", false);
						$('#btnAddRange').prop("disabled",false);
						$('#btnAddDisposal').prop("disabled", false);
						$('#addIdealWeight').prop("disabled", false);
						$('#btnAddFrequency').prop("disabled", false);
						$('#btnAddAppointmentType').prop("disabled", false);
						$('#btnAddEmpanelledHospital').prop("disabled", false);
						$('#btnAddPhysiotherapy').prop("disabled", false);
						$('#btnAddServiceType').prop("disabled",false);
						$('#btnAddStoreGroup').prop("disabled",false);
						$('#btnAddItemType').prop("disabled",false);
						$('#btnAddStoreSection').prop("disabled",false);
						$('#btnAddItem').prop("disabled",false);
						$('#btnAdd').prop("disabled",false);
						$('#btnAddMedicalCategory').prop("disabled",false);
						$('#btnAddMEMB').prop("disabled",false);
						$('#btnAddMEInv').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddItemClass').prop("disabled",false);
						$('#btnAddSample').prop("disabled",false);
						$('#btnAddUom').prop("disabled",false);
						$('#btnAddItem').prop("disabled",false);
						$('#btnAddInvestigation').prop("disabled",false);
						$('#btnAddVendor').prop("disabled",false);
						$('#btnAddSupplierType').prop("disabled",false);
						$('#btnAddMainChargecode').prop("disabled",false);
						$('#btnAddSubChargecode').prop("disabled",false);
						$('#btnAddBedStatus').prop("disabled",false);
						$('#btnAddDischargeStatus').prop("disabled",false);
						$('#btnAddDisease').prop("disabled",false);
						$('#btnAddDocument').prop("disabled",false);
						$('#btnAddAccountType').prop("disabled",false);
						$('#btnAddReligion').prop("disabled",false);
						$('#btnAddDiagnosis').prop("disabled",false);
						$('#btnAddMedicalExamSchedule').prop("disabled",false);
						$j('#btnAddMMU').prop("disabled",false);
						$j('#btnAddUserType').prop("disabled",false);
						$('#btnAddCity').prop("disabled",false);
						$j('#btnAddZone').prop("disabled",false);
						$j('#btnAddApplication').prop("disabled",false);
						$('#btnAddRole').prop("disabled", false);
						$j('#btnAdd').prop("disabled",false);
						$j('#btnAddWard').prop("disabled",false);
						$j('#btnAddDistrict').prop("disabled",false);
						$j('#btnAddInstructions').prop("disabled",false);
						$j('#btnAddSymtoms').prop("disabled",false);
						$('#btnAddLabour').prop("disabled", false);
						$('#btnDeptMapping').prop("disabled", false);
						alert("An error has occurred while contacting the server"+ result);


					}


			});

}
 

