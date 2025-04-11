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
		GetAllCapturedEquipmentList('ALL');
		GetCityList();

	});

	function GetAllCapturedEquipmentList(MODE){

		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo};
		 }else{
			var data = {"PN":nPageNo, "cityId": $('#city').val()};
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


	function GetZoneListByCity(cityId){

		$j("#zone").empty();
		if(cityId !=''){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",
		    crossDomain:true,
		    url: "getAllZone",
		    data: JSON.stringify({"PN" : "0","cityId":cityId}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "<option value=\"\">Select</option>" ;

		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].zoneId+'>' +result.data[i].zoneName+ '</option>';

		    	}

		    	jQuery('#zone').append(combo);

		    }

		});
	 }
	}

	function makeTable(jsonData)
	{
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.data;


		for(i=0;i<dataList.length;i++)
			{

			 if(dataList[i].status == 'Y' || dataList[i].status == 'y')
					{
						var Status='Active'
					}
				else
					{
						var Status='Inactive'
					}

				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].inspectionDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].inspectedBy+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><button id='viewCapturedEquipmentDetails' type='button' data-toggle='modal' data-target='#equipmentChecklistDetailModal' class='btn  btn-primary'>View</button></td>";
				htmlTable = htmlTable+"</tr>";

			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";

			}


		$j("#capturedEquipmentTableList").html(htmlTable);

	}

		function showAll()
		{
			nPageNo = 1;
			$('input, select').val('')
			GetAllCapturedEquipmentList('ALL');
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;
			GetAllCapturedEquipmentList('FILTER');

		}

		 function search()
		 {
		 	nPageNo=1;
		 	GetAllCapturedEquipmentList('FILTER');
		 }

		 function generateReport()
		 {
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
                <div class="internal_Htext">Captured Equipment Checklist List</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchBankForm"
												name="searchBankForm" method="" role="form">
												<div class="form-group row">
													<label class="col-2 col-form-label">City</label>
													<div class="col-3">
														<select class="form-control" id="city" name="city" ></select>
													</div>

													<label class="col-2 col-form-label">MMU</label>
                                                    <div class="col-3">
                                                        <select class="form-control" id="mmuName" name="mmuName" >
                                                            <option value="">--Select</option>
                                                        </select>
                                                    </div>

												</div>

												<div class="form-group row">
                                                    <label class="col-2 col-form-label">From Date</label>
                                                    <div class="col-3">
                                                        <input type="text" readonly="true" name="fromDate" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" />
                                                    </div>

                                                    <label class="col-2 col-form-label">To Date</label>
                                                    <div class="col-3">
                                                        <input type="text" readonly="true" name="toDate" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" />
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-md-12">
                                                            <button type="button" class="btn  btn-primary "
                                                                onclick="search()">Search</button>
                                                        </div>
                                                    </div>
												</div>
											</form>

										</div>
										<div class="col-md-4">
											<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												<!-- <button type="button" class="btn  btn-primary "
												id="printReportButton"
													onclick="generateReport()">Reports</button> -->
											</div>
										</div>
									</div>


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
                                                <th id="th5" class ="inner_md_htext">View Detail</th>
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

<div id="equipmentChecklistDetailModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Captured Equipment Checklist Details</h4>
      </div>
      <div class="modal-body">
        <p>Under Construction...</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

