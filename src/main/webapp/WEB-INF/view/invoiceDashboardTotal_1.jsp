<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Medical Unit- MMSSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>

</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">
 
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                 <div class="internal_Htext">Invoice Dashboard - Total</div>
                  
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                      
                                       <div class="row">
										<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">UPSS</label>
													</div>
													<div class="col-md-7">
														<input type="text" value="UPSS1" class="form-control" readonly />
													</div>
												</div>
											</div>
											
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Total</label>
													</div>
													<div class="col-md-7">
														<input type="text" value="1,20,0000" class="form-control" readonly />
													</div>
												</div>
											</div>
												
											</div>
											
											

								<div class="scrollableDiv m-b-10">
                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                           
                                            <tr>                                                  
                                                <th>S.No.</th> 
                                                <th>Vendor</th> 
                                                <th>MMU</th> 
                                                <th>Invoice Date</th>
                                                <th>Upload Date</th>     
                                                <th>Invoice No.</th>
                                                <th>Invoice Amount</th>
                                                <th>Last Approved Status</th>
                                                <th>View</th>
                                                <th>Track</th>                                          
                                            </tr>
                                        </thead>
                                     <tbody id="">
										 <tr>
										 	<td>1</td>
										 	<td>Vendor 1</td>
										 	<td>MMU 1, MMU 2</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>68768</td>
										 	<td>70000</td>
										 	<td>Pending at Collector</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 1</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
										 <tr>
										 	<td>2</td>
										 	<td>Vendor 2</td>
										 	<td>MMU 3, MMU 4</td>
										 	<td>21/01/2022</td>
										 	<td>29/01/2022</td>
										 	<td>58468</td>
										 	<td>50000</td>
										 	<td>Pending at Commissioner</td>
										 	<td><a class="btn-link" href="javascript:void(0);">File 2</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">View</a></td>
										 </tr>
                     				 </tbody>
                                    </table>
							
							</div>
								
										
                                

                                    <!-- end row -->

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
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
    <!-- END wrapper -->

    <!-- jQuery  -->
   <script>
   $(function(){
	   /* var winHeight = $(window).height();

	   $('.scrollableDiv').css({'height':winHeight-420}); */

	   // add custom scroll to sscrollableDiv class
	       $('.scrollableDiv').slimscroll({
	           height: 'inherit',
	           position: 'right',
	           color: '#9ea5ab',
	           touchScrollStep: 50
	       });
	   })
	</script>

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>