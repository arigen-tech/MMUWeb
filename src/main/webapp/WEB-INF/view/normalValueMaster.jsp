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

//var subInvData=${subInvId};
var subinvestId=${subInvId};
var subInvData=${subInvData};
var normalValueData=${normalValueData};


<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
%>
$j(document).ready(function()
		{	
	
	 		
			makeTable();			
			
			
		});
		

function makeTable()
{	
	var htmlTable = "";		
	
	 var dataList = normalValueData.data;
	
	 for(i=0;i<dataList.length;i++)
		{		
		 var data = ${sexData};;			
		 var sexList=data.data;
		 
		 htmlTable = htmlTable+'<tr>'; 
		 htmlTable = htmlTable+'<td><select class="form-control width150" id="sexid">';
			htmlTable = htmlTable+'	<option value="">Select</option>';
		    $j.each(sexList, function(ij, item) {
		    	
		    	if(item.administrativeSexId==1){
		    		if(dataList[i].sexId=='m'){
					htmlTable = htmlTable+'<option   value="m" selected>' + item.administrativeSexName+'</option>';
		    		}
		    		else{
		    			htmlTable = htmlTable+'<option   value="m">' + item.administrativeSexName+'</option>';
		    		}
					}
					if(item.administrativeSexId==2){
						if(dataList[i].sexId=='f'){
						htmlTable = htmlTable+'<option   value="f" selected>' + item.administrativeSexName+'</option>';
						}
						else{
							htmlTable = htmlTable+'<option   value="f">' + item.administrativeSexName+'</option>';	
						}
					}
		       });
		    htmlTable = htmlTable+'</select></td>';
			htmlTable = htmlTable+'<td><input type="text" class="form-control width80" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" id="fromAge" value="'+dataList[i].fromAge+'" /></td>';
			htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="toAge" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" value="'+dataList[i].toAge+'" /></td>';
			htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="minNormalValue" value="'+dataList[i].minNormalValue+'" /></td>';
			htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="maxNormalValue" value="'+dataList[i].maxNormalValue+'" /></td>';
			htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="normalValue" value="'+dataList[i].normalValue+'" /></td>';					 	
		 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button></td>';
		 	htmlTable = htmlTable+'<td></td><td style="display: none;"><input type="hidden" value="'+dataList[i].normalValueId+'" /></td> </tr>';
			
			
			
		}  
	 if(dataList.length == 0)
		{ 
		 var data = ${sexData};;			
		 var sexList=data.data;
		 
		 htmlTable = htmlTable+'<tr>'; 
		 htmlTable = htmlTable+'<td><select class="form-control width150" id="sexid">';
			htmlTable = htmlTable+'	<option value="">Select</option>';
		    $j.each(sexList, function(ij, item) {
				if(item.administrativeSexId==1){
				htmlTable = htmlTable+'<option   value="m">' + item.administrativeSexName+'</option>';
				}
				if(item.administrativeSexId==2){
					htmlTable = htmlTable+'<option   value="f">' + item.administrativeSexName+'</option>';
					}
		       });
		htmlTable = htmlTable+'</select></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="fromAge" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="toAge" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="minNormalValue" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="maxNormalValue" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="normalValue" value="" /></td>';
	 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button>	</td>';
	 	htmlTable = htmlTable+'<td></td>';
	 	htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="" /></td> </tr>';   
			}			
	
	$j("#normalValueId").append(htmlTable);	
	
	
}



function updateNormalValueDetails()
{	
	
	var nvlist =[];
	var data='';
	var flag=true;
	$j('#normalValueId tr').each(function(i, el) {
	
		var $tds = $j(this).find('td');
		var sexId = $tds.eq(0).find(":input").val();
		var fromAge = $tds.eq(1).find(":input").val();
		var toAge = $tds.eq(2).find(":input").val();
		var minNormalValue = $tds.eq(3).find(":input").val();
		var maxNormalValue = $tds.eq(4).find(":input").val();
		var normalValue = $tds.eq(5).find(":input").val();
		var normalValueId = $tds.eq(8).find(":input").val() !='' ? $tds.eq(8).find(":input").val() :'' ;
		
		
		if(sexId ==''){
	    	 alert("Please select Gender");
	    	 flag=false;
	    	 return flag;
	     }
		else if(fromAge ==''){
	    	 alert("Please Enter From Age");
	    	 flag=false;
	    	 return flag;
	     }
	    
		else if(toAge ==''){
	    	 alert("Please Enter To Age");
	    	 flag=false;
	    	 return flag;
	     }
		else if( parseInt(toAge) <  parseInt(fromAge)){
   			alert("To age should not be earlier than From age");
   			flag=false;
	    	return flag;
   	      }
		else if(minNormalValue ==''){
	    	 alert("Please Enter Min Normal value");
	    	 flag=false;
	    	 return flag;
	     }
		else if(maxNormalValue ==''){
	    	 alert("Please Enter Max Normal value");
	    	 flag=false;
	    	 return flag;
	     }
		else if(parseInt(maxNormalValue) < parseInt(minNormalValue)){
   			alert("Max normal value should not be lesser than Min normal value");
   			flag=false;
	    	return flag;
   	      }		
		else if(normalValue ==''){
	    	 alert("Please Enter Normal value");
	    	 flag=false;
	    	 return flag;
	     }
		
			     
	data = {
			 'sexId':sexId,
			 'fromAge':fromAge,
			 'toAge':toAge,
			 'minNormalValue':minNormalValue,
			 'maxNormalValue':maxNormalValue,			 
			 'normalValue':normalValue,
			 'normalValueId':normalValueId,
			 'userId':<%=userId %>,			 
			 'subInvId':subinvestId
			}; 
	
	//alert(JSON.stringify(data));
	nvlist.push(data);
	
	});
	
	if(flag){  
	var param = {
			"normalValuelist" : nvlist
		};	
	//alert(JSON.stringify(param));
	//console.log(JSON.stringify(param));
	
	 jQuery.ajax({
		crossOrigin : true,
		method : "POST",
		crossDomain : true,
		url : "updateNormalValue",
		data : JSON.stringify(param),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			if (result.status == 1) {
				
				alert(result.msg);
				window.location = "normalValueMaster?subInvId="+subinvestId+"&cmpType="+v;

			} else if (result.status == 0) {
				alert(result.msg);
			}

		}

	});
		 		
	}
	
	
}




function generateReport()
{
	document.searchMCCForm.action="${pageContext.request.contextPath}/report/generateRankMasterReport";
	document.searchMCCForm.method="POST";
	document.searchMCCForm.submit(); 
	
}


function bacTolabkInvestigtion(){
	
	window.close();
}
var t=0;
  function addRow(){
	  
	  var htmlTable = "";
	  var data = ${sexData};;			
	  var sexList=data.data;
	  
	  htmlTable = htmlTable+'<tr>'; 
		 htmlTable = htmlTable+'<td><select class="form-control width150" id="sexid">';
			htmlTable = htmlTable+'	<option value="">Select</option>';
		    $j.each(sexList, function(ij, item) {
				
		    	if(item.administrativeSexId==1){
					htmlTable = htmlTable+'<option   value="m">' + item.administrativeSexName+'</option>';
					}
					if(item.administrativeSexId==2){
						htmlTable = htmlTable+'<option   value="f">' + item.administrativeSexName+'</option>';
						}
				
		       });
		htmlTable = htmlTable+'</select></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="fromAge" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="toAge" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="minNormalValue" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="maxNormalValue" value="" /></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control width80" id="normalValue" value="" /></td>';		 	
		htmlTable = htmlTable+'<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button></td>';
		htmlTable = htmlTable+'<td><button type="button" class="btn btn-danger noMinWidth" button-type="delete" onclick="deleteRow(this)"></button></td>';		
		htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="" /></td></tr>';	    
		$j("#normalValueId").append(htmlTable);
		
  }
  
     function deleteRow(val){			 
		
	if (confirm("Do you want to delete the record ?")){
		
	   if($j('#normalValueId tr').length > 1) {
		   $j(val).closest('tr').remove();
		  
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
                <div class="internal_Htext">Normal Value</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                   
                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                             <tr>
                                              
                                                <th id="th1">Gender</th> 
                                                <th id="th2">From Age</th>
                                                <th id="th3">To Age</th>
                                                <th id="th4">Min Normal Value</th>
                                                <th id="th5">Max Normal Value</th>
                                                <th id="th6">Normal Value</th>                                                                                               
                                                <th>Add</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                       
                                     <!-- <tbody id="tblListOfsubInvestigation"> -->
                                     <tbody id="normalValueId">
										 
                     				 </tbody>
                                    </table>

									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddorUpdate"
															class="btn  btn-primary " onclick="updateNormalValueDetails()">Submit</button>
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