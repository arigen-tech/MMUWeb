<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>


<script type="text/javascript">

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

nPageNo=1;
var $j = jQuery.noConflict();

var totalregcount_m="";
var totalregcount_w="";
var totalaudit_c="";
var totalappcount_o="";

var totalappcount_m="";
var totalappcount_w="";
var totalappcount_c="";
var totalappcount_o="";

var pieArray = [];
var pieArray1 = [];


var pieOpdArray1 = [];
var pieOpdArray2 = [];

var t_topmedissue=0;
var t_mlc_flag=0;
var t_totopd=0;
var t_totinvestigation=0;
var pieopddata1="";
var pieopddata2="";

var topmedissue="";
var mlc_flag="";
var totopd="";
var totinvestigation="";


var excellent="";
var ni="";
var good="";
var total="";

var excellentP="";
var niP="";
var goodP="";

var feedbackArray = [];

var cityArray =[];
var opdArray =[];
var mIssuedArray =[];
var invArray =[];
var mlcArray =[];


var topmedissue="";
var cityname="";
var totopd="";
var totinvestigation="";
var mlcflag="";

var opdStatistics_city_data_total=""; 
var totalCities ="";
var totalCities1 ="";
var districtArray =[];
var topDistArrayVal =[];
var districtname="";
var tot_count="";

var opdStatistics_city_data_ddc=""; 
var cityArray1 =[];
var opdArray1 =[];
var mIssuedArray1 =[];
var invArray1 =[];
var mlcArray1 =[];

var districtArray =[];
var topDistArrayVal =[];
var districtname="";
var tot_count="";


var topDistricts_data_reg = "";
var topDistricts_data_apt = "";   
var topDistricts_data_lab = "";
var topDistricts_data_dipsn = "";
var topDistricts_data_medstock = ""; 


var drugExpiryArray =[];
var drugExpiryArrayVal =[];
var expiry_stock="";
var mmu_name="";

var signsSymptoms_data = "";
var symptomsArray =[];
var symptomsArrayVal =[];
var symptomsName="";
var totsymptoms="";
var totapp="";

var diagnosis_data = "";
var diagnosisArray =[];
var diagnosisArrayVal =[];
var diagnosisName="";
var totdiagnosis="";


var discrepenciesData = "";
var discrepenciesArray =[];
var discrepenciesArrayVal =[];
var discrepenciesName="";
var totdubiousAudit="";
var totApp="";
var totBlunderAudit="";
var totBlooperAudit="";

var communicable_data = "";
var communicableArray =[];
var communicableArrayVal =[];
var commDiseaseName="";
var totcommunicable="";

var auditorName="";
var totaudit="";
var pieChartLoad1, pieChartLoad2,pieChartLoadState, groupChart, districtChart,drugbarChart,pieChart,signChart,signChart2, signChart3,diagChart,pandemicChart; 

$j(document).ready(function()
		{
	
	getMMUList('');
	getAuditDashBoardData();
	GetDistrictList();	
	GetAuditorList();
	getAuditDashBoardAuditorData();
	//getDistrictListForGPS();
	//getPandmicZoneData();
	
		});
		
 
   function getMMUList(item){
	   $j("#mmuId").empty();
	  var params;
	  if(item != ''){
		  var cityId = item.value;
		  params = {
					"cityId":cityId
			}
	  }else{
		  params = { };
	  }
	 
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url: "${pageContext.servletContext.contextPath}/master/getMmuByCityMapping",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				 
				if(data.status == true){
					var list = data.data;
					var mmuDrop = '';
					//$j('#mmuId').find('option').not(':first').remove();
					mmuDrop = '<option value="0">All</option>';
					if(list.length!=null && list.length!="" && list.length>0){
						
					
					for(i=0;i<list.length;i++){
						mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
					}
					
					}
					 
					$j('#mmuId').append(mmuDrop);
				}				
				   else{
					mmuDrop = '<option value="0">All</option>';
					$j('#mmuId').append(mmuDrop);
				}  
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}


   function GetDistrictList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "" ;
		    	console.log("district"+result.data.length);
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#district').append(combo);
		    	
		    }
		    
		});
	}	
	  
   function destroyAllChart(){
		  pieChart.destroy();
		  pieChartLoad1.destroy(); 
		  pieChartLoad2.destroy();
		  //pieChartLoadState.destroy();
		 // groupChart.destroy();
		//  districtChart.destroy();
		    signChart.destroy();
		    signChart2.destroy();
		 //   signChart3.destroy();
		//  diagChart.destroy();
	//  commDiseaseChart.destroy();
		//  pandemicChart.destroy();
		  	  
	  }
   function compareToFromDate() {
 		var fromDate = $('#fromDate').val();
 		var toDate = $('#toDate').val();

 		if(fromDate=="" || toDate ==""){
 			alert("Date should not be empty");
 			return;
 	 		}
 		if (process(toDate) < process(fromDate)) {
 			alert("To Date should not be earlier than From Date");
 			$('#toDate').val("");
 			return;
 		}
 	}
   function compareToFromDateAudior() {
		var fromDate = $('#startDate').val();
		var toDate = $('#endDate').val();
		var Date = $j("#date").val();
		if(Date=="" ){
 			alert("Date should not be empty");
 			return;
 	 		}
		if(fromDate=="" || toDate ==""){
 			alert("Date should not be empty");
 			return;
 	 		}
		if (process(toDate) < process(fromDate)) {
			alert("To Date should not be earlier than From Date");
			$('#endDate').val("");
			return;
		}
	}

   function compareToStartAndEndTimeAudior() {
	   var starttime=$j("#starttime").val();
     var endtime=$j("#endtime").val();
		if((starttime) > (endtime)){
			alert("End Time Should not be earlier than Start time");
			return;
	 		}
		
	}
   function GetCityList(){
		$j("#city").empty();
		$j("#mmuId").empty();
		var districtId=$j("#district option:selected").val();
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
		    data: JSON.stringify({"PN" : "0","districtId": districtId}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "" ;
		    	if(result!=null && result.data!=null && result.data.length!=null){
		    	for(var i=0;i<result.data.length;i++){
		    		
		    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
		    		
		    	}
		    	$j("#city").append('<option value=0>All</option>');
		    	jQuery('#city').append(combo);
		    	$j("#mmuId").append('<option value=0>All</option>');
		    	}
		    	else{
		    		
		    		$j("#city").append('<option value=0>All</option>');
		    		$j("#mmuId").append('<option value=0>All</option>');
			    		
		    	}
		    }
		    
		});
	}	


   function GetAuditorList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/master/getAllAuditorName",
		    data: JSON.stringify({}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "" ;
		    	/* combo += "<option value=\"0\">Select</option>" ; */
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].auditiorId+'>' +result.data[i].audtiorName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#auditor').append(combo);
		    	
		    }
		    
		});
	}
	

   function getAuditDashBoardData(){
		$j("#loadingDiv").show();  
		var currentDate="";
		var fromDate="";
		var now = new Date();
	   	now.setDate(now.getDate());
	   	var day = ("0" + now.getDate()).slice(-2);
	   	var month = ("0" + (now.getMonth() + 1)).slice(-2);
	   	var today = (day)+"/"+(month)+"/"+now.getFullYear();
	   	currentDate=today;   	
	   	var now1 = new Date();
	   	now1.setDate(now1.getDate() - 7); // add -7 days to your date variable 
	   	
	   	var day1 = ("0" + now1.getDate()).slice(-2);
	   	var month1 = ("0" + (now1.getMonth() + 1)).slice(-2);
	   	var fromDate = (day1)+"/"+(month1)+"/"+now1.getFullYear();
	   	var mmuId= <%=mmuId%>;
	   	$j('#fromDate').val(fromDate);
	   	$j('#toDate').val(currentDate);

	   	$j("#stateStat1").prop("checked", true);
	   	$j("#stat1").prop("checked", true);

	   	$j('#symptomsId').html(fromDate+"-"+currentDate);
	   	$j('#diagnosisId').html(fromDate+"-"+currentDate);
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/dashboard/getAuditDashBoardData",
			    data: JSON.stringify({"districtId" : "0","cityId" : "0", "fromDate" : fromDate,"toDate" : currentDate,"mmuId":"0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	$j("#loadingDiv").hide();
			    	var data="";
			    	if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined)
			    	data = result.dashboard_data.dashboard_data;    
			    	console.log("getAuditDashBoardData::"+ result.dashboard_data.opdStatistics_city_data_total); 

	                   // Audit Discrepencies
					 discrepenciesArray =[];
		        	discrepenciesArrayVal =[];
		        	mIssuedArray =[];
					invArray =[];
					mlcArray =[];
					var discrepenciesData="";
			    	if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined)
			    	discrepenciesData = result.dashboard_data.opdStatistics_city_data_total;    
			    	
			    	 $j.each(discrepenciesData, function(i, discrepenciesData){
				    	
			    		 discrepenciesName=discrepenciesData.mmu_name;
				      	 discrepenciesArray.push(discrepenciesName);

						totBlooperAudit=discrepenciesData.blooper_audit;
				      	discrepenciesArrayVal.push(totBlooperAudit);
						
		            	totApp=discrepenciesData.tot_app;
				      	mIssuedArray.push(totApp);
		            	
		            	totdubiousAudit=discrepenciesData.dubious_audit;
				      	opdArray.push(totdubiousAudit);
		            	
		            	totBlunderAudit=discrepenciesData.blunder_audit;
				      	invArray.push(totBlunderAudit); 
						 
				      	
				      	
			    	 });

			    	//sign chart2 
						
				    	var xValues1 =  discrepenciesArray;
				    	//var yValues1 = discrepenciesArrayVal;
				    	var delayed;
				    	var barColors = [
				    	    "#ff3364",
				    	    "#F7A400",
				    	    "#ffce33",
				    	    "#64FF33"
				    	    
				    	  ];

				    	signChart2 = new Chart("signChart2", {
				    	    type: "bar",
				    	 
				    	    data: {
			                    labels: xValues1,
			                    datasets: [
			                    	{
			                            label: "Total OPD",
			                            backgroundColor: "#64FF33",
			                            borderColor: "#64FF33",
			                            borderWidth: 1,
			                           // data: [43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34]
			                            data: mIssuedArray
			                      },
			                        {
			                            label: "Blunder",
			                            backgroundColor: "#ff3364",
			                            borderColor: "#ff3364",
			                            borderWidth: 1,
			                            //data: [86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48]
			                            data: invArray
			                          },
			                          {
			                            label: "Blooper",
			                            backgroundColor: "#F7A400",
			                            borderColor: "#F7A400",
			                            borderWidth: 1,
			                            //data: [55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30]
			                            data: discrepenciesArrayVal
			                          },
			                          {
			                            label: "Dubious",
			                            backgroundColor: "#ffce33",
			                            borderColor: "#ffce33",
			                            borderWidth:1,
			                           // data: [43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34]
			                            data: opdArray
			                          }
			                          
			                          
			                        ]
			                },	 
				    	    options: {
				    	        responsive: true,		    	        
				    	        animation: {
				    	            onComplete: function() {
				    	              delayed = true;
				    	            },
				    	            delay: function(context){
				    	              let delay = 0;
				    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
				    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
				    	              }
				    	              return delay;
				    	            },
				    	        }
				    	    },
				    	    plugins: [ChartDataLabels],
				            options: {
				            	scales: {
				            	    xAxes: [{
				            	        ticks: {
				            	            autoSkip: false
				            	        }
				            	    }]
				            	},
				            	maintainAspectRatio: false,
				            	layout: {
				    	            padding: {
				    	                top: 20
				    	            }
				    	        },
				            	plugins:{
				            		legend: {
				                        display: false
				                    },
				    	            datalabels: {
				    	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
				    	            	color: 'black',
				    	                anchor:'end',
				    	                align:'end',
				    	                offset:5,
				    	                font: {
			                                size: 10,
			                                weight: 'bold'
			                            }
				    	            }
				    	        },
				            }
				    	    
				    	});

			    	
			    	symptomsArray =[];
		        	symptomsArrayVal =[];
		        	symptomsArrayVal1 =[];
		        	
			    	 $j.each(data, function(i, data){
				    	
				    	 symptomsName=data.mmu_name;
				      	 symptomsArray.push(symptomsName);

		                 totsymptoms=data.tot_audit;
				      	 symptomsArrayVal.push(totsymptoms);
				      	 totapp=data.tot_app;
				      	 symptomsArrayVal1.push(totapp);
				      	// symptomsArray.push(symptomsName);
				      	
			    	 });

			    	//sign chart 
						
				    	var xValues =  symptomsArray;
				    	var yValues = symptomsArrayVal;
				    	var delayed;
				    	var barColors = [
				    	    "#4568dc",
				    	    "#ff7e5f"
				    	    
				    	  ];

				    	signChart = new Chart("signChart", {
				    	    type: "bar",
				    	    data: {
				    	        labels: xValues,
				    	      
				    	    datasets: [
				    	    	{
		                            label: "Total OPD Visit",
		                            backgroundColor: "#4568dc",
		                            borderColor: "#4568dc",
		                            borderWidth: 0,
		                            //data: [86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48]
		                            data: symptomsArrayVal1
		                          },
				    	    	  {
		                            label: "Total Audit Visit",
		                            backgroundColor: "#ff7e5f",
		                            borderColor: "#ff7e5f",
		                            borderWidth: 0,
		                            //data: [55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30]
		                            data: symptomsArrayVal
		                          }
				    	    	  
				    	    	
		                          ]
			                },	 
				    	    options: {
				    	        responsive: true,		    	        
				    	        animation: {
				    	            onComplete: function() {
				    	              delayed = true;
				    	            },
				    	            delay: function(context){
				    	              let delay = 0;
				    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
				    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
				    	              }
				    	              return delay;
				    	            },
				    	        }
				    	    },
				    	    plugins: [ChartDataLabels],
				            options: {
				            	scales: {
				            	    xAxes: [{
				            	        ticks: {
				            	            autoSkip: false
				            	        }
				            	    }]
				            	},
				            	maintainAspectRatio: false,
				            	layout: {
				    	            padding: {
				    	                top: 20
				    	            }
				    	        },
				            	plugins:{
				            		legend: {
				                        display: false
				                    },
				    	            datalabels: {
				    	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
				    	            	color: 'black',
				    	                anchor:'end',
				    	                align:'end',
				    	                offset:5,
				    	                font: {
			                                size: 10,
			                                weight: 'bold'
			                            }
				    	            }
				    	        },
				            }
				    	    
				    	});

				    	 
		            var piedata="";
		            if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined )
		              piedata = result.dashboard_data.piechart_data;  
		              
		            pieArray=[];
		            pieArray1=[];
		            $j.each(piedata, function(i, piedata){
		            
		            	totalregcount_m=piedata.tot_audit;
		            	totalregcount_w=piedata.tot_app;
		            	  
		            	  pieArray.push(totalregcount_w);
		            	  pieArray.push(totalregcount_m);
		            	  // pie chart 1 total registration
		            	var totalRegCanvas = document.getElementById("totalReg");
		            	var regData = {
		            	    labels: [
		            	    	   "Total OPD",
			            	       "Total Audit"
		            	    ],
		            	    datasets: [
		            	        {
		            	        	data: pieArray,
		            	            backgroundColor: [
		            	           
		            	                "#4568dc",
		            	                "#ff7e5f"
		            	                
		            	            ], 
		            	            borderColor: [
		            	            	"#4568dc",
		            	            	"#ff7e5f"
		            	            ]
		            	        }],
		            	};

		            	pieChartLoad1 = new Chart(totalRegCanvas, {
		            	  type: 'doughnut',
		            	  data: regData,
		            	  plugins: [ChartDataLabels],
		                  options: {
		                	  responsive: true,
		                	  plugins:{
		                  		legend: {
		                              display: false
		                          },
		            	            datalabels: {
		            	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
		            	            	color: function(context) {
		          	            		  var index = context.dataIndex;
		          	            		  var value = context.dataset.data[index];
		          	            		  return value < 1 ? 'transparent' :  // draw negative values in red
		          	            		    'white';
		          	            		},
		          	            		font: {
		 	                                weight: 'bold'
		 	                            }
		            	            }
		            	        },
		                  }
		            	});
		            	
		            	//pie chart 2 total appointment
		            	var totalAppCanvas = document.getElementById("totalApp");
		            	var regData = {
		            	    labels: [
		            	        "Men",
		            	        "Women",
		            	        "Children",
		            	        "Transgender"
		            	    ],
		            	    datasets: [
		            	        {
		            	            data: pieArray1,
		            	            backgroundColor: [
		            	            	"#4568dc",
		            	                "#b06ab3",
		            	                "#45B649",
		            	                "#ff7e5f"
		            	            ],
		            	            borderColor: [
		            	            	"#4568dc",
		            	                "#b06ab3",
		            	                "#45B649",
		            	                "#ff7e5f"
		            	            ]
		            	        }],
		            	};

		            	pieChartLoad2 = new Chart(totalAppCanvas, {
		            	  type: 'doughnut',
		            	  data: regData,
		            	  plugins: [ChartDataLabels],
		                  options: {
		                	  plugins:{
		                  		legend: {
		                              display: false
		                          },
		            	            datalabels: {
		            	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
		            	            	color: function(context) {
		          	            		  var index = context.dataIndex;
		          	            		  var value = context.dataset.data[index];
		          	            		  return value < 1 ? 'transparent' :  // draw negative values in red
		          	            		    'white';
		          	            		},
		          	            		font: { 
		 	                                weight: 'bold'
		 	                            }
		            	            }
		            	        },
		                  }
		            	});
		            	
		                
		            });
			    	
		            cityArray =[];
					opdArray =[];
					mIssuedArray =[];
					invArray =[];
					mlcArray =[];
					if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined )
		            opdStatistics_city_data_total = result.dashboard_data.opdStatistics_city_data_total;
					
					if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined )
		            opdStatistics_city_data_ddc = result.dashboard_data.opdStatistics_city_data_ddc;
		            
		            totalCities = opdStatistics_city_data_total.length;
		            
		            if(totalCities<8){	            	
		            	$j('.chartWrap').css('width','100%');
		            }
		            else{
		            	var gchartWidth = totalCities*80;
			            $j('.chartWrap').css('width',gchartWidth);
		            }
		            
		            //alert(JSON.stringify(opdStatistics_city_data_total));
		            $j.each(opdStatistics_city_data_total, function(i, opdStatistics_city_data_total){
		            	
		            	cityname=opdStatistics_city_data_total.cityname;	            	
		            	cityArray.push(cityname);
		            	
		            	topmedissue=opdStatistics_city_data_total.topmedissue;
		            	mIssuedArray.push(topmedissue);
		            	
		            	totopd=opdStatistics_city_data_total.totopd;
		            	opdArray.push(totopd);
		            	
		            	totinvestigation=opdStatistics_city_data_total.totinvestigation;
		            	invArray.push(totinvestigation); 

		            	mlcflag=opdStatistics_city_data_total.mlc_flag;
		            	mlcArray.push(mlcflag); 
		            	 
		            });
		           // alert(pieArray);
		           
		            if(cityname =='0' && totopd =='0'){
			        	   $j('#noRegData').show();

			           }
			           else{
			        	   $j('#noRegData').hide();

			           }
		           
		         // grouped bar chart  
		            //var xValues = ["Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma","Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma","Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma","Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma"];
		            var xValues = cityArray;
		            var delayed;
		            var opdColor = "#b06ab3"
		            var medColor = "#45B649"
		            var invColor = "#ff7e5f"
		            var mlcColor = "#5B86E5" 

		            groupChart = new Chart("groupChart", {
		                type: "bar",
		                data: {
		                    labels: xValues,
		                    datasets: [
		                        {
		                            label: "OPD",
		                            backgroundColor: opdColor,
		                            borderColor: opdColor,
		                            borderWidth: 0,
		                            //data: [86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48]
		                            data: opdArray
		                          },
		                          {
		                            label: "Medicine",
		                            backgroundColor: medColor,
		                            borderColor: medColor,
		                            borderWidth: 0,
		                            //data: [55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30]
		                            data: mIssuedArray
		                          },
		                          {
		                            label: "Investigation",
		                            backgroundColor: invColor,
		                            borderColor: invColor,
		                            borderWidth: 0,
		                            //data: [43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34]
		                            data: invArray
		                          },
		                          {
		                            label: "MLC",
		                            backgroundColor: mlcColor,
		                            borderColor: mlcColor,
		                            borderWidth: 0,
		                            data: mlcArray
		                          } 
		                        ]
		                },	               
		                options: {
		                    responsive: true,
		                    plugins:{
		                        datalabels: {
		                            color: '#36A2EB',
	                            	display: function(context) {
	                            		  return context.dataIndex % 2; // display labels with an odd index
	                            		}
		                          }
		                    },
		                    animation: {
		                        onComplete: function() {
		                          delayed = true;
		                        },
		                        delay: function(context){
		                          let delay = 0;
		                          if (context.type === 'data' && context.mode === 'default' && !delayed) {
		                            delay = context.dataIndex * 300 + context.datasetIndex * 100;
		                          }
		                          return delay;
		                        },
		                    }
		                },
		                plugins: [ChartDataLabels],
		                options: {
		                	maintainAspectRatio: false,
		                	layout: {
		        	            padding: {
		        	                top: 20
		        	            }
		        	        },
		                	plugins:{
		                		 legend: {
		                			 display: false
			                        },
		        	            datalabels: {
		        	            	formatter:function(value,context){
		        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		        	            	},
		        	                color: 'black',
		        	                anchor:'end',
		        	                align:'end',
		        	                offset:5,
		        	                font: {
		                                size: 9,
		                                weight: 'bold'
		                            }
	        	                }
		        	        },
		                }
		                
		            });
		           
		            
		            districtArray=[];
		            topDistArrayVal=[];
		            var topDistricts_data ="";
		            if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined){
		              topDistricts_data = result.dashboard_data.topDistricts_data;
		            
	                 topDistricts_data_reg = result.dashboard_data.topDistricts_data_reg;
	                 topDistricts_data_apt = result.dashboard_data.topDistricts_data_apt;   
	                 topDistricts_data_lab = result.dashboard_data.topDistricts_data_lab;
	                 topDistricts_data_dipsn = result.dashboard_data.topDistricts_data_dipsn;
	                 topDistricts_data_medstock = result.dashboard_data.topDistricts_data_medstock;     
		            }
	                 $j("#topDistrictSelect").val('Registration');
		      	$j.each(topDistricts_data_reg, function(i, topDistricts_data_reg){

			        	  districtname=topDistricts_data_reg.cityname;
			        	  districtArray.push(districtname);
			        	  tot_count=topDistricts_data_reg.totpt;
			        	  topDistArrayVal.push(tot_count);

			        	});
	                  
		        	
		        	
		        	//top cities bar chart
		        	var xValues = districtArray;
		        	var yValues = topDistArrayVal;
		        	var delayed;
		        	var barColors = [
		        	    "#4568dc",
		        	    "#b06ab3",
		        	    "#45B649",
		        	    "#ff7e5f",
		        	    "#feb47b",
		        	    "#DCE35B",
		        	    "#c0f366"
		        	  ];
					
		        	if(districtChart){
		        		districtChart.destroy();
		        	}
		        	
		        	districtChart = new Chart("barChart", {
		        	    type: "bar",
		        	    data: {
		        	        labels: xValues,
		        	        datasets: [{
		        	            //label: 'Top Districts/Cities ',
		        	            maxBarThickness:60,
		        	            backgroundColor: barColors,
		        	            data: yValues
		        	        }]
		        	    },
		        	    options: {
		        	        responsive: true,
		        	        animation: {
		        	            onComplete: function() {
		        	              delayed = true;
		        	            },
		        	            delay: function(context){
		        	              let delay = 0;
		        	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
		        	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
		        	              }
		        	              return delay;
		        	            },
		        	        }
		        	    },
		        	    plugins: [ChartDataLabels],
		                options: {
		                	maintainAspectRatio: false,
		                	layout: {
		        	            padding: {
		        	                top: 20
		        	            }
		        	        },
		                	plugins:{
		                		legend: {
		                            display: false
		                        },
		        	            datalabels: {
		        	            	formatter:function(value,context){
		        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		        	            	},
		        	            	color: 'black',
		        	                anchor:'end',
		        	                align:'end',
		        	                offset:5,	        	                
		        	                font: {
		                                size: 10,
		                                weight: 'bold'
		                            }
		        	            }
		        	        },
		                }
		        	    
		        	});
		        	
		        
			    	diagnosisArray =[];
			    	diagnosisArrayVal =[];
			            if(result!=null && result.dashboard_data != null && result.dashboard_data!=undefined)
			    	diagnosis_data = result.dashboard_data.diagnosis_data;
		                 
			      	$j.each(diagnosis_data, function(i, diagnosis_data){

			      		diagnosisName=diagnosis_data.icd_name;
			      		diagnosisArray.push(diagnosisName);
			      		totdiagnosis=diagnosis_data.tot;
			      		diagnosisArrayVal.push(totdiagnosis);

				        	});


			      	
			    	
			    	// diagnosis chart
			    	var xValues = diagnosisArray;
			    	var yValues = diagnosisArrayVal;
			    	var delayed;
			    	var barColors = [
			    	    "#4568dc",
			    	    "#b06ab3",
			    	    "#45B649",
			    	    "#ff7e5f",
			    	    "#feb47b",
			    	    "#DCE35B",
			    	    "#c0f366"
			    	  ];

			    	diagChart = new Chart("diagChart", {
			    	    type: "bar",
			    	    data: {
			    	        labels: xValues,
			    	        datasets: [{
			    	            //label: 'Top 10 Diagnosis',
			    	            backgroundColor: barColors,
			    	            data: yValues
			    	        }]
			    	    },
			    	    options: {
			    	        responsive: true,		    	        
			    	        animation: {
			    	            onComplete: function() {
			    	              delayed = true;
			    	            },
			    	            delay: function(context){
			    	              let delay = 0;
			    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
			    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
			    	              }
			    	              return delay;
			    	            },
			    	        }
			    	    },
			    	    plugins: [ChartDataLabels],
			            options: {
			            	scales: {
			            	    xAxes: [{
			            	        ticks: {
			            	            autoSkip: false
			            	        }
			            	    }]
			            	},
			            	maintainAspectRatio: false,
			            	layout: {
			    	            padding: {
			    	                top: 20
			    	            }
			    	        },
			            	plugins:{
			            		legend: {
			                        display: false
			                    },
			    	            datalabels: {
			    	            	formatter:function(value,context){
		        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		        	            	},
			    	            	color: 'black',
			    	                anchor:'end',
			    	                align:'end',
			    	                offset:5,
			    	                font: {
		                                size: 10,
		                                weight: 'bold'
		                            }
			    	            }
			    	        },
			            }
			    	    
			    	});


			    	communicableArray =[];
			    	communicableArrayVal =[];
			    	if(result!=null && result.dashboard_data != null && result.dashboard_data!=undefined)
			    	communicable_data = result.dashboard_data.communicable_data;
		                 
			      	$j.each(communicable_data, function(i, communicable_data){

			      		commDiseaseName=communicable_data.icd_name;
			      		communicableArray.push(commDiseaseName);
			      		totcommunicable=communicable_data.tot;
			      		communicableArrayVal.push(totcommunicable);

				     });

			      	var xValues = communicableArray;
			      	var yValues = communicableArrayVal;
			      	var delayed;
			      	var barColors = [    
			      	    "#b06ab3",
			      	    "#45B649",
			      	    "#ff7e5f",
			      	    "#feb47b",
			      	    "#DCE35B",
			      	    "#4568dc"
			      	  ];

			      	commDiseaseChart = new Chart("commDiseaseChart", {
			      	    type: "bar",
			      	    data: {
			      	        labels: xValues,
			      	        datasets: [{
			      	            //label: 'Top Districts/Cities ',
			      	            maxBarThickness:60,
			      	            backgroundColor: barColors,
			      	            data: yValues
			      	        }]
			      	    },
			      	    options: {
			      	        responsive: true,
			      	        animation: {
			      	            onComplete: function() {
			      	              delayed = true;
			      	            },
			      	            delay: function(context){
			      	              let delay = 0;
			      	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
			      	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
			      	              }
			      	              return delay;
			      	            },
			      	        }
			      	    },
			      	    plugins: [ChartDataLabels],
			      	    options: {
			      	    	maintainAspectRatio: false,
			      	    	layout: {
			      	            padding: {
			      	                top: 20
			      	            }
			      	        },
			      	    	plugins:{
			      	    		legend: {
			      	                display: false
			      	            },
			      	            datalabels: {
			      	            	formatter:function(value,context){
			      	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			      	            	},
			      	            	color: 'black',
			      	                anchor:'end',
			      	                align:'end',
			      	                offset:5,	        	                
			      	                font: {
			      	                    size: 10,
			      	                    weight: 'bold'
			      	                }
			      	            }
			      	        },
			      	    }
			      	    
			      	});
				     
	              
		        	drugExpiryArray=[];
		        	drugExpiryArrayVal=[];
		        	var drugExpiry_data = "";
		        	if(result!=null && result.dashboard_data != null && result.dashboard_data!=undefined)
		              drugExpiry_data = result.dashboard_data.drugExpiry_data;
	                 
		        	$j.each(drugExpiry_data, function(i, drugExpiry_data){

		        	  mmu_name=drugExpiry_data.mmu_name;
		        	  drugExpiryArray.push(mmu_name);
		        	  expiry_stock=drugExpiry_data.expiry_stock;
		        	  drugExpiryArrayVal.push(expiry_stock);
	                  
		        	});
		        	
		        	//drug expiry for mmu bar chart
		        	/* var xValues = drugExpiryArray;
		        	var yValues = drugExpiryArrayVal;
		        	var delayed;
		        	var barColors = [    
		        	    "#ff7e5f",
		        	    "#feb47b",
		        	    "#DCE35B",
		        	    "#c0f366",
		        	    "#4568dc",
		        	    "#b06ab3",
		        	    "#45B649",
		        	    "#ff7e5f",
		        	    "#feb47b",
		        	    "#DCE35B"
		        	  ];

		        	drugbarChart=new Chart("drugbarChart", {
		        	    type: "bar",
		        	    data: {
		        	        labels: xValues,
		        	        datasets: [{
		        	            label: 'Drug Expiry MMU ',
		        	            backgroundColor: barColors,
		        	            data: yValues
		        	        }]
		        	    },
		        	    options: {
		        	        responsive: true,
		        	        maintainAspectRatio: false,
		        	        plugins:{
		        	            legend: {
		        	                display: false,
		        	                position: 'bottom'
		        	            }
		        	        },
		        	        animation: {
		        	            onComplete: function() {
		        	              delayed = true;
		        	            },
		        	            delay: function(context){
		        	              let delay = 0;
		        	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
		        	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
		        	              }
		        	              return delay;
		        	            },
		        	        }
		        	    }
		        	    
		        	}); */
		        	var feedbackdata = "";
		        	if(result!=null && result.dashboard_data != null && result.dashboard_data!=undefined)
		        	feedbackdata = result.dashboard_data.feedbackPie_data; 
		        	
		        	feedbackArray = [];
		        	
		            $j.each(feedbackdata, function(i, feedbackdata){
		            	
		            	excellent=feedbackdata.ex;
		            	ni=feedbackdata.ni;
		            	good=feedbackdata.good;
		            	total=feedbackdata.total;
		            	
		            	if(excellent !=''){
		            	excellentP=Math.round((excellent*100/total));
		            	}
		            	else{
		            		excellentP=0;
		            	}
		            	if(ni !=''){
		            	niP=Math.round((ni*100/total));
		            	}
		            	else{
		            		niP=0;	
		            	}
		            	if(good !=''){
		            	goodP=Math.round((good*100/total));
		            	}
		            	else{
		            		goodP=0;	
		            	}
		            	feedbackArray.push(excellent);
		            	feedbackArray.push(good);
		            	feedbackArray.push(ni);
			        }); 
		            
		            $j("#gd").html(excellent+"<br> "+excellentP+"%");
		            $j("#avg").html(good+"<br> "+goodP+"%");
		            $j("#bad").html(ni+"<br> "+niP+"%");
		            
		            feedbackPie = document.getElementById("feedbackPie");
		            var feedbackData = {
		                labels: [
		                    "Excellent",
		                    "Good",
		                    "Needs Improvement"
		                ],
		                datasets: [
		                    {
		                        data: feedbackArray,
		                        backgroundColor: [
		                        	"#45B649",
		                        	"#fdc507",
		                            "#d7350a"
		                            
		                        ]
		                    }],
		            };

		             pieChart = new Chart(feedbackPie, {
		              type: 'doughnut',
		              data: feedbackData,
		              options: {
		                  responsive: true,
		                  plugins:{
		                     legend: {
		                          display: false,
		                          position: 'left'
		                      }
		                  }
		              }
		            }); 
		            
		             if(result!=null && result.dashboard_data != null && result.dashboard_data!=undefined)
		                pieopddata1 = result.dashboard_data.opdstatistics_state_data_total;
				    	pieOpdArray1=[];
				    				    	
			            $j.each(pieopddata1, function(i, pieopddata1){      	 
			           
			            	topmedissue=pieopddata1.topmedissue;
			            	mlc_flag=pieopddata1.mlc_flag;
			            	totopd=pieopddata1.totopd;
			            	totinvestigation=pieopddata1.totinvestigation;
			            	
			            	pieOpdArray1.push(totopd);
			            	pieOpdArray1.push(topmedissue);
			            	pieOpdArray1.push(totinvestigation);
			            	pieOpdArray1.push(mlc_flag);           	  
	                    
			            var totalOpdCanvas = document.getElementById("totalOpd");
		            	
		            	var opdData = {
		            	    labels: [
		            	        "OPD",
		            	        "Medicine",
		            	        "Investigation",
		            	        "MLC"
		            	    ],
		            	    datasets: [
		            	        {
		            	        	data: pieOpdArray1,
		            	            backgroundColor: [	            	            	
		            	                "#b06ab3",
		            	                "#45B649",
		            	                "#ff7e5f",
		            	                "#4568dc"
		            	            ],
		            	            borderColor: [
		            	            	"#b06ab3",
		            	                "#45B649",
		            	                "#ff7e5f",
		            	                "#4568dc"
		            	            ]
		            	        }],
		            	};
		            	
		            	
		            	if(pieChartLoadState){
		            		pieChartLoadState.destroy();
		            	}
		            		
		            	
		            	pieChartLoadState = new Chart(totalOpdCanvas, {
		            	  type: 'doughnut',
		            	  data: opdData,
		            	  plugins: [ChartDataLabels],
		                  options: {
		                	  responsive: true,
		                	  maintainAspectRatio: false,
		                	  plugins:{
		                  		legend: {
		                              display: false
		                          },
		            	            datalabels: {
		            	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
		            	            	color: function(context) {
		            	            		  var index = context.dataIndex;
		            	            		  var value = context.dataset.data[index];
		            	            		  return value < 1 ? 'transparent' :  // draw negative values in red
		            	            		    'white';
		            	            		},
		            	            		font: {
			 	                                weight: 'bold'
			 	                            }
		            	            }
		            	        },
		                  }
		            	});  
		            	  
			            });    
			            if(result!=null && result.dashboard_data != null && result.dashboard_data!=undefined)
			            pieopddata2 = result.dashboard_data.opdstatistics_state_data_ddc;
			           	
		            
			        
			    }
			});
		}	


   
   function reset(){
		//  destroyAllChart();	  
		  $j("#district").val('0');
		  $j('#noRegData').hide();
		  $j('#noAppData').hide();	  
		  $j("#topDistrictSelect").val('Registration');
		  GetCityList();
		  getAuditDashBoardData();
		//  getAuditDashBoardAuditorData();
		//  setTopDistrict(); 
	  }
  



   function refreshData(){
		 
		  $j("#loadingDiv").show();
		  var districtId=$j("#district option:selected").val();
		  var cityId=$j("#city option:selected").val();
		  var fromDate=$j("#fromDate").val();
		  var toDate=$j("#toDate").val();
	      
		  $j("#stateStat1").prop("checked", true);
		  $j("#stat1").prop("checked", true);
		      	  
		  $j("#symptomsId").html(fromDate+"-"+toDate);
		  $j("#diagnosisId").html(fromDate+"-"+toDate);
		  var mmuId=$j("#mmuId").val();
				jQuery.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: "${pageContext.servletContext.contextPath}/dashboard/getAuditDashBoardData",
				    data: JSON.stringify({"districtId" : districtId,"cityId" : cityId, "fromDate" : fromDate,"toDate" : toDate,"mmuId":mmuId}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	$j("#loadingDiv").hide();
				    	pieArray=[];
				    	pieArray1=[];
				    	 symptomsArray =[];
				         symptomsArrayVal =[];
				         
				        if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined)
				             	
				    	
				    	
			            var piedata = result.dashboard_data.piechart_data;   
			           
			            
			            $j.each(piedata, function(i, piedata){
			            
			            	totalregcount_m=piedata.tot_audit;
			            	totalregcount_w=piedata.tot_app;
			            	  pieArray.push(totalregcount_w);
			            	  pieArray.push(totalregcount_m);
			            	  
			            	  if( totalregcount_m=='0'  ){
			            		  
			            		  $j('#noRegData').show();
			            	  }
			            	  else{
			            		  $j('#noRegData').hide(); 
			            	  }
			            	  
			            	totalappcount_m=piedata.tot_audit;
			            	totalappcount_w=piedata.tot_app;
			            	
			            	
			            	if(totalregcount_w=='0' ){
			            		 $j('#noAppData').show()
			            	}
			            	else{
			            		$j('#noAppData').hide()
			            	}
			            	
			            	pieArray1.push(totalappcount_m);
			            	pieArray1.push(totalappcount_w);
			            	
			            	
			            	destroyAllChart();
			            	
			            	// pie chart 1 total registration
			            	var totalRegCanvas = document.getElementById("totalReg");
			            	
			            	var regData = {
				            	    labels: [
				            	    	   "Total OPD",
					            	       "Total Audit"
				            	    ],
				            	    datasets: [
				            	        {
				            	        	data: pieArray,
				            	            backgroundColor: [
				            	           
				            	                "#4568dc",
				            	                "#ff7e5f"
				            	                
				            	            ], 
				            	            borderColor: [
				            	            	"#4568dc",
				            	            	"#ff7e5f"
				            	            ]
				            	        }],
				            	};
			            	pieChartLoad1 = new Chart(totalRegCanvas, {
			            	  type: 'doughnut',
			            	  data: regData,
			            	  plugins: [ChartDataLabels],
			                  options: {
			                	  responsive: true,
			                	  plugins:{
			                  		legend: {
			                              display: false
			                          },
			            	            datalabels: {
			            	            	formatter:function(value,context){
				        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				        	            	},
			            	            	color: function(context) {
			          	            		  var index = context.dataIndex;
			          	            		  var value = context.dataset.data[index];
			          	            		  return value < 1 ? 'transparent' :  // draw negative values in red
			          	            		    'white';
			          	            		},
			          	            		font: {
			 	                                weight: 'bold'
			 	                            }
			            	            }
			            	        },
			                  }
			            	});
			            	
			            	//pie chart 2 total appointment
			            	var totalAppCanvas = document.getElementById("totalApp");
			            	var regData = {
			            	    labels: [
			            	        "Men",
			            	        "Women",
			            	        "Children",
			            	        "Transgender"
			            	    ],
			            	    datasets: [
			            	        {
			            	            data: pieArray1,
			            	            backgroundColor: [
			            	            	"#4568dc",
			            	                "#b06ab3",
			            	                "#45B649",
			            	                "#ff7e5f"
			            	            ],
			            	            borderColor: [
			            	            	"#4568dc",
			            	                "#b06ab3",
			            	                "#45B649",
			            	                "#ff7e5f"
			            	            ]
			            	        }],
			            	};

			            	pieChartLoad2 = new Chart(totalAppCanvas, {
			            	  type: 'doughnut',
			            	  data: regData,
			            	  plugins: [ChartDataLabels],
			                  options: {
			                	  responsive: true,
			                	  plugins:{
			                  		legend: {
			                              display: false
			                          },
			            	            datalabels: {
			            	            	formatter:function(value,context){
				        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				        	            	},
			            	            	color: function(context) {
			          	            		  var index = context.dataIndex;
			          	            		  var value = context.dataset.data[index];
			          	            		  return value < 1 ? 'transparent' :  // draw negative values in red
			          	            		    'white';
			          	            		},
			          	            		font: {
			 	                                weight: 'bold'
			 	                            }
			            	            }
			            	        },
			                  }
			            	});
			            	
			                
			            });

			          	symptomsArray =[];
			        	symptomsArrayVal =[];
			        	symptomsArrayVal1 =[];
			        
			        	var data1 = result.dashboard_data.dashboard_data;
				    	 $j.each(data1, function(i, data1){
					    	
					    	 symptomsName=data1.mmu_name;
					      	 symptomsArray.push(symptomsName);

			                 totsymptoms=data1.tot_audit;
					      	 symptomsArrayVal.push(totsymptoms);
					      	 totapp=data1.tot_app;
					      	 
					      	symptomsArrayVal1.push(totapp);
					      	
					      	
				    	 });
			        	

				     // top 10 signs and symptoms charts
						//sign chart 
					 	
				    	var xValues =  symptomsArray;
				    	var yValues = symptomsArrayVal;
				    	var delayed;
				    	var barColors = [
				    		"#ff7e5f",
				    		 "#4568dc"
					    	 
				    	  ];

				    	signChart = new Chart("signChart", {
				    	    type: "bar",
				    	    data: {
				    	        labels: xValues,
				    	        
				    	    datasets: [ 
				    	    	 {
				                       label: "Total OPD Visit",
					                   backgroundColor: "#4568dc",
					                   borderColor: "#4568dc",
			                            borderWidth: 0,
			                            //data: [55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30]
			                            data: symptomsArrayVal1
			                          },
				    	    	{
				    	    		 label: "Total Audit Visit",
			                          backgroundColor: "#ff7e5f",
			                          borderColor: "#ff7e5f",
			                          borderWidth: 0,
		                            //data: [86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48]
		                            data: symptomsArrayVal
		                          }
					    	   
				    	    	
		                         
		                        
		                          ]
				    	    },
				    	    options: {
				    	        responsive: true,
				    	        animation: {
				    	            onComplete: function() {
				    	              delayed = true;
				    	            },
				    	            delay: function(context){
				    	              let delay = 0;
				    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
				    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
				    	              }
				    	              return delay;
				    	            },
				    	        }
				    	    },
				    	    plugins: [ChartDataLabels],
				            options: {
				            	scales: {
				            	    xAxes: [{
				            	        ticks: {
				            	            autoSkip: false
				            	        }
				            	    }]
				            	},
				            	maintainAspectRatio: false,
				            	layout: {
				    	            padding: {
				    	                top: 20
				    	            }
				    	        },
				            	plugins:{
				            		legend: {
				                        display: false
				                    },
				    	            datalabels: {
				    	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
				    	            	color: 'black',
				    	                anchor:'end',
				    	                align:'end',
				    	                offset:5,
				    	                font: {
			                                size: 10,
			                                weight: 'bold'
			                            }
				    	            }
				    	        },
				            }
				    	    
				    	});

				    	   // Audit Discrepencies refresh
						discrepenciesArray =[];
			        	discrepenciesArrayVal =[];
			        	mIssuedArray =[];
						invArray =[];
						mlcArray =[];
						opdArray =[];
						var discrepenciesData="";
				    	if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined)
				    	discrepenciesData = result.dashboard_data.opdStatistics_city_data_total;    
				    	
				    	 $j.each(discrepenciesData, function(i, discrepenciesData){
					    	
				    		 discrepenciesName=discrepenciesData.mmu_name;
					      	 discrepenciesArray.push(discrepenciesName);

							totBlooperAudit=discrepenciesData.blooper_audit;
					      	discrepenciesArrayVal.push(totBlooperAudit);
							
			            	totApp=discrepenciesData.tot_app;
					      	mIssuedArray.push(totApp);
			            	
			            	totdubiousAudit=discrepenciesData.dubious_audit;
					      	opdArray.push(totdubiousAudit);
			            	
			            	totBlunderAudit=discrepenciesData.blunder_audit;
					      	invArray.push(totBlunderAudit); 
					      	
					      	
				    	 });

				    	//sign chart2 
							
					    	var xValues1 =  discrepenciesArray;
					    	//var yValues1 = discrepenciesArrayVal;
					    	var delayed;
					    	var barColors = [
					    		 "#ff3364",
						    	    "#F7A400",
						    	    "#ffce33",
						    	    "#64FF33"
					    	    
					    	  ];

					    	signChart2 = new Chart("signChart2", {
					    	    type: "bar",
					    	  
					    	    data: {
				                    labels: xValues1,
				                    datasets: [
				                    	{
				                            label: "Total OPD",
				                            backgroundColor: "#64FF33",
				                            borderColor: "#64FF33",
				                            borderWidth: 0,
				                           // data: [43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34]
				                            data: mIssuedArray
				                      },
				                        {
				                            label: "Blunder",
				                            backgroundColor: "#ff3364",
				                            borderColor: "#ff3364",
				                            borderWidth: 0,
				                            //data: [86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48]
				                            data: invArray
				                          },
				                          {
				                            label: "Blooper",
				                            backgroundColor: "#F7A400",
				                            borderColor: "#F7A400",
				                            borderWidth: 0,
				                            //data: [55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30]
				                            data: discrepenciesArrayVal
				                          },
				                          {
				                            label: "Dubious",
				                            backgroundColor: "#ffce33",
				                            borderColor: "#ffce33",
				                            borderWidth: 0,
				                            //data: [43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34]
				                            data: opdArray
				                          }
				                          
				                          
				                        ]
				                },	 
					    	    options: {
					    	        responsive: true,		    	        
					    	        animation: {
					    	            onComplete: function() {
					    	              delayed = true;
					    	            },
					    	            delay: function(context){
					    	              let delay = 0;
					    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
					    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
					    	              }
					    	              return delay;
					    	            },
					    	        }
					    	    },
					    	    plugins: [ChartDataLabels],
					            options: {
					            	scales: {
					            	    xAxes: [{
					            	        ticks: {
					            	            autoSkip: false
					            	        }
					            	    }]
					            	},
					            	maintainAspectRatio: false,
					            	layout: {
					    	            padding: {
					    	                top: 20
					    	            }
					    	        },
					            	plugins:{
					            		legend: {
					                        display: false
					                    },
					    	            datalabels: {
					    	            	formatter:function(value,context){
				        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				        	            	},
					    	            	color: 'black',
					    	                anchor:'end',
					    	                align:'end',
					    	                offset:5,
					    	                font: {
				                                size: 10,
				                                weight: 'bold'
				                            }
					    	            }
					    	        },
					            }
					    	    
					    	});

				    	
			            cityArray =[];
						opdArray =[];
						mIssuedArray =[];
						invArray =[];
						mlcArray =[];
			            opdStatistics_city_data_total = result.dashboard_data.opdStatistics_city_data_total;

			            opdStatistics_city_data_ddc = result.dashboard_data.opdStatistics_city_data_ddc;
			            
			            totalCities = opdStatistics_city_data_total.length;
			            
			            if(totalCities<8){	            	
			            	$j('.chartWrap').css('width','100%');
			            }
			            else{
			            	var gchartWidth = totalCities*80;
				            $j('.chartWrap').css('width',gchartWidth);
			            }
			            //alert(JSON.stringify(opdStatistics_city_data_total));
			            $j.each(opdStatistics_city_data_total, function(i, opdStatistics_city_data_total){
			            	
			            	cityname=opdStatistics_city_data_total.cityname;	            	
			            	cityArray.push(cityname);
			            	
			            	topmedissue=opdStatistics_city_data_total.topmedissue;
			            	mIssuedArray.push(topmedissue);
			            	
			            	totopd=opdStatistics_city_data_total.totopd;
			            	opdArray.push(totopd);
			            	
			            	totinvestigation=opdStatistics_city_data_total.totinvestigation;
			            	invArray.push(totinvestigation);  

							mlcflag=opdStatistics_city_data_total.mlc_flag;
			            	mlcArray.push(mlcflag);
			            });
			           // alert(pieArray);
			           if(cityname =='0' && totopd =='0'){
			        	   $j('#noRegData').show();
	  
			           }
			           else{
			        	   $j('#noRegData').hide();
	   
			           }
			           
			         // grouped bar chart  
			            //var xValues = ["Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma","Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma","Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma","Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma"];
			            var xValues = cityArray;
			            var delayed;
			            var opdColor = "#b06ab3"
			            var medColor = "#45B649"
			            var invColor = "#ff7e5f"
			            var mlcColor = "#5B86E5"

			            groupChart = new Chart("groupChart", {
			                type: "bar",
			                data: {
			                    labels: xValues,
			                    datasets: [
			                        {
			                            label: "OPD",
			                            backgroundColor: opdColor,
			                            borderColor: opdColor,
			                            borderWidth: 0,
			                            //data: [86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48,86,54,66,95,50,65,36,48]
			                            data: opdArray
			                          },
			                          {
			                            label: "Medicine Issued",
			                            backgroundColor: medColor,
			                            borderColor: medColor,
			                            borderWidth: 0,
			                            //data: [55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30,55,30,44,60,28,33,40,30]
			                            data: mIssuedArray
			                          },
			                          {
			                            label: "Investigation",
			                            backgroundColor: invColor,
			                            borderColor: invColor,
			                            borderWidth: 0,
			                            //data: [43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34]
			                            data: invArray
			                          },
			                          {
			                            label: "MLC",
			                            backgroundColor: mlcColor,
			                            borderColor: mlcColor,
			                            borderWidth: 0,
			                            data: mlcArray
			                          }
			                        ]
			                },
			                options: {
			                    responsive: true,		                    
			                    animation: {
			                        onComplete: function() {
			                          delayed = true;
			                        },
			                        delay: function(context){
			                          let delay = 0;
			                          if (context.type === 'data' && context.mode === 'default' && !delayed) {
			                            delay = context.dataIndex * 300 + context.datasetIndex * 100;
			                          }
			                          return delay;
			                        },
			                    }
			                },
			                plugins: [ChartDataLabels],
			                options: {
			                	maintainAspectRatio: false,
			                	layout: {
			        	            padding: {
			        	                top: 20
			        	            }
			        	        },
			                	plugins:{
			                		legend: {
			                            display: false
			                        },
			        	            datalabels: {
			        	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
			        	            	color: 'black',
			        	                anchor:'end',
			        	                align:'end',
			        	                offset:5,
			        	                font: {
			                                size: 9,
			                                weight: 'bold'
			                            }
		        	                }
			        	        },
			                }
			                
			            });
				    	
			            districtArray=[];
			            topDistArrayVal=[];
			            var topDistricts_data = result.dashboard_data.topDistricts_data;

			             topDistricts_data_reg = result.dashboard_data.topDistricts_data_reg;
		                 topDistricts_data_apt = result.dashboard_data.topDistricts_data_apt;   
		                 topDistricts_data_lab = result.dashboard_data.topDistricts_data_lab;
		                 topDistricts_data_dipsn = result.dashboard_data.topDistricts_data_dipsn;
		                 topDistricts_data_medstock = result.dashboard_data.topDistricts_data_medstock;          

			      	$j.each(topDistricts_data_reg, function(i, topDistricts_data_reg){

				        	  districtname=topDistricts_data_reg.cityname;
				        	  districtArray.push(districtname);
				        	  tot_count=topDistricts_data_reg.totpt;
				        	  topDistArrayVal.push(tot_count);

				        	});
		                  
			        	
			        	
			        	//top cities bar chart
			        	var xValues = districtArray;
			        	var yValues = topDistArrayVal;
			        	var delayed;
			        	var barColors = [
			        	    "#4568dc",
			        	    "#b06ab3",
			        	    "#45B649",
			        	    "#ff7e5f",
			        	    "#feb47b",
			        	    "#DCE35B",
			        	    "#c0f366"
			        	  ];
						
			        	if(districtChart){
			        		districtChart.destroy();
			        	}
			        	
			        	districtChart = new Chart("barChart", {
			        	    type: "bar",
			        	    data: {
			        	        labels: xValues,
			        	        datasets: [{
			        	            //label: 'Top Districts/Cities ',
			        	            maxBarThickness:60,
			        	            backgroundColor: barColors,
			        	            data: yValues
			        	        }]
			        	    },
			        	    options: {
			        	        responsive: true,
			        	        animation: {
			        	            onComplete: function() {
			        	              delayed = true;
			        	            },
			        	            delay: function(context){
			        	              let delay = 0;
			        	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
			        	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
			        	              }
			        	              return delay;
			        	            },
			        	        }
			        	    },
			        	    plugins: [ChartDataLabels],
			                options: {
			                	maintainAspectRatio: false,
			                	layout: {
			        	            padding: {
			        	                top: 20
			        	            }
			        	        },
			                	plugins:{
			                		legend: {
			                            display: false
			                        },
			        	            datalabels: {
			        	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
			        	            	color: 'black',
			        	                anchor:'end',
			        	                align:'end',
			        	                offset:5,
			        	                font: {
			                                size: 10,
			                                weight: 'bold'
			                            }
			        	            }
			        	        },
			                }
			        	    
			        	});


			      //
				        	 
				    	diagnosisArray =[];
				    	diagnosisArrayVal =[];
				            
				    	diagnosis_data = result.dashboard_data.diagnosis_data;
			                 
				      	$j.each(diagnosis_data, function(i, diagnosis_data){

				      		diagnosisName=diagnosis_data.icd_name;
				      		diagnosisArray.push(diagnosisName);
				      		totdiagnosis=diagnosis_data.tot;
				      		diagnosisArrayVal.push(totdiagnosis);

					        	});
				    	
				    	// diagnosis chart
				    	var xValues = diagnosisArray;
				    	var yValues = diagnosisArrayVal;
				    	var delayed;
				    	var barColors = [
				    	    "#4568dc",
				    	    "#b06ab3",
				    	    "#45B649",
				    	    "#ff7e5f",
				    	    "#feb47b",
				    	    "#DCE35B",
				    	    "#c0f366"
				    	  ];

				    	diagChart = new Chart("diagChart", {
				    	    type: "bar",
				    	    data: {
				    	        labels: xValues,
				    	        datasets: [{
				    	            //label: 'Top 10 Diagnosis',
				    	            backgroundColor: barColors,
				    	            data: yValues
				    	        }]
				    	    },
				    	    options: {
				    	        responsive: true,			    	        
				    	        animation: {
				    	            onComplete: function() {
				    	              delayed = true;
				    	            },
				    	            delay: function(context){
				    	              let delay = 0;
				    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
				    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
				    	              }
				    	              return delay;
				    	            },
				    	        }
				    	    },
				    	    plugins: [ChartDataLabels],
				            options: {
				            	scales: {
				            	    xAxes: [{
				            	        ticks: {
				            	            autoSkip: false
				            	        }
				            	    }]
				            	},
				            	maintainAspectRatio: false,
				            	layout: {
				    	            padding: {
				    	                top: 20
				    	            }
				    	        },
				            	plugins:{
				            		legend: {
				                        display: false
				                    },
				    	            datalabels: {
				    	            	formatter:function(value,context){
			        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        	            	},
				    	            	color: 'black',
				    	                anchor:'end',
				    	                align:'end',
				    	                offset:5,
				    	                font: {
			                                size: 10,
			                                weight: 'bold'
			                            }
				    	            }
				    	        },
				            }
				    	    
				    	});

				    	 pieopddata1 = result.dashboard_data.opdstatistics_state_data_total;
					    	pieOpdArray1=[];
					    				    	
				            $j.each(pieopddata1, function(i, pieopddata1){      	 
				           
				            	topmedissue=pieopddata1.topmedissue;
				            	mlc_flag=pieopddata1.mlc_flag;
				            	totopd=pieopddata1.totopd;
				            	totinvestigation=pieopddata1.totinvestigation;
				            	
				            	pieOpdArray1.push(totopd);
				            	pieOpdArray1.push(topmedissue);
				            	pieOpdArray1.push(totinvestigation);
				            	pieOpdArray1.push(mlc_flag);
				          
		                    
				            var totalOpdCanvas = document.getElementById("totalOpd");
			            	
			            	var opdData = {
			            	    labels: [
			            	        "OPD",
			            	        "Medicine",
			            	        "Investigation",
			            	        "MLC"
			            	    ],
			            	    datasets: [
			            	        {
			            	        	data: pieOpdArray1,
			            	            backgroundColor: [
			            	            	"#b06ab3",
			            	                "#45B649",
			            	                "#ff7e5f",
			            	                "#4568dc"
			            	            ],
			            	            borderColor: [
			            	            	"#b06ab3",
			            	                "#45B649",
			            	                "#ff7e5f",
			            	                "#4568dc"
			            	            ]
			            	        }],
			            	};
			            	
			            	
			            	if(pieChartLoadState){
			            		pieChartLoadState.destroy();
			            	}
			            		
			            	
			            	pieChartLoadState = new Chart(totalOpdCanvas, {
			            	  type: 'doughnut',
			            	  data: opdData,
			            	  plugins: [ChartDataLabels],
			                  options: {
			                	  responsive: true,
			                	  maintainAspectRatio: false,
			                	  plugins:{
			                  		legend: {
			                              display: false
			                          },
			            	            datalabels: {
			            	            	formatter:function(value,context){
				        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				        	            	},
			            	            	color: function(context) {
			            	            		  var index = context.dataIndex;
			            	            		  var value = context.dataset.data[index];
			            	            		  return value < 1 ? 'transparent' :  // draw negative values in red
			            	            		    'white';
			            	            		},
			            	            		font: {
				 	                                weight: 'bold'
				 	                            }
			            	            }
			            	        },
			                  }
			            	}); 
				            });
				            pieopddata2 = result.dashboard_data.opdstatistics_state_data_ddc;
			        	
			        	drugExpiryArray=[];
			        	drugExpiryArrayVal=[];
			            var drugExpiry_data = result.dashboard_data.drugExpiry_data;
		                 
			        	$j.each(drugExpiry_data, function(i, drugExpiry_data){

			        	  mmu_name=drugExpiry_data.mmu_name;
			        	  drugExpiryArray.push(mmu_name);
			        	  expiry_stock=drugExpiry_data.expiry_stock;
			        	  drugExpiryArrayVal.push(expiry_stock);
		                  
			        	});



			        	communicableArray =[];
				    	communicableArrayVal =[];
				            
				    	communicable_data = result.dashboard_data.communicable_data;
			                 
				      	$j.each(communicable_data, function(i, communicable_data){

				      		commDiseaseName=communicable_data.icd_name;
				      		communicableArray.push(commDiseaseName);
				      		totcommunicable=communicable_data.tot;
				      		communicableArrayVal.push(totcommunicable);

					     });

				      	var xValues = communicableArray;
				      	var yValues = communicableArrayVal;
				      	var delayed;
				      	var barColors = [    
				      	    "#b06ab3",
				      	    "#45B649",
				      	    "#ff7e5f",
				      	    "#feb47b",
				      	    "#DCE35B",
				      	    "#4568dc"
				      	  ];

				      	commDiseaseChart = new Chart("commDiseaseChart", {
				      	    type: "bar",
				      	    data: {
				      	        labels: xValues,
				      	        datasets: [{
				      	            //label: 'Top Districts/Cities ',
				      	            maxBarThickness:60,
				      	            backgroundColor: barColors,
				      	            data: yValues
				      	        }]
				      	    },
				      	    options: {
				      	        responsive: true,
				      	        animation: {
				      	            onComplete: function() {
				      	              delayed = true;
				      	            },
				      	            delay: function(context){
				      	              let delay = 0;
				      	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
				      	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
				      	              }
				      	              return delay;
				      	            },
				      	        }
				      	    },
				      	    plugins: [ChartDataLabels],
				      	    options: {
				      	    	maintainAspectRatio: false,
				      	    	layout: {
				      	            padding: {
				      	                top: 20
				      	            }
				      	        },
				      	    	plugins:{
				      	    		legend: {
				      	                display: false
				      	            },
				      	            datalabels: {
				      	            	formatter:function(value,context){
				      	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				      	            	},
				      	            	color: 'black',
				      	                anchor:'end',
				      	                align:'end',
				      	                offset:5,	        	                
				      	                font: {
				      	                    size: 10,
				      	                    weight: 'bold'
				      	                }
				      	            }
				      	        },
				      	    }
				      	    
				      	});
			        	
			        	
			        	//drug expiry for mmu bar chart
			        	/* var xValues = drugExpiryArray;
			        	var yValues = drugExpiryArrayVal;
			        	var delayed;
			        	var barColors = [    
			        	    "#ff7e5f",
			        	    "#feb47b",
			        	    "#DCE35B",
			        	    "#c0f366",
			        	    "#4568dc",
			        	    "#b06ab3",
			        	    "#45B649",
			        	    "#ff7e5f",
			        	    "#feb47b",
			        	    "#DCE35B"
			        	  ];

			        	drugbarChart=new Chart("drugbarChart", {
			        	    type: "bar",
			        	    data: {
			        	        labels: xValues,
			        	        datasets: [{
			        	            label: 'Drug Expiry MMU ',
			        	            backgroundColor: barColors,
			        	            data: yValues
			        	        }]
			        	    },
			        	    options: {
			        	        responsive: true,
			        	        maintainAspectRatio: false,
			        	        plugins:{
			        	            legend: {
			        	                display: false,
			        	                position: 'bottom'
			        	            }
			        	        },
			        	        animation: {
			        	            onComplete: function() {
			        	              delayed = true;
			        	            },
			        	            delay: function(context){
			        	              let delay = 0;
			        	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
			        	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
			        	              }
			        	              return delay;
			        	            },
			        	        }
			        	    }
			        	    
			        	}); */
			        	
			        	
			        	var feedbackdata = result.dashboard_data.feedbackPie_data; 
			        	
			        	feedbackArray = [];
			        	
			            $j.each(feedbackdata, function(i, feedbackdata){
			            	
			            	excellent=feedbackdata.ex;
			            	ni=feedbackdata.ni;
			            	good=feedbackdata.good;
			            	total=feedbackdata.total;
			            	if(excellent !=''){
			            	excellentP=Math.round((excellent*100/total));
			            	}
			            	else{
			            		excellentP=0;
			            	}
			            	if(ni !=''){
			            	niP=Math.round((ni*100/total));
			            	}
			            	else{
			            		niP=0;	
			            	}
			            	if(good !=''){
			            	goodP=Math.round((good*100/total));
			            	}
			            	else{
			            		goodP=0;
			            	}
			            	feedbackArray.push(excellent);
			            	feedbackArray.push(good);
			            	feedbackArray.push(ni);
				        }); 
			            
			            $j("#gd").html(excellent+"<br> "+excellentP+"%");
			            $j("#avg").html(good+"<br> "+goodP+"%");
			            $j("#bad").html(ni+"<br> "+niP+"%");
			            
			            var feedbackPie = document.getElementById("feedbackPie");
			            var feedbackData = {
			                labels: [
			                    "Excellent",
			                    "Good",
			                    "Needs Improvement"
			                ],
			                datasets: [
			                    {
			                        data: feedbackArray,
			                        backgroundColor: [
			                        	"#45B649",
			                        	"#fdc507",
			                            "#d7350a"
			                            
			                        ]
			                    }],
			            };

			             pieChart = new Chart(feedbackPie, {
			              type: 'doughnut',
			              data: feedbackData,
			              options: {
			                  responsive: true,
			                  plugins:{
			                     legend: {
			                          display: false,
			                          position: 'left'
			                      }
			                  }
			              }
			            }); 
			            
				    }
				    
				});
		}




   function getAuditDashBoardAuditorData(){
		$j("#loadingDiv1").show();  
		var currentDate="";
		var fromDate="";
		var now = new Date();
	   	now.setDate(now.getDate());
	   	var day = ("0" + now.getDate()).slice(-2);
	   	var month = ("0" + (now.getMonth() + 1)).slice(-2);
	   	var today = (day)+"/"+(month)+"/"+now.getFullYear();
	   	currentDate=today;   	
	   	var now1 = new Date();
	   	now1.setDate(now1.getDate() - 7); // add -7 days to your date variable 
	   	
	   	var day1 = ("0" + now1.getDate()).slice(-2);
	   	var month1 = ("0" + (now1.getMonth() + 1)).slice(-2);
	   	var fromDate = (day1)+"/"+(month1)+"/"+now1.getFullYear();
	   	var mmuId= <%=mmuId%>;
	   	$j('#date').val(currentDate);
	   	$j('#startDate').val(fromDate);
	   	$j('#endDate').val(currentDate);

	   	$j("#radiobtn1").prop("checked", true);
	   	//$j("#radiobtn2").prop("checked", true);
	 
	   
	   //	$j('#symptomsId').html(fromDate+"-"+currentDate);
	   //	$j('#diagnosisId').html(fromDate+"-"+currentDate);
	   	jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/dashboard/getAuditDashBoardAuditorData",
		    data: JSON.stringify({"auditorId" : "0", "starttime":"00:00" , endtime: "24:00" , "startDate" : fromDate,"endDate" : currentDate}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	$j("#loadingDiv1").hide();
		    	var data="";
		    	if(result!=null && result.dashboard_auditor_data!=null && result.dashboard_auditor_data!=undefined)
		    	data = result.dashboard_auditor_data.dashboard_auditor_data;    
		    	console.log("getAuditDashBoard auditor Data::"+ result.dashboard_auditor_data.dashboard_auditor_data); 

                   // Audit Discrepencies
				auditorArray =[];
	        	auditorArrayVal =[];
	        	
				var auditorData="";
		    	if(result!=null && result.dashboard_auditor_data!=null && result.dashboard_auditor_data!=undefined)
		    		auditorData = result.dashboard_auditor_data.dashboard_auditor_data;    
		    	
		    	 $j.each(auditorData, function(i, auditorData){
			    	
		    		 auditorName=auditorData.a_name;
		    		 auditorArray.push(auditorName);

		    		 totaudit=auditorData.tot_audit;
					auditorArrayVal.push(totaudit);
					
				    
				});
		    	//sign chart2 
					
			   	
			    	var xValues =  auditorArray;
			    	var yValues = auditorArrayVal;
			    	var delayed;
			    	var barColors = [
			    	    "#b06ab3"
			    	   
			    	    
			    	  ];

			    	signChart3 = new Chart("signChart3", {
			    	    type: "bar",
			    	    data: {
			    	        labels: xValues,
			    	        datasets: [{
			    	            //label: 'Top 10 Signs Symptoms',
			    	            backgroundColor: barColors,
			    	            data: yValues
			    	        }]
			    	    },
			    	    options: {
			    	        responsive: true,		    	        
			    	        animation: {
			    	            onComplete: function() {
			    	              delayed = true;
			    	            },
			    	            delay: function(context){
			    	              let delay = 0;
			    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
			    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
			    	              }
			    	              return delay;
			    	            },
			    	        }
			    	    },
			    	    plugins: [ChartDataLabels],
			            options: {
			            	scales: {
			            	    xAxes: [{
			            	        ticks: {
			            	            autoSkip: false
			            	        }
			            	    }]
			            	},
			            	maintainAspectRatio: false,
			            	layout: {
			    	            padding: {
			    	                top: 20
			    	            }
			    	        },
			            	plugins:{
			            		legend: {
			                        display: false
			                    },
			    	            datalabels: {
			    	            	formatter:function(value,context){
		        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		        	            	},
			    	            	color: 'black',
			    	                anchor:'end',
			    	                align:'end',
			    	                offset:5,
			    	                font: {
		                                size: 10,
		                                weight: 'bold'
		                            }
			    	            }
			    	        },
			            }
			    	    
			    	});

			}	
	   	});
   }



   function searchData(){
		 
	   $j("#loadingDiv1").show();  
		
	    
	 if($("input[type='radio'].radioBtnClass").is(':checked')) {
    var card_type = $("input[type='radio'].radioBtnClass:checked").val();
    //alert(card_type);
    
    if(card_type == 1){
    	// alert(card_type);
    	var auditorId=$j("#auditor option:selected").val();
    	var starttime=$j("#starttime").val();
    	var endtime=$j("#endtime").val();
		var startDate=$j("#date").val();
		var endDate=$j("#date").val();
        }else{
        	// alert(card_type);
        	var auditorId=$j("#auditor option:selected").val();
        	 var starttime="00:00";
         	var endtime="24:00";
        	var startDate=$j("#startDate").val();
    		var endDate=$j("#endDate").val();
            }
   
}
	  
	   	jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/dashboard/getAuditDashBoardAuditorData",
		     data: JSON.stringify({"auditorId" : auditorId,"starttime":starttime , "endtime": endtime , "startDate" : startDate,"endDate" : endDate}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	$j("#loadingDiv1").hide();
				    	var data="";
				    	if(result!=null && result.dashboard_auditor_data!=null && result.dashboard_auditor_data!=undefined)
				    	data = result.dashboard_auditor_data.dashboard_auditor_data;    
				    	console.log("getAuditDashBoard auditor Refresh Data::"+ result.dashboard_auditor_data.dashboard_auditor_data); 

		                   // Audit Discrepencies
						auditorArray =[];
			        	auditorArrayVal =[];
			        	
						var auditorData="";
				    	if(result!=null && result.dashboard_auditor_data!=null && result.dashboard_auditor_data!=undefined)
				    		auditorData = result.dashboard_auditor_data.dashboard_auditor_data;    
				    	
				    	 $j.each(auditorData, function(i, auditorData){
					    	
				    		 auditorName=auditorData.a_name;
				    		 auditorArray.push(auditorName);

				    		 totaudit=auditorData.tot_audit;
							auditorArrayVal.push(totaudit);
							 signChart3.destroy();
							//destroyAllChart();
						});
				    	//sign chart2 
							
					   	 signChart3.destroy();
					    	var xValues =  auditorArray;
					    	var yValues = auditorArrayVal;
					    	var delayed;
					    	var barColors = [
					    	    "#b06ab3"
					    	   
					    	    
					    	  ];

					    	signChart3 = new Chart("signChart3", {
					    	    type: "bar",
					    	    data: {
					    	        labels: xValues,
					    	        datasets: [{
					    	            //label: 'Top 10 Signs Symptoms',
					    	            backgroundColor: barColors,
					    	            data: yValues
					    	        }]
					    	    },
					    	    options: {
					    	        responsive: true,		    	        
					    	        animation: {
					    	            onComplete: function() {
					    	              delayed = true;
					    	            },
					    	            delay: function(context){
					    	              let delay = 0;
					    	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
					    	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
					    	              }
					    	              return delay;
					    	            },
					    	        }
					    	    },
					    	    plugins: [ChartDataLabels],
					            options: {
					            	scales: {
					            	    xAxes: [{
					            	        ticks: {
					            	            autoSkip: false
					            	        }
					            	    }]
					            	},
					            	maintainAspectRatio: false,
					            	layout: {
					    	            padding: {
					    	                top: 20
					    	            }
					    	        },
					            	plugins:{
					            		legend: {
					                        display: false
					                    },
					    	            datalabels: {
					    	            	formatter:function(value,context){
				        	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				        	            	},
					    	            	color: 'black',
					    	                anchor:'end',
					    	                align:'end',
					    	                offset:5,
					    	                font: {
				                                size: 10,
				                                weight: 'bold'
				                            }
					    	            }
					    	        },
					            }
					    	    
					    	});

					}	
			   	});
		   }

				         
</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

			
			<div class="row">
			<div class="col-12">
				<div class="portlet">
					<!-- /primary heading -->
					<div class="portlet-heading dashSelection">
						<div class="row">
						<input type="hidden"  name="userTypeName" value=<%= session.getAttribute("userTypeName") %> id="userTypeName" />
						<div class="col-lg-4 col-sm-6">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Select District</label>
									</div>
									<div class="col-md-7">
										<select class="form-control" id="district" onchange="GetCityList()">
											<option value="0">All</option>
										</select>
									</div>
								</div> 
							</div>
							
							<!-- <div class="col-lg-4 col-sm-6">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Select Cluster</label>
									</div>
									<div class="col-md-7">
										<select class="form-control" id="" onchange="">
											<option value="0">All</option>
										</select>
									</div>
								</div> 
							</div> -->
							
							<div class="col-lg-4 col-sm-6">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Select City</label>
									</div>
									<div class="col-md-7">
										<select class="form-control" id="city" onchange="getMMUList(this)">
											<option value="0">All</option>
										</select>
									</div>
								</div> 
							</div>
							
							<div class="col-lg-4 col-sm-6">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Select MMU</label>
									</div>
									<div class="col-md-7">
										<select class="form-control" id="mmuId">
											<option value="0">All</option>
										</select>
									</div>
								</div> 
							</div>
							<!-- 
							<div class="col-lg-4 col-sm-6">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Select Auditor</label>
									</div>
									<div class="col-md-7">
										<select class="form-control" id="mmuId">
											<option value="0">All</option>
										</select>
									</div>
								</div> 
							</div> -->
							
							<div class="col-lg-4 col-sm-6">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">From Date</label>
									</div>
									<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareToFromDate();">
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-lg-4 col-sm-6">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">To Date</label>
									</div>
									
									<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareToFromDate();">
										</div>
									</div>
								</div>
								<div id="loadingDiv" class="text-center">
						<img
							src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
					</div>
							</div>
							<div class="col-lg-12  text-right">
							    
								<button class="btn btn-primary" onclick="reset();">Reset</button>
								<button class="btn btn-primary" onclick="refreshData();">Refresh Data</button>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
			
			<div class="row">
				
			
			<div class="col-lg-8 col-sm-12">
				
				<div class="portlet">					
					<div class="portlet-heading">
						<div class="row">
							<div class="col-lg-8 col-sm-12">
								<h4 class="portlet-title">Audit Count</h4>					
							</div>
							
						</div>
					</div>
					<div id="portlet2" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							<div class="row">
							<div class="col-12">	
							<div class="horizontalScroll">
								<div class="chartWrap">
									<canvas id="signChart"></canvas>
								</div>
							</div>					 	
						 	
					          </div>
								  <div class="col-12">
									<canvas class="dashBarChart" id="groupedCountChart" hidden=""></canvas>
								</div>   
								
							</div>
						</div>
					</div>
				</div>				
				</div>
				
				
				<div class="col-lg-4 col-sm-12">
				
				<div class="portlet">					
					<div class="portlet-heading">
						<div class="row">
							<div class="col-lg-8 col-sm-12">
								<h4 class="portlet-title">Overall Audit</h4>					
							</div>
							
						</div>
					</div>
					<div id="portlet2" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							<div class="row">
							<div class="col-lg-6 col-sm-8">
										
										<div id="noRegData">No Data Available</div>
										<div class="clearmob">
											<canvas class="dashPieChart" id="totalReg"></canvas>
										</div>
									</div>
									
								 <div class="col-lg-6 col-sm-8">
									<canvas class="dashPieChart" id="unsettledInvoice" hidden=""></canvas>
								</div>  
								
							</div>
							
							<div class="row">
								<div class="col-5">
									<div class="pieLegends sideways">										
										<div><span style="background:#4568dc"></span>Total OPD</div>
									</div>
								</div>
								<div class="col-6">
									<div class="pieLegends sideways">								
										<div><span style="background:#ff7e5f"></span>Total Audit</div>
									</div>
								</div>
								<br/>
								<br/>
							</div>
						</div>
					</div>
				</div>	
				
				
										
			</div>
		</div>
				<!-- end row -->
				
		<div class="row">
			<div class="col-md-12">
				<div class="portlet">
					<div class="portlet-heading p-b-10">
						<div class="row">
							<div class="col-md-6 col-sm-12">
								<h4 class="portlet-title">Audit Discrepancies</h4>	 
							</div>
							
						</div>
					</div>
					<div id="portlet3" class="panel-collapse collapse show">
					<div class="portlet-body p-t-0">
					<div class="horizontalScroll">
								<div class="chartWrap">						 	
						 	<canvas class="dashBarChart" id="signChart2"></canvas>
						 	</div>
						 	</div>
					          </div>
						 <%--  <div class="portlet-body p-t-0">
							<canvas class="dashBarChart" id="groupedDiscrepChart" hidden=""></canvas>
						</div>    --%>
						
						
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
				<div class="col-12">
				
					<div class="portlet">					
						<div class="portlet-heading">
							<div class="row">
								<div class="col-lg-8 col-sm-12">
									<h4 class="portlet-title">Auditor Status</h4>					
								</div>
								
							</div>
						</div>
						<div id="portlet2" class="panel-collapse collapse show">
							<div class="portlet-body p-t-0">
								<div class="row">
									<div class="col-5">
										<div class="row">
											<div class="col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Auditor</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="auditor">
															<option value="0">All</option>
														</select>
													</div>
												</div>
											</div>
											
											
											<div class="w-100 m-t-10"></div>
											<div class="col-md-4 m-l-5">												
												<div class="form-check form-check-inline cusRadio">
													<input class="radioBtnClass" type="radio"  name="timeCheck" id="radiobtn1" value="1"> 
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="radiobtn1">Hour</label>
												</div>												
											</div>
											<div class="w-100 m-t-10"></div>
											
											<div class="col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Date</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<input type="text" id="date" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareToFromDateAudior();">
														</div>
													</div>
												</div>
											</div>
											<div class="col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Start Time</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="starttime" onchange="compareToStartAndEndTimeAudior">
														
															<option value="00:00">00:00</option>
																<option value="01:00">01:00</option>
																	<option value="02:00">02:00</option>
																		<option value="03:00">03:00</option>
																			<option value="04:00">04:00</option>
																				<option value="05:00">05:00</option>
																					<option value="06:00">06:00</option>
																						<option value="07:00">07:00</option>
																							<option value="08:00">08:00</option>
																								<option value="09:00">09:00</option>
																									<option value="10:00">10:00</option>
																										<option value="11:00">11:00</option>
																											<option value="12:00">12:00</option>
																											<option value="13:00">13:00</option>
																												<option value="14:00">14:00</option>
																												<option value="15:00">15:00</option>
																												<option value="16:00">16:00</option>
																												<option value="17:00">17:00</option>
																												<option value="18:00">18:00</option>
																												<option value="19:00">19:00</option>
																												<option value="20:00">20:00</option>
																												<option value="21:00">21:00</option>
																												<option value="22:00">22:00</option>
																												<option value="23:00">23:00</option>
																												<option value="24:00">24:00</option>
																												
														</select>
													</div>
												</div>
											</div>
											<div class="col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">End Tme</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="endtime" onchange="compareToStartAndEndTimeAudior();">
		
															<option value="24:00">24:00</option>
																<option value="23:00">23:00</option>
																	<option value="22:00">22:00</option>
																		<option value="21:00">21:00</option>
																			<option value="20:00">20:00</option>
																				<option value="19:00">19:00</option>
																					<option value="18:00">18:00</option>
																						<option value="17:00">17:00</option>
																							<option value="16:00">16:00</option>
																								<option value="15:00">15:00</option>
																									<option value="14:00">14:00</option>
																										<option value="13:00">13:00</option>
																											<option value="12:00">12:00</option>
																											<option value="11:00">11:00</option>
																												<option value="10:00">10:00</option>
																												<option value="09:00">09:00</option>
																												<option value="08:00">08:00</option>
																												<option value="07:00">07:00</option>
																												<option value="06:00">06:00</option>
																												<option value="05:00">05:00</option>
																												<option value="04:00">04:00</option>
																												<option value="03:00">03:00</option>
																												<option value="02:00">02:00</option>
																												<option value="01:00">01:00</option>
																												<option value="00:00">00:00</option>
														</select>
													</div>
												</div>
											</div>
											
											
											<div class="w-100 m-t-10"></div>
											<div class="col-md-4 m-l-5">												
												<div class="form-check form-check-inline cusRadio">
													<input class="radioBtnClass" type="radio"  name="timeCheck" id="radiobtn1" value="2"> 
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="radiobtn2">Date</label>
												</div>												
											</div>
											<div class="w-100 m-t-10"></div>
											
											<div class="col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">From Date</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<input type="text" id="startDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareToFromDateAudior();">
														</div>
													</div>
												</div>
											</div>
											<div class="col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">To Date</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<input type="text" id="endDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareToFromDateAudior();">
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-12 text-right">
												<button class="btn btn-primary" onclick="searchData();">Search</button>
											</div>
										
												 
										</div>
										<div id="loadingDiv1" class="text-center">
						<img
							src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
					</div>
									</div>
										
									<div class="col-sm-6 offset-sm-1">						 	
						 	<canvas id="signChart3"></canvas>
					          </div>
								 	<div class="col-sm-6 offset-sm-1">
										<canvas class="dashBarChart" id="groupedStatusChart" hidden=""></canvas>
									</div> 
									
								</div>
							</div>
						</div>
					</div>				
				</div>
		</div>

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

<!-- jQuery chart -->
<script src="${pageContext.request.contextPath}/resources/js/chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chartjs-plugin-datalabels-new.js"></script>


<script>
$(function(){
	var invoiceChart,settledInvoice,unsettledInvoice;
	
	
	// audit count bar chart
	var xValues = ['MMU 1','MMU 2','MMU 3','MMU 4'];
   
   	invoiceChart = new Chart("groupedCountChart", {
   	    type: "bar",
   	    data: {
   	        labels: xValues,
   	        datasets: [
   	         	{
   	   		      label: "Total OPD Visit",
   	   			  backgroundColor: "#4568dc",
   	   		      data: [100,80,70,55]
   	   		    },
   	   		    {
   	   		      label: "Total Audit",
   	   		      backgroundColor:  "#ff7e5f",
   	   		      data: [90,80,58,50]
   	   		    }
   	        ]
   	    },
   	    options: {
   	        responsive: true,
   	        animation: {
   	            onComplete: function() {
   	              delayed = true;
   	            },
   	            delay: function(context){
   	              let delay = 0;
   	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
   	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
   	              }
   	              return delay;
   	            },
   	        }
   	    },
   	    plugins: [ChartDataLabels],
   	    options: {
   	    	maintainAspectRatio: false,
   	    	layout: {
   	            padding: {
   	                top: 20
   	            }
   	        },
   	    	plugins:{
   	    		legend: {
   	                display: false
   	            },
   	            datalabels: {
   	            	formatter:function(value,context){
   	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   	            	},
   	            	color: 'black',
   	                anchor:'end',
   	                align:'end',
   	                offset:5,	        	                
   	                font: {
   	                    size: 10,
   	                    weight: 'bold'
   	                }
   	            }
   	        },
   	    }
   	    
   	});
     
  // unsettledInvoice pie chart
 	var yValues = [100,80];
 	var pieColors = [ 
 			"#4568dc",
    	    "#ff7e5f",
    	    "#feb47b",
    	    "#DCE35B",
    	    
    	  ];
 	
 	unsettledInvoice = document.getElementById("unsettledInvoice");
     var unsettledData = {
         
         datasets: [
             {
                 data: yValues,
                 backgroundColor: pieColors
             }],
     };

      pieChart = new Chart(unsettledInvoice, {
       type: 'pie',
       data: unsettledData,
       plugins: [ChartDataLabels],
       options: {
     	  plugins:{
       		legend: {
                   display: false
               },
 	            datalabels: {
 	            	formatter:function(value,context){
 	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
 	            	},
 	            	color: function(context) {
	            		  var index = context.dataIndex;
	            		  var value = context.dataset.data[index];
	            		  return value < 1 ? 'transparent' :  // draw negative values in red
	            		    'white';
	            		},
	            		font: { 
                          weight: 'bold'
                      }
 	            }
 	        },
       }
     });
	
	// grouped bar chart
	/* var xValues = ['MMU 1','MMU 2','MMU 3','MMU 4','MMU 5'];
   
   	invoiceChart = new Chart("groupedDiscrepChart", {
   	    type: "bar",
   	    data: {
   	        labels: xValues,
   	        datasets: [
   	         	{
   	   		      label: "Blunder",
   	   			  backgroundColor: "#ff3364",
   	   		      data: [20,3,10,15,10]
   	   		    },
   	   		    {
   	   		      label: "Blooper",
   	   		      backgroundColor: "#F7A400",
   	   		      data: [10,4,8,8,8]
   	   		    },
   	   		    {
   	   		      label: "Dubious",
   	   		      backgroundColor: "#ffce33",
   	   		      data: [6,5,19,17,19]
   	   		    }
   	        ]
   	    },
   	    options: {
   	        responsive: true,
   	        animation: {
   	            onComplete: function() {
   	              delayed = true;
   	            },
   	            delay: function(context){
   	              let delay = 0;
   	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
   	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
   	              }
   	              return delay;
   	            },
   	        }
   	    },
   	    plugins: [ChartDataLabels],
   	    options: {
   	    	maintainAspectRatio: false,
   	    	layout: {
   	            padding: {
   	                top: 20
   	            }
   	        },
   	    	plugins:{
   	    		legend: {
   	                display: false
   	            },
   	            datalabels: {
   	            	formatter:function(value,context){
   	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   	            	},
   	            	color: 'black',
   	                anchor:'end',
   	                align:'end',
   	                offset:5,	        	                
   	                font: {
   	                    size: 10,
   	                    weight: 'bold'
   	                }
   	            }
   	        },
   	    }
   	    
   	});
   	
   	 */
 // auditor status bar chart
	var xValues = ['Aman','Amit','Brijesh','Manish','Harsh'];
   
   	invoiceChart = new Chart("groupedStatusChart", {
   	    type: "bar",
   	    data: {
   	        labels: xValues,
   	        datasets: [
   	   		    {
   	   		      label: "Total Audit",
   	   		      backgroundColor:  "#b06ab3",
   	   		      data: [44,55,65,50,73]
   	   		    }
   	        ]
   	    },
   	    options: {
   	        responsive: true,
   	        animation: {
   	            onComplete: function() {
   	              delayed = true;
   	            },
   	            delay: function(context){
   	              let delay = 0;
   	              if (context.type === 'data' && context.mode === 'default' && !delayed) {
   	                delay = context.dataIndex * 300 + context.datasetIndex * 100;
   	              }
   	              return delay;
   	            },
   	        }
   	    },
   	    plugins: [ChartDataLabels],
   	    options: {
   	    	maintainAspectRatio: false,
   	    	layout: {
   	            padding: {
   	                top: 20
   	            }
   	        },
   	    	plugins:{
   	    		legend: {
   	                display: false
   	            },
   	            datalabels: {
   	            	formatter:function(value,context){
   	            		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   	            	},
   	            	color: 'black',
   	                anchor:'end',
   	                align:'end',
   	                offset:5,	        	                
   	                font: {
   	                    size: 10,
   	                    weight: 'bold'
   	                }
   	            }
   	        },
   	    }
   	    
   	});
   	
})
</script>
</body>

</html>






