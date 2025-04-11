package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.SystemAdminService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;
@Repository
public class SystemAdminServiceImpl implements SystemAdminService {
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	@Override
	public String getMasHospitalListForAdmin(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasHospitalListForAdmin");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getMasHospitalListForAdmin", requestHeaders, payload);
	}
	
	@Override
	public String getMasEmployeeDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasEmployeeDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getMasEmployeeDetail", requestHeaders, payload);

	}
	@Override
	public String getAllMasDesigation(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAllMasDesigation");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getAllMasDesigation", requestHeaders, payload);

	}

	
	 
	@Override
	public String submitUnitAdmin(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","submitUnitAdmin");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/submitUnitAdmin", requestHeaders, payload);
	}
	@Override
	public String getUnitAdminDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getUnitAdminDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getUnitAdminDetail", requestHeaders, payload);
	}
	@Override
	public String submitMasDesignation(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","submitMasDesignation");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/submitMasDesignation", requestHeaders, payload);
	}

	@Override
	public String activateDeActivatUser(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","activateDeActivatUser");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/activateDeActivatUser", requestHeaders, payload);
	
	}

	@Override
	public String getMasDesinationDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasDesinationDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getMasDesinationDetail", requestHeaders, payload);
	
	}
	@Override
	public String editDesignation(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","editDesignation");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	//	return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/editDesignation", requestHeaders, payload);
	
	}

	@Override
	public String getUnitAdminMasRole(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getUnitAdminMasRole");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getUnitAdminMasRole", requestHeaders, payload);
	
	}

	@Override
	public String editUnitAdminUser(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","editUnitAdminUser");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/editUnitAdminUser", requestHeaders, payload);
	}

	@Override
	public String getMasDesigationForUnitId(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasDesigationForUnitId");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getMasDesigationForUnitId", requestHeaders, payload);
	}
	@Override
	public String getAllServiceByUnitId(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAllServiceByUnitId");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getAllServiceByUnitId", requestHeaders, payload);
	}
	
	
	@Override
	public String getMasUnitListByUnitCode(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasUnitListByUnitCode");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/createAdmin/getMasUnitListByUnitCode", requestHeaders, payload);
	}
}
