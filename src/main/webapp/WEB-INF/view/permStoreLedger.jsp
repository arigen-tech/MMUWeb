<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

	Calendar c = Calendar.getInstance(); 
	Date currentDate1 = c.getTime();
	String currentDate=formatter.format(currentDate1); 

	//c.set(Calendar.DATE, 01);
	Date startDate1 = c.getTime();

	//c.set(Calendar.DATE, 30);
	Date enddate1 = c.getTime();
	String startDate=formatter.format(startDate1); 
	String enddate=formatter.format(enddate1); 	
	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title>permanent stores ledger</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->


<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>

<%
	int i = 1;
%>

<body>
<div id="wrapper">
	<div class="content-page">
		<!-- Start content -->

		<div class="container-fluid" >
			<div class="internal_Htext">Permanent Stores Ledger IAFM-1224</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
								<form:form name="submitAuditDetails" id="submitAuditDetails" method="post"
										action="${pageContext.request.contextPath}/miAdmin/submitAuditDetails" autocomplete="never">
							<div class="row">								
								<div class="col-md-6">
									<div class="form-group row">
										<div class="col-md-4">
											<label class="col-form-label">PVMS/Nomeclature</label>
										</div>
										<div class="col-md-8 ">
											<div class="autocomplete forResptable">
												<input type="text" value="" autocomplete="never"
																	spellcheck="false" id="nomenclature1" 
																	name="nomenclature" class="form-control border-input width330"
																	onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','MIitem')" />
												<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
											</div>
										</div>
									</div>															
								</div>
								<input type="hidden" value="" id="itemId" name="itemId"/>
								<div class="w-100"></div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Authorized ME Scale</label>
										</div>
										<div class="col-md-6">
											<input type="text" id="scale" name="scale" class="form-control" readonly />
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Authorized Qty</label>
										</div>
										<div class="col-md-6">
											<input type="text" id="qty" name="qty"class="form-control" readonly />
										</div>
									</div>															
								</div>	
								<!-- <div class="col-md-4">
								<button class="btn btn-primary" id="searhData"
												type="button" onclick="searchRequest()">Search</button>
								</div>	 -->						
																
							</div>
							<div>	
								<div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >	
		                                    
		                             		<tr>
												<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
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
                                    
					
		

                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
								
											<tr>
												<th>RV No</th>
												<th>RV Date</th>
												<th>Received Qty</th>
												<th>Board Out</th>
												<th>Balance</th>
												<!-- <th>Remarks</th> -->
											</tr>
										</thead>
											<tbody id="tblListOfStoreLedger">
											 <tr id="noFound"><td colspan='5'><h6>No Record Found</h6></td></tr>
											</tbody>
										
									</table>														
								</div>	
							
							<div class="row">								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Audit By</label>
										</div>
										<div class="col-md-6">
												<input type="text" id="auditBy" name="auditBy" class="form-control"  />
										
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Audit Date</label>
										</div>
										<div class="col-md-6">
											<div class="dateHolder">
												<input class="form-control calDate" id="auditDate" name="auditDate" placeholder="DD/MM/YYYY" />
											</div>
										</div>
									</div>															
								</div>
								<input type="hidden" id="rowid" class="form-control"  />
     			
								<div class="w-100"></div>
								<div class="col-md-6">
									<div class="form-group row">
										<div class="col-md-4">
											<label class="col-form-label">Audit Remarks</label>
										</div>
										<div class="col-md-8">
											<textarea class="form-control" id="auditRemarks" name="auditRemarks" rows="2"></textarea>
										</div>
									</div>															
								</div>								
							</div>
							<input type="hidden" id="tbSize" name="tbSize"class="form-control" value="0" readonly />
																			
							<div class="row m-t-10">								
								<div class="col-12 text-right">
									<input type="submit" class="btn  btn-primary" id="submitForm1"
														name="submit"
														value="Submit" tabindex="1" onclick="return submitForm();" />																	
								</div>
							</div>	
							</form:form>	
						</div>
						
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		  <div class="modal-dialog modal-xl" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title font-weight-bold">Board Out</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		       <form:form name="submitAccessary" id="submitAccessary" >
     			<input type="hidden" id="eqhid" name="eqhid" class="form-control"  />
     			<input type="hidden" id="rvNo" name="rvNo" class="form-control"  />
     			
     			
		      <div class="modal-body">
		        
				<table class="table table-striped table-hover table-bordered">
					<thead>
						<tr>
							<th>Department</th>
							<th>Model No.</th>
							<th>Serial No.</th>
							<th>Make</th>
							<th>Manufacturer</th>
							<th>Remarks</th>
							<th>Mark As Board Out</th>
							<th>Audit By</th>
							<th>Audit Date</th>
						</tr>
					</thead>
					<tbody id="equipmentGrid">
									
					</tbody>
				</table>
				
				<div class="row">
					 <div class="col-md-12 text-right">
			<button type="button" id="accSubmit" class="btn btn-primary" onclick="submitBoardOutDetails()">Submit</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
		</div>
				</div>
		      </div>
		      </form:form>
		    </div>
		  </div>
		</div>
	
	
	<div class="modal-backdrop show" style="display:none;"></div>
	</div>
</div>

</body>

<script>
var nPageNo=1;
var user_id = <%= userId %>
$(function(){
	
	// add custom scroll to sscrollableDiv class
	    $('.scrollableDiv').slimscroll({
	        height: 'inherit',
	        position: 'right',
	        color: '#9ea5ab',
	        touchScrollStep: 50
	    });
	    
	    
	   
	});
var autoVsPvmsNo = '';
var data='';
var pvmsNo = '';
var itemIds = '';
var itemIdPrescription= '';
		function populatePVMS(val, inc,item) {

			if (val != "") {
					var index1 = val.lastIndexOf("[");
				var indexForBrandName = index1;
				var index2 = val.lastIndexOf("]");
				index1++;
				pvmsNo = val.substring(index1, index2);
				var indexForBrandName = indexForBrandName--;
				var brandName = val.substring(0, indexForBrandName);
				if (pvmsNo == "") {
					
					return false;
				} 
				else
				{
					  var pvmsValue = '';
			     	  for(var i=0;i<autoVsPvmsNo.length;i++){
			     		 // var pvmsNo1 = data[i].pvmsNo;
			     		 var masItemIdValue= autoVsPvmsNo[i];
			     		 var pvmsNo1=masItemIdValue[1];
			     		
			     		  if(pvmsNo1 == pvmsNo){
			     			  pvmsValue = masItemIdValue[4];//data[i].dispUnit;
			     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
			     			  itemIds = itemIdPrescription;
			     			  $j('#itemId').val(itemIds);
			     			 searchRequest();
			     		  }
			     	  }	
			     	
		           
					return true;

				}

			} 
			else
			{
				return false;
		    }
}
		function getEquipmentDetailsByItemId() {
			var itemId=$('#itemId').val();
			if (itemId != "") {
			var itemId={"itemId":itemId};
			
			jQuery.ajax({
			crossOrigin: true,
			method: "POST",			    
			crossDomain:true,
			url: "getEquipmentDetailsByItemId",
			data:JSON.stringify(itemId),
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(result){
				if(result.status==1){
					if(result.qty!=0){
						$('#scale').val(result.scale);
						$('#qty').val(result.qty);
					}else{
						alert("No data found");
						$('#nomenclature1').val("");
						$('#scale').val("");
						$('#qty').val("");
					}
				}
				else if(result.status==0){
					alert(result.err_mssg);
				}
				else if(result.status==-1){
					alert(result.msg);
				}
				
				
			},
			error: function(result) {
			alert("An error has occurred while contacting the server");
			}
			
			});
		}
}
		function GetStoreLedgerData(MODE)
		{
			var itemId=$('#itemId').val();
			 if(MODE == 'ALL'){
				 var data = {"PN":nPageNo,"itemId":itemId};		
				}
			else
				{
				var data = {"PN":nPageNo,"itemId":itemId};
				} 
			var url = "getEquipmentReportList";
				
			var bClickable = false;
			GetJsonData('tblListOfStoreLedger',data,url,bClickable);
		} 
		function makeTable(jsonData)
		{	
			var htmlTable = "";	
			var data = jsonData.count;
			var pageSize = 5;
			var i=1+pageSize*(nPageNo-1);
			
			var dataList = jsonData.data;
			$('#tbSize').val(jsonData.count);
			
			 for(item in dataList){
					
					  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
					  htmlTable = htmlTable + "<tr id='rvNumber"+item+"'>";	
					  htmlTable = htmlTable + "<td >" +dataList[item].rvNumber+ "</td>";
			    	  htmlTable = htmlTable + "<td >" + dataList[item].rvDate + "</td>";
			    	  htmlTable = htmlTable + "<td >" + dataList[item].qty + "</td>";
			    	  htmlTable = htmlTable + "<td ><a class='btn-link' href='javascript:void(0);' onclick='showEquipmentDetails(\""+dataList[item].eqHdId+"\",\""+dataList[item].rvNumber+"\",this)'>" + dataList[item].boardOut + "</a></td>";
			    	  htmlTable = htmlTable + "<td >" + dataList[item].balance + "</td>";                                      
			    	 // htmlTable = htmlTable + "<td >" + dataList[item].eqHdId + "</td>";
			    	  htmlTable = htmlTable + "</tr>";
			 
			      }
			if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
				{
				$('#tbSize').val(0);
				htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
				   //alert('No Record Found');
				}			
			
			$j("#tblListOfStoreLedger").html(htmlTable);	
			
			
		}


		function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetStoreLedgerData('FILTER');
			
		}



		function searchRequest() {
			var nomenclature= $('#nomenclature1').val();
			if(nomenclature==""){
				alert("Please select PVMS/Nomenclature ");
				false;
			}
		 	nPageNo=1;
		 	GetStoreLedgerData('FILTER');
		}
		
		

		function showEquipmentDetails(eqHdId,rvNumber,obj) {
			 var idddd =$(obj).closest('tr').attr("id");
			 $('#rowid').val(idddd);
			$('#eqhid').val(eqHdId);
			var itemId=$('#itemId').val();
			$('#rvNo').val(rvNumber);
			var eqHdId={"eqHdId":eqHdId,"rvNumber":rvNumber,"itemId":itemId};
			jQuery.ajax({
			crossOrigin: true,
			method: "POST",			    
			crossDomain:true,
			url: "getEquipmentDetailsForstoreLedger",
			data:JSON.stringify(eqHdId),
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(result){
				if(result.status==1){
					var dataList=result.data;
					var htmlTable="";
					    for(item in dataList){
					    		  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
								  htmlTable = htmlTable + "<tr id='"+dataList[item].dtId+"' >";	
								  htmlTable = htmlTable + "<td id='department"+item+"'>" + dataList[item].department+ "</td>";
						    	  htmlTable = htmlTable + "<td id='modelNo"+item+"'>" + dataList[item].modelNo + "</td>";
						    	  htmlTable = htmlTable + "<td id='serialNo"+item+"'>" + dataList[item].serialNo + "</td>";
						    	  htmlTable = htmlTable + "<td id='make"+item+"'>" + dataList[item].make + "</a></td>";				
						    	  htmlTable = htmlTable + "<td id='manufacturer"+item+"'>" + dataList[item].manufacturer + "</td>";
						    	  
						    	  if(dataList[item].boardOutRemark=="")
						    	  	  htmlTable = htmlTable + "<td id='remark"+item+"'><input type='hidden' class='form-control' id='dtId"+item+"' value='"+dataList[item].dtId+"'  name='dtId' /><input type='text' class='form-control' id='rem"+item+"'  name='auditRemark' /></td>";
						    	  else
						    		  htmlTable = htmlTable + "<td id='remark"+item+"'><input type='hidden' class='form-control' id='dtId"+item+"' value='"+dataList[item].dtId+"'  name='dtId' /><input type='text' class='form-control' id='rem"+item+"'  name='auditRemark' value='"+dataList[item].boardOutRemark+"' readonly /></td>";
							    	 
						    	  if(dataList[item].boardOut==1)
						    	 	 htmlTable = htmlTable + "<td id='scales"+item+"'><input type='checkbox' name='boardOut' value='"+dataList[item].dtId+"' ></td>";
						    	  else
						    		  htmlTable = htmlTable + "<td id='scales"+item+"'><input type='checkbox' name='boardOut' value='"+dataList[item].dtId+"' checked='checked'  disabled></td>";
						    		
						    		  htmlTable = htmlTable + "<td id='auditBy"+item+"'>" + dataList[item].auditBy + "</a></td>";				
							    	  htmlTable = htmlTable + "<td id='auditDate"+item+"'>" + dataList[item].auditDate + "</td>";
							    	   
						    	  htmlTable = htmlTable + "</tr>";
						 
						      }
						if(result.count == 0 || typeof result.count == 'undefined')
							{
							htmlTable = htmlTable+"<tr ><td colspan='9'><h6>No Record Found</h6></td></tr>";
							   //alert('No Record Found');
							}			
						$j("#equipmentGrid").html(htmlTable);
					    }
				 $('#accSubmit').removeAttr('disabled','disabled');
			     $j("#exampleModal").modal("show")
				 
				
			},
			error: function(result) {
			alert("An error has occurred while contacting the server");
			}
			
			});
			
		}
		
		function submitBoardOutDetails() {
			  var eqHdId=$('#eqhid').val();
			  var rowid=$('#rowid').val();
			  var count=0;
			    $('#equipmentGrid tr').find('input[type="checkbox"]:checked').each(function () {
					count=count+1;
					
			    });  
			   
			    $('#tblListOfStoreLedger tr').each(function () {
			    	 var idddd =$(this).closest('tr').attr("id");
			    	 if(idddd==rowid){
			    		  $('#'+rowid).find("td:eq(3) > a").html(count);
			    		 var data= $('#'+rowid).find("td:eq(2)").html();
			    		  $('#'+rowid).find("td:eq(4)").html(data-count);
			    	 }
					
			    });
			  var rvNo=$('#rvNo').val();
			  $('#accSubmit').attr('disabled','disabled');
			 var formData1 = $('#submitAccessary')[0];
			 var formData = new FormData(formData1);
				var url="submitBoardOutDetails";
				$.ajax({
					url : url,
					data : formData,
					processData: false,
			        contentType: false,
					async : false,
					type : 'POST',
					dataType : "json",
					success : function(result) {
						if(result.status==1){
							alert(result.msg +'S');
							 $('#accSubmit').removeAttr('disabled','disabled');
							    
							showEquipmentDetails(eqHdId,rvNo);
						}
						else if(result.status==0){
							alert(result.err_mssg);
						}
						else if(result.status==-1){
							alert(result.msg);
						}
						
						
					},
					error : function(err) {
					}
				});
		}
		
		function submitForm() {
			 var auditRemarks=$('#auditRemarks').val();
			 var auditBy=$('#auditBy').val();
			 var auditDate=$('#auditDate').val();
			 var tbLength1=$('#tblListOfStoreLedger tr').length ;
			 var tbLength=$('#tbSize').val();
			 var nomenclature=$('#nomenclature1').val();
			 if (nomenclature == null || nomenclature == "") {
		          alert("Please select PVMS/Nomeclature");
		          return false;
		      }
			 if(tbLength == 0){
				 alert("This PVMS item is not available for audit");
		          return false;
			 }
			  if (auditBy == null || auditBy == "") {
		          alert("Please enter audit By");
		          return false;
		      }
			  if (auditDate == null || auditDate == 0) {
		          alert("Please select audit Date");
		          return false;
		      }
			  /* if (auditRemarks == null || auditRemarks == 0) {
		          alert("Please enter audit Remarks");
		          return false;
		      } */
			
				$("#submitAuditDetails").submit();
			    
				 setTimeout(function(){ 			 
					    $("#submitForm1").attr("disabled", "disabled");
				 }, 50);
				
			 
			   
		}
	
</script>
</html>