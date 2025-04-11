package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service
public interface AppointmentService {



	String getRecordsForDoctorAppointment(String data,HttpServletRequest request, HttpServletResponse response);
	String getAppointmentSetupDetails(String data, HttpServletRequest request, HttpServletResponse response);
	String getLocationWiseAppointmentType(String data, HttpServletRequest request, HttpServletResponse response);
	String submitAppointmentSetup(String data, HttpServletRequest request, HttpServletResponse response);
	String showAppointmentSession(String data, HttpServletRequest request, HttpServletResponse response);
	String submitAppointmentSession(String data, HttpServletRequest request, HttpServletResponse response);
	String getAllAppointmentSession(String data, HttpServletRequest request, HttpServletResponse response);
	String updateAppointmentSession(String data, HttpServletRequest request, HttpServletResponse response);
	String getDoctorListFromMapping(String data, HttpServletRequest request, HttpServletResponse response);

	

	

}
