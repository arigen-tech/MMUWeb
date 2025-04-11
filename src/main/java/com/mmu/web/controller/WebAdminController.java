package com.mmu.web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.service.WebAdminService;


@RequestMapping("/admin")
@RestController
@CrossOrigin
public class WebAdminController {
	
	@Autowired
	WebAdminService adminser;
	
	@RequestMapping(value="/doctorRoaster", method = RequestMethod.GET)
	public ModelAndView doctorRoaster() {
		String jsp = "doctorRoaster";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/getDepartmentList", method = RequestMethod.POST)
	public String getDepartmentList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("asha web called");
		return adminser.getDepartmentList(data, request, response) ;		
	}
	
	@RequestMapping(value="/getDoctorRoasterDetail", method = RequestMethod.POST)
	public String getDoctorRoasterDetail(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		//System.out.println(adminser.getDoctorRoasterDetail(data, request, response));
		//System.out.println("asha web called");
		return adminser.getDoctorRoasterDetail(data, request, response)	;	
	}
	
	@RequestMapping(value="/saveDoctorRoaster", method = RequestMethod.POST)
	public String saveDoctorRoaster(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		
		return adminser.saveDoctorRoaster(data, request, response);	
	}
	
	@RequestMapping(value="/getDepartmentListBasedOnDepartmentType", method = RequestMethod.POST)
	public String getDepartmentListBasedOnDepartmentType(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("asha web called");
		return adminser.getDepartmentListBasedOnDepartmentType(data, request, response) ;		
	}
	
	@RequestMapping(value="/setDepartmentId", method = RequestMethod.POST, consumes = "application/json")
	public String setDepartmentId(@RequestBody Map<String,Object> data, HttpServletRequest request, HttpServletResponse response) {
		long departmentId = Long.parseLong(String.valueOf(data.get("departmentId")));
		String departmentName = String.valueOf(data.get("departmentName"));
		HttpSession session = request.getSession();
		session.setAttribute("department_id",departmentId);
		session.setAttribute("departmentName",departmentName);		
		JSONObject obj = new JSONObject();
		obj.put("status", "success");
		obj.put("departmentID", session.getAttribute("department_id"));		
		//System.out.println("department name "+session.getAttribute("departmentName"));
		return obj.toString();
	}
	
	

}
