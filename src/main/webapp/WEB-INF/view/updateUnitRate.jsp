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
  </head>
  <%
  
  String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	
  String cityId = "0";
	if (session.getAttribute("cityIdUsers") != null) {
		cityId = session.getAttribute("cityIdUsers").toString();
		cityId = cityId.replace(",","");
	}
	
  String districtId = "0";
	if (session.getAttribute("distIdUsers") != null) {
		districtId = session.getAttribute("distIdUsers").toString();
		districtId = districtId.replace(",","");
	}
  
  %>
<script type="text/javascript" language="javascript">


var $j = jQuery.noConflict();
var nPageNo=1;
$j(document).ready(function()
		{	
	
		getDrugList();
			
		});
		
function getDrugList()
{
	$j("#loadingDiv").show();
	var data = {"mmuId":"<%= mmuId %>", "cityId":"<%= cityId %>", "districtId":"<%= districtId %>"};
	var bClickable = false;
 	var url = "getDrugList";
 	GetJsonData('drugListTable',data,url,bClickable);
}

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var dataList = jsonData.list;
	
	for(i=0;i<dataList.length;i++)
		{ 		
			var j=i+1;
			htmlTable = htmlTable+"<tr id='"+dataList[i].id+"' >";	
			htmlTable = htmlTable +"<td style='width: 400px;'>"+dataList[i].drugName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].au+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].batchNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].expiryDate+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].availableStock+"</td>";
			
			var unitRate = parseFloat(dataList[i].previousUnitRate);
			htmlTable = htmlTable +"<td style='width: 100px;'>"+unitRate.toFixed(2)+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'><input type='text' class='form-control width80' value='' onkeypress='if(isNaN(this.value + String.fromCharCode(event.keyCode))) return false;'/></td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
		if(dataList.length == 0)
		{
			htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>"; 		   
		}			
		$j("#loadingDiv").hide();
	$j("#drugListTable").html(htmlTable);	
	
}

function updateUnitRate(item){
	var list = [];
	var flag = true;
	$('#drugListTable tr').each(function(i, el) {
		var $tds = $(this).find('td')
		var stockId = $($tds).closest('tr').attr("id");
		var unitRate = 	$($tds).closest('tr').find("td:eq(6)").find(":input").val();
		
		if(unitRate != ''){
			flag = false;
			var input ={
					"stockId":stockId,
					"unitRate":unitRate
			}
			list.push(input);
		}
		
	});
	
	if(flag){
		alert("Please enter unit rate atleast for one drug");
		return;
	}
	
	var params = {
			"list":list
	}
	console.log(JSON.stringify(list));				

	$j(item).attr("disabled", true);
	$j.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "updateUnitRate",
	    data: JSON.stringify(params),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(jsonData){
	    	var msg = jsonData.msg;
	    	if(msg == 'Unit Rate updated successfully'){
	    		alert(jsonData.msg+'S');
				document.addEventListener('click',function(e){
					    if(e.target && e.target.id== 'closeBtn'){
	   	   				 	window.location.reload();
					     }
				 });
	    	}else{
	    		alert(jsonData.msg);
	    	}
	    		
	    	$j(item).attr("disabled", false);
	    }
	    
	});
	
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
                <div class="internal_Htext">Update Unit Rate</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="font-weight: bold;" ></p>                     
                                    
                                  	<!-- New Table -->
                                  
                                  	<div class="table-responsive m-t-10">
                                  	<span id="loadingDiv">
													<img class="m-r-10 " src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
												</span>
                                  	<table class="table table-hover table-bordered table-striped">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Drug Name</th> 
                                                <th>A/U</th> 
                                                <th>Batch</th> 
                                                <th>Expiry Date</th> 
                                                <th>Available Stock</th>
                                                <th>Previous Unit Rate</th> 
                                                <th>Updated Unit Rate</th> 
                                            </tr>
                                        </thead>
                                     <tbody id="drugListTable">
										 
                     				 </tbody>
                                    </table> 
                                    </div>
                                    <!-- New Table -->
                                    
                                    
									<br>	
                                    <!-- end row -->
									<div class="row">
		                                	<div class="col-12 m-t-10 text-right">
		                               			<input type="button" class="btn btn-primary" id="btnSubmit" value="Submit" onclick="updateUnitRate(this)"  />
		                               			
		                               		</div>
	                               	</div>
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