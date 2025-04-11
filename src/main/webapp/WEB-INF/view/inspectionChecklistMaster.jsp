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
		GetAllInspectionChecklist('ALL');
		GetPenaltyList();
		populateSequenceNo();
		manageSubSequence()

		$('#checklistName').bind('keypress', function (event) {
            if ($(this).val().length > 199) {
               event.preventDefault();
               return false;
            }
        }).change(function(e){
            var desc = $(this).val();
            if(desc.length > 200){
                alert('Checklist Name can be only 200 character value!');
                $(this).val('');
            }
        });
	});

	var subseq_str = ['', 'a', 'b', 'c', 'd', 'e', 'f']
	function populateSequenceNo(){
	    for(var i=1;i<=50;i++){
	        option = '<option value='+i+'>'+i+'</option>'
	        $('#sequenceNo').append(option)
	    }

	    for(var i=1;i<=6;i++){
            option = '<option value='+i+'>'+subseq_str[i]+'</option>'
            $('#subsequence').append(option)
        }
	}

	function GetAllInspectionChecklist(MODE){

		var checklistName=$("#searchChecklistName").val();
		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo, "checklistName": "", "status": ""};
		 }else{
			var data = {"PN":nPageNo, "checklistName": checklistName, "status": ""};
		}
		var url = "getAllInspectionChecklist";
		var bClickable = true;
		GetJsonData('inspectionChecklistTableList',data,url,bClickable);
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
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].checklistName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].typeOfInput+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].sequenceNo+"</td>";

				var subseq = dataList[i].subsequence;
				if(subseq){
				    subseq = subseq_str[parseInt(subseq)];
				} else {
				    subseq = '';
				}
				htmlTable = htmlTable +"<td style='width: 150px;'>"+subseq+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].penaltyCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
				htmlTable = htmlTable+"</tr>";

			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";

			}


		$j("#inspectionChecklistTableList").html(htmlTable);

	}
    var checklistId;
    var checklistid = ''
	var checklistName;
	var typeOfInput;
	var penaltyId;
	var Status;
	var sequenceNo;
	var subsequence;

	function executeClickEvent(checklistId,data)
	{
		for(j=0;j<data.data.length;j++){
			if(checklistId == data.data[j].checklistId){
				checklistId = data.data[j].checklistId;
				checklistName = data.data[j].checklistName;
				typeOfInput = data.data[j].typeOfInput;
				sequenceNo = data.data[j].sequenceNo;
				penaltyId = data.data[j].penaltyId;
				Status = data.data[j].status;
				subsequence = data.data[j].subsequence;
			}
		}
		rowClick(checklistId,checklistName,typeOfInput,sequenceNo,penaltyId,subsequence);
	}

	function rowClick(checklistId,checklistName,typeOfInput,sequenceNo,penaltyId,subsequence){
		checklistid=checklistId;
		if(!subsequence)
		    subsequence = '';
		document.getElementById("checklistName").value = checklistName;
		document.getElementById("typeOfInput").value = typeOfInput;
		document.getElementById("sequenceNo").value = sequenceNo;
		document.getElementById("penaltyId").value = penaltyId;
		document.getElementById("subsequence").value = subsequence;

		if(Status == 'Y' || Status == 'y'){
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddInspectionChecklist').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddInspectionChecklist').hide();
		}
	}


		function addInspectionChecklist(){
			if(document.getElementById('checklistName').value == null || document.getElementById('checklistName').value == ""){
				alert("Please Enter Checklist Name");
				return false;
			}

			if(document.getElementById('typeOfInput').value == null || document.getElementById('typeOfInput').value == ""){
				alert("Please Select Type of Input");
				return false;
			}

			if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value ==""){
				alert("Please Sequence No");
				return false;
			}

			$j('#btnAddInspectionChecklist').prop("disabled",true);
			var params = {
					 'checklistName': jQuery('#checklistName').val(),
					 'typeOfInput': jQuery('#typeOfInput').val(),
					 'sequenceNo': jQuery('#sequenceNo').val(),
					 'subsequence': jQuery('#subsequence').val(),
					 'penaltyId': jQuery('#penaltyId').val(),
					 'status': 'Y'
			 }

            var url = "addInspectionChecklist";
            SendJsonData(url,params);
            $j('#btnAddInspectionChecklist').attr("disabled", false);
            $('#addInspectionChecklistForm')[0].reset()
		}

		function updateInspectionChecklist(){
			if(document.getElementById('checklistName').value == null || document.getElementById('checklistName').value == ""){
                alert("Please Enter Checklist Name");
                return false;
            }

            if(document.getElementById('typeOfInput').value == null || document.getElementById('typeOfInput').value == ""){
                alert("Please Select Type of Input");
                return false;
            }

            if(document.getElementById('sequenceNo').value == null || document.getElementById('sequenceNo').value ==""){
                alert("Please Sequence No");
                return false;
            }

			$j('#btnAddInspectionChecklist').prop("disabled",true);
			var params = {
                 'checklistId': checklistid,
                 'checklistName': jQuery('#checklistName').val(),
                 'typeOfInput': jQuery('#typeOfInput').val(),
                 'sequenceNo': jQuery('#sequenceNo').val(),
                 'subsequence': jQuery('#subsequence').val(),
                 'penaltyId': jQuery('#penaltyId').val(),
                 'status': Status
			 }

            var url = "updateInspectionChecklist";
            SendJsonData(url,params);
            $j('#penaltyCode').attr('readonly', true);
            $('#addInspectionChecklistForm')[0].reset()
		}

		function updateInspectionChecklistStatus(){
			var params = {
                'checklistId': checklistid,
                'status':Status
			}
            var url = "updateInspectionChecklistStatus";
            SendJsonData(url,params);
            $('#addInspectionChecklistForm')[0].reset()
		}

		function Reset(){

			document.getElementById('searchChecklistName').value = "";

			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddInspectionChecklist').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			showAll();
		}

		function ResetForm()
		{
			$j('#checklistName').val('');
			$j('#typeOfInput').val('');
			$j('#sequenceNo').val('');
		}

		function showAll()
		{
			ResetForm();
			nPageNo = 1;
			$('#searchChecklistName').val('')
			GetAllInspectionChecklist('ALL');

			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddInspectionChecklist').show();
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;
			GetAllInspectionChecklist('FILTER');

		}

		 function search()
		 {
		 	if(document.getElementById('searchChecklistName').value == ""){
		  		alert("Please Enter Checklist Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllInspectionChecklist('FILTER');
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

    function manageSubSequence(){
        $('#sequenceNo').on('change', function(){
            var sequenceNo1 = $(this).val();

            jQuery.ajax({
                crossOrigin: true,
                method: "POST",
                crossDomain:true,
                url: "getAllInspectionChecklist",
                data: JSON.stringify({"PN" : "0", "sequenceNo": sequenceNo1}),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(result){
                    $('#subsequence').empty().append('<option value="">--Select--</option>');
                    for(var i=1;i<=6;i++){
                        var option = '<option value='+i+'>'+subseq_str[i]+'</option>';
                        $('#subsequence').append(option)
                    }
                    if (result.data.length > 0){
                        for(var j=0;j<result.data.length;j++){
                            $('#subsequence').children().each(function(){
                                if(this.value == result.data[j].subsequence){
                                    $(this).remove();
                                }
                            });
                        }
                    }
                }

            });
        })
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
                <div class="internal_Htext">Inspection Checklist Master</div>

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
													<label class="col-3 col-form-label">Checklist Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchChecklistName" id="searchChecklistName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Checklist Name">

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
                                                <th id="th1" class ="inner_md_htext">Checklist Name</th>
                                                <th id="th2" class ="inner_md_htext">Type of Input</th>
                                                <th id="th3" class ="inner_md_htext">Sequence No.</th>
                                                <th id="th3" class ="inner_md_htext">Subsequence</th>
                                                <th id="th4" class ="inner_md_htext">Penalty Code</th>
                                                <th id="th6" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>

                                     <tbody class="clickableRow" id="inspectionChecklistTableList">

                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addInspectionChecklistForm" name="addInspectionChecklistForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Sequence No.<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="sequenceNo" name="sequenceNo" >
                                                                    <option value="">--Select--</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Subsequence</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="subsequence" name="subsequence" >
                                                                    <option value="">--Select--</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Checklist Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="checklistName" name="checklistName" placeholder="Checklist Name">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Type of Input<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                    <select class="form-control" id="typeOfInput" name="typeOfInput" >
                                                                        <option value="">--Select--</option>
                                                                        <option value="DROPDOWN">DROPDOWN</option>
                                                                        <option value="TEXTFIELD">TEXTFIELD</option>
                                                                    </select>
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

														<button type="button" id="btnAddInspectionChecklist"
															class="btn  btn-primary " onclick="addInspectionChecklist();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateInspectionChecklist();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateInspectionChecklistStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateInspectionChecklistStatus();">Deactivate</button>
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

