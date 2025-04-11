package com.mmu.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RequestMapping("/dispencery")
@RestController
@CrossOrigin
public class DispensaryWebController {
	String IpAndPortNo = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT").trim();

	@RequestMapping(value = "/createIndent", method = RequestMethod.GET)
	public ModelAndView createIndent(HttpServletRequest request, HttpServletResponse response,HttpSession session, Model model) {
		String jsp = "createIndent";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getDepartmentListBasedOnDepartmentType");
		String OSBURL = IpAndPortNo + Url;
		//Integer mmuId = Integer.parseInt(request.getParameter("mmuId"));
		//String data = "{\"mmuId\":" + mmuId+"}";
		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		obj.put("userId", session.getAttribute("user_id"));
		 
		obj.put("mmuId", session.getAttribute("mmuId"));
		 	String departmentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, obj.toString());
		model.addAttribute("departmentList", departmentList);
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	// submit form

	@RequestMapping(value = "/submitIndentDispencery", method = RequestMethod.POST)
	public ModelAndView submitIndentDispencery(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		obj.put("userId", session.getAttribute("user_id"));
		// obj.put("hospitalId", session.getAttribute("hospital_id"));
		obj.put("mmuId", session.getAttribute("mmuId"));
		obj.put("cityId", session.getAttribute("dispensaryCityId"));
		String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
		obj.put("loginDepartmentId", departmentId);
		//////////////////////As per new Changes/////////////////////////////////
		String cittyIdVal= obj.get("cittyIdVal").toString();
		 
		cittyIdVal=HMSUtil.getReplaceString(cittyIdVal);
		
		obj.put("cittyIdVal", cittyIdVal);
		/////////////////////////////////////////////////////

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitDispenceryIndent");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, obj.toString());
		// String responseData =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/submitDispenceryIndent",requestHeaders,
		// obj.toString());
		JSONObject responsedata = new JSONObject(responseData);
		ModelAndView mv = new ModelAndView();
		String jsp = "saveIndent";
		model.addAttribute("message", responsedata.get("msg"));
		model.addAttribute("indentMId", responsedata.get("indentMId"));
		model.addAttribute("indentFlag",""); 
		model.addAttribute("flag", "save");
		mv.setViewName(jsp);
		return mv;

	}

	// list of pending Indent

	@RequestMapping(value = "/getIndentForApproval", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentForApproval(HttpServletRequest request, Model model, HttpServletResponse response,
			HttpSession session) {
		String indentListForApprovals = "";
		return new ModelAndView("indentListForApproval", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getIndentApprovalListForAuditor", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentApprovalListForAuditor(HttpServletRequest request, Model model,
			HttpServletResponse response, HttpSession session) {
		String indentListForApprovals = "";
		return new ModelAndView("indentApprovalListForAuditor", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getIndentApprovalListForCO", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentApprovalListForCO(HttpServletRequest request, Model model,
			HttpServletResponse response, HttpSession session) {
		String indentListForApprovals = "";
		return new ModelAndView("indentApprovalListForCO", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getAllListOfIndentList", method = RequestMethod.POST)
	public String getAllListOfIndentList(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String indentList = "";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		// json.put("mmuId", session.getAttribute("mmuId"));
		json.put("departmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllListOfIndentList");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		// indentList =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getAllListOfIndentList",requestHeaders,
		// json.toString());

		return indentList;
	}

	@RequestMapping(value = "/getPendingListForAuditor", method = RequestMethod.POST)
	public String getPendingListForAuditor(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String indentList = "";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		// json.put("mmuId", session.getAttribute("mmuId"));
		json.put("departmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPendingListForAuditor");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		// indentList =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getAllListOfIndentList",requestHeaders,
		// json.toString());

		return indentList;
	}

	@RequestMapping(value = "/getPendingListForCO", method = RequestMethod.POST)
	public String getPendingListForCO(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String cityId = session.getAttribute("cityIdUsers").toString();
		cityId = cityId.replace(",", "");
		String indentList = "";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		json.put("departmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());
		json.put("cityId", cityId);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPendingListForCO");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		return indentList;
	}

	// get indent for Tracking

	@RequestMapping(value = "/getIndentForTracking", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentForTracking(HttpServletRequest request, Model model, HttpServletResponse response) {
		String indentListForApprovals = "";
		return new ModelAndView("indentListForTracking", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getIndentListForTracking", method = RequestMethod.POST)
	public String getIndentListForTracking(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String indentList = "";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		json.put("mmuId", session.getAttribute("mmuId"));
		json.put("departmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentListForTracking");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		// indentList =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentListForTracking",requestHeaders,
		// json.toString());

		return indentList;
	}

	@RequestMapping(value = "/viewindentListForViewUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView viewindentListForViewUpdate(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		String indentListForApprovals = "";
		return new ModelAndView("indentListForViewUpdate", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getindentListForViewUpdate", method = RequestMethod.POST)
	public String getindentListForViewUpdate(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String indentList = "";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		json.put("mmuId", session.getAttribute("mmuId"));
		json.put("departmentId", session.getAttribute("department_id"));
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentListForTracking");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		// indentList =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentListForTracking",requestHeaders,
		// json.toString());

		return indentList;
	}

	@RequestMapping(value = "/getIndentDetails", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetails(HttpServletRequest request, Model model, HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentId"));
		String statusId = request.getParameter("indentStatus");
		String jsp = "updateIndent";
		String indentListForApprovals = "";
		String payload = "{\"indentId\":" + indentId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentDetails");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// String
		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentDetails",requestHeaders,payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.addObject("indentMId", indentId);
		mv.setViewName(jsp);
		return mv;
	}

	// -----------------------view Indent details for tracking--------------------//
	@RequestMapping(value = "/getIndentDetailsForTracking", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetailsForTracking(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentId"));
		String statusId = request.getParameter("indentStatus");
		String jsp = "viewIndentDetailsForTracking";
		String indentListForApprovals = "";
		String payload = "{\"indentId\":" + indentId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentDetails");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// String
		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentDetails",requestHeaders,payload);

		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getIndentDetailsForTrackingCo", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetailsForTrackingCo(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentId"));
		String statusId = request.getParameter("indentStatus");
		String jsp = "viewIndentDetailsForTrackingCo";
		String indentListForApprovals = "";
		String payload = "{\"indentId\":" + indentId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentDetailsCo");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// String
		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentDetails",requestHeaders,payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getIndentDetailsForTrackingDo", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetailsForTrackingDo(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentId"));
		String statusId = request.getParameter("indentStatus");
		String jsp = "viewIndentDetailsForTrackingDo";
		String indentListForApprovals = "";
		String payload = "{\"indentId\":" + indentId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentDetailsDo");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// String
		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentDetails",requestHeaders,payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.setViewName(jsp);
		return mv;
	}

	// ---------------------Delete Indent items------------------------------//

	@RequestMapping(value = "/deleteIndentItems", method = { RequestMethod.POST })
	public String deleteIndentItems(@RequestBody String requestObject, HttpServletRequest request,
			HttpServletResponse response) {
		String jsonResponse = "";
		// JSONObject json = new JSONObject(requestObject);

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "deleteIndentItems");
		String OSBURL = IpAndPortNo + Url;
		jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, requestObject);

		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/deleteIndentItems",requestHeaders,requestObject);
		return jsonResponse;

	}

	// --------------------------------------update Indent
	// items---------------------------------------------//

	@RequestMapping(value = "/updateIndentDispencery", method = RequestMethod.POST)
	public ModelAndView updateIndentDispencery(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		obj.put("userId", session.getAttribute("user_id"));
		obj.put("mmuId", session.getAttribute("mmuId"));
		obj.put("loginDepartmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateIndentDispencery");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, obj.toString());

		// String responseData =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/updateIndentDispencery",requestHeaders,
		// obj.toString());
		JSONObject responsedata = new JSONObject(responseData);
		ModelAndView mv = new ModelAndView();
		String jsp = "saveIndent";
		model.addAttribute("message", responsedata.get("msg"));
		model.addAttribute("indentMId", responsedata.get("indentMId"));
		model.addAttribute("flag", "update");
		model.addAttribute("indentFlag",""); 
		mv.setViewName(jsp);
		return mv;

	}

	@RequestMapping(value = "/getIndentDetailsForApproval", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetailsForApproval(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentId"));
		String statusId = request.getParameter("indentStatus");
		String jsp = "indentApproval";
		String indentListForApprovals = "";
		String payload = "{\"indentId\":" + indentId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentDetails");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// String
		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentDetails",requestHeaders,payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getIndentDetailsApprovalForAuditor", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetailsApprovalForAuditor(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentId"));
		String statusId = request.getParameter("indentStatus");
		String jsp = "indentApprovalDetailForAuditor";
		String indentListForApprovals = "";
		String payload = "{\"indentId\":" + indentId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentDetails");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// String
		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentDetails",requestHeaders,payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getIndentDetailsApprovalForCO", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetailsApprovalForCO(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentId"));
		String statusId = request.getParameter("indentStatus");
		//System.out.println("calling................................................");
		String jsp = "indentApprovalDetailCo";
		String indentListForApprovals = "";
		String payload = "{\"indentId\":" + indentId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentDetails");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// String
		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getIndentDetails",requestHeaders,payload);

		//System.out.println("jsonResponse " + jsonResponse);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.setViewName(jsp);
		return mv;
	}

	// --------------------------------------update Indent
	// items---------------------------------------------//

	@RequestMapping(value = "/approveIndentDispencery", method = RequestMethod.POST)
	public ModelAndView approveIndentDispencery(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		obj.put("userId", session.getAttribute("user_id"));
		obj.put("mmuId", session.getAttribute("mmuId"));
		obj.put("loginDepartmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());

		//System.out.println("approveIndentDispencery--" + obj);

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateIndentDispencery");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, obj.toString());

		// String responseData =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/updateIndentDispencery",requestHeaders,
		// obj.toString());
		JSONObject responsedata = new JSONObject(responseData);
		ModelAndView mv = new ModelAndView();
		String jsp = "saveIndent";
		model.addAttribute("message", responsedata.get("msg"));
		model.addAttribute("indentMId", responsedata.get("indentMId"));
		model.addAttribute("flag", "approve");
		model.addAttribute("indentFlag",""); 
		mv.setViewName(jsp);
		return mv;

	}

	@RequestMapping(value = "/approveIndentDispenceryByAuditor", method = RequestMethod.POST)
	public ModelAndView approveIndentDispenceryByAuditor(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		String docorFlag=obj.get("doctor").toString();
		docorFlag=HMSUtil.getReplaceString(docorFlag);
		obj.put("userId", session.getAttribute("user_id"));
		obj.put("mmuId", session.getAttribute("mmuId"));
		obj.put("loginDepartmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());

		//System.out.println("approveIndentDispencery--" + obj);

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateIndentDispenceryByAuditor");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, obj.toString());

		// String responseData =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/updateIndentDispencery",requestHeaders,
		// obj.toString());
		JSONObject responsedata = new JSONObject(responseData);
		ModelAndView mv = new ModelAndView();
		String jsp = "saveIndent";
		model.addAttribute("message", responsedata.get("msg"));
		model.addAttribute("indentMId", responsedata.get("indentMId"));
		model.addAttribute("flag", "approve");
		model.addAttribute("indentFlag","");
		if(docorFlag.equals("doctorValue"))
		{
			model.addAttribute("docorFlag","doctorValue");	
		}
		mv.setViewName(jsp);
		return mv;

	}

	@RequestMapping(value = "/approveIndentDispenceryByCO", method = RequestMethod.POST)
	public ModelAndView approveIndentDispenceryByCO(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		obj.put("userId", session.getAttribute("user_id"));
		obj.put("mmuId", session.getAttribute("mmuId"));
		obj.put("loginDepartmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());

		//System.out.println("approveIndentDispencery--" + obj);

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateIndentDispenceryByCo");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, obj.toString());

		// String responseData =
		// RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/updateIndentDispencery",requestHeaders,
		// obj.toString());
		JSONObject responsedata = new JSONObject(responseData);
		ModelAndView mv = new ModelAndView();
		String jsp = "saveIndentCo";
		model.addAttribute("message", responsedata.get("msg"));
		model.addAttribute("indentMId", responsedata.get("indentMId"));
		model.addAttribute("flag", "approve");
		mv.setViewName(jsp);
		return mv;

	}

	@RequestMapping(value = "/getAvailableStock", method = { RequestMethod.POST })
	public String getAvailableStock(@RequestBody String requestObject, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		String jsonResponse = "";
		JSONObject obj = new JSONObject(requestObject);
		obj.put("mmuId", session.getAttribute("mmuId"));
		String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
		obj.put("departmentId", departmentId);
		//System.out.println("inside getAvailableStock--" + requestObject);

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAvailableStock");
		String OSBURL = IpAndPortNo + Url;
		jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, obj.toString());

		// jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/dispencery/getAvailableStock",requestHeaders,obj.toString());
		return jsonResponse;

	}

	// -------------------------code by Deepak---------------------------------//

	@RequestMapping(value = "/pendingPrescriptionJSP", method = RequestMethod.GET)
	public ModelAndView pendingPrescriptionJSP(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pendingPrescription");
		return mv;
	}

	@RequestMapping(value = "/getPrescriptionList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPrescriptionList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPendingPrescriptionList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getPendingPrescriptionList",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getPrescriptionDetailJSP", method = RequestMethod.GET)
	public ModelAndView getPrescriptionDetailJSP(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "patientPrescription";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String headerId = request.getParameter("id");
		String payload = "{\"id\":\"" + headerId + "\"}";
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPrescriptionHeader");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, payload);
		// String responseData =
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getPrescriptionHeader",
		// requestHeaders, payload);
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/getPrescriptionDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPrescriptionDetail(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		String jsp = "patientPrescription";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPrescriptionDetail");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// String responseData =
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getPrescriptionDetail",
		// requestHeaders, data);
		return responseData;
	}

	@RequestMapping(value = "/getBatchDetails", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getBatchDetails(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getBatchDetails");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices//v0.1/dispencery/getBatchDetails",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/issueMedicineFromDispensary", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String issueMedicineFromDispensary(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "issueMedicineFromDispensary");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/issueMedicineFromDispensary",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/partialIssueWaitingJSP", method = RequestMethod.GET)
	public ModelAndView partialIssueWaitingJSP(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("partialIssueWaitingList");
		return mv;
	}

	@RequestMapping(value = "/getPartialWaitingList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPartialWaitingList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPartialWaitingList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getPartialWaitingList",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getPartialIssueHeader", method = RequestMethod.GET)
	public ModelAndView getPartialIssueHeader(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "partialIssueDetails";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String headerId = request.getParameter("id");
		String payload = "{\"id\":\"" + headerId + "\"}";
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPartialIssueHeader");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, payload);
		// String responseData =
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getPartialIssueHeader",
		// requestHeaders, payload);
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/getPartialIssueDetails", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPartialIssueDetails(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		String jsp = "partialIssueDetails";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPartialIssueDetails");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// String responseData =
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getPartialIssueDetails",
		// requestHeaders, data);
		return responseData;
	}

	@RequestMapping(value = "/partialIssueMedicineFromDispensary", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String partialIssueMedicineFromDispensary(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "partialIssueMediFromDispensary");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/partialIssueMedicineFromDispensary",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/partialIssueSubmit", method = RequestMethod.GET)
	public ModelAndView partialIssueSubmit(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("partialIssueSubmit");
		return mv;
	}

	@RequestMapping(value = "/indentIssueWaitingJSP", method = RequestMethod.GET)
	public ModelAndView indentIssueWaitingJSP(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("indentIsuueWaitingList");
		return mv;
	}

	@RequestMapping(value = "/indentIssueWaitingList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String indentIssueWaitingList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "indentIssueWaitingList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/indentIssueWaitingList",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getIndentIssueDetailJSP", method = RequestMethod.GET)
	public ModelAndView getIndentIssueHeader(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "indentIssueJsp";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String headerId = request.getParameter("Id");
		String payload = "{\"id\":\"" + headerId + "\"}";
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIndentIssueHeader");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, payload);
		// String responseData =
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getIndentIssueHeader",
		// requestHeaders, payload);
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/getIndentIssueDetails", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getIndentIssueDetails(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		String jsp = "indentIssueJsp";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIndentIssueDetails");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// String responseData =
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getIndentIssueDetails",
		// requestHeaders, data);
		return responseData;
	}

	@RequestMapping(value = "/indentIssue", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String indentIssue(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "indentIssue");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/indentIssue",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/dispensarySubmit", method = RequestMethod.GET)
	public ModelAndView dispensarySubmit(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dispensarySubmit");
		return mv;
	}

	@RequestMapping(value = "/indentSubmit", method = RequestMethod.GET)
	public ModelAndView indentSubmit(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("indentSubmit");
		return mv;
	}

	@RequestMapping(value = "/indentIssueReport", method = RequestMethod.GET)
	public ModelAndView indentIssueReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("indentIssueReport");
		return mv;
	}

	@RequestMapping(value = "/getIssuNoAndIndentNo", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getIssuNoAndIndentNo(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIssuNoAndIndentNo");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getIssuNoAndIndentNo",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/drugExpiryList", method = RequestMethod.GET)
	public ModelAndView drugExpiryList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("drugExpiryList");
		return mv;
	}
	
	@RequestMapping(value = "/drugExpiryListCo", method = RequestMethod.GET)
	public ModelAndView drugExpiryListCo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("drugExpiryListCo");
		return mv;
	}
	
	@RequestMapping(value = "/drugExpiryListDo", method = RequestMethod.GET)
	public ModelAndView drugExpiryListDo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("drugExpiryListDo");
		return mv;
	}

	@RequestMapping(value = "/getDrugExpiryList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getDrugExpiryList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDrugExpiryList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getDrugExpiryList",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getROLList", method = RequestMethod.GET)
	public ModelAndView getROLList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rolReport");
		return mv;
	}

	@RequestMapping(value = "/getROLDataList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getROLDataList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getROLDataList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getROLDataList",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getDispenaryReportList", method = RequestMethod.GET)
	public ModelAndView getDispenaryReportList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dispensaryReport");
		return mv;
	}

	@RequestMapping(value = "/getVisitListAndPrescriptionId", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getVisitListAndPrescriptionId(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getVisitListAndPrescriptionId");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getVisitListAndPrescriptionId",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getNISRegister", method = RequestMethod.GET)
	public ModelAndView getNISRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("nisRegister");
		return mv;
	}

	@RequestMapping(value = "/getNisRegisterData", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getNisRegisterData(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getNisRegisterData");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/getDailyIssueSummaryReport", method = RequestMethod.GET)
	public ModelAndView getDailyIssueSummaryReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dailyIssueSummaryReport");
		return mv;
	}

	@RequestMapping(value = "/getDailyIssueSummaryData", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getDailyIssueSummaryData(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDailyIssueSummaryData");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getDailyIssueSummaryData",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getDepartmentIdAgainstCode", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getDepartmentIdAgainstCode(@RequestBody String data) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDepartmentIdAgainstCode");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getDepartmentIdAgainstCode",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getItemTypeIdForPVMS", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getItemTypeIdForPVMS(@RequestBody String data) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getItemTypeId");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getItemTypeId",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/partialRegisteredPatient", method = RequestMethod.GET)
	public ModelAndView partialRegisteredPatient(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pendingCompleteRegistrationList");
		return mv;
	}

	@RequestMapping(value = "/partialRegisteredPatientList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String partialRegisteredPatientList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "partialRegisteredPatientList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/completePatientRegistration", method = RequestMethod.GET)
	public ModelAndView completePatientRegistration(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "completePatientRegistration";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String patientId = request.getParameter("id");
		String payload = "{\"id\":\"" + patientId + "\"}";
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getRegisteredPatientDetail");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, payload);
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/getDistrictList", method = RequestMethod.POST)
	public String getDistrictList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDistrictListForCH");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/getCityList", method = RequestMethod.POST)
	public String getCityListForCH(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCityListForCH");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/getReligionList", method = RequestMethod.POST)
	public String getReligionList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getReligionListForCH");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getBloodGroupList", method = RequestMethod.POST)
	public String getBloodGroupList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getBloodGroupListForCH");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getLabourTyeList", method = RequestMethod.POST)
	public String getLabourTyeList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getLabourTyeListForCH");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getIdentificationTypeList", method = RequestMethod.POST)
	public String getIdentificationTypeList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIdentificationTypeListForCH");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getWardListWithoutCity", method = RequestMethod.POST)
	public String getWardListWithoutCity(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWardListWithoutCity");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	// updateRegistrationDetail
	@RequestMapping(value = "/updateRegistrationDetail", method = RequestMethod.POST)
	public String updateRegistrationDetail(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "updateRegistrationDetail");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getRelationList", method = RequestMethod.POST)
	public String getRelationList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getRelationList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getMMUList", method = RequestMethod.POST)
	public String getMMUList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMMUList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/displayItemListCO", method = RequestMethod.GET)
	public ModelAndView displayItemListCO(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		String jsp = "displayItemListCO";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "displayItemListCO");
		String cityId = session.getAttribute("cityIdUsers").toString();
		cityId = cityId.replace(",", "");
		JSONObject payload = new JSONObject();
		payload.put("cityId", cityId);
		// String payload = "{}";
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders,
				payload.toString());
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/forwardToDisctrict", method = RequestMethod.POST)
	public String forwardToDisctrict(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "forwardToDisctrict");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/getIndentApprovalListForDO", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentApprovalListForDO(HttpServletRequest request, Model model,
			HttpServletResponse response, HttpSession session) {
		String indentListForApprovals = "";
		return new ModelAndView("indentApprovalListForDO", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getPendingListForDO", method = RequestMethod.POST)
	public String getPendingListForDO(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String indentList = "";
		JSONObject json = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPendingListForDO");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		return indentList;
	}

	@RequestMapping(value = "/getIndentDetailsApprovalForDO", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentDetailsApprovalForDO(HttpServletRequest request, Model model,
			HttpServletResponse response) {
		int indentId = Integer.parseInt(request.getParameter("indentCoMId"));
		String statusId = request.getParameter("indentStatus");
		//System.out.println("calling................................................");
		String jsp = "indentApprovalDetailDO";
		String indentListForApprovals = "";
		String payload = "{\"indentCoMId\":" + indentId + "}";
		//System.out.println("inside getIndentDetailsForApproval--" + payload);

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "indentValidationDO");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		// //System.out.println("jsonResponse " + jsonResponse);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("status", statusId);
		mv.setViewName(jsp);
		return mv;
	}

	//
	@RequestMapping(value = "/updateIndentDispenceryByDO", method = RequestMethod.POST)
	public String updateIndentDispenceryByDO(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		//System.out.println("updateIndentDispenceryByDO called");
		JSONObject json = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateIndentDispenceryByDO");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		return responseData;
	}

	@RequestMapping(value = "/indentSubmitByDO", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView indentSubmitByDO(HttpServletRequest request, Model model, HttpServletResponse response,
			HttpSession session) {
		ModelAndView mv = new ModelAndView();
		model.addAttribute("message", "Indent has been approved");
		model.addAttribute("flag", "approve");
		mv.setViewName("saveIndentDo");
		return mv;
	}

	@RequestMapping(value = "/displayItemListDO", method = RequestMethod.GET)
	public ModelAndView displayItemListDO(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		String jsp = "displayItemDO";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "displayItemListDO");
		String districtId = session.getAttribute("distIdUsers").toString();
		districtId = districtId.replace(",", "");
		JSONObject json = new JSONObject();
		json.put("districtId", districtId);
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders,
				json.toString());
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/getMmuWiseIndentList", method = RequestMethod.GET)
	public ModelAndView getMmuWiseIndentList(HttpServletRequest request, HttpServletResponse response) {
		int itemId = Integer.parseInt(request.getParameter("itemId"));
		String jsp = "mmuWiseIndentDetail";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMmuWiseIndentList");
		String payload = "{\"itemId\":" + itemId + "}";
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, payload);
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	// submitDoItemsAndGeneratePo
	@RequestMapping(value = "/submitDoItemsAndGeneratePo", method = RequestMethod.POST)
	public String submitDoItemsAndGeneratePo(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		JSONObject json = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitDoItemsAndGeneratePo");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		return responseData;
	}

	@RequestMapping(value = "/getMasSupplierList", method = RequestMethod.POST)
	public String getMasSupplierList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMasSupplierList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}
	
	@RequestMapping(value = "/getMasSupplierListNew", method = RequestMethod.POST)
	public String getMasSupplierListNew(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMasSupplierListNew");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/getMasSupplierTypeList", method = RequestMethod.POST)
	public String getMasSupplierTypeList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMasSupplierTypeList");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/getCityWiseIndentList", method = RequestMethod.GET)
	public ModelAndView getCityWiseIndentList(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		int itemId = Integer.parseInt(request.getParameter("itemId"));
		String jsp = "cityWiseIndentDetail";
		ModelAndView mv = new ModelAndView();
		// String payload = "{\"itemId\":" + itemId + "}";
		JSONObject obj = new JSONObject();
		String districtId = session.getAttribute("distIdUsers").toString();
		districtId = districtId.replace(",", "");
		// obj.put("districtId", session.getAttribute("districtId"));
		obj.put("districtId", districtId);
		obj.put("itemId", itemId);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCityWiseIndentList");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders,
				obj.toString());

		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/pendingRVList", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView pendingRVList(HttpServletRequest request, Model model, HttpServletResponse response,
			HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pendingRvList");
		return mv;
	}

	@RequestMapping(value = "/getRvWaitingList", method = RequestMethod.POST)
	public String getRvWaitingList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getRvWaitingList");
		//System.out.println("data is **************************** " + data);
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/rvDetail", method = RequestMethod.GET)
	public ModelAndView rvDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String jsp = "rvAgainstPO";
		ModelAndView mv = new ModelAndView();
		String id = request.getParameter("id");
		String payload = "{\"id\":" + id + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "rvDetail");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, payload);
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	@RequestMapping(value = "/pendingIndentIssueWaitingListDo", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView pendingIndentIssueWaitingList(HttpServletRequest request, Model model,
			HttpServletResponse response, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("indentIssueWaitingListDo");
		return mv;
	}

	@RequestMapping(value = "/indentIssueWaitingListDO", method = RequestMethod.POST)
	public String indentIssueWaitingListDO(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "indentIssueWaitingListForDO");
		//System.out.println("data is **************************** " + data + " OSBURL" + OSBURL);
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
	}

	@RequestMapping(value = "/getIndentIssueDetailJSPForDo", method = RequestMethod.GET)
	public ModelAndView getIndentIssueDetailJSPForDo(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "indentIssueDoJsp";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String headerId = request.getParameter("id");
		String payload = "{\"id\":\"" + headerId + "\"}";
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIndentIssueHeaderDo");
		//System.out.println("payload " + payload);
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, payload);
		mv.setViewName(jsp);
		mv.addObject("response", responseData);
		return mv;
	}

	// submitRvDetailAgainstPo
	@RequestMapping(value = "/submitRvDetailAgainstPo", method = RequestMethod.POST)
	public String submitRvDetailAgainstPo(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		JSONObject json = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitRvDetailAgainstPo");
		String OSBURL = IpAndPortNo + Url;
		String responseData = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		return responseData;
	}

	@RequestMapping(value = "/getIndentIssueDetailsDo", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getIndentIssueDetailsDo(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		String jsp = "indentIssueDoJsp";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIndentIssueDetailsDo");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// String responseData =
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/getIndentIssueDetails",
		// requestHeaders, data);
		return responseData;
	}

	@RequestMapping(value = "/indentIssueDo", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String indentIssueDo(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "indentIssueDo");
		return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/dispencery/indentIssue",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/dispensarySubmitDo", method = RequestMethod.GET)
	public ModelAndView dispensarySubmitDo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dispensarySubmit");
		return mv;
	}

	@RequestMapping(value = "/rvDetailsAgainstSo", method = RequestMethod.GET)
	public ModelAndView rvDetailsAgainstSo(HttpServletRequest request, HttpServletResponse response) {
		String headerId = request.getParameter("id");
		String data = "{\"headerId\":" + headerId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_SUPPLY_ORDER_DETAILS_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,data);
		
		String jsp = "rvAgainstSO";
		return new ModelAndView(jsp, "jsonResponse", jsonResponse);

	}

	@RequestMapping(value = "/submitRVAgainstSO", method = RequestMethod.POST)
	  public ModelAndView submitRVAgainstSO(HttpServletRequest request, HttpServletResponse response) {
		String message="";
		long grnMId=0;
		Map<String,Object> map = new HashMap<String, Object>();
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUBMIT_RV_AGAINST_SUPPLY_ORDER");
		String OSBURL = IpAndPortNo + Url;
		String jsonResponse=  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data.toString());
	    
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	message =  responseData.getString("message");
	    	grnMId = responseData.getLong("grnMId");
	    	map.put("message",message);
	    	map.put("grnMId",grnMId);
	    }
	    return new ModelAndView("successRvAgainstSo", "map", map);
	  }	 
	
	@RequestMapping(value = "/indentSubmitDo", method = RequestMethod.GET)
	public ModelAndView indentSubmitDo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("indentSubmitDo");
		return mv;
	}
	
	@RequestMapping(value = "/getIndentForTrackingCo", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentForTrackingCo(HttpServletRequest request, Model model, HttpServletResponse response) {
		String indentListForApprovals = "";
		return new ModelAndView("indentListForTrackingCo", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getIndentListForTrackingCo", method = RequestMethod.POST)
	public String getIndentListForTrackingCo(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		//System.out.println("inside getIndentListForTracking--");

		String indentList = "";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		String cityId = session.getAttribute("cityIdUsers").toString();
		cityId = cityId.substring(0, cityId.length()-1);
		
		json.put("cityId", cityId);		
		json.put("departmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());
		//System.out.println("inside getIndentListForTracking--" + json);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentListForTrackingCo");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		return indentList;
	}
	
	@RequestMapping(value = "/getIndentForTrackingDo", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView getIndentForTrackingDo(HttpServletRequest request, Model model, HttpServletResponse response) {
		String indentListForApprovals = "";
		return new ModelAndView("indentListForTrackingDo", "indentListForApprovals", indentListForApprovals);
	}

	@RequestMapping(value = "/getIndentListForTrackingDo", method = RequestMethod.POST)
	public String getIndentListForTrackingDo(@RequestBody Map<String, Object> payload, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		//System.out.println("inside getIndentListForTracking--");

		String indentList = "";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		String distId = session.getAttribute("distIdUsers").toString();
		distId = distId.substring(0, distId.length()-1);
		
		json.put("districtId", distId);		
		json.put("departmentId", HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim());
		//System.out.println("inside getIndentListForTracking--" + json);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getIndentListForTrackingDo");
		String OSBURL = IpAndPortNo + Url;
		indentList = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, json.toString());

		return indentList;
	}
	
	@RequestMapping(value = "/unitRate", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView unitRate(HttpServletRequest request, Model model, HttpServletResponse response) {
		String indentListForApprovals = "";
		return new ModelAndView("updateUnitRate", "updateUnitRate", indentListForApprovals);
	}
	
	@RequestMapping(value = "/getDrugList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getDrugList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDrugList");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		return responseData;
	}
	
	@RequestMapping(value = "/updateUnitRate", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String updateUnitRate(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "updateUnitRate");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		return responseData;
	}
	
	@RequestMapping(value = "/directPo", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView directPo(HttpServletRequest request, Model model,
			HttpServletResponse response, HttpSession session) {
		String indentListForApprovals = "";
		return new ModelAndView("directPo", "directPo", indentListForApprovals);
	}

}
