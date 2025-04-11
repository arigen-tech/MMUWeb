<%@page import="java.util.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Radiology Report</title>
<%@include file="..//view/commonJavaScript.jsp"%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/wysiwyg.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/wysiwyg-color.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/wysiwyg-settings.js"></script>  --%>
</head>
<script type="text/javascript" language="javascript">
<%			

%>
$j(document).ready(function() {
	
	var data = ${data};
	$j('#patient_name').val(data.resultValidationData[0].patientName);
	$j('#age').val(data.resultValidationData[0].age);
	$j('#gender').val(data.resultValidationData[0].gender);
	$j('#service_no').val(data.resultValidationData[0].serviceNo);
	$j('#relation').val(data.resultValidationData[0].relation);
	$j('#result').html(data.resultEntry);
	$j('#relation').val(data.resultValidationData[0].relation);
	$j('#investigationName').val(data.resultValidationData[0].investigationName);
	$j('#result_dt_id').val(data.resultValidationData[0].resultDtId);
	$j('#result_hd_id').val(data.resultValidationData[0].resultHdId);
	$j('#dId').val(data.dId);
	$j('#docName').val(data.docName);
	$j('#dFormat').val(data.dFormat);
	$j('#ridcId').val(data.resultValidationData[0].ridcId);
	$j('#entered_by').val(data.resultValidationData[0].enteredByRank +' '+data.resultValidationData[0].enteredBy);
	$j('#validated_by').val(data.resultValidationData[0].virifiedByRank +' '+data.resultValidationData[0].verifiedBy);
	$j('#remarks').val(data.resultValidationData[0].remarks);
	var flagData = ${flag};
	if(flagData.flag == 'resultEntry'){
		$j('#validated_by_div').hide();
	}
	
	if(flagData.flag == 'validation'){
		$j('#validated_by_div').show();
	}

});

	function downloadDoc(){
		var ridcId = $j('#ridcId').val();	
		if(ridcId == ''){
			alert("No Document Found");
			return;
		}
 		var dId = $j('#dId').val();
 		var docName = $j('#docName').val();
 		var dFormat = $j('#dFormat').val();
 		window.location = "../downloadDocumentFromRIDC?dId="+dId+"&"+"docName="+docName+"&"+"dFormat="+dFormat+"";
 		
 		/* $.get("../downloadDocumentFromRIDC",{"dId":dId,"docName":docName,"dFormat":dFormat},
 		function(data){
 			alert("response");
 		},"json"); */
 		
 	}

</script>
<body>


<div id="wrapper">

	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Radiology Report</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form>
								
								
								
								<div class="row">
         <div class="col-md-4">
                <div class="form-group row">
                    <label for="fName" class="col-md-5 col-form-label colonAfter">  Name
                       </label>
                    <div class="col-md-7">
                        <input type="text"  readonly class="form-control-plaintext"    id="patient_name" name="Name" >
                    </div>
                </div>
            </div>
   
         
            <div class="col-md-4">
                <div class="form-group row">
                    <label for="service" class="col-md-5 col-form-label colonAfter">Service No.
                        </label>
                    <div class="col-md-7">
                        <input type="text"  readonly class="form-control-plaintext"  id="service_no" name="empService" validate="Service No,string,yes">
                    </div>
                </div>
            </div>
           
              <div class="col-md-4">
         <div class="form-group row">
          <label for="service" class="col-md-5 col-form-label colonAfter">Relation</label>
          <div class="col-md-7">
           <input type="text"  readonly class="form-control-plaintext"
            id="relation" name="relation"  >  
          </div>
         </div>
      </div>
     
      <div class="col-md-4">
         <div class="form-group row">
          <label for="service" class="col-md-5 col-form-label colonAfter">Age</label>
          <div class="col-md-7">
           <input type="text"  readonly class="form-control-plaintext"  id="age"
            name="patientAge" >
          </div>
         </div>
      </div>
     
     
      <div class="col-md-4">
         <div class="form-group row">
          <label class="col-md-5 col-form-label colonAfter">Gender</label>
          <div class="col-md-7">
           <input type="text"  readonly class="form-control-plaintext"  id="gender"
            name="gender" >
          </div>
         </div>
                              </div>
                             
                              <div class="col-md-4">
         <div class="form-group row">
          <label class="col-md-5 col-form-label colonAfter">Investigation Name</label>
          <div class="col-md-7">
           <input type="text"  readonly  class="form-control-plaintext"  id="investigationName"
            name="investigationName">
          </div>
         </div>
                              </div>
            </div>
            
            
            
         <div class="row">
           <div class="col-md-12">
           
           <h6 class="text-theme font-weight-bold">Result</h6>
          <div class="form-group row">          
           <div class="col-md-12">
            <!-- <textarea type="text" class="form-control" id="result"
             name="result"></textarea> -->
             <div id="result" class="result_describe"></div>
           </div>
          </div>
             </div>                              
             </div>
          <div class="row">
          	<div class="col-md-4">
				<div class="form-group row">
					<label class="col-sm-5 col-form-label">Remarks</label>
					<div class="col-sm-7">
						<textarea class="form-control" id="remarks" name="remarks"></textarea>
					</div>
				</div>
			</div>
          </div>                   
         <div class="row">
            <div class="col-md-4">
                <div class="form-group row">
                    <label for="rank" class="col-md-5 col-form-label colonAfter">Result Entered By</label>
                    <div class="col-md-7">
                        <input type="text"  readonly class="form-control-plaintext"  id="entered_by" name="result_entered_by" >
                    </div>
                </div>
            </div>
            <div class="col-md-4" id="validated_by_div">
                <div class="form-group row">
                    <label for="fName" class="col-md-5 col-form-label colonAfter">Result Validated By
                       </label>
                    <div class="col-md-7">
                        <input type="text"  readonly class="form-control-plaintext"  id="validated_by" name="validated_by">
                    </div>
                </div>
            </div>            
         </div>
										<div class="row">
											<div class="col-md-12">
												<div class="btn-left-all"></div>
												<div class="btn-right-all">
													<!-- <button type="button" class="btn btn-primary"
														onclick="downloadDoc()">Download/View Document</button> -->
													<input type="button" class="btn btn-primary opd_submit_btn" value="Download/View Document" onclick="downloadDoc();">
												</div>
											</div>
										</div>


										<input type="hidden" id="result_dt_id">						
							 <input type="hidden" id="result_hd_id">
							 <input type="hidden" id="dId" name=""dId"">
							 <input type="hidden" id="docName" name="docName">
							 <input type="hidden" id="dFormat" name="dFormat">
							 <input type="hidden" id="ridcId" name="ridcId">
							</form>

							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

</div>		
								
								
								
								
								
								
								

</body>
</html>