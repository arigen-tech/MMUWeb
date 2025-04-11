package com.mmu.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RestController
@CrossOrigin
@RequestMapping("/ward")
public class WardWebController {
	
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	@RequestMapping(value="/getPatientList", method=RequestMethod.GET)
	public ModelAndView getPatientList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("patientListForAdmission");
		return mv;
	}
	
	@RequestMapping(value="/getPatientListForAdmission", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getPatientListForAdmission(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientListForAdmission");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientListForAdmission", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getPatientDetailForAdmission", method=RequestMethod.GET)
	public ModelAndView getPatientDetailForAdmission(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		
		String id = request.getParameter("id");
		String userId = request.getParameter("userId");
		String payload = "{\"id\":" + id + "}"; 
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientDetailForAdmission");
		String data = RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, payload);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientDetailForAdmission", requestHeaders, payload);
		
		mv.setViewName("patientAdmissionInWard");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/getWardDoctor", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getWardDoctor(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWardDoctor");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getWardDoctor", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getRelationList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getRelationList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getRelationList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getRelationList", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getWardDepartment", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getWardDepartment(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWardDepartment");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getWardDepartment", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getAdmissionTypeList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getAdmissionTypeList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getAdmissionTypeList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getAdmissionTypeList", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/saveAdmission", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveAdmission(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveAdmission");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveAdmission", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/wardManagement", method=RequestMethod.GET)
	public ModelAndView wardManagement(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardManagement");
		return mv;
	}
	
	@RequestMapping(value="/getWardManagementData", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getWardManagementData(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWardManagementData");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getWardManagementData", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getVacentBedList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getVacentBedList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getVacentBedList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getVacentBedList", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getStateList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getStateList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getStateList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/master/getStateList", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getDistrictList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDistrictList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getListForDistrict");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getListForDistrict", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getDistrictListById", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDistrictListById(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDistrictListById");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/master/getDistrictListById", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/wardAdmissionSubmit", method=RequestMethod.GET)
	public ModelAndView wardAdmissionSubmit(HttpServletRequest request, HttpServletResponse response) {
		String visitId = String.valueOf(request.getParameter("visitId"));
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardAdmissionSubmit");
		mv.addObject("visitId", visitId);
		return mv;
	}
	
	
	@RequestMapping(value="/acceptPatientInWard", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String acceptPatientInWard(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "acceptPatientInWard");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/acceptPatientInWard", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getCaseSheetData", method=RequestMethod.GET)
	public ModelAndView dailyCaseSheetWard(HttpServletRequest request, HttpServletResponse response) {
		long inpatientId= Long.parseLong(request.getParameter("inpatientId"));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCaseSheetData");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getCaseSheetData", requestHeaders, inputJson);
		//System.out.println("data is "+data);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("caseSheetWard");
		mv.addObject("data", data);
		mv.addObject("inpatientId", inpatientId);
		return mv;
	}
	
	@RequestMapping(value="/getCaseSheetHistoryData", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getCaseSheetHistoryData(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCaseSheetData");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getCaseSheetData", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/saveCaseSheet", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveAdmissionNotesInCaseSheet(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveCaseSheet");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveCaseSheet", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getDailyCaseSheetData", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDailyCaseSheetData(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDailyCaseSheetData");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDailyCaseSheetData", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getInvestigations", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getInvestigations(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getInvestigations");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getInvestigations", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getDietType", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDietType(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDietType");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDietType", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getDietDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDietDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDietDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDietDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getNursingObservation", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getNursingObservation(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getNursingObservation");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getNursingObservation", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/bedCareTransfer", method=RequestMethod.GET)
	public ModelAndView bedCareTransfer(HttpServletRequest request, HttpServletResponse response) {
		long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientDetail");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientDetail", requestHeaders, inputJson);
		//System.out.println("data is "+data);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("bedCareTransfer");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/saveBedCareTransfer", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveBedCareTransfer(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveBedCareTransfer");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveBedCareTransfer", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getTransferHistory", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getTransferHistory(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getTransferHistory");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getTransferHistory", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/wardIntakeOutput", method=RequestMethod.GET)
	public ModelAndView wardIntakeOutput(HttpServletRequest request, HttpServletResponse response) {
		long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardIntakeOutput");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/saveIntakeOutput", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveIntakeOutput(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveIntakeOutput");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveIntakeOutput", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getIntakeOutputDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getIntakeOutputDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIntakeOutputDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getIntakeOutputDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/wardLinenManagement", method=RequestMethod.GET)
	public ModelAndView wardLinenManagement(HttpServletRequest request, HttpServletResponse response) {
		long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardLinenManagement");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/getLinenItemList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getLinenItemList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getLinenItemList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getLinenItemList", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/saveLinenDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveLinenDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveLinenDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveLinenDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getLinenDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getLinenDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getLinenDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getLinenDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/wardNursingCareSetup", method=RequestMethod.GET)
	public ModelAndView wardNursingCareSetup(HttpServletRequest request, HttpServletResponse response) {
		long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		//System.out.println("inpatient id ******************************** "+inpatientId);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardNursingCareSetup");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/saveNursingCareSetUp", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveNursingCareSetUp(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveNursingCareSetUp");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveNursingCareSetUp", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getnursingCareDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getnursingCareDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getnursingCareDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getnursingCareDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/nursingCareEntry", method=RequestMethod.GET)
	public ModelAndView nursingCareEntry(HttpServletRequest request, HttpServletResponse response) {
		long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		//System.out.println("inpatient id ******************************** "+inpatientId);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("nursingCareEntry");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/getNursingEntryProcedure", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getNursingEntryProcedure(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getNursingEntryProcedure");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getNursingEntryProcedure", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/saveNursingEntry", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveNursingEntry(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveNursingEntry");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveNursingEntry", requestHeaders, inputJson);
	}
	
	
	@RequestMapping(value="/getSilDil", method=RequestMethod.GET)
	public ModelAndView getSilDil(HttpServletRequest request, HttpServletResponse response) {
		long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		//System.out.println("inpatient id ******************************** "+inpatientId);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardSilDil");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/saveSilDilDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveSilDilDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveSilDilDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveSilDilDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getSilDilDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getSilDilDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getSilDilDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getSilDilDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getTreatmentDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getTreatmentDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getTreatmentDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getTreatmentDetails", requestHeaders, inputJson);
	}	
	
	@RequestMapping(value="/wardIssueMedicine", method=RequestMethod.GET)
	public ModelAndView wardIssueMedicine(HttpServletRequest request, HttpServletResponse response) {
		Long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardIssueMedicine");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/wardMedicineEntrty", method=RequestMethod.GET)
	public ModelAndView wardMedicineEntrty(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardMedicineEntryPopup");
		return mv;
	}
	
	@RequestMapping(value="/getMedicineList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getMedicineList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMedicineList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getMedicineList", requestHeaders, inputJson);
	}
	
	
	@RequestMapping(value="/wardDietEntry", method=RequestMethod.GET)
	public ModelAndView wardDietEntry(HttpServletRequest request, HttpServletResponse response) {
		Long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		MultiValueMap<String, String> requestHeaders2 = new LinkedMultiValueMap<String, String>();
		String OSBURL2 = HMSUtil.getProperties("urlextension.properties", "getDietDetails");
		String dietData =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL2.trim(), requestHeaders2, inputJson);
		//String dietData = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDietDetails", requestHeaders2, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardDietEntry");
		mv.addObject("data", data);
		mv.addObject("dietData", dietData);
		return mv;
	}
	
	@RequestMapping(value="/wardClinicalEntry", method=RequestMethod.GET)
	public ModelAndView wardClinicalEntry(HttpServletRequest request, HttpServletResponse response) {
		Long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardClinicalEntry");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/saveDietEntry", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveDietEntry(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveDietEntry");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveDietEntry", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getDietEntryDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDietEntryDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDietEntryDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDietEntryDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/saveClinicalDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveClinicalDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveClinicalDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveClinicalDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getClinicalDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getClinicalDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getClinicalDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getClinicalDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getReferralAndConsultationDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getReferralAndConsultationDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getReferralAndConsultationDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getReferralAndConsultationDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/saveNursingObservation", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveNursingObservation(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveNursingObservation");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveNursingObservation", requestHeaders, inputJson);
	}
	
	
	@RequestMapping(value="/wardNursingObservation", method=RequestMethod.GET)
	public ModelAndView wardNursingObservation(HttpServletRequest request, HttpServletResponse response) {
		Long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardNursingObservation");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/getWardMedicineEntry", method=RequestMethod.GET)
	public ModelAndView getWardMedicineEntry(HttpServletRequest request, HttpServletResponse response) {
		Long dtId = Long.parseLong(String.valueOf(request.getParameter("id")));
		Long inpatientId = Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		
		String inputJson = "{\"dtId\":"+dtId+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMedicineEntryDetails");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getMedicineEntryDetails", requestHeaders, inputJson);
		
		MultiValueMap<String, String> requestHeaders2 = new LinkedMultiValueMap<String, String>();
		String OSBURL2 = HMSUtil.getProperties("urlextension.properties", "getMedicineDoseDetails");
		String doseData =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL2.trim(), requestHeaders2, inputJson);
		//String doseData = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getMedicineDoseDetails", requestHeaders2, inputJson);
		//System.out.println("doseData is ********************************* "+doseData);
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("wardMedicineEntryPopup");
		mv.addObject("data", data);
		mv.addObject("doseData", doseData);  
		mv.addObject("inpatientId", inpatientId);
		return mv;
	}
	
	@RequestMapping(value="/saveMedicineDose", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveMedicineDose(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveMedicineDose");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveMedicineDose", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/wardDischargeSummary", method=RequestMethod.GET)
	public ModelAndView wardDischargeSummary(HttpServletRequest request, HttpServletResponse response) {
		Long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardDischargeSummary");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping(value="/getDisposalList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDisposalList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWardDisposalList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDisposalList", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/saveDischargeSummary", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveDischargeSummary(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveDischargeSummary");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveDischargeSummary", requestHeaders, inputJson);
	}  
	
	@RequestMapping(value="/getDischargeApprovalWaitingList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDischargeApprovalWaitingList(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDischargeApprovalWaitingList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDischargeApprovalWaitingList", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/getDischargeApprovalDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String getDischargeApprovalDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDischargeApprovalDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDischargeApprovalDetails", requestHeaders, inputJson);
	}
	
	@RequestMapping(value="/wardApproveDischargeList", method=RequestMethod.GET)
	public ModelAndView wardApproveDischargeList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardApproveDischargeList");
		return mv;
	}
	
	@RequestMapping(value="/saveApprovalDischargeDetails", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveDischargeApprovalDetails(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveApprovalDischargeDetails");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveApprovalDischargeDetails", requestHeaders, inputJson);
	}     
	
	@RequestMapping(value="/wardApproveDischargeSummary", method=RequestMethod.GET)
	public ModelAndView wardApproveDischargeSummary(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id= String.valueOf(request.getParameter("id"));
		long userId = Long.parseLong(String.valueOf(request.getParameter("userId")));
		String[] bothId = id.split("\\.");
		long inpatientId = Long.parseLong(bothId[1]);
		long dischargeDtId = Long.parseLong(bothId[0]);
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		
		Map<String,Object> map = new HashMap<>(); 
		map.put("dischargeDtId", dischargeDtId);
		map.put("userId", userId);
		String inputJson2 = "{\"dischargeDtId\":"+dischargeDtId+",\"userId\":"+userId+"}";
		//String inputJson2 = map.toString();
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientInfo");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getPatientInfo", requestHeaders, inputJson);
		
		String OSBURL2 = HMSUtil.getProperties("urlextension.properties", "getDischargeApprovalDetails");
		String data2 =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data2 = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getDischargeApprovalDetails", requestHeaders, inputJson2);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("wardApproveDischargeSummary");
		mv.addObject("data", data);
		mv.addObject("data2", data2);
		return mv;  
	}
	
	@RequestMapping(value="/submitWardDischargeSummary", method=RequestMethod.GET)
	public ModelAndView submitWardDischargeSummary(HttpServletRequest request, HttpServletResponse response) {
		String inpatientId = String.valueOf(request.getParameter("inpatientId"));
		ModelAndView mv = new ModelAndView();
		mv.setViewName("submitWardDischargeSummary");
		mv.addObject("inpatientId", inpatientId);
		return mv; 
	}
	
	@RequestMapping(value="/submitApproveDischargeSummary", method=RequestMethod.GET)
	public ModelAndView submitApproveDischargeSummary(HttpServletRequest request, HttpServletResponse response) {
		String inpatientId = String.valueOf(request.getParameter("inpatientId"));
		ModelAndView mv = new ModelAndView();
		mv.setViewName("submitApproveDischargeSummary");
		mv.addObject("inpatientId", inpatientId);
		return mv; 
	}
	
	@RequestMapping(value="/dailyCaseSheetChart", method=RequestMethod.GET)
	public ModelAndView wardDailyCaseSheetChart(HttpServletRequest request, HttpServletResponse response) {
		Long inpatientId= Long.parseLong(String.valueOf(request.getParameter("inpatientId")));
		String inputJson = "{\"inpatientId\":"+inpatientId+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCaseSheetChartDetails");
		String data =  RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/getCaseSheetChartDetails", requestHeaders, inputJson);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dailyCaseSheetChart");
		mv.addObject("data", data);  
		return mv;
	}
	
	
	/*Working of ReferralAndConsultation*/
	
	@RequestMapping(value="/waitingListForRefAndConsult", method=RequestMethod.GET)
	public ModelAndView waitingListForRefAndConsult(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("waitingListForRefAndConsult");
		return mv; 
	}
	 
	
	@RequestMapping(value = "/getWaitingListReferalAndConsult", method = RequestMethod.POST)
	public String getWaitingListReferalAndConsult(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWaitingListReferalAndConsult");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/ward/getWaitingListReferalAndConsult", requestHeaders, payload);
	}
	@RequestMapping(value = "/referalAndConsultDetails", method = RequestMethod.GET)
	public ModelAndView referalAndConsultDetails(HttpServletRequest request, HttpServletResponse response) {
		String consDoctorIdDt = request.getParameter("consDoctorIdDt");
		String jsonResponse = "";
		String jsp = "referalAndConsultDetails";
		Map<String, Object> map = new HashMap<String, Object>();
		String flagForList =  request.getParameter("flagForList");
		String payload = "{\"consDoctorIdDt\":" + consDoctorIdDt + "," + "\"flagForList\":" +'"'+flagForList+'"'+"}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/ward/getWaitingListReferalAndConsult", requestHeaders, payload);
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWaitingListReferalAndConsult");
		jsonResponse= RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, payload);
		//System.out.println("jsonResponse " + jsonResponse);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/submitReferalRemarks", method=RequestMethod.POST)
	public String submitReferalRemarks(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		 
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "submitReferalRemarks");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		 //return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/ward/submitReferalRemarks", requestHeaders, inputJson);
		} 
	/*End of Working Referral consultation */
	
	@RequestMapping(value="/saveReturnQty", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public String saveReturnQty(@RequestBody String inputJson, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveReturnQty");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, inputJson);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/ward/saveReturnQty", requestHeaders, inputJson);
	}   
	
	@RequestMapping(value="/getUnitList", method=RequestMethod.POST)
	public String getUnitList(@RequestBody String requestPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);	
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getUnitList");	
		//String OSBURL = IpAndPortNo+OSBURL;		
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, jsonObject.toString());
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/sho/getUnitList", requestHeaders, jsonObject.toString());
	}
}
