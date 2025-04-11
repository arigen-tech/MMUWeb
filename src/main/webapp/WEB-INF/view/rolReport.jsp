<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ROL (Re-order Level) List</title>

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

	String departmentId = "0";
	if (session.getAttribute("department_id") != null) {
		departmentId  = session.getAttribute("department_id") + "";
	}
%>

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function(){
	if(<%=departmentId%>!=0){
		getROLList('ALL');
		GetHospitalList();
		$('#uid').hide();
	}else{
		alert("Select the department");
		return false;
	}
			
			
		});

 function getROLList(MODE) { 	
 	var hospital;
 	if($j('#unitId').val()!=0 &&  $j('#unitId').val()!=null ){
 		hospital=$j('#unitId').val();
 	}else{
 		hospital=<%=hospitalId%>;
 	}
 	var cmdId=0; 
 	 if(MODE == 'ALL')
 		{
 		var data = {"hospitalId":hospital, "departmentId": <%= departmentId %>, "pageNo":nPageNo};
 			
 		}
 	else
 		{
 		var data = {"hospitalId": hospital, "departmentId": <%= departmentId %>, "pageNo":nPageNo};
 		}  	 
		
 	var bClickable = false;
 	var url = "getROLDataList";
 	GetJsonData('tblListofROL',data,url,bClickable);
 }
 
 
 function makeTable(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	var pageSize = 5;
 	var dataList = jsonData.rolList;
 	
 	for(i=0;i<dataList.length;i++)
 		{	 		
 				
 			htmlTable = htmlTable+"<tr>";		
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+(i+1)+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].pvmsNo+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].nomenClature+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].unitName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].closingStock+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].rol_d+"</td>";
 			htmlTable = htmlTable+"</tr>";
 			
 		}
 	if(dataList.length == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofROL").html(htmlTable);	 	
 	
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getROLList('FILTER');
 	
 }
 
 
 function ResetForm()
 {	
	 $j('#from_date').val('');
 	 $j('#to_date').val('');
 	 $j('#pvms_no').val();
 	 $j('#nomenclature').val('');
 }
 
 
 function printReport(){
	 if($j('#unitId').val()!=''){
		 var hospitalId;
		 	if($j('#unitId').val()!=0){
		 		hospitalId=$j('#unitId').val();
		 	}else{
		 		hospitalId=<%=hospitalId%>;
		 	}
	 	 var departmentId = <%= departmentId %>;
	 	 var url="${pageContext.request.contextPath}/report/printRolReport?hId="+hospitalId+"&dId="+departmentId+"&unitId="+hospitalId;
	 	 openPdfModel(url);
	 	 
	 	/*  document.frm.action="${pageContext.request.contextPath}/report/printRolReport?hId="+hospitalId+"&dId="+departmentId+"";
	 	 document.frm.method="GET";
		 document.frm.submit();  */
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
	 	    	$j("#printReportButton").attr("disabled", false);
	 	    	
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
	 
	  <div class="internal_Htext">ROL (Re-order Level) List</div>
	 
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <div class="col-md-4">
                                                     <div class="form-group row" id="unitDiv">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId" onchange="getROLList()">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                                     </div>
                                                 </div>
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
                                            	<th id="th1">S.NO.</th>
                                                <th id="th1">PVMS NO.</th>
                                                <th id="th2">Nomenclature </th>
                                                <th id="th3">A/U</th>
												<th id="th5">Stock Qty.</th> 
												<th id="th6">ROL Qty</th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListofROL">

                                        </tbody>
                                    </table>
						
                                    <!-- end row -->
									<!-- <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
									<div class="ow">
										<div class="col-sm-12 text-right">
										<button disabled type="button" id="printReportButton"   class="btn  btn-primary "
											onclick="printReport();">Print</button>
											
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