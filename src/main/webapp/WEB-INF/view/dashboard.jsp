<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />

<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>


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
var totalregcount_c="";
var totalregcount_o="";

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

var diagnosis_data = "";
var diagnosisArray =[];
var diagnosisArrayVal =[];
var diagnosisName="";
var totdiagnosis="";

var communicable_data = "";
var communicableArray =[];
var communicableArrayVal =[];
var commDiseaseName="";
var totcommunicable="";


var pieChartLoad1, pieChartLoad2,pieChartLoadState, groupChart, districtChart,drugbarChart,pieChart,signChart,diagChart,pandemicChart; 

$j(document).ready(function()
		{
	
	//getMMUList('');
	GetDashBoardData();
	GetDistrictList();	
	getDistrictListForGPS();
	getPandmicZoneData();
	
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
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#district').append(combo);
	    	
	    }
	    
	});
}	
  
  
  function getDistrictListForGPS(){
	  
	  var params = {};
	  
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/gps/getDistrictListForMap",
		    data: JSON.stringify(params),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = '<option value="" disabled selected>Select</option>';
		    	
		    	for(var i=0;i<result.list.length;i++){
		    		combo += '<option value='+result.list[i].districtId+'>' +result.list[i].districtName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#distForGPS').append(combo);
		    	
		    }
		    
		});
	}	
  
  function GetDashBoardData(){
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
   	$j('#fromDate').val(currentDate);
   	$j('#toDate').val(currentDate);

   	$j("#stateStat1").prop("checked", true);
   	$j("#stat1").prop("checked", true);

   	$j('#symptomsId').html(fromDate+"-"+currentDate);
   	$j('#diagnosisId').html(fromDate+"-"+currentDate);
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/dashboard/getDashBoardData",
		    data: JSON.stringify({"districtId" : "0","cityId" : "0", "fromDate" : currentDate,"toDate" : currentDate,"mmuId":"0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	$j("#loadingDiv").hide();
		    	var data="";
		    	if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined)
		    	data = result.dashboard_data.dashboard_data;     
	            $j.each(data, function(i, data){
	            
	                $j("#totalRegistration").text(data.totalregcount);
			    	$j("#totalAppointment").text(data.totalappcount);
			    	$j("#labourRegistration").text(data.totalregcount_l);
			    	$j("#gcRegistration").text(data.totalregcount_n);
			    	$j("#labourAppointment").text(data.totalappcount_l);
			    	$j("#gcAppointment").text(data.totalappcount_n);
	            });
		    	
	            var piedata="";
	            if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined )
	              piedata = result.dashboard_data.piechart_data;   
	            pieArray=[];
	            pieArray1=[];
	            $j.each(piedata, function(i, piedata){
	            
	            	totalregcount_m=piedata.totalregcount_m;
	            	totalregcount_w=piedata.totalregcount_w;
	            	totalregcount_c=piedata.totalregcount_c;
	            	totalregcount_o=piedata.totalregcount_o;
	            
	            	  pieArray.push(totalregcount_m);
	            	  pieArray.push(totalregcount_w);
	            	  pieArray.push(totalregcount_c);
	            	  pieArray.push(totalregcount_o);
	            	  
	            	  
	            	totalappcount_m=piedata.totalappcount_m;
	            	totalappcount_w=piedata.totalappcount_w;
	            	totalappcount_c=piedata.totalappcount_c;
	            	totalappcount_o=piedata.totalappcount_o;
	            	
	            	pieArray1.push(totalappcount_m);
	            	pieArray1.push(totalappcount_w);
	            	pieArray1.push(totalappcount_c);
	            	pieArray1.push(totalappcount_o);
	            	
	            	
	            	// pie chart 1 total registration
	            	var totalRegCanvas = document.getElementById("totalReg");
	            	var regData = {
	            	    labels: [
	            	        "Men",
	            	        "Women",
	            	        "Children",
	            	        "Transgender"
	            	    ],
	            	    datasets: [
	            	        {
	            	        	data: pieArray,
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
	        	
	        	symptomsArray =[];
	        	symptomsArrayVal =[];
		            if(result!=null && result.dashboard_data!=null && result.dashboard_data!=undefined)
	        	signsSymptoms_data = result.dashboard_data.signsSymptoms_data;
	                 
		      	$j.each(signsSymptoms_data, function(i, signsSymptoms_data){

		      		symptomsName=signsSymptoms_data.symptoms_name;
		      		symptomsArray.push(symptomsName);
		      		totsymptoms=signsSymptoms_data.tot;
		      		symptomsArrayVal.push(totsymptoms);

			        	});

		     // top 10 signs and symptoms charts
				

				//sign chart 
				
		    	var xValues =  symptomsArray;
		    	var yValues = symptomsArrayVal;
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

		    	signChart = new Chart("signChart", {
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
	  destroyAllChart();	  
	  $j("#district").val('0');
	  $j('#noRegData').hide();
	  $j('#noAppData').hide();	  
	  $j("#topDistrictSelect").val('Registration');
	  GetCityList();
	  GetDashBoardData();
	  setTopDistrict(); 
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
			    url: "${pageContext.servletContext.contextPath}/dashboard/getDashBoardData",
			    data: JSON.stringify({"districtId" : districtId,"cityId" : cityId, "fromDate" : fromDate,"toDate" : toDate,"mmuId":mmuId}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	$j("#loadingDiv").hide();
			    	pieArray=[];
			    	pieArray1=[];
			    	
			    	var data = result.dashboard_data.dashboard_data;     
		            $j.each(data, function(i, data){
		                if(data.totalregcount !=''){
		                $j("#totalRegistration").text(data.totalregcount);
		                }
		                else{
		                	$j("#totalRegistration").text("0");
		                }
		                if(data.totalappcount !=''){
				    	$j("#totalAppointment").text(data.totalappcount);
				    	}
		                else{
		                	$j("#totalAppointment").text("0");	
		                }
		                if(data.totalregcount_l !=''){
				    	$j("#labourRegistration").text(data.totalregcount_l);
		                }
		                else{
		                	$j("#labourRegistration").text("0");
		                }
		                if(data.totalregcount_n !=''){
				    	$j("#gcRegistration").text(data.totalregcount_n);
		                }
		                else{
		                	$j("#gcRegistration").text("0");	
		                }
		                if(data.totalappcount_l !=''){
				    	$j("#labourAppointment").text(data.totalappcount_l);
		                }
		                else{
		                	$j("#labourAppointment").text("0");	
		                }
		                if(data.totalappcount_n !=''){
				    	$j("#gcAppointment").text(data.totalappcount_n);
		                }
		                else{
		                	$j("#gcAppointment").text("0");
		                }
		            });
			    	
			    	
		            var piedata = result.dashboard_data.piechart_data;   
		            
		            
		            $j.each(piedata, function(i, piedata){
		            
		            	totalregcount_m=piedata.totalregcount_m;
		            	totalregcount_w=piedata.totalregcount_w;
		            	totalregcount_c=piedata.totalregcount_c;
		            	totalregcount_o=piedata.totalregcount_o;
		            
		            	  pieArray.push(totalregcount_m);
		            	  pieArray.push(totalregcount_w);
		            	  pieArray.push(totalregcount_c);
		            	  pieArray.push(totalregcount_o);
		            	  if( totalregcount_m=='0' && totalregcount_w =='0' && totalregcount_c =='0' && totalregcount_o=='0'){
		            		  
		            		  $j('#noRegData').show();
		            	  }
		            	  else{
		            		  $j('#noRegData').hide(); 
		            	  }
		            	  
		            	totalappcount_m=piedata.totalappcount_m;
		            	totalappcount_w=piedata.totalappcount_w;
		            	totalappcount_c=piedata.totalappcount_c;
		            	totalappcount_o=piedata.totalappcount_o;
		            	
		            	if(totalappcount_m=='0' && totalappcount_w=='0' && totalappcount_c =='0' && totalappcount_o=='0' ){
		            		 $j('#noAppData').show()
		            	}
		            	else{
		            		$j('#noAppData').hide()
		            	}
		            	
		            	pieArray1.push(totalappcount_m);
		            	pieArray1.push(totalappcount_w);
		            	pieArray1.push(totalappcount_c);
		            	pieArray1.push(totalappcount_o);
		            	
		            	destroyAllChart();
		            	
		            	// pie chart 1 total registration
		            	var totalRegCanvas = document.getElementById("totalReg");
		            	
		            	var regData = {
		            	    labels: [
		            	        "Men",
		            	        "Women",
		            	        "Children",
		            	        "Transgender"
		            	    ],
		            	    datasets: [
		            	        {
		            	        	data: pieArray,
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
		            	 getPandmicZoneData();
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


		        	symptomsArray =[];
		        	symptomsArrayVal =[];
			            
		        	signsSymptoms_data = result.dashboard_data.signsSymptoms_data;
		                 
			      	$j.each(signsSymptoms_data, function(i, signsSymptoms_data){

			      		symptomsName=signsSymptoms_data.symptoms_name;
			      		symptomsArray.push(symptomsName);
			      		totsymptoms=signsSymptoms_data.tot;
			      		symptomsArrayVal.push(totsymptoms);

				        	});

			     // top 10 signs and symptoms charts
					//sign chart 
					
			    	var xValues =  symptomsArray;
			    	var yValues = symptomsArrayVal;
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

			    	signChart = new Chart("signChart", {
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
  
  function destroyAllChart(){
	  pieChart.destroy();
	  pieChartLoad1.destroy(); 
	  pieChartLoad2.destroy();
	  //pieChartLoadState.destroy();
	  groupChart.destroy();
	  districtChart.destroy();
	  signChart.destroy();
	  diagChart.destroy();
	  commDiseaseChart.destroy();
	  pandemicChart.destroy();
	  	  
  }
  
  function compareToFromDate() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();

		if (process(toDate) < process(fromDate)) {
			alert("To Date should not be earlier than from Date");
			$('#toDate').val("");
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
		
		function setTopDistrict(){

			districtChart.destroy();
			
			 var topDistrictval=$("#topDistrictSelect").val();			    

              topDistricts_data_reg;
              topDistricts_data_apt;  
              topDistricts_data_lab;
              topDistricts_data_dipsn;
              topDistricts_data_medstock; 
                       
            if(topDistrictval=='Registration'){
            	districtArray=[];
	            topDistArrayVal=[];
	      	$j.each(topDistricts_data_reg, function(i, topDistricts_data_reg){

		        	  districtname=topDistricts_data_reg.cityname;
		        	  districtArray.push(districtname);
		        	  tot_count=topDistricts_data_reg.totpt;
		        	  topDistArrayVal.push(tot_count);

		        	});
               
             }

            if(topDistrictval=='Appointment'){
            	districtArray=[];
	            topDistArrayVal=[];
    	      	$j.each(topDistricts_data_apt, function(i, topDistricts_data_apt){

    		        	  districtname=topDistricts_data_apt.cityname;
    		        	  districtArray.push(districtname);
    		        	  tot_count=topDistricts_data_apt.totopd;
    		        	  topDistArrayVal.push(tot_count);

    		        	});
                   
                 }	

            if(topDistrictval=='Lab'){
            	districtArray=[];
	            topDistArrayVal=[];
    	      	$j.each(topDistricts_data_lab, function(i, topDistricts_data_lab){

    		        	  districtname=topDistricts_data_lab.cityname;
    		        	  districtArray.push(districtname);
    		        	  tot_count=topDistricts_data_lab.totinvestigation;
    		        	  topDistArrayVal.push(tot_count);

    		        	});
                   
                 }	

            if(topDistrictval=='Dispensary'){
            	districtArray=[];
	            topDistArrayVal=[];
    	      	$j.each(topDistricts_data_dipsn, function(i, topDistricts_data_dipsn){

    		        	  districtname=topDistricts_data_dipsn.cityname;
    		        	  districtArray.push(districtname);
    		        	  tot_count=topDistricts_data_dipsn.topmedissue;
    		        	  topDistArrayVal.push(tot_count);

    		        	});
                   
                 }	

            if(topDistrictval=='Medicine Stock'){
            	districtArray=[];
	            topDistArrayVal=[];
    	      	$j.each(topDistricts_data_medstock, function(i, topDistricts_data_medstock){

    		        	  districtname=topDistricts_data_medstock.city_name;
    		        	  districtArray.push(districtname);
    		        	  tot_count=topDistricts_data_medstock.stock;
    		        	  topDistArrayVal.push(tot_count);

    		        	});
                   
                 }		
	        	
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
			 
		     
		   
		      }	

		function setStateOPDStatistics(){

			pieChartLoadState.destroy();
			     
			var statisticType = $('input[name="stateStatistic"]:checked').val();

	       if(statisticType=='1'){
	    	   pieopddata1;
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
			

	       }


	       if(statisticType=='2'){
	    	    pieopddata2;
	          
	    	    pieOpdArray2=[];
		    			    	
	            $j.each(pieopddata2, function(i, pieopddata2){

	            	 
	            	topmedissue=pieopddata2.topmedissue;
	            	mlc_flag=pieopddata2.mlc_flag;
	            	totopd=pieopddata2.totopd;
	            	totinvestigation=pieopddata2.totinvestigation;
	            	
	            	pieOpdArray2.push(totopd);
	            	pieOpdArray2.push(topmedissue);
	            	pieOpdArray2.push(totinvestigation);
	            	pieOpdArray2.push(mlc_flag);
	            	 
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
	            	        	data: pieOpdArray2,
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

	          }

	         

			 }
	      
		
	 function setOPDStatisticsCitywise(){

		groupChart.destroy();
		     
		var statisticType = $('input[name="Statistic"]:checked').val();

       if(statisticType=='1'){
        
		cityArray =[];
		opdArray =[];
		mIssuedArray =[];
		invArray =[];
		mlcArray =[];
        opdStatistics_city_data_total;
        
        totalCities;
        
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
                            size: 10,
                            weight: 'bold'
                        }
	                }
    	        },
            }
            
        });

       }


       if(statisticType=='2'){
           
   		cityArray1 =[];
   		opdArray1 =[];
   		mIssuedArray1 =[];
   		invArray1 =[];
   		mlcArray1 =[];  
   		opdStatistics_city_data_ddc;
           
           totalCities1=opdStatistics_city_data_ddc.length;
           
           if(totalCities1<8){	            	
           	$j('.chartWrap').css('width','100%');
           }
           else{
           		var gchartWidth = totalCities*80;
               $j('.chartWrap').css('width',gchartWidth);
               console.log('cities'+totalCities);
           }
           //alert(JSON.stringify(opdStatistics_city_data_total));
           $j.each(opdStatistics_city_data_ddc, function(i, opdStatistics_city_data_ddc){

            	
           	cityname=opdStatistics_city_data_ddc.cityname;	            	
           	cityArray1.push(cityname);
           	
           	topmedissue=opdStatistics_city_data_ddc.topmedissue;
           	mIssuedArray1.push(topmedissue);
           	
           	totopd=opdStatistics_city_data_ddc.totopd;
           	opdArray1.push(totopd);
           	
           	totinvestigation=opdStatistics_city_data_ddc.totinvestigation;
           	invArray1.push(totinvestigation);

           	mlcflag=opdStatistics_city_data_ddc.mlc_flag;
        	mlcArray1.push(mlcflag);
        	
            
           	  
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
           var xValues = cityArray1;
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
                           data: mIssuedArray1
                         },
                         {
                           label: "Investigation",
                           backgroundColor: invColor,
                           borderColor: invColor,
                           borderWidth: 0,
                           //data: [43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34,43,35,35,25,21,39,34]
                           data: invArray1
                         },
                         {
                           label: "MLC",
                           backgroundColor: mlcColor,
                           borderColor: mlcColor,
                           borderWidth: 0,
                           data: mlcArray1
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

         

		 }
	 
	 function getExpiryMedicineNotification(){
		 	
		 		var pathname = window.location.pathname;
		 		var accessGroup = "MMUWeb";

		 		var url = window.location.protocol + "//"
		 				+ window.location.host + "/" + accessGroup
		 				+ "/treatmentAudit/getExpiryMedicine";
		      	//var data = $('employeeId').val();
		 	   // alert("radioValue" +radioValue);
		 		$.ajax({
		 			type : "POST",
		 			contentType : "application/json",
		 			url : url,
		 			data : JSON.stringify({
		 				'employeeId' : "1",
		 				'mmuId': <%=mmuId%>
		 			}),
		 			dataType : 'json',
		 			timeout : 100000,
		 			
		 			success : function(res)
		 			
		 			{
		 			var aspMedicine = res.asp_medicine;
		 			var drugsName='';
		 			var expiryStock='';
		 			var rolName='';
		 			var rolExpiry='';
		 			var trHTML='';
		 			var i=0;
		 			var rolHTML='';
		 			var j=0;
		 			var expiryMedicine="";
		 			var totalData="";
		 			        if(aspMedicine!=null){
		 					  expiryMedicine= aspMedicine.expiry_medicine;
		 			       
		 					totalData=aspMedicine.total_data;
		 					}          
		 		           if(expiryMedicine!="")
		 					for(var i=0;i<expiryMedicine.length;i++){
			 					 expiryStock= expiryMedicine[i].expiry_stock;
			 					 drugsName=expiryMedicine[i].mmu_name;
			 					trHTML +='<tr><td>';
			 					trHTML +='<a href="${pageContext.request.contextPath}/dispencery/drugExpiryList" id="mmuNameNotification'+i+'">'+drugsName+'</a>';
			 					trHTML +='</td>';
			 					trHTML +='<td>';
			 					trHTML +='<a href="${pageContext.request.contextPath}/dispencery/drugExpiryList" id="expiryMedicine'+i+'">'+expiryStock+'</a>';
			 					trHTML +='</td></tr>' ;
			 				    i++;
		 					}
		 					$('#notificationGrid').html(trHTML);
		 					 for(var i=0;i<totalData.length;i++){
		 						rolExpiry= totalData[i].expiry_stock;
			 					rolName=totalData[i].mmu_name;
			 					rolHTML +='<tr><td>';
			 					rolHTML +='<a href="javascript:printRolReport()" id="totalMedicine'+j+'">'+rolName+'</a>';
			 					rolHTML +='</td>' ;
			 					rolHTML +='<td>';
			 					rolHTML +='<a href="javascript:printRolReport()" id="expiryMedicine'+j+'">'+rolExpiry+'</a>';
			 					rolHTML +='</td></tr>' ;
			 					j++;
		 					} 
		 					$('#roldExpiryGrid').html(rolHTML);
		 					
		 					//document.getElementById("mmuNameNotification").innerHTML ="Drugs Name :"+ drugsName;
		 					//document.getElementById("expiryMedicine").innerHTML ="Expiry Stock :"+ expiryStock;
		 					//document.getElementById("totalMedicine").innerHTML ="ROL Name :"+ rolName;
		 					//document.getElementById("rolExpiry").innerHTML ="ROL Expiry :"+ rolExpiry;
		 					 /* <a href="#" id="mmuNameNotification"></a>
							    <a href="#" id="expiryMedicine">Expiry Medicine :</a>
						        <a href="#" id="totalMedicine"></a> */
		 		    	 
		 			   },
		 	           error: function (jqXHR, exception) {
		 	               var msg = '';
		 	               if (jqXHR.status === 0) {
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
	 
	 function printRolReport(){
		 var mmuId = <%=mmuId%>;
	     var url="${pageContext.request.contextPath}/report/printRolExpiryReport?mmuId="+mmuId+"";
	 	 openPdfModel(url);
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
			<div class="col-xl-4 col-lg-4 col-sm-6">
				<div class="widget-panel widget-style-2 bg-purple-gradient">
					<i class="fa fa-users"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="totalRegistration">&nbsp;</h2>
					<div class="info">Total Registration</div>
				</div>
			</div>
			<div class="col-xl-4 col-lg-4 col-sm-6">
				<div class="widget-panel widget-style-2 bg-green-gradient">
					<i class="fa fa-user-friends"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="gcRegistration">&nbsp;</h2>
					<div class="info">General Citizen Registration</div>
				</div>
			</div>
			<div class="col-xl-4 col-lg-4 col-sm-6">
				<div class="widget-panel widget-style-2 bg-orange-gradient">
					<i class="fa fa-people-carry"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="labourRegistration">&nbsp;</h2>
					<div class="info">Labour Registration</div>
				</div>
			</div>
			<div class="col-xl-4 col-lg-4 col-sm-6">
				<div class="widget-panel widget-style-2 bg-blue-gradient">
					<i class="fa fa-calendar-alt"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="totalAppointment">&nbsp;</h2>
					<div class="info">Total Appointment</div>
				</div>
			</div>
			<div class="col-xl-4 col-lg-4 col-sm-6">
				<div class="widget-panel widget-style-2 bg-yellow-gradient">
					<i class="fa fa-list-alt"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="gcAppointment">&nbsp;</h2>
					<div class="info">General Citizen Appointment</div>
				</div>
			</div>
			<div class="col-xl-4 col-lg-4 col-sm-6">
				<div class="widget-panel widget-style-2 bg-darkgreen-gradient">
					<i class="fa fa-calendar-check"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="labourAppointment">&nbsp;</h2>
					<div class="info">Labour Appointment</div>
				</div>
			</div>
		</div>
		<!-- end row -->
		
		<div class="row">
			<%-- <div class="col-lg-6 col-sm-6">
				<a href="http://www.meter1.in/MMSSY" target="_blank" title="Patient Feedback Dashboard Website">
					<div class="widget-panel external">
						<h2>Patient Feedback Dashboard <i class="fa fa-external-link-alt"></i></h2> 
						<img src="${pageContext.request.contextPath}/resources/images/pat-feedback.jpg"/>
					</div>
				</a>
			</div>  --%>
			<div class="col-lg-6 col-sm-12">
				<div class="portlet">
					<div class="portlet-heading">
						<h4 class="portlet-title">Patient Feedback </h4>
					</div>
					
					<div class="portlet-body p-b-10">	
						<div class="clearfix">
						<div class="feedbackPieChart" id="">
										
						<canvas id="feedbackPie"></canvas>
						<img class="feedChartImg" src="${pageContext.request.contextPath}/resources/images/excellent.svg"/>		
						</div>
						<div class="feedbackData">
							<h3 class="good"><small>Excellent</small><span id="gd"><small></small></span></h3>
							<h3 class="average"><small>Good</small> <span id="avg"> <small></small></span></h3> 
							<h3 class="bad"><small>Needs Improvement</small> <span id="bad"> <small></small></span></h3>
						</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="pieLegends feed ">
									<div><span style="background:#45B649"></span>Excellent </div>
									<div><span style="background:#fdc507"></span>Good </div>
									<div><span style="background:#d7350a"></span>Needs Improvement </div>
								</div>
							</div>
						</div> 
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-sm-12">
			
				<%-- <a href="https://www.eicherlive.in/" target="_blank" title="MMU GPS Tracking Website">
					<div class="widget-panel external">
						<h2>MMU GPS Tracking <i class="fa fa-external-link-alt"></i></h2>
						<img src="${pageContext.request.contextPath}/resources/images/mmu-track.jpg"/>
					</div>	
				</a> --%>
				
				<div class="portlet donut">
						<div id="portlet4" class="panel-collapse collapse show">
							<div class="portlet-body">							
								<div class="row m-b-4">									
									<div class="col-lg-5 col-sm-6">
										<h4 class="portlet-title2">Total Appointment</h4>	
										<div id="noRegData">No Data Available</div>
										<div class="clearmob">
											<canvas class="dashPieChart" id="totalReg"></canvas>
										</div>
									</div>
									<div class="col-lg-5 offset-lg-1  col-sm-6">
										<h4 class="portlet-title2">Total Registration</h4>	
										<div id="noAppData">No Data Available</div>
										<div class="clearmob">
											<canvas class="dashPieChart" id="totalApp"></canvas>
										</div>
									</div>
									<div class="col-12">
										<div class="pieLegends">
											<div><span style="background:#4568dc"></span> Men</div>
											<div><span style="background:#b06ab3"></span> Women</div>
											<div><span style="background:#45B649"></span> Children</div>
											<div><span style="background:#ff7e5f"></span> Transgender</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			
			</div>
		</div>
			
		<div class="row" id="mmuMap">
			<div class="col-12">
				<div class="portlet">			
                     
					<div id="mapSection" class="portlet-heading p-b-0">
						<div class="row clearfix">
							<div class="col-lg-4 col-sm-6">
								<h4 class="portlet-title">Chhattisgarh Map</h4>											
							</div>
							<div class="col-lg-4 col-sm-6 offset-lg-4">
								<div class="form-group row">
									<label class="col-md-5 col-form-label">District</label>
									<div class="col-md-7">
										<select class="form-control" id="distForGPS" onchange="populateMapWithData(this.value)">
											
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="portlet1" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							
							 <!-- <div id="map"></div> -->
							 <div class="mapParent">
							 	<div id="gmap" style="height:400px; width:100%;"></div>
							 	<div class="mapLoader text-theme text-center">
						      			<img  src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"> 
						      			<br>
						      			<h6 class="text-theme">Fetching MMU's...</h6>
							 	</div>
							 </div>
							 
						</div>
					</div>
				</div>								
			</div>	
		</div>
		
		
		<div class="row">
				
			
			<div class="col-lg-6 col-sm-12">
				
				<div class="portlet">					
					<div class="portlet-heading">
						<div class="row">
							<div class="col-lg-6 col-sm-12">
								<h4 class="portlet-title">OPD Statistics (State) </h4>					
							</div>
							<div class="col-lg-6 col-sm-12 text-right-desk mn-t-10">
								<div class="form-check form-check-inline cusRadio m-r-15">
									<input class="form-check-input" type="radio"  name="stateStatistic" checked="checked" id="stateStat1" value="1" onclick="setStateOPDStatistics()"> 
									<span class="cus-radiobtn"></span> 
									<label class="form-check-label" for="stateStat1">Total</label>
								</div>
								<div class="form-check form-check-inline cusRadio">
									<input class="form-check-input" type="radio"  name="stateStatistic" id="stateStat2" value="2" onclick="setStateOPDStatistics()"> 
									<span class="cus-radiobtn"></span> 
									<label class="form-check-label" for="stateStat2">Dai Didi Clinic</label>
								</div>				
							</div>
						</div>
					</div>
					<div id="portlet2" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							<div class="row">
								<div class="col-lg-5 col-sm-7">
									<canvas class="dashPieChart" id="totalOpd"></canvas>
								</div>
								<div class="col-4 offset-1">
									<div class="pieLegends sideways">
										
										<div><span style="background:#b06ab3"></span>OPD</div>
										<div><span style="background:#45B649"></span>Medicine </div>
										<div><span style="background:#ff7e5f"></span>Investigation </div>
										<div><span style="background:#4568dc"></span>MLC </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>				
				</div>
				
				
				<div class="col-lg-6 col-sm-12">
				
				<div class="portlet">					
					<div class="portlet-heading">
						<div class="row">
							<div class="col-lg-6 col-sm-12">
								<h4 class="portlet-title">OPD Statistics (City wise) </h4>					
							</div>
							<div class="col-lg-6 col-sm-12 text-right-desk mn-t-10">
								<div class="form-check form-check-inline cusRadio m-r-15">
									<input class="form-check-input" type="radio"  name="Statistic" checked="checked" id="stat1" value="1" onclick="setOPDStatisticsCitywise()"> 
									<span class="cus-radiobtn"></span> 
									<label class="form-check-label" for="stat1">Total</label>
								</div>
								<div class="form-check form-check-inline cusRadio">
									<input class="form-check-input" type="radio"  name="Statistic" id="stat2" value="2" onclick="setOPDStatisticsCitywise()"> 
									<span class="cus-radiobtn"></span> 
									<label class="form-check-label" for="stat2">Dai Didi Clinic</label>
								</div>				
							</div>
						</div>
					</div>
					<div id="portlet2" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0 p-b-10">
							<div class="horizontalScroll">
								<div class="chartWrap">
									<canvas class="dashGroupChart" id="groupChart"></canvas>
								</div>
							</div>
							<div class="col-12">
								<div class="pieLegends m-t-0">
									<div><span style="background:#b06ab3"></span> OPD</div>
									<div><span style="background:#45B649"></span> Medicine</div>
									<div><span style="background:#ff7e5f"></span> Investigation</div>
									<div><span style="background:#5B86E5"></span> MLC</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
										
			</div>
		</div>
		
		<div class="row">
			<%-- <div class="col-lg-6 col-sm-6">
				<a href="http://www.meter1.in/MMSSY" target="_blank" title="Patient Feedback Dashboard Website">
					<div class="widget-panel external">
						<h2>Patient Feedback Dashboard <i class="fa fa-external-link-alt"></i></h2> 
						<img src="${pageContext.request.contextPath}/resources/images/pat-feedback.jpg"/>
					</div>
				</a>
			</div>  --%> 
			<div class="col-lg-6 col-sm-6">
				<div class="portlet">
					<div class="portlet-heading  p-b-0">
						<h4 class="portlet-title blockdiv clearfix">Top 10 Signs &amp; Symptoms  <span class="pull-right mob" id="symptomsId"></span> </h4>
					</div>
					
					<div class="portlet-body p-b-10">						 	
						 	<canvas id="signChart"></canvas>
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-sm-6">
				<div class="portlet relativeDiv">
					<div class="portlet-heading  p-b-0">
						<h4 class="portlet-title blockdiv clearfix">Top 10 Diagnosis  <span class="pull-right mob" id="diagnosisId"></span> </h4>
					</div>					
					<div class="portlet-body p-b-10">						 	
					 	<canvas id="diagChart"></canvas>
					</div>
				</div>		
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<div class="portlet">
					<div class="portlet-heading p-b-10">
						<div class="row">
							<div class="col-6">
								<h4 class="portlet-title">Top 10 Communicable disease </h4>	
							</div>
						</div>
					</div>
					<div id="portlet3" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							<canvas class="dashBarChart" id="commDiseaseChart"></canvas>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="col-md-12">
				<div class="portlet">
					<div class="portlet-heading p-b-10">
						<div class="row">
							<div class="col-6">
								<h4 class="portlet-title">Pandemic Zones</h4>	
							</div>
						</div>
					</div>
					<div id="portlet3" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							<canvas class="dashBarChart" id="pandemicChart"></canvas>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="col-md-12">
				<div class="portlet">
					<div class="portlet-heading p-b-10">
						<div class="row">
							<div class="col-md-6 col-sm-12">
								<h4 class="portlet-title">Top District </h4>	 
							</div>
							<div class="col-md-6 col-sm-12">
								<div class="form-group row">
									<div class="col-md-6 col-sm-12 text-right">
									</div>
									<div class="col-md-6 col-sm-12">
										<select class="form-control" id="topDistrictSelect" onchange="setTopDistrict()">
											<option value="Registration">Registration</option>
											<option value="Appointment">Appointment</option>
											<option value="Lab">Lab</option>
											<option value="Dispensary">Dispensary</option>
											<option value="Medicine Stock">Medicine Stock</option>
										</select>
									</div>
								</div>	
							</div>
						</div>
					</div>
					<div id="portlet3" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							<canvas class="dashBarChart" id="barChart"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- <div class="row">
			<div class="col-md-12">
				<div class="portlet">
					<div class="portlet-heading">
						<div class="row">
							<div class="col-12">
								<h4 class="portlet-title">Drug Expiry</h4>	
							</div>
						</div>
					</div>
					<div id="portlet3" class="panel-collapse collapse show">
						<div class="portlet-body">
							<canvas class="dashBarChart" id="drugbarChart"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div> -->
		
		
		<!-- update Box -->
                 
            <span class="notificationIcon">
            <i class="fa fa-bell"></i>
            <span class="badge">!</span>
            </span>
			<div class="updatesBox">
				<div class="heading">
					Updates
					<span class="minMaxBtn" onclick="closeUpdate();"><i class="fa fa-times"></i></span>
				</div>
				
				<div id="demo" class="updateContent scroll-text">
				<marquee behavior="scroll" direction="up" scrollamount="3" onmouseover="this.stop();" onmouseout="this.start();">
				<table id="ddrugsExpiry" class="table table-bordered">
																<thead>
																	
																	<th>Drugs Name</th>
																	<th>Expiry Stock</th>
																	</thead>	
				    <tbody id="notificationGrid">
					
												<tr>
													
				 							
				 							</tr>
				 			</tbody>
				 		</table>
				 	<table id="rolExpiry" class="table table-bordered">
																<thead>
																	
																	<th>ROL Name</th>
																	<th>Expiry Stock</th>
																	</thead>	
				    <tbody id="roldExpiryGrid">
					
												<tr>
													
				 							
				 							</tr>
				 			</tbody>
				 		</table>		
				 		</marquee>								
				</div>
			</div>
		<!-- end -->
		
		
	</div>
	<!-- container -->
	<!-- content -->
	</div>
</div>
<!-- END wrapper -->

<!-- jQuery chart -->
<script src="${pageContext.request.contextPath}/resources/js/chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chartjs-plugin-datalabels-new.js"></script>
<!-- map -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/mapdata/d3.v4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mapdata/d3-scale-chromatic.v0.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mapdata/chhattisgarhDistrictData.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mapdata/d3-tip.js"></script> --%>
<script>
var showBox = 0;

$(function(){	
	
	$('.notificationIcon').on('click',function(){
		
		if(showBox==0){
			$('.updatesBox').animate({'right':'10px','opacity':'1'},300);
			showBox = 1;
		}
		else if(showBox==1){
			closeUpdate();
		}
		
	});
	
});

function closeUpdate(){
	$('.updatesBox').animate({'right':'-250px','opacity':'0'},300);
	showBox = 0;
}
	
	</script>
<script>
$(function(){
/* 	$('.dashGroup button').on('click',function(){
		$('.dashGroup button').removeClass('active');
		$(this).addClass('active');
	});
	
	$j('#multipleSelect').multiSelect(); */ 
	
	$('.autofocus').focus();

});
</script>

<!-- <script>
var mapWidth =$('#map').width();
var format = d3.format(",");

// Set tooltips
var tip = d3.tip()
    .attr('class', 'd3-tip')
    .offset([-10, 0])
    .html(function (d) {
        return "<strong>State: </strong><span class='d3-details'>" + d.properties.State_Name + "<br></span>" + "<strong>Dist: </strong><span class='d3-details'>" + (d.properties.Dist_Name) + "</span>";
    })

var margin = { top: 20, right: 0, bottom: 20, left: 0 },
    width = mapWidth - margin.left - margin.right, 
    height = 574 - margin.top - margin.bottom;


var color = d3.scaleThreshold()
    .domain([10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120])
    .range(d3.schemeSet3);



var svg = d3.select("#map")
    .append("svg")
    .attr("width", width + (margin.right + margin.left))
    .attr("height", height + (margin.top + margin.bottom))
    .append('g')
    .attr('class', 'map');



let preparedData = data[0];
var projection = d3.geoMercator()
    .fitExtent([[10, 10], [width, height]], preparedData);

var path = d3.geoPath().projection(projection);
    
svg.call(tip);
const mainG = svg.append("g")
    .attr("transform", 'translate(20,20)')
    .attr("class", "states");
ready(null, preparedData);

function ready(error, data, population) {
   
    mainG.selectAll("path")
        .data(data.features)
        .enter().append("path")
        .attr("d", path)
        .attr('data-id',function(d){                    
            return d.properties.Dist_Name;
        })
        .style("fill", function(d) {
            return color(Math.floor(Math.random() * 100));
        })
        .style('stroke', 'white')
        .style('stroke-width', 0.3)
        .style("opacity", 0.8)
        .on('mouseover', function (d) {
            tip.show(d);

            d3.select(this)
                .style("opacity", 1)
                .style("stroke", "white")
                .style("stroke-width", 3);
        })
        .on('mouseout', function (d) {
            tip.hide(d);

            d3.select(this)
                .style("opacity", 0.8)
                .style("stroke", "white")
                .style("stroke-width", 0.3);
        });
}


</script> -->


<script>


//pie chart 2 total appointment


</script>

<!-- ########################## map ################################ -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAVhYvBRlvc4NjN2O5CDANTErWTcyW8pBQ&"></script>
<script>
//var InforObj = [];
var distData;
/* var distData =  [
			    {
			      "districtName": "Rajnandgaon",
			      "lat": 21.0976,
			      "lng": 81.0337,
			      "id":"rajnDist",
			      "totalMMU": 2,
			      "mmu": [
			        {
			          "id":"rajnmmu1",
			          "name": "Rajnandgaon-mmu1",
			          "lat": 21.1066175,
			          "lng": 81.0154125,
			          "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
			        },
			        {
			          "id":"rajnmmu2",
			          "name": "Rajnandgaon-mmu2",
			          "lat": 21.0835164,
			          "lng": 81.018515,
			          "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
			        }
			      ]
			    },
			    {
			      "districtName": "Raipur",
			      "lat": 21.2514,
			      "lng": 81.6296,
			      "id":"raipDist",
			      "totalMMU": 2,
			      "mmu": [
			        {
			          "id":"raipmmu1",
			          "name": "Raipur-mmu1",
			          "lat": 21.2489398,
			          "lng": 81.5700341,
			          "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
			        },
			        {
			          "id":"raipmmu2",
			          "name": "Raipur-mmu2",
			          "lat": 21.2468505,
			          "lng": 81.6257639,
			          "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
			        }
			      ]
			    },
			    {
			      "districtName": "Raigarh",
			      "lat": 21.8974,
			      "lng": 83.3950,
			      "id":"raigDist",
			      "totalMMU": 2,
			      "mmu": [
			        {
			       	  "id":"raigmmu1",
			          "name": "Raigarh-mmu1",
			          "lat": 21.9059907,
			          "lng": 83.3784189,
			          "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
			        },
			        {
			          "id":"raigmmu2",
			          "name": "Raigarh-mmu2",
			          "lat": 21.896379,
			          "lng": 83.4013658,
			          "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
			        }
			      ]
			    }
			  ]; */
	
function populateMapWithData(distId) {
		
				  
  	$('.mapLoader').show();
  	
	$.ajax({
		url : '${pageContext.servletContext.contextPath}/gps/getGPSInfo',
		dataType : "json",
		data : JSON.stringify({
			"distId":distId
		}),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
			distData = response;
			
			
			  
			  if (distId==0){
				  alert('No district selected');
			  }else{
				  var selectedDist = distData;
				  console.log('Selected district is : '+distData.districtName+' generating map for it.');		  
				  initMap(selectedDist);
			  }
						
		},
		error : function(e) {

			console.log("ERROR: ", e);

		},
		done : function(e) {
			console.log("DONE");
			alert("success");

		}
	});
	
	
	  /* var distValue = selectObject.value;
	  
	  if (distValue==0){
		  alert('No district selected');
	  }else{
		  var selectedDist = distData[distValue-1];
		  console.log('Selected district is : '+selectedDist.districtName+' generating map for it.');		  
		  initMap(selectedDist);
	  } */
	}

	function initMap(selecDist) {
		
		$('.mapLoader').hide();
		
		var fetchDist = selecDist;
		console.log("fetchdate"+fetchDist);
		var map;		
		const infowindow = new google.maps.InfoWindow(); 
		const mmuImg="${pageContext.servletContext.contextPath}/resources/images/bus-marker.png";
				
		if(fetchDist==0){
			
			// show chattisgarh when no district is selected
			distLoc = { lat: 21.2787, lng: 81.8661 };
			
			map = new google.maps.Map(document.getElementById("gmap"), {
			  zoom: 7,
			  center: distLoc,
			});
			
		}
		else{
			
			// show district
			distLoc = { lat: fetchDist.lat, lng: fetchDist.lng };
						
			map = new google.maps.Map(document.getElementById("gmap"), {
				  zoom: 12,
				  center: distLoc,
			});
			
			for (var i = 0; i < fetchDist.mmu.length; i++) {
                placeMarker(fetchDist.mmu[i])
			}
			
			
		}
		
		// focusing on city and plotting marker for each mmu in city
		function placeMarker( mmu ) {
			
			const marker = new google.maps.Marker({
			  position : new google.maps.LatLng( mmu.lat, mmu.lng ),
			  map : map,
			  icon : mmuImg
			});
			
			//Commented staff details at UI and Backend both on 13th dec 2023
			//var contentString = '<div class="mapContent" id="'+ mmu.id +'"><h4>' + mmu.name + '</h4><div><span>Timing</span>' + mmu.startTime + ' - ' + mmu.endTime + '</div><div><span>Location</span>' + mmu.location + '</div><div><span>Landmark</span>' + mmu.landmark + '</div><div><span>Staff</span>' + mmu.staffAvailable + '</div></div>';
			var contentString = '<div class="mapContent" id="'+ mmu.id +'"><h4>' + mmu.name + '</h4><div><span>Timing</span>' + mmu.startTime + ' - ' + mmu.endTime + '</div><div><span>Location</span>' + mmu.location + '</div><div><span>Landmark</span>' + mmu.landmark + '</div></div>';
			/* <p>'+mmu.detail+'</p> */
			
			google.maps.event.addListener(marker, 'click', function(){
			    infowindow.close(); // Close previously opened infowindow
			    infowindow.setContent(contentString);
			    infowindow.open(map, marker);
			});
		 }
	}
	
	
	$(document).ready(function(){
		var a=0;
		initMap(0);	
		getExpiryMedicineNotification();
		var userTypeName=$('#userTypeName').val();
		if(userTypeName.startsWith('Doct') ||userTypeName.startsWith('ANM')||userTypeName.startsWith('Lab')||userTypeName.startsWith('Phar'))
	     {
			$('#portlet1').hide();
			$('#mapSection').hide();
	     }
	});

</script>

<script>
function getPandmicZoneData(){
	var fromDate=$j('#fromDate').val();
   	var toDate=$j('#toDate').val();

  jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/dashboard/getPandmicZoneData",
		    data: JSON.stringify({"fromDate" : fromDate,"toDate" : toDate,"mmuId":"0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	
		    	var pandemicArray =[];
	        	var pandemicTotalVal =[];
		            
	        	var pandemicCasesInfo = result.data.pandemicCasesInfo;
	                 
		      	$j.each(pandemicCasesInfo, function(i, pandemicCasesInfo){

		      		var investigationName=pandemicCasesInfo.investigation_name;
		      		var wardName=pandemicCasesInfo.ward_name;
		      		pandemicArray.push(wardName+"("+investigationName+")");
		      		var total=pandemicCasesInfo.total;
		      		pandemicTotalVal.push(total);

			        	});
		    	if(pandemicChart){
		       		pandemicChart.destroy();
	        	}
		    	var xValues = pandemicArray;
		       	var yValues = pandemicTotalVal;
		       	var delayed;
		       	
		       	var barColors = [    
		       	    "#b06ab3",
		       	    "#45B649",
		       	    "#ff7e5f",
		       	    "#feb47b",
		       	    "#DCE35B",
		       	    "#4568dc"
		       	  ];
		       
		       	pandemicChart = new Chart("pandemicChart", {
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
		    }   
		   
		});
	}	

//pandemic zones bar chart


</script>

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
