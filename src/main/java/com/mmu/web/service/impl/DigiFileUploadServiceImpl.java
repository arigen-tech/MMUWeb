package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mmu.web.service.DigiFileUploadService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@Service
public class DigiFileUploadServiceImpl implements DigiFileUploadService{

	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	@Override
	public String getWaitingTagAndDataEntry(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getWaitingTagAndDataEntry");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/digifileupload/getWaitingTagAndDataEntry", requestHeaders, payload);
}
	@Override
	public String submitNewEntryForm3B(String jsonObj, MultipartHttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","submitNewEntryForm3B");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObj);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/digifileupload/submitNewEntryForm3B", requestHeaders, jsonObj);
	}
	@Override
	public String dataSaveAmsfForm15(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","dataDigitizationSaveAmsfForm15");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalBoard/dataDigitizationSaveAmsfForm15", requestHeaders, payload);
	}
	@Override
	public String dataSaveSpecialistOpinion(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","dataDigitizationSaveSpecialistOpinion");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalBoard/dataDigitizationSaveSpecialistOpinion", requestHeaders, payload);
	}
	@Override
	public String getSubInvestigationHtml(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getSubInvestigationHtml");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/commonController/getSubInvestigationHtml", requestHeaders, payload);

	}
	@Override
	public String getInvestigationAndSubInvesForTemplate(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getInvestigationAndSubInvesForTemplate");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/commonController/getInvestigationAndSubInvesForTemplate", requestHeaders, payload);
	}

	
	@Override
	public String getFamilyDetailsHistory(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getFamilyDetailsHistory");
		 String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/commonController/getFamilyDetailsHistory", requestHeaders, payload);
	}
}
