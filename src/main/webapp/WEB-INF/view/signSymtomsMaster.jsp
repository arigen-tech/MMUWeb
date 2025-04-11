<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
  
<script type="text/javascript">

	var nPageNo=1;
	var $j = jQuery.noConflict();
	<% 
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	%>
	
	$j(document).ready(function()
			{
		$j("#btnActive").hide();
		$j("#btnInActive").hide();		
		$j('#updateBtn').hide();	  
		$j('#symptomsCode').attr('readonly', false);		
		GetAllSignSymtoms('ALL');			
			});
			
	function GetAllSignSymtoms(MODE){
		 
		var symptomsName=$("#searchSymptomsName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "symptomsName":""};			
			}else{
			var data = {"PN":nPageNo, "symptomsName":symptomsName};
			} 
		var url = "getAllSignSymtoms";		
		var bClickable = true;
		GetJsonData('tblListOfSignSymtoms',data,url,bClickable);	 
	}

	function makeTable(jsonData)
	{	
		var htmlTable = "";	
		var data = jsonData.count; 
		
		var pageSize = 5; 	
		var dataList = jsonData.data; 
		
		
		for(i=0;i<dataList.length;i++)
			{		
			
			 if(dataList[i].status == 'Y' || dataList[i].status == 'y')
					{
						var Status='Active'
					}
				else
					{
						var Status='Inactive'
					} 		
				
			 if(dataList[i].mfSymtoms == 'Y' || dataList[i].mfSymtoms == 'y')
				{
					var mfSymtoms='Yes'
				}
			 else
				{
					var mfSymtoms='No'
				} 
			 
				htmlTable = htmlTable+"<tr id='"+dataList[i].id+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].code+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].name+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+mfSymtoms+"</td>";				
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfSignSymtoms").html(htmlTable); 	
		
	}
    var Id;
	var id='';
	var code;
	var name;
	var mfSymtoms;
	var Status;
	
	function executeClickEvent(Id,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(Id == data.data[j].id){
				Id = data.data[j].id;			
				code = data.data[j].code;			
				name = data.data[j].name;
				mfSymtoms = data.data[j].mfSymtoms;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(Id,code,name,Status,mfSymtoms);
	}
	
	function rowClick(Id,code,name,Status,mfSymtoms){	
		id=Id;
		document.getElementById("symptomsCode").value = code;
		document.getElementById("symptomsName").value = name;
		
		if(mfSymtoms == 'Y' || mfSymtoms == 'y'){
			jQuery("#mostFrequentSymptoms").prop('checked', true);
		
		}
		else{
			jQuery("#mostFrequentSymptoms").prop('checked', false);
		}
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddSymtoms').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddSymtoms').hide();
		}
		
		
		$j('#symptomsCode').attr('readonly', true);
		
	}


		function addSignSymtoms(){
			var mfSymtoms=$j('#mostFrequentSymptoms').is(':checked') ? 'y' :'n';
			
			if(document.getElementById('symptomsCode').value == null || document.getElementById('symptomsCode').value == ""){
				alert("Please Enter Symptoms Code");
				return false;
			}
			if(document.getElementById('symptomsName').value == null || document.getElementById('symptomsName').value ==""){
				alert("Please Enter Symptoms Name");
				return false;
			}
			$j('#btnAddSymtoms').prop("disabled",true);
			var params = {		
					
					 'code':jQuery('#symptomsCode').val(),
					 'name':jQuery('#symptomsName').val(),
					 'status' : Status,
					 'userId': <%= userId%>,
					 'mfSymtoms' : mfSymtoms
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addSignSymtoms";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateSignSymtoms(){	
			var mfSymtoms=$j('#mostFrequentSymptoms').is(':checked') ? 'y' :'n';
			if(document.getElementById('symptomsCode').value == null || document.getElementById('symptomsCode').value == ""){
				alert("Please Enter Symptoms Code");
				return false;
			}
			if(document.getElementById('symptomsName').value == null || document.getElementById('symptomsName').value ==""){
				alert("Please Enter Symptoms Name");
				return false;
			}
			$j('#btnAddSymtoms').prop("disabled",true);
			var params = {		
					 'id':id,
					 'code':jQuery('#symptomsCode').val(),
					 'name':jQuery('#symptomsName').val(),
					 'status' : Status,
					 'userId': <%= userId%>,
					 'mfSymtoms' : mfSymtoms
			 }
			//alert(JSON.stringify(params));
				    var url = "updateSignSymtoms";
				    SendJsonData(url,params);
					
					Reset();
		}
		
		function updateSignSymtomsStatus(){
			
			
			var params = {
					
					'id':id,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateSignSymtomsStatus";
			        SendJsonData(url,params);
			 
			        Reset(); 
		}
		
		function Reset(){
			
			document.getElementById('searchSymptomsName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddSymtoms').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#symptomsCode').attr('readonly', false);
			$j("#mostFrequentSymptoms").prop('checked', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#symptomsCode').val('');
			$j('#symptomsName').val('');
			$j('#searchSymptomsName').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllSignSymtoms('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddSymtoms').show();
			$j('#symptomsCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllSignSymtoms('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchSymptomsName').value == ""){
		  		alert("Please Enter Symptoms Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllSignSymtoms('FILTER');
		 }
		 
		 function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateBankMasterReport";
			 openPdfModel(url)
		 	
		 }
 
</script> 
</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">
 
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Sign and Symptoms Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchSymptomsForm"
												name="searchSymptomsForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Symptoms Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchSymptomsName" id="searchSymptomsName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Symptoms Name" onkeypress="return validateText('searchSymptomsName',300,'Symptoms Name')">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary "
																onclick="search()">Search</button>
														</div>
													</div>
												</div>
											</form>

										</div>
										<div class="col-md-4">
											<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												<!-- <button type="button" class="btn  btn-primary "
												id="printReportButton" 
													onclick="generateReport()">Reports</button> -->
											</div>
										</div>
									</div>
                                    
		
			<div style="float:left">
               
                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
                                    <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
                                   <td>            
           
                         </td>
           </tr>
         </table>
                                  </div>  
                                     <div style="float:right">
                                       <div id="resultnavigation">
                                       </div> 
                                     </div> 

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th2" class ="inner_md_htext">Symptoms Code</th>
                                                <th id="th3" class ="inner_md_htext">Symptoms Name</th>
                                                <th id="th4" class ="inner_md_htext">Most Frequent Symptoms</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfSignSymtoms">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSymptomsForm" name="addSymptomsForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Symptoms Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="symptomsCode" name="symptomsCode" placeholder="Symptoms Code" onkeypress=" return validateText('symptomsCode',7,'Symptoms Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Symptoms Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="symptomsName" name="symptomsName" placeholder="Symptoms Name" onkeypress="return validateText('symptomsName',300,'Symptoms Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                               <div class="col-md-4">   
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="mostFrequentSymptoms" id="mostFrequentSymptoms" value="n"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="Most Frequent Symptoms">Most Frequent Symptoms</label>
														</div>
                                                    </div>     
                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
																											
							            </div>
                                                    
                                                </div>
                                            </form>
                                        </div>

                                    </div>
									
         							<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddSymtoms"
															class="btn  btn-primary " onclick="addSignSymtoms();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateSignSymtoms();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateSignSymtomsStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateSignSymtomsStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
											</div>
										</div>
									</div>	
                                    

                                    <!-- end row -->

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->
                    <!-- end row -->

                </div>
                <!-- container -->

            </div>
            <!-- content -->

        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

