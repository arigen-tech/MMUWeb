
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>

<head>
<title>Minor Surgery Detail</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@include file="..//view/commonModal.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

</head>
<script type="text/javascript" language="javascript">
<%String hospitalId = "1";
			String loggedUser = "";
			String userId = "1";
			if (session.getAttribute("user_id") != null) {
				userId = session.getAttribute("user_id") + "";
			}
			if (session.getAttribute("userName") != null) {
				loggedUser = session.getAttribute("userName") + "";
			}%>

	var combo;
	var t=0;
	var $j = jQuery.noConflict();
	var j;
	var popup ;
	var patientId;	
	var defaultProcedureValue='M';
	var visitId;

	var url1='';
	var url2='';
	var flaga='';


	func1='populateNursing';
	url1='opd';
	url2='getMasNursingCare';
	flaga='procedureNursing';
	
$j(document).ready(function()
		{
	    
	
		var data = ${data};			
		data.patient_detail.patientId;
		visitId=data.patient_detail.visitId;		
		$j('#patient_name').val(data.patient_detail.patientName);
		$j('#age').val(data.patient_detail.fullage);
		$j('#ageNumber').val(data.patient_detail.age);
		$j('#serviceNo').val(data.patient_detail.serviceNo);		
		$j('#opdDate').val(data.patient_detail.opdDate);
		$j('#gender').val(data.patient_detail.gender);
		$j('#genderId').val(data.patient_detail.genderId);
		$j('#header_id').val(data.patient_detail.header_id);		
		$j('#icd_diagnosis').val(data.patient_detail.icd_diagnosis);		
		patientId=data.patient_detail.patientId;		
		var anesthesiaList=data.anesthesiaList;    	
    	 
		var html= '';
		for(var i=0;i<data.nursingDetailList.length;i++){
			 j=i+1;
			html += '<tr><input type="hidden" class="mid" id="rowid'+j+'" value="'+data.nursingDetailList[i].id+'">';
			//html += '<td><div><input class="form-control" id="siNO" type="hidden" value="'+j+'" readonly></div></td>';
			if(data.nursingDetailList[i].status=='Y'){
			html += '<td><div class="form-check form-check-inline cusCheck m-l-10"><input type="checkbox" class="form-check-input" id="chk'+j+'" checked><span class="cus-checkbtn"></span></div</td>';
			}
			else{
				html += '<td><div class="form-check form-check-inline cusCheck m-l-10"><input  class="form-check-input" type="checkbox" id="chk'+j+'"><span class="cus-checkbtn"></span></div></td>';
			}
			html += '<td><div><input class="form-control" id="procedure_name" type="text" value="'+data.nursingDetailList[i].minorSurgryName+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="" type="hidden" value="'+data.nursingDetailList[i].prescribedBy+'" readonly>'+data.nursingDetailList[i].rankName+" "+data.nursingDetailList[i].userName+'</div></td>';
			
			html +='<td><div><select name="anesthesia" class="form-control" id="anesthesia'+i+'"';
			html +='class="medium">';
			
			html +='<option value=""><strong>Select</strong></option>';		
			
			$.each(anesthesiaList, function(ij, item) {
				 if(item.anesthesiaId==data.nursingDetailList[i].anethesiaId){
					 html += '<option value="'+data.nursingDetailList[i].anethesiaId+'" selected>' + data.nursingDetailList[i].anethesiaName+'</option>'; 
				 }else{
					 html += '<option   value="'+item.anesthesiaId +'">' + item.anesthesiaName+'</option>';
				 }
				
			});
			html +='</select>';
			html +='</div></td>';
			
			html += '<td><div><textarea class="form-control" id="minor_surgery_remarks" type="text" value="" rows="2" cols="3">'+data.nursingDetailList[i].remarks+'</textarea></div></td>';
			html += '<td><div><button type="button" class="btn btn-primary noMinWidth" button-type="add" value="" onclick="addRow()" ></button>&nbsp;<button type="button" style="display: none;" class="btn btn-danger noMinWidth" button-type="add value="'+data.nursingDetailList[i].id+'" onclick="deleteRow(this)" disabled ></button></div></td>';
			html += '<td style="display: none;"><div><input class="form-control" id="minor'+j+'" type="hidden" value="'+data.nursingDetailList[i].nCode+'" ></div></td>';
			html += '</tr>';
			
			
		}
			
			
		$j('#gridMinorSurgery').append(html);
		
		});
		
		var arryProcedureCare= new Array();
		var autoNursingNo = '';
		var nursingItemId = '';
		var nursingCode="";
		 var nursingName="";
		 var nursingType="";
		 var nursingId="";
		 var dataNursing='';
		
		function addRow(){	
			t=t+1;
			j=j+1;			
			var data = ${data};			
			var anesthesiaList=data.anesthesiaList;
			
			 var htmlnew= '';
				htmlnew += '<tr><input type="hidden" id="rowid" value="">';
				//htmlnew += '<td><div><input class="form-control" id="siNO" type="text" value="'+j+'" readonly ></div></td>';
				htmlnew += '<td><div  class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="chk'+j+'" ><span class="cus-checkbtn"></span></div></td>';
				//htmlnew += '<td><div class="autocomplete" ><input class="form-control" autocomplete="never" id="minor'+j+'" onblur="populateNursing(this.value,1);calucateNursingValue(this); checkMsName(this.value, this);" name="minor" type="text" value="" ></div></td>';
                
                htmlnew =htmlnew+'<td><div class="form-group autocomplete forTableResp">';
                htmlnew = htmlnew+'<input type="text" autocomplete="never" value=""';			
                htmlnew = htmlnew+' class="form-control border-input" name="nursingname" id="minor'+j+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"    />';
                htmlnew = htmlnew+'<div id="procedureNursing" class="autocomplete-itemsNew"></div></div></td>';

				htmlnew += '<td><div><input class="form-control" id="prescribed_by" type="hidden" value="'+<%=userId%>+'"><%=loggedUser%></div></td>';								
				htmlnew +='<td><div><select name="anesthesia" class="form-control" id="anesthesia'+j+'"';
				htmlnew +='class="medium">';			
				htmlnew +='<option value=""><strong>Select</strong></option>';				
				$.each(anesthesiaList, function(ij, item) {
					 
						 htmlnew += '<option   value="'+item.anesthesiaId +'">' + item.anesthesiaName+'</option>';
					 
					
				});
				htmlnew +='</select>';
				htmlnew +='</div></td>';				
				htmlnew += '<td><div><textarea class="form-control" id="minor_surgery_remarks" type="text" value="" rows="2" cols="3"></textarea></div></td>';
				htmlnew += '<td><div><button type="button" class="btn btn-primary noMinWidth" button-type="add" value="" onclick="addRow()"> </button>&nbsp;<button type="button" class="btn btn-danger noMinWidth" button-type="delete" value="" onclick="deleteRow(this)" ></button></div></td>';
				htmlnew += '<td style="display: none;"><div><input class="form-control" id="minor'+t+'" type="hidden" value="" ></div></td>';
				htmlnew += '</tr>'; 
			$j('#gridMinorSurgery').append(htmlnew);
			
			
			$(document).ready(
					   function getMastNursingCareItem(defaultProcedureValue){
						    
				   var pathname = window.location.pathname;
					var accessGroup = "MMUWeb";

					var url = window.location.protocol + "//"
							+ window.location.host + "/" + accessGroup
							+ "/opd/getMasNursingCare";
					
					defaultProcedureValue = "M";
					$j.ajax({
						type : "POST",
						contentType : "application/json",
						url : url,
						data : JSON.stringify({
							'nursingType' : defaultProcedureValue
						}),
						dataType : 'json',
						timeout : 100000,
						
						success : function(res)
						
						{
							//alert(JSON.stringify(res.data));
							dataNursing = res.data;
							autoNursingNo=res.data;
							var valProcedureCare="";
							arryProcedureCare=[];
							for(var i=0;i<dataNursing.length;i++){
								
								nursingCode= dataNursing[i].nursingCode;
								nursingName=dataNursing[i].nursingName;
								nursingType = dataNursing[i].nursingType;
								nursingId = dataNursing[i].nursingId;
								var aProcedure=nursingName+"["+nursingCode+"]";							
								arryProcedureCare.push(aProcedure);
								console.log('MasProcedureCare :',arryProcedureCare);								
								valProcedureCare=$('#gridMinorSurgery').children('tr:last').children('td:eq(1)').find(':input')[0];								
								//autocomplete(valProcedureCare, arryProcedureCare); 
								
							}
							
						
				           },
				           error: function (jqXHR, exception) {
				               var msg = '';
				               if (jqXHR.status === 0) {
				                   msg = 'Not connect.\n Verify Network.';
				               } /* else if (jqXHR.status == 404) {
				                   msg = 'Requested page not found. [404]';
				                }*/ else if (jqXHR.status == 500) {
				                   msg = 'Internal Server Error [500].';
				               } else if (exception === 'parsererror') {
				                   msg = 'Requested JSON parse failed.';
				               } else if (exception === 'timeout') {
				                   msg = 'Time out error.';
				               } else if (exception === 'abort') {
				                   msg = 'Ajax request aborted.';
				               } else {
				                   msg = 'Uncaught Error.\n' + jqXHR.responseText;
				               }
				               //alert(msg);
				           }
					});
					 
					
			
			        });
			
		}
		
		var nursingNo = '';
		var brandName='';
		function populateNursing(val, inc,item) {
		   
			if (val != "") {
				
				var index1 = val.lastIndexOf("[");
				var indexForBrandName = index1;
				var index2 = val.lastIndexOf("]");
				index1++;
				nursingNo = val.substring(index1, index2);
				
				var indexForBrandName = indexForBrandName--;
				brandName = val.substring(0, indexForBrandName);
				
				
				if (nursingNo == "") {
					
					return false;
				} else {
					
				
				 $(item).closest('tr').find("td:eq(6)").find(":input").val(nursingNo);
				 checkMsName(brandName);
					return true;

				}

			} else {
				return false;
			}
		}
		
		
		function checkMsName(value){		
				
			var param={"msName":value,"visitId":visitId};
			//alert(JSON.stringify(param));
			jQuery.ajax({
				crossOrigin : true,
				method : "POST",
				crossDomain : true,
				url : "validateMinorSurgery",
				data : JSON.stringify(param),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(result) {
					if (result.status == 1) {
						alert(result.msg);
						$("#minor"+j).val('');						
						
					} 

				}

			});
			
			
		}
		
		var nursingItemIdValue= '';
		 var nursingValue = '';
		 var nursingType = '';
		 function calucateNursingValue(nursingItem){
			 //alert("autovalue"+autoNursingNo.length);
			  
			  for(var i=0;i<autoNursingNo.length;i++){
				  
				  var nursingC = dataNursing[i].nursingCode;
				  
				  if(nursingC == nursingNo){
					  nursingValue = dataNursing[i].nursingId;
					   nursingType = dataNursing[i].nursingType;
					  //itemIds = itemIdPrescription;
					 // alert("item id is " + nursingType )
				  }
			  }
			  
			  //console.log("item is "+item);
			  $(nursingItem).closest('tr').find("td:eq(6)").find(":input").val(nursingValue);
			  
			 
			  
		  }
				
		function Reset(){			
			$('textarea[id="minor_surgery_remarks"]').each(function(){				
			       $("textarea").val('');					
					
			    });
			
			
		}
		 
		function deleteRow(val){
			
			 if(j>1){
			j=j-1;
		}  
			 var param={procedureDtId:val.value};			 
			
		if (confirm("Do you want to delete the record ?")){
			
			/* if(val.value !=''){
			jQuery.ajax({
        	 	crossOrigin: true,
        	    method: "POST",			    
        	    crossDomain:true,
        	    url: "deleteMinorSurgery",
        	    data: JSON.stringify(param),
        	    contentType: "application/json; charset=utf-8",
        	    dataType: "json",
        	    success: function(result){
        	    	if(result.status==1){
        	    		alert(result.msg);
        	    	}
        	    	
        	    }
        	    
        	});
			
			} */
			
			if(val.value ==''){
		   if($j('#gridMinorSurgery tr').length > 1) {
			   $j(val).closest('tr').remove()
			 }
		   
			}
		}
		}
		
		function showPreveiousVital() { 
			
            popup = window.open("showPreveiousVital?patientId="+patientId+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
            popup.focus();
			
        }	
		
		function validateVitals(){
			var a = document.getElementById("height").value;
            var b = document.getElementById("ideal_weight").value;
		    var c = document.getElementById("weight").value;
		    var d = document.getElementById("temperature").value;
		    var e = document.getElementById("bp").value;
		    var f = document.getElementById("bp1").value;
		    var g = document.getElementById("pulse").value;
		    var h = document.getElementById("spo2").value;
		    var i = document.getElementById("rr").value;
		    if(a==0 && a !=''){
		    	alert("Height should be greater than 0");
		    	$("#height").val("");
		    	return false;
			 }
		    else if(b==0 && b !=''){
		    	alert("Ideal weight should be greater than 0");
		    	$("#ideal_weight").val("");
		    	return false;
			 }
		    else if(c==0 && c !=''){
		    	alert("Weight should be greater than 0");
		    	$("#weight").val("");
		    	return false;
			 }
		    else if(d==0 && d !=''){
		    	alert("Temperature should be greater than 0");
		    	$("#temperature").val("");
		    	return false;
			 }
		    else if(e==0 && e !=''){
		    	alert("Systolic BP should be greater than 0");
		    	$("#bp").val("");
		    	return false;
			 }
		    else if(f==0 && f !=''){
		    	alert("Diastolic BP should be greater than 0");
		    	$("#bp1").val("");
		    	return false;
			 }
		    else if(g==0 && g !=''){
		    	alert("Pulse should be greater than 0");
		    	$("#pulse").val("");
		    	return false;
			 }
		    else if(h==0 && h !=''){
		    	alert("Spo2 should be greater than 0");
		    	$("#spo2").val("");
		    	return false;
			 }
		    else if(i==0 && i !=''){
		    	alert("RR should be greater than 0");
		    	$("#rr").val("");
		    	return false;
			 }
		    }
			
		function saveMsDetails(){			
						
               	
        	var listofMinorDT =[];
        	
        	var dataMinorgDT='';        	
        	 var flag = false;   	
	    	var count=0;
	    	var checkedCount=0;
        	$j('#gridMinorSurgery tr').each(function(i, el) {  
        		var getcheckboxValue = document.getElementById('chk'+(i+1)).checked !=null ? document.getElementById('chk'+(i+1)).checked : false;  
        		var $tds = $(this).find('td'); 
        		
        			 if($tds.eq(3).find(":input").val() !=''){
            			 if(!document.getElementById('chk'+(i+1)).checked ){
                        alert("Please check the Checkbox");
                        flag=true;
            			 }

            			 else if((document.getElementById('chk'+(i+1)).checked) && ($tds.eq(1).find(":input").val() =='')){
                             alert("Please Enter Minor Surgery Name");
                             flag=true;
                 			 }
            			}  
            		 		
        	           	    
        	    if(getcheckboxValue){
        	    	count+=1;
        	   	
        	    }
        	    
        	    if(getcheckboxValue)    	    	
        	   {                
        	    	
        	    var surgeryNameId = $tds.eq(1).find(":input").val();
        	    var prescribedBy = $tds.eq(2).find(":input").val();
        	    var typeofAnesthesia = $tds.eq(3).find(":input").val();         	   
        	    var selectedValue = $j('#anesthesia'+i+'').find('option:selected').val();   
        	    var selectedValue1 = $j('#anesthesia'+j+'').find('option:selected').val(); 
        	    if((selectedValue =="" ) || (selectedValue1 =="" )){
        	    	
        	    	flag = true;
        	    }
  	   	        var remarks = $tds.eq(4).find(":input").val();        	    
        		var minorVal= $tds.eq(6).find(":input").val();		
        			dataMinorgDT={
        				'msId' : minorVal,
        				'prescribedById' : prescribedBy,        				
        				'anethesiaType':typeofAnesthesia,
        				'remarks':remarks,
        				'headerId':$j('#header_id').val(),
        				'userId': <%=userId%>
        				
				};
        					listofMinorDT.push(dataMinorgDT);
        					
        		}
        	    
        	    //alert(JSON.stringify(dataMinorgDT)); 
			});
        	
        	 if(count==0){
     	    	alert("Please checked atleast one checkbox");
     	    	return false;
     	    }
     	    
        	
        	
		if (flag) {
			alert("Please select Type of anesthesia");
			return;
		}
		
		
		var param = {
			"listofMinorDT" : listofMinorDT,
			'idealWeight': $j('#ideal_weight').val(),
            'height': $('#height').val(),
            'weight': $('#weight').val(),
            'varation': $('#variant_in_weight').val(),
            'temperature': $('#temperature').val(),
            'bp': $('#bp').val(),
            'bp1': $('#bp1').val(),
            'pulse': $('#pulse').val(),
            'spo2': $('#spo2').val(),
            'bmi': $('#bmi').val(),
            'rr': $('#rr').val(),
            'patientId': patientId,
            'userId': <%=userId%>
		};
		//alert(JSON.stringify(param)); 	
		jQuery.ajax({
			crossOrigin : true,
			method : "POST",
			crossDomain : true,
			url : "saveMinorSurgery",
			data : JSON.stringify(param),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(result) {
				if (result.status == 1) {
					//alert(result.msg);
					//window.location = "minorSurgeryWaitingJSP";
					window.location = "minorSurgeryResponse";

				} else if (result.status == 0) {
					alert(result.msg);
				}

			}

		});
		
	}

	function getMinorSurgeryList() {
		window.location = "minorSurgeryWaitingJSP";
	}
	
</script>

<script type="text/javascript">
function idealWeight() {
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getIdealWeight";
   
	var dataJSON={
			 
			  'height':$('#height').val(),
      		  'age':$('#ageNumber').val(),
			  'genderId':$('#genderId').val(),
			
	}
	
	
   
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify(dataJSON),
		dataType : 'json',
		timeout : 100000,
		success : function(data) {
			//console.log("SUCCESS: ", data);
			
		   	   	   if (data.status == 1) {
			//var data = data;
			//alert("value is "+data.data[0].idealWeight);
			$('#ideal_weight').val(data.data[0].idealWeight);
			$('#ideal_weight').attr("disabled","disabled");
           
			
		    }
		   	   	   else
		   	   		   {
		   	   		   	alert("Ideal Weight Not Configured")
		   	   		   	$('#ideal_weight').val();
						$('#ideal_weight').removeAttr("disabled");
		   	   		   }
			
			

		},
		error : function(e) {

			console.log("ERROR: ", e);

		},
		done : function(e) {
			console.log("DONE");
			alert("success");
			var datas = e.data;
		}
	});

 }

	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		var c = b / 100;
		var d = c * c;
		var sub = a / d;
		$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));

	}

	function checkObsistyMark() {

		if (document.getElementById('variant_in_weight').value == ''
				&& document.getElementById('variant_in_weight').value == undefined) {
			alert("Please enter Height and Varation and Weight");
		}

	}
</script>
<script type="text/javascript">
	function checkVaration() {

		var a = document.getElementById("ideal_weight").value;
		var b = document.getElementById("weight").value;

		if (parseFloat(a) > parseFloat(b)) {
			var sub = a - b;
			var cal = sub * 100 / a
			var n = cal.toFixed(2);
			$('#variant_in_weight').val("-" + n);

		} else {
			var eadd = b - a;
			var cal1 = eadd * 100 / b
			var n1 = cal1.toFixed(2);
			$('#variant_in_weight').val(n1);
		}

	}
</script>

<body>


	<!-- Begin page -->
	<div id="wrapper">

		<div class="content-page">

			<!-- Start content -->
			<div class="">
				<div class="container-fluid">

					<div class="internal_Htext">Minor Surgery Details</div>
					<!-- end row -->

					<div class="row">
						<div class="col-12">
							<div class="card">
							<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
							<input type="hidden" name="defaultProcedureValue" id="defaultProcedureValue" value="M"/>
							
								<div class="card-body">

									<form>

										<!-- Patient Detail start here--------------->


										<div class="adviceDivMain" id="button1"
											onclick="showhide(this.id)">
											<div class="titleBg" style="width: 520px; float: left;">
												<span>Patient Details </span>
											</div>
											<input class="buttonPlusMinus" tabindex="1" name=""
												id="realtedbutton1" value="+" onclick="showhide(this.id)"
												type="button">
										</div>

										<div class="hisDivHide p-10" id="newpost1">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<label for="staticEmail" class="col-sm-5 col-form-label">Service
															No</label>
														<div class="col-sm-7">
															<input type="text" class="form-control  form-control-sm"
																id="serviceNo" name="serviceNo" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<label for="staticEmail" class="col-sm-5 col-form-label">Patient
															Name</label>
														<div class="col-sm-7">
															<input type="text" class="form-control  form-control-sm"
																id="patient_name" name="patient_name" readonly>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">
														<label for="staticEmail" class="col-sm-5 col-form-label">Age</label>
														<div class="col-sm-7">
															<input type="text" class="form-control  form-control-sm"
																id="age" name="age" readonly>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">
														<label for="staticEmail" class="col-sm-5 col-form-label">Gender</label>
														<div class="col-sm-7">
															<input type="text" class="form-control  form-control-sm"
																id="gender" name="gender" readonly>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">
														<label for="staticEmail" class="col-sm-5 col-form-label">OPD
															Date</label>
														<div class="col-sm-7">
															<input type="text" class="form-control  form-control-sm"
																id="opdDate" name="opdDate" readonly>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">
														<label for="staticEmail" class="col-sm-5 col-form-label">
															Diagnosis</label>
														<div class="col-sm-7">
															<textarea class="form-control  form-control-sm"
																id="icd_diagnosis" name="icd_diagnosis" readonly></textarea>
														</div>
													</div>
												</div>


											</div>
										</div>

										<!-- Patient Detail end here--------------->




										<!-- -----  Vital start here --------- -->

										<div class="adviceDivMain" id="button2"
											onclick="showhide(this.id)">
											<div class="titleBg" style="width: 520px; float: left;">
												<span>Vitals &nbsp;&nbsp; 
												</span>
											</div>
											<input class="buttonPlusMinus" tabindex="1" name=""
												id="realtedbutton2" value="-" onclick="showhide(this.id)"
												type="button">
										</div>


										<div class="hisDivHide p-10" id="newpost2"
											style="display: block;">

											<div class="row">
												<div class="col-12 p-10"><a href="#"
													class="text-underline text-theme"
													onclick="showPreveiousVital()">Previous Vitals</a> </div>
												
												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">Height</label>

														<div class="col-md-7">
															
															<div class="input-group mb-2 mr-sm-2">
																<input name="height" id="height" type="text"
																maxlength="3" class="form-control border-input"
																onblur="idealWeight();checkBMI();" placeholder="Height"
																value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />

															    <div class="input-group-append">
															      <div class="input-group-text">cm</div>
															    </div>
															    
															  </div>
														</div>
													</div>
												</div>


												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">Ideal
															Weight</label>

														<div class="col-md-7">
																														
																<div class="input-group mb-2 mr-sm-2">
																	<input name="ideal_weight" id="ideal_weight"
																maxlength="10" onblur="checkVaration()" type="text"
																class="form-control border-input"
																placeholder="Ideal Weight"
																onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
																    <div class="input-group-append">
																      <div class="input-group-text">kg</div>
																    </div>
																    
																  </div>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">Weight</label>

														<div class="col-md-7">
																															
																<div class="input-group mb-2 mr-sm-2">
																	<input name="Weight" id="weight" type="text"
																class="form-control border-input" maxlength="10"
																onblur="checkVaration();checkBMI();"
																placeholder="Weight"
																onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
																    <div class="input-group-append">
																      <div class="input-group-text">kg</div>
																    </div>
																    
																  </div>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">Variation
															in Weight</label>

														<div class="col-md-7">
															
															<div class="input-group mb-2 mr-sm-2">
																<input name="variant_in_weight" maxlength="10"
																id="variant_in_weight" type="text"
																class="form-control border-input" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																placeholder="Variation in Weight" value="" readonly />
															    <div class="input-group-append">
															      <div class="input-group-text">%</div>
															    </div>
															    
															  </div>
														</div>
													</div>
												</div>


												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">Temperature
															</label>

														<div class="col-md-7">
															
																<div class="input-group mb-2 mr-sm-2">
																	<input name="temperature" id="temperature" type="text"
																maxlength="12" class="form-control border-input"
																placeholder="Temperature" value="" 
																onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																required>
																    <div class="input-group-append">
																      <div class="input-group-text">°F</div>
																    </div>
																    
																  </div>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label">BP </label>
														
														
														<div class="col-md-3">
															
																<input name="bp" id="bp" type="text"
																class="form-control border-input bpSlash" placeholder="Systolic"
																maxlength="3" value="" 
																onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																required>
																<span></span>
															  
														</div>
														<div class="col-md-4">
															<div class="input-group mb-2 mr-sm-2">
																<input name="bp" id="bp1" type="text" maxlength="3"
																class="form-control border-input bmiInput"
																placeholder="Diastolic" value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																required>
															    <div class="input-group-append">
															      <div class="input-group-text">mmHg</div>
															    </div>
															  </div>
														</div>

													</div>
												</div>


												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">Pulse </label>

														<div class="col-sm-7">
															<div class="input-group mb-2 mr-sm-2">
																	<input name="pulse" id="pulse" type="text" maxlength="10"
																class="form-control border-input" placeholder="Pulse" 
																value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
																    <div class="input-group-append">
																      <div class="input-group-text">/min</div>
																    </div>
																    
																  </div>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">SpO2 
														</label>

														<div class="col-sm-7">
															
																<div class="input-group mb-2 mr-sm-2">
																	<input name="spo2" id="spo2" type="text" maxlength="25"
																class="form-control border-input" 
																onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																placeholder="SpO2" value="" required>
																    <div class="input-group-append">
																      <div class="input-group-text">%</div>
																    </div>
																    
																  </div>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">BMI  </label>

														<div class="col-sm-7">
															
																
																<div class="input-group mb-2 mr-sm-2">
																	<input name="bmi" id="bmi" type="text"
																class="form-control border-input" placeholder="BMI"
																value=""
																onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																readonly>
																    <div class="input-group-append">
																      <div class="input-group-text">kg/m2</div>
																    </div>
																    
																  </div>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">

														<label class="col-sm-5 col-form-label">RR (in/min)</label>

														<div class="col-sm-7">
															
																
																<div class="input-group mb-2 mr-sm-2">
																	<input name="rr" id="rr" type="text" maxlength="3"
																class="form-control border-input" onblur="validateVitals();"
																onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																placeholder="RR" value="" required>
																    <div class="input-group-append">
																      <div class="input-group-text">/min</div>
																    </div>
																    
																  </div>
														</div>
													</div>
												</div>                                             

											</div>
										</div>
		                	<div class="adviceDivMain" id="button6"
											onclick="showhide(this.id)">
											<div class="titleBg" style="width: 520px; float: left;">
												<span> Minor Surgery Details</span>
											</div>
											<input class="buttonPlusMinus" tabindex="1" name=""
												id="realtedbutton6" value="-" onclick="showhide(this.id)"
												type="button">
										</div>


										<div class="hisDivHide p-10" id="newpost6"
											style="display: block;">
											<input type="hidden" id="header_id"> <input
												type="hidden" class="form-control border-input" value=""
												id="procedureNameNursingCare" size="55"
												name="procedureNameNursingCare" /> <input type="hidden"
												value="" id="procedureNameNursingId"
												name="procedureNameNursingId" />

											<div class="tablediv">
												<table class="table table-striped table-bordered"
													align="center" cellpadding="0" cellspacing="0">
													<tr>
														<th style="width: 80px;"></th>
														<th>Minor Surgery Name</th>
														<th>Prescribed By</th>
														<th>Type of Anesthesia</th>
														<th>Minor Surgery Remarks</th>
														<th></th>


													</tr>

													<tbody id="gridMinorSurgery">

													</tbody>
												</table>
											</div>


											<div class="row">
												<div class="col-md-12">

													<div class="btn-right-all">
														<button type="button" id="minorSubmit"
															class="btn btn-primary  " onclick="saveMsDetails();">Submit</button>
														<button type="button" class="btn btn-primary"
															onclick="getMinorSurgeryList()">Back</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>


													</div>
												</div>
											</div>
										</div>


									</form>
								</div>


							</div>

						</div>
					</div>
				</div>

			</div>

		</div>
	</div>


	<!-- ----------------Accordian  end here---------- -->

	<script>
		function showhide(buttonId) {
			if (buttonId == "button1") {
				test('realted' + buttonId, "newpost1");
			} else if (buttonId == "button2") {
				test('realted' + buttonId, "newpost2");
			} else if (buttonId == "button3") {
				test('realted' + buttonId, "newpost3");
			} else if (buttonId == "button4") {
				test('realted' + buttonId, "newpost4");
			} else if (buttonId == "button5") {
				test('realted' + buttonId, "newpost5");
			} else if (buttonId == "button6") {
				test('realted' + buttonId, "newpost6");
			} else if (buttonId == "button7") {
				test('realted' + buttonId, "newpost7");
			} else if (buttonId == "button8") {
				test('realted' + buttonId, "newpost8");
			} else if (buttonId == "button9") {
				test('realted' + buttonId, "newpost9");
			} else if (buttonId == "button10") {
				test('realted' + buttonId, "newpost10");
			} else if (buttonId == "button11") {
				test('realted' + buttonId, "newpost11");
			} else if (buttonId == "button12") {
				test('realted' + buttonId, "newpost12");
			}
		}

		function test(buttonId, newpost) {
			var x = document.getElementById(newpost);
			if (x.style.display != "block") {
				x.style.display = "block";
				document.getElementById(buttonId).value = "-";
			} else {
				x.style.display = "none";
				document.getElementById(buttonId).value = "+";
			}
		}
	</script>

<input type="hidden" id="ageNumber" name="ageNumber" value=""/>
<input type="hidden" id="genderId" name="genderId" value="">
</body>
</html>