
/**
* Theme: Velonic - Responsive Bootstrap 4 Admin Dashboard
* Author: Coderthemes
* Morris Chart
*/

!function($) {
    "use strict";

    var MorrisCharts = function() {};

   //creates line chart
    MorrisCharts.prototype.createLineChart = function(element, data, xkey, ykeys, labels, lineColors) {
        Morris.Line({
          element: element,
          data: data,
          xkey: xkey,
          ykeys: ykeys,
          labels: labels,
          resize: true, //defaulted to true
          lineColors: lineColors,
          gridLineColor: '#eeeeee'
        });
    },
    //creates area chart
    /*MorrisCharts.prototype.createAreaChart = function(element, pointSize, lineWidth, data, xkey, ykeys, labels, lineColors) {
        Morris.Area({
            element: element,
            pointSize: 0,
            lineWidth: 0,
            data: data,
            xkey: xkey,
            ykeys: ykeys,
            labels: labels,
            resize: true,
            lineColors: lineColors,
            gridLineColor: '#eeeeee'
        });
    },*/
    //creates Bar chart
    MorrisCharts.prototype.createBarChart  = function(element, data, xkey, ykeys, labels, lineColors, mybarlegend) {
    	
    	   (function() {
    		   var $, MyMorris;

    		   MyMorris = window.MyMorris = {};
    		   $ = jQuery;

    		   MyMorris = Object.create(Morris);

    		   MyMorris.Bar.prototype.defaults["labelTop"] = false;

    		   MyMorris.Bar.prototype.drawLabelTop = function(xPos, yPos, text) {
    		  var label;
    		  return label = this.raphael.text(xPos, yPos, text).attr('font-size', this.options.gridTextSize).attr('font-family', this.options.gridTextFamily).attr('font-weight', this.options.gridTextWeight).attr('fill', this.options.gridTextColor);
    		   };

    		   MyMorris.Bar.prototype.drawSeries = function() {
    		  var barWidth, bottom, groupWidth, idx, lastTop, left, leftPadding, numBars, row, sidx, size, spaceLeft, top, ypos, zeroPos;
    		  groupWidth = this.width / this.options.data.length;
    		  numBars = this.options.stacked ? 1 : this.options.ykeys.length;
    		  barWidth = (groupWidth * this.options.barSizeRatio - this.options.barGap * (numBars - 1)) / numBars;
    		  if (this.options.barSize) {
    		    barWidth = Math.min(barWidth, this.options.barSize);
    		  }
    		  spaceLeft = groupWidth - barWidth * numBars - this.options.barGap * (numBars - 1);
    		  leftPadding = spaceLeft / 2;
    		  zeroPos = this.ymin <= 0 && this.ymax >= 0 ? this.transY(0) : null;
    		  return this.bars = (function() {
    		    var _i, _len, _ref, _results;
    		    _ref = this.data;
    		    _results = [];
    		    for (idx = _i = 0, _len = _ref.length; _i < _len; idx = ++_i) {
    		   row = _ref[idx];
    		   lastTop = 0;
    		   _results.push((function() {
    		     var _j, _len1, _ref1, _results1;
    		     _ref1 = row._y;
    		     _results1 = [];
    		     for (sidx = _j = 0, _len1 = _ref1.length; _j < _len1; sidx = ++_j) {
    		    ypos = _ref1[sidx];
    		    if (ypos !== null) {
    		      if (zeroPos) {
    		     top = Math.min(ypos, zeroPos);
    		     bottom = Math.max(ypos, zeroPos);
    		      } else {
    		     top = ypos;
    		     bottom = this.bottom;
    		      }
    		      left = this.left + idx * groupWidth + leftPadding;
    		      if (!this.options.stacked) {
    		     left += sidx * (barWidth + this.options.barGap);
    		      }
    		      size = bottom - top;
    		      if (this.options.verticalGridCondition && this.options.verticalGridCondition(row.x)) {
    		     this.drawBar(this.left + idx * groupWidth, this.top, groupWidth, Math.abs(this.top - this.bottom), this.options.verticalGridColor, this.options.verticalGridOpacity, this.options.barRadius, row.y[sidx]);
    		      }
    		      if (this.options.stacked) {
    		     top -= lastTop;
    		      }
    		      this.drawBar(left, top, barWidth, size, this.colorFor(row, sidx, 'bar'), this.options.barOpacity, this.options.barRadius);
    		      _results1.push(lastTop += size);

    		      if (this.options.labelTop && !this.options.stacked) {
    		     var label = this.drawLabelTop((left + (barWidth / 2)), top - 10, row.y[sidx]);
    		     var textBox = label.getBBox();
    		     _results.push(textBox);
    		      }
    		    } else {
    		      _results1.push(null);
    		    }
    		     }
    		     return _results1;
    		   }).call(this));
    		    }
    		    return _results;
    		  }).call(this);
    		   };
    		 }).call(this);
    		   
    	
        /*Morris.Bar({
            element: element,
            data: data,
            xkey: xkey,
            ykeys: ykeys,
            labels: labels,
            barColors: lineColors,
            gridLineColor: '#eeeeee',
            	labelTop:true
        });*/
    },
    //creates Donut chart
    MorrisCharts.prototype.createDonutChart = function(element, data, colors) {
       /* Morris.Donut({
            element: element,
            data: data,
            colors: colors
        });*/
    }, 
    MorrisCharts.prototype.init = function() {

       //create line chart
        /* var $data  = [
            { y: '2009', a: 100, b: 90 , c: 75 },
            { y: '2010', a: 75,  b: 65 , c: 50 },
            { y: '2011', a: 50,  b: 40 , c: 30 },
            { y: '2012', a: 75,  b: 65 , c: 50 },
            { y: '2013', a: 50,  b: 40 , c: 22 },
            { y: '2014', a: 75,  b: 65 , c: 50 },
            { y: '2015', a: 100, b: 90 , c: 65 }
          ];
        this.createLineChart('morris-line-example', $data, 'y', ['a', 'b','c'], ['Series A', 'Series B', 'Series C'], ['#1a2942', '#3bc0c3', '#f13c6c']);*/
 
        //creating area chart
     /*   var $areaData = [
                { y: '2009', a: 10, b: 20 },
                { y: '2010', a: 75,  b: 65 },
                { y: '2011', a: 50,  b: 40 },
                { y: '2012', a: 75,  b: 65 },
                { y: '2013', a: 50,  b: 40 },
                { y: '2014', a: 75,  b: 65 }
                
            ];
        this.createAreaChart('morris-area-example', 0, 0, $areaData, 'y', ['a', 'b'], ['Series A', 'Series B'], ['#1a2942', '#3bc0c3']);
 */
        //creating bar chart
       /* var $barData  = [
            { y: 'Jan 2018', a: 100, b: 90 , c: 40, d: 10 },
            { y: 'Feb 2018', a: 75,  b: 65 , c: 20, d: 20 },
            { y: 'Mar 2018', a: 50,  b: 40 , c: 50, d: 15},
            { y: 'Apr 2018', a: 75,  b: 65 , c: 95, d: 30 },
            { y: 'May 2018', a: 50,  b: 40 , c: 22, d: 80 },
            { y: 'Jun 2018', a: 75,  b: 65 , c: 56, d: 10 }
           
        ];*/
       // this.createBarChart('morris-bar-example', $barData, 'y', ['a', 'b', 'c', 'd'], ['OPD', 'Attc', 'Referral', 'Others'], ['#3bc0c3', '#1a2942', '#e67a77', '#f13c6c']);

       //creating donut chart
       /* var $donutData = [
                {label: "Completed", value: 10},
                {label: "Total ME", value: 60},
                {label: "Pending", value: 20},                
                {label: "Over Due", value: 30},
               
            ];
        this.createDonutChart('morris-donut-example', $donutData, ['#e67a77', '#3bc0c3', '#1a2942', '#615ca8']);*/
        
       /* var $donutData1 = [
            
            {label: "Pending", value: 30},
            {label: "Total MB", value: 60},
            {label: "Completed", value: 10},
            {label: "Over Due", value: 20}
        ];
    this.createDonutChart('morris-donut-example1', $donutData1, ['#f13c6c', '#615ca8', '#ebc142', '#1a2142']);*/
    
    
    
    
   /* 
    var $donutData2 = [
        {label: "Completed", value: 10},
        {label: "Pending", value: 20},
        {label: "Total ME", value: 30},
       
    ];
this.createDonutChart('morris-donut-example2', $donutData2, ['#e67a77', '#3bc0c3', '#1a2942']);

var $donutData3 = [
    
    {label: "Pending", value: 20},
    {label: "Total MB", value: 60},
    {label: "Completed", value: 10},
    {label: "Due", value: 30}
];
this.createDonutChart('morris-donut-example3', $donutData3, ['#f13c6c', '#615ca8', '#ebc142', '#1a2142']);
    */
  
    },
    //init
    $.MorrisCharts = new MorrisCharts, $.MorrisCharts.Constructor = MorrisCharts
}(window.jQuery),

//initializing 
function($) {
    "use strict";
    $.MorrisCharts.init();
}(window.jQuery);