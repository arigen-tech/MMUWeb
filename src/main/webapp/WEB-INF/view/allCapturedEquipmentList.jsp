<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <%@include file="..//view/leftMenu.jsp" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">

	var nPageNo=1;
	var $j = jQuery.noConflict();
	<%
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	String requestedStatus = null;
	if(request.getAttribute("requestedStatus") != null && !request.getAttribute("requestedStatus").toString().isEmpty())
	    requestedStatus = request.getAttribute("requestedStatus").toString();
	%>

	$j(document).ready(function(){
		GetAllCapturedEquipmentChecklist('ALL');
		GetCityList();
		//GetAllMMU('ALL');

		/*$('#city').on('change', function(){
            $('#mmuName').empty().append('<option value="">--Select--</option>');
            populateMMUDetails($(this).val());
        });*/
	});

	 function getMMUList(item){
		   $j("#mmuName").empty();
		  var params;
		  if(item != ''){
			  var cityId = item.value;
			  params = {
						"cityId":cityId
				}
		  }else{
			  params = { };
		  }
		 
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url: "${pageContext.servletContext.contextPath}/master/getMmuByCityMapping",
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					 var mmuDrop="";
					if(data.status == true){
						var list = data.data;
						var mmuDrop = '';
						//$j('#mmuName').find('option').not(':first').remove();
						mmuDrop = '<option value="">--Select</option>';
						$j('#mmuName').append(mmuDrop);
						if(list.length!=null && list.length!="" && list.length>0){
							
						
						for(i=0;i<list.length;i++){
							//mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
							$('#mmuName').append($('<option/>',{'value':list[i].mmuId, 'data-reg-no': list[i].regNo}).text(list[i].mmuName));
						}
						
						}
						 
						//$j('#mmuName').append(mmuDrop);
					}				
					   else{
						mmuDrop = '<option value="">--Select</option>';
						$j('#mmuName').append(mmuDrop);
					}  
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
		}
	 
	
	
	var mmuResultData = null;
    function GetAllMMU(){
        jQuery.ajax({
            crossOrigin: true,
            method: "POST",
            crossDomain:true,
            url: "getAllMMU",
            data: JSON.stringify({"PN" : "0", "cityName":$('#city').val()}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result){
                if(result.data.length > 0){
                    mmuResultData = result.data;
                }
            }

        });
    }

	function populateMMUDetails(city){
        if(city && mmuResultData){
            for(var i=0;i<mmuResultData.length;i++){
                if(parseInt(city) == parseInt(mmuResultData[i].cityId))
                    $('#mmuName').append($('<option/>',{'value':mmuResultData[i].mmuId, 'data-reg-no': mmuResultData[i].regNo}).text(mmuResultData[i].mmuName));
            }
        }
    }

	function GetAllCapturedEquipmentChecklist(MODE){
         var reqStatus = '<%=requestedStatus%>';
         var allStatus = 'P,Q,R,V';
         if(reqStatus == 'V'){
             allStatus = 'V';
             $('#statusBlock').hide();
             $('.internal_Htext').text('List of Validated Equipment Checklist');
         }
		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo,'auditStatus': allStatus};
		 }else{
			var data = {"PN":nPageNo,'auditStatus': allStatus};
			if($('#city').val())
			    data['cityId'] = $('#city').val();
			if($('#mmuName').val())
            	data['mmuId'] = $('#mmuName').val();
            if($('#status').val())
                data['auditStatus'] = $('#status').val();
            if($('#fromDate').val())
                data['fromDate'] = $('#fromDate').val();
            if($('#toDate').val())
                data['toDate'] = $('#toDate').val();

		}
		var url = "getAllCapturedEquipmentChecklist";
		var bClickable = true;
		GetJsonData('capturedEquipmentTableList',data,url,bClickable);
	}

	function GetCityList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",
			    crossDomain:true,
			    url: "getAllCity",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "<option value=\"\">Select</option>" ;

			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';

			    	}

			    	jQuery('#city').append(combo);

			    }

			});
		}

	function makeTable(jsonData)
	{
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.data;
		for(i=0;i<dataList.length;i++){
            var status = '';
            var btnTxt = 'Audit'
            if(!dataList[i].auditStatus || dataList[i].auditStatus == 'P'){
                status = 'PENDING FOR VALIDATION';
            } else if(dataList[i].auditStatus == 'Q'){
                status = 'QUERY RAISED';
                btnTxt = 'View Detail';
            } else if(dataList[i].auditStatus == 'R'){
                status = 'RESPONDED';
            } else if(dataList[i].auditStatus == 'V'){
                status = 'VALIDATED';
            } else if(dataList[i].auditStatus == 'T'){
                status = 'PARTIALLY RESPONDED';
            }else if(dataList[i].auditStatus == 'S'){
                status = 'SAVED';
            }

            htmlTable = htmlTable+"<tr id='"+dataList[i].equipmentChecklistDetailId+"' >";
            htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
            htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuName+"</td>";
            htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].inspectionDate+"</td>";
            htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].inspectedBy+"</td>";
            htmlTable = htmlTable +"<td style='width: 150px;'>"+status+"</td>";
            htmlTable = htmlTable+"</tr>";
		}
		if(dataList.length == 0){
			htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		}

		$j("#capturedEquipmentTableList").html(htmlTable);
	}

	function executeClickEvent(equipmentChecklistDetailId,data){
	    var reqStatus = '<%=requestedStatus%>';
	    //alert(reqStatus=='V');return false;
        if(reqStatus == 'V')
            window.location = 'auditEuipmentChecklist?page=validated&detail='+equipmentChecklistDetailId;
        else window.location = 'auditEuipmentChecklist?detail='+equipmentChecklistDetailId;
    }

    function showAll(){
        nPageNo = 1;
        $('input, select').val('')
        GetAllCapturedEquipmentChecklist('ALL');
    }
     function showResultPage(pageNo){
        nPageNo = pageNo;
        GetAllCapturedEquipmentChecklist('FILTER');
    }

     function search(){
    	 var toDate = $j("#toDate").val()
 	 	var fromDate = $j("#fromDate").val();
 	 	if(fromDate ==''){
 			 alert("Please select From Date");
 			 return false;
 		 }
 		 if(toDate ==''){
 			 alert("Please select To Date");
 			 return false;
 		 }
 	 var countDate=getDateComapareValue(fromDate,toDate);
 	 if(countDate!=0){
 		 alert("To Date should not be earlier than from Date.");
 		 return false;
 	 }
        nPageNo=1;
        GetAllCapturedEquipmentChecklist('FILTER');
     }

     function generateReport(){
         var url="${pageContext.request.contextPath}/report/generateBankMasterReport";
         openPdfModel(url)
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
                <div class="internal_Htext">Audit Pending Equipment Checklist</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                                                                             
											<form class="form-horizontal" id="searchBankForm"
                                            name="searchBankForm" method="" role="form">
                                            <div class="row">
                                             <div class="col-lg-4 cl-sm-6">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">City</label>
													<div class="col-sm-7">
														<select class="form-control" id="city" name="city" onchange="getMMUList(this)"></select>
													</div>
												</div>
											</div>
                                            
                                            <div class="col-lg-4 cl-sm-6">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">MMU</label>
													<div class="col-sm-7">
														<select class="form-control" id="mmuName" name="mmuName" >
	                                                        <option value="">--Select</option>
	                                                    </select>
													</div>
												</div>
											</div>
                                            
											<div class="col-lg-4 cl-sm-6">
												<div class="form-group row" id="statusBlock">
													<label class="col-sm-5 col-form-label">Status</label>
													<div class="col-sm-7">
														<select class="form-control" id="status" name="status" >
                                                        <option value="">--Select</option>
                                                        <option value="P">Pending for Validation</option>
                                                        <!--<option value="Q">Query Raised</option>
                                                        <option value="R">Responded</option>-->
                                                        <option value="V">Validated</option>
                                                    </select>
													</div>
												</div>
											</div>
											
											<div class="col-lg-4 cl-sm-6">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">From Date</label>
													<div class="col-sm-7">
														<div class="dateHolder">
															<input type="text" readonly="true" name="fromDate" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" />
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-lg-4 cl-sm-6">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">To Date</label>
													<div class="col-sm-7">
														<div class="dateHolder">
															<input type="text" readonly="true" name="toDate" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" />
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-lg-4 cl-sm-6 clearfix">
												<button type="button" class="btn  btn-primary " onclick="search()">Search</button>
												<button type="button" class="btn  btn-primary pull-right" onclick="showAll('ALL');">Show All</button>
											</div>
											
                                        
										
									</div><br><br>
									</form>

			<div style="float:left">

                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
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
                                                <th id="th1" class ="inner_md_htext">City</th>
                                                <th id="th2" class ="inner_md_htext">MMU</th>
                                                <th id="th3" class ="inner_md_htext">Date of Inspection</th>
                                                <th id="th4" class ="inner_md_htext">Inspected By</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>

                                     <tbody class="clickableRow" id="capturedEquipmentTableList">

                     				 </tbody>
                                    </table>

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
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

