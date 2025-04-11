package com.mmu.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.entity.RidcEntity;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RequestMapping("/lpprocess")
@RestController
@CrossOrigin
public class LPProcessWebController {
	String IpAndPortNo = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT").trim();

////------------------------Create Requirement For Budgetry Approval--------------------------------//	
	@RequestMapping(value = "/createRequirementForBudgetry", method = RequestMethod.GET)
	public ModelAndView createRequirementForBudgetry(HttpServletRequest request,	HttpServletResponse response,Model model) {
		//System.out.println("createRequirementForBudgetry called");
		String jsp = "createRequirementForBudgetry";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	
	//submit form
	
	@RequestMapping(value = "/submitBudgetaryApproval", method = RequestMethod.POST)
	public ModelAndView submitBudgetaryApproval(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
		
		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		obj.put("userId", session.getAttribute("user_id"));
		obj.put("hospitalId", session.getAttribute("hospital_id"));
		obj.put("departmentId",session.getAttribute("department_id"));
		//System.out.println("submitBudgetary--"+obj);
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
	    String Url = HMSUtil.getProperties("urlextension.properties","submitBudgetary");
	    String OSBURL = IpAndPortNo + Url;
		String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
		//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/submitBudgetary",requestHeaders, obj.toString());
		JSONObject responsedata = new JSONObject(responseData);
		ModelAndView mv = new ModelAndView();
		String jsp = "printBudgetryApproval";
		model.addAttribute("message", responsedata.get("msg"));
		model.addAttribute("budgetaryId",responsedata.get("budgetaryId"));
		model.addAttribute("flag","save");
		mv.setViewName(jsp);
		return mv;

	}
	
	
	//list of pending budgetaryApprovalList
	
		@RequestMapping(value="/budgetaryApprovalList", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView budgetaryApprovalList(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			String budgetaryListForApproval="";
			return new ModelAndView("budgetaryListForApproval", "budgetaryListForApproval", budgetaryListForApproval);
		}
		
		@RequestMapping(value = "/getBudgetaryApprovalList", method = RequestMethod.POST)
		public String getBudgetaryApprovalList(@RequestBody Map<String, Object> payload,
				HttpServletRequest request, HttpServletResponse response,HttpSession session) {
			
		String budgetaryList="";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		json.put("hospitalId", session.getAttribute("hospital_id"));
		json.put("departmentId",session.getAttribute("department_id"));
		//System.out.println("inside getBudgetaryApprovalList--"+json);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url=HMSUtil.getProperties("urlextension.properties","getBudgetaryApprovalList");
		String OSBURL = IpAndPortNo + Url;
		budgetaryList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
		
		//budgetaryList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getBudgetaryApprovalList",requestHeaders, json.toString());
				
		return  budgetaryList;
		}
		
		// budgetaryApprovalList details
		
		
		@RequestMapping(value="/getBudgetaryDetailsForMOApproval", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView getBudgetarDetailsForMOApproval(HttpServletRequest request,Model model,HttpServletResponse response) {
			int budgetaryId = Integer.parseInt(request.getParameter("budgetaryId"));
			 String budgetaryStatus = request.getParameter("budgetaryStatus");
			String jsp = "budgetaryMOApproval";
			//String indentListForApprovals="";
			String payload = "{\"budgetaryId\":" + budgetaryId + "}";
			//System.out.println("inside getBudgetarDetailsForMOApproval--"+payload);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		    String Url=HMSUtil.getProperties("urlextension.properties","getBudgetaryDetails");
			String OSBURL = IpAndPortNo + Url;
			String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,payload);
			
			//String jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getBudgetaryDetails",requestHeaders,payload);
			
			//System.out.println("jsonResponse getBudgetarDetailsForMOApproval " + jsonResponse);
			ModelAndView mv = new ModelAndView();
			mv.addObject("data", jsonResponse);
			mv.addObject("status", budgetaryId);
			mv.addObject("budgetaryId", budgetaryId);
			mv.setViewName(jsp);
			return mv;
		}
		
		
		@RequestMapping(value = "/moBudgetaryApproval", method = RequestMethod.POST)
		public ModelAndView moBudgetaryApproval(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
			
			Box box = HMSUtil.getBox(request);
			JSONObject obj = new JSONObject(box);
			obj.put("userId", session.getAttribute("user_id"));
			obj.put("hospitalId", session.getAttribute("hospital_id"));
			
			//System.out.println("moBudgetaryApproval--"+obj);
			
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","moBudgetaryApproval");
			String OSBURL = IpAndPortNo + Url;
			String responseData = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
			
			//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/moBudgetaryApproval",requestHeaders, obj.toString());
			 JSONObject responsedata = new JSONObject(responseData);
			ModelAndView mv = new ModelAndView();
			String jsp = "printBudgetryApproval";
			model.addAttribute("message", responsedata.get("msg"));
			model.addAttribute("budgetaryId",responsedata.get("budMId"));
			model.addAttribute("flag","update");
			mv.setViewName(jsp);
			return mv;

		}
		
		@RequestMapping(value="/budgetaryApprovalByMOList", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView budgetaryApprovalByMOList(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			String budgetaryApprovalByMOTrackingList="";
			return new ModelAndView("budgetaryApprovalByMOTrackingList", "budgetaryApprovalByMOTrackingList", budgetaryApprovalByMOTrackingList);
		}
		
		
		
		@RequestMapping(value="/getBudgetaryDetailsForMOTracking", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView getBudgetaryDetailsForMOTracking(HttpServletRequest request,Model model,HttpServletResponse response) {
			int budgetaryId = Integer.parseInt(request.getParameter("budgetaryId"));
			 String budgetaryStatus = request.getParameter("budgetaryStatus");
			String jsp = "viewMOBudgetaryApprovalDetails";
			//String indentListForApprovals="";
			String payload = "{\"budgetaryId\":" + budgetaryId + "}";
			//System.out.println("inside getBudgetaryDetailsForMOTracking--"+payload);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		    String Url=HMSUtil.getProperties("urlextension.properties","getBudgetaryDetails");
			String OSBURL = IpAndPortNo + Url;
			String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,payload);
			
			//String jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getBudgetaryDetails",requestHeaders,payload);
			
			//System.out.println("jsonResponse getBudgetaryDetailsForMOTracking " + jsonResponse);
			ModelAndView mv = new ModelAndView();
			mv.addObject("data", jsonResponse);
			mv.addObject("status", budgetaryId);
			mv.addObject("budgetaryId", budgetaryId);
			if(budgetaryStatus.equalsIgnoreCase("flag"))
				mv.addObject("flag", budgetaryStatus);
			else
				mv.addObject("flag", "no");
			mv.setViewName(jsp);
			return mv;
		}
		
		
		
		@RequestMapping(value="/budgetaryApprovalListForCO", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView budgetaryApprovalListForCO(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			String budgetaryApprovalListForCO="";
			return new ModelAndView("budgetaryApprovalListForCO", "budgetaryApprovalListForCO", budgetaryApprovalListForCO);
		}
		
		
		@RequestMapping(value="/getBudgetaryDetailsForCOApproval", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView getBudgetaryDetailsForCOApproval(HttpServletRequest request,Model model,HttpServletResponse response) {
			int budgetaryId = Integer.parseInt(request.getParameter("budgetaryId"));
			 String budgetaryStatus = request.getParameter("budgetaryStatus");
			String jsp = "budgetaryCOApproval";
			//String indentListForApprovals="";
			String payload = "{\"budgetaryId\":" + budgetaryId + "}";
			//System.out.println("inside getBudgetaryDetailsForCOApproval--"+payload);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		    String Url=HMSUtil.getProperties("urlextension.properties","getBudgetaryDetails");
			String OSBURL = IpAndPortNo + Url;
			String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,payload);
			
			//String jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getBudgetaryDetails",requestHeaders,payload);
			
			//System.out.println("jsonResponse getBudgetaryDetailsForCOApproval " + jsonResponse);
			ModelAndView mv = new ModelAndView();
			mv.addObject("data", jsonResponse);
			mv.addObject("status", budgetaryId);
			mv.addObject("budgetaryId", budgetaryId);
			mv.setViewName(jsp);
			return mv;
		}
		
		
		@RequestMapping(value = "/coBudgetaryApproval", method = RequestMethod.POST)
		public ModelAndView coBudgetaryApproval(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
			
			Box box = HMSUtil.getBox(request);
			JSONObject obj = new JSONObject(box);
			obj.put("userId", session.getAttribute("user_id"));
			obj.put("hospitalId", session.getAttribute("hospital_id"));
			obj.put("departmentId",session.getAttribute("department_id"));
			
			//System.out.println("coBudgetaryApproval--"+obj);
			
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","moBudgetaryApproval");
			String OSBURL = IpAndPortNo + Url;
			String responseData = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
			
			//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/moBudgetaryApproval",requestHeaders, obj.toString());
			 JSONObject responsedata = new JSONObject(responseData);
			ModelAndView mv = new ModelAndView();
			String jsp = "printBudgetryApproval";
			model.addAttribute("message", responsedata.get("msg"));
			model.addAttribute("budgetaryId",responsedata.get("budMId"));
			model.addAttribute("flag","coApproval");
			mv.setViewName(jsp);
			return mv;

		}
		
		@RequestMapping(value="/budgetaryApprovalListSALogistic", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView budgetaryApprovalListSALogistic(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			String budgetaryApprovalListSALogistic="";
			return new ModelAndView("budgetaryApprovalListSALogistic", "budgetaryApprovalListSALogistic", budgetaryApprovalListSALogistic);
		}
		
		//---------------------Delete Budgetary items------------------------------//
		
		@RequestMapping(value="/deleteBudgetaryItems", method = {RequestMethod.POST})
		public String deleteIndentItems(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response) {
			String jsonResponse = "";
			//JSONObject json = new JSONObject(requestObject);
			//System.out.println("inside deleteBudgetaryItems--"+requestObject);
			
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url=HMSUtil.getProperties("urlextension.properties","deleteBudgetaryItems");
			String OSBURL = IpAndPortNo + Url;
			jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,requestObject);
			
		   //jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/deleteBudgetaryItems",requestHeaders,requestObject);
		   return jsonResponse;
			
		}
		
		
		@RequestMapping(value="/enterQuotationForBudgetary", method = RequestMethod.GET)
		public ModelAndView enterQuotationForBudgetary(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			MultiValueMap<String, String> requestHeaders1 = new LinkedMultiValueMap<String, String>();
			String lpTypeFlag="";
			String jsp="";
			int budgetaryId = Integer.parseInt(request.getParameter("budgetaryId"));
			String budgetaryStatus = request.getParameter("budgetaryStatus");
			String payload = "{\"budgetaryId\":" + budgetaryId + "}";
			
		    String Url=HMSUtil.getProperties("urlextension.properties","getBudgetaryDetails");
			String OSBURL = IpAndPortNo + Url;
			String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,payload);
			//String jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getBudgetaryDetails",requestHeaders,payload);
			
		/*
		 * if(!jsonResponse.isEmpty()) { JSONObject responseData = new
		 * JSONObject(jsonResponse); lpTypeFlag =
		 * responseData.get("lpTypeFlag").toString(); }
		 */
			
			
			JSONObject data = new JSONObject();
			data.put("hospitalId", session.getAttribute("hospital_id"));
			String Url1=HMSUtil.getProperties("urlextension.properties","getVenderList");
			String OSBURL1 = IpAndPortNo + Url1;
			String venderList = RestUtils.postWithHeaders(OSBURL1.trim(),requestHeaders1,data.toString());
			//String venderList=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getVenderList",requestHeaders1,data.toString());
			
			//System.out.println("jsonResponse enterQuotationForBudgetary " + jsonResponse);
		/*
		 * if(!lpTypeFlag.isEmpty() && lpTypeFlag.equalsIgnoreCase("B")) { jsp =
		 * "enterQuotationAgainstBudgetaryBackLP"; }else { jsp =
		 * "enterQuotationAgainstBudApp"; }
		 */
			jsp = "enterQuotationAgainstBudApp";
			ModelAndView mv = new ModelAndView();
			mv.addObject("data", jsonResponse);
		
			mv.addObject("status", budgetaryStatus);
			mv.addObject("budgetaryId", budgetaryId); 
			mv.addObject("venderList", venderList);
		
			mv.setViewName(jsp);
			return mv;
		}
		
		
		
		//submit  submitQuotation
		
		@RequestMapping(value = "/submitQuotation", method = RequestMethod.POST)
		public ModelAndView submitQuotation(MultipartHttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
			
			Box box = HMSUtil.getBox(request);
			JSONObject obj = new JSONObject(box);
			obj.put("userId", session.getAttribute("user_id"));
			obj.put("hospitalId", session.getAttribute("hospital_id"));
			obj.put("departmentId",session.getAttribute("department_id"));
			//System.out.println("submitQuotation--"+obj);
			
			//File upload code
			String hospitalName = session.getAttribute("hospital_Name").toString();
			//int docType = RIDCUtils.DOC_TYPE_DIS;
			int year = Calendar.getInstance().get(Calendar.YEAR);
			
			String ridcIdValues = "";
			String fileNameValue = "";
			String rmsAllValue = "";
			String data = "";
			String referalRmsId = "";
			String meRmsId = "";
			Iterator<String> itr = request.getFileNames();
			Integer ridcIdVv = 1;
			try {
				while (itr.hasNext()) {
					MultipartFile file = request.getFile(itr.next());

					InputStream inputStream = null;
					String name = null, contentType = null;
					long size = 0;
					try {
						inputStream = file.getInputStream();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					name = file.getName();
					size = file.getSize();
					contentType = file.getContentType();
					String myFileName = file.getOriginalFilename();
					File convFile = new File(file.getOriginalFilename());
					 convFile.createNewFile();
					 FileOutputStream fos = new FileOutputStream(convFile);
					 fos.write(file.getBytes());
					 fos.close();
					
					RidcEntity ridcDoc = null;
					HashMap<String,String> info=new HashMap<String,String>();
					
					info.put("year", String.valueOf(year));
					info.put("location", hospitalName);
					info.put("type", "2");
					//info.put("docType", String.valueOf(docType));
					//System.out.println("info"+info);
					if (size == 0) {
						rmsAllValue += size + ",";
					}
					if (StringUtils.isNotEmpty(myFileName)) {

						//ridcDoc = PatientRegistrationWebController.getRidcEntityByValue(inputStream, myFileName, size,contentType);
						// ridcDoc = RIDCUtils.getRidcEntityByValueOtherDocs(inputStream, myFileName, size, contentType,info);
						 ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
						String ridcId = PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
						ridcIdValues += "" + ridcId + ",";
						fileNameValue += "" + myFileName + ",";
						rmsAllValue += "" + ridcId + ",";
					}
				}
			} catch (Exception e) {
				JSONObject json = new JSONObject();
				e.printStackTrace();
			}
			obj.put("ridcId",ridcIdValues);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		    String Url = HMSUtil.getProperties("urlextension.properties","submitQuotation");
		    String OSBURL = IpAndPortNo + Url;
		    String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
		    //String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/submitQuotation",requestHeaders, obj.toString());
			JSONObject responsedata = new JSONObject(responseData);
			ModelAndView mv = new ModelAndView();
			String jsp = "printBudgetryApproval";
			model.addAttribute("message", responsedata.get("msg"));
			model.addAttribute("quotationMId",responsedata.get("quotationMId"));
			model.addAttribute("flag","submitQutotation");
			mv.setViewName(jsp);
			return mv;

		}
		
		
		@RequestMapping(value="/quotationApprovalListlpc", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView quotationApprovalListlpc(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			String quotationApprovalList="";
			return new ModelAndView("quotationApprovalList", "quotationApprovalList", quotationApprovalList);
		}
		
		
		
		@RequestMapping(value = "/getQuotationForApprovalList", method = RequestMethod.POST)
		public String getQuotationForApprovalList(@RequestBody Map<String, Object> payload,
				HttpServletRequest request, HttpServletResponse response,HttpSession session) {
			
		String quotationList="";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		json.put("hospitalId", session.getAttribute("hospital_id"));
		json.put("departmentId",session.getAttribute("department_id"));
		//System.out.println("inside getQuotationForApprovalList--"+json);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url=HMSUtil.getProperties("urlextension.properties","getQuotationForApprovalList");
		String OSBURL = IpAndPortNo + Url;
		quotationList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
		//quotationList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getQuotationForApprovalList",requestHeaders, json.toString());
				
		return  quotationList;
		}
		
		
		//CTM for LP committee
		
		
		@RequestMapping(value = "/ctmForLpCommittee", method = RequestMethod.GET)
		public ModelAndView ctmForLpCommittee(HttpServletRequest request,HttpServletResponse response,Model model) {
			//System.out.println("ctmForLpCommittee called");
			
			String jsp = "ctmForLpCommittee";
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
		}
		
		@RequestMapping(value = "/getCTMmemberList", method = RequestMethod.POST)
		public String getCTMmemberList(@RequestBody Map<String, Object> payload,
				HttpServletRequest request, HttpServletResponse response,HttpSession session) {
			
			
		String ctmMemberList="";
		
		JSONObject json = new JSONObject(payload);
		json.put("hospitalId", session.getAttribute("hospital_id"));
		//System.out.println("inside getCTMmemberList--"+json);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url=HMSUtil.getProperties("urlextension.properties","getAllCtmCommittee");
		String OSBURL = IpAndPortNo + Url;
		ctmMemberList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
		
		//ctmMemberList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getAllCtmCommittee",requestHeaders, json.toString());
			
		return  ctmMemberList;
		}
		
		//Get emp data by serviceNo
		@RequestMapping(value="/getNameByServiceNo", method = {RequestMethod.POST})
		public String getNameByServiceNo(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response) {
			String jsonResponse = "";
			//JSONObject json = new JSONObject(requestObject);
			//System.out.println("inside getNameByServiceNo--"+requestObject);
			
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url=HMSUtil.getProperties("urlextension.properties","getNameByServiceNo");
			String OSBURL = IpAndPortNo + Url;
			jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,requestObject);
			
			//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getNameByServiceNo",requestHeaders,requestObject);
		   return jsonResponse;
			
		}
		
		//submit form
		
		@RequestMapping(value = "/submitCtmForLP", method = RequestMethod.POST)
		public ModelAndView submitCtmForLP(MultipartHttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
			
			Box box = HMSUtil.getBox(request);
			JSONObject obj = new JSONObject(box);
			obj.put("userId", session.getAttribute("user_id"));
			obj.put("hospitalId", session.getAttribute("hospital_id"));
			obj.put("departmentId",session.getAttribute("department_id"));
			//System.out.println("submitCtmForLP--"+obj);
			//File upload code
			String hospitalName = session.getAttribute("hospital_Name").toString();
			//int docType = RIDCUtils.DOC_TYPE_DIS;
			int year = Calendar.getInstance().get(Calendar.YEAR);
			String ridcIdValues = "";
			String fileNameValue = "";
			String rmsAllValue = "";
			Iterator<String> itr = request.getFileNames();
			Integer ridcIdVv = 1;
			String ridcId ="";
			try {
				while (itr.hasNext()) {
					MultipartFile file = request.getFile(itr.next());

					InputStream inputStream = null;
					String name = null, contentType = null;
					long size = 0;
					try {
						inputStream = file.getInputStream();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					name = file.getName();
					size = file.getSize();
					contentType = file.getContentType();
					String myFileName = file.getOriginalFilename();
					RidcEntity ridcDoc = null;
					
					HashMap<String,String> info=new HashMap<String,String>();
					info.put("year", String.valueOf(year));
					info.put("location", hospitalName);
					info.put("type", "2");
					//info.put("docType", String.valueOf(docType));
					File convFile = new File(file.getOriginalFilename());
					 convFile.createNewFile();
					 FileOutputStream fos = new FileOutputStream(convFile);
					 fos.write(file.getBytes());
					 fos.close();
					//System.out.println("info"+info);
					if (size == 0) {
						rmsAllValue += size + ",";
					}
					if (StringUtils.isNotEmpty(myFileName)) {

						//ridcDoc = PatientRegistrationWebController.getRidcEntityByValue(inputStream, myFileName, size,contentType);
						 //ridcDoc = RIDCUtils.getRidcEntityByValueOtherDocs(inputStream, myFileName, size, contentType,info);
						 ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
						 ridcId = PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
					}
				}
				} catch (Exception e) {
					JSONObject json = new JSONObject();
					e.printStackTrace();
				}
			obj.put("ridcId",ridcId);
			//End file upload
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		    String Url = HMSUtil.getProperties("urlextension.properties","submitCtmForLP");
			 String OSBURL = IpAndPortNo + Url;
			 String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
			 //String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/submitCtmForLP",requestHeaders, obj.toString());
			 JSONObject responsedata = new JSONObject(responseData);
			ModelAndView mv = new ModelAndView();
			String jsp = "ctmForLpCommittee";
			model.addAttribute("message", responsedata.get("msg"));
			if(responsedata.has("masStoreLpcId"))
			model.addAttribute("masStoreLpcId",responsedata.get("masStoreLpcId"));
			mv.setViewName(jsp);
			return mv;

		}
		
		@RequestMapping(value="/inactivatectmCommittee", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView inactivatectmCommittee(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			int lpcId = Integer.parseInt(request.getParameter("lpcId"));
			 String status = request.getParameter("status");
			String jsp = "ctmForLpCommittee";
			JSONObject obj = new JSONObject();
			obj.put("userId", session.getAttribute("user_id"));
			obj.put("lpcId", lpcId);
			String payload = "{\"lpcId\":" + lpcId + "}";
			//System.out.println("inside inactivatectmCommittee--"+payload);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			 String Url=HMSUtil.getProperties("urlextension.properties","inactivatectmCommittee");
			String OSBURL = IpAndPortNo + Url;
			String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
			
			//String jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/inactivatectmCommittee",requestHeaders,obj.toString());
			 JSONObject responsedata = new JSONObject(jsonResponse);
			model.addAttribute("message", responsedata.get("msg"));
			ModelAndView mv = new ModelAndView();
			mv.setViewName(jsp);
			return mv;
		}
		
		
	//Approval Quotation	
		@RequestMapping(value="/approveQuotation", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView approveQuotation(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			int budgetaryId = Integer.parseInt(request.getParameter("budgetaryId"));
			String lpTypeId = request.getParameter("lpTypeId");
			String jsp = "approvalQuotation";
			 JSONObject requestObject = new JSONObject();
			 requestObject.put("hospitalId", session.getAttribute("hospital_id"));
			String payload = "{\"budgetaryId\":" + budgetaryId + "}";
			
			//String requestObject= "{}";
			//System.out.println("inside approveQuotation--"+payload);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		    String Url=HMSUtil.getProperties("urlextension.properties","getCommitteeMember");
			String OSBURL = IpAndPortNo + Url;
			String memberlist = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,requestObject.toString());
			//String memberlist=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getCommitteeMember",requestHeaders,requestObject.toString());
			
			MultiValueMap<String, String> requestHeaders1 = new LinkedMultiValueMap<String, String>();
		    String Url1=HMSUtil.getProperties("urlextension.properties","getItemList");
			String OSBURL1 = IpAndPortNo + Url1;
			String jsonResponse = RestUtils.postWithHeaders(OSBURL1.trim(),requestHeaders1,payload);
			//String jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getItemList",requestHeaders,payload);
			
			//System.out.println("jsonResponse approveQuotation " + jsonResponse);
			ModelAndView mv = new ModelAndView();
			mv.addObject("data", jsonResponse);
			mv.addObject("budgetaryId", budgetaryId);
			mv.addObject("lpTypeCode", lpTypeId);
			mv.addObject("memberlist", memberlist);
			mv.setViewName(jsp);
			return mv;
		}
		
		
				//approve Quotation
		
				@RequestMapping(value = "/approveQuotationPresident", method = RequestMethod.POST)
				public ModelAndView approveQuotationPresident(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("approveQuotationPresident--"+obj);
					
					String lpTypeCode = String.valueOf(obj.get("lpTypeCode"));
		
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","approveQuotationPresident");
					 String OSBURL = IpAndPortNo + Url;
					 String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					 //String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/approveQuotationPresident",requestHeaders, obj.toString());
					 JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printBudgetryApproval";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("quotationMId",responsedata.get("quotationMId"));
					model.addAttribute("flag","qApprove");
					model.addAttribute("lpTypeId",responsedata.get("lpTypeId"));
					mv.setViewName(jsp);
					return mv;

				}
				
				
				@RequestMapping(value = "/pendingListForSanctionOrder", method = RequestMethod.GET)
				public ModelAndView pendingListForSanctionOrder(HttpServletRequest request,	HttpServletResponse response,Model model) {
					//System.out.println("createSanctionOrder called");
					String jsp = "pendingListForSanctionOrder";
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}
				
				
				@RequestMapping(value="/createSanctionOrder", method = {RequestMethod.GET,RequestMethod.POST})
				public ModelAndView createSanctionOrder(HttpServletRequest request,HttpServletResponse response,Model model) {
					
				int budgetaryId = Integer.parseInt(request.getParameter("budgetaryId"));
				int storeQMId = Integer.parseInt(request.getParameter("storeQMId"));
				String status = request.getParameter("status");
				String jsp = "createSanctionOrder";
				String payload = "{\"budgetaryId\":" + budgetaryId + ",\"storeQMId\":" + storeQMId +",\"status\":"+status+"}";
				 
				Box box = HMSUtil.getBox(request);
				JSONObject obj = new JSONObject(box);
				obj.put("budgetaryId", budgetaryId);
				obj.put("storeQMId", storeQMId);
				obj.put("status",status);
				//System.out.println("inside createSanctionOrder--"+payload);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url1=HMSUtil.getProperties("urlextension.properties","getItemListForSanctionOrder");
				String OSBURL1 = IpAndPortNo + Url1;
				String jsonResponse = RestUtils.postWithHeaders(OSBURL1.trim(),requestHeaders,obj.toString());
				//String jsonResponse = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getItemListForSanctionOrder",requestHeaders, obj.toString());
				////System.out.println("jsonResponse enterQuotationForBudgetary " + jsonResponse);
				ModelAndView mv = new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
				}
				
				
				@RequestMapping(value = "/submitSanctionOrder", method = RequestMethod.POST)
				public ModelAndView submitSanctionOrder(MultipartHttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitSanctionOrder--"+obj);
					//File upload code
					String hospitalName = session.getAttribute("hospital_Name").toString();
					//int docType = RIDCUtils.DOC_TYPE_DIS;
					int year = Calendar.getInstance().get(Calendar.YEAR);
					String ridcIdValues = "";
					String fileNameValue = "";
					String rmsAllValue = "";
					Iterator<String> itr = request.getFileNames();
					Integer ridcIdVv = 1;
					String ridcId ="";
					try {
						while (itr.hasNext()) {
							MultipartFile file = request.getFile(itr.next());

							InputStream inputStream = null;
							String name = null, contentType = null;
							long size = 0;
							try {
								inputStream = file.getInputStream();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							name = file.getName();
							size = file.getSize();
							contentType = file.getContentType();
							String myFileName = file.getOriginalFilename();
							RidcEntity ridcDoc = null;
							HashMap<String,String> info=new HashMap<String,String>();
							info.put("year", String.valueOf(year));
							info.put("location", hospitalName);
							info.put("type", "2");
							//info.put("docType", String.valueOf(docType));
							File convFile = new File(file.getOriginalFilename());
							 convFile.createNewFile();
							 FileOutputStream fos = new FileOutputStream(convFile);
							 fos.write(file.getBytes());
							 fos.close();
							//System.out.println("info"+info);
							if (size == 0) {
								rmsAllValue += size + ",";
							}
							if (StringUtils.isNotEmpty(myFileName)) {

								//ridcDoc = PatientRegistrationWebController.getRidcEntityByValue(inputStream, myFileName, size,contentType);
								//ridcDoc = RIDCUtils.getRidcEntityByValueOtherDocs(inputStream, myFileName, size, contentType,info);
								ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
								ridcId = PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
							}
						}
						} catch (Exception e) {
							JSONObject json = new JSONObject();
							e.printStackTrace();
						}
					obj.put("ridcId",ridcId);
					//End file upload
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitSanctionOrder");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/submitSanctionOrder",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printBudgetryApproval";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("storeSoMId",responsedata.get("storeSoMId"));
					model.addAttribute("flag","submitSanction");
					mv.setViewName(jsp);
					return mv;

				}
				
				
				@RequestMapping(value = "/pendingListForSanctionApproval", method = RequestMethod.GET)
				public ModelAndView pendingListForSanctionApproval(HttpServletRequest request,	HttpServletResponse response,Model model) {
					//System.out.println("pendingListForSanctionApproval called");
					String jsp = "pendingListForSanctionApproval";
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}
				
				@RequestMapping(value = "/getSanctionListForApproval", method = RequestMethod.POST)
				public String getSanctionListForApproval(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String sanctionList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getSanctionListForApproval--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getSanctionListForApproval");
				String OSBURL = IpAndPortNo + Url;
				sanctionList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//sanctionList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getSanctionListForApproval",requestHeaders, json.toString());
						
				return  sanctionList;
				}
				
			
				@RequestMapping(value="/approveSanctionOrderDetails", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView approveSanctionOrderDetails(HttpServletRequest request,Model model,HttpServletResponse response) {
				//int storeSoMId = Integer.parseInt(request.getParameter("storeSoMId"));
					long storeSoMId = Long.parseLong(request.getParameter("storeSoMId"));
				String flag = request.getParameter("flag");
				String jsp = "approveSanctionOrder";
				String payload = "{\"storeSoMId\":" + storeSoMId + "}";
				//System.out.println("inside approveSanctionOrderDetails--"+payload);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url1=HMSUtil.getProperties("urlextension.properties","approveSanctionOrderDetails");
				String OSBURL1 = IpAndPortNo + Url1;
				String jsonResponse = RestUtils.postWithHeaders(OSBURL1.trim(),requestHeaders,payload);
				
				//String jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/approveSanctionOrderDetails",requestHeaders,payload);
				ModelAndView mv = new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.addObject("flag", flag);
				mv.setViewName(jsp);
				return mv;
				}
				
				
				@RequestMapping(value = "/approveSanctionOrder", method = RequestMethod.POST)
				public ModelAndView approveSanctionOrder(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("approveSanctionOrder--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","approveSanctionOrder");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/approveSanctionOrder",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printBudgetryApproval";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("storeSoMId",responsedata.get("storeSoMId"));
					model.addAttribute("flag","sanctionApprove");
					mv.setViewName(jsp);
					return mv;

				}
				
				
				@RequestMapping(value="/getLpRateByItemId", method = {RequestMethod.POST})
				public String getLpRateByItemId(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					String jsonResponse = "";
					JSONObject obj = new JSONObject(requestObject);
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("inside getLpRateByItemId--"+requestObject);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","getLpRateByItemId");
					String OSBURL = IpAndPortNo + Url;
					jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					
					//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getLpRateByItemId",requestHeaders,obj.toString());
				   return jsonResponse;
					
				}
				
				
				//FUND UTILIzation
				
				@RequestMapping(value = "/openFundUtilization", method = RequestMethod.GET)
				public ModelAndView openFundUtilization(HttpServletRequest request,HttpServletResponse response,Model model) {
					//System.out.println("openFundUtilization called");
					
					String jsp = "fundUtilization";
					
					MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					String Url = HMSUtil.getProperties("urlextension.properties","financialYearList");		
					 String OSBURL = IpAndPortNo + Url;
					 String data="{}"; 
					 String financialYearList =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,data);
					 
					
				   // String financialYearList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/financialYearList", requestHeaders, data); 
					model.addAttribute("financialYearList", financialYearList);
				
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}
				
				@RequestMapping(value = "/getFundUtilizationList", method = RequestMethod.POST)
				public String getFundUTilizationList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
					
				String fundUtilizationList="";
				
				JSONObject json = new JSONObject(payload);
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getFundUTilizationList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","fundUtilizationList");
				String OSBURL = IpAndPortNo + Url;
				fundUtilizationList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//fundUtilizationList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/fundUtilizationList",requestHeaders, json.toString());
					
				return  fundUtilizationList;
				}
				
				//submit form
				
				@RequestMapping(value = "/submitFundUtilization", method = RequestMethod.POST)
				public ModelAndView submitFundUtilization(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitFundUtilization--"+obj);
					String data="{}";
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url = HMSUtil.getProperties("urlextension.properties","submitFundUtilization");
				    String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/submitFundUtilization",requestHeaders, obj.toString());
					
					MultiValueMap<String, String> requestHeaders1 = new LinkedMultiValueMap<String, String>();
					String Url1=HMSUtil.getProperties("urlextension.properties","financialYearList");
					String OSBURL1 = IpAndPortNo + Url1;
					String financialYearList = RestUtils.postWithHeaders(OSBURL1.trim(),requestHeaders1,data);
					   
					//String financialYearList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/financialYearList", requestHeaders1, data); 
					model.addAttribute("financialYearList", financialYearList);
				
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "fundUtilization";
					model.addAttribute("message", responsedata.get("msg"));
					mv.setViewName(jsp);
					return mv;

				}
		
				@RequestMapping(value = "/showFundUtilizationInShownYear", method = RequestMethod.GET)
				public ModelAndView showFundUtilizationInShownYear(HttpServletRequest request,	HttpServletResponse response) {
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("yearId", Integer.parseInt(request.getParameter("yearId")));
					String jsp = "showUtilizedfund";
					ModelAndView mv =new ModelAndView();
					mv.addObject("map", map);
					mv.setViewName(jsp);
					return mv;
				}
				
				
				@RequestMapping(value = "/getFundUtilizationDetailsInShownYear", method = RequestMethod.POST)
				public String getFundUtilizationDetailsInShownYear(@RequestBody String data,HttpServletRequest request,	HttpServletResponse response) {
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
						String Url=HMSUtil.getProperties("urlextension.properties","GET_FUND_UTILIZATION_IN_SHOWN_YEAR");
						String OSBUrl = IpAndPortNo + Url;
						return RestUtils.postWithHeaders(OSBUrl.trim(), requestHeaders, data);
				}
				
				
				///Tracking list for Budgetary
				
				@RequestMapping(value="/budgetaryList", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView budgetaryList(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					return new ModelAndView("budgetaryList");
				}
				
				@RequestMapping(value = "/getBudgetaryList", method = RequestMethod.POST)
				public String getBudgetaryList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String budgetaryList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getBudgetaryApprovalList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getBudgetaryApprovalList");
				String OSBURL = IpAndPortNo + Url;
				 budgetaryList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				 // budgetaryList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getBudgetaryApprovalList",requestHeaders, json.toString());
						
				return  budgetaryList;
				}
				
					///Tracking list for Sanction
				
				@RequestMapping(value="/sanctionList", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView sanctionList(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					return new ModelAndView("sanctionList");
				}
				
				@RequestMapping(value = "/getSanctionList", method = RequestMethod.POST)
				public String getSanctionList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String sanctionList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getSanctionList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getSanctionList");
				String OSBURL = IpAndPortNo + Url;
				sanctionList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//sanctionList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/lpprocess/getSanctionList",requestHeaders, json.toString());
						
				return  sanctionList;
				}
				
}
