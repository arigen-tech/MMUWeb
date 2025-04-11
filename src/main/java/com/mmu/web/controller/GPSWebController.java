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

@RequestMapping("/gps")
@RestController
@CrossOrigin
public class GPSWebController {
	static String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");

	
	@RequestMapping(value = "/getGPSInfo", method = RequestMethod.POST)
	public String getGPSInfo(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getGPSInfo");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getDistrictListForMap", method = RequestMethod.POST)
	public String getIdTypeList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDistrictListForMap");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getCampInfoAllDistrict", method = RequestMethod.POST)
	public String getCampInfoAllDistrict(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCampInfoAllDistrict");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, payload);
	}
	
}
