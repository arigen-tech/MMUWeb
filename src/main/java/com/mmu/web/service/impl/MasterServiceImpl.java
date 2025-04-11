package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.MasterService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;



@Repository
public class MasterServiceImpl implements MasterService{

	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT").trim();
	
	@Override
	public String getAllCommandDetails(String cmdPayload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","OSB_GET_ALL_COMMAND");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL, requestHeaders, cmdPayload);
		
	}
	

	


	@Override
	public String getTradeDetails(String tradeDetailsPayload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GET_TRADE_DETAILS_KEY");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL, requestHeaders, tradeDetailsPayload);
	}

	@Override
	public String getCommandDetails(String cmdPayload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GET_COMMAND_KEY");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL, requestHeaders, cmdPayload);
	}
	
	 
	@Override
	public String checkFinancialYear(String cmdPayload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","checkFinancialYear");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL, requestHeaders, cmdPayload);
	
		  
	}
	
}
