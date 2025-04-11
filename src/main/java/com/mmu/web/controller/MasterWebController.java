package com.mmu.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.service.MasterService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;





@RequestMapping("/master")
@RestController
@CrossOrigin
public class MasterWebController {
	@Autowired
	MasterService masterService;

	String IpAndPortNo = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	String IpAndPortNoLocal = HMSUtil.getProperties("urlextension.properties", "LOCAL_IP_AND_PORT");


	/**************************************Command Master**************************************************/
	/**
	 * @param CommandMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value="/masterModule", method=RequestMethod.GET)
	public ModelAndView masterModules(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("masterModule");
		return mav;

	}

	@RequestMapping(value="/regionMaster", method=RequestMethod.GET)
	public ModelAndView commandMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("commandMaster");
		return mav;

	}

	@RequestMapping(value="/getAllCommandDetails", method=RequestMethod.POST)
	public String  getAllCommandDetails(@RequestBody String cmdPayload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_ALL_COMMAND");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, cmdPayload);
	}

	@RequestMapping(value="/getCommandTypeList", method=RequestMethod.POST)
	public String getCommandTypeList(@RequestBody String payload,
									 HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_COMMAND_TYPE_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	@RequestMapping(value="/addCommand", method=RequestMethod.POST)
	public String addCommand(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
							 HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_ADD_COMMAND");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	@RequestMapping(value="/updateCommandDetails", method=RequestMethod.POST)
	public String updateCommandDetails(@RequestBody String updateCmdPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(updateCmdPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_COMMAND");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateCommandStatus", method=RequestMethod.POST)
	public String updateCommandStatus(@RequestBody String activeStatusCmdPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(activeStatusCmdPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_STATUS_COMMAND");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/**************************************MAS UNIT**************************************************/
	/**
	 * @param Unit Master
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/unitMaster", method=RequestMethod.GET)
	public ModelAndView unitMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("unitMaster");
		return mav;
	}

	@RequestMapping(value="/addUnit", method=RequestMethod.POST)
	public String addUnitMaster(@RequestBody Map<String, Object> payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_ADD_UNIT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getCmdList", method=RequestMethod.POST)
	public String getCommandList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_COMMAND_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getUnitTypeList", method=RequestMethod.POST)
	public String getUnitTypeList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_UNIT_TYPE_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}



	@RequestMapping(value="/getAllUnit", method=RequestMethod.POST)
	public String getAllUnit(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_ALL_UNIT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateUnit", method=RequestMethod.POST)
	public String updateUnit(@RequestBody HashMap<String, Object> payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_UNIT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}


	@RequestMapping(value="/updateUnitStatus", method=RequestMethod.POST)
	public String updateUnitStatus(@RequestBody String payload,
								   HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_UNIT_STATUS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}
	/***********************************IDEAL WEIGHT**************************************************/
	@RequestMapping(value="/idealWeightMaster", method=RequestMethod.GET)
	public ModelAndView idealWeightMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("idealWeightMaster");
		return mav;
	}

	@RequestMapping(value="/getAge", method=RequestMethod.POST)
	public String getAgeList(@RequestBody Map<String, Object> idealWeight, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(idealWeight);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_AGE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/addIdealWeight", method=RequestMethod.POST)
	public String addIdealWeightMaster(@RequestBody Map<String, Object> idealWeight, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(idealWeight);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_IDEAL_WEIGHT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getAllIdealWeight", method=RequestMethod.POST)
	public String getAllIdealWeight(@RequestBody String empnelledHospital, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(empnelledHospital);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ALL_IDEAL_WEIGHT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());


	}

	@RequestMapping(value="/updateIdealWeight", method=RequestMethod.POST)
	public String updateIdealWeight(@RequestBody String empnelledHospital, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(empnelledHospital);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateIdealWeight");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/******************************************MAS HOSPITAL*****************************************************************/
	/**
	 * @param Mas Hospital
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/hospitalMaster", method=RequestMethod.GET)
	public ModelAndView hospitalMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("hospitalMaster");
		return mav;
	}

	@RequestMapping(value="/addHospital", method=RequestMethod.POST)
	public String addHospital(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_MASHOSPITAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getUnitNameList", method=RequestMethod.POST)
	public String getUnitNameList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_UNIT_NAME_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	@RequestMapping(value="/getAllHospital", method=RequestMethod.POST)
	public String getAllHospital(@RequestBody String hospitalPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(hospitalPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_ALL_HOSPITAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	@RequestMapping(value="/updateMasHospitalDetails", method=RequestMethod.POST)
	public String updateMasHospitalDetails(@RequestBody String hospitalPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(hospitalPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_HOS_DETAILS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}
	@RequestMapping(value="/updateMasHospitalStatus", method=RequestMethod.POST)
	public String updateMasHospitalStatus(@RequestBody String hospitalPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(hospitalPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_HOS_STATUS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	/***************************************MAS RELATION*****************************************************/
	@RequestMapping(value="/relationMaster", method=RequestMethod.GET)
	public ModelAndView relationMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("relationMaster");
		return mav;
	}

	@RequestMapping(value="/getAllRelation", method=RequestMethod.POST)
	public String getAllRelation(@RequestBody String relationPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(relationPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllRelation");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	@RequestMapping(value="/updateRelationDetails", method=RequestMethod.POST)
	public String updateRelationDetails(@RequestBody String relationPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(relationPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateRelationDetails");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}
	@RequestMapping(value="/updateRelationStatus", method=RequestMethod.POST)
	public String updateRelationStatus(@RequestBody String relationPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(relationPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateRelationStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}
	@RequestMapping(value="/addRelation", method=RequestMethod.POST)
	public String addRelation(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "addRelation");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/*********************************MAS DISPOSAL*************************************************/
	@RequestMapping(value="/disposalMaster", method=RequestMethod.GET)
	public ModelAndView disposalMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("disposalMaster");
		return mav;
	}

	@RequestMapping(value="/addDisposal", method=RequestMethod.POST)
	public String addDisposal(@RequestBody Map<String, Object> disposalPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(disposalPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_ADD_DISPOSAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getAllDisposal", method=RequestMethod.POST)
	public String getAllDisposal(@RequestBody String disposalPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(disposalPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_ALL_DISPOSAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateDisposalDetails", method=RequestMethod.POST)
	public String updateDisposalDetails(@RequestBody String disposalPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(disposalPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_DISPOSAL_DETAILS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateDisposalStatus", method=RequestMethod.POST)
	public String updateDisposalStatus(@RequestBody String disposalPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(disposalPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_DISPOSAL_STATUS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	/***************************MAS APPOINTMENT TYPE****************************************************/
	@RequestMapping(value="/appointmentTypeMaster", method=RequestMethod.GET)
	public ModelAndView appointmentTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("appointmentTypeMaster");
		return mav;
	}

	@RequestMapping(value="/addAppointmentType", method=RequestMethod.POST)
	public String addAppointmentType(@RequestBody Map<String, Object> appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_ADD_APPOINTMENT_TYPE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getAllAppointmentType", method=RequestMethod.POST)
	public String getAllAppointmentType(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_ALL_APPOINTMENT_TYPE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateAppointmentTypeDetails", method=RequestMethod.POST)
	public String updateAppointmentTypeDetails(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_APPOINTMENT_TYPE_DETAILS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateAppointmentTypeStatus", method=RequestMethod.POST)
	public String updateAppointmentTypeStatus(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_APPOINTMENT_STATUS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/*********************************MAS FREQUENCY******************************************************/
	@RequestMapping(value="/frequencyMaster", method=RequestMethod.GET)
	public ModelAndView frequencyMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("frequencyMaster");
		return mav;
	}

	@RequestMapping(value="/addOpdFrequency", method=RequestMethod.POST)
	public String addOpdFrequency(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		//JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_ADD_OPD_FREQUENCY");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, appointmentPayload);
	}

	@RequestMapping(value="/getAllOpdFrequency", method=RequestMethod.POST)
	public String getAllOpdFrequency(@RequestBody String departTypePayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(departTypePayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_ALL_OPD_FREQUENCY");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateOpdFrequencyDetails", method=RequestMethod.POST)
	public String updateOpdFrequencyDetails(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		//JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_OPD_FREQUENCY_DETAILS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, appointmentPayload);
	}

	@RequestMapping(value="/updateOpdFrequencyStatus", method=RequestMethod.POST)
	public String updateOpdFrequencyStatus(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_OPD_FREQUENCY_STATUS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/******************************** MAS Empanelled Hospital Master***************************************/
	@RequestMapping(value="/empanelledHospitalMaster", method=RequestMethod.GET)
	public ModelAndView empanelledHospitalMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("empanelledHospitalMaster");
		return mav;
	}

	@RequestMapping(value="/addEmpanelledHospital", method=RequestMethod.POST)
	public String addEmpanelledHospital(@RequestBody Map<String, Object> empnelledHospital, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(empnelledHospital);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_EMPPANELLED_HOSPITAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getAllEmpanelledHospital", method=RequestMethod.POST)
	public String getAllEmpanelledHospital(@RequestBody String empnelledHospital, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(empnelledHospital);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ALL_EMPANELLED_HOSPITAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateEmpanelledHospital", method=RequestMethod.POST)
	public String updateEmpanelledHospital(@RequestBody String empnelledHospital, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(empnelledHospital);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_EMPANELLED_HOSPITAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/getHospitalListByRegion", method = RequestMethod.POST)
	public String getHospitalListByRegion(@RequestBody String payload, HttpServletRequest request,
										  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getHospitalListByRegion");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/getAllRegionList", method=RequestMethod.POST)
	public String getAllRegionList(@RequestBody String empnelledHospital, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(empnelledHospital);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllRegionList");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}



	/************************************ MAS DEPARTMENT *******************************************************/
	@RequestMapping(value="/departmentMaster", method=RequestMethod.GET)
	public ModelAndView departmentMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("departmentMaster");
		return mav;
	}

	@RequestMapping(value="/getDepartmentTypeList", method=RequestMethod.POST)
	public String getDepartmentTypeList(@RequestBody String departTypePayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(departTypePayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_DEPARTMENT_TYPE_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/addDepartment", method=RequestMethod.POST)
	public String addDepartment(@RequestBody Map<String, Object> appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_ADD_DEPARTMENT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getAllDepartment", method=RequestMethod.POST)
	public String getAllDepartment(@RequestBody String departTypePayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(departTypePayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_GET_ALL_DEPARTMENT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateDepartmentDetails", method=RequestMethod.POST)
	public String updateDepartmentDetails(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_DEPARTMENT_DETAILS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateDepartmentStatus", method=RequestMethod.POST)
	public String updateDepartmentStatus(@RequestBody String appointmentPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(appointmentPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OSB_UPDATE_DEPARTMENT_STATUS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/******************************************phsiotherapy TYPE MASTER*****************************************************************/
	/**
	 * @Author Anita
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/physiotherapyMaster", method=RequestMethod.GET)
	public ModelAndView phsiotherapyMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("phsiotherapyMaster");
		return mav;
	}


	@RequestMapping(value="/getAllPhysiotherapy", method=RequestMethod.POST)
	public String getAllPhysiotherapy(@RequestBody String physiotherapyPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(physiotherapyPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ALL_PHYSIOTHERAPY");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	@RequestMapping(value="/addPhsiotherapy", method=RequestMethod.POST)
	public String addPhsiotherapy(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_PHSIOTHERAPY_CARE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updatePhsiotherapyDetails", method=RequestMethod.POST)
	public String updatePhsiotherapyDetails(@RequestBody String masNursingCare, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(masNursingCare);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_PHSITHERAPY_DETAILS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/***************************************** ICD *********************************************************/

	@RequestMapping(value="/ICDMaster", method=RequestMethod.GET)
	public ModelAndView ICDMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("ICDMaster");
		return mav;
	}

	/***************************************** SERVICE TYPE *********************************************************/

	@RequestMapping(value="/serviceTypeMaster", method=RequestMethod.GET)
	public ModelAndView serviceTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("serviceTypeMaster");
		return mav;

	}
	@RequestMapping(value="/getAllServiceTypeDetails", method=RequestMethod.POST)
	public String  getAllServiceTypeDetails(@RequestBody String stPayload, HttpServletRequest request, HttpServletResponse response) {
		String serviceTypeDetails="";
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "osb_getAllServiceType");
		String OSBURL = IpAndPortNo + Url;
		serviceTypeDetails = RestUtils.postWithHeaders(OSBURL, requestHeaders, stPayload);

		return serviceTypeDetails;
	}

	@RequestMapping(value="/updateServiceTypeDetails", method=RequestMethod.POST)
	public String updateServiceTypeDetails(@RequestBody String updateStPayload, HttpServletRequest request, HttpServletResponse response) {
		String responseObj="";
		String Url="";
		JSONObject jsonObject = new JSONObject(updateStPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Url = HMSUtil.getProperties("urlextension.properties", "osb_updateServiceType");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL, requestHeaders, jsonObject.toString());
		return responseObj;
	}
	@RequestMapping(value="/addServiceType", method=RequestMethod.POST)
	public String addServiceType(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
								 HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "osb_addServiceType");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateServiceTypeStatus", method=RequestMethod.POST)
	public String updateServiceTypeStatus(@RequestBody String activeStatusCmdPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(activeStatusCmdPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "osb_statusServiceType");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}


	/**************************************
	 * Rank Master
	 **************************************************/
	/**
	 * @param RankMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/rankMaster", method = RequestMethod.GET)
	public ModelAndView rankMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("rankMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllRankDetails", method = RequestMethod.POST)
	public String getAllRankDetails(@RequestBody String rankPayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "osb_getRank");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rankPayload);
	}

	@RequestMapping(value = "/addRank", method = RequestMethod.POST)
	public String addRank(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
						  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","osb_addRank");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateRankDetails", method = RequestMethod.POST)
	public String updateRankDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
									HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "osb_updateRank");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateRankStatus", method = RequestMethod.POST)
	public String updateRankStatus(@RequestBody String activeStatusRankPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "osb_statusRank");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusRankPayload);
	}

	@RequestMapping(value = "/getEmployeeCategoryList", method = RequestMethod.POST)
	public String getEmployeeCategoryList(@RequestBody String payload, HttpServletRequest request,
										  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "osb_getEmployeeCategoryList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	/**************************************
	 * Trade Master
	 **************************************************/
	/**
	 * @param TradeMaster
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/tradeMaster", method = RequestMethod.GET)
	public ModelAndView tradeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("tradeMaster");
		return mav;

	}

	@RequestMapping(value = "/addTrade", method = RequestMethod.POST)
	public String addTrade(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
						   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addTrade");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllTradeDetails", method = RequestMethod.POST)
	public String getAllTradeDetails(@RequestBody String tradePayload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllTrade");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, tradePayload);

	}

	@RequestMapping(value = "/updateTradeDetails", method = RequestMethod.POST)
	public String updateTradeDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
									 HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateTrade");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateTradeStatus", method = RequestMethod.POST)
	public String updateTradeStatus(@RequestBody String activeStatusTradePayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "statusTrade");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusTradePayload);
	}

	@RequestMapping(value = "/getServiceTypeList", method = RequestMethod.POST)
	public String getServiceTypeList(@RequestBody String payload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getServiceTypeList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	/**************************************
	 * RELION Master
	 **************************************************/
	/**
	 * @param ReligionMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/religionMaster", method = RequestMethod.GET)
	public ModelAndView religionMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("religionMaster");
		return mav;
	}

	@RequestMapping(value = "/addReligion", method = RequestMethod.POST)
	public String addReligion(@RequestBody Map<String, Object> religionPayload, HttpServletRequest request,
							  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(religionPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addReligion");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllReligion", method = RequestMethod.POST)
	public String getAllReligion(@RequestBody String religionPayload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllReligion");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, religionPayload);
	}

	@RequestMapping(value = "/updateReligionDetails", method = RequestMethod.POST)
	public String updateReligionDetails(@RequestBody String religionPayload, HttpServletRequest request,
										HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(religionPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateReligionDetails");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateReligionStatus", method = RequestMethod.POST)
	public String updateReligionStatus(@RequestBody String religionPayload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateReligionStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, religionPayload);
	}

	/**************************************
	 * MARITAL STATUS Master
	 **************************************************/
	/**
	 * @param MaritalStatusMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/maritalStatusMaster", method = RequestMethod.GET)
	public ModelAndView maritalStatusMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("maritalStatusMaster");
		return mav;
	}

	@RequestMapping(value = "/addMaritalStatus", method = RequestMethod.POST)
	public String addMaritalStatus(@RequestBody Map<String, Object> maritalStatusPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(maritalStatusPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addMaritalStatus");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllMaritalStatus", method = RequestMethod.POST)
	public String getAllMaritalStatus(@RequestBody String maritalStatusPayload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMaritalStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, maritalStatusPayload);
	}

	@RequestMapping(value = "/updateMaritalStatusDetails", method = RequestMethod.POST)
	public String updateMaritalStatusDetails(@RequestBody String maritalStatusPayload, HttpServletRequest request,
											 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateMaritalStatusDetails");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, maritalStatusPayload);

	}

	@RequestMapping(value = "/updateMaritalStatusStatus", method = RequestMethod.POST)
	public String updateMaritalStatusStatus(@RequestBody String maritalStatusPayload, HttpServletRequest request,
											HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateMaritalStatusStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, maritalStatusPayload);
	}

	/**************************************
	 * Employee Category Master
	 **************************************************/
	/**
	 * @param EmployeeCategoryMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/employeeCategoryMaster", method = RequestMethod.GET)
	public ModelAndView employeeCategoryMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("employeeCategoryMaster");
		return mav;
	}

	@RequestMapping(value = "/addEmployeeCategory", method = RequestMethod.POST)
	public String addEmployeeCategory(@RequestBody Map<String, Object> employeeCategoryPayload,
									  HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(employeeCategoryPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addEmployeeCategory");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllEmployeeCategory", method = RequestMethod.POST)
	public String getAllEmployeeCategory(@RequestBody String employeeCategoryPayload, HttpServletRequest request,
										 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllEmployeeCategory");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, employeeCategoryPayload);
	}

	@RequestMapping(value = "/updateEmployeeCategoryDetails", method = RequestMethod.POST)
	public String updateEmployeeCategoryDetails(@RequestBody String employeeCategoryPayload, HttpServletRequest request,
												HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateEmployeeCategoryDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, employeeCategoryPayload);
	}

	@RequestMapping(value = "/updateEmployeeCategoryStatus", method = RequestMethod.POST)
	public String updateEmployeeCategoryStatus(@RequestBody String employeeCategoryPayload, HttpServletRequest request,
											   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateEmployeeCategoryStatus");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, employeeCategoryPayload);
	}

	/**************************************
	 * Administrative Sex Master
	 **************************************************/
	/**
	 * @param AdministrativeSexMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/genderMaster", method = RequestMethod.GET)
	public ModelAndView genderMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("genderMaster");
		return mav;
	}

	@RequestMapping(value = "/addAdministrativeSex", method = RequestMethod.POST)
	public String addAdministrativeSex(@RequestBody Map<String, Object> administrativeSexPayload,
									   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(administrativeSexPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addAdministrativeSex");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllAdministrativeSex", method = RequestMethod.POST)
	public String getAllAdministrativeSex(@RequestBody String administrativeSexPayload, HttpServletRequest request,
										  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllAdministrativeSex");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, administrativeSexPayload);
	}

	@RequestMapping(value = "/updateAdministrativeSexDetails", method = RequestMethod.POST)
	public String updateAdministrativeSexDetails(@RequestBody String administrativeSexPayload,
												 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateAdministrativeSexDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, administrativeSexPayload);

	}

	@RequestMapping(value = "/updateAdministrativeSexStatus", method = RequestMethod.POST)
	public String updateAdministrativeSexStatus(@RequestBody String administrativeSexPayload,
												HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateAdministrativeSexStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, administrativeSexPayload);
	}

	/**************************************
	 * Medical Category Master
	 **************************************************/
	/**
	 * @param MedicalCategoryMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/medicalCategoryMaster", method = RequestMethod.GET)
	public ModelAndView medicalCategoryMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("medicalCategoryMaster");
		return mav;
	}

	@RequestMapping(value = "/addMedicalCategory", method = RequestMethod.POST)
	public String addMedicalCategory(@RequestBody Map<String, Object> medicalCategoryPayload,
									 HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(medicalCategoryPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addMedicalCategory");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllMedicalCategory", method = RequestMethod.POST)
	public String getAllMedicalCategory(@RequestBody String medicalCategoryPayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMedicalCategory");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, medicalCategoryPayload);
	}

	@RequestMapping(value = "/updateMedicalCategoryDetails", method = RequestMethod.POST)
	public String updateMedicalCategoryDetails(@RequestBody String medicalCategoryPayload, HttpServletRequest request,
											   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateMedicalCategoryDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, medicalCategoryPayload);
	}

	@RequestMapping(value = "/updateMedicalCategoryStatus", method = RequestMethod.POST)
	public String updateMedicalCategoryStatus(@RequestBody String medicalCategoryPayload, HttpServletRequest request,
											  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateMedicalCategoryStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, medicalCategoryPayload);
	}

	/**************************************
	 * Blood Group Master
	 **************************************************/
	/**
	 * @param BloodGroupMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/bloodGroupMaster", method = RequestMethod.GET)
	public ModelAndView bloodGroupMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("bloodGroupMaster");
		return mav;
	}

	@RequestMapping(value = "/addBloodGroup", method = RequestMethod.POST)
	public String addBloodGroup(@RequestBody Map<String, Object> bloodGroupPayload, HttpServletRequest request,
								HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(bloodGroupPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addBloodGroup");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllBloodGroup", method = RequestMethod.POST)
	public String getAllBloodGroup(@RequestBody String bloodGroupPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllBloodGroup");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bloodGroupPayload);
	}

	@RequestMapping(value = "/updateBloodGroupDetails", method = RequestMethod.POST)
	public String updateBloodGroupDetails(@RequestBody String bloodGroupPayload, HttpServletRequest request,
										  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateBloodGroupDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bloodGroupPayload);
	}

	@RequestMapping(value = "/updateBloodGroupStatus", method = RequestMethod.POST)
	public String updateBloodGroupStatus(@RequestBody String bloodGroupPayload, HttpServletRequest request,
										 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateBloodGroupStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bloodGroupPayload);
	}

	/**************************************
	 * Sample Master
	 **************************************************/
	/**
	 * @param SampleMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/sampleMaster", method = RequestMethod.GET)
	public ModelAndView sampleContainerMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("sampleMaster");
		return mav;
	}

	@RequestMapping(value = "/addSample", method = RequestMethod.POST)
	public String addSample(@RequestBody Map<String, Object> samplePayload,
							HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(samplePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSample");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllSample", method = RequestMethod.POST)
	public String getAllSample(@RequestBody String samplePayload, HttpServletRequest request,
							   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSample");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, samplePayload);
	}

	@RequestMapping(value = "/updateSampleDetails", method = RequestMethod.POST)
	public String updateSampleDetails(@RequestBody String samplePayload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSampleDetails");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, samplePayload);
	}

	@RequestMapping(value = "/updateSampleStatus", method = RequestMethod.POST)
	public String updateSampleStatus(@RequestBody String samplePayload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSampleStatus");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, samplePayload);
	}

	/**************************************
	 * Unit of Measurement Master
	 **************************************************/
	/**
	 * @param UOMMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/uomMaster", method = RequestMethod.GET)
	public ModelAndView uomMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("uomMaster");
		return mav;
	}

	@RequestMapping(value = "/addUOM", method = RequestMethod.POST)
	public String addUOM(@RequestBody Map<String, Object> UOMPayload,
						 HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(UOMPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addUOM");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllUOM", method = RequestMethod.POST)
	public String getAllUOM(@RequestBody String UOMPayload, HttpServletRequest request,
							HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllUOM");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, UOMPayload);
	}

	@RequestMapping(value = "/updateUOMDetails", method = RequestMethod.POST)
	public String updateUOMDetails(@RequestBody String UOMPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateUOMDetails");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, UOMPayload);
	}

	@RequestMapping(value = "/updateUOMStatus", method = RequestMethod.POST)
	public String updateUOMStatus(@RequestBody String UOMPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateUOMStatus");
		String OSBURL = IpAndPortNo + URL;
		//String LOCALURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, UOMPayload);
	}

	/**************************************
	 * Item Unit Master
	 **************************************************/
	/**
	 * @param itemUnitMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/itemUnitMaster", method = RequestMethod.GET)
	public ModelAndView itemUnitMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("itemUnitMaster");
		return mav;
	}

	@RequestMapping(value = "/addItemUnit", method = RequestMethod.POST)
	public String addItemUnit(@RequestBody Map<String, Object> itemUnitPayload,
							  HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(itemUnitPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addItemUnit");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllItemUnit", method = RequestMethod.POST)
	public String getAllItemUnit(@RequestBody String itemUnitPayload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllItemUnit");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemUnitPayload);
	}

	@RequestMapping(value = "/updateItemUnitDetails", method = RequestMethod.POST)
	public String updateItemUnitDetails(@RequestBody String itemUnitPayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateItemUnitDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemUnitPayload);
	}

	@RequestMapping(value = "/updateItemUnitStatus", method = RequestMethod.POST)
	public String updateItemUnitStatus(@RequestBody String itemUnitPayload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateItemUnitStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemUnitPayload);
	}

	/**************************************
	 * Users Master
	 **************************************************/
	/**
	 * @param usersMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/usersMaster", method = RequestMethod.GET)
	public ModelAndView usersMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("usersMaster");
		return mav;
	}

	@RequestMapping(value = "/addUsers", method = RequestMethod.POST)
	public String addUsers(@RequestBody Map<String, Object> usersPayload,
						   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(usersPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addUsers");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllUsers", method = RequestMethod.POST)
	public String getAllUsers(@RequestBody String usersPayload, HttpServletRequest request,
							  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllUsers");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, usersPayload);
	}

	@RequestMapping(value = "/updateUsersDetails", method = RequestMethod.POST)
	public String updateUsersDetails(@RequestBody String usersPayload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateUsersDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, usersPayload);
	}

	@RequestMapping(value = "/updateUsersStatus", method = RequestMethod.POST)
	public String updateUsersStatus(@RequestBody String usersPayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateUsersStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, usersPayload);
	}

	@RequestMapping(value = "/getHospitalList", method = RequestMethod.POST)
	public String getHospitalList(@RequestBody String payload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getHospitalList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	/**************************************
	 * MainChargecode Master
	 **************************************************/
	/**
	 * @param mainChargecodeMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/mainChargeCodeMaster", method = RequestMethod.GET)
	public ModelAndView mainChargeCodeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mainChargeCodeMaster");
		return mav;
	}

	@RequestMapping(value = "/addMainChargecode", method = RequestMethod.POST)
	public String addMainChargecode(@RequestBody Map<String, Object> mainChargecodePayload,
									HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(mainChargecodePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addMainChargecode");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllMainChargecode", method = RequestMethod.POST)
	public String getAllMainChargecode(@RequestBody String mainChargecodePayload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMainChargecode");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, mainChargecodePayload);
	}

	@RequestMapping(value = "/updateMainChargecodeDetails", method = RequestMethod.POST)
	public String updateMainChargecodeDetails(@RequestBody String mainChargecodePayload, HttpServletRequest request,
											  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateMainChargecodeDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, mainChargecodePayload);
	}

	@RequestMapping(value = "/updateMainChargecodeStatus", method = RequestMethod.POST)
	public String updateMainChargecodeStatus(@RequestBody String mainChargecodePayload, HttpServletRequest request,
											 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateMainChargecodeStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, mainChargecodePayload);
	}

	@RequestMapping(value = "/getDepartmentList", method = RequestMethod.POST)
	public String getDepartmentList(@RequestBody String payload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getDepartmentList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	/**************************************
	 * Role Master
	 **************************************************/
	/**
	 * @param RoleMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/roleMaster", method = RequestMethod.GET)
	public ModelAndView roleMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("roleMaster");
		return mav;
	}

	@RequestMapping(value = "/addRole", method = RequestMethod.POST)
	public String addRole(@RequestBody Map<String, Object> rolePayload,
						  HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(rolePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addRole");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllRole", method = RequestMethod.POST)
	public String getAllRole(@RequestBody String rolePayload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllRole");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rolePayload);
	}

	@RequestMapping(value = "/updateRoleDetails", method = RequestMethod.POST)
	public String updateRoleDetails(@RequestBody String rolePayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateRoleDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rolePayload);
	}

	@RequestMapping(value = "/updateRoleStatus", method = RequestMethod.POST)
	public String updateRoleStatus(@RequestBody String rolePayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateRoleStatus");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rolePayload);
	}
	/**************************************
	 * Range Master
	 **************************************************/
	/**
	 * @param rangeMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/rangeMaster", method = RequestMethod.GET)
	public ModelAndView rangeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("rangeMaster");
		return mav;
	}

	@RequestMapping(value = "/addRange", method = RequestMethod.POST)
	public String addRange(@RequestBody Map<String, Object> rangePayload,
						   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(rangePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addRange");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllRange", method = RequestMethod.POST)
	public String getAllRange(@RequestBody String rangePayload, HttpServletRequest request,
							  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllRange");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rangePayload);
	}

	@RequestMapping(value = "/updateRangeDetails", method = RequestMethod.POST)
	public String updateRangeDetails(@RequestBody String rangePayload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateRangeDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rangePayload);
	}

	@RequestMapping(value = "/updateRangeStatus", method = RequestMethod.POST)
	public String updateRangeStatus(@RequestBody String rangePayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateRangeStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rangePayload);
	}

	@RequestMapping(value = "/getGenderList", method = RequestMethod.POST)
	public String getGenderList(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getGenderList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/getMasRange", method=RequestMethod.POST)
	public String getMasRange(@RequestBody String rangePayload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMasRange");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, rangePayload);
	}

	/**************************************
	 * Store Group Master
	 **************************************************/
	/**
	 * @param StoreGroupMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/storeGroupMaster", method = RequestMethod.GET)
	public ModelAndView storeGroupMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("storeGroupMaster");
		return mav;
	}

	@RequestMapping(value = "/addStoreGroup", method = RequestMethod.POST)
	public String addStoreGroup(@RequestBody Map<String, Object> storeGroupPayload,
								HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(storeGroupPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addStoreGroup");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllStoreGroup", method = RequestMethod.POST)
	public String getAllStoreGroup(@RequestBody String storeGroupPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllStoreGroup");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, storeGroupPayload);
	}

	@RequestMapping(value = "/updateStoreGroup", method = RequestMethod.POST)
	public String updateStoreGroup(@RequestBody String storeGroupPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateStoreGroup");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, storeGroupPayload);
	}

	@RequestMapping(value = "/updateStoreGroupStatus", method = RequestMethod.POST)
	public String updateStoreGroupStatus(@RequestBody String storeGroupPayload, HttpServletRequest request,
										 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateStoreGroupStatus");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, storeGroupPayload);
	}

	/**************************************
	 * ITEM TYPE Master
	 **************************************************/
	/**
	 * @param ItemTypeMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/itemTypeMaster", method = RequestMethod.GET)
	public ModelAndView itemTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("itemTypeMaster");
		return mav;
	}

	@RequestMapping(value = "/addItemType", method = RequestMethod.POST)
	public String addItemType(@RequestBody Map<String, Object> itemTypePayload,
							  HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(itemTypePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addItemType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllItemType", method = RequestMethod.POST)
	public String getAllItemType(@RequestBody String itemTypePayload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllItemType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemTypePayload);
	}

	@RequestMapping(value = "/updateItemType", method = RequestMethod.POST)
	public String updateItemType(@RequestBody String itemTypePayload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateItemType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemTypePayload);
	}

	@RequestMapping(value = "/updateItemTypeStatus", method = RequestMethod.POST)
	public String updateItemTypeStatus(@RequestBody String itemTypePayload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateItemTypeStatus");
		String OSBURL = IpAndPortNo + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemTypePayload);
	}

	/**************************************
	 * Item Section Master
	 **************************************************/
	/**
	 * @param ItemSectionMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/itemSectionMaster", method = RequestMethod.GET)
	public ModelAndView itemSectionMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("itemSectionMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllStoreSectionDetails", method = RequestMethod.POST)
	public String getAllStoreSectionDetails(@RequestBody String storeSectionPayload, HttpServletRequest request,
											HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllStoreSection");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, storeSectionPayload);
	}

	@RequestMapping(value = "/addStoreSection", method = RequestMethod.POST)
	public String addStoreSection(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addStoreSection");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateStoreSectionDetails", method = RequestMethod.POST)
	public String updateStoreSectionDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
											HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateStoreSection");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateStoreSectionStatus", method = RequestMethod.POST)
	public String updateStoreSectionStatus(@RequestBody String activeStatusStoreSectionPayload, HttpServletRequest request,
										   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "statusStoreSection");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusStoreSectionPayload);
	}

	/*
	 * @RequestMapping(value = "/getItemTypeList", method = RequestMethod.POST)
	 * public String getItemTypeList(@RequestBody String payload, HttpServletRequest
	 * request, HttpServletResponse response) { MultiValueMap<String, String>
	 * requestHeaders = new LinkedMultiValueMap<String, String>(); String URL =
	 * HMSUtil.getProperties("urlextension.properties", "getItemTypeList"); String
	 * OSBURL = IpAndPortNo + URL; return RestUtils.postWithHeaders(OSBURL.trim(),
	 * requestHeaders, payload); }
	 */

	/**************************************
	 * Item Class Master
	 **************************************************/
	/**
	 * @param ItemClassMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/itemClassMaster", method = RequestMethod.GET)
	public ModelAndView itemClassMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("itemClassMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllItemClassDetails", method = RequestMethod.POST)
	public String getAllItemClassDetails(@RequestBody String itemClassPayload, HttpServletRequest request,
										 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllItemClass");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemClassPayload);
	}

	@RequestMapping(value = "/addItemClass", method = RequestMethod.POST)
	public String addItemClass(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
							   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addItemClass");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateItemClassDetails", method = RequestMethod.POST)
	public String updateItemClassDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
										 HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateItemClass");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateItemClassStatus", method = RequestMethod.POST)
	public String updateItemClassStatus(@RequestBody String activeStatusItemClassPayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "statusItemClass");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusItemClassPayload);
	}

	@RequestMapping(value = "/getStoreSectionList", method = RequestMethod.POST)
	public String getItemTypeList(@RequestBody String payload, HttpServletRequest
			request, HttpServletResponse response) { MultiValueMap<String, String>
			requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL =
				HMSUtil.getProperties("urlextension.properties", "getStoreSectionList"); String
				OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);

	}

	/**************************************
	 *Section Master
	 **************************************************/
	/**
	 * @param SectionMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/sectionMaster", method = RequestMethod.GET)
	public ModelAndView sectionMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("sectionMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllSectionDetails", method = RequestMethod.POST)
	public String getAllSectionDetails(@RequestBody String sectionPayload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllSection");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, sectionPayload);
	}

	@RequestMapping(value = "/addSection", method = RequestMethod.POST)
	public String addSection(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
							 HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addSection");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateSectionDetails", method = RequestMethod.POST)
	public String updateSectionDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
									   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateSection");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateSectionStatus", method = RequestMethod.POST)
	public String updateSectionStatus(@RequestBody String activeStatusSectionPayload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "statusSection");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusSectionPayload);
	}

	/*
	 * @RequestMapping(value = "/getItemTypeList", method = RequestMethod.POST)
	 * public String getItemTypeList(@RequestBody String payload, HttpServletRequest
	 * request, HttpServletResponse response) { MultiValueMap<String, String>
	 * requestHeaders = new LinkedMultiValueMap<String, String>(); String URL =
	 * HMSUtil.getProperties("urlextension.properties", "getItemTypeList"); String
	 * OSBURL = IpAndPortNo + URL; return RestUtils.postWithHeaders(OSBURL.trim(),
	 * requestHeaders, payload); }
	 */

	/**************************************
	 *Item Drug Master
	 **************************************************/
	/**
	 * @param ItemDrugMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/itemDrugMaster", method = RequestMethod.GET)
	public ModelAndView itemDrugMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("itemDrugMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllItemDetails", method = RequestMethod.POST)
	public String getAllItemDetails(@RequestBody String itemPayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllItem");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, itemPayload);
	}

	@RequestMapping(value = "/addItem", method = RequestMethod.POST)
	public String addItem(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
						  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addItem");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateItemDetails", method = RequestMethod.POST)
	public String updateItemDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
									HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateItem");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateItemStatus", method = RequestMethod.POST)
	public String updateItemStatus(@RequestBody String activeStatusItemPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "statusItem");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusItemPayload);
	}


	/**************************************
	 MEMB Type Master
	 **************************************************/


	@RequestMapping(value="/membTypeMaster", method=RequestMethod.GET)
	public ModelAndView membTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("membTypeMaster");
		return mav;

	}

	@RequestMapping(value="/addMEMBMaster", method=RequestMethod.POST)
	public String addMEMBMaster(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
								HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "addMEMBMaster");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getAllMEMBMaster", method=RequestMethod.POST)
	public String  getAllMEMBMaster(@RequestBody String membPayload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllMEMBMaster");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, membPayload);
	}

	@RequestMapping(value="/updateMEMBMasterDetails", method=RequestMethod.POST)
	public String updateMEMBMasterDetails(@RequestBody String updateMEMBPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(updateMEMBPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateMEMBMaster");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/updateMEMBStatus", method=RequestMethod.POST)
	public String updateMEMBStatus(@RequestBody String statusMEMBPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusMEMBPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateMEMBStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/**************************************
	 ME Investigation Master
	 **************************************************/
	@RequestMapping(value="/meInvestigationMaster", method=RequestMethod.GET)
	public ModelAndView meInvestigationMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("meInvestigationMaster");
		return mav;

	}

	@RequestMapping(value="/getInvestigationNameList", method=RequestMethod.POST)
	public String getInvestigationNameList(@RequestBody String payload,
										   HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getInvestigationNameList");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	@RequestMapping(value="/saveMEInvestigation", method=RequestMethod.POST)
	public String saveMEInvestigation(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
									  HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "saveMEInvestigation");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value="/getAllInvestigationMapping", method=RequestMethod.POST)
	public String getAllInvestigationMapping(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
											 HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllInvestigationMapping");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}


	@RequestMapping(value="/updateMEInvestStatus", method=RequestMethod.POST)
	public String updateMEInvestStatus(@RequestBody String statusMEPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusMEPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateMEInvestStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}


	@RequestMapping(value="/updateInvestigationMapping", method=RequestMethod.POST)
	public String updateInvestigationMapping(@RequestBody String updateMEPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(updateMEPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateInvestigationMapping");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	/**************************************
	 * Sub Type Master
	 **************************************************/
	/**
	 * @param sub Type Master
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/subTypeMaster", method = RequestMethod.GET)
	public ModelAndView subTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("subChargecodeMaster");
		return mav;
	}

	@RequestMapping(value = "/getMainTypeList", method = RequestMethod.POST)
	public String getMainTypeList(@RequestBody String payload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMainTypeList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@RequestMapping(value = "/addSubType", method = RequestMethod.POST)
	public String addSubType(@RequestBody Map<String, Object> subTypePayload,
							 HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(subTypePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSubType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllSubTypeDetails", method = RequestMethod.POST)
	public String getAllSubTypeDetails(@RequestBody String mainChargecodePayload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSubTypeDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, mainChargecodePayload);
	}


	@RequestMapping(value="/updateSubTypeStatus", method=RequestMethod.POST)
	public String updateSubTypeStatus(@RequestBody String subtypePayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(subtypePayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateSubTypeStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}


	@RequestMapping(value = "/updateSubTypeDetails", method = RequestMethod.POST)
	public String updateSubTypeDetails(@RequestBody String subtypePayload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSubTypeDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, subtypePayload);
	}


	/**************************************
	 * Vendor Type Master
	 **************************************************/
	/**
	 * @param VendorTypeMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/vendorTypeMaster", method = RequestMethod.GET)
	public ModelAndView vendorTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("vendorTypeMaster");
		return mav;
	}

	@RequestMapping(value = "/addvendorType", method = RequestMethod.POST)
	public String addvendorType(@RequestBody Map<String, Object> vendorTypePayload, HttpServletRequest request,
								HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(vendorTypePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addVendorType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllVendorType", method = RequestMethod.POST)
	public String getAllVendorType(@RequestBody String vendorTypePayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllVendorType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, vendorTypePayload);
	}

	@RequestMapping(value = "/updateVendorTypeDetails", method = RequestMethod.POST)
	public String updateVendorTypeDetails(@RequestBody String vendorTypePayload, HttpServletRequest request,
										  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(vendorTypePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateVendorTypeDetails");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateVendorTypeStatus", method = RequestMethod.POST)
	public String updateVendorTypeStatus(@RequestBody String vendorTypePayload, HttpServletRequest request,
										 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateVendorTypeStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, vendorTypePayload);
	}



	/**************************************
	 * Sample Container Master
	 **************************************************/
	/**
	 * @param Sample Container Master
	 * @param request
	 * @param response
	 * @return
	 */


	@RequestMapping(value = "/sampleContainer", method = RequestMethod.GET)
	public ModelAndView sampleContainer(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("sampleContainerMaster");
		return mav;
	}



	@RequestMapping(value = "/addSampleContainer", method = RequestMethod.POST)
	public String addSampleContainer(@RequestBody String scPayload,
									 HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(scPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSampleContainer");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}


	@RequestMapping(value = "/getAllSampleContainer", method = RequestMethod.POST)
	public String getAllSampleContainer(@RequestBody String samplePayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSampleContainer");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, samplePayload);
	}


	@RequestMapping(value="/updateSampleContainerStatus", method=RequestMethod.POST)
	public String updateSampleContainerStatus(@RequestBody String subtypePayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(subtypePayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateSampleContainerStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}


	@RequestMapping(value = "/updateSampleContainer", method = RequestMethod.POST)
	public String updateSampleContainer(@RequestBody String samplePayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSampleContainer");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, samplePayload);
	}



	/**************************************
	 * Investigation UOM Master
	 **************************************************/
	/**
	 * @param Investigation UOM Master
	 * @param request
	 * @param response
	 * @return
	 */


	@RequestMapping(value = "/investigationUOM", method = RequestMethod.GET)
	public ModelAndView investigationUOM(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("investigationUOM");
		return mav;
	}

	@RequestMapping(value = "/addInvestigationUOM", method = RequestMethod.POST)
	public String addInvestigationUOM(@RequestBody String uomPayload,
									  HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(uomPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addInvestigationUOM");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllInvestigationUOM", method = RequestMethod.POST)
	public String getAllInvestigationUOM(@RequestBody String samplePayload, HttpServletRequest request,
										 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllInvestigationUOM");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, samplePayload);
	}

	/**************************************
	 *Vendor Master
	 **************************************************/
	/**
	 * @param VendorMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/vendorMaster", method = RequestMethod.GET)
	public ModelAndView vendorMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("vendorMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllVendorDetails", method = RequestMethod.POST)
	public String getAllVendorDetails(@RequestBody String vendorPayload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllVendor");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, vendorPayload);
	}

	@RequestMapping(value = "/addVendor", method = RequestMethod.POST)
	public String addVendor(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
							HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addVendor");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateVendorDetails", method = RequestMethod.POST)
	public String updateVendorDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
									  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateVendor");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateVendorStatus", method = RequestMethod.POST)
	public String updateVendorStatus(@RequestBody String activeStatusItemPayload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateVendorStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusItemPayload);
	}

	@RequestMapping(value = "/updateInvestigationUOM", method = RequestMethod.POST)
	public String updateInvestigationUOM(@RequestBody String uomPayload, HttpServletRequest request,
										 HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(uomPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateInvestigationUOM");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}


	@RequestMapping(value = "/updateInvestigationUOMStatus", method = RequestMethod.POST)
	public String updateInvestigationUOMStatus(@RequestBody String uomPayload, HttpServletRequest request,
											   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateInvestigationUOMStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, uomPayload);
	}


	@RequestMapping(value = "/updateDepartmentTypeStatus", method = RequestMethod.POST)
	public String updateDepartmentTypeStatus(@RequestBody String departmentTypePayload, HttpServletRequest request,
											 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDepartmentTypeStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, departmentTypePayload);
	}

	@RequestMapping(value = "/getStateList", method = RequestMethod.POST)
	public String getStateList(@RequestBody String payload, HttpServletRequest
			request, HttpServletResponse response) { MultiValueMap<String, String>
			requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL =
				HMSUtil.getProperties("urlextension.properties", "getStateList"); String
				OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);

	}
	@RequestMapping(value = "/getDistrictList", method = RequestMethod.POST)
	public String getDistrictList(@RequestBody String payload, HttpServletRequest
			request, HttpServletResponse response) { MultiValueMap<String, String>
			requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL =
				HMSUtil.getProperties("urlextension.properties", "getDistrictList"); String
				OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);

	}

	@RequestMapping(value = "/getDistrictListById", method = RequestMethod.POST)
	public String getDistrictListById(@RequestBody String payload, HttpServletRequest
			request, HttpServletResponse response) { MultiValueMap<String, String>
			requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL =
				HMSUtil.getProperties("urlextension.properties", "getDistrictListById"); String
				OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);

	}


	/**************************************
	 * Investigation Master
	 **************************************************/
	/**
	 * @param Investigation Master
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/investigationMaster", method = RequestMethod.GET)
	public ModelAndView investigationMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("labInvestigationMaster");
		return mav;
	}


	@RequestMapping(value = "/getAllMainChargeList", method = RequestMethod.POST)
	public String getAllMainChargeList(@RequestBody String payload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMainChargeList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getAllModalityList", method = RequestMethod.POST)
	public String getAllModalityList(@RequestBody String payload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllModalityList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@RequestMapping(value = "/getAllSampleList", method = RequestMethod.POST)
	public String getAllSampleList(@RequestBody String payload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSampleList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getAllCollectionList", method = RequestMethod.POST)
	public String getAllCollectionList(@RequestBody String payload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCollectionList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getAllUOMList", method = RequestMethod.POST)
	public String getAllUOMList(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllUOMList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@RequestMapping(value = "/addInvestigation", method = RequestMethod.POST)
	public String addInvestigation(@RequestBody String invPayload,
								   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(invPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addInvestigation");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllInvestigationDetails", method = RequestMethod.POST)
	public String getAllInvestigationDetails(@RequestBody String invPayload, HttpServletRequest request,
											 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllInvestigationDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, invPayload);
	}


	@RequestMapping(value="/updateInvestigationStatus", method=RequestMethod.POST)
	public String updateInvestigationStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateInvestigationStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateInvestigation", method = RequestMethod.POST)
	public String updateInvestigation(@RequestBody String uomPayload, HttpServletRequest request,
									  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(uomPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateInvestigation");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	/**************************************
	 *Item Non Drug Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/itemNonDrugMaster", method = RequestMethod.GET)
	public ModelAndView itemNonDrugMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("itemNonDrugMaster");
		return mav;

	}



	/**************************************
	 *Sub Investigation Master
	 **************************************************/
	/**
	 * * @param Sub Investigation Master
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/subInvestigationMaster", method = RequestMethod.GET)
	public ModelAndView subInvestigationMaster(@RequestParam HashMap<String,String> params, HttpServletRequest request, HttpServletResponse response) {

		JSONObject jsondata=new JSONObject(params);
		ModelAndView mav = new ModelAndView("subInvestigationMaster");
		String data = getAllUOMList("{}", request,response);
		mav.addObject("data", data);
		mav.addObject("invData",jsondata);
		String subInvestigationData=getAllSubInvestigationDetails(jsondata.toString(), request,response);
		mav.addObject("subInvData",subInvestigationData);
		return mav;

	}


	@RequestMapping(value = "/getAllSubInvestigationDetails", method = RequestMethod.POST)
	public String getAllSubInvestigationDetails(@RequestBody String subPayload, HttpServletRequest request,
												HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSubInvestigationDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, subPayload);
	}


	@RequestMapping(value = "/updateSubInvestigation", method = RequestMethod.POST)
	public String updateSubInvestigation(@RequestBody Map<String, Object> requestPayload,
										 HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSubInvestigation");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}


	@RequestMapping(value = "/deleteSunbInvestigationById", method = RequestMethod.POST)
	public String deleteSunbInvestigationById(@RequestBody Map<String, Object> requestPayload,
											  HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "deleteSunbInvestigationById");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	/**************************************
	 *DepartmentAndDoctorMappingMaster Master
	 **************************************************/
	/**
	 * @param DepartmentAndDoctorMappingMasterMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/departmentAndDoctorMappingMaster", method = RequestMethod.GET)
	public ModelAndView departmentAndDoctorMappingMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("departmentAndDoctorMappingMaster");
		return mav;
	}

	@RequestMapping(value = "/getAllDepartmentAndDoctorMapping", method = RequestMethod.POST)
	public String getAllDepartmentAndDoctorMapping(@RequestBody String sectionPayload, HttpServletRequest request,
												   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllDepartmentAndDoctorMapping");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, sectionPayload);
	}

	@RequestMapping(value = "/addDepartmentAndDoctorMapping", method = RequestMethod.POST)
	public String addDepartmentAndDoctorMapping(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
												HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addDepartmentAndDoctorMapping");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateDepartmentAndDoctorMapping", method = RequestMethod.POST)
	public String updateDepartmentAndDoctorMapping(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
												   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateDepartmentAndDoctorMapping");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateDepartmentAndDoctorMappingStatus", method = RequestMethod.POST)
	public String updateDepartmentAndDoctorMappingStatus(@RequestBody String activeStatusSectionPayload, HttpServletRequest request,
														 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "statusDepartmentAndDoctorMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusSectionPayload);
	}

	/***************************************
	 Radiology Investigation  Master
	 **************************************************/

	@RequestMapping(value = "/radInvestigationMaster", method = RequestMethod.GET)
	public ModelAndView radioInvestigationMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("radInvestigationMaster");
		return mav;
	}

	/**************************************
	 *Employee Master
	 **************************************************/
	/**
	 * @param employeeMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/employeeMaster", method = RequestMethod.GET)
	public ModelAndView employeeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("employeeMaster");
		return mav;
	}

	@RequestMapping(value = "/getAllEmployee", method = RequestMethod.POST)
	public String getAllEmployee(@RequestBody String employeePayload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllEmployee");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, employeePayload);
	}

	@RequestMapping(value = "/getAllUnitList", method = RequestMethod.POST)
	public String getAllUnitList(@RequestBody String payload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllUnitList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	/**************************************
	 *Fixed Value Master
	 **************************************************/
	/**
	 * @param fixed value Master
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/fixedValueMaster", method = RequestMethod.GET)
	public ModelAndView fixedValueMaster(@RequestParam HashMap<String,String> params, HttpServletRequest request, HttpServletResponse response) {

		JSONObject jsondata=new JSONObject(params);
		ModelAndView mav = new ModelAndView("fixedValueMaster");
		mav.addObject("subInvId", jsondata);
		String fixedValueData=getAllFixeValueById(jsondata.toString(), request, response);
		mav.addObject("fixedValueData", fixedValueData);

		return mav;

	}

	@RequestMapping(value = "/updateFixedValue", method = RequestMethod.POST)
	public String updateFixedValue(@RequestBody Map<String, Object> requestPayload,
								   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateFixedValue");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/validateFixedValue", method = RequestMethod.POST)
	public String validateFixedValue(@RequestBody String fvPayload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "validateFixedValue");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, fvPayload);
	}


	@RequestMapping(value = "/getAllFixeValueById", method = RequestMethod.POST)
	public String getAllFixeValueById(@RequestBody String subPayload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllFixeValueById");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, subPayload);
	}


	/**************************************
	 *Normal Value Master
	 **************************************************/
	/**
	 * @param normal value Master
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/normalValueMaster", method = RequestMethod.GET)
	public ModelAndView normalValueMaster(@RequestParam HashMap<String,String> params, HttpServletRequest request, HttpServletResponse response) {

		JSONObject jsondata=new JSONObject(params);
		ModelAndView mav = new ModelAndView("normalValueMaster");
		JSONObject json=new JSONObject();
		json.put("PN", 1);
		String data = getAllAdministrativeSex(json.toString(), request,response);
		mav.addObject("sexData", data);
		mav.addObject("subInvId", Long.parseLong(jsondata.get("subInvId").toString()));
		mav.addObject("subInvData",jsondata);
		String normalValueData=getAllNormalValueById(jsondata.toString(), request, response);
		mav.addObject("normalValueData", normalValueData);

		return mav;

	}

	@RequestMapping(value = "/updateNormalValue", method = RequestMethod.POST)
	public String updateNormalValue(@RequestBody Map<String, Object> requestPayload,
									HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateNormalValue");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllNormalValueById", method = RequestMethod.POST)
	public String getAllNormalValueById(@RequestBody String subPayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllNormalValueById");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, subPayload);
	}

	@RequestMapping(value = "/validateServiceNo", method = RequestMethod.POST)
	public String validateServiceNo(@RequestBody String fvPayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "validateServiceNo");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, fvPayload);
	}

	/**************************************
	 * Discharge Status Master
	 **************************************************/
	/**
	 * @param DischargeStatusMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/dischargeStatusMaster", method = RequestMethod.GET)
	public ModelAndView dischargeStatusMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("dischargeStatusMaster");
		return mav;
	}

	@RequestMapping(value = "/addDischargeStatus", method = RequestMethod.POST)
	public String addDischargeStatus(@RequestBody Map<String, Object> dischargeStatusPayload,
									 HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(dischargeStatusPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDischargeStatus");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllDischargeStatus", method = RequestMethod.POST)
	public String getAllDischargeStatus(@RequestBody String dischargeStatusPayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDischargeStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dischargeStatusPayload);
	}

	@RequestMapping(value = "/updateDischargeStatusDetails", method = RequestMethod.POST)
	public String updateDischargeStatusDetails(@RequestBody String dischargeStatusPayload,
											   HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDischargeStatusDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dischargeStatusPayload);

	}

	@RequestMapping(value = "/updateDischargeStatusStatus", method = RequestMethod.POST)
	public String updateDischargeStatusStatus(@RequestBody String dischargeStatusPayload,
											  HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDischargeStatusStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dischargeStatusPayload);
	}


	/**************************************
	 * Bed Status Master
	 **************************************************/
	/**
	 * @param BedStatusMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/bedStatusMaster", method = RequestMethod.GET)
	public ModelAndView bedStatusMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("bedStatusMaster");
		return mav;
	}

	@RequestMapping(value = "/addBedStatus", method = RequestMethod.POST)
	public String addBedStatus(@RequestBody Map<String, Object> bedStatusPayload,
							   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(bedStatusPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addBedStatus");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllBedStatus", method = RequestMethod.POST)
	public String getAllBedStatus(@RequestBody String bedStatusPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllBedStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bedStatusPayload);
	}

	@RequestMapping(value = "/updateBedStatusDetails", method = RequestMethod.POST)
	public String updateBedStatusDetails(@RequestBody String bedStatusPayload,
										 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateBedStatusDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bedStatusPayload);

	}

	@RequestMapping(value = "/updateBedStatusStatus", method = RequestMethod.POST)
	public String updateBedStatusStatus(@RequestBody String bedStatusPayload,
										HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateBedStatusStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bedStatusPayload);
	}

	/**************************************
	 *Bed Master
	 **************************************************/
	/**
	 * @param DepartmentAndDoctorMappingMasterMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/bedMaster", method = RequestMethod.GET)
	public ModelAndView bedMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("bedMaster");
		return mav;
	}

	@RequestMapping(value = "/getAllBed", method = RequestMethod.POST)
	public String getAllBed(@RequestBody String sectionPayload, HttpServletRequest request,
							HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllBed");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, sectionPayload);
	}

	@RequestMapping(value = "/addBed", method = RequestMethod.POST)
	public String addBed(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
						 HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addBed");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateBed", method = RequestMethod.POST)
	public String updateBed(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
							HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateBed");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateBedStatus", method = RequestMethod.POST)
	public String updateBedStatus(@RequestBody String activeStatusSectionPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateBedStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusSectionPayload);
	}

	/**************************************
	 * Speciality Master
	 **************************************************/
	/**
	 * @param SpecialtyMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/specialityMaster", method = RequestMethod.GET)
	public ModelAndView specialityMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("specialityMaster");
		return mav;
	}

	@RequestMapping(value = "/addSpeciality", method = RequestMethod.POST)
	public String addSpeciality(@RequestBody Map<String, Object> specialityPayload,
								HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(specialityPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSpeciality");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllSpeciality", method = RequestMethod.POST)
	public String getAllSpeciality(@RequestBody String specialityPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSpeciality");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, specialityPayload);
	}

	@RequestMapping(value = "/updateSpecialityDetails", method = RequestMethod.POST)
	public String updateSpecialityDetails(@RequestBody String specialityPayload,
										  HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSpecialityDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, specialityPayload);

	}

	@RequestMapping(value = "/updateSpecialityStatus", method = RequestMethod.POST)
	public String updateSpecialityStatus(@RequestBody String specialityPayload,
										 HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSpecialityStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, specialityPayload);
	}


	/**************************************
	 * Admission Type Master
	 **************************************************/
	/**
	 * @param admissionTypeMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/admissionTypeMaster", method = RequestMethod.GET)
	public ModelAndView admissionTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("admissionTypeMaster");
		return mav;
	}

	@RequestMapping(value = "/addAdmissionType", method = RequestMethod.POST)
	public String addAdmissionType(@RequestBody Map<String, Object> admissionTypePayload,
								   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(admissionTypePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addAdmissionType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllAdmissionType", method = RequestMethod.POST)
	public String getAllAdmissionType(@RequestBody String admissionTypePayload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllAdmissionType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, admissionTypePayload);
	}

	@RequestMapping(value = "/updateAdmissionTypeDetails", method = RequestMethod.POST)
	public String updateAdmissionTypeDetails(@RequestBody String admissionTypePayload,
											 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateAdmissionTypeDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, admissionTypePayload);

	}

	@RequestMapping(value = "/updateAdmissionTypeStatus", method = RequestMethod.POST)
	public String updateAdmissionTypeStatus(@RequestBody String admissionTypePayload,
											HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateAdmissionTypeStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, admissionTypePayload);
	}

	/**************************************
	 * Disposed To Master
	 **************************************************/
	/**
	 * @param disposedToMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/disposedToMaster", method = RequestMethod.GET)
	public ModelAndView disposedToMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("disposedToMaster");
		return mav;
	}

	@RequestMapping(value = "/addDisposedTo", method = RequestMethod.POST)
	public String addDisposedTo(@RequestBody Map<String, Object> disposedToPayload,
								HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(disposedToPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDisposedTo");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllDisposedTo", method = RequestMethod.POST)
	public String getAllDisposedTo(@RequestBody String disposedToPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDisposedTo");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, disposedToPayload);
	}

	@RequestMapping(value = "/updateDisposedToDetails", method = RequestMethod.POST)
	public String updateDisposedToDetails(@RequestBody String disposedToPayload,
										  HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDisposedToDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, disposedToPayload);

	}

	@RequestMapping(value = "/updateDisposedToStatus", method = RequestMethod.POST)
	public String updateDisposedToStatus(@RequestBody String disposedToPayload,
										 HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDisposedToStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, disposedToPayload);
	}


	/**************************************
	 * PatientCondition Master
	 **************************************************/
	/**
	 * @param conditionMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/patientConditionMaster", method = RequestMethod.GET)
	public ModelAndView patientConditionMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("patientConditionMaster");
		return mav;
	}

	@RequestMapping(value = "/addCondition", method = RequestMethod.POST)
	public String addCondition(@RequestBody Map<String, Object> conditionPayload,
							   HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(conditionPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addCondition");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllCondition", method = RequestMethod.POST)
	public String getAllCondition(@RequestBody String conditionPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCondition");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, conditionPayload);
	}

	@RequestMapping(value = "/updateConditionDetails", method = RequestMethod.POST)
	public String updateConditionDetails(@RequestBody String conditionPayload,
										 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateConditionDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, conditionPayload);

	}

	@RequestMapping(value = "/updateConditionStatus", method = RequestMethod.POST)
	public String updateConditionStatus(@RequestBody String conditionPayload,
										HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateConditionStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, conditionPayload);
	}

	/**************************************
	 * Diet Master
	 **************************************************/
	/**
	 * @param dietMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/dietMaster", method = RequestMethod.GET)
	public ModelAndView dietMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("dietMaster");
		return mav;
	}

	@RequestMapping(value = "/addDiet", method = RequestMethod.POST)
	public String addDiet(@RequestBody Map<String, Object> dietPayload,
						  HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(dietPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDiet");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllDiet", method = RequestMethod.POST)
	public String getAllDiet(@RequestBody String dietPayload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDiet");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dietPayload);
	}

	@RequestMapping(value = "/updateDietDetails", method = RequestMethod.POST)
	public String updateDietDetails(@RequestBody String dietPayload,
									HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDietDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dietPayload);

	}

	@RequestMapping(value = "/updateDietStatus", method = RequestMethod.POST)
	public String updateDietStatus(@RequestBody String dietPayload,
								   HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDietStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dietPayload);
	}

	/**************************************
	 *NIV Drug Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/nivDrugMaster", method = RequestMethod.GET)
	public ModelAndView nivDrugMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("nivDrugMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllNivDetails", method = RequestMethod.POST)
	public String getAllNivDetails(@RequestBody String nivPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllNiv");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, nivPayload);
	}




	/**************************************
	 *DISEASE Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/diseaseMaster", method = RequestMethod.GET)
	public ModelAndView diseaseMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("diseaseMaster");
		return mav;

	}


	@RequestMapping(value = "/addDisease", method = RequestMethod.POST)
	public String addDisease(@RequestBody Map<String, Object> dietPayload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(dietPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDisease");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}


	@RequestMapping(value = "/getAllDisease", method = RequestMethod.POST)
	public String getAllDisease(@RequestBody String dietPayload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDisease");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dietPayload);
	}


	@RequestMapping(value="/updateDiseaseStatus", method=RequestMethod.POST)
	public String updateDiseaseStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateDiseaseStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}


	@RequestMapping(value = "/updateDisease", method = RequestMethod.POST)
	public String updateDisease(@RequestBody String dietPayload,
								HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDisease");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dietPayload);

	}


	/**************************************
	 *DOCUMENT Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/documentMaster", method = RequestMethod.GET)
	public ModelAndView documentMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("documentMaster");
		return mav;

	}

	@RequestMapping(value = "/addDocument", method = RequestMethod.POST)
	public String addDocument(@RequestBody Map<String, Object> dietPayload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(dietPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDocument");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllDocument", method = RequestMethod.POST)
	public String getAllDocument(@RequestBody String dietPayload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDocument");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, dietPayload);
	}

	@RequestMapping(value="/updateDocumentStatus", method=RequestMethod.POST)
	public String updateDocumentStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateDocumentStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateDocument", method = RequestMethod.POST)
	public String updateDocument(@RequestBody String docPayload,
								 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDocument");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, docPayload);

	}

	/**************************************
	 *Bank Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/bankMaster", method = RequestMethod.GET)
	public ModelAndView bankMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("bankMaster");
		return mav;

	}

	@RequestMapping(value = "/addBank", method = RequestMethod.POST)
	public String addBank(@RequestBody Map<String, Object> bankPayload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(bankPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addBank");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateBankStatus", method=RequestMethod.POST)
	public String updateBankStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateBankStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/getAllBank", method = RequestMethod.POST)
	public String getAllBank(@RequestBody String bankPayload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllBank");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bankPayload);
	}

	@RequestMapping(value = "/updateBankDetails", method = RequestMethod.POST)
	public String updateBankDetails(@RequestBody String bankPayload,
									HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateBankDetails");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, bankPayload);

	}


	/**************************************
	 *Account Type Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/accountTypeMaster", method = RequestMethod.GET)
	public ModelAndView accountTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("accountTypeMaster");
		return mav;

	}

	@RequestMapping(value = "/addAccountType", method = RequestMethod.POST)
	public String addAccountType(@RequestBody Map<String, Object> bankPayload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(bankPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addAccountType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateAccountTypeStatus", method=RequestMethod.POST)
	public String updateAccountTypeStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateAccountTypeStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/getAllAccountType", method = RequestMethod.POST)
	public String getAllAccountType(@RequestBody String actPayload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllAccountType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, actPayload);
	}

	@RequestMapping(value = "/updateAccountType", method = RequestMethod.POST)
	public String updateAccountType(@RequestBody String actPayload,
									HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateAccountType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, actPayload);

	}

	/**************************************
	 * Diagnosis Master
	 **************************************************/
	/**
	 * @param BloodGroupMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/diagnosisMaster", method = RequestMethod.GET)
	public ModelAndView diagnosisMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("diagnosisMaster");
		return mav;
	}

	@RequestMapping(value = "/addDiagnosis", method = RequestMethod.POST)
	public String addDiagnosis(@RequestBody Map<String, Object> diagnosisPayload, HttpServletRequest request,
							   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(diagnosisPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDiagnosis");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllDiagnosis", method = RequestMethod.POST)
	public String getAllDiagnosis(@RequestBody String diagnosisPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDiagnosis");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, diagnosisPayload);
	}

	@RequestMapping(value = "/updateDiagnosis", method = RequestMethod.POST)
	public String updateDiagnosis(@RequestBody String diagnosisPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDiagnosis");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, diagnosisPayload);
	}

	@RequestMapping(value = "/updateDiagnosisStatus", method = RequestMethod.POST)
	public String updateDiagnosisStatus(@RequestBody String diagnosisPayload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDiagnosisStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, diagnosisPayload);
	}

	/**************************************
	 * Medical Exam Schedule Master
	 **************************************************/
	/**
	 * @param medicalExamScheduleMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/medicalExamScheduleMaster", method = RequestMethod.GET)
	public ModelAndView medicalExamScheduleMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("medicalExamScheduleMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllMedicalExamScheduleDetails", method = RequestMethod.POST)
	public String getAllMedicalExamScheduleDetails(@RequestBody String medicalExamSchedulePayload, HttpServletRequest request,
												   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllMedicalExamSchedule");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, medicalExamSchedulePayload);
	}

	@RequestMapping(value = "/addMedicalExamSchedule", method = RequestMethod.POST)
	public String addMedicalExamSchedule(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
										 HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addMedicalExamSchedule");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateMedicalExamScheduleDetails", method = RequestMethod.POST)
	public String updateMedicalExamScheduleDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
												   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateMedicalExamSchedule");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateMedicalExamScheduleStatus", method = RequestMethod.POST)
	public String updateMedicalExamScheduleStatus(@RequestBody String activeStatusMedicalExamSchedulePayload, HttpServletRequest request,
												  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "medicalExamScheduleStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusMedicalExamSchedulePayload);
	}
	@RequestMapping(value="/getRankCategoryList", method=RequestMethod.POST)
	public String getRankCategoryList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getRankCategoryList");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());

	}

	/**************************************
	 * FWC Master
	 **************************************************/
	/**
	 * @param FWCMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/fwcMaster", method = RequestMethod.GET)
	public ModelAndView fwcMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("fwcMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllFWCDetails", method = RequestMethod.POST)
	public String getAllFWCDetails(@RequestBody String fwcPayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllFWC");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, fwcPayload);
	}

	@RequestMapping(value = "/addFWC", method = RequestMethod.POST)
	public String addFWC(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
						 HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(requestPayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","addFWC");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateFWCDetails", method = RequestMethod.POST)
	public String updateFWCDetails(@RequestBody HashMap<String, Object> payload, HttpServletRequest request,
								   HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateFWC");
		String OSBURL = IpAndPortNo + Url;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateFWCStatus", method = RequestMethod.POST)
	public String updateFWCStatus(@RequestBody String activeStatusItemClassPayload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "statusFWC");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, activeStatusItemClassPayload);
	}

	@RequestMapping(value = "/getMIRoomList", method = RequestMethod.POST)
	public String getMIRoomList(@RequestBody String payload, HttpServletRequest
			request, HttpServletResponse response) { MultiValueMap<String, String>
			requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL =
				HMSUtil.getProperties("urlextension.properties", "getMIRoomList"); String
				OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);

	}

	/**************************************
	 *DISEASE TYPE Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/diseaseTypeMaster", method = RequestMethod.GET)
	public ModelAndView diseaseTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("diseaseTypeMaster");
		return mav;

	}

	@RequestMapping(value = "/addDiseaseType", method = RequestMethod.POST)
	public String addDiseaseType(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDiseaseType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllDiseaseType", method = RequestMethod.POST)
	public String getAllDiseaseType(@RequestBody String payload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDiseaseType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateDiseaseTypeStatus", method=RequestMethod.POST)
	public String updateDiseaseTypeStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateDiseaseTypeStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateDiseaseType", method = RequestMethod.POST)
	public String updateDiseaseType(@RequestBody String payload,
									HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDiseaseType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	/**************************************
	 *DISEASE MAPPING Master
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/diseaseMappingMaster", method = RequestMethod.GET)
	public ModelAndView diseaseMappingMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("diseaseMappingMaster");
		return mav;

	}

	@RequestMapping(value = "/addDiseaseMapping", method = RequestMethod.POST)
	public String addDiseaseMapping(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDiseaseMapping");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	@RequestMapping(value = "/getAllDiseaseMapping", method = RequestMethod.POST)
	public String getAllDiseaseMapping(@RequestBody String payload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDiseaseMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateDiseaseMappingStatus", method=RequestMethod.POST)
	public String updateDiseaseMappingStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateDiseaseMappingStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	@RequestMapping(value = "/updateDiseaseMapping", method = RequestMethod.POST)
	public String updateDiseaseMapping(@RequestBody String payload,
									   HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDiseaseMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/identificationTypeMaster", method = RequestMethod.GET)
	public ModelAndView identificationTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("identificationTypeMaster");
		return mav;
	}


	/**************************************
	 *MMU Master   dated 21-08-2021
	 **************************************************/
	/**
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/mmuMaster", method = RequestMethod.GET)
	public ModelAndView mmuMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mmuMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllMMU", method = RequestMethod.POST)
	public String getAllMMU(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMMU");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/addMMU", method = RequestMethod.POST)
	public String addMMU(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addMMU");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateMMUStatus", method=RequestMethod.POST)
	public String updateMMUStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateMMUStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateMMU", method = RequestMethod.POST)
	public String updateMMU(@RequestBody String payload,
							HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateMMU");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/getAllCity", method = RequestMethod.POST)
	public String getAllCity(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCity");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
    
	
	
	@RequestMapping(value = "/getIndendeCityList", method = RequestMethod.POST)
	public String getIndendeCityList(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getIndendeCityList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getAllMMUVendor", method = RequestMethod.POST)
	public String getAllMMUVendor(@RequestBody String payload, HttpServletRequest request,
								  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMMUVendor");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getAllMMUType", method = RequestMethod.POST)
	public String getAllMMUType(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMMUType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/validateRegNo", method = RequestMethod.POST)
	public String validateRegNo(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "validateRegNo");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@RequestMapping(value = "/userTypeMaster", method = RequestMethod.GET)
	public ModelAndView userTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("userTypeMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllUserType", method = RequestMethod.POST)
	public String getAllUserType(@RequestBody String payload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllUserType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/addUserType", method = RequestMethod.POST)
	public String addUserType(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addUserType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateUserTypeStatus", method=RequestMethod.POST)
	public String updateUserTypeStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateUserTypeStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateUserType", method = RequestMethod.POST)
	public String updateUserType(@RequestBody String payload,
								 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateUserType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/cityMaster", method = RequestMethod.GET)
	public ModelAndView cityMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("cityMaster");
		return mav;

	}

	@RequestMapping(value = "/addCity", method = RequestMethod.POST)
	public String addCity(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addCity");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	@RequestMapping(value="/updateCityStatus", method=RequestMethod.POST)
	public String updateCityStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateCityStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	@RequestMapping(value = "/updateCity", method = RequestMethod.POST)
	public String updateCity(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateCity");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/getAllDistrict", method = RequestMethod.POST)
	public String getAllDistrict(@RequestBody String payload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDistrict");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/zoneMaster", method = RequestMethod.GET)
	public ModelAndView zoneMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("zoneMaster");
		return mav;

	}

	@RequestMapping(value = "/addZone", method = RequestMethod.POST)
	public String addZone(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addZone");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllZone", method = RequestMethod.POST)
	public String getAllZone(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllZone");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateZoneStatus", method=RequestMethod.POST)
	public String updateZoneStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateZoneStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateZone", method = RequestMethod.POST)
	public String updateZone(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateZone");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/wardMaster", method = RequestMethod.GET)
	public ModelAndView wardMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("wardMaster");
		return mav;

	}

	@RequestMapping(value = "/addWard", method = RequestMethod.POST)
	public String addWard(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addWard");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllWard", method = RequestMethod.POST)
	public String getAllWard(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllWard");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateWardStatus", method=RequestMethod.POST)
	public String updateWardStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateWardStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	@RequestMapping(value = "/updateWard", method = RequestMethod.POST)
	public String updateWard(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateWard");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/districtMaster", method = RequestMethod.GET)
	public ModelAndView districtMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("districtMaster");
		return mav;

	}

	@RequestMapping(value = "/addDistrict", method = RequestMethod.POST)
	public String addDistrict(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDistrict");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateDistrictStatus", method=RequestMethod.POST)
	public String updateDistrictStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateDistrictStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateDistrict", method = RequestMethod.POST)
	public String updateDistrict(@RequestBody String payload,
								 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDistrict");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/treatmentInstructionsMaster", method = RequestMethod.GET)
	public ModelAndView treatmentInstructionsMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("treatmentInstructionsMaster");
		return mav;

	}

	@RequestMapping(value = "/addTreatmentInstructions", method = RequestMethod.POST)
	public String addTreatmentInstructions(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addTreatmentInstructions");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	@RequestMapping(value = "/getAllTreatmentInstructions", method = RequestMethod.POST)
	public String getAllTreatmentInstructions(@RequestBody String payload, HttpServletRequest request,
											  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllTreatmentInstructions");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateTreatmentInstructionsStatus", method=RequestMethod.POST)
	public String updateTreatmentInstructionsStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateTreatmentInstructionsStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateTreatmentInstructions", method = RequestMethod.POST)
	public String updateTreatmentInstructions(@RequestBody String payload,
											  HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateTreatmentInstructions");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/signSymtomsMaster", method = RequestMethod.GET)
	public ModelAndView signSymtomsMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("signSymtomsMaster");
		return mav;

	}

	@RequestMapping(value = "/addSignSymtoms", method = RequestMethod.POST)
	public String addSignSymtoms(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSignSymtoms");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllSignSymtoms", method = RequestMethod.POST)
	public String getAllSignSymtoms(@RequestBody String payload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSignSymtoms");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateSignSymtomsStatus", method=RequestMethod.POST)
	public String updateSignSymtomsStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateSignSymtomsStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateSignSymtoms", method = RequestMethod.POST)
	public String updateSignSymtoms(@RequestBody String payload,
									HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSignSymtoms");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/labourMaster", method = RequestMethod.GET)
	public ModelAndView labourMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("labourMaster");
		return mav;

	}

	@RequestMapping(value = "/addLabour", method = RequestMethod.POST)
	public String addLabour(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addLabour");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllLabour", method = RequestMethod.POST)
	public String getAllLabour(@RequestBody String payload, HttpServletRequest request,
							   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllLabour");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateLabourStatus", method=RequestMethod.POST)
	public String updateLabourStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateLabourStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateLabour", method = RequestMethod.POST)
	public String updateLabour(@RequestBody String payload,
							   HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateLabour");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	
	@RequestMapping(value = "/getMMUHierarchicalList", method = RequestMethod.POST)
	public String getMMUHierarchicalList(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String URL = HMSUtil.getProperties("urlextension.properties", "getMMUHierarchicalList");
			String OSBURL = IpAndPortNo + URL;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	 }
	
	@RequestMapping(value = "/deptMappingMaster", method = RequestMethod.GET)
	public ModelAndView deptMappingMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("deptMappingMaster");
		return mav;

	}
	
	
	@RequestMapping(value = "/addDeptMapping", method = RequestMethod.POST)
	public String addDeptMapping(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
			String responseObj = "";
			JSONObject jsonObject = new JSONObject(payload);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String URL = HMSUtil.getProperties("urlextension.properties", "addDeptMapping");
			String OSBURL = IpAndPortNo + URL;
			responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
			return responseObj;
		}
	
	@RequestMapping(value = "/getAllDeptMapping", method = RequestMethod.POST)
	public String getAllDeptMapping(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String URL = HMSUtil.getProperties("urlextension.properties", "getAllDeptMapping");
			String OSBURL = IpAndPortNo + URL;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	 }
	
	@RequestMapping(value="/updateDeptMappingStatus", method=RequestMethod.POST)
	public String updateDeptMappingStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {		
			JSONObject jsonObject = new JSONObject(statusPayload);	
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();		
			String Url = HMSUtil.getProperties("urlextension.properties", "updateDeptMappingStatus");
			String OSBURL = IpAndPortNo + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	 }
	
	@RequestMapping(value = "/updateDeptMapping", method = RequestMethod.POST)
	public String updateDeptMapping(@RequestBody String payload,
				HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String URL = HMSUtil.getProperties("urlextension.properties", "updateDeptMapping");
			String OSBURL = IpAndPortNo + URL;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
	}

	@RequestMapping(value = "/penaltyMaster", method = RequestMethod.GET)
	public ModelAndView penaltyMaster(){

		return new ModelAndView("penaltyMaster");
	}

	@RequestMapping(value = "/getAllPenalty", method = RequestMethod.POST)
	public String getAllPenalty(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllPenalty");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/addPenalty", method = RequestMethod.POST)
	public String addPenalty(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "addPenalty");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/updatePenalty", method = RequestMethod.POST)
	public String updatePenalty(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "updatePenalty");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/updatePenaltyStatus", method = RequestMethod.POST)
	public String updatePenaltyStatus(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "updatePenaltyStatus");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/equipmentChecklistMaster", method = RequestMethod.GET)
	public ModelAndView equipmentChecklistMaster(){

		return new ModelAndView("equipmentChecklistMaster");
	}

	@RequestMapping(value = "/getAllEquipmentChecklist", method = RequestMethod.POST)
	public String getAllEquipmentChecklist(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllEquipmentChecklist");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/addEquipmentChecklist", method = RequestMethod.POST)
	public String addEquipmentChecklist(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "addEquipmentChecklist");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/updateEquipmentChecklist", method = RequestMethod.POST)
	public String updateEquipmentChecklist(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "updateEquipmentChecklist");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/updateEquipmentChecklistStatus", method = RequestMethod.POST)
	public String updateEquipmentChecklistStatus(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "updateEquipmentChecklistStatus");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/inspectionChecklistMaster", method = RequestMethod.GET)
	public ModelAndView inspectionChecklistMaster(){

		return new ModelAndView("inspectionChecklistMaster");
	}

	@RequestMapping(value = "/getAllInspectionChecklist", method = RequestMethod.POST)
	public String getAllInspectionChecklist(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllInspectionChecklist");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/addInspectionChecklist", method = RequestMethod.POST)
	public String addInspectionChecklist(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "addInspectionChecklist");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/updateInspectionChecklist", method = RequestMethod.POST)
	public String updateInspectionChecklist(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "updateInspectionChecklist");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}

	@RequestMapping(value = "/updateInspectionChecklistStatus", method = RequestMethod.POST)
	public String updateInspectionChecklistStatus(@RequestBody Map<String, Object> payload) {

		String URL = HMSUtil.getProperties("urlextension.properties", "updateInspectionChecklistStatus");
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						new JSONObject(payload).toString()
				);
	}
	
	
	/**************************************
	 * Supplier Type Master
	 **************************************************/
	/**
	 * @param VendorTypeMaster
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/supplierTypeMaster", method = RequestMethod.GET)
	public ModelAndView supplierTypeMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("supplierTypeMaster");
		return mav;
	}

	@RequestMapping(value = "/addSupplierType", method = RequestMethod.POST)
	public String addSupplierType(@RequestBody Map<String, Object> supplierTypePayload, HttpServletRequest request,
								HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(supplierTypePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSupplierType");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllSupplierType", method = RequestMethod.POST)
	public String getAllSupplierType(@RequestBody String supplierTypePayload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSupplierType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, supplierTypePayload);
	}

	@RequestMapping(value = "/updateSupplierTypeDetails", method = RequestMethod.POST)
	public String updateSupplierTypeDetails(@RequestBody String supplierTypePayload, HttpServletRequest request,
										  HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(supplierTypePayload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSupplierTypeDetails");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/updateSupplierTypeStatus", method = RequestMethod.POST)
	public String updateSupplierTypeStatus(@RequestBody String supplierTypePayload, HttpServletRequest request,
										 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSupplierTypeStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, supplierTypePayload);
	}
	
	
	
	@RequestMapping(value = "/manufacturerMaster", method = RequestMethod.GET)
	public ModelAndView manufacturerMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("manufacturerMaster");
		return mav;

	}
	
	/**************************************
	 * Manufacturer Master
	 **************************************************/
	/**
	 
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(value = "/addManufacturer", method = RequestMethod.POST)
	public String addManufacturer(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
			String responseObj = "";
			JSONObject jsonObject = new JSONObject(payload);
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String URL = HMSUtil.getProperties("urlextension.properties", "addManufacturer");
			String OSBURL = IpAndPortNo + URL;
			responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
			return responseObj;
		}
	
	@RequestMapping(value = "/getAllManufacturer", method = RequestMethod.POST)
	public String getAllManufacturer(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String URL = HMSUtil.getProperties("urlextension.properties", "getAllManufacturer");
			String OSBURL = IpAndPortNo + URL;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	 }
	
	@RequestMapping(value="/updateManufacturerStatus", method=RequestMethod.POST)
	public String updateManufacturerStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {		
			JSONObject jsonObject = new JSONObject(statusPayload);	
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();		
			String Url = HMSUtil.getProperties("urlextension.properties", "updateManufacturerStatus");
			String OSBURL = IpAndPortNo + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	 }
	
	@RequestMapping(value = "/updateManufacturer", method = RequestMethod.POST)
	public String updateManufacturer(@RequestBody String payload,
				HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String URL = HMSUtil.getProperties("urlextension.properties", "updateManufacturer");
			String OSBURL = IpAndPortNo + URL;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
	}
	
	@RequestMapping(value = "/getAllAuditorName", method = RequestMethod.POST)
	public String getAllAuditorName(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllAuditorName");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	
	/**************************************
	 * Treatment Advice Master
	 **************************************************/
	/**
	 
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/treatmentAdviceMaster", method = RequestMethod.GET)
	public ModelAndView treatmentAdviceMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("treatmentAdviceMaster");
		return mav;

	}

	@RequestMapping(value = "/addTreatmentAdvice", method = RequestMethod.POST)
	public String addTreatmentAdvice(@RequestBody Map<String, Object> payload,
							HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addTreatmentAdvice");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllTreatmentAdvice", method = RequestMethod.POST)
	public String getAllTreatmentAdvice(@RequestBody String payload, HttpServletRequest request,
							   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllTreatmentAdvice");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/updateTreatmentAdvice", method = RequestMethod.POST)
	public String updateTreatmentAdvice(@RequestBody String payload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateTreatmentAdvice");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/updateTreatmentAdviceStatus", method = RequestMethod.POST)
	public String updateTreatmentAdviceStatus(@RequestBody String payload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateTreatmentAdviceStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value="/legacyDataMaster", method=RequestMethod.GET)
	public ModelAndView legacyDataMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("legacyDataEntry");
		return mav;

	}
	
	@RequestMapping(value = "/saveOrUpdateLgacyData", method = RequestMethod.POST)
	public String saveOrUpdateLgacyData(@RequestBody String payload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "saveOrUpdateLgacyData");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getLegacyCityMasterData", method = RequestMethod.POST)
	public String getLegacyCityMasterData(@RequestBody String payload, HttpServletRequest request,
									 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getLegacyCityMasterData");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	@RequestMapping(value = "/clusterMaster", method = RequestMethod.GET)
	public ModelAndView clusterMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("clusterMaster");
		return mav;

	}

	@RequestMapping(value = "/addCluster", method = RequestMethod.POST)
	public String addCluster(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addCluster");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllCluster", method = RequestMethod.POST)
	public String getAllCluster(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCluster");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/cityMMUMapMaster", method = RequestMethod.GET)
	public ModelAndView cityMMUMapMaster(){

		return new ModelAndView("cityMmuMap");
	}

	@RequestMapping(value = "/getAllCityMmuMapping", method = RequestMethod.POST)
	public String getAllCityMmuMapping(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCityMmuMapping");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/addCityMmuMapping", method = RequestMethod.POST)
	public String addCityMmuMapping(@RequestBody Map<String, Object> payload, HttpServletRequest request) {

		String URL = HMSUtil.getProperties("urlextension.properties", "addCityMmuMapping");
		JSONObject payloadJson = new JSONObject(payload);
		payloadJson.put("lastChangeBy", request.getSession().getAttribute("user_id"));
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						payloadJson.toString()
				);
	}

	@RequestMapping(value = "/cityClusterMapMaster", method = RequestMethod.GET)
	public ModelAndView cityClusterMapMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("clusterCityMap");
		return mav;

	}

	@RequestMapping(value = "/addCityCluster", method = RequestMethod.POST)
	public String addCityCluster(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addCityCluster");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllCityCluster", method = RequestMethod.POST)
	public String getAllCityCluster(@RequestBody String payload, HttpServletRequest request,
									HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCityCluster");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/districtClusterMapMaster", method = RequestMethod.GET)
	public ModelAndView districtClusterMapMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("clusterDistrictMap");
		return mav;

	}

	@RequestMapping(value = "/addDistrictCluster", method = RequestMethod.POST)
	public String addDistrictCluster(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addDistrictCluster");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllDistrictCluster", method = RequestMethod.POST)
	public String getAllDistrictCluster(@RequestBody String payload, HttpServletRequest request,
										HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllDistrictCluster");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getCityByCluster", method = RequestMethod.POST)
	public String getCityByCluster(@RequestBody String payload, HttpServletRequest request,
								   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getCityByCluster");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getClusterByDistrict", method = RequestMethod.POST)
	public String getClusterByDistrict(@RequestBody String payload, HttpServletRequest request,
									   HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getClusterByDistrict");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	//==========================================
	//            Society Master
	//==========================================

	@RequestMapping(value = "/societyMaster", method = RequestMethod.GET)
	public ModelAndView societyMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("societyMaster");
		return mav;

	}

	@RequestMapping(value = "/getAllSociety", method = RequestMethod.POST)
	public String getAllSociety(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllSociety");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/addSociety", method = RequestMethod.POST)
	public String addSociety(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSociety");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateSocietyStatus", method=RequestMethod.POST)
	public String updateSocietyStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateSocietyStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateSociety", method = RequestMethod.POST)
	public String updateSociety(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSociety");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	//==========================================
	//            Society-City Mapping
	//==========================================

	@RequestMapping(value = "/societyCityMapping", method = RequestMethod.GET)
	public ModelAndView societyCityMapping(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("societyCityMapping");
		return mav;

	}

	@RequestMapping(value = "/getCityList", method = RequestMethod.POST)
	public String getCityList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getCityList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
	}

	@RequestMapping(value = "/getSocietyList", method = RequestMethod.POST)
	public String getSocietyList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getSocietyList");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
	}

	@RequestMapping(value = "/getAllCitySociety", method = RequestMethod.POST)
	public String getAllCitySociety(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCitySociety");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/addSocietyCity", method = RequestMethod.POST)
	public String mapSocietyCity(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addSocietyCity");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateSocietyCityStatus", method=RequestMethod.POST)
	public String updateSocietyCityStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateSocietyCityStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateSocietyCity", method = RequestMethod.POST)
	public String updateSocietyCity(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateSocietyCity");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	//==========================================
	//            Fund Scheme Master
	//==========================================

	@RequestMapping(value = "/fundSchemeMaster", method = RequestMethod.GET)
	public ModelAndView fundSchemeMaster(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("fundSchemeMaster");
	}

	@RequestMapping(value = "/getAllFundScheme", method = RequestMethod.POST)
	public String getAllFundScheme(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllFundScheme");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/addFundSchemeMaster", method = RequestMethod.POST)
	public String addFundSchemeMaster(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addFundSchemeMaster");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateFundSchemeStatus", method=RequestMethod.POST)
	public String updateFundSchemeStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateFundSchemeStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateFundSchemeMaster", method = RequestMethod.POST)
	public String updateFundSchemeMaster(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateFundSchemeMaster");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/updateClusterStatus", method = RequestMethod.POST)
	public String updateClusterStatus(@RequestBody String payload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateClusterStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/updateDistrictClusterStatus", method = RequestMethod.POST)
	public String updateDistrictClusterStatus(@RequestBody String payload, HttpServletRequest request,
											  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateDistrictClusterStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/updateCityClusterStatus", method = RequestMethod.POST)
	public String updateCityClusterStatus(@RequestBody String payload, HttpServletRequest request,
										  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateCityClusterStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/getMMUByCityCluster", method = RequestMethod.POST)
	public String getMMUByCityCluster(@RequestBody String payload, HttpServletRequest request,
									  HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMMUByCityCluster");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	//================================================================
	//            GET  CITY FROM MMU CITY MAPPING
	//================================================================

	@RequestMapping(value = "/getMmuByCityMapping", method = RequestMethod.POST)
	public String getCityFromMmuMapping(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMmuByCityMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getAuthority", method = RequestMethod.POST)
	public String getAuthority(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAuthority");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value="/updateCityMMuStatus", method=RequestMethod.POST)
	public String updateCityMMuStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateCityMMuStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateCityMMUMapping", method = RequestMethod.POST)
	public String updateCityMMUMapping(@RequestBody String payload,
								 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateCityMMUMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	
	@RequestMapping(value = "/getMmuByDistrictId", method = RequestMethod.POST)
	public String getMmuByDistrictId(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMmuByDistrictId");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/headMaster", method = RequestMethod.GET)
	public ModelAndView masHeadMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mashead");
		return mav;

	}
	
	@RequestMapping(value="/updateHeadStatus", method=RequestMethod.POST)
	public String updateHeadStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateHeadStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	@RequestMapping(value = "/addHead", method = RequestMethod.POST)
	public String addHead(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addHead");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	@RequestMapping(value = "/getAllMasHead", method = RequestMethod.POST)
	public String getAllMasHead(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMasHead");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/updateHead", method = RequestMethod.POST)
	public String updateHead(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateHead");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	
	@RequestMapping(value = "/approvingAuthorityMaster", method = RequestMethod.GET)
	public ModelAndView approvingAuthorityMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("approvingAuthrityMaster");
		return mav;

	}
	
	@RequestMapping(value = "/addApprovalAuthority", method = RequestMethod.POST)
	public String addApprovalAuthority(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addApprovalAuthority");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	
	@RequestMapping(value = "/addApprovalAuthorityMapping", method = RequestMethod.POST)
	public String addApprovalAuthorityMapping(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addApprovalAuthorityMapping");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	
	@RequestMapping(value = "/updateApprovalAuthority", method = RequestMethod.POST)
	public String updateApprovalAuthority(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateApprovalAuthority");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	@RequestMapping(value="/updateApprovalAuthorityStatus", method=RequestMethod.POST)
	public String updateApprovalAuthorityStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateApprovalAuthorityStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	@RequestMapping(value = "/getAllApprovalAuthority", method = RequestMethod.POST)
	public String getAllApprovalAuthority(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllApprovalAuthority");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getAllOrderNumber", method = RequestMethod.POST)
	public String getAllOrderNumber(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllOrderNumber");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getMasHeadType", method = RequestMethod.POST)
	public String getMasHeadType(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMasHeadType");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getStoreFinancialYear", method = RequestMethod.POST)
	public String getStoreFinancialYear(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getStoreFinancialYear");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/checkFinalApproval", method = RequestMethod.POST)
	public String checkFinalApproval(@RequestBody String payload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "checkFinalApproval");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@RequestMapping(value = "/approvingMappingMaster", method = RequestMethod.GET)
	public ModelAndView approvingMappingMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("approvingMapping");
		return mav;

	}
	@RequestMapping(value = "/getAllApprovalAuthorityMapping", method = RequestMethod.POST)
	public String getAllApprovalAuthorityMapping(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllApprovalAuthorityMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	@RequestMapping(value = "/updateApprovalAuthorityMapping", method = RequestMethod.POST)
	public String updateApprovalAuthorityMapping(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateApprovalAuthorityMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	@RequestMapping(value="/updateApprovalAuthorityMappingStatus", method=RequestMethod.POST)
	public String updateApprovalAuthorityMappingStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateApprovalAuthorityMappingStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	@RequestMapping(value = "/financialYearMaster", method = RequestMethod.GET)
	public ModelAndView financialYearMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("financialYearMaster");
		return mav;

	}
	@RequestMapping(value = "/getAllFinancialYear", method = RequestMethod.POST)
	public String getAllFinancialYear(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllFinancialYear");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	@RequestMapping(value = "/addFinancialYear", method = RequestMethod.POST)
	public String addFinancialYear(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addFinancialYear");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	@RequestMapping(value = "/updateFinancialYear", method = RequestMethod.POST)
	public String updateFinancialYear(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateFinancialYear");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	@RequestMapping(value="/updateFinancialYearStatus", method=RequestMethod.POST)
	public String updateFinancialYearStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateFinancialYearStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/checkFinancialYear", method = RequestMethod.POST)
	public String checkFinancialYear(@RequestBody String payload, HttpServletRequest request,
								 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "checkFinancialYear");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/penaltyAuthorityConfigMaster", method = RequestMethod.GET)
	public ModelAndView penaltyAuthorityConfigMaster(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("penaltyAuthorityConfig");
		return mav;

	}
	@RequestMapping(value = "/addPenalityApprovalAuthority", method = RequestMethod.POST)
	public String addPenalityApprovalAuthority(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addPenalityApprovalAuthority");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value = "/getAllPenalityApprovalAuthority", method = RequestMethod.POST)
	public String getAllPenalityApprovalAuthority(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllPenalityApprovalAuthority");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}	

	@RequestMapping(value = "/updatePenalityApprovalAuthority", method = RequestMethod.POST)
	public String updatePenalityApprovalAuthority(@RequestBody String payload,
							 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updatePenalityApprovalAuthority");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	@RequestMapping(value="/updatePenalityApprovalAuthorityStatus", method=RequestMethod.POST)
	public String updatePenalityApprovalAuthorityStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updatePenalityApprovalAuthorityStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/upssManufacturerMapping", method = RequestMethod.GET)
	public ModelAndView upssManufacturerMapping(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("upssManufacturerMapping");
		return mav;

	}

	@RequestMapping(value = "/getAllMasStoreSupplier", method = RequestMethod.POST)
	public String getAllMasStoreSupplier(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMasStoreSupplier");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@RequestMapping(value = "/addMMUManufac", method = RequestMethod.POST)
	public String addMMUManufac(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addMMUManufac");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}

	@RequestMapping(value="/updateUpssManuStatus", method=RequestMethod.POST)
	public String updateUpssManuStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateUpssManuStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateUpssManu", method = RequestMethod.POST)
	public String updateUpssManu(@RequestBody String payload,
							HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateUpssManu");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}

	@RequestMapping(value = "/getAllUpssManu", method = RequestMethod.POST)
	public String getAllUpssManu(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllUpssManu");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/getMasPhase", method = RequestMethod.POST)
	public String getMasPhase(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMasPhase");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/upssPhaseMapping", method = RequestMethod.GET)
	public ModelAndView upssPhaseMapping(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("upssPhaseMapping");
		return mav;

	}
	
	@RequestMapping(value = "/addUpssPhaseMapping", method = RequestMethod.POST)
	public String addUpssPhaseMapping(@RequestBody Map<String, Object> payload,	HttpServletRequest request, HttpServletResponse response) {
		String responseObj = "";
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "addUpssPhaseMapping");
		String OSBURL = IpAndPortNo + URL;
		responseObj = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObj;
	}
	
	@RequestMapping(value = "/getAllUpssPhaseMapping", method = RequestMethod.POST)
	public String getAllUpssPhaseMapping(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllUpssPhaseMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value="/updateUpssPhase", method=RequestMethod.POST)
	public String updateUpssPhase(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateUpssPhase");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateUpssPhaseStatus", method = RequestMethod.POST)
	public String updateUpssPhaseStatus(@RequestBody String payload,
							HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateUpssPhaseStatus");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	
	@RequestMapping(value = "/getStoreFutureFinancialYear", method = RequestMethod.POST)
	public String getStoreFutureFinancialYear(@RequestBody String payload, HttpServletRequest request,HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getStoreFutureFinancialYear");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@RequestMapping(value = "/cityMMUPhaseMapping", method = RequestMethod.GET)
	public ModelAndView cityMMUPhaseMapping(){

		return new ModelAndView("cityMmuPhaseMap");
	}

	@RequestMapping(value = "/getAllCityMMUPhaseMapping", method = RequestMethod.POST)
	public String getAllCityMMUPhaseMapping(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCityMMUPhaseMapping");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/addCityMmuPhaseMapping", method = RequestMethod.POST)
	public String addCityMMUPhaseMapping(@RequestBody Map<String, Object> payload, HttpServletRequest request) {

		String URL = HMSUtil.getProperties("urlextension.properties", "addCityMmuPhaseMapping");
		JSONObject payloadJson = new JSONObject(payload);
		payloadJson.put("lastChangeBy", request.getSession().getAttribute("user_id"));
		return RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						payloadJson.toString()
				);
	}
	
	@RequestMapping(value="/updateCityMMuPhaseStatus", method=RequestMethod.POST)
	public String updateCityMMuPhaseStatus(@RequestBody String statusPayload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(statusPayload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateCityMMuPhaseStatus");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}

	@RequestMapping(value = "/updateCityMMUPhaseMapping", method = RequestMethod.POST)
	public String updateCityMMUPhaseMapping(@RequestBody String payload,
								 HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "updateCityMMUPhaseMapping");
		String OSBURL = IpAndPortNo + URL;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

	}
	
}
