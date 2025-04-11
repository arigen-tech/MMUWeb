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

	var $j = jQuery.noConflict();
	
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">MMSSY Labour Beneficiary Register</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Camp Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="" id="" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control">
												
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="">Search</button>
										
									</div>
								</div>

								<div class="m-t-10">
									<div class="clearfix">
										<div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>											
										</div>

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										<div class="table-responsive" id="table_div">
											<table
												class="table table-striped table-hover table-bordered " id="">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th class="text-center b-align" rowspan="2">City</th>
														<th class="text-center b-align" colspan="4">No. of Labour Beneficiary</th>
														<th class="text-center b-align"  rowspan="2">Total No. of Labour Beneficiary</th>
														<th class="text-center b-align"  colspan="2">No. of patient registered in labour department</th>
														<th class="text-center b-align"  colspan="2">No. of patient who has applied for registration</th>
														<th class="text-center b-align"  colspan="2">No. of unregistered workers treated in the past who has applied for labour registration</th>
														<th class="text-center b-align" >No. of non labour who has been treated</th>
														<th class="text-center b-align"  colspan="4">No. of beneficiary till date</th>
														<th class="text-center b-align"  colspan="2">No. of patient registered in labour department till date<br>(A)</th>
														<th class="text-center b-align"  colspan="2">No. of patient who has applied for registration till date<br>(B)</th>
														<th class="text-center b-align"  colspan="2">No. of unregistered workers treated in the past who has applied for labour registration till date<br>(C)</th>
														<th class="text-center b-align"  rowspan="2">No. of non labour who has been treated till date<br>(D)</th>
														<th class="text-center b-align"  rowspan="2">Total No. of beneficiary till date <br>(A+B+C+D)</th>
													</tr>
													<tr>
														<th>Male</th>
														<th>Female</th>
														<th>Child</th>
														<th>Transgender</th>
														<th>BOC</th>
														<th>Other</th>
														<th>BOC</th>
														<th>Other</th>
														<th>BOC</th>
														<th>Other</th>
														<th>General Citizen</th>
														<th>Male</th>
														<th>Female</th>
														<th>Child</th>
														<th>Transgender</th>
														<th>BOC</th>
														<th>Other</th>
														<th>BOC</th>
														<th>Other</th>
														<th>BOC</th>
														<th>Other</th>
													</tr>
												</thead>
												<tbody id="">
													<tr>
														<td>City 1</td>
														<td>22</td>
														<td>34</td>
														<td>44</td>
														<td>33</td>
														<td>133</td>
														<td>32</td>
														<td>44</td>
														<td>34</td>
														<td>33</td>
														<td>22</td>
														<td>23</td>
														<td>44</td>
														<td>33</td>
														<td>44</td>
														<td>55</td>
														<td>34</td>
														<td>34</td>
														<td>45</td>
														<td>55</td>
														<td>55</td>
														<td>66</td>
														<td>76</td>
														<td>455</td>
														<td>786</td>									
													</tr>
													<tr>
														<td>City 1</td>
														<td>22</td>
														<td>34</td>
														<td>44</td>
														<td>33</td>
														<td>133</td>
														<td>32</td>
														<td>44</td>
														<td>34</td>
														<td>33</td>
														<td>22</td>
														<td>23</td>
														<td>44</td>
														<td>33</td>
														<td>44</td>
														<td>55</td>
														<td>34</td>
														<td>34</td>
														<td>45</td>
														<td>55</td>
														<td>55</td>
														<td>66</td>
														<td>76</td>
														<td>455</td>
														<td>786</td>									
													</tr>
													<tr class="font-weight-bold">
														<td>Total</td>
														<td>22</td>
														<td>34</td>
														<td>44</td>
														<td>33</td>
														<td>133</td>
														<td>32</td>
														<td>44</td>
														<td>34</td>
														<td>33</td>
														<td>22</td>
														<td>23</td>
														<td>44</td>
														<td>33</td>
														<td>44</td>
														<td>55</td>
														<td>34</td>
														<td>34</td>
														<td>45</td>
														<td>55</td>
														<td>55</td>
														<td>66</td>
														<td>76</td>
														<td>455</td>
														<td>786</td>									
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								
								<div class="row m-t-10">
									<div class="col-12 text-right">
										<button type="button" class="btn btn-primary">Export PDF</button>
									</div>
								</div>

							</div>
						</div>
						<!-- end card -->
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

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
