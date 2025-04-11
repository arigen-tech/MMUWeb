<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Indian Coast Guard</title>

</head>


<script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function(){
	var htmlTable = "";
	var data =  ${jsonResponse};
	if(data.status=1){
	    var dataList = data.utilizedFundData;
	    for(item in dataList){
	    	htmlTable = htmlTable + "<tr id='" + dataList[item].poMId + "'>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].poNumber + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].poDate + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].sum + "</td>";
	    	
	    }
	    	$j("#tblFundUtilization").html(htmlTable);
	  }else{
		   $j("#tblFundUtilization").html("");
	  }
			
});

</script>
<body>

		<table class="table table-hover table-bordered">
			 <thead class="bg-primary" style="color: #fff;">
					<tr id='th'>
						<th id="th1">PO Number</th>
						<th id="th2">PO Date</th>
						<th id="th3">Amount</th>
					</tr>
			</thead>
					<tbody id="tblFundUtilization">
					</tbody>
		</table>
	
</body>
</html>