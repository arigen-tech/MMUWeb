<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Mobile Medical Unit- MMSSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
      <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon-16x16.png" type="image/x-icon">  
   <%--  <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/icons.css" rel="stylesheet" type="text/css" /> --%>
    <link href="${pageContext.request.contextPath}/resources/css/metismenu.min.css" rel="stylesheet" type="text/css" />
    <%-- <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" /> --%>
    <%--  <link href="${pageContext.request.contextPath}/resources/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" /> --%>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/resources/js/modernizr.min.js"></script> --%>
    <%-- <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script> --%>
    <script src="${pageContext.request.contextPath}/resources/js/metisMenu.min.js"></script>    
    <script src="${pageContext.request.contextPath}/resources/js/jquery.slimscroll.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.scrollTo.min.js"></script> 
      
    
      
    <script src="${pageContext.request.contextPath}/resources/js/jquery.core.js"></script>
       
    
    <%-- <script src="${pageContext.request.contextPath}/resources/js/datepicker.js"></script> --%>
    
    
    
  <%--   <script src="${pageContext.request.contextPath}/resources/js/pages/morris.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/pages/raphael.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/pages/morris.init.js"></script> --%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/leftmenu.js"></script>
    
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/approvalprocess.js"></script>

<style>
.enlarged .left.side-menu{
 margin-left:0px !important ;
 }
</style>    
                    
                    <%
int hospitalId1=0;
if(session.getAttribute("mmuId")!=null)
{
hospitalId1 =Integer.parseInt(session.getAttribute("mmuId").toString());

}

int userId1=0;
if(session.getAttribute("userId")!=null)
{
	userId1 =Integer.parseInt(session.getAttribute("userId").toString());
}



%>
<script>var pageContaxValue = "${pageContext.request.contextPath}"</script>
</head>

<body>
  <div id="wrapper">
	<input type="hidden" name="userIdLeft" id="userIdLeft" value="<%=userId1%>"/>	
      <input type="hidden" name="hospitalIdForMas" id="hospitalIdForMas" value="<%=hospitalId1%>"/>	
        <!-- ========== Left Sidebar Start ========== -->
        <nav>
        <div class="left side-menu">
        <!-- <input type="text" id="dynamicLeftMenu" value=""/> -->
            <div class="slimscroll-menu" id="remove-scroll">

                <!--- Sidemenu -->
                <div id="sidebar-menu">
                
                	<div class="filterMenu">
                		<input type="text" name="q" class="form-control" id="filter" placeholder="Search...">
                	</div>
                  
                    <!-- Left Menu Start -->
                    <ul class="metismenu" id="side-menu">
                    
                    <li id="dynamicValue"></li>
                    
                    
                        
                                                
                    </ul>

                </div>
                <!-- Sidebar -->
                <div class="clearfix"></div>

            </div>
            <!-- Sidebar -left -->

        </div>
        </nav>
        <!-- Left Sidebar End -->

        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->
        <div class="content-page">
            <!-- Start content -->
            <div class="content">
                <div class="container-fluid">
                    
                    <!-- end row -->
                    <!-- end row -->

                </div>
                <!-- container -->

            </div>
            <!-- content -->


        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->
</div>
<script src="${pageContext.request.contextPath}/resources/js/metisMenu.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
	  //localStorage.setItem("dynamicLeftMenu","");
	  var getValue=getDynamicMenu(1);

 }); 
  
</script> 
<script>
$(document).ready(function () {
    $("#filter").keyup(function () {
        var filter = $(this).val(),
            count = 0;
        
        $(".metismenu li").each(function () {
            if (filter == "" || filter == " ") {
                $(this).css("visibility", "visible");
                $(".metismenu li").removeClass('active')
                $('.nav-second-level').removeClass('in');
                $('.nav-third-level').removeClass('in'); 
                $(this).fadeIn();                  
                
            } else if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                $(this).css("visibility", "hidden");
                $(this).fadeOut();
            } else {
                $(this).css("visibility", "visible");
                
                if($(this).closest('.nav-second-level').length>0){
                	$(this).closest('.nav-second-level').addClass('in');
                	$(this).closest('.nav-second-level').parent().addClass("active"); 
                	
                	if($(this).closest('.nav-third-level').length>0){
                    	$(this).closest('.nav-third-level').addClass('in');
                    	$(this).closest('.nav-third-level').parent().addClass("active"); 
        			}
    			}                
                $(this).fadeIn();
            }
        });
    });
});
</script>
</body>

</html>