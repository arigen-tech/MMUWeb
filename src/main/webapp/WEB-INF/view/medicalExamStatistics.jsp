<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script> --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
		
	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title>Asha Application</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->



</head>

<%
	int i = 1;
%>

<body>
<div id="wrapper">
	<div class="content-page">
		<!-- Start content -->

		<div class="container-fluid">
			<div class="internal_Htext">Medical Exam Statistics</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<form name="frm">
									
							<div class="row">								
								<div class="col-md-3">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">From Date</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" id="fromDate" name="fromDate" class="form-control calDate" placeholder="DD/MM/YYYY" />
											</div>
										</div>
									</div>															
								</div>
								
								<div class="col-md-3">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">To Date</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" id="toDate" name="toDate" class="form-control calDate" placeholder="DD/MM/YYYY" />
											</div>
										</div>
									</div>															
								</div>
								<div class="col-md-3" id="unitDiv">
							                            <div class="form-group row">							                                
							                                <label class="col-md-5 col-form-label">Unit<span class="mandate"><sup>&#9733;</sup></span></label>
							                                <div class="col-md-7">
							                                    <select class="form-control" id="unitId" name="unitId" ></select>
							                                  <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid" style="display:none"/>
							                             
							                                </div>
							                                
							                            </div>
							                        </div>
								<div class="col-md-1">
									<button class="btn btn-primary" id="searhAppointment"
												type="button" onclick="searchRequest()">Search</button>													
								</div>
								<div class="col-md-2 text-right">
									<button id="printReportButton" type="button" class="btn btn-primary"  onclick="makeUrl()">Report</button>
														
								</div>												
							</div>
							</form>
							<div class="row">
									
								</div>							
								<div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >	
		                                    
		                             		<tr>
												<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
												<td>
												 <!-- <div id=resultnavigation></div> -->
												
												</td>
												</tr>
										</table>
		                                 </div>     
		                                    <div style="float:right">
				                                    <div id="resultnavigation">
				                                    </div> 
		                                    </div> 
                                    
					
		

                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
												<tr>
													<th>S.No</th>
													<th>Medical Category</th>
													<th>Count</th>
												</tr>
											</thead>
											<tbody id="tblListOfBudgetary">
											</tbody>
										</table>							
						
								
								
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

</body>
<script>
	var nPageNo=1;
	var Status;
	var $j = jQuery.noConflict();
	
 	$j(document).ready(function()
		{
	var now = new Date();
 	now.setDate(now.getDate());
 	var day = ("0" + now.getDate()).slice(-2);
 	var month = ("0" + (now.getMonth() + 1)).slice(-2);

 	var today = (day)+"/"+(month)+"/"+now.getFullYear();

 	$j('#fromDate').val(today);
 	$j('#toDate').val(today);
	 GetHospitalList();
		});
		
function GetListMedicalStatistics(MODE)
{
	var fromDate = $j('#fromDate').val();
	var toDate = $j('#toDate').val();
	var unit = $j('#unitId').val();
	 if(MODE == 'ALL'){
		 var data = {"PN":nPageNo,"flag":"ALL","fromDate":fromDate,"toDate":toDate,"unit":unit};		
		}
	else
		{
		var data = {"PN":nPageNo,"flag":"ALL","fromDate":fromDate,"toDate":toDate,"unit":unit};
		} 
	var url = "getMasMedicalStatistics";
		
	var bClickable = false;
	GetJsonData('tblListOfBudgetary',data,url,bClickable);
} 
var unitName="";

function GetHospitalList(){
  	jQuery.ajax({
  	 	crossOrigin: true,
  	    method: "POST",			    
  	    crossDomain:true,
  	    url: "${pageContext.request.contextPath}/master/getAllHospital",
  	    data: JSON.stringify({"PN":"0","hospitalId":<%=hospitalId%>}),
  	    contentType: "application/json; charset=utf-8",
  	    dataType: "json",
  	    success: function(result){
  	    	//alert("success "+result.data.length);
  	    	var combo = "" ;
  	    	
  	    	for(var i=0;i<result.data.length;i++){
  	    		//comboArray[i] = result.data[i].departmentName;
  	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
				unitName=result.data[i].unitName;
  	    		
  	    		
  	    	}
  	    	if(result.data.length>1){
  	    		$j('#unitId').show();
  	    		$('#uid').hide();
  	    	}else{
  	    		$j('#unitId').hide();
  	    		$('#uid').show();
	    		$('#uid').val(unitName).attr('readonly','readonly');
  	    	}
  	    	jQuery('#unitId').append(combo);
  	    	document.getElementById('unitId').value = <%=hospitalId%>;
  	 	   GetListMedicalStatistics('ALL');
  	 	
  	    }
  	    
  	});
   }
 
function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count;
	var pageSize = 5;
	var i=1+pageSize*(nPageNo-1);
	
	var dataList = jsonData.data;

	 for(item in dataList){
			
			  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
			   htmlTable = htmlTable + "<tr id='"+dataList[item].disposalId+"' >";	
			  htmlTable = htmlTable + "<td >" +i+ "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].medExamCategory + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].count + "</td>";
	    	 
	    	  htmlTable = htmlTable + "</tr>";
	    i++;
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfBudgetary").html(htmlTable);	
	
	
}


function showResultPage(pageNo)
{
	
	
	nPageNo = pageNo;	
	GetListMedicalStatistics('FILTER');
	
}


function showAll()
{
	nPageNo = 1;	
	GetListMedicalStatistics('ALL');
	
}

function searchRequest() {
	
	var fDate=$j('#fromDate').val();
	var tDate=$j('#toDate').val();
	
	if(document.getElementById('fromDate').value == "" || document.getElementById('fromDate') == null){
		 alert("Please select From Date");
		 return false;
	 }
	if(document.getElementById('toDate').value == "" || document.getElementById('toDate') == null){
		 alert("Please select To Date");
		 return false;
	 }
		var fromDate = $j('#fromDate').val();
	    var toDate = $j('#toDate').val();

	 	var fd = fromDate.split("/");
		var fDate= new Date(fd[2], fd[1] - 1, fd[0])
		
		var td = toDate.split("/");
		var tDate= new Date(td[2], td[1] - 1, td[0])

	 	 if(tDate < fDate) {
	 	alert("To Date cannot be earlier than the From Date");
	 	return false;
	
 	} 
 	nPageNo=1;
 	GetListMedicalStatistics('FILTER');
}

function makeUrl(){
	var fromDate = $j('#fromDate').val();
	var toDate = $j('#toDate').val();
	var unit = $j('#unitId').val();
	
	if($j("#unitId").val() == "")
	  {
		  alert("Please select Unit");
		  retun;
		  	
	  }
	var url="${pageContext.request.contextPath}/report/printMedicalExamstatisticsReport?fromDate="+fromDate+"&toDate="+toDate+"&unitId="+unit;
	openPdfModel(url);
	
}
</script>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
