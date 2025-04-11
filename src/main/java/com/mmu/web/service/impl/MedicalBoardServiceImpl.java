package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.MedicalBoardService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@Repository
public class MedicalBoardServiceImpl implements MedicalBoardService{

	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");

	@Override
	public String getMBWaitingList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","piMbWaitingList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String preliminaryMBWaitingDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMBPatientDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String saveInvestigationMBdetails(String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveInvestigationMBDetails");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getMBPreAssesWaitingList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","mbPreAssesmentWaitingList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getMBPreAssesDetails(String payload, HttpServletRequest request, HttpServletResponse response) {
		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","mbPreAssesmentDetails");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String saveVitailsPatientdetails(String payload, HttpServletRequest request, HttpServletResponse response) {
		
		JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","mbsaveVitailsPatientdetails");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String saveRefferedOpinionMBdetails(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveRefferedOpinionMBDetails");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getMedicalBoardAutocomplete(String payload, HttpServletRequest request,
		HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getMedicalBoardAutocomplete");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getPatientDetailToValidate(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientDetailToValidate");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getPatientReferalDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientReferalDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getRefferedOpinionDetails(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getRefferedOpinionDetails");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	
	@Override
	public String saveTranscriptionData(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveTranscriptionData");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getMOValidateWaitingList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMOValidateWaitingList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}	
	
	@Override
	public String getDataValidateAMSFform(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getDataValidateAMSFform");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String updateSpecialistOpiniondetails(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		
		JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","updateSpecialistOpiniondetails");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String saveAmsfForm15Details(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveAmsfForm15Details");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getDataValidateAMSF15form(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getDataValidateAMSF15form");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String saveAmsf15CheckList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveAmsfForm15CheckList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getAmsf15CheckList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAmsf15CheckList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getMBMedicalCategory(String payload, HttpServletRequest request, HttpServletResponse response) {
		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","mbCategoryDetails");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getInvestigationAndResult(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getInvestigationAndResultMB ");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	@Override
	public String getDocumentList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getDocumentList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
	}

	

}
