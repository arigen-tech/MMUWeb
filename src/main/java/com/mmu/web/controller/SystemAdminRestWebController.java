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

import com.mmu.web.service.SystemAdminService;
import com.mmu.web.utils.HMSUtil;



@RequestMapping("/createAdmin")
@RestController
@CrossOrigin
public class SystemAdminRestWebController {
	
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	String localIpAndPort = HMSUtil.getProperties("urlextension.properties", "local_IP_AND_PORT");
	
	@Autowired
	SystemAdminService systemAdminService;
	
	@RequestMapping(value = "/systemAdmin", method = RequestMethod.GET)
	public ModelAndView systemAdmin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("systemAdmin");
		 
		return mav;

	}
	
	@RequestMapping(value = "/unitAdmin", method = RequestMethod.GET)
	public ModelAndView unitAdmin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("unitAdmin");
		 HttpSession httSession= request.getSession();
		 Integer userId=(Integer) httSession.getAttribute("user_id");
		 
		return mav;

	}
	
	  @RequestMapping(value="/getMasHospitalListForAdmin", method = RequestMethod.POST)
		public String getMasHospitalListForAdmin(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			
			return systemAdminService.getMasHospitalListForAdmin(payload, request, response);
		}
	  
	 
	  @RequestMapping(value="/getMasEmployeeDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String getMasEmployeeDetail(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			//System.out.println("coming here");
			return systemAdminService.getMasEmployeeDetail(payload, request, response);
		}
	
	  @RequestMapping(value="/getAllMasDesigation", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String getAllMasDesigation(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.getAllMasDesigation(payload, request, response);
		}

	  
	  @RequestMapping(value="/submitUnitAdmin", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String submitUnitAdmin(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				return systemAdminService.submitUnitAdmin(payload, request, response);
			}
	
	  
	  @RequestMapping(value="/getUnitAdminDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String getUnitAdminDetail(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.getUnitAdminDetail(payload, request, response);
		}
	  @RequestMapping(value="/submitMasDesignation", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String submitMasDesignation(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.submitMasDesignation(payload, request, response);
		}
	  @RequestMapping(value="/activateDeActivatUser", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String activateDeActivatUser(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.activateDeActivatUser(payload, request, response);
		}
	  
	  @RequestMapping(value="/getMasDesinationDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getMasDesinationDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				return systemAdminService.getMasDesinationDetail(payload, request, response);
			}
	  
	  @RequestMapping(value="/editDesignation", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String editDesignation(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.editDesignation(payload, request, response);
		}
	  @RequestMapping(value="/getUnitAdminMasRole", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String getUnitAdminMasRole(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.getUnitAdminMasRole(payload, request, response);
		}
	  
	  
	  @RequestMapping(value="/editUnitAdminUser", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String editUnitAdminUser(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.editUnitAdminUser(payload, request, response);
		}
	  
	  @RequestMapping(value="/getMasDesigationForUnitId", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String getMasDesigationForUnitId(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.getMasDesigationForUnitId(payload, request, response);
		}
	  
	  @RequestMapping(value="/getAllServiceByUnitId", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String getAllServiceByUnitId(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.getAllServiceByUnitId(payload, request, response);
		}
	  @RequestMapping(value="/getMasUnitListByUnitCode", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
		public String getMasUnitListByUnitCode(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			return systemAdminService.getMasUnitListByUnitCode(payload, request, response);
		}
	  
	   }
