<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
   <%@ page import="com.mmu.web.utils.ProjectUtils"%>


          
        <%--   <%@include file="..//view/leftMenu.jsp" %> --%>

                <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
				<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
				<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
					pageEncoding="ISO-8859-1"%>
                <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoPopulate.js"></script>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
       
                            <title>OPD Treatment Template</title>
               
                   
                    </head>
                    <body style="background:#ffff;">
                    
                    
   <%
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map) request.getAttribute("map");
	}
	Map<String, Object> utilMap = new HashMap<String, Object>();
	utilMap = (Map) ProjectUtils.getCurrentDateAndTime();
	String date = (String) utilMap.get("currentDate");
	String time = (String) utilMap.get("currentTime");

	String userName = "";
	if (session.getAttribute("userName") != null) {
		userName = (String) session.getAttribute("userName");
	}
	String message = "";
	if (map.get("message") != null) {
		message = (String) map.get("message");
		//out.println(message);
	}
	System.out.println("message==in jsp ===" + message);

	/* int deptId = 0;
	if(session.getAttribute("deptId") != null){
		deptId = (Integer)session.getAttribute("deptId");
	}
	String deptName="";
	if(session.getAttribute("deptName") != null){
		deptName = (String)session.getAttribute("deptName");
	}
	List<MasFrequency> frequencyList= new ArrayList<MasFrequency>();
	if(map.get("masFrequencyList") != null){
	frequencyList=(List)map.get("masFrequencyList");
	
	}
	List<OpdInstructionTreatment>opdInstructionTreatmentList=new ArrayList<OpdInstructionTreatment>();
	if(map.get("opdInstructionTreatmentList")!=null){
		opdInstructionTreatmentList=(List<OpdInstructionTreatment>)map.get("opdInstructionTreatmentList");
	} */
%>

<%
	String hospitalId = "1";
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
%>
<div class="Clear"></div>

	
<script type="text/javascript" language="javascript">

	
     
    

function submitWindow()
{
var code=document.getElementById('code').value;
var flag =true;
if(validateMetaCharacters(code)){

}

}

function closeWindow()
{
  window.close();
}


var templateCode='';
function createTemplateCode(){
	
var templateName=document.getElementById("templateName").value;
if(validateMetaCharacters(templateName)){
if(templateName.length>5){

	templateCode=templateName.substring(0,5);
document.investigationTemplate.code.value=templateCode;
//alert("tempalte code" + templateCode);
}
else{
document.treatmentTemplate.code.value=templateName;
}
}
}
	</script>
<form name="treatmentTemplate" autocomplete="off" method="post" action="">

		<input type="hidden" name=" " value="OpdTemplate" /> <input
			type="hidden" name=" " value="TemplateName" /> <input type="hidden"
			name="title" value="OpdTemplate" /> <input type="hidden" name=" "
			value="opdTemplate" /> <input type="hidden" name="hiddenValueCharge"
			id="hiddenValueCharge" /> <input type="hidden"
			name="pojoPropertyCode" value="TemplateCode" />
<div class="clear" style="margin-top:8px;"></div>
    
			<!--  <label>Template Code </label>-->

			<input type="hidden" name="code" id="code" value="" disabled="true"
				readonly="readonly" validate="Template Code,metachar,yes"
				MAXLENGTH="8" tabindex=1 />
				
				<!--  <label><span>*</span> Template	Name</label> 
				 
				 
				<input type="text" name=" " id="templateName" value=""
				onblur="createTemplateCode();" validate="Template Name,metachar,yes"
				MAXLENGTH="30" tabindex=1 /> -->
				
				
				                                <div class="row">
                                                            <div class="col-md-6">
																  <div class="form-group row">
																 <label class="col-sm-5" style="background:none;">Template Name <span class="mandate"><sup>*</sup></span></label>
																  <div class="col-sm-7">  
																      <input type="text" class="form-control" name=" " id="templateName" value=""
																		onblur="createTemplateCode();" validate="Template Name,metachar,yes"
																		MAXLENGTH="30" tabindex=1 /> 
                                                                    </div>
																 </div>
																</div>
																
																
																 <div class="col-md-6">
																  
																</div>
																
																
													 </div>
				
				

		<div class="clear"></div>
		<div class="paddingTop15"></div>
		<div id="testDiv" class="">
			<table class="table table-striped table-hover table-bordered" align="center"
											cellpadding="0" cellspacing="0">
											<tr>
												<th>Drugs Name/Drugs Code</th>
												<th scope="col">Disp. Unit</th>
												<th scope="col">Dosage<span>*</span></th>
												<th scope="col">Frequency<span>*</span></th>
												<th scope="col">Days<span>*</span></th>
												<th  style="width:7%;">Total<span>*</span></th>
												<th  style="width:7%;">Instructions</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="nomenclatureGridTemplate">
												<tr>

													<td>
														<div class="autocomplete">
															<input type="text" value="" tabindex="1" autocomplete="nope"
																id="nomenclature1Treatment"  size="77" name="nomenclature1Treatment"
																class="form-control width330"
																onblur="populatePVMSTemplate(this.value,'1',this);" />

														</div>
													</td>

													<td>
                                                    <select name="au1TreatmentTemplate" id="au1TreatmentTemplate" class="medium form-control width100" ></select>
                                                    </td>

													<td><input type="text" name="dosage1Treatment" onkeypress="return checkValidate(event);" tabindex="1" onblur="fillValueNomenclatureTemplate()"
														value="" id="dosage1Treatment" size="5" maxlength="5" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control" /></td>

													<td><select name="frequencyTemplate" id="frequencyTemplate" onchange="fillValueNomenclatureTemplate()"
														class="medium form-control">

													</select></td>

													<td><input type="text" onkeypress="return checkValidate(event);" name="noOfDays1Treatment" tabindex="1"
														id="noOfDays1Treatment" onblur="fillValueNomenclatureTemplate()"
														size="5" maxlength="3" class="form-control" /></td>

													<td><input type="text"onkeypress="return checkValidate(event);" name="total1Treatment" tabindex="1"
														id="total1Treatment" size="5" validate="total,num,no"
														onblur="treatmentTotalAlert(this.value,1)"  class="form-control"  /></td>

													<td><select name="instuctionTemplate" id="instuctionTemplate"
														class="medium form-control">

													</select></td>
													<!-- <td><input type="text" name="remarks1" tabindex="1"
														id="remarks1Treatment" size="10" maxlength="10" class="form-control" />
													</td> -->

													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNomTreatment" size="77"
														name="itemIdNomTreatment" /></td>
													<td>

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" button-type="add" value=""
															onclick="addTreatmentNomenclatureRow()" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" button-type="delete" value=""
															onclick="removeTreatmentTemplateRow(this);"
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
												<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="treatmentType" size="77"
														name="treatmentType" /></td>	
												<td style="display: none;"><input type="hidden"
														name="itemClassId" tabindex="1" id="itemClassId" size="10"
														readonly="readonly" /></td>			
												</tr>

											</tbody>
											
										</table> 
			<div class="Clear"></div>
		</div>
      <!--  <h5>NIV</h5> 
										<div class="table-responsive">
										<table class="table verticalAlignTD " align="center"
											cellpadding="0" cellspacing="0" id="dgNipGridTemplate">
											<tr>
												<th  style="width: 458px; ">NIV</th>
												<th style="width: 210px; ">Dosage<span>*</span></th>
												<th style="width: 235px; ">Frequency<span>*</span></th>
												<th style="width: 210px; ">Days<span>*</span></th>
												<th style="width: 210px; ">Total<span>*</span></th>
												<th style="width: 210px; ">Instructions</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="nipGridTemplate">
												<tr>

													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" tabindex="1" autocomplete="_off" 
																id="oldnip1"  size="77" name="oldnip1"
																class="form-control border-input width330" 
																onblur="populatePVMSforNip(this.value,'1',this);" />
																<input type="text" value="" tabindex="1" autocomplete="never" spellcheck="false"
																id="oldnip1Treatment"  size="50" name="oldnip1Treatment"
																class="form-control border-input width330 disablecopypaste" onKeyUp="getNomenClatureList(this,'populatePVMSforNipTreatment','opd','getMasStoreItemNip','newNib');" /> 
                                                        <div id="newNibForPVMSTreatment" class="autocomplete-itemsNew"></div> 
														</div>
													</td>
													                                                  
													<td style="display: none;"><input type="text" name="dispensingUnit1Treatment"
														tabindex="1" id="dispensingUnit1Treatment" size="6"
														validate="AU,string,no" readonly="readonly"  class="form-control width100"/>
													</td>
                                                    <td><input type="text" name="uomqty1"
														tabindex="1" value="" id="uomqty1" size="3"
														class="form-control width50" />
													</td>
													<td><input type="text" name="dosage1Treatment" tabindex="1"
														value="" id="dosage1Treatment" onblur="fillValueNip()" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width50 disablecopypaste" /></td>

													<td><select name="nipfrequency1Treatment" id="nipfrequency1Treatment" onchange="fillValueNip()"
														class="medium form-control width100">

													</select></td>

													<td><input type="text" name="noOfDays1Treatment" tabindex="1"
														id="noOfDays1Treatment" onblur="fillValueNip()"
														size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"   class="form-control width50 disablecopypaste" /></td>

													<td><input type="text" name="total1Treatment" tabindex="1"
														id="total1Treatment" size="5" validate="total,num,no"
														onblur="treatmentTotalAlert(this.value,1)"  class="form-control width50 disablecopypaste"  /></td>

													<td><input type="text" name="remarks1Treatment" tabindex="1"
														id="remarks1Treatment" size="10" maxlength="10"  class="form-control width100" />
													</td>

													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNomNipTreatment" size="77"
														/></td>
													<td>

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" value="" button-type="add"
															onclick="addTreatmentNipRow();" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" id="deleteNomenclature" button-type="delete" value=""
															onclick="removeRowNipTreatment(this);"
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														name="nippvmsNo1Treatment" tabindex="1" id="nippvmsNo1Treatment" size="10"
														readonly="readonly" /></td>
												</tr>

											</tbody>
											<tr>
										</table> 
										
										</div> -->

		<div class="Clear"></div>
		<div class="division"></div>
<div style="float:right;">
		<button type="button" name="add" id="addbutton" value=""
			class="button btn btn-primary"  onClick="submitWindow();" accesskey="a" tabindex=1>Save</button>
		    <button type="reset" name="Reset" id="reset" value=""
			class="button btn btn-primary" onclick="resetCheck();" accesskey="r">Reset</button>
			 <button	type="reset" name="Reset" id="reset" value="" class="button btn btn-danger"
			data-dismiss="modal" accesskey="r" /u>Close</button>
</div>
		
		<div class="Clear"></div>
		<div class="division"></div>
	                                        
		
		 
	</form>
<div class="modal" id="messageForTreatmentAlertTreatment" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeMessageTreatment();" class="close"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgForTreatmentDaysLimit" /></span> <br />
									<spring:message code="msgDesignation2" />
									&#63;


								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitTreatmentAlertTeatment"
							onClick="fillValueNomenclatureTemplate()" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<button class="btn btn-primary"
							onClick="closeMessageTreatment();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button>
					</div>
					
					
					
				</div>
			</div>
		</div>
		

<script>

var arryNomenclatureTemplate= new Array();
var val=$('#nomenclatureGridTemplate').children('tr:first').children('td:eq(0)').find(':input')[0]
oldautocomplete(val, arryNomenclatureTemplate);

</script>


<script type="text/javascript" language="javascript">

		 var autoVsPvmsNoTemplate = '';
	      var dataTreatmentTemplate='';
	      var itemIdsTreatment = '';
	      $(document).ready(
	        function getMastStoreItemTreatment(){
	    	  var pathname = window.location.pathname;
	    		var accessGroup = "MMUWeb";

	    		var url = window.location.protocol + "//"
	    				+ window.location.host + "/" + accessGroup
	    				+ "/opd/getMasStoreItemList";
	             
	    		//var data = $('employeeId').val();
	    	   // alert("radioValue" +radioValue);
	    		$.ajax({
	    			type : "POST",
	    			contentType : "application/json",
	    			url : url,
	    			data : JSON.stringify({
	    				'employeeId' : "1",
	    				'sectionId':10
	    			}),
	    			dataType : 'json',
	    			timeout : 100000,
	    			
	    			success : function(res)
	    			
	    			{
	    				dataTreatmentTemplate = res.MasStoreItemList;
	    				autoVsPvmsNoTemplate = res.MasStoreItemList;
	    				var autoList = [];
	    				for(var i=0;i<dataTreatmentTemplate.length;i++){
	    					var masItemIdValue= dataTreatmentTemplate[i];
	    					var masItemId=masItemIdValue[0];
	    					var masPvmsNo = masItemIdValue[1];
	    					var masDispUnit = masItemIdValue[3];
	    					var masNomenclature = masItemIdValue[2];
	    					var aNom=masNomenclature+"["+masPvmsNo +"]";
	    					autoList[i] = aNom;
	    					//alert("a "+a);
	    					arryNomenclatureTemplate.push(aNom);
	    					console.log('MasStoredata :',aNom);
	    					
	    					
	    				}
	    				//putPvmsValue(autoList, dataTreatmentTemplate);
	    			
	    	           },
	    	           error: function (jqXHR, exception) {
	    	               var msg = '';
	    	               if (jqXHR.status === 0) {
	    	                   msg = 'Not connect.\n Verify Network.';
	    	               } else if (jqXHR.status == 404) {
	    	                   msg = 'Requested page not found. [404]';
	    	               } else if (jqXHR.status == 500) {
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
	    	               alert(msg);
	    	           }
	    		});
	    		
	        });
	     
	      
	      var pvmsNo = '';
	      function populatePVMSTemplate(val, inc,item) {

	      	if (val != "") {
	      		var index1 = val.lastIndexOf("[");
	      		var indexForBrandName = index1;
	      		var index2 = val.lastIndexOf("]");
	      		index1++;
	      		pvmsNo = val.substring(index1, index2);
	      		var indexForBrandName = indexForBrandName--;
	      		var brandName = val.substring(0, indexForBrandName);
	      		// alert("pvms no--"+pvmsNo)

	      		if (pvmsNo == "") {
	      			// alert("pvms no1111--"+pvmsNo)
	      			// document.getElementById('nomenclature' + inc).value = "";
	      			// document.getElementById('pvmsNo' + inc).value = "";
	      			return false;
	      		}
	      		else
	      		{
	      			document.getElementById('pvmsNo' + inc).value = pvmsNo
                   
                	   var pvmsValue = '';
	      			   var dispunitIddd='';
		      		   var masFrequencyId='';
	    	  		   var  masDosage='';
	    	  		   var  masNoOfDays='';
         	     	  for(var i=0;i<autoVsPvmsNoTemplate.length;i++){
         	     		 // var pvmsNo1 = data[i].pvmsNo;
         	     		 var masItemIdValue= autoVsPvmsNoTemplate[i];
         	     		 var pvmsNo1=masItemIdValue[1];
         	     		 var itemClassId=masItemIdValue[5];
	         	     		dispunitIddd=masItemIdValue[6];
	    	     			masFrequencyId=masItemIdValue[7];
	    	     			masDosage=masItemIdValue[8];
	    	     			masNoOfDays=masItemIdValue[9];
         	     		  if(pvmsNo1 == pvmsNo){
         	     			  pvmsValue = masItemIdValue[3];//data[i].dispUnit;
         	     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
         	     			  itemIdsTreatment = itemIdPrescription;
	         	     		 
         	     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
                			var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").val();  
         	     			$('#nomenclatureGridTemplate tr').each(function(i, el) {
         	     			   var $tds = $(this).find('td')
         	  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
         	     			   var itemIdValue=$('#'+itemIdCheck).val();
         	     			   var idddd =$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
         	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
         	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
         	     			   if(itemIdCheck!=checkCurrentNomRowId && itemIdsTreatment==itemIdValue)	   
           			           {
         	     				 if(itemIdsTreatment==itemIdValue){
         	      			        $('#'+idddd).val("");
         	      			        $('#'+currentidddd).val("");
         	      			        alert("Nomenclature is already added");
         	      			        return false;
         	     				   
           			           }
           			           }
         	     			   else
         	     			   {
         	     				 $(item).closest('tr').find("td:eq(1)").find("select:eq(0)").val(dispunitIddd)
         	     				  $(item).closest('tr').find("td:eq(2)").find(":input").val(masDosage)
         	     				  $(item).closest('tr').find("td:eq(3)").find("select:eq(0)").val(masFrequencyId)
         	     				   $(item).closest('tr').find("td:eq(4)").find(":input").val(masNoOfDays)
         	       	     	     $(item).closest('tr').find("td:eq(7)").find(":input").val(itemIdsTreatment) 
         	       	     	     
         	       	     	        var itemClassIdTablet=3;
				       	          	 var itemClassIdCapusle=4;
				       	             var itemClassIdInjection=5;
				       	            if(itemClassId!=itemClassIdTablet && itemClassId!=itemClassIdCapusle && itemClassId!=itemClassIdInjection)
			       	     	    	{
			       	     	    		$(item).closest('tr').find("td:eq(5)").find(":input").val("1")
			       	     	    	}
				       	           	else
			       	     	    	{
         	       	     	     	var total = masDosage * masFrequencyId * masNoOfDays;
		       	          			var t=Math.round(total);
		       	            		$(item).closest('tr').find("td:eq(5)").find(":input").val(t)
			       	     	    	}
         	       	     	        
					       	     	     $(item).closest('tr').find("td:eq(12)").find(":input").val(itemClassId)
				       	     	    
         	     			   }	   
         	     				
         	     			}); 
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
	      
	      /*var itemIdPrescription= '';
	      function putPvmsValue(item){
	     	 
	     	  var pvmsValue = '';
	     	  for(var i=0;i<autoVsPvmsNo.length;i++){
	     		 // var pvmsNo1 = data[i].pvmsNo;
	     		 var masItemIdValue= autoVsPvmsNo[i];
	     		 var pvmsNo1=masItemIdValue[1];
	     		
	     		  if(pvmsNo1 == pvmsNo){
	     			  pvmsValue = masItemIdValue[3];//data[i].dispUnit;
	     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
	     			  itemIds = itemIdPrescription;
	     			  alert("item " + item )
	     		  }
	     	  }
	     	  //console.log("item is "+item);
	     	  
	     	  $(item).closest('tr').find("td:eq(1)").find(":input").val(pvmsValue)
	     	  $(item).closest('tr').find("td:eq(7)").find(":input").val(itemIds)
	     	  	  
	     	  
	       }*/

	      
	      /*var itemIdPrescription= '';
	      var countinves="";
	      
	      function putPvmsValue(item){
	          
	          var pvmsValue = '';
	          for(var i=0;i<autoVsPvmsNo.length;i++){
	          var masItemIdValue= autoVsPvmsNo[i];	  
	          var pvmsNo1 = masItemIdValue[1];
	         
	          if(pvmsNo1 == pvmsNo){
	          //alert(pvmsNo1)
	          pvmsValue = masItemIdValue[3];
	          itemIdPrescription = masItemIdValue[0];
	          itemIds = itemIdPrescription;
	          //alert("item id is " + itemIds )
	          $('#nomenclatureGrid tr').each(function(i1, el) {
	        	 // alert("dfsd");
	               var $tds = $(this).find('td')
	               var itemsIds=  $($tds).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
	                var itemsIdValue=$('#'+itemsIds).val();
	             
	                if(itemsIdValue==itemIds){
	                countinves="1";
	                $('#'+item.id).val("");
	                alert("Plese select another medicine.Medicine already selected.");
	                return false;
	                }
	                else{
	                	//alert("itemsIdValue"+itemsIdValue);
	                	  countinves="";
	                }
	                
	              }); 
	            }
	          }
	          if(countinves!="1"){
	          console.log("item is "+item);
	          $(item).closest('tr').find("td:eq(1)").find(":input").val(pvmsValue)
	          $(item).closest('tr').find("td:eq(8)").find(":input").val(itemIds)
	         // $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(itemIds)
	          }
	          else
	        	{
	        	  $(item).closest('tr').find("td:eq(8)").find(":input").val("")
	        	}  
	        }*/	 


	        var i=0;
	        function addTreatmentNomenclatureRow() {
	            i++;
	        	var aClone = $('#nomenclatureGridTemplate>tr:last').clone(true)
	        	aClone.find(":input").val("");
	        	aClone.find('input[type="text"]').prop('id', 'nomenclature1Treatment'+i+'');
	        	aClone.find("td:eq(7)").find(":input").prop('id', 'itemIdNomTreatment'+i+'');
	        	aClone.find("td:eq(12)").find(":input").prop('id', 'itemClassId'+i+'');
	        	//aClone.find("td:eq(7)").find("input:eq(0)").removeAttr('value', '');
	        	aClone.find("option[selected]").removeAttr("selected")
	        	aClone.clone(true).appendTo('#nomenclatureGridTemplate');
	        	var val = $('#nomenclatureGridTemplate>tr:last').find("td:eq(0)").find(":input")[0];
	        	oldautocomplete(val, arryNomenclatureTemplate);
	        	
	        }
	        
	        function addTreatmentNipRow() {
	            i++;
	        	var aClone = $('#nipGridTemplate>tr:last').clone(true)
	        	aClone.find(":input").val("");
	        	aClone.find('input[type="text"]').prop('id', 'oldnip1Treatment'+i+'');
	        	aClone.find("td:eq(7)").find(":input").prop('id', 'itemIdNomNipTreatment'+i+'');
	        	//aClone.find("td:eq(7)").find("input:eq(0)").removeAttr('value', '');
	        	aClone.find("option[selected]").removeAttr("selected")
	        	aClone.clone(true).appendTo('#nipGridTemplate');
	        	var val = $('#nipGridTemplate>tr:last').find("td:eq(0)").find(":input")[0];
	        	        	
	        }
</script>

<script type="text/javascript" language="javascript">
function getFrequencyDetail() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getMasFrequency";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.MasFrequencyList;
					var trHTML = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTML += '<option value="' + item.feq + '@'
								+ item.frequencyId + '" >' + item.frequencyName
								+ '</option>';
					});

					$('#frequencyTemplate').html(trHTML);
					$('#nipfrequency1Treatment').html(trHTML);
					
					// $('#referHospitalList').html(trHTML);
					// referHospitalList

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

var trHTMLDispUnitTemp='';
var masDispUnitListTemp="";
function getDispUnitDetailTemplate() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getMasDispUnit";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.MasItemClassList;
					masDispUnitListTemp= response.MasItemClassList;
					trHTMLDispUnitTemp = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTMLDispUnitTemp += '<option value="' + item.storeUnitId + '" >' + item.storeUnitName
								+ '</option>';
					});

					$('#au1TreatmentTemplate').html(trHTMLDispUnitTemp);
					
					
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

var trHTMLTempInstruction='';
var massTempInstructionList="";
var a=1;
function geTreatmentInstructionDataTemplate() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/geTreatmentInstruction";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.teatmentInstruction;
					massTempInstructionList= response.teatmentInstruction;
					a=2;
					trHTMLTempInstruction = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTMLTempInstruction += '<option value="' + item.instructionsName +'" >' + item.instructionsName
								+ '</option>';
					});
					
					//$('#frequency1').html(trHTMLTempInstruction);
					$('#instuctionTemplate').html(trHTMLTempInstruction);
					//$('#nipfrequency1').html(trHTMLTempInstruction);
					//$('#updateFrequencyTemp').html(trHTMLTempInstruction);
								
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
 
 </script>
 <script type="text/javascript">
 $(document).ready(function() {

	getFrequencyDetail();
	getDispUnitDetailTemplate();
	geTreatmentInstructionDataTemplate();
	
})
</script>

<script type="text/javascript" language="javascript">


 $('#addbutton').click(function() {
	 
	
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/saveTreatmentOpdTemplates";
     
		if(document.getElementById('templateName').value == "") {
            alert("Please enter Template Name");
            document.getElementById('templateName').focus(); 
            return false;
          }	
		
		/////////////////////// treatment validation part ////////////////////////////
    	var extNomenclatureFlag=true;
		var count1=0;
		var count2=0;
		var count3=0;
		var count4=0;
		var count5=0;
    	var valnomenclatureGrid='';	
    	  $('#nomenclatureGridTemplate tr').each(function(i, el) {
       	     
    		  var $tds = $(this).find('td')
       	    var treatmentName = $tds.eq(0).find(":input").val();
       	    var dosage = $tds.eq(2).find(":input").val();
       	    var frequency = $tds.eq(3).find(":input").val();
       	    var splitFrequency=frequency.split("@");
       	    var days = $tds.eq(4).find(":input").val();
       	    var instruction = $tds.eq(6).find(":input").val();
       	    var itemIdCheck = $tds.eq(7).find(":input").val();
       	    var total = $tds.eq(5).find(":input").val();
       	    //alert("item id "+itemIdCheck)
       	 if(itemIdCheck== "")
    	 {
        		alert("Please enter valid prescription name");
        		itemIdCheck.focus();
      		    return false;       	
    	 }
       	if(dosage== "" || dosage==0)
  	    {
      		alert("Dosage should be greater than 0 under Drugs template");
      		dosage.focus();
     		return false;      	
  		}
       	if(splitFrequency[1]== "")
   	    {
       		alert("Please select Frequency");
       		frequency.focus();
     		return false;       	
   		}
    	if(days== "")
   	    {
       		alert("Please Enter No. of Days");
       		frequency.focus();
     		return false;       	
   		}
    	if(total== "" || total==0)
   	    {
       		alert("Total should be greater than 0 under Drugs template");
       		total.focus();
     		return false;       	
   		}
    	
       /* 	if(days== "")
   	    {
       		alert("Please Enter Days");
       		extNomenclatureFlag = false;
       		count4+=1;       	
   		}  */
       	/*  if(count1!=0 && count2!=0){
       		  return false;
       	 } */
       	 /* if(count1!=0)
       	{
       		 
       		 return false;	 
       	}
       	if(count2!=0)
        {
        	return false;	 
        }
       	if(count3!=0)
        {
        	return false;	 
        }
       	if(count4!=0)
        {
        	return false;	 
        } */
         });
         if(extNomenclatureFlag == false){
       	  return;
         }	
         
		
		var tableDataPrescrption = [];  
    	var dataPresecption='';
    	var idforTreat='';
	$('#nomenclatureGridTemplate tr').each(function(i, el) {
		idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
    {
	var $tds = $(this).find('td')
  	var itemIdPresc = $tds.eq(7).find(":input").val();
	var dosage = $tds.eq(2).find(":input").val();
	var frequency = $tds.eq(3).find(":input").val();
	var splitFrequency=frequency.split("@");
	var noofdays = $tds.eq(4).find(":input").val();
	var total = $tds.eq(5).find(":input").val();
	var instruction = $tds.eq(6).find(":input").val();
	
	dataPresecption={
			'itemId' : itemIdPresc,
			'dosage' : dosage,
			'frequencyId' : splitFrequency[1],
			'noOfDays' : noofdays,
			'total' : total,
			'instruction' : instruction,
		}
	tableDataPrescrption.push(dataPresecption)
    }
  });	
		
	 var dataJSON = {
	 'templateCode' : templateCode,
	 'templateName' : $('#templateName').val(),
	 'templateType' : "T",
	 'doctorId' : <%=userId%>,
	 'userId' : <%=userId%>,
	 'hospitalId' : <%=hospitalId%>,
	 "listofTreatmentTemplate" : tableDataPrescrption
	 }
	 $("#addbutton").attr("disabled", true);
	 $.ajax({
	 type : "POST",
	 contentType : "application/json",
	 url : url,
	 data : JSON.stringify(dataJSON),
	 dataType : 'json',
	 timeout : 100000,
	 success : function(msg) {
	 console.log("SUCCESS: ", msg);
	 if (msg.status == 1)
 	   {
		   alert("OPD Treatment Template Details Inserted successfully");
		   getTreatmentTemplateDetail();
		   $j('#exampleModal .modal-body').empty();		   
		   $('#exampleModal .modal-body').load("createTreatmentTemplate?employeeId="+<%= userId %>);
		  
	   }
	   else if(msg.status == 0)
	   {
		 $("#addbutton").attr("disabled", false);
		 alert(msg.msg)	 
	   }
		
	  else
	  {
		  $("#addbutton").attr("disabled", false);
		  alert(msg.status)
	   }
	  
	 },
	 error: function (jqXHR, exception) {
         var msg = '';
         if (jqXHR.status === 0) {
             msg = 'Not connect.\n Verify Network.';
         } else if (jqXHR.status == 404) {
             msg = 'Requested page not found. [404]';
         } else if (jqXHR.status == 500) {
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
         alert(msg);
     },
	 });
});

 function removeRowNipTreatment(val){
		
		if($('#nipGridTemplate tr').length > 1) {
			   $(val).closest('tr').remove()
			 }

	}
 var nipPvmsNo1 = '';
 function populatePVMSforNipTreatment(val,inc,item) {
 	//alert("called");
 	if (val != "") {
 		
 		var index1 = val.lastIndexOf("[");
 		var indexForBrandName = index1;
 		var index2 = val.lastIndexOf("]");
 		index1++;
 		nipPvmsNo1 = val.substring(index1, index2);
 		var indexForBrandName = indexForBrandName--;
 		var brandName = val.substring(0, indexForBrandName);
 		// alert("pvms no--"+pvmsNo)

 		if (nipPvmsNo1 == "") {
 			// alert("pvms no1111--"+pvmsNo)
 			// document.getElementById('nomenclature' + inc).value = "";
 			// document.getElementById('pvmsNo' + inc).value = "";
 			return false;
 		} else {
 			//document.getElementById('nippvmsNo' + inc).value = nipPvmsNo
 			 var itemIdNipPrescription= '';
 			  var nipPvmsValue = '';
 				  for(var i=0;i<nipDataforItem.length;i++){
 					var nipItemIdValue= nipDataforItem[i].itemId;
 					  if(nipItemIdValue == nipPvmsNo1){
 						
 						  itemIdNipPrescription =nipItemIdValue //data[i].itemId;
 						  var checkCurrentNomRowIdNip=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
               			  var checkCurrentNomRowValNip=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").val();  
               			 $('#nipGrid tr').each(function(i, el) {
       	     			   var $tds = $(this).find('td')
       	  			       var itemIdCheckNip=  $($tds).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
       	     			   var itemIdValueNip=$('#'+itemIdCheckNip).val();
       	     			   var iddddNip =$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
       	     			   var currentiddddNip=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
       	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
       	     			 
       	     			   if(itemIdCheckNip!=checkCurrentNomRowIdNip && itemIdNipPrescription==itemIdValueNip)	   
         			        {
       	     				 
       	     				 if(itemIdNipPrescription==itemIdValueNip){
       	      			        $('#'+iddddNip).val("");
       	      			        $('#'+currentiddddNip).val("");
       	      			        alert("NIP is already added");
       	      			        return false;
       	     				   
         			           }
         			           }
       	     			   else
       	     			   {
       	     			  $(item).closest('tr').find("td:eq(7)").find(":input").val(itemIdNipPrescription)
       	 				   
       	     			   }	   
       	     				
       	     			}); 
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
 
 
 function removeTreatmentTemplateRow(val){
		if($('#nomenclatureGridTemplate tr').length > 1) {
		   $(val).closest('tr').remove()
		 }
	}
 
 function noOfDaysAlertTreatment(val,item)
 {
	    var fiftenDays=resourceJSON.msgForfiftenDays;
		var thirtyDays=resourceJSON.msgForthirtyDays;
		
		var noofdays = val;	
		if(parseFloat(noofdays) > parseFloat(fiftenDays) && parseFloat(noofdays) < parseFloat(thirtyDays))
		{
			$('#messageForTreatmentAlertTreatment').show();
			$('.modal-backdrop').show();
			return false;
		
		}
		if(parseFloat(noofdays) > parseFloat(thirtyDays))
		{
 		alert("You can not prescribe more than 30 days.")
 		
 		$('#nomenclatureGridTemplate tr').each(function(i, el) {
 			var $tds = $(this).find('td')
 			var noofdaysId = $(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
 			 $(item).closest('tr').find("td:eq(4)").find(":input").val("")
 			
 			return false;
 		});
 	}
	fillValueNomenclatureTemplate();	
 }
 
 function closeMessageTreatment(){
	
	 $('#messageForTreatmentAlertTreatment').hide();
		
		
	}
 
 </script>

</body>
</html>
