<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Medical Unit- MMSSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
     <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
  
<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
			 $j('#selectUnit').attr('readonly', false);
			 $j('#searchServiceNo').attr('readonly', false);
			 GetEmployeeList('ALL');
			 GetUnitList();
			
		});

		
function GetEmployeeList(MODE)
{
	var unitId = jQuery('#selectUnit').find('option:selected').val();
	var serviceNo = jQuery('#searchServiceNo').val();
	var employeeId=0;
	if(MODE == 'ALL'){
		var data = {"PN":nPageNo,"serviceNo":"","unitId":""};			
	}
else
	{
	var data = {"PN":nPageNo, "serviceNo":serviceNo,"unitId":unitId};
	} 
	var url = "getAllEmployee";
		
	var bClickable = false;
	GetJsonData('tblListOfEmployee',data,url,bClickable);
}
function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count;
	
	
	var pageSize = 5;
	
	var dataList = jsonData.data;
	
	for(i=0;i<dataList.length;i++)
		{		
		
			htmlTable = htmlTable+"<trid='"+dataList[i].employeeId+"' >";	
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].employeeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].unitName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rankName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].adId+"</td>";
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfEmployee").html(htmlTable);	
	
	
}

var comboArray = [];
function GetUnitList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllUnitList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].unitName;
	    		combo += '<option value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);	
	    	}
	    	jQuery('#selectUnit').append(combo);
	    }
	    
	});
}



function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetEmployeeList('FILTER');	
}

/* function Reset(){
	document.getElementById("employeeForm").reset();
	document.getElementById('selectUnit').value = "";
	document.getElementById('searchServiceNo').value = "";
	showAll();
} */



function ResetForm()
{	
	$j('#searchServiceNo').val('');
	$j('#selectUnit').val('');
}

function showAll()
{
	$j('#selectUnit').val('');
	$j('#searchServiceNo').val('');
	ResetForm();
	nPageNo = 1;	
	GetEmployeeList('ALL');
	
}

function search()
{
	if(document.getElementById('searchServiceNo').value == "" && document.getElementById('selectUnit').value == ""){
		alert("Please Enter Service No OR Select the Unit Name");
 		return false;
 	}
	nPageNo=1;
	GetEmployeeList('FILTER');
}
function generateReport()
{
	document.employeeForm.action="${pageContext.request.contextPath}/report/generateEmployeeMasterReport";
	document.employeeForm.method="POST";
	document.employeeForm.submit(); 
	
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
                <div class="internal_Htext">Employee Master</div>
                    
                    <!-- end row -->
                   
                  <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       <form class="form-horizontal" id="employeeForm" name="employeeForm" method="" role="form">  
                                    <div class="row">
                                        <div class="col-md-4">
	                                        <div class="form-group row">
	                                        	<label class="col-5 col-form-label">Service No<span class="mandate"><sup>&#9733;</sup></span></label>
														<div class="col-md-7">
	
															<input type="text" name="searchServiceNo" id="searchServiceNo"
																class="form-control" id="inlineFormInputGroup"
																placeholder="Service No" onkeypress="return validateText('searchServiceNo',17,'Service No');">
	
														</div>
											</div>
                                        </div>  
                                        
                                        <div class="col-md-4">
	                                        <div class="form-group row">
	                                        	<label class="col-md-5 col-form-label">Unit<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-md-7">                                                       
                                                     <select class="form-control" id="selectUnit" onchange="">
                                                     </select>
                                                    </div>
	                                        </div>
                                        </div>                              
                                        <div class="col-md-1">
											<div class="form-group row">
													<button type="button" class="btn  btn-primary obesityWait-search"
														onclick="search();">Search</button>
												
											</div>
										</div>
						
                                        <div class="col-md-3 text-right">
                                                                                  
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>
                                                    <!-- <button type="button" class="btn  btn-primary " onclick="generateReport()">Reports</button> -->
                                         
                                          
                                        </div>
                                        
                                        

                                    </div>
                                  </form>
					
					                  <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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
                                                <th id="th2" class ="inner_md_htext">First Name</th>
                                                <th id="th3" class ="inner_md_htext">Service No</th>
                                                <th id="th4" class ="inner_md_htext">Unit Name</th>
                                                <th id="th4" class ="inner_md_htext">Rank Name</th>
                                                <th id="th4" class ="inner_md_htext">AD ID</th>
                                            </tr>
                                        </thead>
                                     <tbody id="tblListOfEmployee">
										 
                     				 </tbody>
                                    </table>
                                    
									 
         							<br>
									<!-- <div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
											
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>

											</div>
										</div>
									</div> -->

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