package com.mmu.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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



@RequestMapping("/ehr")
@RestController
@CrossOrigin
public class WebEHRController {
	
	
	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT");

	@RequestMapping(value="/patientSummary", method = RequestMethod.GET)
	public ModelAndView doctorRoaster() {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "patientSummary";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;		
	}
	
	@RequestMapping(value = "/patientSummaryDetail", method = RequestMethod.POST)
	public String patientSummaryDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();	
		String Url = HMSUtil.getProperties("urlextension.properties","patientSummary");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);		
		   
		
	}
	
	@RequestMapping(value = "/visitSummary", method = RequestMethod.POST)
	public String visitSummary(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","visitSummary");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	
}
