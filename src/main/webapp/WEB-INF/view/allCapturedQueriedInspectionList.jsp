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
	%>

	$j(document).ready(function(){
		GetAllCapturedInspectionList('ALL');
		GetCityList();
		GetAllMMU('ALL');

		$('#city').on('change', function(){
            $('#mmuName').empty().append('<option value="">--Select--</option>');
            populateMMUDetails($(this).val());
        });
	});

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

	function GetAllCapturedInspectionList(MODE){

		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo};
		 }else{
			var data = {"PN":nPageNo};
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
		var url = "getAllCapturedInspectionChecklist";
		var bClickable = true;
		GetJsonData('capturedInspectionTableList',data,url,bClickable);
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
                }else if(dataList[i].auditStatus == 'R'){
                   status = 'RESPONDED';
                } else if(dataList[i].auditStatus == 'V'){
                   status = 'VALIDATED';
                }  else if(dataList[i].auditStatus == 'T'){
                   status = 'PARTIALLY RESPONDED';
                } else if(dataList[i].auditStatus == 'S'){
                   status = 'SAVED';
                }

                htmlTable = htmlTable+"<tr id='"+dataList[i].inspectionDetailId+"' >";
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

		$j("#capturedInspectionTableList").html(htmlTable);
	}

	function executeClickEvent(inspectionDetailId,data){
        window.location = 'responseInspectionChecklist?detail='+inspectionDetailId;
    }

    function showAll(){
        nPageNo = 1;
        $('input, select').val('')
        GetAllCapturedInspectionList('ALL');
    }
     function showResultPage(pageNo){
        nPageNo = pageNo;
        GetAllCapturedInspectionList('FILTER');
    }

     function search(){
        nPageNo=1;
        GetAllCapturedInspectionList('FILTER');
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
                <div class="internal_Htext">Response Queried MMU Inspection Checklist</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
										
										<form class="form-horizontal" id="searchBankForm" name="searchBankForm" method="" role="form">
										
                                       <div class="row">
                                             <div class="col-lg-4 cl-sm-6">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">City</label>
													<div class="col-sm-7">
														<select class="form-control" id="city" name="city" ></select>
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
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Status</label>
													<div class="col-sm-7">
														<select class="form-control" id="status" name="status" >
                                                        <option value="">--Select</option>
                                                        <option value="P">Pending for Validation</option>
                                                        <!--<option value="Q">Query Raised</option>
                                                        <option value="R">Responded</option>
                                                        <option value="T">Partially Responded</option>-->
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

                                     <tbody class="clickableRow" id="capturedInspectionTableList">

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

