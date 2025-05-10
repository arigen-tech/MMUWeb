package com.mmu.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.service.MedicalExamService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RequestMapping("/approve") 
@RestController
@CrossOrigin
public class ApprovalProcessController {
String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT").trim();
@Autowired
MedicalExamService medicalExamService;
 

////------------------------open jsp for Approval-------------------------------//	
	@RequestMapping(value = "/approveProcess", method = RequestMethod.GET)
	public ModelAndView approveProcess(HttpServletRequest request,	HttpServletResponse response,Model model,HttpSession session) {
		String jsp = "approvalProcess";
		JSONObject json = new JSONObject();
		json.put("userId", session.getAttribute("user_id"));
		json.put("hospitalId", session.getAttribute("hospital_id"));
		json.put("departmentId","6");
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
		
		 String Url = HMSUtil.getProperties("urlextension.properties","getApprovalFormatData"); 
		 String OSBURL = IpAndPortNo + Url;
		 String approvalResponse =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
		 
		
	   // String approvalResponse =  RestUtils.postWithHeaders("http://localhost:8181/AshaServices/v0.1/approval/getApprovalFormatData",requestHeaders, json.toString()); 
		model.addAttribute("approvalResponse", approvalResponse);
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	 @RequestMapping(value="/getApprovalFormatDataProcessing", method = RequestMethod.POST,produces="application/json",consumes="application/json")
		public String getApprovalFormatDataProcessing(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
		 MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
		 JSONObject json = new JSONObject();
		 HttpSession session=request.getSession();
			json.put("userId", session.getAttribute("user_id"));
			json.put("hospitalId", session.getAttribute("hospital_id"));
			json.put("departmentId","6");
			 String Url = HMSUtil.getProperties("urlextension.properties","getApprovalFormatData"); 
			 String OSBURL = IpAndPortNo + Url;
			 String approvalResponse =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
			 return  approvalResponse;
			
			// return     RestUtils.postWithHeaders("http://localhost:8181/AshaShipServices/approval/getApprovalFormatData",requestHeaders, json.toString()); 
		}
	 
		@RequestMapping(value = "/meApproveProcess", method = RequestMethod.GET)
		public ModelAndView approveProcessMe(HttpServletRequest request,	HttpServletResponse response,Model model ) {
			String jsp = "meApprovalProcess";
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
		}
		
		
		@RequestMapping(value = "/meApproved", method = RequestMethod.GET)
		public ModelAndView getMEApprovedList(HttpServletRequest request,	HttpServletResponse response,Model model ) {
			String jsp = "meApprovalProcessApproved";
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
		}
		@RequestMapping(value = "/meReject", method = RequestMethod.GET)
		public ModelAndView getMeReject(HttpServletRequest request,	HttpServletResponse response,Model model ) {
			String jsp = "meReject";
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
		}
		
		@RequestMapping(value = "/mbApproveProcess", method = RequestMethod.GET)
		public ModelAndView approveProcessMb(HttpServletRequest request,HttpServletResponse response,Model model ) {
			String jsp = "mbApprovalProcess";
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
		}
		
		@RequestMapping(value = "/mbApproved", method = RequestMethod.GET)
		public ModelAndView getMbApprovedList(HttpServletRequest request,	HttpServletResponse response,Model model ) {
			String jsp = "mbApprovalProcessApproved";
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
		}
		
		
		@RequestMapping(value = "/anmEntryApprovalProcess", method = RequestMethod.GET)
		public ModelAndView captureVendorBillDetails(){

			return new ModelAndView("anmEntryDetails");
		}
		
		@RequestMapping(value = "/saveOrUpdateANMEntryDetails", method = RequestMethod.POST)
		public String saveOrUpdateANMEntryDetails(@RequestBody String payload) {
			String URL = HMSUtil.getProperties("urlextension.properties", "saveOrUpdateANMEntryDetails");
			return RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload
			);
		}
		
		@RequestMapping(value = "/anmOpdDataSubmit", method = RequestMethod.GET)
		public ModelAndView anmOpdDataSubmit(){

			return new ModelAndView("anmDetailsSubmit");
		}
		
		@RequestMapping(value = "/anmOpdOfflineList", method = RequestMethod.GET)
		public ModelAndView anmOpdOfflineList(){

			return new ModelAndView("anmOpdOfflineWaitingList");
		}
		
		@RequestMapping(value = "/getAnmOpdOfflineData", method = RequestMethod.POST)
		public String getAnmOpdOfflineData(@RequestBody String payload) {
			String URL = HMSUtil.getProperties("urlextension.properties", "getAnmOpdOfflineData");
			return RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload
			);
		}
		
		@RequestMapping(value = "/getAnmOpdOfflineDataDetails", method = RequestMethod.GET)
		public ModelAndView getAnmOpdOfflineDataDetails(HttpServletRequest request,	HttpServletResponse response) {
			Map<String, Object> map = new HashMap<String, Object>();
			String jsp = "anmEntryUpdateDetails";
			Long anmApmId= Long.parseLong(request.getParameter("anmApmId"));
			String payload = "{\"anmApmId\":"+anmApmId+"}";
			//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
			String URL = HMSUtil.getProperties("urlextension.properties", "getAnmOpdOfflineData");
			String jsonResponse = RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload.toString()
			);
			ModelAndView mv =new ModelAndView();
			mv.addObject("data", jsonResponse);
			mv.setViewName(jsp);
			return mv;
		}
		 
	
		@RequestMapping(value = "/pendingApprovalListOfflineData", method = RequestMethod.GET)
		public ModelAndView pendingApprovalListOfflineData(){

			return new ModelAndView("apmOpdOfflineWaitingList");
		}
		
		@RequestMapping(value = "/getApmOpdOfflineDataDetails", method = RequestMethod.GET)
		public ModelAndView getApmOpdOfflineDataDetails(HttpServletRequest request,	HttpServletResponse response) {
			Map<String, Object> map = new HashMap<String, Object>();
			String jsp = "apmEntryUpdateDetails";
			Long anmApmId= Long.parseLong(request.getParameter("anmApmId"));
			String payload = "{\"anmApmId\":"+anmApmId+"}";
			//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
			String URL = HMSUtil.getProperties("urlextension.properties", "getAnmOpdOfflineData");
			String jsonResponse = RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload.toString()
			);
			ModelAndView mv =new ModelAndView();
			mv.addObject("data", jsonResponse);
			mv.setViewName(jsp);
			return mv;
		}
		
		@RequestMapping(value = "/captureAttendanceOfflineData", method = RequestMethod.GET)
		public ModelAndView attendanceOfflineDataProcess(){

			return new ModelAndView("captureOfflineAttendance");
		}
		
		@RequestMapping(value = "/saveOrUpdateAttendanceOfflineData", method = RequestMethod.POST)
		public String saveOrUpdateAttendanceOfflineData(@RequestBody String payload) {
			String URL = HMSUtil.getProperties("urlextension.properties", "saveOrUpdateAttendanceOfflineData");
			return RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload
			);
		}
		
		@RequestMapping(value = "/attendanceDataSubmit", method = RequestMethod.GET)
		public ModelAndView attendanceDataSubmit(){

			return new ModelAndView("attendanceDetailsSubmit");
		}
		 
}
