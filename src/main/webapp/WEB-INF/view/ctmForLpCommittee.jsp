<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
  <%@include file="..//view/commonJavaScript.jsp"%> 
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CTM For LP Committee</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!--  <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
   
</head>
<%
long departmentId = 0;
String departmentName="";
	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  }
	  
	  %>
<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">CTM (Captain's Temporary Memorandum) for LP (Local Purchase) Committee</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<p class="submitMsg">${message}</p>
							      <form:form name="submitCtmForLP" id="submitCtmForLP" method="post"  enctype='multipart/form-data'
										action="${pageContext.request.contextPath}/lpprocess/submitCtmForLP" autocomplete="off">
									
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">From Date<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" id="fromDate" name="fromDate" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" />
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">To Date<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" id="toDate" name="toDate" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY"  value="" maxlength="10" />
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="row m-t-10">
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													
												</div>
												<div class="col-md-7">
													<label for="service" class="col-form-label m-l-5">Service Number</label>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												
												<div class="col-md-7">
														<label for="service" class="col-form-label m-l-5">Name</label>
												</div>
											</div>
										</div>
									</div>
									
									<div class="row">
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Member 1<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" id="m1ServiceNo"  name="m1ServiceNo" class="form-control check" onblur="getName('m1')"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												
												<div class="col-md-7">
													<input type="text" id="m1Name"  name="m1Name" class="form-control" readonly="readonly" />
													<input type="hidden" id="m1EmpId"  name="m1EmpId" class="form-control" readonly="readonly" />
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<span id="m1msg" style="color:red; font-weight: bold;"></span>
										</div>
									</div>
									
									<div class="row">
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Member 2<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" id="m2ServiceNo"  name="m2ServiceNo" class="form-control check" onblur="getName('m2')"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												
												<div class="col-md-7">
													<input type="text" id="m2Name"  name="m2Name" class="form-control" readonly="readonly" />
													<input type="hidden" id="m2EmpId"  name="m2EmpId" class="form-control" readonly="readonly" />
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<span id="m2msg" style="color:red; font-weight: bold;"></span>
										</div>
									</div>
									
									<div class="row">
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">President<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" id="pServiceNo"  name="pServiceNo" class="form-control check" onblur="getName('p')"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												
												<div class="col-md-7">
													<input type="text"  id="pName"  name="pName" class="form-control" readonly="readonly" />
													<input type="hidden" id="pEmpId"  name="pEmpId" class="form-control" readonly="readonly" />
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<span id="pmsg" style="color:red; font-weight: bold;"></span>
										</div>
									</div>
									
									<div class="row">
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Authority Letter No.<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" id="letterNo" name="letterNo" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-8">
													<div class="fileUploadDiv">
														<input type="file" id="fileUploadid" class="inputUpload" name="fileInvUploadDyna">
														<label class="inputUploadlabel">Choose File</label>
														<span class="inputUploadFileName">No File Chosen</span>
													</div>
												</div>
											</div>
										</div> 
									</div>
  									
  									<div class="row">
										<div class="col-md-12 text-right">
											<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1" onclick="return submitForm();" />
													<button type="reset" id="reset" class="btn  btn-danger"/> Reset </button>

										</div>
									</div>
									</form:form>
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
													<th>From Date</th>
												<th>To Date</th>
												<th>Member 1</th>
												<th>Member 2</th>
												<th>President</th>
												<th>Authority Letter No.</th>
												<th>Status</th>
												<th>View Letter</th>
												</tr>
											</thead>
											<tbody id="tblListOfctmCommittee">
											</tbody>
										</table>
									
									
									
									</div>

								</div>
							</div>
						</div>
					</div>

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

</body>
<script>

var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
	{	
	//if department not in session
   	if(<%= departmentId %>!=0){
			$j("#submitCtmForLP :input").attr("disabled", false);
			$("#saveForm1").attr("disabled", false);
			}else{
			alert("Select the department");
			$j("#submitCtmForLP :input").attr("disabled", true);
			return false;
		}
 GetCTMMemberList('ALL');
 
	});
	
function GetCTMMemberList(MODE)
{
/* var serviceNo=$j('#serviceNo').val();
var fromDate = $j('#fromDate').val();
  var toDate = $j('#toDate').val(); */
 if(MODE == 'ALL'){
	 var data = {"PN":nPageNo};		
	}
else
	{
	var data = {"PN":nPageNo};
	} 
var url = "getCTMmemberList";
	
var bClickable = false;
GetJsonData('tblListOfctmCommittee',data,url,bClickable);
} 

function makeTable(jsonData)
{	
var htmlTable = "";	
var data = jsonData.count;
var i=1;

var pageSize = 5;


var dataList = jsonData.data;

 for(item in dataList){
		  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
		   htmlTable = htmlTable + "<tr id='"+dataList[item].id+"' >";	
		  htmlTable = htmlTable + "<td >" + dataList[item].fromDate + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].toDate + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].member1 + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].member2 + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].president + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].letterNo + "</td>";
    	  if(dataList[item].status.toUpperCase() == 'Inactive'.toUpperCase())
    		  htmlTable = htmlTable + "<td >"+ dataList[item].status + "</td>";
    		  else
    	  htmlTable = htmlTable + "<td ><a style='text-decoration:underline; color:blue;'  href='#' onclick='changeStatus(\""+dataList[item].id+"\",\""+dataList[item].status+"\")'</a>"+ dataList[item].status + "</td>";
    	  if(dataList[item].ridcId != null)
    	  htmlTable = htmlTable + "<td ><a style='text-decoration:underline; color:blue;'  href='#' onclick='downloadFile("+dataList[item].ridcId+")'</a>Download</td>";
    	  else
    		  htmlTable = htmlTable + "<td ></td>";
     	 
    	  htmlTable = htmlTable + "</tr>";
   
      }
if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
	{
	htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
	   //alert('No Record Found');
	}			

$j("#tblListOfctmCommittee").html(htmlTable);	


}


function showResultPage(pageNo)
{


nPageNo = pageNo;	
GetCTMMemberList('FILTER');

}

function getName(id){
	var memberService = 0;
    var memberService= document.getElementById(id+"ServiceNo").value;
	if(memberService == ""){
		document.getElementById(id+"Name").value="";
		return false;
	}
	 var m1Name = $j("#m1Name").val();
	 var m2Name = $j("#m2Name").val();
	 var pName = $j("#pName").val();
	if(m1Name!=""){
	 var m1ServiceNo = $j("#m1ServiceNo").val();
	 if(memberService==m1ServiceNo){
		 alert("Member is already selected");
		 document.getElementById(id+"ServiceNo").value="";
		 return false;
	 }
	}
	if(m2Name!=""){
		 var m2ServiceNo = $j("#m2ServiceNo").val();
		 if(memberService==m2ServiceNo){
			 alert("Member is already selected");
			 document.getElementById(id+"ServiceNo").value="";
			 return false;
		 }
		}
	
	if(pName!=""){
		 var pServiceNo = $j("#pServiceNo").val();
		 if(memberService==pServiceNo){
			 alert("Member is already selected");
			 document.getElementById(id+"ServiceNo").value="";
			 return false;
		 }
		}
	
	 $j(".check").prop("readonly", true);
	
	 document.getElementById(id+"msg").innerHTML="";
	 var serviceNo={"memberService":memberService};
	 jQuery.ajax({
 	 	crossOrigin: true,
 	    method: "POST",			    
 	    crossDomain:true,
 	    url: "getNameByServiceNo",
 	    data:JSON.stringify(serviceNo),
 	    contentType: "application/json; charset=utf-8",
 	    dataType: "json",
 	    success: function(result){
 	    	if(result.status==1){
 	    		document.getElementById(id+"Name").value=result.name;
 	    		document.getElementById(id+"EmpId").value=result.empId;
 	    		 $j(".check").prop("readonly", false);
 	    	
 	    	}
 	    	else if(result.status==0){
 	    		console.log(result.msg);
 	    		document.getElementById(id+"msg").innerHTML=result.msg;
 	    		 $j(".check").prop("readonly", false);
 	    		
 	    	}
 	    	
 	    },
 	    error: function(result) {
             alert("An error has occurred while contacting the server");
         }
 	    
 	});
 	
}

function submitForm() {
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
	
	
	 var m1Name = $j("#m1Name").val();
	 var m2Name = $j("#m2Name").val();
	 var pName = $j("#pName").val();
	  var letterNo = $j("#letterNo").val();
	   if (m1Name == null || m1Name == "") {
          alert("Member 1 can not be blank");
          return false;
      }
	  if (m2Name == null || m2Name == "") {
          alert("Member 2 can not be blank");
          return false;
      }
	  if (pName == null || pName == "") {
          alert("President can not be blank");
          return false;
      }
	  
	  if (letterNo == null || letterNo == "") {
          alert("Authority Letter No  can not be blank");
          return false;
      }
	  var filenameValue = $j("#fileUploadid").val();
	  if(filenameValue==""||filenameValue == null ){
		  alert("Please choose file");
		  return false;
	  } 
	  if(filenameValue!="" && filenameValue!=undefined){
			 if(validateFileExtension(filenameValue, "valid_msg", "Only pdf/image files are allowed ",
				      new Array("jpg","pdf","jpeg","gif","png")) == false)
				      {
				 		return false;
				 	   }
			
	  }
	  $("#submitCtmForLP").submit();
		 setTimeout(function(){ 			 
			 $("#saveForm1").attr("disabled", "disabled");
			   
		 }, 50);	
	
}


var status;
var lpcId;
function changeStatus(lpcId,status)
{
	/* var dataList = jsonData.data;
	 for(item in dataList){
		if(lpcId == dataList[item].id){
			lpcId = dataList[item].id;
			status = dataList[item].status;
		
		}
	} */
	
	 if(status==="Active"){
	   var r = confirm("Are you sure want to Inactivate committee");
	   if(r==true)
		rowClick(status,lpcId);
	 }
	 else
		 alert("Inactivate committee can not be activate");
		 return false;
		 
}


function rowClick(status,lpcId){	
	 window.location.href = "inactivatectmCommittee?lpcId="+lpcId+"&status="+status;
	
}

function validateFileExtension(component,msg_id,msg,extns)
{
   var flag=0;
   with(component)
   {
      var ext=component.substring(component.lastIndexOf('.')+1);
      for(i=0;i<extns.length;i++)
      {
         if(ext==extns[i])
         {
            flag=0;
            break;
         }
         else
         {
            flag=1;
         }
      }
      if(flag!=0)
      {
         alert(msg);
        /*  component.value="";
         component.style.backgroundColor="#eab1b1";
         component.style.border="thin solid #000000";
         component.focus(); */
         return false;
      }
      else
      {
         return true;
      }
   }
}

function downloadFile(ridcId){
   //viewDocumentForDigi(ridcId);
	//viewDocumentForCommon(ridcId);
	viewDocumentForDigi(ridcId);
	}
</script>
</html>