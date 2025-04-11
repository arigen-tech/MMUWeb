 

(function ($) {

    'use strict';

    function initSlimscrollMenu() {

        $('.slimscroll-menu').slimscroll({
            height: 'auto',
            position: 'right',
            size: "5px",
            color: '#9ea5ab',
            wheelStep: 5,
            touchScrollStep: 50
        });
    }

    function initSlimscroll() {
        $('.slimscroll').slimscroll({
            height: 'auto',
            position: 'right',
            size: "5px",
            color: '#9ea5ab',
            touchScrollStep: 50
        });
    }

    /*function initMetisMenu() {
        //metis menu
        $("#side-menu").metisMenu();
    }*/

    function initLeftMenuCollapse() {
        // Left menu collapse
        /*$('.button-menu-mobile').on('click', function (event) {
            event.preventDefault();
            $("body").toggleClass("enlarged");
        });*/
    }

    function initEnlarge() {
        if ($(window).width() < 1025) {
            $('body').addClass('enlarged');
        } else {
            $('body').removeClass('enlarged');
        }
    }

    function initActiveMenu() {
        
    	
    	var divContainer = $('.slimscroll-menu'); // === for scrolling menu item to view
    	
    	// === following js will activate the menu in left side bar based on url ====
    	
        $("#sidebar-menu a").each(function () {
            var pageUrl = window.location.href.split(/[?#]/)[0];
            if (this.href == pageUrl) {
                $(this).addClass("active"); // a tag
                $(this).parent().addClass("active"); // add active to li of the current link
                $(this).parent().parent().addClass("in"); // ul tag
                //$(this).parent().parent().attr("aria-expanded","true"); // ul tag
                $(this).parent().parent().prev().addClass("active"); // add active class to a tag
                //$(this).parent().parent().prev().attr("aria-expanded","true"); // add active class to a tag
                
                $(this).parent().parent().parent().addClass("active"); // li tag
               
               // used for third level menu 
               $(this).parent().parent().parent().parent().addClass("in"); // add active to li of the current link
               $(this).parent().parent().parent().parent().parent().addClass("active");
                
             // === for scrolling menu item to view
                var scrollThis = $(this);
                divContainer.animate({scrollTop: (scrollThis.offset().top - 100) - divContainer.offset().top + 
        			divContainer.scrollTop()},200);
            }
            
        });
        
    }
    
    
    // to select a clicked row in a table ---- add class clickableRow to the <tbody> 
  /*  $(document).on('click','tr',function(){
		
		$('tr').removeClass('rowClicked');
		
		var parentTr = $(this).closest('tbody');
		
		if(parentTr.hasClass('clickableRow')){
			$(this).addClass('rowClicked')
		}
		
		;
	});*/

    function init() {
        //initSlimscrollMenu();
        initSlimscroll();
        //initMetisMenu();
       // initLeftMenuCollapse();
        initEnlarge();
        //initActiveMenu();
    }

    init();

})(jQuery)