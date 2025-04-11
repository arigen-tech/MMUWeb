<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
     <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
    
<%@include file="..//view/commonJavaScript.jsp" %>
  
<script type="text/javascript" language="javascript">


var $j = jQuery.noConflict();
var nPageNo=1;
$j(document).ready(function()
		{	
	
		GetExportSyncTableList();
		//getHospitalList();
			
		});
		
function GetExportSyncTableList()
{
	var data = {"pageNo":nPageNo}
	var bClickable = false;
 	var url = "getExportSyncTableList";
 	GetJsonData('exportList',data,url,bClickable);
}

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var cmdId=0;
	var data = jsonData.count;
	
	var dataList = jsonData.data;
	
	for(i=0;i<dataList.length;i++)
		{ 		
			var j=i+1;
			htmlTable = htmlTable+"<tr id='"+dataList[i].syncId+"' >";	
			htmlTable = htmlTable +"<td style='display:none'></td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].exportDate+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].exportFileName+"</td>";
			if(dataList[i].downloadStatus == ''){
				htmlTable = htmlTable +"<td style='width: 100px;'>No</td>";
			}else if(dataList[i].downloadStatus == 'Y'){
				htmlTable = htmlTable +"<td style='width: 100px;'>Yes</td>";
			}
			if(dataList[i].downloadCount == ''){
				htmlTable = htmlTable +"<td style='width: 100px;'>0</td>";	
			}else{
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].downloadCount+"</td>";
			}
			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].importDate+"</td>";
			
			if(dataList[i].importStatus == ''){
				htmlTable = htmlTable +"<td style='width: 100px;'>No</td>";
			}else if(dataList[i].importStatus == 'Y'){
				htmlTable = htmlTable +"<td style='width: 100px;'>Yes</td>";
			}
			if(dataList[i].uploadStatus == ''){
				htmlTable = htmlTable +"<td style='width: 100px;'>0</td>";
			}else{
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].uploadStatus+"</td>";
			}
			
			htmlTable = htmlTable +'<td><a href="javascript:Void(0);" onclick="downloadZip(this);" class="btn btn-primary"><i class="fa fa-file-alt"></i> Zip </a></td>'; 
			htmlTable = htmlTable +'<td><a href="javascript:Void(0);" onclick="downloadLog(this);" class="btn btn-primary"><i class="fa fa-file-code"></i> Log</a></td>';  
			htmlTable = htmlTable+"</tr>";
			
		}
		if(dataList.length == 0)
		{
			htmlTable = htmlTable+"<tr ><td colspan='11'><h6>No Record Found</h6></td></tr>"; 		   
		}			
	
	$j("#exportList").html(htmlTable);	
	
}

function genrateCSV(){
	/* var id = $j('#hospitalId').val();
	if(id == ''){
		alert("Please select Hospital Name");
		return;
	}
	var params = {
			"id":id
	} */
	$j("#loadingDiv").show();
	$j('#btnExport').attr("disabled", true);
	$j.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "genrateCSV",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(jsonData){
	    	GetExportSyncTableList();
	    	var msg = jsonData.msg;
	    	alert(msg);
	    	$j("#loadingDiv").hide();
	    	$j('#btnExport').attr("disabled", false);
	    }
	    
	});
	
}

/* function getHospitalList(){
	$j.ajax({
	    method: "POST",			    
	    crossDomain:true,
	    url: "getHospitalList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(jsonData){
	    	var list = jsonData.list;
	    	var hospitalHTML = '';
	    	for(var i=0;i<list.length;i++){
	    		var unitCode = list[i].unitCode;
	    		var hIdAndUId = list[i].hospitalId+'@'+list[i].unitId+'@'+unitCode;
	    		
	    		hospitalHTML += '<option value='+hIdAndUId+'>'+list[i].hospitalName+'</option>';
	    	}
	    	$j('#hospitalId').append(hospitalHTML);
	    }
	    
	});
} */

function downloadZipFileFromServer(){
	window.location = "downloadDataInZip";
}

function downloadZip(item){
	var doneTypingInterval = 1500;  //time in ms, 5 second for example
	var fileName = $j(item).closest('tr').find("td:eq(2)").text();
	window.location = "downloadZip?fileName="+fileName+"";
	setTimeout(GetExportSyncTableList, doneTypingInterval);
}

function downloadLog(item){
	var fileName = $j(item).closest('tr').find("td:eq(2)").text();
	var fName = fileName.split(".")[0]+".log";
	window.location = "downloadZip?fileName="+fName+"";	
}
function showResultPage(pageNo)
{ 	
	nPageNo = pageNo;	
	GetExportSyncTableList();
}
</script>
</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">

        

        <!-- ========== Left Sidebar Start ========== -->
        
        <!-- Left Sidebar End -->

        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Export from Ship</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="font-weight: bold;" ></p>                     
                                    

                                   

					<!-- <table class="table table-striped table-hover jambo_table"> -->
					
									<div class="row">
										
										<!-- <div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Hospital</label>
														</div>
														<div class="col-sm-7">
															<select class="form-control" id="hospitalId" >
															<option value="">Select</option>
															</select>
													</div>
												</div>
										</div> -->
										
										<div class="col-12 text-right">
											<span id="loadingDiv">
													<img class="m-r-10 " src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
												</span>
											<button type="button" class="btn btn-primary" id="btnExport" onclick="genrateCSV();">Export</button>
										</div>
									</div>
									
					                  <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
												
												<td>
												 <!-- <div id=resultnavigation></div> -->
												
												</td>
												</tr>
										</table>
		                                 </div>     
		                                    <div style="float:right">
				                                    <div id="resultnavigation">
				                                    </div> 
		                                    </div> 
		                                    
        
                                  	
                                  	
                                  	<!-- New Table -->
                                  	<div class="table-responsive m-t-10">
                                  	<table class="table table-hover table-bordered table-striped">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Export Date</th> 
                                                <th>Export Filename</th> 
                                                <th>Download Status</th> 
                                                <th>Download Count</th> 
                                                <th>Import Date</th> 
                                                <th>Import Status</th> 
                                                <th>Upload Count</th> 
                                                <th>Download File</th> 
                                                <th>Download Log</th>                                                
                                            </tr>
                                        </thead>
                                     <tbody id="exportList">
										 
                     				 </tbody>
                                    </table> 
                                    </div>
                                    <!-- New Table -->
                                    
                                    
									<br>	
                                    <div class="row">
                                       
                                        <div class="col-md-12 text-right">
                                            <form>
                                            
                                                
                                                  <!--   <button type="button" id="btnExport" class="btn btn-primary  " onclick="genrateCSV();">Export</button>                                                   
                                                
                                                    <button type="button" id="btnDownload" class="btn btn-primary" onclick="downloadZipFileFromServer()">Download</button>    -->                                                

                                                
                                            </form>
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