<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>


<script type="text/javascript">

nPageNo=1;
var $j = jQuery.noConflict();

 
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
						<div class="row text-right">
							<div class="col-md-3">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Select District</label>
									</div>
									<div class="col-md-7">
										<select class="form-control" id="">
											<option>All</option>
										</select>
									</div>
								</div> 
							</div>
							<div class="col-md-3">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Select City</label>
									</div>
									<div class="col-md-7">
										<select class="form-control" id="">
											<option>All</option>
										</select>
									</div>
								</div> 
							</div>
							
							<div class="col-md-3">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">From Date</label>
									</div>
									<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" id="" class="calDate form-control" value="" placeholder="DD/MM/YYYY">
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-3">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">To Date</label>
									</div>
									<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" id="" class="calDate form-control" value="" placeholder="DD/MM/YYYY">
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="row">
			<div class="col-xl-4 col-md-4">
				<div class="widget-panel widget-style-2 bg-purple-gradient">
					<i class="fa fa-users"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="totalOPD">543</h2>
					<div class="info">Total Registration</div>
				</div>
			</div>
			<div class="col-xl-4 col-md-4">
				<div class="widget-panel widget-style-2 bg-green-gradient">
					<i class="fa fa-user"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="totalAttc">279</h2>
					<div class="info">General Public Registration</div>
				</div>
			</div>
			<div class="col-xl-4 col-md-4">
				<div class="widget-panel widget-style-2 bg-orange-gradient">
					<i class="fa fa-people-carry"></i>
					<h2 class="m-0 text-white" data-plugin="counterup"
						id="totalMedicalExam">264</h2>
					<div class="info">Labour Registration</div>
				</div>
			</div>
		</div>
		<!-- end row -->
		
		<div class="row">
			<div class="col-md-6">
				<div class="portlet">
					<!-- /primary heading -->
					<!-- 
					<div class="col-md-4">
						<div class="form-group row">
							<div class="col-md-5">
								<label class="col-form-label">Year</label>
							</div>
							<div class="col-md-7">
								<select class="form-control" id="multipleSelect" name="parss" multiple>
									<option name="op1">2021</option>
									<option name="op2">2020</option>
									<option name="op3">2019</option>
									<option name="op4">2018</option>
									<option name="op5">2017</option>
								</select>
							</div>
						</div> 
					</div> -->
                     
					<div class="portlet-heading p-b-0">
						<div class="row clearfix">
							<div class="col-md-4">
								<h4 class="portlet-title">Chhattisgarh Map</h4>											
							</div>
							<div class="col-md-12">
								<div class="form-group row">
									<label class="col-md-5 col-form-label">Diagnosis Marked as </label>
									<div class="col-md-7 ">
										<select class="form-control autofocus">
											<option>Communicable</option>
											<option>Infectious</option>
											<option>Communicable &amp; Infectious</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group row">
									<label class="col-md-5 col-form-label">Disease</label>
									<div class="col-md-7 ">
										<select class="form-control autofocus">
											<option>Dengue</option>
											<option>Malaria</option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="portlet1" class="panel-collapse collapse show">
						<div class="portlet-body p-t-0">
							
							 <div id="map"></div>
						</div>
					</div>
				</div>								
			</div>		
			
			<div class="col-md-6">
				<div class="portlet">
					<!-- /primary heading -->
					<div class="portlet-heading">
						<div class="row">
							<div class="col-12">
								<h4 class="portlet-title">Top Districts</h4>	
								
								<!-- <div class="col-md-6">
									<select class="form-control mn-t-5">
										<option value="1">District Wise</option>
										<option value="2">City Wise</option>
									</select>	
								</div> -->						
							</div>
							<!-- <div class="col-md-5 clearfix mn-t-5">
								<div class="btn-group dashGroup pull-right" role="group">
								  <button type="button" class="btn btn-secondary">Weekly</button>
								  <button type="button" class="btn btn-secondary">Monthly</button>
								  <button type="button" class="btn btn-secondary">Yearly</button>
								</div>
							</div> -->
						</div>
					</div>
					<div id="portlet2" class="panel-collapse collapse show">
						<div class="portlet-body">
							<canvas class="dashBarChart" id="groupChart"></canvas>
						</div>
					</div>
				</div>
				
				<div class="portlet">
					<!-- /primary heading -->
					<div class="portlet-heading">
						<div class="row">
							<div class="col-12">
								<h4 class="portlet-title">Top Districts</h4>	
							</div>
						</div>
					</div>
					<div id="portlet3" class="panel-collapse collapse show">
						<div class="portlet-body">
							<canvas class="dashBarChart" id="barChart"></canvas>
						</div>
					</div>
				</div>						
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
			<div class="row">
				<div class="col-md-6">
					<div class="portlet donut">
						<!-- /primary heading -->
						<div class="portlet-heading p-b-0">
							<div class="row">
								<div class="col-md-12">
									<h4 class="portlet-title">Total Registration</h4>											
								</div>
							</div>
						</div>
						<div id="portlet4" class="panel-collapse collapse show">
							<div class="portlet-body">
								<div class="row">
									<div class="col-md-5">
										<div class="pieLegends">
										<div><span style="background:#4568dc"></span> Men</div>
										<div><span style="background:#b06ab3"></span> Women</div>
										<div><span style="background:#45B649"></span> Children</div>
										<div><span style="background:#ff7e5f"></span> Transgender</div>
									</div>
									</div>
									<div class="col-md-6">
										<canvas class="dashPieChart" id="totalReg"></canvas>
									</div>
								</div>
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
<script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>

<!-- map -->
<script src="${pageContext.request.contextPath}/resources/js/mapdata/d3.v4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mapdata/d3-scale-chromatic.v0.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mapdata/chhattisgarhDistrictData.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mapdata/d3-tip.js"></script>

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

<script>
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
    height = 510 - margin.top - margin.bottom;


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


</script>


<script>

// grouped bar chart  
var xValues = ["Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma"];
var delayed;
var opdColor = "#b06ab3"
var medColor = "#45B649"
var invColor = "#ff7e5f"
var refColor = "#c0f366"

new Chart("groupChart", {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [
            {
                label: "OPD",
                backgroundColor: opdColor,
                borderColor: opdColor,
                borderWidth: 0,
                data: [90,55,56,75,36,55,46,70]
              },
              {
                label: "Medicine Issued",
                backgroundColor: medColor,
                borderColor: medColor,
                borderWidth: 0,
                data: [40,70,30,60,100,70,40,60]
              },
              {
                label: "Investigattion",
                backgroundColor: invColor,
                borderColor: invColor,
                borderWidth: 0,
                data: [60,72,44,65,96,71,39,10]
              },
              {
                label: "Referral",
                backgroundColor: refColor,
                borderColor: refColor,
                borderWidth: 0,
                data: [60,90,70,30,100,70,40,60]
              }
            ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins:{
            legend: {
                display: true,
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
    
});

//bar chart
var xValues = ["Raipur", "Durg", "Jashpur", "Bijapur", "Raigarh","Gaurella","Sukma"];
var yValues = [55, 49, 44, 24, 15,25,10];
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

new Chart("barChart", {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [{
            label: 'Top Districts/Cities ',
            backgroundColor: barColors,
            data: yValues
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins:{
            legend: {
                display: true,
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
    
});

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
            data: ['47', '23', '30','10'],
            backgroundColor: [
            	"#4568dc",
                "#b06ab3",
                "#45B649",
                "#ff7e5f"
            ]
        }]
};

var pieChart = new Chart(totalRegCanvas, {
  type: 'doughnut',
  data: regData,
  options: {
      responsive: true,
      plugins:{
          legend: {
              display: false,
              position: 'left'
          },
          labels: {
              // render 'label', 'value', 'percentage', 'image' or custom function, default is 'percentage'
              render: 'label',
              fontColor: 'white',
          }
      }
  }
});



</script>
</body>

</html>
