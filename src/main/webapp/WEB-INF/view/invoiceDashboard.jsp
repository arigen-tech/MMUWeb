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

</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">
				
				<div class="row">
					<div class="col-lg-6 col-sm-12">
				
						<div class="portlet">					
							<div class="portlet-heading">
								<div class="row">
									<div class="col-lg-7 col-sm-12">
										<h4 class="portlet-title">Settled Invoice (Society wise) </h4>					
									</div>
									<div class="col-lg-5 col-sm-12 text-right-desk mn-t-10">
										<select class="form-control">
										
										</select>		
									</div>
								</div>
							</div>
							<div id="portlet2" class="panel-collapse collapse show">
								<div class="portlet-body p-t-0">
									<div class="row">
										<div class="col-lg-5 col-sm-7">
											<canvas class="dashPieChart" id="settledPie"></canvas>
										</div>
										<div class="col-4 offset-1">
											<div class="pieLegends sideways">
												
												<div><span style="background:#4568dc"></span>Society 1</div>
												<div><span style="background:#b06ab3"></span>Society 2 </div>
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
									<div class="col-lg-7 col-sm-12">
										<h4 class="portlet-title">Unsettled Invoice (Society wise) </h4>					
									</div>
									<div class="col-lg-5 col-sm-12 text-right-desk mn-t-10">
										<select class="form-control">
										
										</select>		
									</div>
								</div>
							</div>
							<div id="portlet2" class="panel-collapse collapse show">
								<div class="portlet-body p-t-0">
									<div class="row">
										<div class="col-lg-5 col-sm-7">
											<canvas class="dashPieChart" id="unsettledPie"></canvas>
										</div>
										<div class="col-4 offset-1">
											<div class="pieLegends sideways">
												
												<div><span style="background:#4568dc"></span>Society 1</div>
												<div><span style="background:#b06ab3"></span>Society 2 </div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>				
					</div>
				</div>
				
				
				
				<div class="row">
						<div class="col-md-12">
							<div class="portlet">
								<div class="portlet-heading p-b-10">
									<div class="row">
										<div class="col-lg-9 col-sm-12">
											<h4 class="portlet-title">Vendor Wise Invoice</h4>	
										</div>
										<div class="col-lg-3 col-sm-12 text-right-desk mn-t-10">
											<select class="form-control">
											
											</select>		
										</div>
									</div>
								</div>
								<div id="portlet3" class="panel-collapse collapse show">
									<div class="portlet-body p-t-0">
										<canvas class="dashBarChart" id="invoiceChart"></canvas>
									</div>
								</div>
							</div>
						</div>								
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->
<script src="${pageContext.request.contextPath}/resources/js/chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chartjs-plugin-datalabels-new.js"></script>

<script>

//Settled Invoice Pie Chart
   	var settledInvCanvas = document.getElementById("settledPie");
   	
   	var regData = {
   	    labels: [
   	        "Society 1",
   	        "Society 2"
   	    ],
   	    datasets: [
   	        {
   	        	data: [30000,20000],
   	            backgroundColor: [
   	            	"#4568dc",
	        	    "#b06ab3",
	        	    "#45B649",
	        	    "#ff7e5f",
	        	    "#feb47b",
	        	    "#DCE35B",
	        	    "#c0f366"
   	            ], 
   	            borderColor: [
   	            	"#4568dc",
	        	    "#b06ab3",
	        	    "#45B649",
	        	    "#ff7e5f",
	        	    "#feb47b",
	        	    "#DCE35B",
	        	    "#c0f366"
   	            ]
   	        }],
   	};

   	pieChartLoad1 = new Chart(settledInvCanvas, {
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

  //Settled Invoice Pie Chart
   	var unsettledInvCanvas = document.getElementById("unsettledPie");
   	
   	var regData = {
   	    labels: [
   	        "Society 1",
   	        "Society 2"
   	    ],
   	    datasets: [
   	        {
   	        	data: [30000,10000],
   	            backgroundColor: [
   	            	"#4568dc",
	        	    "#b06ab3",
	        	    "#45B649",
	        	    "#ff7e5f",
	        	    "#feb47b",
	        	    "#DCE35B",
	        	    "#c0f366"
   	            ], 
   	            borderColor: [
   	            	"#4568dc",
	        	    "#b06ab3",
	        	    "#45B649",
	        	    "#ff7e5f",
	        	    "#feb47b",
	        	    "#DCE35B",
	        	    "#c0f366"
   	            ]
   	        }],
   	};

   	pieChartLoad2 = new Chart(unsettledInvCanvas, {
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
   	
   	
// Invoice Chart
var xValues = ["2018-19", "2019-20", "2020-21", "2021-22"];
var delayed;
var settledColor = "#b06ab3"
var unsettledColor = "#45B649"

groupChart = new Chart("invoiceChart", {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [
            {
                label: "Settled",
                backgroundColor: settledColor,
                borderColor: settledColor,
                borderWidth: 0,
                data: [30000,10000]
              },
              {
                label: "Unsettled",
                backgroundColor: unsettledColor,
                borderColor: unsettledColor,
                borderWidth: 0,
                data: [20000,15000]
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
</script>

</body>

</html>



