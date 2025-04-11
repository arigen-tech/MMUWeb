<%@ page import="com.mmu.web.utils.UtilityServices"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="pragma-directive" content="no-cache" />
<meta http-equiv="cache-directive" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta name="robots" content="all,follow" />


<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>


<title>Insert title here</title>
    
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon-16x16.png" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon-16x16.png" type="image/x-icon">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/icons.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" />
    <link	href="${pageContext.request.contextPath}/resources/css/datePicker.css"	rel="stylesheet" />
    <link	href="${pageContext.request.contextPath}/resources/css/jquery-te-1.4.0.css"	rel="stylesheet" />
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>   
    <script src="${pageContext.request.contextPath}/resources/js/modernizr.min.js"></script>    
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.slimscroll.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.scrollTo.min.js"></script>    
	 <script src="${pageContext.request.contextPath}/resources/js/jquery.core.js"></script>
	  <script src="${pageContext.request.contextPath}/resources/js/jquery-te-1.4.0.min.js"></script>
    
    
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.datePicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/ajax.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonValidator.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hms.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>

<script type="text/javascript">
var item;
var resourceJSON = <%=UtilityServices.getJSLocaleJSON()%>;

<% 
String str="";
if (session.getAttribute("userId") != null) {
	str = session.getAttribute("userId") + "";
}
else
{
	%>
	window.location = resourceJSON.logoutAndSessionURL;	
	<% 
}%>	

window.history.forward();
function noBack() { window.history.forward(); }

 if ( window.history.replaceState ) {
	  window.history.replaceState( null, "", window.location.href );
	} 
<%  HttpSession session1 = request.getSession(false);// don't create if it doesn't exist

if(session1 == null || session1.isNew()) {
	%>
	window.location = resourceJSON.logoutAndSessionURL;
	<% 
	}%>
var versionContorl=resourceJSON.versionControl;		
			
			
</script>
<script>

function getResolution() {
    console.log("Your screen resolution is: " + screen.width + "x" + screen.height);
    
    if(screen.width<= 1024){
    	$('body').addClass('enlarged');
    }
}
getResolution();
</script>
</head>
<body >
<div id="wrapper">

        <!-- Top Bar Start -->
        <div class="topbar">
        
        	<!-- LOGO -->
            <div class="topbar-left">
                <a href="javascript:void(0);" class="logo">
                    <span>
                            <img href="javascript:void(0);" src="${pageContext.request.contextPath}/resources/images/mmu-logo.png"  height="100%">
                        </span>
                         <i>
                             <img href="javascript:void(0);" src="${pageContext.request.contextPath}/resources/images/mmu-logo.png"  height="22">
                        </i>
                    
                </a>
            </div>
        
            <nav class="navbar-custom">
                     <!-- <span class="centerLocation text-center"> Mobile Medical Unit- MMSSY</span> -->
				
				
				
               <ul class="list-inline float-right mb-0">
                    <li class="list-inline-item dropdown notification-list">
                        <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                            <i class="noti-icon">
                            </i>
                            <% 
                             
                            
                            if(session.getAttribute("userName") != null) {
                            if(!session.getAttribute("userName").equals("")){ %>
                           
                         	 <span class="profile-username ml-2 text-white"><strong>WELCOME :</strong> &nbsp;&nbsp;<span class="name"><%=session.getAttribute("userName")%></span> <span class="designation"> ,</span> </span>
                          <%}else{ %> 
                         
                           <span class="profile-username ml-2 text-white"><strong>WELCOME :</strong> <span class="name"><%=session.getAttribute("userName")%></span> </span>
                           <%}
                            }
                           %> 
                            <span class="mdi mdi-menu-down text-white userArrow"><%=session.getAttribute("userTypeDesignation")%></span> 
                            
                        </a>
                        <div id="userDropDown" class="dropdown-menu dropdown-menu-animated dropdown-menu-right profile-dropdown" style="width:100%">
                         

                            <a href="<%=request.getContextPath()%>/dashboard/logouts"  class="dropdown-item notify-item" > 
                                <i class="mdi mdi-power"></i> <span>Logout</span>
                            </a>

                        </div>
                    </li>

                </ul>
                <%-- 
                <% String hospitalName = String.valueOf(session.getAttribute("hospital_Name"));
                System.out.println("hospitalName *********** "+hospitalName);
                if(!hospitalName.equals("null")){
                %>
                <select class="form-control float-right headerSelect" id="dept_list" onchange="setDepartmentId()">
                <option value="0" selected="selected">Select</option>
            	</select>
            	
            	<label class="form-control-label float-right headerSelect text-right m-r-10">Department</label> 
            	
           		<span class="centerLocation2 text-center">ASHA - <span><%=session.getAttribute("hospital_Name")%></span></span>
           		<%
                	}
            	%> --%>
           		<!-- <span class="centerLocation2 text-center">ASHA - <span>SHIP</span></span>  -->
           		
           		
				<img class="minister" src="${pageContext.request.contextPath}/resources/images/minister.png"/>
           		<div class="appName">
           			<img src="${pageContext.request.contextPath}/resources/images/name.png"/>
           			<span class="mmuName"><% if(session.getAttribute("mmuName") !=null) out.print(session.getAttribute("mmuName")); %>-<% if(session.getAttribute("campLocation") !=null) out.print(session.getAttribute("campLocation")); %></span>
           		</div>
                <ul class="list-inline menu-left mb-0">
                    <li class="float-left">
                        <button class="button-menu-mobile open-left waves-light waves-effect">
                            <i class="mdi mdi-menu"></i>
                        </button>
                    </li>
                </ul>
            </nav>
        </div>
     </div>
     
     <footer class="footer">
      2023 © All Rights Reserved. Version &nbsp 3.0.0
    </footer>
     <script>
     
     
     <%
	     String hId="0";
	     if(session.getAttribute("hospital_id")!=null)
	     {
	     	hId = session.getAttribute("hospital_id")+""; 
	     }
	     String dId = "0";
	     if(session.getAttribute("department_id")!=null)
	     {
	    	 dId = session.getAttribute("department_id")+""; 
	     } 
	 	String mmuIdVal = "0";
		if (session.getAttribute("mmuId") != null) {
			mmuIdVal = session.getAttribute("mmuId") + "";
		}

	%>
	
	 $j(document).ready(function() {		
    	// makeCombo();
    	});
	
	
     function makeCombo() {
 		var params = {
 			"hospitalID" : "<%= hId %>",
 			"mmuId":"<%= mmuIdVal%>"
 		}
 		$j.ajax({
 					type : "POST",
 					contentType : "application/json",
 					url : '${pageContext.request.contextPath}/admin/getDepartmentListBasedOnDepartmentType',
 					data : JSON.stringify(params),
 					dataType : "json",
 					cache : false,
 					 async: true,
 					success : function(msg) {
 						if (msg.status == '1') {
 							var comboval ="";
 							/* var comboval = "<option value=\"\">Select</option>"; */
 							for (var i = 0; i < msg.departmentList.length; i++) {
 								//console.log("msg.departmentList[i].departmentName"+msg.departmentList[i].departmentName);
 								comboval += '<option value=' + msg.departmentList[i].departmentId + '>'
 										+ msg.departmentList[i].departmentname
 										+ '</option>';

 							}
 							$j('#dept_list').append(comboval);
 							var departId = <%= dId %>;
 							 $('#dept_list').val(departId); 

 						}

 					},

 					error : function(msg) {

 						alert("An error has occurred while contacting the server");

 					}
 				});
 	} 
     
     function setDepartmentId(){
     	var id = $('#dept_list').find('option:selected').val();
     	var name = $('#dept_list').find('option:selected').text();
     	if(id == undefined || id == ''){
     		return;
     	}
     	var params = {
     			"departmentId" : id,
     			"departmentName": name
     		}
     	$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : '${pageContext.request.contextPath}/admin/setDepartmentId',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(msg) {
					$('#dept_list').val(msg.departmentID);
					//location.reload();
					location.href='${pageContext.request.contextPath}/dashboard/dashboard'
				},

				error : function(msg) {

					alert("An error has occurred while contacting the server");

				}
			});
     }
     
     $(function(){
    	 $('.button-menu-mobile').on('click', function (event) {
             event.preventDefault();
             $("body").toggleClass("enlarged");
         });
    	 
    	 // to select a clicked row in a table ---- add class clickableRow to the tbody
			$(document).on('click','tr',function(){
				
				$('tr').removeClass('rowClicked');
				
				var parentTr = $(this).closest('tbody');
				
				if(parentTr.hasClass('clickableRow')){
					$(this).addClass('rowClicked');
				}
			});
    	 
			/* $(document).mouseup(function(e){
				
			    var container = $(".clickableRow");
			    
			    if (!container.is(e.target) && container.has(e.target).length === 0) 
			    {
			    	$('tr').removeClass('rowClicked');
			    }
			}); */
			
			
			// logout button work
			$('.nav-user').on('click', function (event) {
	             $('#userDropDown').toggle();
	         });
			
			$(document).on('click', '.multiDiv span', function () {
				$('.multiDiv span').removeClass('active');
				$(this).addClass('active');
			});
    	 
     }); 	
         
     </script>
     
<!--      <script>
		// to show autocomplete list outside of table responsive
		$(function(){
			
			$('.forTableResp input').on('keyup',function(){
				
				var parentInput = $(this);
				var parentWidth = $(this).outerWidth();
				var parentPostion = parentInput.position();
				
				console.log('hhhh');
				
				$('.autocomplete-items').css({'top':parentInput.position().top+24, 'width': parentWidth});
			});
		});
	</script> -->
	
	  <script>
		// to show autocomplete list outside of table responsive
	
		$(document).on('keyup', '.forTableResp input', function () {
			var parentInput = $(this);
			var parentWidth = $(this).outerWidth();
			var parentPostion = parentInput.position();
			$('.autocomplete-items').css({'visibility':'visible'});
			$('.autocomplete-items').css({'top':parentInput.position().top+24, 'width': parentWidth,'left':parentInput.position().left});
			$('.autocomplete-itemsNew').css({'visibility':'visible'});
			$('.autocomplete-itemsNew').css({'top':parentInput.position().top+24, 'width': parentWidth,'left':parentInput.position().left});
			
		});
		
		$(document).on('keyup', '.forTableResp textarea', function () {
			var parentInput = $(this);
			var parentWidth = $(this).outerWidth();
			var parentPostion = parentInput.position();
			$('.autocomplete-items').css({'visibility':'visible'});
			$('.autocomplete-items').css({'top':parentInput.position().top+24, 'width': parentWidth,'left':parentInput.position().left});
			$('.autocomplete-itemsNew').css({'visibility':'visible'});
			$('.autocomplete-itemsNew').css({'top':parentInput.position().top+24, 'width': parentWidth,'left':parentInput.position().left});
		});
		
		function logoutApplication(){
			window.location="${pageContext.request.contextPath}/dashboard/logouts";
		
		}
		
		
	</script>
	
	<script>
	$(function(){
		localStorage['myKey'] = 'defaultValue';
		// save clicked menu in local storage
		/* $("#sidebar-menu a + ul a").on('click',function(e){
			var menuItem = $(this).attr('data-id');
			localStorage['myKey'] = menuItem || 'defaultValue';
		}); */
		
		$("#sidebar-menu a + ul a").on('click',function(e){
			var menuItem = $(this).attr('data-id');			
			localStorage['myKey'] = menuItem || 'defaultValue';
			localStorage['myMenu'] = menuItem || 'defaultValue';
		});
		
		$("#sidebar-menu a + ul a + ul.nav-third-level a").on('click',function(e){
			var menuItem = $(this).attr('data-id');
			localStorage['myKey'] = menuItem || 'defaultValue';
			localStorage['myMenu'] = menuItem || 'defaultValue';
		});
	});
	</script>
	
<script>
  
  $j(document).on('mouseenter','.autocomplete input',function(){
	  $j('input').disableAutoFill({
		  randomizeInputName: true
	  });
  });  
</script>

	<script> 
// change browser alert to custom alert
var ALERT_TITLE = "Alert";
var ALERT_BUTTON_TEXT = "Ok";

if(document.getElementById) {
    window.alert = function(txt) {
        createCustomAlert(txt);
    }
}

function createCustomAlert(txt) {
    d = document;
	
    var lastChar,newMsg;     
        
    if(d.getElementById("modalContainer")) return;

    mObj = d.getElementsByTagName("body")[0].appendChild(d.createElement("div"));
    mObj.id = "modalContainer";
    mObj.style.height = d.documentElement.scrollHeight + "px";
    
    alertObj = mObj.appendChild(d.createElement("div"));
    alertObj.id = "alertBox";
    if(d.all && !window.opera) alertObj.style.top = document.documentElement.scrollTop + "px";
    alertObj.style.left = (d.documentElement.scrollWidth - alertObj.offsetWidth)/2 + "px";
    alertObj.style.visiblity="visible";	
    h1 = alertObj.appendChild(d.createElement("h1"));
    
    //h1.appendChild(d.createTextNode(ALERT_TITLE));
	
    if(typeof txt === 'undefined' || txt === null) {
        txt = 'Undefined value'; 
        alertIcon = d.createElement('i');
        alertIcon.className ="fa fa-exclamation-triangle";
        
    }
    else{
	    lastChar = txt[txt.length -1];    
	    if( lastChar == 'S')
	   	{
	    	newMsg = txt.substring(0, txt.length-1);
	    	alertIcon = d.createElement('img');
	    	alertIcon.src = "${pageContext.request.contextPath}/resources/images/checkmarksuccess.gif";
	   	}    
	    else{
	    	newMsg = txt;
	    	alertIcon = d.createElement('i');
	    	alertIcon.className ="fa fa-exclamation-triangle";
	    }
    }
    
    h1.appendChild(alertIcon);
    
    msg = alertObj.appendChild(d.createElement("p"));
    //msg.appendChild(d.createTextNode(txt));
    msg.innerHTML = newMsg;

    btn = alertObj.appendChild(d.createElement("a"));
    btn.id = "closeBtn";
    btn.appendChild(d.createTextNode(ALERT_BUTTON_TEXT));
    btn.href = "#";
    btn.focus();
    btn.onclick = function() { removeCustomAlert();return false; };

    alertObj.style.display = "block";
    
}

function removeCustomAlert() {
    document.getElementsByTagName("body")[0].removeChild(document.getElementById("modalContainer"));
}

function ful(){
	alert('Alert');
}

/////////////////////////////////////////Document Expiry Get Source Code /////////////////////////
function viewDocumentForDigi(ridcId)
{
	
    var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getRidcDocmentInfo";

	//var data = $('employeeId').val();
   // alert("radioValue" +radioValue);
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify({
			'ridcId' : ridcId,
			
		}),
		dataType : 'json',
		timeout : 100000,
		
		success : function(res)
		
		{
			data = res.ridcInfoList;
			
			for(var i=0;i<data.length;i++){
				
				var ridcInfo= data[i];
				
				var documentId=ridcInfo[0];
				var documentName = ridcInfo[1];
				//var documentInfo = ridcInfo[2];
				var shipDownloadUrl = resourceJSON.shipDownloadUrl;
				var openUrl=shipDownloadUrl+documentId;
				window.open(openUrl);
				//openRmsModel(openUrl); 	
			}

		
           },
           error: function (jqXHR, exception) {
               var msg = '';
               if (jqXHR.status == 0) {
                   msg = 'Not connect.\n Verify Network.';
               } else if (jqXHR.status == 404) {
                   msg = 'Requested page not found. [404]';
               } else if (jqXHR.status == 500) {
                   msg = 'Internal Server Error [500].';
               } else if (exception === 'parsererror') {
                   msg = 'Requested JSON parse failed.';
               } else if (exception === 'timeout') {
                   msg = 'Time out error.';
               } else if (exception === 'abort') {
                   msg = 'Ajax request aborted.';
               } else {
                   msg = 'Uncaught Error.\n' + jqXHR.responseText;
               }
               alert(msg);
           }
	});
}
function getDateComapareValue(fromDate,toDate){
	 var countDateV=0;
	 
	 var fCurrentDateVal=fromDate.split("/");
		var fddate=fCurrentDateVal[0];
		var fmonth=fCurrentDateVal[1];
		var fyear=fCurrentDateVal[2];
		var fUpdateDate=fCurrentDateVal[1]+"/"+fCurrentDateVal[0]+"/"+fCurrentDateVal[2];
		
		 var tCurrentDateVal=toDate.split("/");
			var tddate=tCurrentDateVal[0];
			var tmonth=tCurrentDateVal[1];
			var tyear=tCurrentDateVal[2];
		
			var tUpdateDate=tCurrentDateVal[1]+"/"+tCurrentDateVal[0]+"/"+tCurrentDateVal[2];	
	 var g1 = new Date(fUpdateDate); 
	    var g2 = new Date(tUpdateDate); 
	    if (g1.getTime() > g2.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    if (g2.getTime() < g1.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    return countDateV;
}


function caompareTPAData(){
	  var tpaMember1Id= $('#tpaMember1Id').val();
	  var tpaMember2Id= $('#tpaMember2Id').val();
	  
	  if(tpaMember2Id!="" && tpaMember2Id!=undefined && tpaMember1Id!="" && tpaMember1Id!=undefined){
		  if(tpaMember1Id===tpaMember2Id){
			  alert("TPA member 1 and member 2 should not be same");
			  return false
		  }else{
			  return true;
		  }
		  
	  }
	  else{
		  return true;
	  }
 }
 
function disbaledForwardTo(){
	  var actionId= $('#actionId').val();
	  var authrityVal=$('#authorityId').val();
	 if(actionId=='R'){
		 $('#forwordTo').attr('disabled', true);
		 $('#penaltyAmount').attr('disabled', true);
		 $('#forwordTo').val('');
		 $('#penaltyAmount').val('');
	  }
	 else
		{
		 $('#forwordTo').attr('disabled', false);
		 $('#penaltyAmount').attr('disabled', false);
		 var forwordTo= document.getElementById("forwordTo");
		 
		 var ddlArray= new Array();
		 var ddl = document.getElementById('forwordTo');
		 for (i = 0; i < ddl.options.length; i++) {
		    ddlArray[i] = ddl .options[i].value;
		   if(ddlArray[i]!="")
			{   
		    var splitVal=ddlArray[i].split("@@");
            var authVal=splitVal[0];
            if(authrityVal<authVal)
            {
            	 $("#forwordTo").val(ddlArray[i]);
            	 break; 
            }	
         
			}
		 }
	
	
		} 
	
}

function getTodayDate(inputdate) {
	var firstdate = new Date(inputdate);
	//var date1 = firstdate.getFullYear()+'-'+(firstdate.getMonth()+1)+'-'+firstdate.getDate();
	var date1 = ("0" + firstdate.getDate()).slice(-2) + '/'
			+ ("0" + (firstdate.getMonth() + 1)).slice(-2) + '/'
			+ firstdate.getFullYear();
	return date1;
}

</script>
	
	
</body>
</html>
<jsp:include page="..//view/rmsModelWindowForReports.jsp" />