package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.WebAdminService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@Service
public class WebAdminServiceImpl implements WebAdminService {
	
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	@Override
	public String getDepartmentList(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDoctorRosterDepartmentList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getDoctorRoasterDetail(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDoctorRoasterDetail");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String saveDoctorRoaster(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "submitDepartmentRoaster");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders,data);
	}

	@Override
	public String getDepartmentListBasedOnDepartmentType(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDepartmentListBasedOnDepartmentType");
		return RestUtils.postWithHeaders(ipAndPort.trim()+OSBURL.trim(), requestHeaders, data);
	}	
	
}
