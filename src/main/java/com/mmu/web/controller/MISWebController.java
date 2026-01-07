package com.mmu.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mmu.web.excel.*;
import org.json.JSONObject;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RequestMapping("/mis")
@RestController
@CrossOrigin
public class MISWebController {

	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT");
	
	@RequestMapping(value="/dailyMmuRegister", method=RequestMethod.GET)
	public ModelAndView dailyMmuRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("dailyMmuRegister");		
		return mav;
	}
	
	@RequestMapping(value="/showIndentRegister", method=RequestMethod.GET)
	public ModelAndView  showIndentRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("indentRegister");		
		return mav;
	}
		
	@RequestMapping(value="/showMedicineIssueRegister", method=RequestMethod.GET)
	public ModelAndView  showMedicineIssueRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("medicineIssueRegister");		
		return mav;
	}
	
	@RequestMapping(value="/daiDidiDailyRegister", method=RequestMethod.GET)
	public ModelAndView daiDidiDailyRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("daiDidiDailyRegister");		
		return mav;
	}
	
	@RequestMapping(value = "/exportExcel", method = RequestMethod.GET)
	public ModelAndView exportExcelDiaDidi(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("campDate", request.getParameter("campDate"));
		payload.put("cityId", request.getParameter("cityId"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getDaiDidiClinicData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
				
	    return new ModelAndView(new ExportExcelDiaDidi(), "data", data);
			
	  }
	
	 
	@RequestMapping(value="/labourBeneficiaryRegister", method=RequestMethod.GET)
	public ModelAndView labourBeneficiaryRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("labourBeneficiaryRegister");		
		return mav;
	}
	    
	@RequestMapping(value = "/exportExcelLabourBeneficiary", method = RequestMethod.GET)
	public ModelAndView exportExcelLabourBeneficiary(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("campDate", request.getParameter("campDate"));
		payload.put("districtId", request.getParameter("districtId"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getLabourBeneficiaryData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
	    return new ModelAndView(new ExportExcelLbrBeneficiary(), "data", data);
		
	
	  }
	
	@RequestMapping(value="/mmssyInformationRegister", method=RequestMethod.GET)
	public ModelAndView mmssyInformationRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mmssyInformationRegister");		
		return mav;
	}
	
	@RequestMapping(value = "/exportExcelMMSSYInfo", method = RequestMethod.GET)
	public ModelAndView exportExcelMMSSYInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("campDate", request.getParameter("campDate"));
		payload.put("districtId", request.getParameter("districtId"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getMMSSYInfoData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
				
	    return new ModelAndView(new ExportExcelMMSSYInfo(), "data", data);
		
	
	  }
	
	@RequestMapping(value="/attendanceRegister", method=RequestMethod.GET)
	public ModelAndView attendanceRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("attendanceRegister");		
		return mav;
	}
	
	
	@RequestMapping(value="/incidentRegister", method=RequestMethod.GET)
	public ModelAndView incidentRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("incidentReport");		
		return mav;
	}
	
	@RequestMapping(value="/campLocationPlanRegister", method=RequestMethod.GET)
	public ModelAndView campLocationPlanRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("campLocationPlanRegister");		
		return mav;
	}
	
	
	@RequestMapping(value="/equipmentChecklistRegister", method=RequestMethod.GET)
	public ModelAndView equipmentChecklistRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("equipmentChecklistRegister");		
		return mav;
	}
	
	
	@RequestMapping(value="/penaltyRegister", method=RequestMethod.GET)
	public ModelAndView penaltyRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("penaltyRegister");		
		return mav;
	}
	
	@RequestMapping(value="/patientFeedbackDataReport", method=RequestMethod.GET)
	public ModelAndView patientFeedbackDataReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("patientFeedbackDataReport");		
		return mav;
	}
	
	@RequestMapping(value="/treatmentAuditRegister", method=RequestMethod.GET)
	public ModelAndView treatmentAuditRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("treatmentAuditRegister");		
		return mav;
	}
	
	@RequestMapping(value="/mmuArrivalRegister", method=RequestMethod.GET)
	public ModelAndView mmuArrivalRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mmuArrivalRegister");		
		return mav;
	}
	
	@RequestMapping(value="/vendorInvoiceReport", method=RequestMethod.GET)
	public ModelAndView vendorInvoiceReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("vendorInvoiceReport");		
		return mav;
	}
	
	@RequestMapping(value="/mmuInspectReport", method=RequestMethod.GET)
	public ModelAndView mmuInspectReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mmuInspectReport");		
		return mav;
	}
	
	@RequestMapping(value="/attendanceInTimeOutTime", method=RequestMethod.GET)
	public ModelAndView attendanceInTimeoutTime(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("attendanceInTimeOutTime");		
		return mav;
	}
	
	@RequestMapping(value="/notInStockRegister", method=RequestMethod.GET)
	public ModelAndView  notInStockRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("notInStockRegister");		
		return mav;
	}
	
	@RequestMapping(value = "/exportExcelDia2", method = RequestMethod.GET)
	public ModelAndView exportExcelDiaDidi2(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("cityId", request.getParameter("cityId"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getDaiDidiClinicData2");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
				
	    return new ModelAndView(new ExportExcelDiaDidi2(), "data", data);
			
	  }
	
	@RequestMapping(value = "/exportExcelLabourBeneficiary2", method = RequestMethod.GET)
	public ModelAndView exportExcelLabourBeneficiary2(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("districtId", request.getParameter("districtId"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getLabourBeneficiaryData2");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
				
	    return new ModelAndView(new ExportExcelLbrBeneficiary2(), "data", data);
		
	
	  }
	
	@RequestMapping(value = "/exportExcelMMSSYInfo2", method = RequestMethod.GET)
	public ModelAndView exportExcelMMSSYInfo2(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("districtId", request.getParameter("districtId"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getMMSSYInfoData2");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
				
	    return new ModelAndView(new ExportExcelMMSSYInfo2(), "data", data);
		
	
	  }
	
	@RequestMapping(value = "/exportExcelAiReport", method = RequestMethod.GET)
	public ModelAndView exportExcelAiReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuId", request.getParameter("mmuId"));
		payload.put("mmuName", request.getParameter("mmuName"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","exportExcelAiReport");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
				
	    return new ModelAndView(new ExportExcelAiReport(), "data", data);
			
	  }
	@RequestMapping(value="/labTestReport", method=RequestMethod.GET)
	public ModelAndView  labTestReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("labTestReport");
		return mav;
	}
	@RequestMapping(value="/edlReport", method=RequestMethod.GET)
	public ModelAndView  edlReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("edlReport");
		return mav;
	}
	@RequestMapping(value="/medicineIssueReport", method=RequestMethod.GET)
	public ModelAndView  medicineIssueReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("medicineIssueReport");
		return mav;
	}

	@RequestMapping(value = "/exportEdlReports", method = RequestMethod.GET)
	public ModelAndView exportEdlReports(HttpServletRequest request,
										 HttpServletResponse response) throws Exception {
		JSONObject payload=new JSONObject();
		payload.put("clusterId", request.getParameter("clusterId"));
		payload.put("asondate", request.getParameter("asondate"));
		payload.put("cityId", request.getParameter("cityId"));
		payload.put("mmuId", request.getParameter("mmuId"));

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","exportEdlReports");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelEdlReports(), "data", data);


	}

	@RequestMapping(value = "/exportEdlReportsCityWise", method = RequestMethod.GET)
	public ModelAndView exportEdlReportsCityWise(HttpServletRequest request,
												 HttpServletResponse response) throws Exception {
		JSONObject payload=new JSONObject();
		payload.put("clusterId", request.getParameter("clusterId"));
		payload.put("asondate", request.getParameter("asondate"));
		payload.put("cityId", request.getParameter("cityId"));

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","edlReportCityWise");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelEdlReportsCityWise(), "data", data);


	}

	@RequestMapping(value = "/exportLabReports", method = RequestMethod.GET)
	public ModelAndView exportLabReports(HttpServletRequest request,
										 HttpServletResponse response) throws Exception {


		JSONObject payload=new JSONObject();
		payload.put("clusterId", request.getParameter("clusterId"));
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("cityId", request.getParameter("cityId"));
		payload.put("mmuId", request.getParameter("mmuId"));

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","exportLabReports");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelLabReports(), "data", data);

	}

	@RequestMapping(value = "/exportMedicineIssueReport", method = RequestMethod.GET)
	public ModelAndView exportMedicineIssueReport(HttpServletRequest request,
												  HttpServletResponse response) throws Exception {
		JSONObject payload=new JSONObject();
		payload.put("cityId", request.getParameter("cityId"));
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuId", request.getParameter("mmuId"));
		payload.put("districtId", request.getParameter("districtId"));

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","exportMedicineIssueReport");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelMedicineIssueReport(), "data", data);


	}
	
	@RequestMapping(value = "/exportAuditOpdRegister", method = RequestMethod.GET)
	public ModelAndView exportAuditOpdRegister(HttpServletRequest request,
										 HttpServletResponse response) throws Exception {
		JSONObject payload=new JSONObject();
		payload.put("mmu_id", request.getParameter("mmu_id"));
		payload.put("gender_id", request.getParameter("gender_id"));
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("icdId", request.getParameter("icdId"));
		payload.put("User_id", request.getParameter("User_id"));
		payload.put("Level_of_user", request.getParameter("Level_of_user"));
		payload.put("fromAge", request.getParameter("fromAge"));
		payload.put("toAge", request.getParameter("toAge"));
		payload.put("referral", request.getParameter("referral"));
		

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAuditOpdRegister");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelAuditRegister(), "data", data);


	}
	
	@RequestMapping(value = "/exportAuditAttendanceRegister", method = RequestMethod.GET)
	public ModelAndView exportAuditAttendanceRegister(HttpServletRequest request,
										 HttpServletResponse response) throws Exception {
		JSONObject payload=new JSONObject();
		payload.put("mmu_id", request.getParameter("mmu_id"));
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("User_id", request.getParameter("User_id"));
		payload.put("Level_of_user", request.getParameter("Level_of_user"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAttendanceRegister");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelAttendanceRegister(), "data", data);


	}
	
	@RequestMapping(value = "/exportAttendanceInTimeOutTime", method = RequestMethod.GET)
	public ModelAndView exportAttendanceInTimeOutTime(HttpServletRequest request,
										 HttpServletResponse response) throws Exception {
		JSONObject payload=new JSONObject();
		payload.put("mmu_id", request.getParameter("mmu_id"));
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("User_id", request.getParameter("User_id"));
		payload.put("Level_of_user", request.getParameter("Level_of_user"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAttendanceInOutTime");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelAttendanceInTimeOutTime(), "data", data);


	}
	
	@RequestMapping(value = "/exportLabRegister", method = RequestMethod.GET)
	public ModelAndView exportLabRegister(HttpServletRequest request,
										 HttpServletResponse response) throws Exception {
		JSONObject payload=new JSONObject();
		payload.put("mmu_id", request.getParameter("mmu_id"));
		payload.put("gender_id", request.getParameter("gender_id"));
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("icdId", request.getParameter("icdId"));
		payload.put("User_id", request.getParameter("User_id"));
		payload.put("Level_of_user", request.getParameter("Level_of_user"));
		payload.put("fromAge", request.getParameter("fromAge"));
		payload.put("toAge", request.getParameter("toAge"));
		payload.put("referral", request.getParameter("referral"));

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getLabRegister");
		String OSBURL = IpAndPortNo + Url;

		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());

		return new ModelAndView(new ExportExcelLabRegister(), "data", data);


	}
	
	@RequestMapping(value = "/exportPenaltyExcel", method = RequestMethod.GET)
	public ModelAndView exportPenaltyExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("mmuId", request.getParameter("mmu_id"));
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("userId", request.getParameter("User_id"));
		payload.put("levelOfUser", request.getParameter("Level_of_user"));
		payload.put("vendorId", request.getParameter("vendor_id"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getPenaltyRegister");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
				
	    return new ModelAndView(new ExportExcelPenaltyRegister(), "data", data);
		
	
	  }
	
}
