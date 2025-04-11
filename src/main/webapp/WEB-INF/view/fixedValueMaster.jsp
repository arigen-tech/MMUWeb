<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%--  <%@include file="..//view/leftMenu.jsp" %> --%>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sub Investigation</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
<style>

#wrapper{
display:none;
}
.footer{
left:0px;
}
</style>
</head>
<script type="text/javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();
var t=0;
var subInvData=${subInvId};
var subinvestId;

var fixedValueData=${fixedValueData};

<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
%>
$j(document).ready(function()
		{	
	
	 		
			makeTable();
			subinvestId=subInvData.subInvId;
			
			
		});
		
var j;
function makeTable()
{	
	var htmlTable = "";		
	
	var dataList = fixedValueData.data;
	
	 for(i=0;i<dataList.length;i++)
		{		
	     j=i+1;
		
			htmlTable = htmlTable+'<tr><td><input type="text" class="form-control width80 selector" id="fixedValue'+j+'" onblur="validateFixedValue(this.value, this);" value="'+dataList[i].fixedValueName+'" /></td>';		 	
		 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button></td>';
		 	htmlTable = htmlTable+ '<td><button type="button" class="btn btn-danger noMinWidth" button-type="delete" value="'+dataList[i].fixedId+'" onclick="deleteRow(this)"></button></td>';
		 	htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="'+dataList[i].fixedId+'" /></td> </tr>';
			
			
			
		} 
	 if(dataList.length == 0)
		{ 
		t=t+1;
		htmlTable = htmlTable+'<tr><td><input type="text" class="form-control width80 selector" onblur="validateFixedValue(this.value, this);" id="fixedValue'+t+'" /></td>';		
	 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button>	</td>';
	 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-danger noMinWidth" button-type="delete" onclick="deleteRow(this)"></button></td>';
	 	htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="" /></td> </tr>';   
		}			
	
	$j("#fixedValueId").append(htmlTable);	
	
	
}


function updateFixedValueDetails()
{	
	
		
	var fvlist =[];
	var data='';
	var flag=true;
	$j('#fixedValueId tr').each(function(i, el) {
	
		var $tds = $j(this).find('td'); 
		var fixedValue = $tds.eq(0).find(":input").val();
		var fixedValueId = $tds.eq(3).find(":input").val() !='' ? $tds.eq(3).find(":input").val() :'' ;
		
	     if(fixedValue ==''){
	    	 alert("Please Enter Fixed Value");
	    	 flag=false;
	    	 return flag;
	     }
	   
	     
	data = {
			 'fixedValueId':fixedValueId,
			 'fixedValue':fixedValue,
			 'userId':<%=userId %>,			 
			 'subInvId':subinvestId
			}; 
	
	
	fvlist.push(data);
	
	});
	
	
	if(flag){  
	var param = {
			"fixedValuelist" : fvlist
		};	
	//alert(JSON.stringify(param));
	
	
	 jQuery.ajax({
		crossOrigin : true,
		method : "POST",
		crossDomain : true,
		url : "updateFixedValue",
		data : JSON.stringify(param),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			if (result.status == 1) {
				
				alert(result.msg);
				window.location = "fixedValueMaster?subInvId="+subinvestId+"&cmpType="+f;

			} else if (result.status == 0) {
				alert(result.msg);
			}

		}

	});
		 		
	}
	
	
  }

			function validateFixedValue(value, item){	
				
								
				var param={"fixedValue":value,"subInvId":subinvestId};
				
				$j(item).closest('tr').find("td:eq(0)").find(":input").attr('id');
				var itemCurrentId= $j(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
				var itemCurrentIdVal= $j(item).closest('tr').find("td:eq(0)").find("input:eq(0)").val();
				$j('#fixedValueId tr').each(function(j1, el) {
					var gridId = $j(this).find("td:eq(0)").find("input:eq(0)").attr("id");
					var gridIdVal = $j(this).find("td:eq(0)").find("input:eq(0)").val();
					
					if(gridId!=itemCurrentId){
						if(gridIdVal !=''){
						if(itemCurrentIdVal==gridIdVal){
							$j('#'+itemCurrentId).val("");
							alert("Fixed value already exist");
							return false;
						}
					}
					}
					
					
				});
				
				//alert(JSON.stringify(param));
				jQuery.ajax({
					crossOrigin : true,
					method : "POST",
					crossDomain : true,
					url : "validateFixedValue",
					data : JSON.stringify(param),
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(result) {
						if (result.status == 1) {
							alert(result.msg);							
							$j(item).closest('tr').find("td:eq(0)").find(":input").val('');
							
						} 
			
					}
			
				});
				
				
			}
  
  


function generateReport()
{
	document.searchMCCForm.action="${pageContext.request.contextPath}/report/generateRankMasterReport";
	document.searchMCCForm.method="POST";
	document.searchMCCForm.submit(); 
	
}



  function addRow(){
	  t=t+1;
	  
	  
	  var html= '';
		html += '<tr>';		
		html += '<td><input type="text" class="form-control width80 selector" onblur="validateFixedValue(this.value, this);" id="fixedValue'+t+'" /></td>';			 	
		html += '<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button></td>';
		html += '<td><button type="button" class="btn btn-danger noMinWidth" button-type="delete" onclick="deleteRow(this)"></button></td>';		
	    html += '<td style="display: none;"><input type="hidden" value="" /></td></tr>';	    
		$j("#fixedValueId").append(html);
		
  }
  
     function deleteRow(val){			 
    	 var value=val.value;	
	if (confirm("Do you want to delete the record ?")){
		
		if(value==''){
	   if($j('#fixedValueId tr').length > 1) {
		   $j(val).closest('tr').remove();
		  
		 }
		}
	   else if(value!=''){
			var param={fixedValueId: value};
				
			jQuery.ajax({
       	 	crossOrigin: true,
       	    method: "POST",			    
       	    crossDomain:true,
       	    url: "deleteFixedValueById",
       	    data: JSON.stringify(param),
       	    contentType: "application/json; charset=utf-8",
       	    dataType: "json",
       	    success: function(result){
       	    	if(result.status==1){
       	    		alert(result.msg);       	    	
       	    		window.location.reload();
       	    	}
       	    	else if(result.status==0){
       	    		alert(result.msg);
       	    	}
       	    	
       	    }
       	    
       	});
		}
	   
		}
	}
	
     function backToSubInvestigation(){
    	 window.location = "subInvestigationMaster?investigationId="+subInvData.investigationId+
			"&investigationName="+subInvData.investigationName+"&deparmentId="+subInvData.deparmentId
			+"&departmentName="+subInvData.departmentName+"&modalityId="
			+subInvData.modalityId+"&modalityName="+subInvData.modalityName;
    	 
     }
  
  
</script>


<body>

    <!-- Begin page -->
    <div id="">
    
        <div class="">
            <!-- Start content -->
            <div class="m-t-10">
                <div class="container-fluid">
                <div class="internal_Htext">Fixed Value</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                   
                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                             <tr>
                                               
                                                <th id="th1">Fixed Value</th>                                                
                                                <th>Add</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                       
                                     <!-- <tbody id="tblListOfsubInvestigation"> -->
                                     <tbody id="fixedValueId">
										 
                     				 </tbody>
                                    </table>

									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddorUpdate"
															class="btn  btn-primary " onclick="updateFixedValueDetails()">Submit</button>
														<button type="button"
															class="btn  btn-primary" onclick="backToSubInvestigation()">Back</button>
														
													
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