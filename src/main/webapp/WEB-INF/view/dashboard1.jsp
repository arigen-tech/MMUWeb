<%@page import="java.util.Date"%>
    <%@page import="java.util.Calendar"%>
        <%@page import="java.text.SimpleDateFormat"%>
            <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
                <%@include file="..//view/leftMenu.jsp"%>
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="utf-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Indian Coast Guard</title>
                        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
                        <meta content="Coderthemes" name="author" />
                        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                        <%-- <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" /> --%>
                            <!-- App favicon -->
                            <link rel="icon" type="images/favicon-32x32.png" sizes="32x32" href="${pageContext.request.contextPath}/resources/images/favicon.ico">

                            <%-- <script src="${pageContext.request.contextPath}/resources/js/canvasjs.min.js"></script> --%>

                            <%@include file="..//view/commonJavaScript.jsp"%>
                            
                            <link href="${pageContext.request.contextPath}/resources/css/owl.carousel.css" rel="stylesheet" type="text/css"/>
					<link href="${pageContext.request.contextPath}/resources/css/owl.theme.default.min.css" rel="stylesheet" type="text/css"/>

                    </head>
                    
                     
                    <%
int hospitalId=0;
if(session.getAttribute("hospital_id")!=null)
{
hospitalId =(Integer)session.getAttribute("hospital_id"); 
}

int userId=0;
if(session.getAttribute("user_id")!=null)
{
	userId =(Integer)session.getAttribute("user_id"); 
}

SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

Calendar c = Calendar.getInstance(); 
Date currentDate1 = c.getTime();
String currentDate=formatter.format(currentDate1); 

c.set(Calendar.DATE, 01);
Date startDate1 = c.getTime();

c.set(Calendar.DATE, 30);
Date enddate1 = c.getTime();
String startDate=formatter.format(startDate1); 
String enddate=formatter.format(enddate1); 

%>
<script type="text/javascript">
	window.history.forward();
	function preventBack() {
		window.history.forward(1);
	}
</script>
                        <script type="text/javascript">
                            var comboArray = [];
                            var hospitalCode;
                            var fdate;
                            var tdate;

                            window.onload = function() {
                            	$j('#selectMB').val(0);
                                $j('#selectME').val(0);
                                executeProcedureForDashBoard();                                
                                $j('input[type="radio"]').click(function(){
                                  	 
                                    var inputValue = $j(this).attr("value");
                                    
                                    $j("#radioVal").val(inputValue);
                                    executeEvent();
                                   
                                    
                                   
                                }); 
                            }
							
                            function executeProcedureForDashBoard(item1) {
                            	var mbVal = 0;
                            	var meVal = 0;
								if(item1 != undefined && item1 != '' && !isNaN(item1)){
									mbVal = $j('#selectMB').val();
									meVal = $j('#selectME').val();
								}
                                	
                                $j('#unitId').html("");
                                var hospitalId = <%=hospitalId%>;
                                var userId = <%=userId%>;
                                var combohospitalId = 0;
                                
                                var inputValue="0";
                                
                               var value= $j("#radioVal").val();
                               // alert(value)

                                
                                var params = {
                                    "hospitalId": hospitalId,
                                    "tUserHospitalId": combohospitalId,
                                    "iOption":value,
                                    "mbVal":mbVal,
                                    "meVal":meVal
                                }
                               
                                $j.ajax({
                                    type: "POST",
                                    contentType: "application/json",
                                    url: '${pageContext.request.contextPath}/dashboard/executeProcedureForDashBoard',
                                    data: JSON.stringify(params),
                                    dataType: "json",
                                    cache: false,
                                    success: function(result) {
                                    	
                                    	$j('#barLegend').empty();
                                    	$j('#morris-bar-example').empty();
                                    	
                                    	$j('#barLegendAdmission').empty();
                                    	$j('#morris-bar-admission').empty();
                                    	for(var i=0;i<result.dashboardData.ref_cursor3.length;i++){
											
											
											if(result.dashboardData.ref_cursor3[0]!= undefined){
												
												
												if(result.dashboardData.ref_cursor3[i].TOTAL_OPD!=undefined){
													$j("#totalOPD").html(result.dashboardData.ref_cursor3[i].TOTAL_OPD);													
													
												}
												else
													{
														$j("#totalOPD").html("0");
													}
												if(result.dashboardData.ref_cursor3[i].ATT_C!=undefined){
													$j("#totalAttc").html(result.dashboardData.ref_cursor3[i].ATT_C);
												}
												else
													{
														$j("#totalAttc").html("0");
													}
											
												if(result.dashboardData.ref_cursor3[i].TOTAL_ME!=undefined){
													$j("#totalMedicalExam").html(result.dashboardData.ref_cursor3[i].TOTAL_ME);
													}
												else
												{
													$j("#totalMedicalExam").html("0");
												}
												
												if(result.dashboardData.ref_cursor3[i].TOTAL_MB!=undefined){
													$j("#totalMedicalBoard").html(result.dashboardData.ref_cursor3[i].TOTAL_MB);
												}
												else
													{
													$j("#totalMedicalBoard").html("0");
													}
											}
												
										}
                                    	
									var	unitValues="";
										
										
										var respData = result.dashboardData.ref_cursor1;
										
										for(count in respData){
											
											
											unitValues += '<option value='+respData[count].HOSPITAL_ID+'>'
											+ respData[count].HOSPITAL_NAME
											+ '</option>';
										}
									
									
									$j('#unitId').append(unitValues); 
									$j('#unitId2').append(unitValues); 
										
                                  
                                     console.log(result);
                                     var ref_cursor2_List=result.dashboardData.ref_cursor2;
                                     var temp='[';
                                     
                                     var customer= new Array();
                                     for(count in ref_cursor2_List){
                                         //temp = temp+"{y:'"+ref_cursor2_List[count].DIMDATE+"',a:"+ref_cursor2_List[count].DIMTYPE_OPD+",b:"+ref_cursor2_List[count].DIMTYPE_ATTC+",c:"+ref_cursor2_List[count].DIMTYPE_REFERRAL+",d:"+ref_cursor2_List[count].DIMTYPE_OTHERS+"},";
                                         customer.push("{'y':'"+ref_cursor2_List[count].DIMDATE+"','a':'"+ref_cursor2_List[count].DIMTYPE_OPD+"','b':'"+ref_cursor2_List[count].DIMTYPE_ATTC+"','c':'"+ref_cursor2_List[count].DIMTYPE_REFERRAL+"','d':'"+ref_cursor2_List[count].DIMTYPE_OTHERS+"'}");
                                    }
                                     
                                     var customer1=JSON.stringify(customer); 
                                        customer1 = customer1.replace(/\"/g,'');
                                       
                                         customer1 = customer1.replace(/\'/g,'"'); 
                                       
                                        
                                         var customers = JSON.parse(customer1);
                                         
                                     
                                     
                                     
                                      var ykeys=['a', 'b', 'c', 'd'];
                                      var labels=['OPD', "Att 'C'", 'Referral', 'Others'];
                                      var lineColors = ['#F24F7C', '#716CB0', '#e67a77', '#1b597c'];
                                      var  mybarlegend = 'barLegend';
                                     var barCharts = Morris.Bar({
                                            element: 'morris-bar-example',
                                            data: customers,
                                            xkey: 'y',
                                            ykeys: ykeys,
                                            labels: labels,
                                            barColors: lineColors,
                                            gridLineColor: '#000',
                                            yLabelFormat: function(y){return y != Math.round(y)?'':y;},
                                             labelTop:true
                                        });
                                     
                                     barCharts.options.labels.forEach(function(label, i) {
                              			var legendItem = $('<span style="display:inline-block; margin-right:10px;"></span>').text( label +'   ' ).prepend('<br><span>&nbsp;</span>');
                              			legendItem.find('span')
                              			  .css('backgroundColor', barCharts.options.barColors[i])
                              			  .css('width', '20px')
                              			  .css('display', 'inline-block')
                              			  .css('margin', '5px');
                              			$('#'+mybarlegend).append(legendItem)
                              		  });
                                     
                                     
                                     
                                     var ref_cursor6_List=result.dashboardData.ref_cursor6;
                                     var temp='[';
                                     
                                     var customer6= new Array();
                                     for(count in ref_cursor6_List){
                                         //temp = temp+"{y:'"+ref_cursor2_List[count].DIMDATE+"',a:"+ref_cursor2_List[count].DIMTYPE_OPD+",b:"+ref_cursor2_List[count].DIMTYPE_ATTC+",c:"+ref_cursor2_List[count].DIMTYPE_REFERRAL+",d:"+ref_cursor2_List[count].DIMTYPE_OTHERS+"},";
                                         customer6.push("{'y':'"+ref_cursor6_List[count].DIMDATE+"','a':'"+ref_cursor6_List[count].DIMTYPE_AD+"','b':'"+ref_cursor6_List[count].DIMTYPE_DS+"'}");
                                    }
                                     
                                     var customer16=JSON.stringify(customer6); 
                                        customer16 = customer16.replace(/\"/g,'');
                                       
                                         customer16 = customer16.replace(/\'/g,'"'); 
                                       
                                        
                                         var admissionData = JSON.parse(customer16);
                                         
                                     
                                     
                                     
                                    /*   var ykeys=['a', 'b'];
                                      var labels=['Addmission','discharge'];
                                      var lineColors = ['#F24F7C', '#716CB0'];
                                      var  mybarlegend = 'barLegend';
                                     var barCharts = Morris.Bar({
                                            element: 'morris-bar-example',
                                            data: customers,
                                            xkey: 'y',
                                            ykeys: ykeys,
                                            labels: labels,
                                            barColors: lineColors,
                                            gridLineColor: '#000',
                                             labelTop:true
                                        });
                                      */
                                 /*     barCharts.options.labels.forEach(function(label, i) {
                              			var legendItem = $('<span style="display:inline-block; margin-right:10px;"></span>').text( label +'   ' ).prepend('<br><span>&nbsp;</span>');
                              			legendItem.find('span')
                              			  .css('backgroundColor', barCharts.options.barColors[i])
                              			  .css('width', '20px')
                              			  .css('display', 'inline-block')
                              			  .css('margin', '5px');
                              			$('#'+mybarlegend).append(legendItem)
                              		  });
                                      */
                                     
                                     //Admission Chart
                                     
                                    /*  var admissionData  = [
                                             { y: 'JAN', a: 100, b: 90},
                                             { y: 'FEB', a: 75,  b: 65 },
                                             { y: 'MAR', a: 50,  b: 40},
                                             { y: 'APR', a: 75,  b: 65 },
                                             { y: 'MAY', a: 50,  b: 40},
                                             { y: 'JUN', a: 75,  b: 65},
                                             { y: 'JUL', a: 100, b: 90},
                                             { y: 'AUG', a: 100, b: 90},
                                             { y: 'SEP', a: 75,  b: 65 },
                                             { y: 'OCT', a: 50,  b: 40},
                                             { y: 'NOV', a: 75,  b: 65 },
                                             { y: 'DEC', a: 100, b: 90},
                                           ];
                                      */
                                     
                                      var ykeys=['a', 'b'];
                                      var labels=['Admission', 'Discharge'];
                                      var lineColors = ['#33b4db', '#1b597c']; 
                                      var  mybarlegend = 'barLegendAdmission';
                                     var barCharts = Morris.Bar({
                                            element: 'morris-bar-admission',
                                            data: admissionData,
                                            xkey: 'y',
                                            ykeys: ykeys,
                                            labels: labels,
                                            barColors: lineColors,
                                            gridLineColor: '#000',
                                            yLabelFormat: function(y){return y != Math.round(y)?'':y;},
                                             labelTop:true
                                        });
                                     
                                     //Admission Chart End
                                     
                                     
                                     barCharts.options.labels.forEach(function(label, i) {
                             			var legendItem = $('<span style="display:inline-block; margin-right:10px;"></span>').text( label +'   ' ).prepend('<br><span>&nbsp;</span>');
                             			legendItem.find('span')
                             			  .css('backgroundColor', barCharts.options.barColors[i])
                             			  .css('width', '20px')
                             			  .css('display', 'inline-block')
                             			  .css('margin', '5px');
                             			$('#'+mybarlegend).append(legendItem)
                             		  });
                                     $j('#mb-donut-chart').empty();
                                     $j('#me-donut-chart').empty();
                                  // Donut Chart 1
                                  var totalMe = 0;
                                  var dueMe = 0;
                                  var pendingMe = 0;
                                  var completeMe = 0;
                                  var totalMb = 0;
                                  var dueMb = 0;
                                  var pendingMb = 0;
                                  var completeMb = 0;
                                  if(result.dashboardData.ref_cursor4.length >0){
                                	  if(result.dashboardData.ref_cursor4[0].TOTAL != undefined && result.dashboardData.ref_cursor4[0].TOTAL != ''){
                                		  totalMb = parseInt(result.dashboardData.ref_cursor4[0].TOTAL);
                                	  }
                                	  if(result.dashboardData.ref_cursor4[0].DUE != undefined && result.dashboardData.ref_cursor4[0].DUE != ''){
                                		  dueMb = parseInt(result.dashboardData.ref_cursor4[0].DUE);
                                	  }
                                	  if(result.dashboardData.ref_cursor4[0].PENDING != undefined && result.dashboardData.ref_cursor4[0].PENDING != ''){
                                		  pendingMb = parseInt(result.dashboardData.ref_cursor4[0].PENDING);
                                	  }
                                	  if(result.dashboardData.ref_cursor4[0].COMPLETE != undefined && result.dashboardData.ref_cursor4[0].COMPLETE != ''){
                                		  completeMb = parseInt(result.dashboardData.ref_cursor4[0].COMPLETE);
                                	  }                                     
                                  }
                                  if(result.dashboardData.ref_cursor5.length >0){
                                	  if(result.dashboardData.ref_cursor5[0].TOTAL != undefined && result.dashboardData.ref_cursor5[0].TOTAL != ''){
                                		  totalMe = parseInt(result.dashboardData.ref_cursor5[0].TOTAL);
                                	  }
                                	  if(result.dashboardData.ref_cursor5[0].DUE != undefined && result.dashboardData.ref_cursor5[0].DUE != ''){
                                		  dueMe = parseInt(result.dashboardData.ref_cursor5[0].DUE);
                                	  }
                                	  if(result.dashboardData.ref_cursor5[0].PENDING != undefined && result.dashboardData.ref_cursor5[0].PENDING != ''){
                                		  pendingMe = parseInt(result.dashboardData.ref_cursor5[0].PENDING);
                                	  }
                                	  if(result.dashboardData.ref_cursor5[0].COMPLETE != undefined && result.dashboardData.ref_cursor5[0].COMPLETE != ''){
                                		  completeMe = parseInt(result.dashboardData.ref_cursor5[0].COMPLETE);
                                	  }
                                	  
                                  }
                                                                         
                                  // Donut Chart 2
                                     var donutData2 = [               
                                    	 {label: "Total MB", value: totalMb},
                                         {label: "Pending", value: dueMb},
                                         {label: "Completed", value: pendingMb},
                                         {label: "Over Due", value: completeMb}
                                     ];
                                     var colorsD2 = ['#f13c6c', '#615ca8', '#ebc142', '#1a2142'];
                                     
                                     Morris.Donut({
                                         element: 'mb-donut-chart',
                                         data: donutData2,
                                         colors: colorsD2
                                     });
                                     
                                     var donutData1 = [
                                    	 {label: "Total ME", value: totalMe},
                                         {label: "Completed", value: completeMe},                                         
                                         {label: "Pending", value: pendingMe},                
                                         {label: "Over Due", value: dueMe},                                   
                                     ];
                                     var colorsD1 = ['#e67a77', '#3bc0c3', '#1a2942', '#615ca8'];
                                     
                                     Morris.Donut({
                                         element: 'me-donut-chart',
                                         data: donutData1,
                                         colors: colorsD1
                                     });
                                     
                                    }
                                });

                            }
                            
                            
                            function executeProcedureForDashBoardforMbOrMe(item1, item2) {
                            	var mbVal = 0;
                            	var meVal = 0;
								if(item1 != undefined && item1 != '' && !isNaN(item1)){
									if(item2 == 'selectMB'){
										mbVal = $j('#selectMB').val();
									}else if(item2 == 'selectME'){
										meVal = $j('#selectME').val();
									}													
								}
								                                	
                                //$j('#unitId').html("");
                                var hospitalId = <%=hospitalId%>;
                                var userId = <%=userId%>;
                                var combohospitalId = 0;
                                if ($j("#unitId").val() == hospitalId) {
                                     combohospitalId = 0
                                } else {
                                     combohospitalId = $j("#unitId").val();
                                }
                                var inputValue="0";
                                
                               var value= $j("#radioVal").val();
                               // alert(value)

                                
                                var params = {
                                    "hospitalId": hospitalId,
                                    "tUserHospitalId": combohospitalId,
                                    "iOption":value,
                                    "mbVal":mbVal,
                                    "meVal":meVal
                                }
                               
                                $j.ajax({
                                    type: "POST",
                                    contentType: "application/json",
                                    url: '${pageContext.request.contextPath}/dashboard/executeProcedureForDashBoard',
                                    data: JSON.stringify(params),
                                    dataType: "json",
                                    cache: false,
                                    success: function(result) {
                                    	
                                    	/* $j('#barLegend').empty();
                                    	$j('#morris-bar-example').empty();   */
                                    	if(item2 == 'selectMB'){
                                    		$j('#mb-donut-chart').empty();
    									}else if(item2 == 'selectME'){
    										$j('#me-donut-chart').empty();
    									}	
                                     
                                     
                                  // Donut Chart 1
                                  var totalMe = 0;
                                  var dueMe = 0;
                                  var pendingMe = 0;
                                  var completeMe = 0;
                                  var totalMb = 0;
                                  var dueMb = 0;
                                  var pendingMb = 0;
                                  var completeMb = 0;
                                  if(result.dashboardData.ref_cursor4.length >0){
                                	  if(result.dashboardData.ref_cursor4[0].TOTAL != undefined && result.dashboardData.ref_cursor4[0].TOTAL != ''){
                                		  totalMb = parseInt(result.dashboardData.ref_cursor4[0].TOTAL);
                                	  }
                                	  if(result.dashboardData.ref_cursor4[0].DUE != undefined && result.dashboardData.ref_cursor4[0].DUE != ''){
                                		  dueMb = parseInt(result.dashboardData.ref_cursor4[0].DUE);
                                	  }
                                	  if(result.dashboardData.ref_cursor4[0].PENDING != undefined && result.dashboardData.ref_cursor4[0].PENDING != ''){
                                		  pendingMb = parseInt(result.dashboardData.ref_cursor4[0].PENDING);
                                	  }
                                	  if(result.dashboardData.ref_cursor4[0].COMPLETE != undefined && result.dashboardData.ref_cursor4[0].COMPLETE != ''){
                                		  completeMb = parseInt(result.dashboardData.ref_cursor4[0].COMPLETE);
                                	  }                                     
                                  }
                                  if(result.dashboardData.ref_cursor5.length >0){
                                	  if(result.dashboardData.ref_cursor5[0].TOTAL != undefined && result.dashboardData.ref_cursor5[0].TOTAL != ''){
                                		  totalMe = parseInt(result.dashboardData.ref_cursor5[0].TOTAL);
                                	  }
                                	  if(result.dashboardData.ref_cursor5[0].DUE != undefined && result.dashboardData.ref_cursor5[0].DUE != ''){
                                		  dueMe = parseInt(result.dashboardData.ref_cursor5[0].DUE);
                                	  }
                                	  if(result.dashboardData.ref_cursor5[0].PENDING != undefined && result.dashboardData.ref_cursor5[0].PENDING != ''){
                                		  pendingMe = parseInt(result.dashboardData.ref_cursor5[0].PENDING);
                                	  }
                                	  if(result.dashboardData.ref_cursor5[0].COMPLETE != undefined && result.dashboardData.ref_cursor5[0].COMPLETE != ''){
                                		  completeMe = parseInt(result.dashboardData.ref_cursor5[0].COMPLETE);
                                	  }
                                	  
                                  }
                                                                         
                                  // Donut Chart 2
                                  if(item2 == 'selectMB'){
                                     var donutData2 = [               
                                    	 {label: "Total MB", value: totalMb},
                                         {label: "Pending", value: dueMb},
                                         {label: "Completed", value: pendingMb},
                                         {label: "Over Due", value: completeMb}
                                     ];
                                     var colorsD2 = ['#f13c6c', '#615ca8', '#ebc142', '#1a2142'];
                                     
                                     Morris.Donut({
                                         element: 'mb-donut-chart',
                                         data: donutData2,
                                         colors: colorsD2
                                     });
                                  }else{
                                     
	                                     var donutData1 = [
	                                    	 {label: "Total ME", value: totalMe},
	                                         {label: "Completed", value: completeMe},                                         
	                                         {label: "Pending", value: pendingMe},                
	                                         {label: "Over Due", value: dueMe},                                   
	                                     ];
	                                     var colorsD1 = ['#e67a77', '#3bc0c3', '#1a2942', '#615ca8'];
	                                     
	                                     Morris.Donut({
	                                         element: 'me-donut-chart',
	                                         data: donutData1,
	                                         colors: colorsD1
	                                     });
                                  		}
                                     
                                    }
                                });

                            }

                               /*  $j.ajax({
                                    type: "POST",
                                    contentType: "application/json",
                                    url: '${pageContext.request.contextPath}/dashboard/executeProcedureForDashBoard',
                                    data: JSON.stringify(params),
                                    dataType: "json",
                                    cache: false,
                                    success: function(result) {
                                    	
                                    	
                                    	
                                    	var unitValues="";
										
										
										var respData = result.dashboardData.ref_cursor1;
										
										for(count in respData){
											
											
											unitValues += '<option value='+respData[count].HOSPITAL_ID+'>'
											+ respData[count].HOSPITAL_NAME
											+ '</option>';
										}
									
									
									$j('#unitId').append(unitValues); 
                                    	
                                    }
                                });

                            } */
                            
                            
							function executeEvent() {

                            	$j("#morris-bar-example").empty();
                            	$j('#morris-bar-admission').empty();
                                //$j('#unitId').html("");
                            	var mbVal = 0;
                            	var meVal = 0;
                            	var optionMb = $j('#selectMB').val();
								if(optionMb != undefined && optionMb != '' && !isNaN(optionMb)){
									mbVal = $j('#selectMB').val();
								}
								var optionMe = $j('#selectME').val();
								if(optionMe != undefined && optionMe != '' && !isNaN(optionMe)){
									meVal = $j('#selectME').val();
								}
                                
                                var hospitalId = <%=hospitalId%>;
                                var userId = <%=userId%>;
                               
                                var temId = $j("#unitId").val();

                                var combohospitalId=0;
                                if ($j("#unitId").val() == hospitalId) {
                                     combohospitalId = 0
                                } else {
                                     combohospitalId = $j("#unitId").val();
                                }
                                
                                var value="0";
                                
                               var value= $j("#radioVal").val();
                               // alert(value)

                                
                                var params = {
                                    "hospitalId": hospitalId,
                                    "tUserHospitalId": combohospitalId,
                                    "iOption":value,
                                    "mbVal":mbVal,
                                    "meVal":meVal
                                }
                                
                                $j.ajax({
                                    type: "POST",
                                    contentType: "application/json",
                                    url: '${pageContext.request.contextPath}/dashboard/executeProcedureForDashBoard',
                                    data: JSON.stringify(params),
                                    dataType: "json",
                                    cache: false,
                                    success: function(result) {                                    	
                                    	
                                   		$j('#mb-donut-chart').empty();    									
   										$j('#me-donut-chart').empty();
    									
                                    	for(var i=0;i<result.dashboardData.ref_cursor3.length;i++){
											
											
											if(result.dashboardData.ref_cursor3[0]!= undefined){
												
												
												if(result.dashboardData.ref_cursor3[i].TOTAL_OPD!=undefined){
													$j("#totalOPD").html(result.dashboardData.ref_cursor3[i].TOTAL_OPD);													
													
												}
												else
													{
														$j("#totalOPD").html("0");
													}
												if(result.dashboardData.ref_cursor3[i].ATT_C!=undefined){
													$j("#totalAttc").html(result.dashboardData.ref_cursor3[i].ATT_C);
												}
												else
													{
														$j("#totalAttc").html("0");
													}
											
												if(result.dashboardData.ref_cursor3[i].TOTAL_ME!=undefined){
													$j("#totalMedicalExam").html(result.dashboardData.ref_cursor3[i].TOTAL_ME);
													}
												else
												{
													$j("#totalMedicalExam").html("0");
												}
												
												if(result.dashboardData.ref_cursor3[i].TOTAL_MB!=undefined){
													$j("#totalMedicalBoard").html(result.dashboardData.ref_cursor3[i].TOTAL_MB);
												}
												else
													{
													$j("#totalMedicalBoard").html("0");
													}
											}
												
										}
                                    	
									/* var	unitValues="";
										
										
										var respData = result.dashboardData.ref_cursor1;
										
										for(count in respData){
											
											
											unitValues += '<option value='+respData[count].HOSPITAL_ID+'>'
											+ respData[count].HOSPITAL_NAME
											+ '</option>';
										}
									
									
									$j('#unitId').append(unitValues);  */
                                    	
                                  
                                     console.log(result);
                                     var ref_cursor2_List=result.dashboardData.ref_cursor2;
                                     var temp='[';
                                     
                                     var customer= new Array();
                                     for(count in ref_cursor2_List){
                                         //temp = temp+"{y:'"+ref_cursor2_List[count].DIMDATE+"',a:"+ref_cursor2_List[count].DIMTYPE_OPD+",b:"+ref_cursor2_List[count].DIMTYPE_ATTC+",c:"+ref_cursor2_List[count].DIMTYPE_REFERRAL+",d:"+ref_cursor2_List[count].DIMTYPE_OTHERS+"},";
                                         customer.push("{'y':'"+ref_cursor2_List[count].DIMDATE+"','a':'"+ref_cursor2_List[count].DIMTYPE_OPD+"','b':'"+ref_cursor2_List[count].DIMTYPE_ATTC+"','c':'"+ref_cursor2_List[count].DIMTYPE_REFERRAL+"','d':'"+ref_cursor2_List[count].DIMTYPE_OTHERS+"'}");
                                    }
                                     
                                     var customer1=JSON.stringify(customer); 
                                        customer1 = customer1.replace(/\"/g,'');
                                       
                                         customer1 = customer1.replace(/\'/g,'"'); 
                                       
                                        
                                         var customers = JSON.parse(customer1);
                                         
                                     
                                     
                                     
                                      var ykeys=['a', 'b', 'c', 'd'];
                                      var labels=['OPD', "Att 'C'", 'Referral', 'Others'];
                                      var lineColors = ['#F24F7C', '#716CB0', '#e67a77', '#1b597c'];
                                     Morris.Bar({
                                            element: 'morris-bar-example',
                                            data: customers,
                                            xkey: 'y',
                                            ykeys: ykeys,
                                            labels: labels,
                                            barColors: lineColors,
                                            gridLineColor: '#000',
                                            yLabelFormat: function(y){return y != Math.round(y)?'':y;},
                                             labelTop:true
                                        });
                                     
                                     
 //Admission Chart
                                     
                                   /*   var admissionData  = [
                                             { y: 'JAN', a: 100, b: 90},
                                             { y: 'FEB', a: 75,  b: 65 },
                                             { y: 'MAR', a: 50,  b: 40},
                                             { y: 'APR', a: 75,  b: 65 },
                                             { y: 'MAY', a: 50,  b: 40},
                                             { y: 'JUN', a: 75,  b: 65},
                                             { y: 'JUL', a: 100, b: 90},
                                             { y: 'AUG', a: 100, b: 90},
                                             { y: 'SEP', a: 75,  b: 65 },
                                             { y: 'OCT', a: 50,  b: 40},
                                             { y: 'NOV', a: 75,  b: 65 },
                                             { y: 'DEC', a: 100, b: 90},
                                           ]; */
                                     var ref_cursor6_List=result.dashboardData.ref_cursor6;
                                     var temp='[';
                                     
                                     var customer6= new Array();
                                     for(count in ref_cursor6_List){
                                         //temp = temp+"{y:'"+ref_cursor2_List[count].DIMDATE+"',a:"+ref_cursor2_List[count].DIMTYPE_OPD+",b:"+ref_cursor2_List[count].DIMTYPE_ATTC+",c:"+ref_cursor2_List[count].DIMTYPE_REFERRAL+",d:"+ref_cursor2_List[count].DIMTYPE_OTHERS+"},";
                                         customer6.push("{'y':'"+ref_cursor6_List[count].DIMDATE+"','a':'"+ref_cursor6_List[count].DIMTYPE_AD+"','b':'"+ref_cursor6_List[count].DIMTYPE_DS+"'}");
                                    }
                                     
                                     var customer16=JSON.stringify(customer6); 
                                        customer16 = customer16.replace(/\"/g,'');
                                       
                                         customer16 = customer16.replace(/\'/g,'"'); 
                                       
                                        
                                         var admissionData = JSON.parse(customer16);
                                     
                                         var ykeys=['a', 'b'];
                                         var labels=['Admission', 'Discharge'];
                                         var lineColors = ['#33b4db', '#1b597c']; 
                                         var  mybarlegend = 'barLegendAdmission';
                                        var barCharts = Morris.Bar({
                                               element: 'morris-bar-admission',
                                               data: admissionData,
                                               xkey: 'y',
                                               ykeys: ykeys,
                                               labels: labels,
                                               barColors: lineColors,
                                               gridLineColor: '#000',
                                               yLabelFormat: function(y){return y != Math.round(y)?'':y;},
                                                labelTop:true
                                           });
                                     
                                     //Admission Chart End
                                     
                                    
                                  
                                // Donut Chart 1
                                var totalMe = 0;
                                var dueMe = 0;
                                var pendingMe = 0;
                                var completeMe = 0;
                                var totalMb = 0;
                                var dueMb = 0;
                                var pendingMb = 0;
                                var completeMb = 0;
                                if(result.dashboardData.ref_cursor4.length >0){
                              	  if(result.dashboardData.ref_cursor4[0].TOTAL != undefined && result.dashboardData.ref_cursor4[0].TOTAL != ''){
                              		  totalMb = parseInt(result.dashboardData.ref_cursor4[0].TOTAL);
                              	  }
                              	  if(result.dashboardData.ref_cursor4[0].DUE != undefined && result.dashboardData.ref_cursor4[0].DUE != ''){
                              		  dueMb = parseInt(result.dashboardData.ref_cursor4[0].DUE);
                              	  }
                              	  if(result.dashboardData.ref_cursor4[0].PENDING != undefined && result.dashboardData.ref_cursor4[0].PENDING != ''){
                              		  pendingMb = parseInt(result.dashboardData.ref_cursor4[0].PENDING);
                              	  }
                              	  if(result.dashboardData.ref_cursor4[0].COMPLETE != undefined && result.dashboardData.ref_cursor4[0].COMPLETE != ''){
                              		  completeMb = parseInt(result.dashboardData.ref_cursor4[0].COMPLETE);
                              	  }                                     
                                }
                                if(result.dashboardData.ref_cursor5.length >0){
                              	  if(result.dashboardData.ref_cursor5[0].TOTAL != undefined && result.dashboardData.ref_cursor5[0].TOTAL != ''){
                              		  totalMe = parseInt(result.dashboardData.ref_cursor5[0].TOTAL);
                              	  }
                              	  if(result.dashboardData.ref_cursor5[0].DUE != undefined && result.dashboardData.ref_cursor5[0].DUE != ''){
                              		  dueMe = parseInt(result.dashboardData.ref_cursor5[0].DUE);
                              	  }
                              	  if(result.dashboardData.ref_cursor5[0].PENDING != undefined && result.dashboardData.ref_cursor5[0].PENDING != ''){
                              		  pendingMe = parseInt(result.dashboardData.ref_cursor5[0].PENDING);
                              	  }
                              	  if(result.dashboardData.ref_cursor5[0].COMPLETE != undefined && result.dashboardData.ref_cursor5[0].COMPLETE != ''){
                              		  completeMe = parseInt(result.dashboardData.ref_cursor5[0].COMPLETE);
                              	  }
                              	  
                                }
                                             
                                // Donut Chart 2
                                
                                   var donutData2 = [               
                                  	 {label: "Total MB", value: totalMb},
                                       {label: "Pending", value: dueMb},
                                       {label: "Completed", value: pendingMb},
                                       {label: "Over Due", value: completeMb}
                                   ];
                                   var colorsD2 = ['#f13c6c', '#615ca8', '#ebc142', '#1a2142'];
                                   
                                   Morris.Donut({
                                       element: 'mb-donut-chart',
                                       data: donutData2,
                                       colors: colorsD2
                                   });
                               
                                   
	                                     var donutData1 = [
	                                    	 {label: "Total ME", value: totalMe},
	                                         {label: "Completed", value: completeMe},                                         
	                                         {label: "Pending", value: pendingMe},                
	                                         {label: "Over Due", value: dueMe},                                   
	                                     ];
	                                     var colorsD1 = ['#e67a77', '#3bc0c3', '#1a2942', '#615ca8'];
	                                     
	                                     Morris.Donut({
	                                         element: 'me-donut-chart',
	                                         data: donutData1,
	                                         colors: colorsD1
	                                     });
                                	}
                                  
                                    
                                });                                            

                            }

                            <%-- function executeEvent() {
                               
                                var hospitalId = <%=hospitalId%>;
                                var userId = <%=userId%>;
                                /* alert($j("#unitId").val()) */

                                var temId = $j("#unitId").val();

                                if ($j("#unitId").val() == hospitalId) {
                                    var combohospitalId = 0
                                } else {
                                    var combohospitalId = $j("#unitId").val();
                                }

                                $j('#unitId').html("");

                                //alert(document.getElementById('unitId').value);

                                 var value= $j("#radioVal").val();
                              

                                 executeProcedureForDashBoard();
                               
                                var params = {
                                    "hospitalId": hospitalId,
                                    "tUserHospitalId": combohospitalId,
                                    "iOption":value

                                }

                                $j.ajax({
                                    type: "POST",
                                    contentType: "application/json",
                                    url: '${pageContext.request.contextPath}/dashboard/executeProcedureForDashBoard',
                                    data: JSON.stringify(params),
                                    dataType: "json",
                                    cache: false,
                                    success: function(result) {
										console.log(result);
                                    }
                                });

                            } --%>
                        </script>

                        <body>

                            <!-- Begin page -->
                            <div id="wrapper">

                                <!-- Top Bar Start -->
                                <%-- <div class="topbar">

                                    <!-- LOGO -->
                                    <div class="topbar-left">
                                        <a href="index.html" class="logo">
                                            <span>
                        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="" height="100%">
                    </span>
                                        </a>
                                    </div>

                                    <nav class="navbar-custom">

                                        <ul class="list-inline menu-left mb-0">
                                            <li class="float-left">
                                                <button class="button-menu-mobile open-left waves-light waves-effect">
                                                    <i class="mdi mdi-menu"></i>
                                                </button>
                                            </li>
                                        </ul>
                                    </nav>
                                </div> --%>

                                <!-- ============================================================== -->
                                <!-- Start right Content here -->
                                <!-- ============================================================== -->
                                <form id="dashboardForm" name="dashboardForm">
                                    <div class="content-page">
                                        <!-- Start content -->
                                        <input type="hidden" id="opdDataCount1" name="opdDataCount1" value="" />
                                        <div class="">
                                            <div class="container-fluid">

                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="page-title-box">
                                                            <h4 class="page-title float-left"></h4>

                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- end row -->

                                                <div class="row">
                                                    <div class="col-xl-3 col-md-6">
                                                        <div class="widget-panel widget-style-2 bg-pink">
                                                            <i class="fa fa-user-md"></i>
                                                            <h2 class="m-0 text-white" data-plugin="counterup" id="totalOPD">0</h2>
                                                            <div>Today OPD</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-md-6">
                                                        <div class="widget-panel widget-style-2 bg-purple">
                                                            <i class="fa fa-copyright"></i>
                                                            <h2 class="m-0 text-white" data-plugin="counterup" id="totalAttc">0</h2>
                                                            <div>Today Att 'C'</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-md-6">
                                                        <div class="widget-panel widget-style-2 bg-info">
                                                            <i class="fa fa-notes-medical"></i>
                                                            <h2 class="m-0 text-white" data-plugin="counterup" id="totalMedicalExam">0</h2>
                                                            <div>Today Medical Exam</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-md-6">
                                                        <div class="widget-panel widget-style-2 bg-primary">
                                                            <i class="fa fa-file-medical"></i>
                                                            <h2 class="m-0 text-white" data-plugin="counterup" id="totalMedicalBoard">0</h2>
                                                            <div>Today Medical Board</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- end row -->

                                              

                            <!-- Admission Bar Chart -->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="portlet">
                                        <!-- /primary heading -->
                                        <div class="portlet-heading graphs z9">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                       
                                                        </div>
                                                         <div class="col-md-4 bg-white">
                                                            <div class="btn-group btn-group-justified m-b-10 z9" style="border: 1px solid #33b0e0; ">
						                                            <span class="btn btn-light waves-effect waves-light filter-btn clicked" style="padding:7px;">
						                                              <div class="custom-control custom-radio">
						                                                        <input type="radio" id="customRadio12" name="customRadio2"  checked value="1" class="custom-control-input">
						                                                        <input type="hidden" id="radioVal" value="1"/>
						                                                        <label class="custom-control-label text-xs" for="customRadio12">Days</label>
						                                                    </div>
						                                            </span>
						                                            <span class="btn btn-light waves-effect waves-light filter-btn" style="padding:7px;">
						                                                  <div class="custom-control custom-radio">
						                                                        <input type="radio" id="customRadio22" name="customRadio2" value="2" class="custom-control-input">
						                                                        <label class="custom-control-label text-xs" for="customRadio22">Months</label>
						                                                    </div>
						                                                </span>
						                                            <span class="btn btn-light waves-effect waves-light filter-btn" style="padding:7px;">
						                                                <div class="custom-control custom-radio">
						                                                        <input type="radio" id="customRadio32" name="customRadio2" value="3" class="custom-control-input">
						                                                        <label class="custom-control-label text-xs" for="customRadio32">Years</label>
						                                                    </div>
						                                                 </span>
						                                        </div>     
                                               
                                                        </div>
                                                        
                                                        
                                                        
                                                        
                                                        <div class="col-md-4 z9 bg-white">
                                                            <div class="form-group row">
                                                                <label class="col-md-5 col-form-label">Unit / Location</label>
                                                                <div class="col-md-7">
                                                                 <select class="form-control selectTextWarp" id="unitId" name="unitId" onchange="executeEvent();">
																 
																  </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                
                                                        
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="clearfix"></div>
                                        </div>
                                        
                                        <div class="portlet-body graphs">
		                                       <div class="owl-carousel owl-theme">
		                                        <div> 
		                                        	 <h3 class="portlet-title text-uppercase"> OPD Statistics </h3>		                                               
		                                             <div id="morris-bar-example" class="morris-charts"></div>
		                                             <div id="barLegend"></div>	                                          
		                                        </div>
		                                        <div>
		                                        	<h3 class="portlet-title text-uppercase"> Admission/Discharge Statistics </h3>	
	                                                <div id="morris-bar-admission" class="morris-charts"></div>
                                                	<div id="barLegendAdmission"></div>	
		                                           
		                                        </div>
		                                       </div>
                                        </div>
                                        
                                        <!-- <div id="bg-default" class="panel-collapse collapse show">
                                            <div class="portlet-body">
                                                <div id="morris-bar-example" class="morris-charts"></div>
                                                <div id="barLegend"></div>
                                            </div>
                                        </div> -->
                                    </div>
                                    <!-- /Portlet -->
                                </div>
                                <!-- col -->
                            </div>
                            <!-- End row-->
                            
                            
                            
                            <!-- End row-->

                            <div class="row">
                                <!-- Area Chart -->
                                <div class="col-lg-6">
                                    <div class="portlet">
                                        <!-- /primary heading -->
                                        <div class="portlet-heading">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h4 class="portlet-title">Medical Board</h4>
                                                              
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                              <div class="form-group text-right mn-t-10"> 
                                                                 <div class="dropdown inlineBlock">
                                                                    <!-- <button class="btn btn-light inChart width90 dropdown-toggle" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        Select
                                                                    </button>
                                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                                                        <span class="dropdown-item">Officers</span>
                                                                        <span class="dropdown-item">Sailors</span>
                                                                        <span class="dropdown-item">All</span>
                                                                    </div> -->
                                                                     
	                                                                    <select id="selectMB" onchange="executeProcedureForDashBoardforMbOrMe(this.value, this.id)" class="form-control">
	                                                                  	  <option value="1">Officers</option>
	                                                                  	  <option value="2">Sailors</option>
	                                                                  	  <option value="0">All</option>
                                                                    	</select>
                                                                  
                                                                </div>
                                                                
                                                                <div class="dropdown inlineBlock">
                                                                   <!-- <button class="btn btn-light inChart dropdown-toggle width90"  id="dropdownMenuButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                       Select
                                                                   </button>
                                                                   <div class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                                                                        <span class="dropdown-item">2019</span>
                                                                        <span class="dropdown-item">2018</span>
                                                                        <span class="dropdown-item">2017</span>
                                                                   </div> -->
                                                                   
                                                                   <!-- <select id=""  class="form-control">
                                                                     <option value="">Select</option>
                                                                  	  <option value="1">2019</option>
                                                                  	  <option value="2">2018</option>
                                                                  	  <option value="0">2017</option>
                                                                   	</select> -->
                                                                 </div> 
                                                                
                                                         	 </div>
                                                         </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div id="portlet3" class="panel-collapse collapse show">
                                            <div class="portlet-body">
                                                <div id="mb-donut-chart" class="morris-charts"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Portlet -->
                                </div>

                                <div class="col-lg-6">
                                    <div class="portlet">
                                        <!-- /primary heading -->
                                        <div class="portlet-heading">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                             <h4 class="portlet-title">Medical Exam</h4>
                                                                
                                                          </div>
                                                        </div>
                                                        <div class="col-md-8"> 
                                                            <div class="form-group text-right mn-t-10">  
                                                            		
                                                            		<div class="dropdown inlineBlock">
	                                                                    <!-- <button class="btn btn-light inChart dropdown-toggle width90" type="button" id="dropdownMenuButton3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                        Select
	                                                                    </button>
	                                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
	                                                                        <span class="dropdown-item">Officers</span>
	                                                                        <span class="dropdown-item">Sailors</span>
	                                                                        <span class="dropdown-item">All</span>
	                                                                    </div> -->
	                                                                    <select id="selectME" onchange="executeProcedureForDashBoardforMbOrMe(this.value, this.id)" class="form-control">
	                                                                  	  <option value="1">Officers</option>
	                                                                  	  <option value="2">Sailors</option>
	                                                                  	  <option value="0">All</option>
                                                                    	</select>
	                                                                    
                                                                    </div>
                                                                    
                                                               		<div class="dropdown inlineBlock">
                                                                    <!-- <button class="btn btn-light inChart dropdown-toggle width125" type="button" id="dropdownMenuButton4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        Select ME Type
                                                                    </button>
                                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton4">                                                                    
                                                                         <span class="dropdown-item">AME</span>
                                                                         <span class="dropdown-item">PME1</span>
                                                                         <span class="dropdown-item">PME2</span>
                                                                    </div> -->
                                                                    
                                                                    <!-- <select id=""  class="form-control">
                                                                      <option value="">Select</option>
                                                                  	  <option value="1">AME</option>
                                                                  	  <option value="2">PME1</option>
                                                                  	  <option value="0">PME2</option>
                                                                   	</select> -->
                                                                    </div>
                                                                    
                                                                    <div class="dropdown inlineBlock">
                                                                    <!-- <button class="btn btn-light inChart dropdown-toggle width90" type="button" id="dropdownMenuButton5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        Select
                                                                    </button>
                                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
                                                                         <span class="dropdown-item">2019</span>
                                                                         <span class="dropdown-item">2018</span>
                                                                         <span class="dropdown-item">2017</span>
                                                                    </div> -->
                                                                   <!--  <select id=""  class="form-control">
                                                                    <option value="">Select</option>
                                                                  	  <option value="1">2019</option>
                                                                  	  <option value="2">2018</option>
                                                                  	  <option value="0">2017</option>
                                                                   	</select> -->
                                                                    </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div id="portlet3" class="panel-collapse collapse show">
                                            <div class="portlet-body">
                                                <div id="me-donut-chart" class="morris-charts"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Portlet -->
                                </div>

                            </div>
                            <!-- End row-->

                      

                            </div>
                            <!-- container -->

                            </div>
                            <!-- content -->

                            </div>
                            </form>
                         
                          <%--   <%@include file="..//view/inventoryNotification.jsp"%> --%>
                          <!-- ============================================================== -->
                            <!-- End Right content here -->
                            <!-- ============================================================== -->

                            </div>

                           

                        </body>
						
						<script>
								$(function(){
									localStorage['myMenu'] = 'defaultValue';
								})
						</script>
						
						<script>
	//increase size of select box based on character to accomodate multiple lines of selected option * additional code in CSS - Paras Ravindran
  function wrapSelectText(a){
	  
	  var selectedElem = a;
	  var selectedOptionText = $('#'+selectedElem).find('option:selected').text();
	  
	  $('#'+selectedElem).attr('title',selectedOptionText);
	  
	// Get the user-agent string 
      let userAgentString =  navigator.userAgent; 
    
      // Detect Chrome 
      let chromeAgent =  userAgentString.indexOf("Chrome") > -1; 
    
      // Detect Internet Explorer 
      let IExplorerAgent =  userAgentString.indexOf("MSIE") > -1 ||  userAgentString.indexOf("rv:") > -1; 
    
      // Detect Firefox 
      let firefoxAgent =  userAgentString.indexOf("Firefox") > -1;       
      
          
      if(chromeAgent){
    	  
    	  if (selectedOptionText.length>22)
		  {
			  $('#'+selectedElem).css('height','48px');
		  	
		  	if (selectedOptionText.length>36 && selectedOptionText.length<50)
			  {
		  		$('#'+selectedElem).css('height','68px');
			  }	
		  	
		  	if (selectedOptionText.length>50 && selectedOptionText.length<80)
			  {
		  		$('#'+selectedElem).css('height','78px');
			  }
		  	
		    if (selectedOptionText.length>80)
			  {
		  		$('#'+selectedElem).css('height','96px');
			  }	
		  }		  
		  else
		  {
			  $('#'+selectedElem).css('height','28px');
		  }
    	  
      }
	  
	  
  }
  
  $(function(){	 	  
	  $('.selectTextWarp').change(function(){		  
		  var changeLoadId = $(this).attr('id');		  
		  wrapSelectText(changeLoadId);		  
	  });	    
  });
  </script>
						
                    
                    
                    <script src="${pageContext.request.contextPath}/resources/js/pages/morris.min.js"></script>
                    <script src="${pageContext.request.contextPath}/resources/js/pages/raphael.min.js"></script>
                    <script src="${pageContext.request.contextPath}/resources/js/pages/morris.init.js"></script>
                     <script src="${pageContext.request.contextPath}/resources/js/owl.carousel.js"></script>
                     
             		<script>
             		$(function(){
             			
             			$j(".owl-carousel").owlCarousel({
                 		    nav:true,
                 		    items:1,
                 		   	margin:20,
                 		    autoplay: true,
                 		    autoplayTimeout:5000,
                 		    autoplayHoverPause:true,
                 		   	autoplaySpeed:500,
                 		   	rewind:true
                 		  
               	  		});
             			
             			$('.custom-radio').on('click',function(){
             				$(this).find('input[type="radio"]').prop('checked',true);
             			})
             			
             			
             			$(".dropdown-menu").on('click', '.dropdown-item', function(){
             					
             				$(this).parent().siblings('button').text($(this).text());
             			      /* $(".btn:first-child").text($(this).text());
             			      $(".btn:first-child").val($(this).text()); */
             			   });
             			
             		});
             		</script>
             		
             		</html>