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
	<%
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	%>
</script>
</head>



<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Cluster - City Mapping</div>
                <input type="hidden"  name="cityClusterId" value="" id="cityClusterId" />
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Cluster Name</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="selectClusterName" onchange="search()">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									
								<!-- 	<div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div> -->
									<div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="showAll('ALL');">Show All</button>
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
                                                <th id="th1" class ="inner_md_htext">Cluster</th>
                                                <th id="th2" class ="inner_md_htext">City</th>
                                                <th id="th3" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="clusterCityTabls">

                     				 </tbody>
                                    </table>
								</div>
								
								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Cluster Name</label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="clusterDropDown" onchange="">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">City<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="city" name="city" onchange="">

                                                                </select>
														</div>
                                                      </div>
                                                 </div>
								</div>
								
								<%-- <div class="row">
									<div class="col-md-2">
										<label class="col-form-label">City</label>
									</div>
									<div class="col-lg-10">
										<div class="row">
											<div class="col-sm-4 col-md-4 ">
								             	 <label><strong><spring:message code="lblallDesignation"/></strong></label> 
								             	<select multiple class="form-control height110" id="" name="">
				            			            
						                   		 </select>
						                   	</div>
													
											<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 
												
												<!-- <button id="addkey" class="btn btn-primary btn-sm btn-block m-t-10"><i class="fa fa-chevron-right"></i></button>
												<button id="removeKey" class="btn btn-primary btn-sm btn-block"><i class="fa fa-chevron-left"></i></button>
											 -->	
											  <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
												<div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
											</div>
												
											<div class="col-sm-4 col-md-4 ">
											 	<label><strong><spring:message code="lblSelectedDesignation"/></strong></label> 
							                      <select multiple class="form-control height110" id="" name="">
							                      </select>
				               				</div>
				               			</div>
									</div>
							</div> --%>
							
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
							   <button type="button" id="btnAddCity" class="btn  btn-primary " onclick="addCityCluster();">Add</button>
								<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateCityCluster('update');">Update</button>
									<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateCityClusterStatus('active');">Activate</button>

														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateCityClusterStatus('inactive');">Deactivate</button>

														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
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


<script type="text/javascript">
$j(document).ready(function()
		{

	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	GetClusterList();
	GetCityList();
	GetAllClusterCity('ALL');
		});

function GetClusterList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",
	    crossDomain:true,
	    url: "getAllCluster",
	    data: JSON.stringify({"PN" : "0","comboVal":"Y"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "<option value=\"\">Select</option>" ;

	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].clusterId+'>' +result.data[i].clusterName+ '</option>';

	    	}

	    	jQuery('#clusterDropDown').append(combo);
	    	jQuery('#selectClusterName').append(combo);

	    }

	});
}
function GetAllClusterCity(MODE){

	var clusterId=$("#selectClusterName").val();
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "clusterId":""};
		}else{
		var data = {"PN":nPageNo, "clusterId":clusterId};
		}
	var url = "getAllCityCluster";
	var bClickable = true;
	GetJsonData('clusterCityTabls',data,url,bClickable);
}

function showAll()
{
	ResetForm();
	nPageNo = 1;
	GetAllClusterCity('ALL');

	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddCity').show();
	$j('#cityCode').attr('readonly', false);


}
 function showResultPage(pageNo)
{
	nPageNo = pageNo;
	GetAllClusterCity('FILTER');

}

 function search()
 {
 	if(document.getElementById('selectClusterName').value == ""){
  		alert("Please Enter Cluster Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllClusterCity('FILTER');
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

				htmlTable = htmlTable+"<tr id='"+dataList[i].clusterCityId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].ClusterName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
				htmlTable = htmlTable+"</tr>";

			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

			}


		$j("#clusterCityTabls").html(htmlTable);

	}

function GetCityList(){
	 jQuery('#citySearch').empty();
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

function addCityCluster(){

	if(document.getElementById('clusterDropDown').value == null || document.getElementById('clusterDropDown').value ==""){
		alert("Please Enter Cluster Name");
		return false;
	}


	$j('#btnAddCity').prop("disabled",true);
	var params = {


			 'cityId':jQuery('#city').val(),
			 'clusterId':jQuery('#clusterDropDown').val(),
			 'cityClusterId':jQuery('#cityClusterId').val(),
			 'userId': <%= userId%>
	 }

	//alert(JSON.stringify(params));
	    var url = "addCityCluster";
	    SendJsonData(url,params);


}

function updateCityCluster(){

	if(document.getElementById('clusterDropDown').value == null || document.getElementById('clusterDropDown').value ==""){
		alert("Please Select Cluster Name");
		return false;
	}
	if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
		alert("Please Select City Name");
		return false;
	}


	var params = {
			  'cityClusterId':jQuery('#cityClusterId').val(),
			  'clusterId': $('#clusterDropDown').val(),
			  'cityId':jQuery('#city').val(),
			 'userId': <%= userId%>,
			 'status':Status
	 }
	//alert(JSON.stringify(params));
		    var url = "addCityCluster";
		    SendJsonData(url,params);
			//$j('#btnAddCity').attr("disabled", false);
			//$j('#cityCode').attr('readonly', true);
			ResetForm();
}

var clusterCityId;
var clusterId;
var cityIdVal;
var Status;
function executeClickEvent(clusterCityId,data)
{
	for(j=0;j<data.data.length;j++){
		if(clusterCityId == data.data[j].clusterCityId){
			clusterCityId=data.data[j].clusterCityId
			clusterId = data.data[j].clusterId;
			cityIdVal = data.data[j].cityId;
			Status = data.data[j].status;


		}
	}
	rowClick(clusterCityId,clusterId,cityIdVal,Status);
}

function rowClick(clusterCityId,clusterId,cityIdVal,Status){
	clusterCityId=clusterCityId;
	document.getElementById("cityClusterId").value = clusterCityId;
	document.getElementById("clusterDropDown").value = clusterId;
	document.getElementById("city").value = cityIdVal;

	if(Status == 'Y' || Status == 'y'){
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddCity').hide();
	}
	if(Status == 'N' || Status == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddCity').hide();
	}


	//$j('#cityCode').attr('readonly', true);

}

function ResetForm()
{

	$j('#clusterDropDown').val('');
	$j('#city').val('');
	//$j('#searchClusterName').val('');
	//showAll();
}

function updateCityClusterStatus(){
	var params = {

			'cityClusterId':jQuery('#cityClusterId').val(),
		     'status':Status

	}

//alert(JSON.stringify(params));
	    var url = "updateCityClusterStatus";
        SendJsonData(url,params);

	}

</script>
</body>

</html>






