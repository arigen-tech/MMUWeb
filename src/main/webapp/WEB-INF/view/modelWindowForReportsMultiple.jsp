<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message</title>

<link href="${pageContext.request.contextPath}/resources/css/video-js.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/videoJs.js"></script>

<style>
iframe{
	width:100%;
	height:500px;
}
#pdfContent{
	margin-top:-100px;
}
.resizeLoader{
	width:24px;
	height:24px;
	display:inline-block
}
.resizeLoader img{
	width:100%
}
@media (max-width:560px){
	#pdfModal .modal-dialog{
		margin-top: 120px;
	}
}

</style>
</head>
<%-- <script src="${pageContext.request.contextPath}/resources/js/pdf.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pdf.worker.js"></script> --%>
<body>

<!-- <div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-lg pdfModal" role="document">
  <input type="hidden" id="urlForReport" name="urlForReport" value="">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">Report</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="clearCanvas()">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
			<div id="pdf-main-container">
				
				<div id="pdf-contents">
					<div id="pdf-metatop">
						
						<div class="row">
							<div class="col-4">
								<div id="pdf-buttonstop">
									<button class="btn btn-primary noMinWidth" id="pdf-prevtop"><i class="fa fa-chevron-left"></i></button>
									<button class="btn btn-primary noMinWidth" id="pdf-nexttop"><i class="fa fa-chevron-right"></i></button>
								</div>
							</div>
							<div class="col-4 text-center">
								<div id="page-count-containertop">Page <div id="pdf-current-pagetop"></div> of <div id="pdf-total-pagestop"></div></div>
							</div>
							<div class="col-4 text-right">
								<a href="" id="pdfUrltop" class="btn btn-primary" >Save</a>
								<button class="btn btn-primary" onclick="printIt()">Print</button>
							</div>
						</div>
					
					</div>
					<div id="pdf-loader" class="text-theme"><i class="fa fa-spinner fa-spin"></i> Loading document ...</div>
					<div class="pdf-canvas-holder">
					<canvas id="pdf-canvas" width="800" height="1132"></canvas>
					</div>
					<div id="pdf-meta">
						
						<div class="row">
							<div class="col-4">
								<div id="pdf-buttons">
									<button class="btn btn-primary noMinWidth" id="pdf-prev"><i class="fa fa-chevron-left"></i></button>
									<button class="btn btn-primary noMinWidth" id="pdf-next"><i class="fa fa-chevron-right"></i></button>
								</div>
							</div>
							<div class="col-4 text-center">
								<div id="page-count-container">Page <div id="pdf-current-page"></div> of <div id="pdf-total-pages"></div></div>
							</div>
							<div class="col-4 text-right">
								<a href="" id="pdfUrl" class="btn btn-primary" >Save</a>
								<button class="btn btn-primary" onclick="printIt()">Print</button>
							</div>
						</div>
					
					</div>
					<div id="page-loader"><i class="fa fa-spinner fa-spin"></i> Loading page ... </div>
				</div>
			</div>
      </div> 
    </div>
  </div>
</div> -->

<div class="modal" id="pdfModal" tabindex="-1" role="dialog" aria-labelledby="docModal">
	  <div class="modal-dialog modal-xl" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Report</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closePdfModalReport()">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      		
	      		<div class="text-center hideInMob">
	      			<div id="page-loader" class="text-theme">
	      			<span class="resizeLoader">
	      				<img  src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif"> 
	      			</span>
	      			Loading Document ... </div>
	      		</div>
	      		<div class="text-center showInMob">
	      			<h4>Please download the report to view in Mobile/Tablet.</h4>
	      			<br/><br/>
	      			<a id="downloadRep" href="" class="btn btn-primary" target="_blank">Download Report</a>
	      		</div>
	      		
				<div id="pdfContent">
				</div>		
	      </div>
	       
	    </div>
	  </div>
</div>


<div class="modal" id="imgModal" tabindex="-1" role="dialog" aria-labelledby="imageModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Image</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeImgModal()">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">	      		
				<div id="imgContent" class="text-center">
				</div>		
	      </div>
	       
	    </div>
	  </div>
</div>


<div class="modal" id="vidModal" tabindex="-1" role="dialog" aria-labelledby="videoModal">
	  <div class="modal-dialog modal-md" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Video</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeVidModal()">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">	      		
				<div id="vidContent" class="text-center">
				</div>		
	      </div>
	       
	    </div>
	  </div>
</div>

<div class="video-backdrop">
		<span class="closeVideo"><i class="fa fa-times"></i></span>
		<div class="videoPlayer">
			<video id="my-video" class="video-js" controls>		
				<source src="${pageContext.request.contextPath}/resources/videos/small.mp4" type="video/mp4" />	    
			    <p class="vjs-no-js"> To view this video please enable JavaScript, and consider upgrading to a supports HTML5 video</p>
			 </video>
		</div>
	</div>



<div class="modal-backdrop show" style="display: none;"></div>
<div class="cus-backdrop" style="display: none;"></div>
</body>

<script>
var browser;

$(document).ready(function() {
   
    var agent = navigator.userAgent.match(/(opera|chrome|safari|firefox|msie)\/?\s*(\.?\d+(\.\d+)*)/i);
    if (navigator.userAgent.match(/Edge/i) || navigator.userAgent.match(/Trident.*rv[ :]*11\./i)) {
        browser = "edge";
    }
    else {
        browser = agent[1].toLowerCase();
    }

    
});
</script>
<script>
	
var pdfFile,imageFile,videoFile;

// for Pdf
function openPdfModel(url){
	showPdfDocReport(url);
	$j('#pdfModal #page-loader').show();
	$j('#pdfModal').show();
	$j('.cus-backdrop').show();
}

function showPdfDocReport(url){
	pdfFile = url;	
	$('#downloadRep').attr('href',url);
	$('#pdfModal #pdfContent').html('<iframe  src="'+pdfFile+'" id="framePdf" frameborder="0"></iframe>');
	$j('#pdfModal #page-loader').hide();
}
function closePdfModalReport(){	  
    $('#pdfModal #page-loader').show();
    $j('#pdfModal').hide();
	$j('.cus-backdrop').hide();
}

// for Image
function openImg(url){
	showImage(url);
	$j('#imgModal').show();
	$j('.cus-backdrop').show();
}
function showImage(url){
	imageFile = url;	
	$('#imgModal #imgContent').html('<img class="img-fluid" src="'+imageFile+'" />');
}
function closeImgModal(){	  
    $j('#imgModal').hide();
	$j('.cus-backdrop').hide();
}


//for Video
function openVid(url){
	showVid(url);
	$j('#vidModal').show();
	$j('.cus-backdrop').show();
}
function showVid(url){
	videoFile = url;
	$('#vidModal #vidContent').html('<a class="videoModBox" data-src="'+videoFile+'" ><img src="${pageContext.request.contextPath}/resources/images/thumb.jpg" /></a>');
}
function closeVidModal(){	  
    $j('#vidModal').hide();
	$j('.cus-backdrop').hide();
}

</script>
<script>
$(function(){
	 var player = videojs('my-video');
	
	$(document).on('click','.videoModBox', function(e){		
		e.preventDefault();
		var videoFile = $(this).attr('data-src');
		player.src(videoFile);
		videojs('my-video');
		$('.video-backdrop').fadeIn(200);
	});	
	
	 $(document).on('click','.closeVideo', function(e){
		 $('.video-backdrop').fadeOut(200);
		 player.pause();	
	 }); 
	 
});
</script>
</html>