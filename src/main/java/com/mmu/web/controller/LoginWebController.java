package com.mmu.web.controller;

import java.util.HashMap;

import javax.servlet.http.Cookie;
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

import com.mmu.web.service.LoginService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.ProjectUtils;

@RequestMapping("/dashboard")
@RestController
@CrossOrigin
public class LoginWebController {

	@Autowired
	LoginService loginService;
	
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public ModelAndView masterModules(HttpServletRequest request, HttpServletResponse response) {
		boolean check=ProjectUtils.checksession(request);
		if(check){
		ModelAndView mav = new ModelAndView("dashboard");
		return mav;
		}
		return new ModelAndView("redirect:/dashboard/mmuLogin");
		//return mav;

	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("login");
		HttpSession session=request.getSession();
		session.invalidate();
		return mav;

	}
	
	@RequestMapping(value = "/mmuLogin", method = RequestMethod.GET)
	public ModelAndView mmuLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mmulogin");
		HttpSession session=request.getSession();
		session.invalidate();
		return mav;

	}
	
	@RequestMapping(value = "/changePassword", method = RequestMethod.GET)
	public ModelAndView changePassword(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("changeUpdatePassword");
		return mav;
	}
	
	@RequestMapping(value = "/homePage", method = RequestMethod.GET)
	public ModelAndView homePage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("home");
		return mav;

	}
	
	@RequestMapping(value = "/executeProcedureForDashBoard", method = RequestMethod.POST)
	public String executeProcedureForDashBoard(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		String resp = loginService.executeProcedureForDashBoard(payload, request, response);

		return resp;
	}
	
	
	@RequestMapping(value="/showApplicationsOnRoleBaseNew", method=RequestMethod.POST)	
	public String showApplicationsOnRoleBaseNew(@RequestBody String payload,HttpServletRequest request,
			HttpServletResponse response) {
		String resp = loginService.showApplicationsOnRoleBaseNew(payload, request, response);
		return resp;
	}
	
	@RequestMapping(value = "/homeShipLanding", method = RequestMethod.GET)
	public ModelAndView homeShipLanding(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("shiplanding");
		return mav;

	}
	
	@RequestMapping(value = "/logouts", method = RequestMethod.GET)
	public ModelAndView logOut(HttpServletRequest request,HttpServletResponse response) {
	
		HttpSession httpSession = request.getSession(false);
	      if(httpSession != null) {
        	httpSession.invalidate();
       }
       for(Cookie cookie : request.getCookies()) {
           cookie.setMaxAge(0);
           cookie.setValue(null);
           cookie.setPath("/");
           response.addCookie(cookie);
       }
	   	String payload = "{\"visitId\":"+455667l+"}";
		String jsonResponse = loginService.getMMUServiceLogout(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
	
       return new ModelAndView("redirect:/dashboard/mmuLogin");
	}
	
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public ModelAndView forgotPassword(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("forgotPassword");
		return mav;

	}
	
	@RequestMapping(value = "/getPandmicZoneData", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPandmicZoneData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		String data=loginService.getPandmicZoneData(payload, request, response);
		return data;
	}
	
	@RequestMapping(value = "/auditdashboard", method = RequestMethod.GET)
	public ModelAndView auditModule(HttpServletRequest request, HttpServletResponse response) {
		boolean check=ProjectUtils.checksession(request);
		if(check){
		ModelAndView mav = new ModelAndView("auditDashboard");
		return mav;
		}
		return new ModelAndView("redirect:/dashboard/mmuLogin");
		//return mav;

	}
	
	@RequestMapping(value = "/authenticateUserDown", method = RequestMethod.GET)
	public ModelAndView authenticateUserDown(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("authenticatUser");
		 
		//String mobileNo = request.getParameter("mobileno");
		String orderId = request.getParameter("orderHdId");
	//	mav.addObject("mobileNo", mobileNo);
		mav.addObject("orderHdId", orderId);
		return mav;

	}
	@RequestMapping(value = "/getAuthenticateUser", method = RequestMethod.POST)
	public ModelAndView getAuthenticateUser(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("authenticatUser");
		 
		Box box = HMSUtil.getBox(request);
		JSONObject jsonObject = new JSONObject(box);
		String orderHdId=jsonObject.get("orderHdId").toString();
		orderHdId=HMSUtil.getReplaceString(orderHdId);
		
		String MobileNo=jsonObject.get("MobileNo").toString();
		MobileNo=HMSUtil.getReplaceString(MobileNo);
		
		String orderIdT=jsonObject.get("orderIdT").toString();
		orderIdT=HMSUtil.getReplaceString(orderIdT);
		
		String mobileNoT=jsonObject.get("mobileNoT").toString();
		mobileNoT=HMSUtil.getReplaceString(mobileNoT);
		if(orderIdT.equalsIgnoreCase(orderHdId)) {
	 	String resp = loginService.getAuthenticateUser(jsonObject.toString(), request, response);
		JSONObject jSONObject =new JSONObject (resp);
	     
		String status = jSONObject.get("status").toString();
		String [] respsstus=status.split("##");
		if(respsstus[1]!=null && respsstus[1]!="" && respsstus[1].toString().equalsIgnoreCase("1")) {
			return new ModelAndView("redirect:/report/generateLabHistoryReport?oderHdId="+orderHdId+"");
		}else {
			//mav.addObject("mobileNo", MobileNo);
			mav.addObject("orderHdId", orderHdId);
			mav.addObject("message", respsstus[0].toString());
		}
		}
		else {
			//mav.addObject("mobileNo", MobileNo);
			mav.addObject("orderHdId", orderHdId);
			mav.addObject("message", "User is not correct");
			
		}
		return mav;

	}
}
