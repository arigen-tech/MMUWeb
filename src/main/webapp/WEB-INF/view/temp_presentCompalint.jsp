<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
        <%--   <%@include file="..//view/leftMenu.jsp" %> --%>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                        <%@include file="..//view/commonJavaScript.jsp" %>
                          <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
                            <title>OPD Main</title>
                      <!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->
                  
                   
                    </head>
                    <body>
                    
       <div id="wrapper">

		 <div class="popupbg">
			<form name="popPresentComp" method="post" action="">
			      <input type="hidden" name=" " value=" "> 
			        <div class="internal_Htext">Present Complaint & History Templates</div> 
			<div class="smallWithHeight">
			
			<table class="table table-primary"  id="componentDetails">
			
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" name="checkall"
						class="radioCheck" value="Collected All" id="addbutton"
						onclick="CheckAll(this);" align="right" /></th>
						<th scope="col">Template Values</th>
					</tr>
				</thead>
				<tbody>	
				<%-- <%int i=0;%>	 --%>	
					<tr>
						<td>    
							<%--  <input id="checkId<%=i %>" name="checkedTemp" type="checkbox"  class="radioCheck" value="n"/>  --%> 
								<input type="hidden" name="rowLength" id="rowLength" value=" " readonly="readonly"/>
						</td>
						<!--  <td><input type="text"  name="presentComplain" id="presentComplain" readonly="readonly" size="40"/></td> --> 
					</tr>					
				</tbody>
				
			</table>
			</div>
			
							
							<input type="hidden" value=" " name="rowVal" id="rowVal"/>	
				
				<button name="" type="button" class="button btn btn-primary" value="" onclick="setPresentComplaintTempalte();"> OK</button>
				<button name="" type="button" class="button btn btn-danger"	value="Close" onclick="cancelForm();"> Close</button>
				
				
					
			</form>
		</div> 
   </div>		
	  

<script>
 function cancelForm(){
   	   window.close();
  }
   
   function setPresentComplaintTempalte(){
	 
	   var name=[];
		for(var i =0;i<arrlen;i++){
			
			var cbcheck = document.getElementById('cb'+i+'');
			if(cbcheck.checked == true){
				
				name[i] = $('#text'+i+'').val();
				
				
			}
		}
		if (window.opener != null && !window.opener.closed) {
            var txtName = window.opener.document.getElementById("presentIllnessHistory");
            txtName.value = name;
        }
		
		  window.close(); 
		
  	}
   function CheckAll(chk){
	   var rowLength=document.getElementById('rowLength').value;
	   for (var i=0;i <document.popPresentComp.elements.length;i++)
	   	{
	   		var e = document.popPresentComp.elements[i];

	   		if (e.type == "checkbox")
	   		{
	   			e.checked = chk.checked;
	   			for(var j=0;j<rowLength;j++)
	   			{
	   				e.value="y";
	   			}
	   		}
	   	}
	   }
	    	
	</script>
	
	
<script type="text/javascript">

$( document ).ready(function() {
	
	 var data = ${data};
	 console.log("SUCCESS: ", data);
	 var dataarray = data.data;
		arrlen = dataarray.length;
		var addrowdata = "<tr>";
	
	  if (data.status == 1) {
	    	for(var i=0;i<dataarray.length;i++){
	    		var name = dataarray[i].patinetPresentComplaintname;
	    		addrowdata += '<td><input type="checkbox" id="cb'+i+'"></td><td><input type="text" value="'+name+'" id="text'+i+'" size="40" readonly="readonly"></td></tr><br>';				    		
	    		
	    	}
	    	
	    	$('#componentDetails').append(addrowdata);
	
   }
	  else
		  {
		    alert("NO Record Found")
		  }
		
});

</script>

	 
 
	</body>
	</html>