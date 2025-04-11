<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message</title>
</head>
<link href="${pageContext.request.contextPath}/resources/css/video-js.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/videoJs.js"></script>
<style>
#videoModal .closeVideo{
	display:none;
}
#imageModal,#docModal,#videoModal{
z-index:1150;
}
iframe{
	width:100%;
	height:500px;
}
</style>
<body>

<!-- <div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-lg pdfModal" role="document">
  <input type="hidden" id="urlForReport" name="urlForReport" value="">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">Report</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="clearCanvasRms()">
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
								<button class="btn btn-primary" onclick="printItRms()">Print</button>
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
								<button class="btn btn-primary" onclick="printItRms()">Print</button>
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

	<div class="modal" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Report</h5>
	        <button type="button" class="close"  aria-label="Close" onclick="closeImageModal()">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
				<div id="imgContent" class="text-center">
					<div id="page-loader"><i class="fa fa-spinner fa-spin"></i> Loading page ... </div>
				</div>				
				
				<div class="row m-t-10">
					<div class="col-4">
					</div>
					<div class="col-4 text-center">
						
					</div>
					<div class="col-4 text-right">
						<a id="imgDownload" href="" class="btn btn-primary">Save</a>
						<button class="btn btn-primary" onclick="printImg()">Print</button>
					</div>
				</div>
	      </div>
	       
	    </div>
	  </div>
	</div>
	
	<div class="modal" id="docModal" tabindex="-1" role="dialog" aria-labelledby="docModal">
	  <div class="modal-dialog modal-xl" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Report</h5>
	        <button type="button" class="close"  aria-label="Close" onclick="closePdfModal()">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
				<div id="docContent">
					
					
				</div>		
	      </div>
	       
	    </div>
	  </div>
	</div>
	
	
	
	<div class="modal" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Report</h5>
	        <button type="button" class="close" aria-label="Close" onclick="closeVideoModal()">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
				<div id="videoContent">
					<div id="videoDiv">
						<video id="rms-video" class="video-js" controls preload="auto" width="760" height="500">
						    <source src="" type="video/mp4" />
						    <p class="vjs-no-js">
						      To view this video please enable JavaScript, and consider upgrading to a
						      web browser that
						      <a href="https://videojs.com/html5-video-support/" target="_blank"
						        >supports HTML5 video</a >
						    </p>
						  </video>
					</div>
					
					<div id="videoLoaderDiv">
						<div id="page-loader"><i class="fa fa-spinner fa-spin"></i> Loading page ... </div>
					</div>
				</div>				
				
				<div class="row m-t-10">
					<div class="col-4">
					</div>
					<div class="col-4 text-center">
						
					</div>
					<div class="col-4 text-right">
						<a id="videoDownload" href="" class="btn btn-primary">Save</a>
					</div>
				</div>
	      </div>
	       
	    </div>
	  </div>
	</div>

<div class="rms-backdrop" style="display: none;"></div>  
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
	
var pdfFile, imageFile, docFile, forPauseVideo ;
var $z = jQuery.noConflict();

// click on "Show PDF" buuton

function openRmsModel(url){
	
	var checkExtn = url.split(/[#?]/)[0].split('.').pop().trim();
		
	if ( checkExtn == 'pdf'){
		url="http://localhost:8180";
		showPdfDoc(url);
		$('#docModal #page-loader').show();
		//$z('#docModal').modal({backdrop: 'static', keyboard: false}, 'show');
		$z('#docModal').show();
		$z('.rms-backdrop').show()
	} 
	
	
	else if ( checkExtn == 'mp4'){
		showVideo(url);
		//$z('#videoModal').modal({backdrop: 'static', keyboard: false}, 'show');
		$z('#videoModal').show();
		$z('.rms-backdrop').show()
	}
	
	else if (checkExtn == 'png'|| checkExtn == 'PNG' || checkExtn == 'jpg' || checkExtn == 'JPG' || checkExtn == 'jpeg' || checkExtn == 'JPEG'  || checkExtn == 'gif' || checkExtn == 'GIF' || checkExtn == 'bmp' || checkExtn == 'BMP'){		
		showImage(url);
		$('#imageModal #page-loader').show();
		//$z('#imageModal').modal({backdrop: 'static', keyboard: false}, 'show');
		$z('#imageModal').show();
		$z('.rms-backdrop').show();
	}
	//else if(checkExtn == 'pdf' || checkExtn == 'doc'|| checkExtn == 'docx' || checkExtn == 'csv' || checkExtn == 'xls' || checkExtn == 'xlsx' || checkExtn == 'ppt' || checkExtn == 'pptx')
	/* else{	
		showOfficeDoc(url);
		$('#docModal #page-loader').show();
		$j('#docModal').modal({backdrop: 'static', keyboard: false}, 'show');		
	} */
	/* else {
		alert('Unsupported File Format '+ checkExtn);
	} */
	else
	{
		url="http://101.53.157.154:8070/icg-dms/batch-job/fileDownlaod/bc9f1aad-4b63-4d37-a3d7-8b948a37e5f3";
		showPdfDoc(url);
		$('#docModal #page-loader').show();
		//$z('#docModal').modal({backdrop: 'static', keyboard: false}, 'show');
		$z('#docModal').show();
		$z('.rms-backdrop').show()
		
	}	
}

function printItRms() {
    var wnd = window.open(pdfFile);
    wnd.print(pdfFile);
}

function printImg() {
    var wnd = window.open(imageFile);
    wnd.print(imageFile);
}

function printDoc(){
    var wnd = window.open(docFile);
    wnd.print(docFile);
}

// when file type is image
function showImage(url){
	imageFile = url;	
	$('#imageModal #imgContent').html('<img class="mw-100" src="'+imageFile+'" />');	
	$('#imgDownload').attr("href", imageFile);
	$('#imgDownload').attr("target","_blank");
}
function closeImageModal(){	
    $('#imageModal #imgContent').html('<div id="page-loader"><i class="fa fa-spinner fa-spin"></i> Loading page ... </div>')
    $('#imageModal #page-loader').show();
    $z('#imageModal').hide();
	$z('.rms-backdrop').hide();   
}

//when file type is mp4
function showVideo(url){
	videoFile = url;	
	$('#videoModal #videoLoaderDiv').hide();
    $('#videoModal #videoDiv').show();
	$('#videoModal #rms-video source').attr('src',videoFile);	
	$('#videoDownload').attr("href", videoFile);
	$('#videoDownload').attr("target","_blank");
	videojs('rms-video');
	forPauseVideo = videojs("rms-video");
}
function closeVideoModal(){	
    $('#videoModal #videoLoaderDiv').show();
    $('#videoModal #videoDiv').hide();
    $z('#videoModal').hide();
	$z('.rms-backdrop').hide();
    forPauseVideo.pause();
}

//when file type is word, excel or powerpoint width="100%" height="500"
function showPdfDoc(url){
	pdfFile = url;	
	window.open(url, null);
	/* $('#docModal #docContent').html('<iframe  src="'+pdfFile+'" frameborder="0","inline"></iframe>');	
	//$('#docDownload').attr("Content-Type","application/pdf");
	$('#docDownload').attr("Content-Disposition","inline");
	$('#docDownload').attr("href", pdfFile);
	$('#docDownload').attr("target","_blank"); */
	

}
function closePdfModal(){	
    $('#docModal #docContent').html('<div id="page-loader"><i class="fa fa-spinner fa-spin"></i> Loading page ... </div>');
    $('#docModal #page-loader').show();
    $z('#docModal').hide();
	$z('.rms-backdrop').hide();
}
</script>
</html>