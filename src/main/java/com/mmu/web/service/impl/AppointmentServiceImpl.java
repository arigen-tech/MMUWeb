package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.AppointmentService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;



@Service("AppointmentService")
public class AppointmentServiceImpl implements AppointmentService {

	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT").trim();
	
	@Override
	public String getRecordsForDoctorAppointment(String data,HttpServletRequest request,
			HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
			String Url = HMSUtil.getProperties("urlextension.properties","RECORD_FOR_APPOINTMENT_SETUP");
			String OSBURL = IpAndPortNo + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getLocationWiseAppointmentType(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
		String Url = HMSUtil.getProperties("urlextension.properties","LOCATION_WISE_APPOINTMENT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}
	
	@Override
	public String getAppointmentSetupDetails(String data, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","APPOINTMENT_SETUP_DETAIL");
			String OSBURL = IpAndPortNo + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String submitAppointmentSetup(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","SUBMIT_APPOINTMENT_SETUP");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String showAppointmentSession(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","SHOW_APPOINTMENT_SESSION");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
		
	}

	@Override
	public String submitAppointmentSession(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","SUBMIT_APPOINTMENT_SESSION");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getAllAppointmentSession(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GET_ALL_APPOINTMENT_SESSION");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String updateAppointmentSession(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","UPDATE_APP_SESSION");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getDoctorListFromMapping(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GET_DOCTOR_LIST_FROM_MAPPING");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	
	}
	
}
