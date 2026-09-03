<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Cost Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/ajax.js"></script>
<script>

<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}

String levelOfUser = "1";
if (session.getAttribute("levelOfUser") != null) {
	levelOfUser = session.getAttribute("levelOfUser") + "";
}

String mmuId = "1";
if (session.getAttribute("mmuId") != null) {
	mmuId = session.getAttribute("mmuId") + "";
}
%>

var $j = jQuery.noConflict();
        $j(document).ready(function() { 
        	currentDate();  	
        	
        	getMMUList();
        	getGenderList();
        	        	
        	$("#uid").hide();
        });
        
       
        function getMMUList(){
			var params = {
					"levelOfUser":'<%=levelOfUser%>',
					"userId": <%=userId%>
			}
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(result) {
					   var mmuDrop = '';
					   var data=result.mmuListdata;
					   
					   if(data.mmuList.length =='1'){
						   $('#mmuId').attr('disabled', true);
						   for(i=0;i<data.mmuList.length;i++){
								mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
								
							}
							$j('#mmuId').append(mmuDrop);
						 <%--  // document.getElementById('mmuId').value = <%=mmuId%>;  --%>
					   }
					   else{
						for(i=0;i<data.mmuList.length;i++){
							mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
							
						}
						$j('#mmuId').append(mmuDrop);
					  }
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 	}
        
        function getGenderList(){
        	var params = {}
        	
        	var pathname = window.location.pathname;
        	var accessGroup = "MMUWeb";
        	var url = window.location.protocol + "//"
        	+ window.location.host + "/" + accessGroup
        	+ "/opd/getGenderList";
        	
        	$.ajax({
        		type : "POST",
        		contentType : "application/json",
        		url : url,
        		data : JSON.stringify(params),
        		dataType : "json",
        		cache : false,
        		success : function(data) {
        			if(data.status == true){
        				var list = data.data;
        				var dropDrop = '<option value="">Select</option>';
        				for(i=0;i<list.length;i++){
        					dropDrop += '<option value='+list[i].administrativeSexId+'>'+list[i].administrativeSexName+'</option>';
        				}
        				$j('#genderId').append(dropDrop);
        			}
        		},
        		error : function(data) {
        			alert("An error has occurred while contacting the server");
        		}
        	}); 
        	}
        	
        function getLabourTypeList(){
        	var params = {}
        	
        	$.ajax({
        		type : "POST",
        		contentType : "application/json",
        		url : "getLabourTyeList",
        		data : JSON.stringify(params),
        		dataType : "json",
        		cache : false,
        		success : function(data) {
        			if(data.status == true){
        				var list = data.list;
        				var dropDrop = '<option value="">Select</option>';
        				for(i=0;i<list.length;i++){
        					dropDrop += '<option value='+list[i].labourTypeId+'>'+list[i].labourTypeName+'</option>';
        				}
        				$j('#labourId').append(dropDrop);
        			}
        		},
        		error : function(data) {
        			alert("An error has occurred while contacting the server");
        		}
        	}); 
        	}
        
 
       
        
        
        function generateReport(){
        	
        	
        		
        		  if($j("#mmuId").val() == ""){
          		  	alert("Please select MMU");
          		  	retun ;
          	  }
        	  if($j("#fromdate").val() == ""){
        		  	alert("Please select From Date");
        		  	retun ;
        	  }
        	  
        	  if($j("#todate").val() == ""){
        		  	alert("Please select To Date");
        		  	retun ;
        	  }

        	  // PREVIEW | DOWNLOAD | CANCEL. See opdRegisterDeliveryDecision().
        	  var opdDelivery = opdRegisterDeliveryDecision();
        	  if (opdDelivery === 'CANCEL') {
        		  return;
        	  }

        	  var fromDate = $('#fromdate').val();
              var toDate = $('#todate').val();
              var mmu_id = $('#mmuId').val();
              var referral = $('#referral').val();
              
              var User_id = <%=userId%>;
              var Level_of_user = '<%=levelOfUser%>';
              
              if($('#genderId').val() !="")
            	  {
            	  		var genderId = $('#genderId').val();
            	  }
              else
            	  {
            	  	var genderId = "0";
            	  
            	  }
              
              var icdId = "0";
              
             if($j('#fromAge').val() !=''){
            	 var fromAge = $j('#fromAge').val(); 
             } 
             else{
            	 var fromAge = "0"; 
             }
             if($j('#toAge').val() !=''){
            	 var toAge = $j('#toAge').val(); 
             }
      		  
             else{
            	 var toAge = "0";
             }
              
        	  
	var url = "${pageContext.request.contextPath}/report/printOPDRegisterReport?mmu_id="
				+ mmu_id
				+ "&gender_id="
				+ genderId
				+ "&fromDate="
				+ fromDate
				+ "&toDate="
				+ toDate
				+ "&icdId="
				+ icdId
				+ "&User_id="
				+ User_id
				+ "&Level_of_user="
				+ Level_of_user
				+ "&fromAge="
				+ fromAge
				+ "&toAge="
				+ toAge
				+ "&referral="
				+ referral;

		if (opdDelivery === 'PREVIEW') {
			openPdfModel(url);
			// The shared modal's Download button sets its href to this same URL, so
			// clicking it re-runs the entire report on the server -- a second full
			// query, fill and export for bytes the browser already holds. Measured at
			// 5.3 minutes for a 5-month range. Hide it: the browser's own PDF viewer
			// has a save control that writes the already-loaded bytes for free.
			// Scoped to this page's DOM, so the button still works on other screens.
			$j('#downloadRep').hide();
		} else {
			opdRegisterDirectDownload(url);
		}

		/* document.frm.action="${pageContext.request.contextPath}/report/printMIReport";
		document.frm.method="GET";
		document.frm.submit();  */
	}
        
        function generatExcelReport(){
        	
        	
    		
  		  if($j("#mmuId").val() == ""){
    		  	alert("Please select MMU");
    		  	retun ;
    	  }
  	  if($j("#fromdate").val() == ""){
  		  	alert("Please select From Date");
  		  	retun ;
  	  }
  	  
  	  if($j("#todate").val() == ""){
  		  	alert("Please select To Date");
  		  	retun ;
  	  }
  	  
  	 
  	  var fromDate = $('#fromdate').val();
        var toDate = $('#todate').val();
        var mmu_id = $('#mmuId').val();
        var referral = $('#referral').val();
        
        var User_id = <%=userId%>;
        var Level_of_user = '<%=levelOfUser%>';
        
        if($('#genderId').val() !="")
      	  {
      	  		var genderId = $('#genderId').val();
      	  }
        else
      	  {
      	  	var genderId = "0";
      	  
      	  }
        
        var icdId = "0";
        
       if($j('#fromAge').val() !=''){
      	 var fromAge = $j('#fromAge').val(); 
       } 
       else{
      	 var fromAge = "0"; 
       }
       if($j('#toAge').val() !=''){
      	 var toAge = $j('#toAge').val(); 
       }
		  
       else{
      	 var toAge = "0";
       }
        
  	  
       window.location.href  = "${pageContext.request.contextPath}/mis/exportAuditOpdRegister?mmu_id="
			+ mmu_id
			+ "&gender_id="
			+ genderId
			+ "&fromDate="
			+ fromDate
			+ "&toDate="
			+ toDate
			+ "&icdId="
			+ icdId
			+ "&User_id="
			+ User_id
			+ "&Level_of_user="
			+ Level_of_user
			+ "&fromAge="
			+ fromAge
			+ "&toAge="
			+ toAge
			+ "&referral="
			+ referral;

	//openPdfModel(url)

	/* document.frm.action="${pageContext.request.contextPath}/report/printMIReport";
	document.frm.method="GET";
	document.frm.submit();  */
}     

	function compareToFromDate() {
		var fromDate = $('#fromdate').val();
		var toDate = $('#todate').val();

		if (process(toDate) < process(fromDate)) {
			alert("To Date should not be earlier than from Date");
			$('#todate').val("");
			return;
		}
	}

	// ------------------------------------------------------------------
	// OPD Register volume policy
	//
	// Calibrated from a measured run (state-level user, All MMU, no other
	// filters, 153 days), logged as event=report_done:
	//     965,920 rows | 42,378 pages | 232 MB | 317 s
	//   => ~6,313 rows, ~277 pages, ~1.52 MB and ~2.1 s PER DAY of range.
	//
	// At those rates a browser cannot render the result much past a week: the
	// 232 MB PDF above froze the tab. So the range drives HOW the report is
	// delivered, not just whether to warn:
	//
	//   <= preview allowance : modal preview (iframe)
	//   <= warn allowance    : straight to download, no preview
	//   >  warn allowance    : confirm() first, then download
	//
	// The allowance scales with how many MMUs are actually in scope, because
	// that is what dominates the row count. "All" for a district user covering
	// 5 MMUs is a fraction of "All" for a state user. getMMUHierarchicalList
	// already scopes the dropdown to the logged-in user, so the option count is
	// the real multiplier and no assumption about Level_of_user is needed.
	//
	// Gender / age / referral are deliberately NOT given an allowance bonus.
	// They do reduce the set, but by an unmeasured amount, and a guess that is
	// too generous re-creates the failure this exists to prevent. Every run now
	// logs params= and rows=, so these can be tuned from real data later.
	//
	// Scoped to this screen. Do not copy elsewhere without measuring that
	// report's rows per day first.
	// ------------------------------------------------------------------
	var OPD_BASE_PREVIEW_DAYS = 7;    // All-MMU preview: ~44k rows, ~1,940 pages, ~11 MB
	var OPD_BASE_WARN_DAYS    = 31;   // All-MMU month:   ~196k rows, ~8,600 pages, ~47 MB
	var OPD_MAX_ALLOWANCE_DAYS = 365; // however narrow the filter, never silently allow more

	/** True when the MMU filter is on "All" (value="0") rather than one MMU. */
	function opdRegisterIsAllMmu() {
		var selected = $j('#mmuId').val();
		return selected === '0' || selected === '' || selected === null;
	}

	/** How many real MMUs this user can see. The "All" entry is not one of them. */
	function opdRegisterMmuTotal() {
		var options = $j('#mmuId option').length - 1;
		return options > 0 ? options : 1;   // unknown -> assume 1, the strictest reading
	}

	/**
	 * Days allowed before previewing, and before warning.
	 *
	 * One MMU out of N carries roughly 1/N of the rows, so N times the date range
	 * fits the same budget. "All" gets the base allowance unwidened.
	 */
	function opdRegisterAllowance() {
		var widen = opdRegisterIsAllMmu() ? 1 : opdRegisterMmuTotal();
		return {
			preview: Math.min(OPD_BASE_PREVIEW_DAYS * widen, OPD_MAX_ALLOWANCE_DAYS),
			warn: Math.min(OPD_BASE_WARN_DAYS * widen, OPD_MAX_ALLOWANCE_DAYS)
		};
	}

	// PREVIEW | DOWNLOAD | CANCEL
	function opdRegisterDeliveryDecision() {
		var days = opdRegisterRangeInDays($j('#fromdate').val(), $j('#todate').val());
		if (days === null) {
			return 'PREVIEW';   // unparseable dates are the date validation's problem
		}
		var limit = opdRegisterAllowance();

		if (days <= limit.preview) {
			return 'PREVIEW';
		}
		if (days <= limit.warn) {
			return 'DOWNLOAD';
		}
		var ok = confirm(
			"You have selected " + days + " days"
			+ (opdRegisterIsAllMmu() ? " for ALL MMUs" : " for the selected MMU") + ".\n\n"
			+ "Reports beyond about " + limit.warn + " days for this selection can take "
			+ "several minutes and produce a file too large to open.\n\n"
			+ "Narrowing the MMU or the date range will make this much faster. If you "
			+ "need the full range, please contact your system administrator.\n\n"
			+ "Press OK to generate and download anyway, or Cancel to change the filters.");
		return ok ? 'DOWNLOAD' : 'CANCEL';
	}

	// ------------------------------------------------------------------
	// Download with progress.
	//
	// Saves the PDF instead of rendering it, in ONE request. The download
	// attribute forces save-as on a same-origin URL regardless of the server's
	// inline Content-Disposition, so no server change is needed -- and unlike
	// opening it in the viewer, a 200 MB file will not freeze the tab.
	//
	// The dialog itself lives in reportProgressDialog.jsp, included at the foot of
	// this page. Cancel is offered here because this report is filled in THIS JVM
	// by HMSUtil, which holds the Statement and can really abort the query -- the
	// MIS exports run theirs in MMUServices and so leave it off.
	// ------------------------------------------------------------------
	function opdRegisterDirectDownload(url) {
		var days = opdRegisterRangeInDays($j('#fromdate').val(), $j('#todate').val());
		var mmuText = opdRegisterIsAllMmu()
				? 'All MMUs (' + opdRegisterMmuTotal() + ')'
				: $j('#mmuId option:selected').text();

		ReportProgress.start({
			url: url,
			title: 'Generating OPD Register',
			prefix: 'opd',
			filename: 'OPD_Register_Report.pdf',
			cancelable: true,
			details: [
				{ label: 'Date range', value: $j('#fromdate').val() + ' \u2013 ' + $j('#todate').val()
						+ (days === null ? '' : ' (' + days + ' days)') },
				{ label: 'MMU', value: mmuText },
				{ label: 'Gender', value: $j('#genderId option:selected').text() || 'All' }
			],
			hint: 'Reading data and building pages'
		});
	}

	// Dates on this screen are dd/MM/yyyy (see currentDate()). Returns an
	// inclusive day count, matching the report query's BETWEEN-style range, or
	// null if either date is missing or unparseable — a warning must never be
	// what stops a valid report.
	function opdRegisterRangeInDays(fromValue, toValue) {
		var from = opdRegisterParseDate(fromValue);
		var to = opdRegisterParseDate(toValue);
		if (from === null || to === null) {
			return null;
		}
		return Math.round((to - from) / 86400000) + 1;
	}

	function opdRegisterParseDate(value) {
		if (!value) {
			return null;
		}
		var parts = String(value).split("/");
		if (parts.length !== 3) {
			return null;
		}
		var day = parseInt(parts[0], 10);
		var month = parseInt(parts[1], 10);
		var year = parseInt(parts[2], 10);
		if (isNaN(day) || isNaN(month) || isNaN(year)) {
			return null;
		}
		return new Date(year, month - 1, day).getTime();
	}
	
                
        
        
        function currentDate(){
        	var now = new Date();
         	now.setDate(now.getDate());
         	var day = ("0" + now.getDate()).slice(-2);
         	var month = ("0" + (now.getMonth() + 1)).slice(-2);
         	var today = (day)+"/"+(month)+"/"+now.getFullYear();
         	$j('#fromdate').val(today);
         	$j('#todate').val(today);
            }

        function validateAge(){
        	       	
        	var fromAge = $j('#fromAge').val();
    		var toAge = $j('#toAge').val();
    		
    		if(fromAge !='' && fromAge > 125){
    			alert("From age should not be greater than 125 ")
    			$j('#fromAge').val("");
    		   }
    		
    		if(toAge !='' && toAge > 125){
    			alert("To age should not be greater than 125 ")
    			$j('#toAge').val("");
    		 }
    		
            if(fromAge !='' && toAge !=''){
    		  if (fromAge > toAge ) {
    			alert("To Age should not be earlier than From Age");
    			$j('#fromAge').val("");
    			$j('#toAge').val("");
    		 }
           }
        }
       
    </script>  

</head>

<body>

         <!-- Begin page -->
         <div id="wrapper">

             <!-- ========== Left Sidebar Start ========== -->

             <!-- Left Sidebar End -->

             <!-- ============================================================== -->
             <!-- Start right Content here -->
             <!-- ============================================================== -->
             <div class="content-page">
                 <!-- Start content -->
                 <div class="">
                     <div class="container-fluid">
                         <div class="internal_Htext">MMU OPD Register</div>

                         <div class="row">
                             <div class="col-12">
                                 <div class="card">
                                     <div class="card-body">

                                         <form name="frm">
                                             <div class="row">
                                                
                                              
												<div class="col-md-4">
															<div class="form-group row">
																<div class="col-md-5">
																	<label class="col-form-label">MMU</label>
																</div>
																<div class="col-md-7">
																	<select class="form-control" id="mmuId">
																	<option value="0">All</option>
																	</select>
																</div>
															</div>
												</div>
                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <label class="col-md-5 col-form-label">From Date:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <div class="dateHolder ">
                                                                 <input type="text"  class="calDate datePickerInput form-control" id="fromdate" placeholder="DD/MM/YYYY" name="date" onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
                                                             </div>

                                                         </div>
                                                     </div>
                                                 </div>

                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <label class="col-md-5 col-form-label">To Date:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <div class="dateHolder ">
                                                                 <input type="text"  class="calDate datePickerInput form-control" id="todate" placeholder="DD/MM/YYYY" name="date" onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
                                                             </div>
                                                         </div>
                                                     </div>
                                                 </div>
                                                 
                                                 <div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">Gender</label>
															</div>
															<div class="col-md-7">
																<select class="form-control" id="genderId">
				
																</select>
															</div>
														</div>
												</div>
												
												 <div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">From Age</label>
															</div>
															<div class="col-md-7">
																<input type="text" name="fromAge" id="fromAge" class="form-control" placeholder="From Age" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" onblur="validateAge()" maxlength="3">
				                                  		</div>
														</div>
												</div>
												
												 <div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">To Age</label>
															</div>
															<div class="col-md-7">
																<input type="text" name="toAge" id="toAge" class="form-control" placeholder="To Age" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" onblur="validateAge()" maxlength="3">
															</div>
														</div>
												</div>
												<div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">Referral</label>
															</div>
															<div class="col-md-7">
															<select class="form-control" id="referral">
															       <option value="">Select</option>
																	<option value="Y">Yes</option>
																	<option value="N">No</option>
															</select>
															</div>
														</div>
												</div>
												 </div>
                                              
                                            
											<div class="row">
		                                	<div class="col-12 m-t-10 text-right">
		                               			<button type="button" class="btn btn-primary reception_mi_reports"  onclick="generateReport();"> Generate PDF</button>
		                               		</div>	</div>
		                               		 <div class="row">
		                               		 <div class="col-12 m-t-10 text-right">
		                               			<button type="button" class="btn btn-primary reception_mi_reports"  onclick="generatExcelReport();"> Generate Excel</button>
		                               			
		                               		</div>
	                               		</div> 
                                         </form>

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

         <!-- END wrapper -->

         <!-- jQuery  -->


</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
<%@include file="..//view/reportProgressDialog.jsp"%>
