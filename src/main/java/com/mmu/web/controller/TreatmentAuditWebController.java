package com.mmu.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.service.OpdService;
import com.mmu.web.service.TreatmentAuditWebService;
import com.mmu.web.utils.HMSUtil;

@RequestMapping("/treatmentAudit")
@RestController
@CrossOrigin
public class TreatmentAuditWebController {
	
	@Autowired
	TreatmentAuditWebService treatmentAuditWebService;
	
	
	
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	@RequestMapping(value = "/auditWaitingList", method = RequestMethod.GET)
	public ModelAndView opdPatientRecall(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("Audit Recall called");
		String jsp = "treatmentAuditWaitingList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
	
	@RequestMapping(value = "/getAuditWaitingList", method = RequestMethod.POST)
	public String getAuditWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		return treatmentAuditWebService.getAuditWaitingList(payload, request, response);
	}
	
	@RequestMapping(value = "/getOpdPatientMainData", method = RequestMethod.GET)
	public ModelAndView getOpdPatientMainData(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("called clinical audit");
		String jsp = "clinicalAudit";
		int visitId = Integer.parseInt(request.getParameter("visitId"));
		String payload = "{\"visitId\":" + visitId + "}";
		String jsonResponse = treatmentAuditWebService.getAuditDetailModel(payload, request, response);
		//System.out.println("jsonResponse " + jsonResponse);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getPatientDianosisDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPatientDianosisDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=treatmentAuditWebService.getPatientDianosisDetail(payload, request, response);
		return data;
		//return RestUtils.postWithHeaders(data, requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getInvestigationDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getInvestigationDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		
		String data=treatmentAuditWebService.getInvestigationDetail(payload, request, response);
		return data;
	}
	
	@RequestMapping(value = "/getTreatmentPatientDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getTreatmentPatientDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
	
		String data=treatmentAuditWebService.getTreatmentPatientDetail(payload, request, response);
		
		return data;
	}
	
	@RequestMapping(value="/treatmentAuditSubmit", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String treatmentAuditSubmit(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		//System.out.println("data Opd submit: " +payload );
		//Box box= HMSUtil.getBox(request);
		
		//JSONObject obj = new JSONObject(box);
		////System.out.println("jsonreq"+obj);
		
		
		return treatmentAuditWebService.treatmentAuditSubmit(payload, request, response);
	}
	
	@RequestMapping(value = "/treatmentSubmit", method = RequestMethod.GET)
	public ModelAndView treatmentSubmit(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("OPD Data Submited Successfully");
		String jsp = "treatmentSubmit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		String payload = "{\"visitId\":"+visitId+"}";
		String jsonResponse = treatmentAuditWebService.getAuditDetailModel(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("msgRecall", "OPD Submited Successfully");
		
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/showPrescriptionAuditWaitingList", method = RequestMethod.GET)
	public ModelAndView showPrescriptionAuditWaitingList(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("Audit Recall called");
		String jsp = "showTreatmentAuditWaitingList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/showClincicalAuditData", method = RequestMethod.GET)
	public ModelAndView showClincicalAuditData(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("called show clinical audit");
		String jsp = "showClinicalAudit";
		int visitId = Integer.parseInt(request.getParameter("visitId"));
		String payload = "{\"visitId\":" + visitId + "}";
		String jsonResponse = treatmentAuditWebService.getAuditDetailModel(payload, request, response);
		//System.out.println("jsonResponse " + jsonResponse);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getRecommendedDiagnosisAllDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String showCurrentMedication(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=treatmentAuditWebService.getRecommendedDiagnosisAllDetail(payload, request, response);
		return data;
	}
	
	@RequestMapping(value = "/getRecommendedInvestgationAllDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getRecommendedInvestgationAllDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=treatmentAuditWebService.getRecommendedInvestgationAllDetail(payload, request, response);
		return data;
	}
	
	@RequestMapping(value = "/getRecommendedTreatmentAllDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getRecommendedTreatmentAllDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=treatmentAuditWebService.getRecommendedTreatmentAllDetail(payload, request, response);
		return data;
	}
	
	@RequestMapping(value = "/getAllSymptomsForOpd", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getAllSymptomsForOpd(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=treatmentAuditWebService.getAllSymptomsForOpd(payload, request, response);
		return data;
	}
	
	@RequestMapping(value = "/getAllIcdForOpd", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getAllIcdForOpd(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=treatmentAuditWebService.getAllIcdForOpd(payload, request, response);
		return data;
	}
	
	@RequestMapping(value = "/getExpiryMedicine", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getExpiryMedicine(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=treatmentAuditWebService.getExpiryMedicine(payload, request, response);
		return data;
	}
	

}
