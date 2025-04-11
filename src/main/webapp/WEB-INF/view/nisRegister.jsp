<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>NIS Register</title>

<%@include file="..//view/commonJavaScript.jsp" %>
</head>
 
<script type="text/javascript" language="javascript">
<%			
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
	}
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}

	String departmentId  = "0";
	if (session.getAttribute("department_id") != null) {
		departmentId  = session.getAttribute("department_id") + "";
		System.out.println("department_id "+departmentId );
	}
%>

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function(){
	if(<%=departmentId%>!=0){
		//getNISData('ALL');
		$('#table_div').hide();
		GetHospitalList();
		$('#uid').hide();
	}else{
		alert("Select the department");
		return false;
	}
	
	var currentDate = currentDateInddmmyyyy();
	$('#from_date').val(currentDate);
	$('#to_date').val(currentDate);
});

 function getNISData(MODE) { 	
 	 var cmdId=0; 	
	 var from_date = $j('#from_date').val();
 	 var to_date = $j('#to_date').val();
 	 var hospital=$j('#unitId').val();
 	if (from_date === undefined) {
 		from_date = "";
 	}
 	
	if (to_date === undefined) {
		to_date = "";
 	} 
	
   if(MODE == 'ALL')
 		{
 		var data = {"hospitalId": hospital, "fromDate":"","toDate":"", "pageNo":nPageNo};
 			
 		}
 	else
 		{
 		var data = {"hospitalId": hospital, "fromDate":from_date,"toDate":to_date, "pageNo":nPageNo};
 		} 
 	 
		
 	var bClickable = false;
 	var url = "getNisRegisterData";
 	GetJsonData('tblListofNisRegister',data,url,bClickable);
 }
 
 
 function makeTable(jsonData)
 {	
	 $('#table_div').show();
 	var htmlTable = "";	
 	var data = jsonData.count;
 	var pageSize = 5;
 	var dataList = jsonData.nisData;
 	var m = 0;
 	for(i=0;i<dataList.length;i++)
 		{	 		
 			m++;	
 			htmlTable = htmlTable+"<tr>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+ m +"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].pvmsNo+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].nomenclature+"</td>"; 		
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].nisQty+"</td>";
 			htmlTable = htmlTable+"</tr>";
 			
 		}
 	if(dataList.length == 0)
 		{
 			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
 		}			
 	
 	$j("#tblListofNisRegister").html(htmlTable);	 	
 	
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getNISData('FILTER');
 	
 }
 
 function showAll()
 {
 	ResetForm();
 	nPageNo = 1;	
 	getNISData('ALL');
 	
 }

 function search()
 {
	 if($j('#unitId').val()!=''){
		 var nPageNo=1;			
		 	var from_date = $j('#from_date').val();
		 	 var to_date = $j('#to_date').val();
			if((from_date == undefined || from_date == '') && (to_date == undefined || to_date == '')){	
				alert("Atleast one option must be entered");
				return;
			}
			getNISData('Filter');
	 }else{
		 alert("Please select Unit");
		 return false;
	 }
	 	
 }
 
 function resetDiv(){
	 $('#table_div').hide();
	 $j("#tblListofNisRegister").empty(); 
 }
 
 function ResetForm()
 {	
	 $j('#from_date').val('');
 	 $j('#to_date').val('');
 }
 
 
 function printReport(){
	 if($j('#unitId').val()!=''){
		 var fromDate = $j('#from_date').val();
	 	 var toDate = $j('#to_date').val();
	 	 var hospitalId =$j('#unitId').val();
	 	 
	 	var url="${pageContext.request.contextPath}/report/printNisRegister?hId="+hospitalId+"&fromDate="+fromDate+"&toDate="+toDate+"&unitId="+hospitalId;
	 	openPdfModel(url);
	 	
	 }else{
		 alert("Please select Unit");
		 return false;
	 }
	 
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
	 	    	var combo = "" ;
	 	    	for(var i=0;i<result.data.length;i++){
	 	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
	 	    		unitName=result.data[i].unitName;
	 	    		
	 	    	}
		
	 	    	jQuery('#unitId').append(combo);
		    	
		    	if($('#unitId').find("option").length > 2){
		    		
		    		$('#unitId').show(); 
		    		$('#uid').hide();
	    	    	
	    	    }

		    	else{
		    		$('#unitId').hide(); 
		    		$('#uid').show();
		    		$('#uid').val(unitName).attr('readonly','readonly');
		    		document.getElementById('unitId').value = <%=hospitalId%>; 
	    	    	};
	 	    	
	 	    }
	 	
	 	});

	  }
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 <form name="frm">
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">NIS Register</div>
	 
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row">
                                     <div class="col-md-4">
                                                     <div class="form-group row" id="unitDiv">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId" onchange="resetDiv();">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                                     </div>
                                                 </div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">From Date</label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text"  class="calDate datePickerInput form-control" id="from_date" placeholder="DD/MM/YYYY"
															name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">To Date</label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text"  class="calDate datePickerInput form-control" id="to_date" placeholder="DD/MM/YYYY"
															name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-10">
													<button type="button" class="btn btn-primary  nis-search" onclick="search();">Search</button>
												</div>
											</div>
										</div>
											
										</div>
							<div id="table_div">
								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>


								<table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                            	<th id="th1">S.No</th>
                                                <th id="th2">PVMS NO.</th>
                                                <th id="th3">Nomenclature </th>                                                
                                                <th id="th4">Quantity </th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListofNisRegister">

                                        </tbody>
                                    </table>
						
                                    <!-- end row -->
									<!-- <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
									<div class="ow">
										<div class="col-sm-12 text-right">
										<button type="button" class="btn  btn-primary" id="printReportButton" 
											onclick="printReport();">Print</button>
											
										</div>
									</div>
									</div>
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
                  </div>
	</form>
</div>
</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>