<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>
<script type="text/javascript">
var nPageNo=1;
var $j = jQuery.noConflict();
    var allMMU = '';
    var mappedData = '';
    
    $j(document).ready(function(){
        getMMUList();
        getCityList();
        GetAllCityMmuMapping('ALL');
        getMasPhase();
        //getMappedList();
/* 
        $('#cityList').on('change', function(e){
            $('#mmuList').empty();
            $('#selectedMmuList').empty();
            var selectedCityId = $(this).val();
            if(selectedCityId && allMMU && allMMU.length > 0){
                var mappedMMUs = [];
                if(mappedData){
                    var mappedCityMMUs = mappedData.filter(function(e){
                        if(e.cityId == selectedCityId)
                            mappedMMUs.push(e.mmuId);
                        return e.cityId == selectedCityId;
                    });
                }
                var cityMmus = allMMU.filter(function(e){
                    return e.cityId == selectedCityId;
                });
                $('#mmuList').empty();
                $('#selectedMMU').empty()
                $.each(cityMmus, function(i, e){
                    if(mappedMMUs.includes(e.mmuId))
                        $('#selectedMMU').append($('<option/>').attr('disabled', true).val(e.mmuId).text(e.mmuName));
                    else $('#mmuList').append($('<option/>').val(e.mmuId).text(e.mmuName));
                });
            }
        });
 */
        $('#addkey').on('click', function(e){
            $('#selectedMMU').append($('#mmuList option:selected'));
            $('#mmuList option:selected').remove();
        });

        $('#removeKey').on('click', function(e){
            $('#mmuList').append($('#selectedMMU option:selected'));
            $('#selectedMMU option:selected').remove();
        });

        $('#add').on('click', function(e){
            addCityMmuMapping();
        });

        $('#reset').on('click', function(e){
            $('#cityList').val('').trigger('change');
            $('#selectedMMU').empty();
            //$('#status').val('');
            
        	$j("#btnActive").hide();
    		$j("#btnInActive").hide();
    		$j('#updateBtn').hide();
    		$j('#add').show();
    		 
    		$j('#cityList').attr('readonly', false);
    		 
    		 $('#mmusingleSelect').hide();
    		 $('#mmulistMultiple').show();
    		 $j('#mmulistsingle').attr('readonly', false);
    		 
        });
        
        $j("#btnActive").hide();
		$j("#btnInActive").hide();		
		$j('#updateBtn').hide();	
		$j('#mmulistMultiple').show();
		$j('#cityList').attr('readonly', false);
		$j('#mmulistsingle').attr('readonly', false);
    });

    function getMappedList(){
        jQuery.ajax({
            crossOrigin: true,
            method: "GET",
            crossDomain:true,
            url: "getAllCityMMUPhaseMapping",
            data: JSON.stringify({"PN" : "0","cityMmuPage":"1"}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(result){
                if(result)
                    mappedData = result.data;
            }
        });
        return mappedData;
    }
    
    
    function makeTable(jsonData){
        var htmlTable = "";
        var data = jsonData.count;
        var pageSize = 5;
        var dataList = jsonData.data;

        for(i=0;i<dataList.length;i++){
               var status = 'Active';
                if(dataList[i].status == 'I')
                    var status='Inactive';

                htmlTable = htmlTable+"<tr id='"+dataList[i].cityMmuInvoiceMappingId+"' >";
                htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
                htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuName+"</td>";
                htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].phaseName+"</td>";
                htmlTable = htmlTable +"<td style='width: 100px;'>"+status+"</td>";
                htmlTable = htmlTable+"</tr>";
            }
        if(dataList.length == 0){
            htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
        }
        $j("#cityMmuMappingTableList").html(htmlTable);
    }

    var cityMmuInvoiceMappingId;
    var cityId;
    var mmuId;
    var phaseId;
    var status;

    function executeClickEvent(cityMmuInvoiceMappingId,data){
        for(j=0;j<data.data.length;j++){
            if(cityMmuInvoiceMappingId == data.data[j].cityMmuInvoiceMappingId){
            	cityMmuInvoiceMappingId = data.data[j].cityMmuInvoiceMappingId;
                cityId = data.data[j].cityId;
                mmuId = data.data[j].mmuId;
                phaseId = data.data[j].phaseId;
                status = data.data[j].status;
            }
        }
        rowClick(cityMmuInvoiceMappingId,cityId,mmuId,status,phaseId);
    }
    
	 
    function rowClick(cityMmuInvoiceMappingId,cityId,mmuId,status,phaseId){
    	cityMmuInvoiceMappingId=cityMmuInvoiceMappingId;
    	cityId=cityId;
    	status=status;
    	mmuId=mmuId;
    	phaseId=phaseId;
    	$j('#mmulistMultiple').hide();
         $j('#mmusingleSelect').show();
         $j('#cityMmuInvoiceMappingIdV').val(cityMmuInvoiceMappingId);
    	document.getElementById("cityList").value = cityId;
		document.getElementById("mmulistsingle").value = mmuId;
		document.getElementById("masPhase").value = phaseId;
		 
    	if(status == 'A' || status == 'a'){	
    		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#add').hide();
			//$j('#cityList').attr('readonly', true);
			//$j('#mmulistsingle').attr('readonly', true);
    	}
		if(status == 'I' || status == 'i'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#add').hide();
			$j('#cityList').attr('readonly', true);
			$j('#mmulistsingle').attr('readonly', true);
		}
		//$j('#cityList').attr('readonly', true);
    }

    function addCityMmuMapping(){

    	 if(document.getElementById('cityList').value == null || document.getElementById('cityList').value == ""){
             alert("Please Select City");
             return false;
         }
    	
        if(document.getElementById('selectedMMU').value == null || document.getElementById('selectedMMU').value == ""){
            alert("Please Select MMU List");
            return false;
        }
        if(document.getElementById('masPhase').value == null || document.getElementById('masPhase').value == ""){
            alert("Please Select Phase");
            return false;
        }

       

       /*  if(document.getElementById('status').value == null || document.getElementById('status').value ==""){
            alert("Please Select Status");
            return false;
        } */

        var params = {
             'cityId': $('#cityList').val(),
             'phaseId': $('#masPhase').val(),
             'mmus': $('#selectedMMU').val().join(),
             'status': ""
         }
        SendJsonData('addCityMmuPhaseMapping',params);
         
    }

    function showAll(){
    	 
    	nPageNo = 1;
     	$('#mmuList').empty();
     	for(var i=0;i<allMMU.length;i++){
     		$('#mmuList').append($('<option/>').val(allMMU[i].mmuId).text(allMMU[i].mmuName));
    	} 
     
 		getCityList();
        GetAllCityMmuMapping('ALL');
        $('#reset').trigger('click');
       // getMappedList();
   
    }

    function showResultPage(pageNo){
    	 
        nPageNo = pageNo;
        GetAllCityMmuMapping('FILTER');
    }

    function search(){
        if(document.getElementById('searchCityList').value == ""){
            alert("Please Select City Name");
            return false;
        }
        nPageNo=1;
        GetAllCityMmuMapping('FILTER');
    }


    function GetAllCityMmuMapping(MODE){
    	 
        var cityId=$("#searchCityList").val();
         if(MODE == 'ALL'){
                var data = {"PN": nPageNo};
         }else{
            var data = {"PN":nPageNo, "cityId": cityId};
        }
        var url = "getAllCityMMUPhaseMapping";
        var bClickable = true;
        GetJsonData('cityMmuMappingTableList',data,url,bClickable);
    }

    
    function getMMUList(){
        $.ajax({
        	crossOrigin: true,
            type : "POST",
            contentType : "application/json",
            url : '${pageContext.request.contextPath}/master/getAllMMU',
            data : JSON.stringify({"PN":"0"}),
            dataType : "json",
            cache : false,
            async: true,
            success : function(result) {
                if(result && result.data && result.data.length > 0){
                    allMMU = result.data;
                    $.each(result.data, function(i, e){
                        //$('#cityList').append($('<option/>').val(e.cityId).text(e.cityName));
                    	$('#mmuList').append($('<option/>').val(e.mmuId).text(e.mmuName));
                    	$('#mmulistsingle').append($('<option/>').val(e.mmuId).text(e.mmuName));
                    	
                    });
                }
            },
            error : function(data) {
                alert("An error has occurred while contacting the server");
            }
        });
    }

    function getCityList(){
         $j('#searchCityList').empty();
        $.ajax({
        	crossOrigin: true,
            type : "POST",
            contentType : "application/json",
            url : '${pageContext.request.contextPath}/master/getAllCity',
            data : JSON.stringify({"PN":"0"}),
            dataType : "json",
            cache : false,
            async: true,
            success : function(result) {
                if(result && result.data && result.data.length > 0){
        
                	masServiceTypeVal = '<option value="0"><strong>Select</strong></option>';
                	$('#searchCityList').append(masServiceTypeVal);
                    $.each(result.data, function(i, e){
                        $('#cityList').append($('<option/>').val(e.cityId).text(e.cityName));
                        $('#searchCityList').append($('<option/>').val(e.cityId).text(e.cityName));
                    });
                }
            },
            error : function(data) {
                alert("An error has occurred while contacting the server");
            }
        });
    }
    
	
	function ResetForm()
	{	
		 $('#cityList').val('').trigger('change');
         $('#selectedMMU').empty();
         
         
     	$j("#btnActive").hide();
 		$j("#btnInActive").hide();
 		$j('#updateBtn').hide();
 		$j('#add').show();
 		 
 		$j('#cityList').attr('readonly', false);
 		 
 		 $('#mmusingleSelect').hide();
 		 $('#mmulistMultiple').show();
 		 //getMMUList(flag);
 		//location.reload();

	}
	
	function updateCityMMU(flag){	 
		
		var params = {		
				 'cityId' :  jQuery('#cityList').val(),
				 'cityMmuInvoiceMappingIdV' : $('#cityMmuInvoiceMappingIdV').val(),
				 'phaseId': $('#masPhase').val(),
				 'mmuId':jQuery('#mmulistsingle').val(),	
				 'status':"",
		 }
	//	alert(JSON.stringify(params));
		
			    var url = "updateCityMMUPhaseMapping";
			    SendJsonData(url,params);
				//$j('#btnAddDistrict').attr("disabled", false);
				//$j('#cityCode').attr('readonly', true);
				
				ResetForm();
	}
	function updateCityMMuPhaseStatus(){
		
		 
		var params = {
				
				'cityMmuInvoiceMappingIdV':$('#cityMmuInvoiceMappingIdV').val(),			 
				 'status':status,
		 
			} 
		
		//alert(JSON.stringify(params));
			    var url = "updateCityMMuPhaseStatus";
		        SendJsonData(url,params);
		 
	     
	}
	 function getMasPhase(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "getMasPhase",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "<option value=\"\">Select</option>" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].phaseId+'>' +result.data[i].phaseName+ '</option>';
			    		
			    	}
			    	jQuery('#masPhase').append(combo);
			    }
			    
			});
		}
	 
</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">City - MMU Phase Mapping</div>

				<div class="row">
					<div class="col-12">
					 <input type="hidden" name="cityMmuInvoiceMappingIdV" id="cityMmuInvoiceMappingIdV">  
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City Name</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="searchCityList" name="searchCityList" onchange="">
												    <option value="">Select</option>
												</select>
											</div>
										</div>
										  
									</div>
									
									
									<div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="search()">Search</button>
									</div>
									<div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="showAll()">Show All</button>
									</div>
								</div>
								
								<div>
								<div style="float:left">               
                                   <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   
                                   <tr>
	                                   <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
	                                  <td></td>
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
                                                <th id="th1" class ="inner_md_htext">City</th>
                                                <th id="th2" class ="inner_md_htext">MMU</th>
                                                <th id="th3" class ="inner_md_htext">Phase</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>

                                         <tbody class="clickableRow" id="cityMmuMappingTableList">

                                         </tbody>
                                    </table>
								</div>
								
								<div class="row"  >
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">City Name</label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="cityList"  name="cityList" onchange="">
												    <option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Phase<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="masPhase" name="masPhase">
                                                                                                                                                                                            
                                                                </select>
														</div>
														</div>
                                                      </div>

									<div class="col-md-4" style="margin-left:15px;display: none" id="mmusingleSelect"> 
                                        <div class="form-group row">
                                            <div class="col-md-6">
                                                <label class="col-form-label">MMU</label>
                                            </div>
                                            <div class="col-md-6">
                                                <select class="form-control" id="mmulistsingle"  name="mmulistsingle">
                                                    <!-- <option value="">Select</option>
                                                    <option value="A">Active</option>
                                                    <option value="I">Inactive</option> -->
                                                </select>
                                            </div>
                                        </div>
                                    </div>
								</div>
								
								<div class="row" id="mmulistMultiple">
									<div class="col-md-2">
										<label class="col-form-label">MMU</label>
									</div>
									<div class="col-lg-10">
										<div class="row">
											<div class="col-sm-4 col-md-4 ">
								             	 <label><strong><spring:message code="lblallDesignation"/></strong></label> 
								             	<select multiple class="form-control height110" id="mmuList" name="mmuList">
				            			            
						                   		 </select>
						                   	</div>
													
											<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 
											    <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
											    <div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div>
											</div>
												
											<div class="col-sm-4 col-md-4 ">
                                              <label><strong><spring:message code="lblSelectedDesignation"/></strong></label>
                                              <select multiple class="form-control height110" id="selectedMMU" name="selectedMMU">
                                              </select>
				               				</div>
				               			</div>
									</div>
							</div>
							
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<input type="button"  id="add" type="button" class="btn  btn-primary " value="Add" />
									
									<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateCityMMU(this);">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateCityMMuPhaseStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateCityMMuPhaseStatus();">Deactivate</button>
														 
									
									<input type="button"  id="reset" type="button" class="btn  btn-primary " value="Reset" />
								</div>
                               </div>	
							</div>
						</div>
						
						
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->


</body>

</html>






