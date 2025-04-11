package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.dao.ReportDao;
import com.mmu.web.service.ReportService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;


@Service("ReportService")
public class ReportServiceImpl implements ReportService {

	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT");
	
	@Autowired
	ReportDao reportDao;
	
	@Override
	public String printTokenCard(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
		String Url = HMSUtil.getProperties("urlextension.properties","TOKEN_CARD_REPORT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}


	 
	
	
	
	
	
}
