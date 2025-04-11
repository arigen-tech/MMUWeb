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
   
<%@include file="..//view/leftMenu.jsp"%>
     <%@include file="..//view/commonJavaScript.jsp"%>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
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
var x;
var $j = jQuery.noConflict();
var subinvestId;

var subInvData=${subInvData};

var investigationData=${invData};
<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
%>

var func1='';
var url1='';
var url2='';
var flaga='';


func1='populateChargeCode';
url1='opd';
url2='getIinvestigationList';
flaga='investigation';

$j(document).ready(function()
		{	
	
	 		$j("#investigationName").val(investigationData.investigationName);
			$j("#modalityname").val(investigationData.modalityName);
			$j("#departmentname").val(investigationData.departmentName);
			makeTable(subInvData);
			
			
		});
		

var charge_code_array = [];
var ChargeCode='';
var multipleChargeCode = new Array();
var investigationForUom = "";
function populateChargeCode(val,count,item) {
	
	//alert(count);
//	if(validateMetaCharacters(val)){
		if(val != "")
		{
			multipleChargeCode=val.split("[");			
		    var index1 = val.lastIndexOf("[");
		    var indexForChargeCode=index1;		 
		    var index2 = val.lastIndexOf("]");
		    index1++;
		    ChargeCode = val.substring(index1,index2);		    
		    var indexForChargeCode=indexForChargeCode--;
		  
       
		if(ChargeCode == "")
		{
		
		return;
		}
		else{
			        			
			//document.getElementById('chargeCodeCode').value=ChargeCode
			var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
			var checkCurrentRow=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
		         var count=0;   			
		        $('#subinvestigationId tr').each(function(i, el) {
			    var $tds = $(this).find('td')
			        var chargeCodeId=  $($tds).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
			        var idddd =$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
			        var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
			    	  if(chargeCodeId!=checkCurrentRowIddd && ChargeCode==chargeCodeIdValue)
			          {
			    		  	if(ChargeCode==chargeCodeIdValue){
			       			alert("Investigation is already added");
			        		$('#'+idddd).val("");
			        		$('#'+currentidddd).val("");
			        		$('#'+chargeCodeIdValue).val("");
			        		return false;
			           }
			          			        
			            }
			            else
			        	{
			               $(item).closest('tr').find("td:eq(1)").find(":input").val("");
			        	   $(item).closest('tr').find("td:eq(2)").find(":input").val(multipleChargeCode[0]);
			        	   $(item).closest('tr').find("td:eq(10)").find(":input").val(ChargeCode);
			        	}
			       
			    }); 
		      }
		}
	  }


function makeTable(subInvData)
{	
	var htmlTable = "";		
	
	var dataList = subInvData.data;
	
	for(i=0;i<dataList.length;i++)
		{		
	      x=i+1;
			
			var data = ${data};			
			var uomList=data.data;
			htmlTable = htmlTable+'<tr><td><input type="text" class="form-control width80" id="printOrder" maxlength="10" value="'+dataList[i].printOrder +'" onkeypress="return isNumberKey(this, event);" /></td>';		
			htmlTable =htmlTable+'<td><div class="form-group autocomplete forTableResp">';
			htmlTable = htmlTable+'<input type="text" autocomplete="never" value=""';			
			htmlTable = htmlTable+' class="form-control border-input" name="investigationName" id=""  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
			htmlTable = htmlTable+'<div id="investigationDivMe" class="autocomplete-itemsNew"></div></div></td>';
			htmlTable = htmlTable+'<td><input type="text" class="form-control" id="subtestname" value="'+dataList[i].subtestName +'" /></td>';		
			htmlTable = htmlTable+'<td><input type="text" class="form-control" id="loincCode" maxlength="20" value="'+dataList[i].loincCode +'" /></td>';
			htmlTable = htmlTable+'<td><select class="form-control width150" id="uomlistid">';
			htmlTable = htmlTable+'	<option value="">Select</option>';		 			
			$j.each(uomList, function(ij, item) {
				if(item.UOMId==dataList[i].uomId) {
				htmlTable = htmlTable+'<option   value="'+item.UOMId +'" selected>' + item.UOMName+'</option>';
				}
				else{
					htmlTable = htmlTable+'<option   value="'+item.UOMId +'" >' + item.UOMName+'</option>';
				}
		       });		
				
		 	htmlTable = htmlTable+'</select></td>';
		 	htmlTable = htmlTable+'<td><select class="form-control" id="resulttype">';
		 	
		 	htmlTable = htmlTable+'<option value="">Select</option>';
		 	if(dataList[i].resultType=='h'){
		 		htmlTable = htmlTable+'<option value="h" selected >Heading</option>';
		 	}
		 	
		 	else{
		 		htmlTable = htmlTable+'<option value="h">Heading</option>';
		 	}
		 	if(dataList[i].resultType=='s'){
		 	htmlTable = htmlTable+'	<option value="s" selected>Single Parameter</option>';
		 	}
		 	else{
		 		htmlTable = htmlTable+'	<option value="s">Single Parameter</option>';
		 	}
		 	if(dataList[i].resultType=='m'){
		 		htmlTable = htmlTable+'<option value="m" selected >Text Area</option>';
		 	}
		 	else{
		 		htmlTable = htmlTable+'<option value="m" >Text Area</option>';
		 	}
		 	if(dataList[i].resultType=='t'){
		 		htmlTable = htmlTable+'<option value="t" selected>Text</option>';
		 	}
		 	else{
		 		htmlTable = htmlTable+'<option value="t">Text</option>';
		 	}
		 	if(dataList[i].resultType=='r'){
		 	htmlTable = htmlTable+'<option value="r" selected >Range</option></select></td>';
		 	}
		 	else{
		 		htmlTable = htmlTable+'<option value="r">Range</option></select></td>';	
		 	}
		 	htmlTable = htmlTable+'<td class="width200"><select class="form-control width120" id="cmptype'+x+'" onchange="changeComparisonType(this.value,this);">';		 	
		 	htmlTable = htmlTable+'<option value="">Select</option>';
		 	if(dataList[i].cmpType=='n'){
		 		htmlTable = htmlTable+'<option value="n" selected >None</option>';
		 	}
		 	else{
		 		htmlTable = htmlTable+'<option value="n">None</option>';
		 		
		 	}
		 	if(dataList[i].cmpType=='f'){
		 	htmlTable = htmlTable+'<option value="f" selected >Fixed Values</option>';
		 	}
		 	else{
		 		htmlTable = htmlTable+'<option value="f">Fixed Values</option>';	
		 	}
		 	if(dataList[i].cmpType=='v'){
		 	htmlTable = htmlTable+'<option value="v" selected >Normal Value</option>	</select>';
		 	}
		 	else{
		 		htmlTable = htmlTable+'<option value="v">Normal Value</option>	</select> ';
		 	}
		 	if(dataList[i].cmpType=='n'){
		 	htmlTable = htmlTable+'<button id="goBtn'+x+'" style="display: none;" type="button"  type="button" class="btn btn-primary noMinWidth m-l-5"  onclick="showCreate(this.value,this);" value="'+dataList[i].subInvId+'" >Go</button></td>';
		 	}
		 	else {
		 		htmlTable = htmlTable+'<button id="goBtn'+x+'" type="button"  type="button" class="btn btn-primary noMinWidth m-l-5"  onclick="showCreate(this.value,this);" value="'+dataList[i].subInvId+'" >Go</button></td>';	
		 	}
		 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button>	</td>';
		 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-danger noMinWidth" button-type="delete" value="'+dataList[i].subInvId+'" onclick="deleteRow(this)"></button>	</td>';
		 	htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="'+dataList[i].subInvId+'" /></td>';
		 	htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="" /></td></tr>';
			
			
		}
	
	if(dataList.length == 0)
		{
		var data = ${data};			
		var uomList=data.data;
		htmlTable = htmlTable+'<tr><td><input type="text" class="form-control width80" id="printOrder" maxlength="10" onkeypress="return isNumberKey(this, event);" /></td>';		
		htmlTable =htmlTable+'<td><div class="form-group autocomplete forTableResp">';
		htmlTable = htmlTable+'<input type="text" autocomplete="never" value=""';			
		htmlTable = htmlTable+' class="form-control border-input" name="investigationName" id=""  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
		htmlTable = htmlTable+'<div id="investigationDivMe" class="autocomplete-itemsNew"></div></div></td>';
		htmlTable = htmlTable+'<td><input type="text" class="form-control" id="subtestname" /></td>';	
		htmlTable = htmlTable+'<td><input type="text" class="form-control" id="loincCode" maxlength="20" /></td>';	
		htmlTable = htmlTable+'<td><select class="form-control width150" id="uomlistid">';
		htmlTable = htmlTable+'	<option value="">Select</option>';		 			
		$j.each(uomList, function(ij, item) {
			 
			htmlTable = htmlTable+'<option   value="'+item.UOMId +'">' + item.UOMName+'</option>';
		 		
	       });		
			
	 	htmlTable = htmlTable+'</select></td>';
	 	htmlTable = htmlTable+'<td><select class="form-control" id="resulttype">';
	 	htmlTable = htmlTable+'<option value="">Select</option>';
	 	htmlTable = htmlTable+'	<option value="h">Heading</option>';
	 	htmlTable = htmlTable+'	<option value="s">Single Parameter</option>';
	 	htmlTable = htmlTable+'<option value="m">Text Area</option>';
	 	htmlTable = htmlTable+'<option value="t">Text</option>';
	 	htmlTable = htmlTable+'<option value="r">Range</option></select></td>';
	 	htmlTable = htmlTable+'<td><select class="form-control" id="cmptype">';
	 	htmlTable = htmlTable+'<option value="">Select</option>';										 			
	 	htmlTable = htmlTable+'<option value="n">None</option>';
	 	htmlTable = htmlTable+'<option value="f">Fixed Values</option>';
	 	htmlTable = htmlTable+'<option value="v">Normal Value</option>	</select></td>';
	 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button>	</td>';
	 	htmlTable = htmlTable+'<td><button type="button" class="btn btn-danger noMinWidth" button-type="delete" onclick="deleteRow(this)"></button>	</td>';
	 	htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="" /></td>';
	 	htmlTable = htmlTable+'<td style="display: none;"><input type="hidden" value="" /></td></tr>';   
		}			
	
	$j("#subinvestigationId").append(htmlTable);	
	
	
   }

			var popup;
			function showCreate(value,item) {
				var invdata ={"investigationId":investigationData.investigationId,"investigationName":investigationData.investigationName,
			               "deparmentId":investigationData.deparmentId,"departmentName":investigationData.departmentName,
						   "modalityId":investigationData.modalityId,"modalityName":investigationData.modalityName
						   }
				
				var cmpValue =$j(item).closest('tr').find("td:eq(6)").find("select:eq(0)").val();
				var data="";				
				 data={"subInvId":value,"cmpType":cmpValue,"investigationId":investigationData.investigationId,
						 "investigationName":investigationData.investigationName,
			               "deparmentId":investigationData.deparmentId,"departmentName":investigationData.departmentName,
						   "modalityId":investigationData.modalityId,"modalityName":investigationData.modalityName};
				 				
			      if(cmpValue=='f'){
					popup = window.open("fixedValueMaster?"+ decodeURIComponent($j.param(data)), "popUpWindow", "height=300,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
			       	popup.focus();
			      }
			      if(cmpValue=='v'){
			    	  popup = window.open("normalValueMaster?"+ decodeURIComponent($j.param(data)), "popUpWindow", "height=300,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
			          popup.focus();
			      }
			        
				
			  }


				function isNumberKey(txt, evt) {
					
				    var charCode = (evt.which) ? evt.which : evt.keyCode;
				    if (charCode == 46) {
				        //Check if the text already contains the . character
				        if (txt.value.indexOf('.') === -1) {
				            return true;
				        } else {
				            return false;
				        }
				    } else {
				        if (charCode > 31
				             && (charCode < 48 || charCode > 57))
				            return false;
				    }
				    return true;
				}
				
				function changeResultType(value){
					if(value=='m' || value=='t'){
						$("#resultBtn").show();
					}
					else{
						$("#resultBtn").hide();
					}
					
				}

function updateSubInvestigationDetails()
{	
	var subInvlist =[];
	var dataSub='';
	var flag=true;
	$j('#subinvestigationId tr').each(function(i, el) {
	
		var $tds = $j(this).find('td'); 
		var printOrder = $tds.eq(0).find(":input").val();		
		var subtestName = $tds.eq(2).find(":input").val();
		var loincCode = $tds.eq(3).find(":input").val();
		var uomId = $tds.eq(4).find(":input").val();
		var resultType = $tds.eq(5).find(":input").val();
		var cmpTypeId = $tds.eq(6).find(":input").val();
		var subInvId = $tds.eq(9).find(":input").val();	
		var mainInvestigationId = $tds.eq(10).find(":input").val();
		
	     if(printOrder ==''){
	    	 alert("Please Enter Print order");
	    	 flag=false;
	    	 return flag;
	     }
	     else if(subtestName ==''){
	    	 alert("Please Enter Sub Test name"); 
	    	 flag=false;
	    	 return flag;
	     }
	     /* else if(subtestCode ==''){
	    	 alert("Please Enter Sub Test Code"); 
	    	 flag=false;
	    	 return flag;
	     } */
	     else if(uomId ==''){
	    	 alert("Please Select unit");
	    	 flag=false;
	    	 return flag;
	     }
	     else if(resultType ==''){
	    	 alert("Please Select Result Type");
	    	 flag=false;
	    	 return flag;
	     }
	     else if(cmpTypeId ==''){
	    	 alert("Please Select Comparison Type");
	    	 flag=false;
	    	 return flag;
	     }
	     
	     
	dataSub = {
			'investigationId':investigationData.investigationId,
			 'userId':<%=userId %>,			 
			 'departmentId':investigationData.deparmentId,
			 'modalityId':investigationData.modalityId,
			 'printOrder':printOrder,
			 'subtestName':subtestName,
			 'loincCode':loincCode,
			 'uomId':uomId,
			 'cmpTypeId':cmpTypeId,
			 'resultType':resultType,
			 'subInvId':subInvId,
			 'mainInvestigationId' :mainInvestigationId
			 
	 } 	
	subInvlist.push(dataSub);
	
	});
	
	if(flag){  
	var param = {
			"subInvlist" : subInvlist
		};	
	//alert(JSON.stringify(param));
	
	
	 jQuery.ajax({
		crossOrigin : true,
		method : "POST",
		crossDomain : true,
		url : "updateSubInvestigation",
		data : JSON.stringify(param),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			if (result.status == 1) {
				
				alert(result.msg);
				
				document.addEventListener('click',function(e){
			         if(e.target && e.target.id== 'closeBtn'){
			        	 window.location = "subInvestigationMaster?investigationId="+investigationData.investigationId+
							"&investigationName="+investigationData.investigationName+"&deparmentId="+investigationData.deparmentId
							+"&departmentName="+investigationData.departmentName+"&modalityId="
							+investigationData.modalityId+"&modalityName="+investigationData.modalityName;
			          }
			      });
				
			} else if (result.status == 0) {
				alert(result.msg);
			}
			
			else if (result.status == 2) {
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
	  
	  var data = ${data};			
	  var uomList=data.data;
	  t=t+1;
	  
	  var html= '';
		html += '<tr>';		
		html += '<td><input type="text" class="form-control width80" id="printOrder" maxlength="8" onkeypress="return isNumberKey(this, event);" /></td>';
		html =html+'<td><div class="form-group autocomplete forTableResp">';
		html = html+'<input type="text" autocomplete="never" value=""';			
		html = html+' class="form-control border-input" name="investigationName" id="'+t+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
		html = html+'<div id="investigationDivMe" class="autocomplete-itemsNew"></div></div></td>';

		html += '<td><input type="text" class="form-control" id="subtestname" /> </td>';		
		html += '<td><input type="text" class="form-control" id="loincCode" maxlength="20" /></td>';
		html += '<td><select class="form-control width150" id="uomlistid"><option value="">Select</option>';		
		$j.each(uomList, function(ij, item) {
			 
				 html += '<option   value="'+item.UOMId +'">' + item.UOMName+'</option>';
			 
			
		});
	
		html += '</select></td>';
		
		html += '<td><select class="form-control" id="resulttype" >';
		html += '<option value="">Select</option>';
		html += '<option value="h">Heading</option>';
		html += '<option value="s">Single Parameter</option>';
		html += '<option value="m">Text Area</option>';
		html += '<option value="t">Text</option>';
		html += '<option value="r">Range</option>';	 			
		html += '</select></td>';	 	
		html += '<td><select class="form-control width120" id="cmptype" ><option value="">Select</option>';										 			
		html += '<option value="n">None</option>';
		html += '<option value="f">Fixed Values</option>';
		html += '<option value="v">Normal Value</option></select></td>';	 	
		html += '<td><button type="button" class="btn btn-primary noMinWidth" button-type="add" onclick="addRow()"></button></td>';
		html += '<td><button type="button" class="btn btn-danger noMinWidth" button-type="delete" onclick="deleteRow(this)"></button>	</td>';		
	    html += '<td style="display: none;"><input type="hidden" value="" /></td>';
	    html += '<td style="display: none;"><input type="hidden" value="" /></td></tr>'	    
		$j("#subinvestigationId").append(html);
		
  }
  
     function deleteRow(val){	
         var value=val.value;		 
		
	if (confirm("Do you want to delete the record ?")){
		
		if(value==''){
	   if($j('#subinvestigationId tr').length > 1) {
		   $j(val).closest('tr').remove();
		  
		 }
		}
		
		else if(value!=''){
			var param={subInvId: val.value};
				
			jQuery.ajax({
        	 	crossOrigin: true,
        	    method: "POST",			    
        	    crossDomain:true,
        	    url: "deleteSunbInvestigationById",
        	    data: JSON.stringify(param),
        	    contentType: "application/json; charset=utf-8",
        	    dataType: "json",
        	    success: function(result){
        	    	if(result.status==1){
        	    		alert(result.msg);
        	    		window.location = "subInvestigationMaster?investigationId="+investigationData.investigationId+
						"&investigationName="+investigationData.investigationName+"&deparmentId="+investigationData.deparmentId
						+"&departmentName="+investigationData.departmentName+"&modalityId="
						+investigationData.modalityId+"&modalityName="+investigationData.modalityName;
        	    	}
        	    	else if(result.status==0){
        	    		alert(result.msg);
        	    	}
        	    	
        	    }
        	    
        	});
		}
		
	}		
		
	}
	
     function changeComparisonType(value,item){	
    	 
    	 if(value=='n' || value ==''){
    		 $j(item).closest('tr').find("td:eq(6)").find("button:eq(0)").hide();
  			}
  			else{
  				$j(item).closest('tr').find("td:eq(6)").find("button:eq(0)").show();
  			}	
      
		}
     
     
  
</script>

<script type="text/javascript">
var labRadioValue=resourceJSON.mainchargeCodeLab;
var imagRadioValue=resourceJSON.mainchargeCodeRadio;
</script>
<script type="text/javascript">
$j(document).ready(function(){
	$j('#lab_radio').val(labRadioValue);
	$j('#imag_radio').val(imagRadioValue);

	$j('#labImaginId').val(labRadioValue);
});

</script>
<body>

    <!-- Begin page -->
    <div id="">
    
        <div class="">
            <!-- Start content -->
            <div class="m-t-10">
                <div class="container-fluid">
                <div class="internal_Htext">Sub Investigation Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                            <input  name="userId" id="labImaginId" type="hidden" value="" />
                            <input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                       <div class="row">
                                           <div class="col-md-4">
                                           	<div class="form-group row">
                                           		<div class="col-md-5">
                                           			<label class="col-form-label">Department Name</label>
                                           		</div>
                                           		
                                           		<div class="col-md-7">
                                           			<input type="text" class="form-control" readonly id="departmentname" />
                                           		</div>
                                           	</div>
                                           </div>
                                           <div class="col-md-4">
                                           	<div class="form-group row">
                                           		<div class="col-md-5">
                                           			<label class="col-form-label">Modality</label>
                                           		</div>
                                           		
                                           		<div class="col-md-7">
                                           			<input type="text" class="form-control" readonly id="modalityname"/>
                                           		</div>
                                           	</div>
                                           </div>
                                           <div class="col-md-4">
                                           	<div class="form-group row">
                                           		<div class="col-md-5">
                                           			<label class="col-form-label">Investigation Name</label>
                                           		</div>
                                           		
                                           		<div class="col-md-7">
                                           			<input type="text" class="form-control" readonly id="investigationName"/>
                                           		</div>
                                           	</div>
                                           </div>

										</div>
										                                  
		
                                     
                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                               
                                                <th id="th1">Print Order</th>                                                
                                                <th id="th2">Sub Test Name(Auto Complete)</th> 
                                                <th id="th3">Sub Test Name(Enterable)</th> 
                                                <th id="th4">LOINC Code</th>                                                                                               
                                                <th id="th5">Unit</th>
                                                <th id="th6">Result Type</th>
                                                <th id="th7">Comparison Type</th>
                                                <th>Add</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                       
                                     <!-- <tbody id="tblListOfsubInvestigation"> -->
                                     <tbody id="subinvestigationId">
                             
																
                     				 </tbody>
                                    </table>

									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddorUpdate"
															class="btn  btn-primary " onclick="updateSubInvestigationDetails()">Update</button>
														<button type="button"
															class="btn  btn-primary " onclick="bacTolabkInvestigtion()">Back</button>
														
													
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