
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
 <%@include file="..//view/commonModal.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
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
		
	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title>Asha Application</title>
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

		<div class="container-fluid">
			<div class="internal_Htext">HIV/STD Entry</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<form:form name="submitHivStdRegister" id="submitHivStdRegister" method="post"
										action="${pageContext.request.contextPath}/miAdmin/submitHivStdRegister" autocomplete="off">
								
							<div class="row">	
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of Entry<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" name="registerDate" id="registerDate" class="noFuture_date2 form-control" placeholder="DD/MM/YYYY" />
										</div>	
										</div>
									</div>															
								</div>							
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Service No<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="serviceNo1" name="serviceNo" onblur="getEmpDetails()"/>
											<span id="msg" style="color:red; font-weight: bold;"></span>
										</div>
									</div>															
								</div>
								<div class="col-md-2">
									<div id="loadingDiv">
										<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
									</div>
								</div>
								<div class="w-100"></div>
								<div class="col-md-4" id="rankNameDiv" >
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Rank</label>
										</div>
										<div class="col-md-7">
											<input type="text"  name="rank" id="rank"  class="form-control" readonly /> 
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="rankDiv" style="display:none">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Rank</label>
										</div>
										<div class="col-md-7">
											<select class="form-control" id="rankIdd" name="rankIdd">
												<option value="0">Select</option>
											</select>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Name</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="empName" name="empName" readonly /> 
											<!-- <textarea class="form-control" rows="2"></textarea> -->
										</div>
									</div>															
								</div>
								<input type="hidden" class="form-control" id="empId" name="empId" readonly />
								<input type="hidden" class="form-control" id="rankId" name="rankId" readonly />
								<input type="hidden" class="form-control" id="genderId" name="genderId" readonly />
								<input type="hidden" class="form-control" id="patientId" name="patientId" readonly />
								
								<div class="col-md-4" id="dobNDiv">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of birth</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" class="form-control " id="birthDate" name="birthDate" onchange="calculateAge()" readonly />
											</div>
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="dobDiv" style="display:none">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of birth</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" class="form-control  noFuture_date2" id="birthDatecal"  onchange="calculateAge()" placeholder="DD/MM/YYYY"  />
											</div>
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Age</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="age" name="age" readonly />
										
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="genderNameDiv">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Gender</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="gender" name="gender" readonly />
										</div>
									</div>															
								</div>
								 <div  class="col-md-4" id="genderDiv" style="display:none" >
                                                                    <div class="form-group row">
                                                                        <label for="service" class="col-md-5 col-form-label">Gender</label>
                                                                        <div class="col-md-5">
                                                                            <select id="genderIdd" name="gender" class="form-control">
                                                                                <option value="0" selected="selected">Select</option>
                                                                                 <!-- <option value="1" >Male</option>
                                                                                <option value="2" >Female</option> -->
                                                                                
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                  </div>
								<!-- <div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Diagnosis</label>
										</div>
										<div class="col-md-7">
											<input name="icddiagnosis" id="icd" type="text" autocomplete="off"
															class="form-control border-input" value=""
														onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','diagnosismi')" />
																<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Med Category</label>
										</div>
										<div class="col-md-7">
											<select id="medcategory" name="medcategory" class="form-control">
                                               <option value="0" selected="selected">Select</option>
                                                                                
                                             </select>
										</div>
									</div>															
								</div> -->
								
								</div>
								
								<div class="row">
								
								<div class="col-12">
									<h6 class="text-theme text-underline font-weight-bold">List of Medical Category</h6>
								
									<div class="table-responsive">
									<table class="table table-bordered table-hover table-striped">
										<thead>
											<tr>
												<th>Diagnosis</th>
												<th>Medical Category</th>
												<th>System</th>
												<th>Type of Category</th>
												<th>Duration</th>
												<th>Category Date</th>
												<th>Next Category Date</th>
												<th>Mark as HIV/ STD</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										</thead>
										<tbody id="medicalCategoryGrid">
											<tr>
												<td>
												<div class="autocomplete forTableResp">
													<input  id="icd1" name="icd" type="text" autocomplete="off"
															class="form-control border-input width330"  value=""
														onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','diagnosismi')" />
																<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														</div>
												</td>
												<td>
													<select id="medcategory1" name="medcategory" class="form-control width120">
                                                                <option value="0">Select</option>
																		
                                                                </select>
												</td>
												<td>
													 <select class="form-control width120" name="system" id="system1" >
                                                                <option value="0">Select</option>
																		<option value="S">S</option>
																		<option value="H">H</option>
																		<option value="A">A</option>
																		<option value="P">P</option>
																		<option value="E">E</option>
                                                                </select>
												</td>
												<td>
													<select class="form-control width120" name="typeOfCategory" id="typeOfCategory1" onChange="getdurationByType(this);">
																		<option value="0">Select</option>
																		<option value="T">Temporary(Week)</option>
																		<option value="P">Permanent(Month)</option>
													</select>
												</td>
												<td>
													<input type="text" class="form-control" name="duration" id="duration1" onblur="return generateNextDate(this);" onkeypress="return isNumberKey(event)" />
												</td>
												<td>
													<div class="dateHolder width120">
														<input type="text" id="categoryDate1" name="categoryDate" class="form-control noFuture_date5" placeholder="DD/MM/YYYY"   />
													</div>												
												</td>
												<td>
													<div class="dateHolder width120">
														<input type="text" id="nextcategoryDate1" name="nextcategoryDate" class="form-control noFuture_date" placeholder="DD/MM/YYYY" />
													</div>
												</td>
												<td class="text-center width110">
													<div class="form-check form-check-inline cusCheck">
													  <input class="form-check-input" type="checkbox" id="hivMark1" value="1" name="hivMark"/>
													  <span class="cus-checkbtn"></span> 
													</div>
												</td>
												<td style="display: none;"><input type="hidden"
														name="pId" tabindex="1" id="pId1" size="10"
														readonly="readonly" /></td>
												<td style="display: none;"><input type="hidden"
												 class="form-control" id="icdId1" name="icdId"  /></td>
												<td>
												

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>
															<button type="button" class="buttonDel  btn btn-danger noMinWidth m-r-20"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRowIndent(this);"></button>

														</td>		
											</tr>
										</tbody>
									</table>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Remarks</label>
										</div>
										<div class="col-md-7">
											<textarea name="remark" id="remark" class="form-control" maxlength="2000"></textarea>
										</div>
									</div>															
								</div>
								<div class="col-md-12 text-right">
									<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1"  onclick="return submitForm();" />														
										<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/hivStdReport">Back</a>
																										
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

</body>
<script>
	var nPageNo=1;
	var Status;
	var $j = jQuery.noConflict();
	var user_Id = <%= userId %>
	var i=1;
	
	//Rank list
	var rankValues = "";
  var rankListDict = ${rankList}
  var rankData = rankListDict.data;
 
  for (category in rankData) {

	  rankValues += '<option  value=' + rankData[category]  + '>' + category + '</option>';
  }
  $j('#rankIdd').append(rankValues);
  
//get gender
  var genderValues = "";
var genderListDict = ${genderList}
for (gender in genderListDict) {

	genderValues += '<option  value=' + gender + '>' + genderListDict[gender] + '</option>';
}
$j('#gender11').append(genderValues); 
 	function getEmpDetails(){
 		$j('#loadingDiv').show();
 		document.getElementById("msg").innerHTML="";
 		document.getElementById("empName").value="";
 		document.getElementById("empId").value="";
  		document.getElementById("age").value="";
  		document.getElementById("birthDate").value="";
  		document.getElementById("rank").value="";
  		document.getElementById("rankId").value="";
  		document.getElementById("gender").value="";
  		document.getElementById("genderId").value="";
  		document.getElementById("patientId").value="";
 		document.getElementById("msg").innerHTML="";
 		 var sNo = $j("#serviceNo1").val();
 			//alert(sNo);
 		 var serviceNo={"memberService":sNo};
 		 jQuery.ajax({
 	 	 	crossOrigin: true,
 	 	    method: "POST",			    
 	 	    crossDomain:true,
 	 	    url: "getPatientDetails",
 	 	    data:JSON.stringify(serviceNo),
 	 	    contentType: "application/json; charset=utf-8",
 	 	    dataType: "json",
 	 	    success: function(result){
 	 	    	if(result.status==1){
 	 	    		document.getElementById("empName").value=result.name;
 	 	    		document.getElementById("empId").value=result.empId;
 	 	    		document.getElementById("age").value=result.age;
 	 	    		document.getElementById("rank").value=result.rank;
 	 	    		document.getElementById("birthDate").value=result.dob;
 	 	    		document.getElementById("rankId").value=result.rankId;
 	 	    		document.getElementById("gender").value=result.gender;
 	 	    		document.getElementById("genderId").value=result.genderId;
 	 	    		document.getElementById("patientId").value=result.patientId;
 	 	    		
 	 	    		if(result.rankId == "" || result.rankId == null){
 	 	    			$j("#rankNameDiv").hide();
 	 	    			$j("#rankDiv").show();
 	 	    			
 	 	    		}
 	 	    		
 	 	    		if(result.genderId == "" || result.genderId == null){
 	 	    			
 	 	    			$j("#genderNameDiv").hide();
 	 	    			$j("#genderDiv").show();
 	 	    			
 	 	    		}
 	 	    		
 	 	    		if(result.dob == "" || result.dob == null){
 	 	    			$j("#dobNDiv").hide();
 	 	    			$j("#dobDiv").show();
 	 	    			
 	 	    		}
 	 	    	   		if(result.patientId != "" || result.patientId != null)
 	 	    				getMedicalCategory(result.patientId);
 	 	    			else
 	 	    				 $j('#loadingDiv').hide();
 	 	    	}
 	 	    
 	 	    	else if(result.status==0){
 	 	    		//console.log(result.msg);
 	 	    		document.getElementById("msg").innerHTML=result.msg;
 	 	    		document.getElementById("empName").value="";
 	 	   		    document.getElementById("empId").value="";
 	 	    		document.getElementById("age").value="";
 	 	    		document.getElementById("birthDate").value="";
 	 	    		document.getElementById("rank").value="";
 	 	    		document.getElementById("rankId").value="";
 	 	    		document.getElementById("gender").value="";
 	 	    		document.getElementById("genderId").value="";
 	 	    		document.getElementById("patientId").value="";
 	 	   		    //document.getElementById("msg").innerHTML="";
 	 	    		 $j('#loadingDiv').hide();
 	 	    	}
 	 	    },
 	 	    error: function(result) {
 	             alert("An error has occurred while contacting the server");
 	            $j('#loadingDiv').hide();
 	         }
 	 	    
 	 	});
 	 	
 	}
 	function getMedicalCategory(patientId){
 		$j('#loadingDiv1').show();
 		 jQuery.ajax({
 	 	 	crossOrigin: true,
 	 	    method: "POST",			    
 	 	    crossDomain:true,
 	 	    url: "getMedicalCategory",
 	 	    data:JSON.stringify(patientId),
 	 	    contentType: "application/json; charset=utf-8",
 	 	    dataType: "json",
 	 	    success: function(result){
 	 	    	  var resultList= result.data;
 	 	          var count=result.count;
 	 	          var j=0;
 	           if(count!=0){
 	 	    	 for(item in resultList){
 	 	    		 j++;
 	 	    		 $('#icd'+j).val(resultList[item].icd);
 	 	    		 $('#medcategory'+j).val(resultList[item].medicalCategory);
 	 	    		 $('#system'+j).val(resultList[item].system);
 	 	    		 $('#typeOfCategory'+j).val(resultList[item].categoryType);
 	 	    		 $('#duration'+j).val(resultList[item].duration);
 	 	    		 $('#categoryDate'+j).val(resultList[item].categoryDate);
 	 	    		 $('#nextcategoryDate'+j).val(resultList[item].categoryNextDate);
 	 	    		 $('#pId'+j).val(resultList[item].pId);
 	 	    		 $('#icdId'+j).val(resultList[item].icdId);
 	 	    		 if(resultList[item].hivmark=="yes"){
	 	 	    		 $('#hivMark'+j).prop('checked', true);
	 	 	    		 //$('#hivMark'+j).attr('readonly',true);
	 	 	    		 $('#hivMark'+j).attr('disabled','disabled');
 	 	    		 }
 	 	    		 if(j!==count)
 	 	    		 addNomenclatureRow1("1",resultList[item].hivmark);
 	 	         }
 	           }
 	 	    	 $j('#loadingDiv').hide();
 	 	    },
 	 	    error: function(result) {
 	             alert("An error has occurred while contacting the server");
 	            $j('#loadingDiv').hide();
 	         }
 	 	 
 	 	});
 	 	
 	}
 	
 	function submitForm() {
 		
 		 var registerDate = $j("#registerDate").val();
 		 var sNo = $j("#serviceNo1").val();
 		 var rank = $j("#rank").val();
 		 var age = $j("#age").val();
 		 var empName = $j("#empName").val();
 		 var remark = $j("#remark").val();
 		 var gender = $j("#gender").val();
 		 var birthDate = $j("#birthDate").val();
 		 
 		 if (registerDate == null || registerDate == "") {
	         alert("Please select date");
	         return false;
	     }
	 	
 		 if (sNo == null || sNo == "") {
	         alert("Please enter Service Number");
	          return false;
	     }
		 if (rank == null || rank == "") {
	         alert("Please enter rank");
	          return false;
	     }
	  	 if (age == null || age == "") {
         	alert("Please enter age");
        	 return false;
    	 }
	 	 if (empName == null || empName == "") {
	         alert("Please enter emp name");
	         return false;
	     }
	 	
	 	var birthDatecal = $j("#birthDatecal").val();
	 	if (birthDate == null || birthDate == "") {
	         if(birthDatecal == null || birthDatecal == "") {
	        	 alert("Please select  birth date");
	 	        
	                return false;
	            }else{
	           	 $j("#birthDate").val(birthDatecal);
		 			 
	            }
	     }
	 	var rankIdd = $j("#rankIdd").val();
		 if (rank == null || rank == "") {
		   if(rankIdd == null || rankIdd == "" ||rankIdd == 0) {
			    alert("Please select rank");
                return false;
            }else{
           	 $j("#rankId").val(rankIdd);
	 			 
            }
    }
		 
		 var genderIdd = $j("#genderIdd").val();
		 if (gender == null || gender == "") {
		   if(genderIdd == null || genderIdd == "" ||genderIdd == 0) {
			    alert("Please select gender");
                return false;
            }else{
           	 $j("#genderId").val(rankIdd);
	 			 
            }
    }
	 	 if (remark == null || remark == "") {
	         alert("Please enter remark");
	         return false;
	     }
	 	
	 	 var flag=0;
		  $("#medicalCategoryGrid tr").each(function () {
		 	 var icd=$(this).find('td:eq(0)').find(':input').val();
		 	 var medcategory=$(this).find('td:eq(1)').find('select').val();
			 var system=$(this).find('td:eq(2)').find('select').val();
			 var categoryType=$(this).find('td:eq(3)').find('select').val();
			 var duration=$(this).find('td:eq(4)').find(':input').val();
			 var catDate=$(this).find('td:eq(5)').find(':input').val(); 
			 var nextCatDate=$(this).find('td:eq(6)').find(':input').val(); 
			 if (icd == null || icd == "") {
		         alert("Please select the diagnosis");
		         flag=1;
		         return false;
		     }
			  if (medcategory == null || medcategory == "" || medcategory==0) {
		         alert("Please select medical category");
		         flag=1;
		         return false;
		     }
		     if (system == null || system == "" || system==0) {
		        alert("Please select system");
		        flag=1;
		        return false;
		    }
		      if (categoryType == null || categoryType == ""  ) {
			        alert("Please select type of category");
			        flag=1;
			        return false;
			    } 
		      
		      if (duration == null || duration == ""  ) {
			        alert("Please enter duration");
			        flag=1;
			        return false;
			    } 
		      if (catDate == null || catDate == ""  ) {
			        alert("Please select category Date");
			        flag=1;
			        return false;
			    } 
		      if (nextCatDate == null || nextCatDate == ""  ) {
			        alert("Please select next category Date");
			        flag=1;
			        return false;
			    } 
		  });
		    if(flag==1){
		    	return false;
		    }
 		
 			$("#submitHivStdRegister").submit();
 			setTimeout(function(){ 			 
 				 $("#saveForm1").attr("disabled", "disabled");
 				   
 			 }, 50);
 	}
 	 var autoIcdCode = '';
     var icdData= '';	 
      var idIcdNo = '';
      var icdValue = '';
      var multiIcdValue=[];
    
 	  var arry = new Array();
      var icdArry = new Array();
     
	//med category
	     
	     var medCategoryValues = "";
	     var medCategoryDict = ${medCategoryList}
	     var medCategoryData = medCategoryDict.data;
	    
	     for (category in medCategoryData) {

	    	 medCategoryValues += '<option  value=' + category + '>' + medCategoryData[category] + '</option>';
	     }
	     $j('#medcategory1').append(medCategoryValues);
	     
 	   var total_icd_value = '';
       var digaoReferal='';   
         function fillDiagnosisCombo1(val) {
        	 
             var index1 = val.lastIndexOf("[");
             var index2 = val.lastIndexOf("]");
             index1++;
             idIcdNo = val.substring(index1, index2);
            //document.getElementById('icdNo').value = idIcdNo;
             if (idIcdNo == "") {
                 return;
             } else {
                 
                 for(var i=0;i<autoIcdCode.length;i++){
              		  
              		  var icdNo1 = icdData[i].icdCode;
              		 
              		  if(icdNo1 == idIcdNo){
              			icdValue = icdData[i].icdId;
              			document.getElementById('icdId').value = icdValue;
              			multiIcdValue.push(icdValue);
              			digaoReferal=icdValue;
              			
              		  }
              	  }
                 
             } 
         }
         
         function fillDiagnosisCombo(val,item) {
        	 var index1 = val.lastIndexOf("[");
      	     var index2 = val.lastIndexOf("]");
      	     index1++;
      	     idIcdNo = val.substring(index1, index2);
      	    
      	     if (idIcdNo == "") {
      	         return;
      	     } else {
      	        
      	         for(var i=0;i<autoIcdCode.length;i++){
      	    		  var icdNo1 = icdData[i].icdCode;
      	    		  icdValue = icdData[i].icdId;
      	    		 //itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
	     			  var itemIds = icdValue;
      	    		  if(icdNo1 == idIcdNo){
      	    			  $(item).closest('tr').find("td:eq(9)").find("input:eq(0)").val(icdValue);
      	    			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(9)").find("input:eq(0)").attr("id");
      	      			var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(9)").find("input:eq(0)").val();  
      		     		
      	    			$('#medicalCategoryGrid tr').each(function(i, el) {
      	     			   var $tds = $(this).find('td')
      	   			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(9)").find("input:eq(0)").attr("id");
      	     			   var itemIdValue=$('#'+itemIdCheck).val();
      	     			   var idddd =$(item).closest('tr').find("td:eq(9)").find("input:eq(0)").attr("id");
      	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
      	     			  // var accId=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
      	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
      	     			   if(itemIdCheck!=checkCurrentNomRowId && itemIds==itemIdValue)	   
      	   		           {
      	     				 if(itemIds==itemIdValue){
      	      			        $('#'+idddd).val("");
      	      			        $('#'+currentidddd).val("");
      	      			       // $('#'+accId).val("");
      	      			        alert("Diagnosis is already added");
      	      			        return false;
      	     				   
      	   		           }
      	   		           }
      	     			   else
      	     			   {
      	     				$(item).closest('tr').find("td:eq(9)").find("input:eq(0)").val(icdValue);
      	     			   }	   
      	     				
      	     			});
      	    		  }
      	    	  }
      	     }
               
       }
         
         function addNomenclatureRow1(flag,hivstatus) {
        	   i++;
        	   //$('#medicalCategoryGrid>tr:last').prop("readonly", true);
        	 	var aClone = $('#medicalCategoryGrid>tr:last').clone(true)
        	 	aClone.find('.ui-datepicker-trigger').remove();
        		aClone.find(":input").val("");
        		if(flag==1){
        	 	$('#medicalCategoryGrid>tr').find(":input").prop("readonly", true);
        	 	$('#medicalCategoryGrid>tr').find('select').attr("readonly", true);
        		aClone.find(":input").prop("readonly", true);
        		aClone.find('select').attr("readonly", true);
        		}else{
        			aClone.find(":input").prop("readonly", false);
            		aClone.find('select').attr("readonly", false);
        		}
        		aClone.find("input[type='checkbox']").removeAttr('disabled');
        	 	aClone.find("input[type='checkbox']").prop('checked', false);
        	 	/* if(hivstatus=="yes")
        	 		aClone.find("input[type='checkbox']").prop('checked', true); */
        	 	aClone.find("input[type='radio']").prop('checked', false);
        	 	aClone.find("td:eq(0)").find("div").find("div").prop('id', 'divIdPVMS' + i + '');
        		aClone.find("td:eq(0)").find(":input").prop('id', 'icd'+i+'');
        		aClone.find("td:eq(1)").find('select').prop('id', 'medcategory'+i+'');
        		aClone.find("td:eq(2)").find("select").prop('id', 'system'+i+''); 
        		aClone.find("td:eq(3)").find("select").prop('id', 'typeOfCategory'+i+'');
        		aClone.find("td:eq(4)").find(":input").prop('id', 'duration'+i+'');
        		aClone.find("td:eq(5)").find(":input").prop('id', 'categoryDate'+i+'').removeClass('hasDatepicker');
        		aClone.find("td:eq(6)").find(":input").prop('id', 'nextcategoryDate'+i+'').removeClass('hasDatepicker');
        		
        		aClone.find("td:eq(7)").find(":checkbox").prop('id', 'hivMark'+i+'').prop('value',i);
        		aClone.find("td:eq(8)").find(":input").prop('id', 'pId'+i+'');
        		aClone.find("td:eq(9)").find(":input").prop('id', 'icdId'+i+'');
        		
        		aClone.clone(true).appendTo('#medicalCategoryGrid');
        		
        	}

        	function showLastRow(){
        		 $('.scrollableDiv ').animate({ scrollTop: $('table').height()}, 300);
        	}

        	function removeRowIndent(obj){
        		var rowCount = $('#medicalCategoryGrid tr').length;
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
        	
        	function isNumberKey(evt){
        	    var charCode = (evt.which) ? evt.which : event.keyCode
        	    if (charCode > 31 && (charCode < 48 || charCode > 57))
        	        return false;
        	    return true;
        	}
        	
        	$j('body').on("focus",".noFuture_date5", function() {
        	   	 $j(this).datepicker({ showOn: "button",
        	   		buttonImage: "../resources/images/calendar.gif",		
        			buttonImageOnly: true,
        			dateFormat: 'dd/mm/yy',
        			buttonText: 'Select Date',
        			selectWeek:false,
        			closeOnSelect:true,  
        			changeMonth: true, 
        			changeYear: true,
        			clickInput:false,
        			yearRange: '1900:2090',
        			maxDate: new Date(),
        			onSelect: function(dateText) {
        		      display(this);
        		      $(this).change();
        		    }
        	   	 }).on("change", function() {
        	 	    display("Change event");  
        	   	 });
        	   	 
        	   	function display(ides) {
        	   		generateNextDate(ides);  
        	   		 
        	   	}
        	   });
        	

        	 function generateNextDate(item) {
        		 
        		  var carrentDateIdValue=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
        		  var durationValue=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
        		  var nextCategoryDateId=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
        		  if(carrentDateIdValue==null || carrentDateIdValue==""){
        			  //alert("Please enter  current Date.");
        				return false;
        		  	}
        		var currentDateVal=carrentDateIdValue.split("/");
        		var date=currentDateVal[0];
        		var month=currentDateVal[1];
        		var year=currentDateVal[2];
        		if(durationValue==null || durationValue==""){
        			alert("Please enter  duration");
        			return false;
        		}
        		
        		 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("id");
        		 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
        		
        		 
        		 if(typeOfCategoryValue=="0"){
        				alert("Please select  Type of Category.");
        				 var categoryDateForCheck=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
        				  $("#"+categoryDateForCheck).val('');
        				return false;
        			}	 
        		 
        	var monthNew ="";	
        	if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='T'){
        		var newDays=(parseInt(date)+(parseInt(durationValue)*7));
        		if(newDays>=30){
        			  var remDayNew= parseInt(newDays)%30;
        			  var  coMonthNew= parseInt(newDays)/30;
        			 
        			     coMonthNew=  Math.floor(parseInt(coMonthNew));
        			     monthNew=parseInt(month)+parseInt(coMonthNew);
        			     date=remDayNew;
        			     
        		}
        		else{
        			date=newDays;
        			monthNew= month;
        		}
        	}
        	else{
        		  //monthNew =parseInt(month)+parseInt(durationValue);	
        		monthNew =parseInt(durationValue);	
        	}
        	 
        	var dateNext="";
        	var yearNew;
        	var remMonthNew;
        	var  coYearNew;
        		if(monthNew>12){
        			 var remMonthNew="";
        			if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='T'){
        		     remMonthNew= parseInt(monthNew)%12;
        			}
        			else{
        				remMonthNew= 	month;
        			}
        		  var  coYearNew= parseInt(monthNew)/12;
        		 
        		   coYearNew=  Math.floor(parseInt(coYearNew));
        		   year=parseInt(year)+parseInt(coYearNew);
        		   if(date!=null && date!="" && date.toString().length==1)
        		     {
        		    	 date="0"+date;
        		     }
        		     if(remMonthNew!=null && remMonthNew!="" && remMonthNew.toString().length==1){
        		    	 remMonthNew="0"+remMonthNew;
        		     }
        		   dateNext=date+"/"+remMonthNew+"/"+year;
        		}
        		else{
        			
        			 if(date!=null && date!="" && date.toString().length==1)
        		     {
        		    	 date="0"+date;
        		     }
        		     if(monthNew!=null && monthNew!="" && monthNew.toString().length==1){
        		    	 monthNew="0"+monthNew;
        		     }
        		  
        			 dateNext=date+"/"+monthNew+"/"+year;
        		}
        	 $('#'+nextCategoryDateId).val(dateNext);
        	 //$('#'+nextCategoryDateId).attr('readonly', true); 
        		}
        	 
        	 
        	 
        	 function getdurationByType(item){
        		 
        		 var medCateDurationId=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
        		 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("id");
        		 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
        		 if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='P'){
        			 var durationValue='24';
        			 
        			 $('#'+medCateDurationId).val(durationValue);
        			 $('#'+medCateDurationId).attr('readonly','readonly');
        		 }
        		 else{
        			 $('#'+medCateDurationId).attr('readonly',false);
        			 $('#'+medCateDurationId).val('');
        			
        		 }
        	 }
</script>
</html>