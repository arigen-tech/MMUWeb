package com.mmu.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.service.AppointmentService;

@RequestMapping("/appointment")
@RestController
@CrossOrigin
public class AppointmentWebController {

	@Autowired
	AppointmentService appointmentService;
	
	
	@RequestMapping(value="/showappointmentsetup", method = RequestMethod.GET)
	public ModelAndView showRecordsForDoctorAppointment(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String data = "{\"hospitalId\":" + session.getAttribute("hospital_id") + "}";
		data=appointmentService.getRecordsForDoctorAppointment(data,request, response);
		String jsp = "appointmentSetup";
		return new ModelAndView(jsp, "data", data);
	}
	
	
	  @RequestMapping(value="/getLocationWiseAppointmentType", method = RequestMethod.POST) 
	  public String getLocationWiseAppointmentType(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
	  return appointmentService.getLocationWiseAppointmentType( data,request, response); 
	  }
	 
	
	
	@RequestMapping(value="/getAppointmentSetupDetails", method = RequestMethod.POST)
	public String getAppointmentSetupDetails(@RequestBody String data,HttpServletRequest request,HttpServletResponse response) {	
		return appointmentService.getAppointmentSetupDetails(data,request, response);
	}
	
	
	@RequestMapping(value="/submitAppointmentSetup", method = RequestMethod.POST)
	public String submitAppointmentSetup(@RequestBody String data,HttpServletRequest request,HttpServletResponse response) {	
		return appointmentService.submitAppointmentSetup(data,request, response);
	}
	
	
	@RequestMapping(value="/showappointmentsession", method = RequestMethod.GET)
	public ModelAndView showAppointmentSession(HttpServletRequest request, HttpServletResponse response) {
		String data ="{}";
		data=appointmentService.showAppointmentSession(data,request, response);
		String jsp = "appointmentsession";
		return new ModelAndView(jsp, "data", data);
	}
	
	@RequestMapping(value="/submitappointmentsession", method = RequestMethod.POST)
	public String submitAppointmentSession(@RequestBody String data,HttpServletRequest request,HttpServletResponse response) {	
		return appointmentService.submitAppointmentSession(data,request, response);
	}
	
	
	@RequestMapping(value="/getAllAppointmentSession", method=RequestMethod.POST)
	public String getAllAppointmentSession(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
	return appointmentService.getAllAppointmentSession(data, request, response);
	}
	
	@RequestMapping(value="/updateAppointmentSession", method = RequestMethod.POST)
	public String updateAppointmentSession(@RequestBody String data,HttpServletRequest request,HttpServletResponse response) {	
		return appointmentService.updateAppointmentSession(data,request, response);
	}
	
	 @RequestMapping(value="/getDoctorListFromMapping", method = RequestMethod.POST) 
	  public String getDoctorListFromMapping(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
	  return appointmentService.getDoctorListFromMapping( data,request, response); 
	  }
	
}



