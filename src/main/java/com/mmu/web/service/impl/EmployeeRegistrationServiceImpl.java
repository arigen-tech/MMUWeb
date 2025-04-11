package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.EmployeeRegistrationService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@Repository
public class EmployeeRegistrationServiceImpl implements EmployeeRegistrationService {
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	

		@Override
		public String getSavedEmployeeList(String payload, HttpServletRequest request, HttpServletResponse response) {
			String Url = HMSUtil.getProperties("urlextension.properties","savedEmployeeList");
			String OSBURL = ipAndPort + Url;
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}



		@Override
		public String getPendingAttendanceList(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			String Url = HMSUtil.getProperties("urlextension.properties","pendingAttendanceList");
			String OSBURL = ipAndPort + Url;
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}



		@Override
		public String pendingListPhoto(String payload, HttpServletRequest request, HttpServletResponse response) {
			String Url = HMSUtil.getProperties("urlextension.properties","pendingListPhoto");
			String OSBURL = ipAndPort + Url;
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}



		@Override
		public String getPenaltyList(String payload, HttpServletRequest request, HttpServletResponse response) {
			JSONObject jsonPayload = new JSONObject(payload);
			jsonPayload.put("inspectionYear", jsonPayload.getString("attnYear"));
			jsonPayload.put("inspectionMonth", jsonPayload.getString("attnMonth"));
			jsonPayload.put("PN", jsonPayload.getInt("pageNo"));
			if(jsonPayload.getString("searchType").equals("E")){
				String Url = HMSUtil.getProperties("urlextension.properties", "getEquipmentPenaltyList");
				String OSBURL = ipAndPort + Url;
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonPayload.toString());
			} else if(jsonPayload.getString("searchType").equals("I")){
				String Url = HMSUtil.getProperties("urlextension.properties", "getInspectionPenaltyList");
				String OSBURL = ipAndPort + Url;
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonPayload.toString());
			}else {
				String Url = HMSUtil.getProperties("urlextension.properties", "getPenaltyList");
				String OSBURL = ipAndPort + Url;
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			}
		}



		@Override
		public String auditAttendanceHistory(String payload, HttpServletRequest request, HttpServletResponse response) {

			String Url = HMSUtil.getProperties("urlextension.properties","auditAttendanceHistory");
			String OSBURL = ipAndPort + Url;
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
		}



		@Override
		public String getEmpListForEdit(String payload, HttpServletRequest request, HttpServletResponse response) {
			String Url = HMSUtil.getProperties("urlextension.properties","getEmpListForEdit");
			String OSBURL = ipAndPort + Url;
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}


}
