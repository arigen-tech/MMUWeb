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
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		GetAllEquipmentChecklist('ALL');
		GetPenaltyList()

		$('#instrumentCode').bind('keypress', function (event) {
            var regex = new RegExp("^[a-zA-Z0-9\b]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (!regex.test(key) || $(this).val().length > 9) {
               event.preventDefault();
               return false;
            }
        }).change(function(e){
            var code = $(this).val();
            if(code.length > 10){
                alert('Instrument Code can be only 10 alphanumeric character value!');
                $(this).val('');
            }
        });

        $('#instrumentName').bind('keypress', function (event) {
            if ($(this).val().length > 199) {
               event.preventDefault();
               return false;
            }
        }).change(function(e){
            var desc = $(this).val();
            if(desc.length > 200){
                alert('Instrument Name can be only 200 character value!');
                $(this).val('');
            }
        });

        $('#quantity').keypress(function (e) {
           var charCode = (e.which) ? e.which : event.keyCode
           if (String.fromCharCode(charCode).match(/[^0-9]/g) || $(this).val().length > 3)
               return false;
        }).change(function(e){
            var amt = $(this).val();
            if(amt.length > 4){
                alert('Quantity for MMY can be only 4 digit number!');
                $(this).val('');
            }
        });
	});

	function GetAllEquipmentChecklist(MODE){

		var instrumentName=$("#searchInstrumentName").val();
		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo, "instrumentName": "", "status": ""};
		 }else{
			var data = {"PN":nPageNo, "instrumentName": instrumentName, "status": ""};
		}
		var url = "getAllEquipmentChecklist";
		var bClickable = true;
		GetJsonData('instrumentTableList',data,url,bClickable);
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

				htmlTable = htmlTable+"<tr id='"+dataList[i].checklistId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].sequenceNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].instrumentCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].instrumentName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].quantity+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].penaltyCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
				htmlTable = htmlTable+"</tr>";

			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";

			}


		$j("#instrumentTableList").html(htmlTable);

        $j('#btnAddEquipmentChecklist').attr("disabled", false);
	}
    var checklistId;
    var checklistid = ''
    var sequenceNo;
	var instrumentName;
	var quantity;
	var penaltyId;
	var Status;

	function executeClickEvent(checklistId,data)
	{
		for(j=0;j<data.data.length;j++){
			if(checklistId == data.data[j].checklistId){
				checklistId = data.data[j].checklistId;
				sequenceNo= data.data[j].sequenceNo;
				instrumentCode = data.data[j].instrumentCode;
				instrumentName = data.data[j].instrumentName;
				quantity = data.data[j].quantity;
				penaltyId = data.data[j].penaltyId;
				Status = data.data[j].status;
			}
		}
		rowClick(sequenceNo,checklistId,instrumentCode,instrumentName,quantity,penaltyId, Status);
		$('#instrumentCode').attr('readonly', true);
	}

	function rowClick(sequenceNo,checklistId,instrumentCode,instrumentName,quantity,penaltyId, Status){
		checklistid=checklistId;
		document.getElementById("sequenceNo").value = sequenceNo;
		document.getElementById("instrumentCode").value = instrumentCode;
		document.getElementById("instrumentName").value = instrumentName;
		document.getElementById("quantity").value = quantity;
		document.getElementById("penaltyId").value = penaltyId;

		if(Status == 'Y' || Status == 'y'){
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddEquipmentChecklist').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddEquipmentChecklist').hide();
		}
	}


		function addEquipmentChecklist(){

			if(document.getElementById('instrumentCode').value == null || document.getElementById('instrumentCode').value == ""){
				alert("Please Enter Instrument Code");
				return false;
			}

			if(document.getElementById('instrumentName').value == null || document.getElementById('instrumentName').value == ""){
				alert("Please Enter Instrument Name");
				return false;
			}

			if(document.getElementById('quantity').value == null || document.getElementById('quantity').value ==""){
				alert("Please Enter Quantity");
				return false;
			}
			if(document.getElementById('penaltyId').value == null || document.getElementById('penaltyId').value ==""){
				alert("Please Select Penalty Code");
				return false;
			}
			 if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value ==""){
	                alert("Please Sequence No");
	                return false;
	            }


			$j('#btnAddEquipmentChecklist').prop("disabled",true);
			var params = {
					 'sequenceNo': jQuery('#sequenceNo').val(),
					 'instrumentCode': jQuery('#instrumentCode').val(),
					 'instrumentName': jQuery('#instrumentName').val(),
					 'quantity': jQuery('#quantity').val(),
					 'penaltyId': jQuery('#penaltyId').val(),
					 'status': 'Y'
			 }

			$j('#btnAddEquipmentChecklist').attr("disabled", true);
            var url = "addEquipmentChecklist";
            SendJsonData(url,params);
            $('#addInstrumentForm')[0].reset()
		}

		function updateEquipmentChecklist(){
			if(document.getElementById('instrumentCode').value == null || document.getElementById('instrumentCode').value == ""){
                alert("Please Enter Instrument Code");
                return false;
            }

            if(document.getElementById('instrumentName').value == null || document.getElementById('instrumentName').value == ""){
                alert("Please Enter Instrument Name");
                return false;
            }

            if(document.getElementById('quantity').value == null || document.getElementById('quantity').value ==""){
                alert("Please Enter Quantity");
                return false;
            }
            if(document.getElementById('penaltyId').value == null || document.getElementById('penaltyId').value ==""){
                alert("Please Select Penalty Code");
                return false;
            }
            
            if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value ==""){
                alert("Please Sequence No");
                return false;
            }

			$j('#btnAddEquipmentChecklist').prop("disabled",true);
			var params = {
                 'checklistId': checklistid,
                 'sequenceNo': jQuery('#sequenceNo').val(),
                 'instrumentCode': jQuery('#instrumentCode').val(),
                 'instrumentName': jQuery('#instrumentName').val(),
                 'quantity': jQuery('#quantity').val(),
                 'penaltyId': jQuery('#penaltyId').val(),
                 'status': 'Y'
			 }
            jQuery('#instrumentCode').attr('readonly', false);
            var url = "updateEquipmentChecklist";
            SendJsonData(url,params);
            $('#addInstrumentForm')[0].reset()
            $('#btnAddEquipmentChecklist').show().attr('disabled', false);
            $('#updateBtn').hide();
            $('#btnInActive').hide();
		}

		function updateEquipmentChecklistStatus(){
			var params = {
                'checklistId': checklistid,
                'status':Status
			}
            var url = "updateEquipmentChecklistStatus";
            SendJsonData(url,params);
            $('#addInstrumentForm')[0].reset()
		}

		function Reset(){

			document.getElementById('searchInstrumentName').value = "";

			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddEquipmentChecklist').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#instrumentCode').attr('readonly', false);
			showAll();
		}

		function ResetForm()
		{
			$j('#instrumentCode').val('');
			$j('#instrumentName').val('');
			$j('#quantity').val('');
		}

		function showAll()
		{
			ResetForm();
			nPageNo = 1;
			$('#searchInstrumentName').val('')
			GetAllEquipmentChecklist('ALL');

			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddEquipmentChecklist').show();
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;
			GetAllEquipmentChecklist('FILTER');

		}

		 function search()
		 {
		 	if(document.getElementById('searchInstrumentName').value == ""){
		  		alert("Please Enter Instrument Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllEquipmentChecklist('FILTER');
		 }

		 function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateBankMasterReport";
			 openPdfModel(url)

		 }

		 function GetPenaltyList(){
                 jQuery.ajax({
                     crossOrigin: true,
                     method: "POST",
                     crossDomain:true,
                     url: "getAllPenalty",
                     data: JSON.stringify({"PN" : "0", "status": "Y", "withExpiredRecords": "true"}),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function(result){
                         var combo = "<option value=\"\">--Select--</option>" ;
                         for(var i=0;i<result.data.length;i++){
                             combo += '<option value='+result.data[i].penaltyId+'>' +result.data[i].penaltyCode+ '</option>';
                         }

                         jQuery('#penaltyId').append(combo);
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
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Equipment Checklist Master</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchEquipmentChecklistForm"
												name="searchEquipmentChecklistForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Instrument Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchInstrumentName" id="searchInstrumentName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Instrument Name">

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
                                            	<th id="th1" class ="inner_md_htext">Sequence No</th>
                                                <th id="th1" class ="inner_md_htext">Instrument Code</th>
                                                <th id="th2" class ="inner_md_htext">Instrument Name</th>
                                                <th id="th3" class ="inner_md_htext">Quantity</th>
                                                <th id="th4" class ="inner_md_htext">Penalty Code</th>
                                                <th id="th6" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>

                                     <tbody class="clickableRow" id="instrumentTableList">

                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addInstrumentForm" name="addInstrumentForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Instrument Code" class=" col-form-label inner_md_htext" >Instrument Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="instrumentCode" name="instrumentCode" placeholder="Instrument Code">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Instrument Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="instrumentName" name="instrumentName" placeholder="Instrument Name">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Quantity for MMU<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="quantity" name="quantity" placeholder="Quantity">
                                                            </div>
                                                        </div>
                                                    </div>

                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Penalty Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="penaltyId" name="penaltyId" >

                                                                </select>
														</div>
                                                      </div>
                                                 </div>
                                                 
                                                  <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Sequence No<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="sequenceNo" name="sequenceNo" placeholder="sequenceNo">
                                                            </div>
                                                        </div>
                                                    </div>
                                                  <!--
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Sequence No.<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="sequenceNo" name="sequenceNo" >
                                                                    <option value="">--Select--</option>
                                                                     	<option value="1">1</option>
																		<option value="2">2</option>
																		<option value="3">3</option>
																		<option value="4">4</option>
																		<option value="5">5</option>
																		<option value="6">6</option>

                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    -->
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

														<button type="button" id="btnAddEquipmentChecklist"
															class="btn  btn-primary " onclick="addEquipmentChecklist();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateEquipmentChecklist();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateEquipmentChecklistStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateEquipmentChecklistStatus();">Deactivate</button>
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

