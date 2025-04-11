package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.TreatmentAuditWebService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@Repository
public class TreatmentAuditWebServiceImpl implements TreatmentAuditWebService {

	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	@Override
	public String getAuditWaitingList(String payload, HttpServletRequest request, HttpServletResponse response) {
		String Url = HMSUtil.getProperties("urlextension.properties","treatmentAuditWaitingList");
		String OSBURL = ipAndPort + Url;
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getAuditDetailModel(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdPatientDetailModel");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getPatientDianosisDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","treatmentGetPatientDianosisDetail");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getInvestigationDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","treatmentGetInvestigationDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getTreatmentPatientDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","treatmentGetTreatmentPatientDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String treatmentAuditSubmit(String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveTreatmentAuditDetails");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getRecommendedDiagnosisAllDetail(String payload, HttpServletRequest request,
			HttpServletResponse response)
	{
		    JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getRecommendedDiagnosisAllDetail");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
	}

	@Override
	public String getRecommendedInvestgationAllDetail(String payload, HttpServletRequest request,
			HttpServletResponse response)
	{
	    JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getRecommendedInvestgationAllDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
    }

	@Override
	public String getRecommendedTreatmentAllDetail(String payload, HttpServletRequest request,
			HttpServletResponse response)
	{
	    JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getRecommendedTreatmentAllDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
   }

	@Override
	public String getAllSymptomsForOpd(String payload, HttpServletRequest request, HttpServletResponse response) {
	    JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAllSymptomsForOpd");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
   }

	@Override
	public String getAllIcdForOpd(String payload, HttpServletRequest request, HttpServletResponse response) {
	    JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAllIcdForOpd");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
   }

	@Override
	public String getExpiryMedicine(String payload, HttpServletRequest request, HttpServletResponse response) {
	    JSONObject jsonParent = new JSONObject();
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getExpiryMedicine");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
   }
	

}
