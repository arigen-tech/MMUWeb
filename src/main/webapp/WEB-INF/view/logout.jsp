<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
		session.invalidate();
       //  Testing Environment
       //  response.sendRedirect("http://10.0.8.10:7001/AshaShipWeb/dashboard/login");
       
      	// Production Environment
        /* response.sendRedirect("http://10.0.3.67:7001/AshaShipWeb/dashboard/login"); */ 
  		   
           response.sendRedirect("http://192.168.10.59:8181/MMUWeb/dashboard/login"); 
%>
     <%@include file="..//view/leftMenu.jsp" %>
     <%@include file="..//view/commonJavaScript.jsp" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">

<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
  <div class="content-page">    
<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext"> Personal Information</div>

				<!-- <div class="row">
					<div class="col-12">
						<div class="page-title-box">
							<ol class="breadcrumb float-right">
								<li class="breadcrumb-item active"><a href="#">Home</a></li>
								<li class="breadcrumb-item  active"><a href="#">Master</a></li>
								<li class="breadcrumb-item active">Doctor Roaster</li>
							</ol>

							<div class="clearfix"></div>
						</div>
					</div>
				</div> -->
				<!-- end row -->

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">


								<form>
								
								
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input type="text" id="sNo" name="serviceNo" value="" readonly>
												</div>
											</div>
										</div>										
										 <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Full Name </label>
												<div class="col-sm-7">
													<input type="text" id="empName" name= "empName" value="" readonly>
												</div>
											</div>
										</div>										 
                                         <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Unit/Location. </label>
												<div class="col-sm-7">
													 <input type="text" id="unit" value="" readonly>
												</div>
											</div>
										</div>	
										
										
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Age </label>
												<div class="col-sm-7">
													<input type="text" id="age" value="" readonly>
												</div>
											</div>
										</div>	
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Department </label>
												<div class="col-sm-7">
													<input type="text" id="department" value="" readonly>
												</div>
											</div>
										</div>	
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Gender </label>
												<div class="col-sm-7">
													<input type="text" id="gender" value="" readonly>
												</div>
											</div>
										</div>	
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Rank</label>
												<div class="col-sm-7">
													<input type="text" id="rank" value="" readonly>
												</div>
											</div>
										</div>																	 
									</div>
									
									
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile Number</label>
												<div class="col-sm-7">
													<input type="text" id="mobile" value="" readonly>
												</div>
											</div>
										</div>	
										
										<div class="col-md-1">
											<div class="form-group row">
												 
												<button type="button" class="btn btn-primary">Update</button>
											</div>
										</div> 
											
									</div>
									
									
									
									
									
									
									
									
									
									
									<div class="row">
										<div class="col-md-11">
											
										</div>	
										
										<div class="col-md-1">
											<div class="form-group row">
												 
												<button type="button" class="btn btn-warning">History</button>
											</div>
										</div> 
											
									</div>
									
									
									
									
									
									
							 <table class="table table-hover table-bordered">
								   <thead class="bg-primary" style="color:#fff;">
								    <tr>
								      <th>Select</th>
								      <th>Name</th>
								      <th>Relation</th>
								      <th>DOB</th>
								      <th>Age</th>
								      <th>Gender</th>
								    </tr>
								  </thead>
								  <tbody>
								    <tr>
								      <td><label class="form-check-input" type="radio"></td>
								      <td>SK Jha</td>
								      <td>Self</td>
								      <td>12//4/1969</td>
								      <td>50</td>
								      <td>Male</td>
								    </tr> 
								  </tbody>
								</table>
								
								
									<div class="row">
										<div class="col-md-11">
											
										</div>	
										
										<div class="col-md-1">
											<div class="form-group row">
												 
												<button type="button" class="btn btn-primary">Book Now</button>
											</div>
										</div> 
											
									</div>
									
									
									
									
									
									<!-- -------------  Patient Appointment start here -->
									
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Employee No.</label>
												<div class="col-sm-7">
													<input  name="employee number" type="text" id="employee" readonly  placeholder="33503" >
												</div>
											</div>
										</div>		
										
										
										
										 <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">UHID </label>
												<div class="col-sm-7">
													<input  name="UHID" type="text" id="uhid" readonly  placeholder="013350306" >
												</div>
											</div>
										</div>	
										 
																		
										 <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Full Name </label>
												<div class="col-sm-7">
													<input  name="fullname" type="text" id="full_nmae" readonly  placeholder="SK Jha" >
												</div>
											</div>
										</div>										 
                                         <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Relation </label>
												<div class="col-sm-7">
													<input  name="Relation" type="text" id="relation" readonly  placeholder="Self" >
												</div>
											</div>
										</div>	
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Date Of Birth </label>
												<div class="col-sm-7">
													<input  name="Date Of Birth" type="text" id="dob" readonly  placeholder="12/04/1969">
												</div>
											</div>
										</div>	
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Age </label>
												<div class="col-sm-7">
													<input  name="Age" type="text" id="age" readonly  placeholder="45 Years" >
												</div>
											</div>
										</div>	
									 
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Gender </label>
												<div class="col-sm-7">
													<input  name="Gender" type="text" id="gender" readonly  placeholder="Male" >
												</div>
											</div>
										</div>	
										 
																										 
									</div>
									
									
									
									
									
									
									
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> Department<span style="color:red"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													 <select class="form-control" id="department">
														    <option>--Select Department--</option>
														    <option>2</option>
														    <option>3</option>
														    <option>4</option>
														  </select>
												</div>
											</div>
										</div>	
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> Doctor<span style="color:red"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													 <select class="form-control" id="doctor">
														    <option>--Select Doctor-- </option>
														    <option>2</option>
														    <option>3</option>
														    <option>4</option>
														  </select>
												</div>
											</div>
										</div>	
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> Session<span style="color:red"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													 <select class="form-control" id=" session">
														    <option>--Select  Session-- </option>
														    <option>2</option>
														    <option>3</option>
														    <option>4</option>
														  </select>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Appointment Date <span style="color:red"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													 <input  name="Appointment Date " type="number" id="appointment_date"   placeholder=""  >
												</div>
											</div>
										</div>	
								     </div>	
										
									
									
									
									
									
									
										<!-- -------------  Patient Appointment end here -->
									
									<div class="row">
									
									 <div class="col-md-12">
									 
									 
									 
									 
									  
                <div class="account-box">
                    <div class="account-logo-box bg-primary p-4">
                        <h3 class="m-0 text-center text-white">INDIAN COAST GAURD</h3>
                    </div>
                    <div class="account-content">
                        <form class="form-horizontal" action="#">

                            <div class="form-group  mb-4 row">
                                <div class="col-12">
                                    <label for="emailaddress">Email Address :</label>
                                    <input class="form-control" type="email" id="emailaddress" required="" placeholder="Enter email id">
                                </div>
                            </div>

                            <div class="form-group row mb-4">
                                <div class="col-12">
                                    <label for="password">Password :</label>
                                    <input class="form-control" type="password" required="" id="password" placeholder="Enter your password">
                                </div>
                            </div>

                            <div class="form-group row mb-4">
                                <div class="col-12">
                                    <div class="checkbox checkbox-success">
                                        <input id="remember" type="checkbox" checked="">
                                        <label for="remember">
                                            Remember me
                                        </label>
                                        <a href="pages-recoverpw.html" class="text-muted float-right">Forgot your password?</a>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group row text-center m-t-10">
                                <div class="col-12">
                                    <button class="btn btn-md btn-block btn-primary waves-effect waves-light" type="submit">Sign In</button>
                                </div>
                            </div>

                        </form>

                        <div class="row mt-4">
                            <div class="col-sm-12 text-center">
                                <p class="text-muted">Don't have an account? <a href="pages-register.html" class="text-dark m-l-5"><b>Sign Up</b></a></p>
                            </div>
                        </div>

                    </div>
                </div>
           
            <!-- end account-box-->
									 
									 </div>
									
									</div>
									
									
									
									
									
									
									
									
									
									
									
								</form>

							</div>

						</div>
					</div>
				</div>
			</div>

		</div>
</div>
</body>
</html>