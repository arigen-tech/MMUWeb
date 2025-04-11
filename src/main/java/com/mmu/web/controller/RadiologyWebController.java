package com.mmu.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

@RequestMapping("/radiology")
@RestController
@CrossOrigin
public class RadiologyWebController {
	
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");

	@RequestMapping(value="/resultPrinting", method = RequestMethod.GET)
	public ModelAndView resultPrinting(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv =new ModelAndView();
		mv.setViewName("radiologyResultPrinting"); 
		return mv;	
	}
	
	@RequestMapping(value="/getResultPrintingData", method = RequestMethod.POST)
	public String getResultPrintingData(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getResultPrintingData");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, data);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/radiology/getResultPrintingData", requestHeaders, data);
	}
	
	@RequestMapping(value="/radiologyResultHistory", method = RequestMethod.GET)
	public ModelAndView radiologyResultHistory(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv =new ModelAndView();
		String flag = request.getParameter("flag");
		JSONObject flagObject = new JSONObject();
		flagObject.put("flag", String.valueOf(flag));
		String dtId = request.getParameter("dtId");
		String userId = request.getParameter("userId");
		String payload = "{\"id\":" + dtId + ",\"userId\":"+ userId +"}";
		/*Map<String,Object> payload = new HashMap<>();
		payload.put("id", dtId);*/
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getResultValidation");
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://localhost:8180/AshaShipServices/radiology/getResultValidation",requestHeaders, payload);
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		mv.setViewName("radiologyResultHistory");
		mv.addObject("data", data);
		mv.addObject("flag", flagObject.toString());
		return mv;	
	}
	
	@RequestMapping(value="/getRadiologyWaitingDataPacs", method = RequestMethod.GET)
	public ModelAndView getRadiologyWaitingDataPacs() {
		ModelAndView mv =new ModelAndView();
		mv.setViewName("radiologyWaitingListPacs");
		return mv;	
	}
	
}
