<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script> --%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

</head>
<%
long departmentId = 0;
String departmentName="";
	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  }
	  
	  %>
<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Enter Quotation Against Budgetary Approval </div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<form:form name="submitBudgetaryQuotation" id="submitBudgetaryQuotation" method="post" enctype='multipart/form-data'
										action="${pageContext.request.contextPath}/lpprocess/submitQuotation" >
								<input type="hidden" name="status" value="${status}" id="status"  />
														 
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Requirement No</label>
												</div>
												<div class="col-md-7">
													<input type="text" id="reqNo" name="reqNo" class="form-control" readonly="readonly"/>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Requested On</label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" class="calDate datePickerInput form-control minwidth120" id="reqDate"
														placeholder="DD/MM/YYYY" value="" maxlength="10"  name="reqDate"/>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<h5>Add Quotation List</h5>
									
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>Quotation No</th>
												<th>Vendor Name</th>
												<th>Upload Quotation<span class="mandate">(File name should not contain any special characters and should be jpg, pdf, jpeg, gif, png, doc, docx, xls, xlsx only!)</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										</thead>
										<tbody id="nomenclatureGrid">
											<tr>
												<td><input type="text" name="quotqtionNo"
														tabindex="1" id="quotation1" class="form-control" onblur="checkQuotation(this.value,this);" /></td>
												<td>
													<select id="vendor1" name="vendors" class="form-control" onchange="checkVendor(this.value,this);">
                                                                                <option value="0" selected="selected" >Select</option>
                                                    </select>
												</td>
												 <td>
												 	<div class="fileUploadDiv">
														<input type="file" id="upload1" class="inputUpload"  name="upload"/>
														<label class="inputUploadlabel">Choose File</label>
														<span class="inputUploadFileName">No File Chosen</span>
													</div>													
												</td> 
												<td>
															<button type="button" class="btn btn-primary buttonAdd noMinWidth addBtn"
																name="button" button-type="add" value="" id="addBtn"
																onclick="addRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth delBtn"
																name="button" button-type="delete" value="" tabindex="1" id="delBtn"
																onclick="removeRow(this);"></button>

														</td>
											</tr>
											
										</tbody>
									</table>
									<div class="row form-group">
										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

												<div class="button-list">
													<input type="button" class="btn btn-primary " id="showDetails"
														name="show" value="ShowDetails" onclick="return ShowDetails();" />
													
												</div>
											</div>



										</div>
									</div>
									<div id="quotationD" style="display: none;">
									<div class="table-responsive" >
									<table class="table table-hover table-striped table-bordered m-t-10" id="quotationDetails" >
										<thead class="bg-primary">
											<tr id="firstHead"> 
											    <th rowspan="2">SI No</th>
												<th rowspan="2">Nomenclature/PVMS No</th>
												<th rowspan="2">A/U</th>
												<th rowspan="2">Required Qty</th>
												<th rowspan="2">Last LP Unit Rate</th>
											</tr>
											<tr id="secondHead">
											</tr>
										</thead>
										<tbody id="nomenclatureGrid1">
											<tr>
												<td id="sNo1">1</td>
												<td>
													<input type="text" class="form-control  width330" readonly="readonly"id="nomenclature1" size="77"
																name="nomenclature" />
												</td>
												<td>
													<input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" class="form-control width150" readonly="readonly" />
												</td>
												<td>
													<input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="requiredQty1"   class="form-control width100" readonly="readonly" />
												</td>
												<td>
													<input type="text" id="lpunitrate1"
														 name="lpunitrate" class="form-control width150" readonly="readonly" />
												</td>
												<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1" size="77"
														name="itemIdNom" /></td>

													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
														
														<td style="display: none;"><input type="hidden"
														name="budgetaryMId1" tabindex="1" id="budgetaryMId1" size="10"
														readonly="readonly" /></td>
														
													<td style="display: none;"><input type="hidden"
														name="budgetaryTId1" tabindex="1" id="budgetaryTId1" size="10"
														readonly="readonly" /></td>
														
												
											</tr>
											
										</tbody>
									</table>
									</div>
									
									
									<div class="row m-t-20" id="textBoxesGroup">
										
									</div>
									
									<!-- <div class="col-md-3">
											<div class="form-group row">
												<div class="col-md-6 ">
													<label for="service" class="col-form-label">L1 Vendor Name</label>
												</div>
												<div class="col-md-6">
													<input type="text" class="form-control" disabled/>
												</div>
											</div>
										</div>
									 -->
									 <div id ="venderList">
                                                                    <div class="form-group row">
                                                                        <label for="service" class="col-md-2 col-form-label">L1 Vendor Name</label>
                                                                        <div class="col-md-3">
                                                                            <select id="vendorId" name="vendor" class="form-control">
                                                                              <option value="0" selected="selected">Select</option>
                                                                                 <!--   <option value="1" >Male</option>
                                                                                <option value="2" >Female</option> -->
                                                                                
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
									<div class="row form-group">
										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

												<div class="button-list">
													<!-- <input type="submit" class="btn btn-primary "
														name="btnvalue" value="Save" onclick="return submitForm();" /> -->
													<input type="submit" class="btn  btn-primary"
														name="btnvalue" id="saveForm1"
														value="Submit" tabindex="1" onclick="return submitForm();" />
														<input type="button" id="reset" class="btn btn-danger" onClick="document.location.reload(true);" value="Reset"/>
															<a  class="buttonDel  btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/budgetaryApprovalListSALogistic">Close</a>


												</div>
											</div>

										</div>
										</form:form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

		
			<!-- container -->

	

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	
	<!-- END wrapper -->

</body>
  <script>
 //get vendorlist
 var k=1;
 var j=0;
 $j(document).ready(function() {
	//if department not in session
	   	if(<%= departmentId %>!=0){
				$j("#submitBudgetaryQuotation :input").attr("disabled", false);
				$("#showDetails").attr("disabled", false);
				}else{
				alert("Select the department");
				$j("#submitBudgetaryQuotation :input").attr("disabled", true);
				return false;
			}
                     var vendorValues = "";
                    var vendorListDict = ${venderList}
                    for (vendor in vendorListDict) {

                    	vendorValues += '<option  value=' + vendor + '>' + vendorListDict[vendor] + '</option>';
                    } 
                    $j('#vendor1').append(vendorValues); 
                    
  					//get list                  
                    
                    var dataList = ${data};
                    var resultList= dataList.data;
                    var count=dataList.count;
                    
                   	 
                   for(item in resultList){
                   	if(item==1){
             		   $j('#reqDate').val(resultList[item].reqDate);
             	  	   $j('#reqNo').val(resultList[item].reqNo);
             	  	 
             	  	  	 }
             	 j++;
             	 $('#sNo'+j).html(j);
             	 $('#nomenclature'+j).val(resultList[item].NomPvmsNo);
             	 $('#dispensingUnit'+j).val(resultList[item].accountingUnit);
             	 $('#requiredQty'+j).val(resultList[item].requiredQty);
             	 $('#itemIdNom'+j).val(resultList[item].itemId);
             	 $('#pvmsNo'+j).val(resultList[item].pvmsNo);
             	 $('#lpunitrate'+j).val(resultList[item].lpunitrate);
             	 $('#budgetaryMId'+j).val(resultList[item].budgetaryMId);
             	 $('#budgetaryTId'+j).val(resultList[item].id);
             	   	 if(j!==count)
                   	 addRow1();
                   }

 });
 
 function checkVendor(val,obj){
	 var flag=0;
	// alert("val"+val+"---this---"+obj);
	 var idddd =$(obj).closest('tr').find("td:eq(1)").find("select").attr("id");
	 var iddddValue =$(obj).closest('tr').find("td:eq(1)").find("select").val();
	// alert("current select id"+idddd);
	// alert("current select val"+iddddValue);
 $("#nomenclatureGrid tr").each(function () {
	// var b=$(this).find('td:eq(1)').find('select');
	 var thisId =$(this).closest('tr').find("td:eq(1)").find("select").attr("id");
	// alert("--thisId--"+thisId);
 	 var vId=$(this).find('td:eq(1)').find('select').val();
	// alert("vId"+vId);
	
	
	  if (vId == iddddValue && thisId!=idddd) {
         alert("Vendor name already selected.Please select different vendor");
         $(obj).closest('tr').find("td:eq(1)").find("select").val(0);
         flag=1;
     }
	  if( flag==1){
	         return false;

	  }
 });
 } 
 
 
 function checkQuotation(val,obj){
	 var flag=0;
	 var idddd =$(obj).closest('tr').find("td:eq(0)").find("input").attr("id");
	 var iddddValue =$(obj).closest('tr').find("td:eq(0)").find("input").val();
	 $("#nomenclatureGrid tr").each(function () {
		var thisId =$(this).closest('tr').find("td:eq(0)").find("input").attr("id");
		var vId=$(this).find('td:eq(0)').find('input').val();
		  if (vId == iddddValue && thisId!=idddd) {
         alert("Quotation already entered");
         $(obj).closest('tr').find("td:eq(0)").find("input").val("");
         flag=1;
     }
	  if( flag==1){
	         return false;

	  }
 });
 } 
 function addRow1() {
	
	 k++;
	 var aClone = $('#nomenclatureGrid1>tr:last').clone(true)
	 aClone.find(":input").val("");
	 aClone.find("td:eq(0)").prop('id', 'sNo'+k+'');
	 aClone.find("td:eq(1)").find(":input").prop('id', 'nomenclature'+k+'');
	 aClone.find("td:eq(2)").find(":input").prop('id', 'dispensingUnit'+k+'');
	 aClone.find("td:eq(3)").find(":input").prop('id', 'requiredQty'+k+'');
	 aClone.find("td:eq(4)").find(":input").prop('id', 'lpunitrate'+k+'');
	 aClone.find("td:eq(5)").find(":input").prop('id', 'itemIdNom'+k+'');
	 aClone.find("td:eq(6)").find(":input").prop('id', 'pvmsNo'+k+'');
	 aClone.find("td:eq(7)").find(":input").prop('id', 'budgetaryMId'+k+'');
	 aClone.find("td:eq(8)").find(":input").prop('id', 'budgetaryTId'+k+'');
	 aClone.find("td:eq(9)").find(":input").prop('id', 'unitRate'+k+'');
	 aClone.find("td:eq(10)").find(":input").prop('id','totalCost'+k+'');
	 aClone.clone(true).appendTo('#nomenclatureGrid1');
	  
 }
 
 var i=1;
 function addRow() {
   i++;
 	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
 	aClone.find(":input").val("");
 	aClone.find("td:eq(0)").find(":input").prop('id', 'quotation'+i+'');
 	aClone.find("td:eq(1)").find(":input").prop('id', 'vendor'+i+'');
 	aClone.find("td:eq(2)").find(":input").prop('id', 'upload'+i+'');
 	aClone.find("td:eq(2)").find(":input").prop('name', 'upload'+i+'');
 	aClone.find("td:eq(2)").find(".inputUploadFileName").text('No File Chosen');
 	aClone.find("td:eq(2)").find(".fileUploadDiv ").removeClass('hasFile');
	aClone.find("td:eq(2)").find('.inputUploadlabel').text('Choose File');	
 	// var  vendorList ='<select id="vendor'+i+'" name="vendors" class="form-control" onchange="checkVendor(this.value);"><option value="0" selected="selected" >Select</option></select>';

	 // aClone.find("td:eq(1)").html(vendorList);
 
 	aClone.clone(true).appendTo('#nomenclatureGrid');
 	var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
 	
 }
 function removeRow(obj){
		var rowCount = $('#nomenclatureGrid tr').length;
		if(rowCount!==1){
		var r = confirm("Do you want to delete the record?");
		if (r == true) {
				$(obj).closest('tr').remove();
				
		}
			
		 else {
			
			  return false;
		 }
		} else {
			alert("Atleast one row should be there");
		  return false;
		}
		
	}
 

 function submitForm() {
		  var flag=0;
		  var rowCount = $('#nomenclatureGrid1 tr').length;
			
			 for(var i=1;i<=rowCount;i++) {
				 
			 	 var unitRate=$j("#unitRate"+i).val();
			 	 if (unitRate == null || unitRate == "") {
				 	 alert("Please enter unit rate");
				 	 flag=1;
				 	 return false;
				 	 break;
			 	 }
			 	}
			 
			 var vendorId=$('#vendorId').find(":selected").val();
			 if (vendorId == null || vendorId == "" || vendorId == 0) {
			 	 alert("Please select L1 vendor name");
			 	 flag=1;
			 	 return false;
		 	 }
		    if(flag==1){
		    	return false;
		    } 
		   
			$("#submitBudgetaryQuotation").submit();
			 setTimeout(function(){ 			 
				 $("#saveForm1").attr("disabled", "disabled");
				 
			 }, 50);
		
	}

 

 function ShowDetails() {
	 var status=$('#status').val();
	 var rowCount = $('#nomenclatureGrid tr').length;
	 if((status=="L" || status=="K") && rowCount<3){
		 alert("Atleast three vendors required for enter quotation");
		 return false;
	 }
	 var flag=0;
	 $("#nomenclatureGrid tr").each(function () {
	 	 var quotation=$(this).find('td:eq(0)').find(':input').val();
		 var vName=$(this).find('td:eq(1)').find('select').val();
		 var fileNameValueIDd= $(this).find("td:eq(2)").find(':input').attr("id");
		 var fileNameValue=$j('#'+fileNameValueIDd).val();
			var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
			 if(filenameWithExtension==""||filenameWithExtension == null ){
			  alert("Please choose file");
			  flag=1;
			  return false;
		      }  
			if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed ",
				      new Array("jpg","pdf","jpeg","gif","png","doc","xlsx","xls","docx")) == false)
			{
				 		flag=1;
				 		return false;
				     
			 }
			 if (quotation == null || quotation == "") {
	         alert("Please enter the Quotation Number");
	         flag=1;
	         return false;
	     }
		  if (vName == null || vName == ""||vName == 0) {
	         alert("Please select Vendor name");
	         flag=1;
	         return false;
	     }
		 
	    
	  });
	    if(flag==1){
	    	return false;
	    } 
	    
	 var i=1;
	 var j=1;
	 	 $j(".addBtn").prop('disabled', true);
		 $j(".delBtn").prop('disabled', true);
		 $j("#showDetails").prop('disabled', true);
		
		var counter=1;
	 	
		var vendorValues="";
		$("#nomenclatureGrid tr").each(function () {
		 	 var vName=$(this).find('td:eq(1) option:selected').text();
		 	 var vId=$(this).find('td:eq(1) option:selected').val();
		 	 
		 	

             	vendorValues += '<option  value=' + vId + '>' +vName + '</option>';
          
           
		 	 //alert(vId);
		 	/* $j("#quotationDetails>thead>tr").append("<th>Quotation"+j+"("+vName+"(Unit Rate))</th>");
		 	  $j("#quotationDetails>thead>tr").append("<th>Quotation"+j+"(Total Cost)</th>"); */
		 	  
		 	 $j("#quotationDetails thead tr#firstHead").append("<th class='text-center' colspan='2'>Quotation"+j+"<br/>("+vName+")</th>");
		 		$j("#quotationDetails thead tr#secondHead").append("<th> Unit Rate</th><th>Total Cost</th>");
		 	  
		 $("#nomenclatureGrid1 tr").each(function () {
			 $(this).append("<td><input type='text' id='unitRate"+i+"' name='unitRate' onkeypress='if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;' onblur='calculateAmount(this,"+i+")' class='form-control  width100' /></td>");
		 	
		  
			 $(this).append("<td><input type='text'  class='form-control width100' id='totalCost"+i+"' name='totalCost' readonly='readonly' /></td>");
		 	
		 	$j(this).append("<td style='display: none;'><input type='hidden' name='venderId' id='vid"+i+"' value="+vId+" class='form-control' readonly='readonly' /></td>");
		 	i++;
		 });
		 	j++;
		 
		 	$j("#textBoxesGroup").append( '<div class="col-md-4"><div class="form-group row"><div class="col-md-6 "><label for="service" class="col-form-label">Total Cost Q'+counter+'</label></div>'+
			'<div class="col-md-6"><input type="text" id="totalCostQ'+counter+'" name="totalCostQ" class="form-control" readonly="readonly"/></div></div></div>');

	   // newTextBoxDiv.appendTo("#textBoxesGroup");


	    counter++;
	    
		 	
		});
		 $j("#quotationD").show();
		  $j('#vendorId').append(vendorValues); 
		 
		 
			
 }
 
 function calculateAmount(obj,inc){
	  var quantity = 0;
	  var unitRate = 0;
	  var amount = 0;
	 var a =$(obj).val();
	var b =$(obj).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
	  if (!isNaN(a))
	  quantity = parseFloat(a);
	  
	  if (!isNaN(b))
	   unitRate = parseFloat(b);
	  // Amount Calculation
	  
	  if (unitRate > 0 && quantity > 0)
	  {
	   amount = quantity * unitRate;
	   document.getElementById('totalCost'+inc).value =  Math.round(amount * 100) / 100;
	   calculateTotalCost(obj,inc);
	  }else
	  {
	   return;
	  }
	 
	 }

 function calculateTotalCost(obj,inc){
	
	var rowCount = $('#nomenclatureGrid tr').length;
	var rowCount1 = $('#nomenclatureGrid1 tr').length;
		 var i=inc=1;
	
	 var n=1;
	 var min=0;
	 var vid;
		 for(var i=1;i<=rowCount;i++) {
			 var totalCost=0;
			 for(var j=1;j<=rowCount1;j++) {
			 
		 	 var itemValue=$j("#totalCost"+n).val();
		 	 n++;
		 	 if (itemValue!==""){
		 	 totalCost=parseFloat(totalCost)+parseFloat(itemValue);
		 	 
		 	}
		 	 $j('#totalCostQ'+i).val(Math.round(totalCost * 100) / 100);
		}
	}
		
		 for(var i=1;i<=rowCount;i++) {
			
		 	 var cost=$j("#totalCostQ"+i).val();
		 	 
		 	//alert("cost---"+cost);
		 	//alert("min"+min);
		 	 if(i==1){
		 		 min=cost;
		 		 vid= $j('#vendor'+i).val();
		 		//alert("vid"+vid);
		 		
		 	 }
		 	if(parseFloat(cost)<parseFloat(min)){
		 		//alert("i"+i);
		 		 min=cost;
		 		//alert("min--"+min);
		 		
		 		 vid= $j('#vendor'+i).val();
		 		 //alert("vid--"+vid);
		 		 }
		 	 $('#vendorId').val(vid);
		 	 }
		 $('#vendorId').val(vid);
		 return;
 }

 function validateFileExtension(component,msg_id,msg,extns)
 {
    var flag=0;
    with(component)
    {
       var ext=component.substring(component.lastIndexOf('.')+1);
       for(i=0;i<extns.length;i++)
       {
          if(ext==extns[i])
          {
             flag=0;
             break;
          }
          else
          {
             flag=1;
          }
       }
       if(flag!=0)
       {
          alert(msg);
         /*  component.value="";
          component.style.backgroundColor="#eab1b1";
          component.style.border="thin solid #000000";
          component.focus(); */
          return false;
       }
       else
       {
          return true;
       }
    }
 } 

 function getFilenameAndReplcePath(fileNameValue){
	 var filenameWithExtension = fileNameValue.replace(/^.*[\\\/]/, '');
	 return filenameWithExtension;
 }

 </script>
</html>