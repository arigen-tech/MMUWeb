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

	$j(document).ready(function()
			{
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		GetAllPenalty('ALL');
		GetCityList();

		$('#penaltyCode').bind('keypress', function (event) {
            var regex = new RegExp("^[a-zA-Z0-9\b]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (!regex.test(key) || $(this).val().length > 9) {
               event.preventDefault();
               return false;
            }
        }).change(function(e){
            var code = $(this).val();
            if(code.length > 9){
                alert('Penalty Code can be only 10 alphanumeric character value!');
                $(this).val('');
            }
        });

        $('#penaltyDescription').bind('keypress', function (event) {
            if ($(this).val().length > 199) {
               event.preventDefault();
               return false;
            }
        }).change(function(e){
            var desc = $(this).val();
            if(desc.length > 199){
                alert('Penalty Description can be only 200 character value!');
                $(this).val('');
            }
        });

        $('#penaltyAmount').keypress(function (e) {
           var charCode = (e.which) ? e.which : event.keyCode
           if (String.fromCharCode(charCode).match(/[^0-9]/g) || $(this).val().length > 5)
               return false;
        }).change(function(e){
            var amt = $(this).val();
            if(amt.length > 5){
                alert('Penalty Amount can be only 6 digit number!');
                $(this).val('');
            }
        });

    });

	function GetAllPenalty(MODE){

		var penaltyCode=$("#searchPenaltyCode").val();
		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo, "penaltyCode": "", "status": ""};
		 }else{
			var data = {"PN":nPageNo, "penaltyCode": penaltyCode, "status": ""};
		}
		var url = "getAllPenalty";
		var bClickable = true;
		GetJsonData('penaltyTableList',data,url,bClickable);
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

				htmlTable = htmlTable+"<tr id='"+dataList[i].penaltyId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].penaltyCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].penaltyDescription+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].penaltyAmount+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].startDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].endDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
				htmlTable = htmlTable+"</tr>";

			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";

			}


		$j("#penaltyTableList").html(htmlTable);

	}
    var penaltyId;
    var penaltyid = ''
	var penaltyCode;
	var penaltyAmount;
	var penaltyDescription;
	var Status;
	var startDate;
	var endDate;

	function executeClickEvent(penaltyId,data)
	{
		for(j=0;j<data.data.length;j++){
			if(penaltyId == data.data[j].penaltyId){
				penaltyId = data.data[j].penaltyId;
				penaltyCode = data.data[j].penaltyCode;
				penaltyAmount = data.data[j].penaltyAmount;
				penaltyDescription = data.data[j].penaltyDescription;
				startDate = data.data[j].startDate;
				endDate = data.data[j].endDate;
				Status = data.data[j].status;
			}
		}
		//alert('11111')
		rowClick(penaltyId,penaltyCode,penaltyAmount,penaltyDescription,Status, startDate, endDate);
	}

	function rowClick(penaltyId,penaltyCode,penaltyAmount,penaltyDescription,Status, startDate, endDate){
	    //alert('22222')
		penaltyid=penaltyId;
		document.getElementById("penaltyCode").value = penaltyCode;
		document.getElementById("penaltyAmount").value = penaltyAmount;
		document.getElementById("penaltyDescription").value = penaltyDescription;
		document.getElementById("startDate").value = startDate;
		document.getElementById("endDate").value = endDate;
        //alert('3333')
		if(Status == 'Y' || Status == 'y'){
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddPenalty').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddPenalty').hide();
		}
	}


		function addPenalty(){

			if(document.getElementById('penaltyCode').value == null || document.getElementById('penaltyCode').value == ""){
				alert("Please Enter Penalty Code");
				return false;
			}

			if(document.getElementById('penaltyDescription').value == null || document.getElementById('penaltyDescription').value == ""){
				alert("Please Enter Penalty Description");
				return false;
			}

			if(document.getElementById('penaltyAmount').value == null || document.getElementById('penaltyAmount').value ==""){
				alert("Please Enter Penalty Amount");
				return false;
			}

            var startDate = document.getElementById('startDate').value;
			if(!startDate){
                alert("Please Enter Start Date");
                return false;
            }

            var endDate = document.getElementById('endDate').value;
            if(!endDate){
                alert("Please Enter End Date");
                return false;
            }

            if(startDate && endDate){
                 var endDtArr = endDate.split('/');
                 var startDtArr = startDate.split('/');
                 var endDts = new Date(endDtArr[2], endDtArr[1]-1, endDtArr[0]);
                 var startDts = new Date(startDtArr[2], startDtArr[1]-1, startDtArr[0]);
                 var todaysDate = new Date();
                 var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
                 var newDt = todaysDate.getDate()+'/'+(todaysDate.getMonth()+1)+'/'+todaysDate.getFullYear();
                 if(endDts.getTime() < currDate.getTime()){
                     alert('End Date should not be earlier than Today`s Date!' );
                     $('#endDate').val(newDt);
                     return false;
                 }

                 if(endDts < startDts){
                     alert('End Date should not be earlier than Start Date!' );
                     $('#endDate').val(newDt);
                     return false;
                 }

            }

            if($('#startDate').val() && $('#endDate').val()){
                var sdts = $('#startDate').val().split('/');
                var startDts = new Date(sdts[2], sdts[1]-1, sdts[0]);

                var edts = $('#endDate').val().split('/');
                var endDts = new Date(edts[2], edts[1]-1, edts[0]);
                if(endDts.getTime() < startDts.getTime()){
                    alert('End Date should not be smaller than Start Date!');
                    return false;
                }
            }

			var params = {
					 'penaltyCode': jQuery('#penaltyCode').val(),
					 'penaltyDescription': jQuery('#penaltyDescription').val(),
					 'penaltyAmount': jQuery('#penaltyAmount').val(),
					 'startDate': jQuery('#startDate').val(),
					 'endDate': jQuery('#endDate').val()
			 }

			//alert(JSON.stringify(params));
            var url = "addPenalty";
            SendJsonData(url,params);
		}

		function updatePenalty(){
			if(document.getElementById('penaltyCode').value == null || document.getElementById('penaltyCode').value == ""){
				alert("Please Enter Penalty Code");
				return false;
			}

			if(document.getElementById('penaltyDescription').value == null || document.getElementById('penaltyDescription').value == ""){
				alert("Please Enter Penalty Description");
				return false;
			}

			if(document.getElementById('penaltyAmount').value == null || document.getElementById('penaltyAmount').value ==""){
				alert("Please Enter Penalty Amount");
				return false;
			}

			if(document.getElementById('startDate').value == null || document.getElementById('startDate').value ==""){
                alert("Please Enter Start Date");
                return false;
            }

            if(document.getElementById('endDate').value == null || document.getElementById('endDate').value ==""){
                alert("Please Enter End Date");
                return false;
            }

			$j('#btnAddPenalty').prop("disabled",true);
			var params = {
                 'penaltyId': penaltyid,
                 'penaltyCode': jQuery('#penaltyCode').val(),
                 'penaltyDescription': jQuery('#penaltyDescription').val(),
                 'penaltyAmount': jQuery('#penaltyAmount').val(),
                 'startDate': jQuery('#startDate').val(),
                 'endDate': jQuery('#endDate').val()
			 }

            var url = "updatePenalty";
            SendJsonData(url,params);
            $j('#penaltyCode').attr('readonly', true);
            $('#addPenaltyForm')[0].reset()
		}

		function updatePenaltyStatus(){
			var params = {
                'penaltyId': penaltyid,
                'status':Status
			}
            var url = "updatePenaltyStatus";
            SendJsonData(url,params);
            $('#addPenaltyForm')[0].reset()
		}

		function Reset(){

			document.getElementById('searchPenaltyCode').value = "";

			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddPenalty').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#penaltyCode').attr('readonly', false);
			showAll();
		}

		function ResetForm()
		{
			$j('#penaltyCode').val('');
			$j('#penaltyDescription').val('');
			$j('#penaltyAmount').val('');
			$j('#startDate').val('');
			$j('#endDate').val('');
		}

		function showAll()
		{
			ResetForm();
			nPageNo = 1;
			$('#searchPenaltyCode').val('')
			GetAllPenalty('ALL');

			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddPenalty').show();
			$j('#penaltyCode').attr('readonly', false);


		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;
			GetAllPenalty('FILTER');

		}

		 function search()
		 {
		 	if(document.getElementById('searchPenaltyCode').value == ""){
		  		alert("Please Enter Penalty Code");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllPenalty('FILTER');
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
                <div class="internal_Htext">Penalty Master</div>

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
													<label class="col-3 col-form-label">Penalty Code<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchPenaltyCode" id="searchPenaltyCode"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Penalty Code">

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
                                                <th id="th1" class ="inner_md_htext">Penalty Code</th>
                                                <th id="th2" class ="inner_md_htext">Penalty Description</th>
                                                <th id="th3" class ="inner_md_htext">Penalty Amount</th>
                                                <th id="th4" class ="inner_md_htext">Start Date</th>
                                                <th id="th5" class ="inner_md_htext">End Date</th>
                                                <th id="th6" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>

                                     <tbody class="clickableRow" id="penaltyTableList">

                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addPenaltyForm" name="addPenaltyForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Penalty Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="penaltyCode" name="penaltyCode" placeholder="Penalty Code" onkeypress=" return validateText('panaltyCode',7,'Penalty Code');">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Penalty Description<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <textarea class="form-control" id="penaltyDescription" name="penaltyDescription" placeholder="Penalty Description"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Penalty Amount<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="penaltyAmount" name="penaltyAmount" placeholder="Penalty Amount">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Start Date<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <div class="dateHolder">
                                                                    <input type="text" name="startDate" readonly="true" id="startDate" class="calDate form-control" onblur="if(isValidDate(this.value)){calculateAge()}"
                                                                    value="" placeholder="DD/MM/YYYY" />
                                                                </div>
														    </div>
                                                      </div>
                                                 </div>

                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <div class="col-sm-5">
                                                         <label for="collection name" class="col-form-label inner_md_htext">End Date<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         </div>
                                                         <div class="col-sm-7">
                                                             <div class="dateHolder">
                                                                 <input type="text" name="endDate" id="endDate" readonly="true" class="calDate form-control" onblur="if(isValidDate(this.value)){calculateAge()}"
                                                                 value="" placeholder="DD/MM/YYYY" />
                                                             </div>
                                                        </div>
                                                   </div>
                                              </div>

                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">

                                                            </div>
                                                            <div class="col-sm-7"></div>
                                                      </div>
                                                 </div>
                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">

							            </div>

                                                </div>
                                            </form>
                                        </div>

                                    </div>

         							<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

														<button type="button" id="btnAddPenalty"
															class="btn  btn-primary " onclick="addPenalty();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updatePenalty();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updatePenaltyStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updatePenaltyStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>

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
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

