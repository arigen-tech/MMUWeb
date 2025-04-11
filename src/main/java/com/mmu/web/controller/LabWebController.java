package com.mmu.web.controller;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
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


@RequestMapping("/lab")
@RestController
@CrossOrigin
public class LabWebController {
	
/*	@Autowired
	LabService labservice;*/
	
	String IpAndPortNo = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	

	@RequestMapping(value="/pendingForSampleCollection", method=RequestMethod.GET)
	public ModelAndView getPendingForSampleCollection(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingForSampleCollection");
	}
	
	@RequestMapping(value="/getPendingSampleCollectionWaitingListGrid", method=RequestMethod.POST)
	public String getPendingSampleCollectionWaitingListGrid(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPendingSampleCollectionWaitingListGrid");	
		String OSBURL = IpAndPortNo+Url;	
		//System.out.println("lab controller");
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/lab/getPendingSampleCollectionWaitingListGrid", requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/getPendingSampleCollection", method=RequestMethod.POST)
	public String getPendingSampleCollection(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPendingSampleCollection");		
		String OSBURL = IpAndPortNo+Url;		
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	
	@RequestMapping(value="/pendingSampleCollectionDetails", method=RequestMethod.GET)
	public ModelAndView pendingSampleCollectionDetails(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "pendingSampleCollectionDetails";
		int headerId = Integer.parseInt(request.getParameter("orderhdId"));
/*		int hospId = Integer.parseInt(request.getParameter("hospitalId"));
		Long userId = Long.parseLong(request.getParameter("userId"));*/
		String payload = "{\"orderhdId\": "+ headerId +" }";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getPendingSampleCollectionDetails");
		String jsonResponse = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, payload);
		
		//System.out.println("jsonResponse="+jsonResponse);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/submitSampleCollectionDetails", method=RequestMethod.POST)
	public ModelAndView submitSampleCollectionDetails(HttpServletRequest request, HttpServletResponse response) {
		Box box = HMSUtil.getBox(request);
		JSONObject jsonObject = new JSONObject(box);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitSampleCollectionDetails");
		String OSBURL = IpAndPortNo+Url;
		String responsedata =  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		ModelAndView mv = new ModelAndView();
		String jsp = "submitSampleCollectedPage";
		mv.addObject("data",responsedata);
		
		mv.addObject("msg", "Sample Collected Successfully.");
		mv.setViewName(jsp);
		return mv;
	}
	
	/************************************************************ Sample Validation *************************************************************/
	/**
	 * @Descrition Method:pendingSampleValidate(). get pending sample validation page loading
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/pendingSampleValidate", method=RequestMethod.GET)
	public ModelAndView pendingSampleValidate(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingSampleValidate");
	}
	
	/**
	 * @Description Method: getPendingSampleValidate(). get Pending Sample Validation List
	 * @param reqPayload
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getPendingSampleValidateListGrid", method=RequestMethod.POST)
	public String getPendingSampleValidateListGrid(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPendingSampleValidateListGrid");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	@RequestMapping(value="/getPendingSampleValidate", method=RequestMethod.POST)
	public String getPendingSampleValidate(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPendingSampleValidateList");		
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	/**
	 * @Description Method: pendingSampleValidateDetails(). Sample Validation Details List
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/pendingSampleValidateDetails", method=RequestMethod.GET)
	public ModelAndView getPendingSampleValidateDetails(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "pendingSampleValidateDetails";
		int sampleCollectionHeaderId = Integer.parseInt(request.getParameter("sampleCollectionHeaderId"));
		int subchargeCodeId = Integer.parseInt(request.getParameter("subchargeCodeId"));
		//String investigationType = request.getParameter("investigationType");
		String payload = "{\"sampleCollectionHeaderId\":" + sampleCollectionHeaderId + ", \"subchargeCodeId\":" + subchargeCodeId +"}";
		JSONObject json=new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getPendingSampleValidateDetails");
		String jsonResponse = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, json.toString());
		//String jsonResponse =  RestUtils.postWithHeaders("http://localhost:8082/AshaServices/lab/getPendingSampleValidateDetails", requestHeaders, json.toString());
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/submitSampleValidationDetails", method=RequestMethod.POST)
	public ModelAndView submitSampleValidationDetails(HttpServletRequest request, HttpServletResponse response) {
		Box box = HMSUtil.getBox(request);
		JSONObject jsonObject = new JSONObject(box);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitSampleValidationDetails");
		String OSBURL = IpAndPortNo+Url;
		String responsedata =  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		ModelAndView mv = new ModelAndView();
		String jsp = "submitSampleValidatedPage";
		mv.addObject("data",responsedata);		
		mv.addObject("msg", "Sample Validated Successfully.");
		mv.setViewName(jsp);
		return mv;
	} 
	
	@RequestMapping(value="/pendingResultEntryOutSide", method=RequestMethod.GET)
	public ModelAndView pendingResultEntryOutSide(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingResultEntryOutSide");
	}
	
	@RequestMapping(value="/pendingResultEntryDetailsOutSide", method=RequestMethod.GET)
	public ModelAndView pendingResultEntryDetailsOutSide(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingResultEntryDetailsOutSide");
	}
	
	
	@RequestMapping(value="/pendingForResultEntryForOtherOutsideLab", method=RequestMethod.GET)
	public ModelAndView pendingForResultEntryForOtherOutsideLab(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingForResultEntryForOtherOutsideLab");
	}
	
	@RequestMapping(value="/diagnosticMaster", method=RequestMethod.GET)
	public ModelAndView diagnosticMaster(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("diagnosticMaster");
	}
	
	/*************************************** Result Entry *****************************************************/
	
	@RequestMapping(value="/pendingResultEntry", method=RequestMethod.GET)
	public ModelAndView pendingResultEntry(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingResultEntry");
	}
	//getResultEntryWaitingListGrid
	@RequestMapping(value="/getResultEntryWaitingListGrid", method=RequestMethod.POST)
	public String getResultEntryWaitingListGrid(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getResultEntryWaitingListGrid");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/getResultEntryWaitingList", method=RequestMethod.POST)
	public String getResultEntryWaitingList(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getResultEntryWaitingList");		
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/getResultEntryDetails", method=RequestMethod.GET)
	public ModelAndView getResultEntryDetails(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "pendingResultEntryDetails";
		int sampleCollectionHdId = Integer.parseInt(request.getParameter("sampleCollectionHdId"));
		//int subchargeCodeId = Integer.parseInt(request.getParameter("subchargeCodeId"));
		//String investigationType = request.getParameter("investigationType");
		//String payload = "{\"sampleCollectionHdId\":" + sampleCollectionHdId + ",\"subchargeCodeId\":" + subchargeCodeId + ",\"investigationType\":" +investigationType+ "}";
		//String payload = "{\"sampleCollectionHdId\":" + sampleCollectionHdId + ",\"subchargeCodeId\":" + subchargeCodeId +"}";
		
		String payload = "{\"sampleCollectionHdId\":" + sampleCollectionHdId + "}";
		JSONObject json = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getResultEntryDetails");
		String jsonResponse = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, json.toString());
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
		
	}
	
	
	@RequestMapping(value="/submitResultEntryDetails", method=RequestMethod.POST)
	public ModelAndView submitResultEntryDetails(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();  
		Box box = HMSUtil.getBox(request);
		JSONObject jsonObject = new JSONObject(box);
		String userId = null;
		String campId = null;
		String mmuName="";
		String cityName="";
		if (session.getAttribute("userId") != null) {
			userId = session.getAttribute("userId") + "";
		}
		
		if (session.getAttribute("campId") != null) {
			campId = session.getAttribute("campId") + "";
		}
		if (session.getAttribute("mmuName") != null) {
			mmuName = session.getAttribute("mmuName") + "";
		}
		if (session.getAttribute("cityName") != null) {
			cityName = session.getAttribute("cityName") + "";
		}
		 
		
				
		jsonObject.put("userId", userId);
		jsonObject.put("campId", campId);
		jsonObject.put("mmuName", mmuName);
		jsonObject.put("cityName", cityName);
		String jsp = "submitResultEntryDetailsPage";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitResultEntryDetails");
		String OSBURL = IpAndPortNo+Url;
		String responsedata =  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		ModelAndView mv = new ModelAndView();
		JSONObject objw = new JSONObject(responsedata);
		String msg = "";
		if(!String.valueOf(objw.get("status")).equals('0')) {
			msg = "Result Submited Successfully.";
		}else {
			msg = "Error occured, Result not submitted";
		}
		mv.addObject("data",responsedata);
		mv.addObject("msg", msg);
		mv.setViewName(jsp);
		return mv;
	}
	
	/************************************** pending Result Entry OutSide Details **************************/
	
	@RequestMapping(value="/pendingResultEntryOutSideDetails", method=RequestMethod.GET)
	public ModelAndView pendingResultEntryOutSideDetails(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingResultEntryOutSideDetails");
	}
	
	/************************************** pending Result Validation **************************/
	
	@RequestMapping(value="/pendingResultValidation", method=RequestMethod.GET)
	public ModelAndView pendingResultValidation(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingResultValidation");
	}
	
	//getResultEntryWaitingListGrid
		@RequestMapping(value="/getResultValidationWaitingListGrid", method=RequestMethod.POST)
		public String getResultValidationWaitingListGrid(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
			JSONObject jsonObject = new JSONObject(reqPayload);		
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties", "getResultValidationWaitingListGrid");
			String OSBURL = IpAndPortNo+Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
			
		}
	
	@RequestMapping(value="/getResultValidationWaitingList", method=RequestMethod.POST)
	public String getResultValidationWaitingList(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getResultValidationWaitingList");		
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	
	@RequestMapping(value="/getResultValidationDetails", method=RequestMethod.GET)
	public ModelAndView getResultValidationDetails(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "pendingResultValidationDetails";
		int resultEntryHdId = Integer.parseInt(request.getParameter("resultEntryHdId"));
		String payload = "{\"resultEntryHdId\":" + resultEntryHdId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getResultValidationDetails");
		String jsonResponse = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;		
	}
	
	
	@RequestMapping(value="/submitResultValidationDetails", method=RequestMethod.POST)
	public ModelAndView submitResultValidationDetails(HttpServletRequest request, HttpServletResponse response) {
		Box box = HMSUtil.getBox(request);
		JSONObject jsonObject = new JSONObject(box);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "submitResultValidationDetails");
		String responsedata = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, jsonObject.toString());
		ModelAndView mv = new ModelAndView();
		String jsp = "submitResultValidationPage";
		mv.addObject("data",responsedata);		
		mv.addObject("msg", "Result Submited Successfully.");
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/labHistory", method=RequestMethod.GET)
	public ModelAndView labHistory(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("labHistory");
	}
	
	
	@RequestMapping(value="/getPatientList", method=RequestMethod.POST)
	public String getPatientList(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPatientList");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/getLabHistory", method=RequestMethod.POST)
	public String getLabHistory(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getLabHistory");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	/****************************** Pending OutSide Patient  ***************************************/
	@RequestMapping(value="/pendingOutSidePatientWaitingList", method=RequestMethod.GET)
	public ModelAndView pendingOutSidePatientWaitingList(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("pendingOutSidePatientWaitingList");
	}
	
	@RequestMapping(value="/getOutSidePatientWaitingList", method=RequestMethod.POST)
	public String getOutSidePatientWaitingList(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getOutSidePatientWaitingList");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	/****************************** Result Entry Update  ***************************************/
	
	@RequestMapping(value="/getResultEntryUpdateWaitingList", method=RequestMethod.GET)
	public ModelAndView getResultEntryUpdateWaitingList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView=new ModelAndView();
		String mobileNumber="";
		try {
			mobileNumber=request.getParameter("mobileNumber");
			if(mobileNumber=="" || mobileNumber==null) {
				mobileNumber="0";
			}
		}
		catch(Exception e) {
			mobileNumber="0";
			e.printStackTrace();}
		//return new ModelAndView("resultEntryUpdateWaitingList");
		modelAndView.setViewName("resultEntryUpdateWaitingList");
		modelAndView.addObject("mobileNumber", mobileNumber);
		return modelAndView;
	}
	
	@RequestMapping(value="/getResultUpdateWaitingList", method=RequestMethod.POST)
	public String getResultUpdateWaitingList(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getResultUpdateWaitingList");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/getResultUpdateDetails", method=RequestMethod.GET)
	public ModelAndView getResultUpdateDetails(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "resultEntryUpdateDetails";
		int resultEntryHdId = Integer.parseInt(request.getParameter("resultEntryHdId"));
		String payload = "{\"resultEntryHdId\":" + resultEntryHdId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getResultEntryUpdateDetails");
		String jsonResponse = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;		
	}
	
	
	@RequestMapping(value="/updateResultEntryDetails", method=RequestMethod.POST)
	public ModelAndView updateResultEntryDetails(HttpServletRequest request, HttpServletResponse response) {
		Box box = HMSUtil.getBox(request);
		JSONObject jsonObject = new JSONObject(box);
		HttpSession session = request.getSession();
		String mmuName="";
		String cityName="";
		if (session.getAttribute("mmuName") != null) {
			mmuName = session.getAttribute("mmuName") + "";
		}
		if (session.getAttribute("cityName") != null) {
			cityName = session.getAttribute("cityName") + "";
		}
		jsonObject.put("mmuName", mmuName);
		jsonObject.put("cityName", cityName);
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateResultEntryDetails");
		String OSBURL = IpAndPortNo+Url;
		String responsedata =  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		ModelAndView mv = new ModelAndView();
		String jsp = "updateResultEntryDetailsPage";
		mv.addObject("data",responsedata);		
		mv.addObject("msg", "Result Updated.");
		mv.setViewName(jsp);
		return mv;
	} 
	
	@RequestMapping(value="/sampleRejectedWaitingList", method=RequestMethod.GET)
	public ModelAndView sampleRejectedWaitingList(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("sampleRejectedList");
	}
	
	@RequestMapping(value="/getSampleRejectedWaitingList", method=RequestMethod.POST)
	public String getSampleRejectedWaitingList(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getSampleRejectedWaitingList");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/getSampleRejectedDetails", method=RequestMethod.GET)
	public ModelAndView getSampleRejectedDetails(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "sampleRejectedDetails";
		int sampleCollectionHdId = Integer.parseInt(request.getParameter("sampleCollectionHdId"));
		int subchargeCodeId = Integer.parseInt(request.getParameter("subchargeCodeId"));
		String investigationType = request.getParameter("investigationType");
		String payload = "{\"sampleCollectionHdId\":" + sampleCollectionHdId + ",\"subchargeCodeId\":" + subchargeCodeId + ",\"investigationType\":" +investigationType+ "}";
		JSONObject json = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getSampleRejectedDetails");
		String jsonResponse = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, json.toString());
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
		
		
		
		/*String jsp = "pendingSampleValidateDetails";
		int sampleCollectionHeaderId = Integer.parseInt(request.getParameter("sampleCollectionHeaderId"));
		int subchargeCodeId = Integer.parseInt(request.getParameter("subchargeCodeId"));
		//String investigationType = request.getParameter("investigationType");
		String payload = "{\"sampleCollectionHeaderId\":" + sampleCollectionHeaderId + ", \"subchargeCodeId\":" + subchargeCodeId +"}";
		JSONObject json=new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getSampleRejectedDetails");
		String jsonResponse = RestUtils.postWithHeaders(IpAndPortNo.trim() + OsbURL.trim(), requestHeaders, json.toString());
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;*/
		
	}
	
	
	@RequestMapping(value="/submitSampleRejectedDetails", method=RequestMethod.POST)
	public ModelAndView submitSampleRejectedDetails(HttpServletRequest request, HttpServletResponse response) {
		Box box = HMSUtil.getBox(request);
		JSONObject jsonObject = new JSONObject(box);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitSampleRejectedDetails");
		String OSBURL = IpAndPortNo+Url;
		String responsedata =  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		//System.out.println("responsedata :::: "+responsedata);
		ModelAndView mv = new ModelAndView();
		String jsp = "submitSampleRejectedPage";
		mv.addObject("data",responsedata);		
		mv.addObject("msg", "Sample Rejected Details Submit Successfully.");
		mv.setViewName(jsp);
		return mv;
	} 
	
/*	@RequestMapping(value="/autheniticateUHID", method=RequestMethod.POST)
	public String autheniticateUHID(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","autheniticateUHID");
		String OSBURL = IpAndPortNo + Url;
		String responsedata = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//System.out.println("responsedata for labhistory :: "+responsedata);
		return responsedata;
	}*/
	
	@RequestMapping(value="/autheniticateUHID", method=RequestMethod.POST)
	public String autheniticateUHID(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "autheniticateUHID");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value = "/checkAuthenticateUser", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String checkAuthenticateUser(@RequestBody HashMap<String, Object> jsondata, HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(jsondata);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "checkAuthenticateUser");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	@RequestMapping(value = "/checkAuthenticateServiceNo", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String checkAuthenticateServiceNo(@RequestBody HashMap<String, Object> jsondata, HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(jsondata);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "checkAuthenticateServiceNo");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	
	@RequestMapping(value="/getLabHistoryDetails", method=RequestMethod.POST)
	public String getLabHistoryDetails(@RequestBody String reqPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(reqPayload);		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getLabHistoryDetails");		
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	
	@RequestMapping(value="/labHistoryforMMU", method=RequestMethod.GET)
	public ModelAndView labHistoryforMMU(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("labHistoryforMMU");
	}
	
	@RequestMapping(value="/investigationRegister", method=RequestMethod.GET)
	public ModelAndView investigationRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("investigationRegister");		
		return mav;
	}
		
	@RequestMapping(value = "/getInvestigationList", method = RequestMethod.POST)
	public String getEmpTypeList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getInvestigationList");		
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);

	}
	@RequestMapping(value="/campVisitStatus", method=RequestMethod.GET)
	public ModelAndView campVisitStatus(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("campVisitStatus");
	}
	
	
}
