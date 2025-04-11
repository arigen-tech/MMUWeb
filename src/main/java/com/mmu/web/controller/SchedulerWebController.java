package com.mmu.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RestController
@CrossOrigin
@RequestMapping("/scheduler")
public class SchedulerWebController {
	
	static String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	

	@RequestMapping(value = "/getMMUListForPoll", method = RequestMethod.POST)
	public String getMMUListForPoll(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMMUListForPoll");
		String resp =  RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);
		return resp;

	}

	@RequestMapping(value = "/savePollInfo", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String savePollInfo(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//System.out.println("Input json save-->"+inputJson);
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "savePollInfo");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	 

}
