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
    
<%@include file="..//view/commonJavaScript.jsp" %>
  
<script type="text/javascript" language="javascript">


var $j = jQuery.noConflict();
var nPageNo = 1;
$j(document).ready(function()
		{	
			getImportList();
		});
		
function getImportList()
{
	var data = {"pageNo": nPageNo}
	var bClickable = false;
 	var url = "getImportSyncTableList";
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
				htmlTable = htmlTable +"<td style='width: 100px;'>"+ dataList[i].downloadCount +"</td>";
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
			
			/* htmlTable = htmlTable +'<td style="width: 100px;"><a href="javascript:Void(0);" onclick="importData(this);" class="btn btn-primary"><i class="fa fa-file-alt"></i> Import </a></td>'; 
			htmlTable = htmlTable +'<td><a href="javascript:Void(0);" onclick="downloadLog(this);" class="btn btn-primary"><i class="fa fa-file-code"></i> Log</a></td>'; */
			//importFileName
			htmlTable = htmlTable +"<td style='display:none'>"+dataList[i].importFileName+"</td>";
			htmlTable = htmlTable+"</tr>";
			
		}
		if(dataList.length == 0)
		{
			htmlTable = htmlTable+"<tr ><td colspan='11'><h6>No Record Found</h6></td></tr>"; 		   
		}			
	
	$j("#exportList").html(htmlTable);	
	
}

function uploadDocument(){
	        
		if (document.getElementById('fileUploadId').value == ""){
			alert('Please select a file to Upload');
			return;
			}
			
			var file = $j('#fileUploadId').val();
			var params = {
					"uploadFile":file
			}
			$j("#loadingDiv").show();
			var form = $j('#fileUploadForm')[0]; 
	        var data = new FormData(form);
	        $j('#btnUpload').attr("disabled", true);
		    
	        $j.ajax({
	            type: 'POST',
	            enctype: 'multipart/form-data',
	            url: 'uploadZipFile',
	            data: data,
	            processData: false,
	            contentType: false,
	            cache: false,
	            timeout: 600000,
	            success: function (data) {
	               getImportList();
	               alert(data);
	               $("#loadingDiv").hide();
	               $j('#btnUpload').attr("disabled", false);
	            },
	            error: function (e) {
	                $j("#result").text(e.responseText);
	                console.log("ERROR : ", e);
	                $j('#btnUpload').attr("disabled", false);
	            }
	        });		
		
}

function importData(item){
	$("#loadingDiv").show();
	$j('#btnImport').attr("disabled", true);
	
	var fileName = $j(item).closest('tr').find("td:eq(10)").text();
	var params = {
			"fileName":fileName
	}
 	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'importCSV',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(msg) {
			getImportList();
			alert(msg.msg);
			$("#loadingDiv").hide();
			$j('#btnImport').attr("disabled", false);
		},

		error : function(msg) {

			alert("An error has occurred while contacting the server");
			$j('#btnImport').attr("disabled", false);
		}
	});
}

function downloadLog(item){
	var fileName = $j(item).closest('tr').find("td:eq(10)").text();
	var fName = fileName.split(".")[0]+".log";
	window.location = "downloadImportLog?fileName="+fName+"";	
}
function showResultPage(pageNo)
{ 	
	nPageNo = pageNo;	
	getImportList();
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
                <div class="internal_Htext">Import to Ship</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                    <input type="hidden" name="importToShip" id="importToShip" value="importToShip"/>
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="font-weight: bold;" ></p>                     
                                    

                                   

					<!-- <table class="table table-striped table-hover jambo_table"> -->
					
					
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
                                            </tr>
                                        </thead>
                                     <tbody id="exportList">
										 
                     				 </tbody>
                                    </table> 
                                    </div>         
                                  	
                                    <div class="row">
                                        <div class="col-md-12">
                                        	
	                                         <form method="post" name="fileUploadForm" id="fileUploadForm">
	                                         <div class="row">
	                                              <div class="col-md-1 offset-md-6">
	                                              <span id="loadingDiv">
														<img class="m-r-10 " src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
													</span>
	                                               </div>
	                                               <div class="col-md-3">    
	                                                   <div class="fileUploadDiv">
														  	<input type="file" name="uploadFile" class="file inputUpload m-r-10" id="fileUploadId">
														  	<label class="inputUploadlabel">Choose File</label>
															<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
													  	</div>
	   														  	         
	                                              <!-- <input type="file" name="uploadFile" class="file m-r-10" id="fileUploadId">   -->                                               
	                                         	  </div>
	                                         	  
	                                         	  <div class="col-md-2 text-right">
	                                              <button type="button" id="btnUpload" class="btn btn-primary  " onclick="uploadDocument();">Upload/Import</button>                                                   
	                                          		</div>
	                                             <!--  <button type="button" id="btnImport" class="btn btn-primary" onclick="importData()">Import</button> -->                                                   
											  </div>
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