package com.mmu.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.Comparator;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
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

import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;



@RequestMapping("/user")
@RestController
@CrossOrigin
public class UserManagementWebController {

	/**
	 * @Page manageUserApplication.jsp
	 * @param request
	 * @param response
	 * @return
	 * @param manageUserApplication method will load the User Application Page.
	 */
	
	String IpAndPortNo = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");

	@Autowired
	private Environment environment;
	
	@RequestMapping(value="/manageUserApplication", method=RequestMethod.GET)	
	public ModelAndView manageUserApplication(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("manageUserApplication");			
		return mav;			
	}
	@RequestMapping(value="/getAllUserApplication", method=RequestMethod.POST)
	public String getAllUserApplication(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ALL_USER_APPLICATION");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	
	@RequestMapping(value="/updateUserApplication", method=RequestMethod.POST)
	public String updateUserApplication(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_USER_APPLICATION");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/addUserApplication", method=RequestMethod.POST)
	public String addUserApplication(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_USER_APPLICATION");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	/**
	 * @Page manageTemplate.jsp
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/manageTemplate", method=RequestMethod.GET)	
	public ModelAndView manageTemplate(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("manageTemplate");			
		return mav;			
	}
	@RequestMapping(value="/addTemplate", method=RequestMethod.POST)
	public String addTemplate(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_TEMPLATE");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/getAllTemplate", method=RequestMethod.POST)
	public String getAllTemplate(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ALL_TEMPLATE");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/getTemplateList", method=RequestMethod.POST)
	public String getTemplateList(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_TEMPLATE_LIST");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/getModuleNameTemplateWise", method=RequestMethod.POST)
	public String getModuleNameTemplateWise(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_MODULE_NAME_TEMPLATE_WISE");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/updateTemplate", method=RequestMethod.POST)
	public String updateTemplate(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_TEMPLATE");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	/**
	 * @Page assignApplicationToTemplate.jsp
	 * @param request
	 * @param response
	 * @return
	 * @method assignApplicationToTemplate 'load the AssignApplicationToTemplate' Page
	 */
	@RequestMapping(value="/assignApplicationToTemplate", method=RequestMethod.GET)	
	public ModelAndView assignApplicationToTemplate(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("assignApplicationToTemplate");			
		return mav;			
	}
	
	@RequestMapping(value="/manageRole", method=RequestMethod.GET)	
	public ModelAndView manageRole(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("manageRole");			
		return mav;			
	}
	
	
	@RequestMapping(value="/addFormsAndReports", method=RequestMethod.GET)	
	public ModelAndView addFormsAndReports(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("addFormsAndReports");			
		return mav;			
	}
	
	@RequestMapping(value="/getApplicationAutoComplete", method=RequestMethod.POST)	
	public String getApplicationAutoComplete(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_APPLICATION_AUTO_COMPLETE");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());			
	}
	
	@RequestMapping(value="/addFormAndReports", method=RequestMethod.POST)	
	public String addFormAndReports(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_FORM_AND_REPORTS");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());			
	}
	
	@RequestMapping(value="/getAllApplicationAndTemplates", method=RequestMethod.POST)
	public String getAllApplicationAndTemplates(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ALL_APPLICATION_AND_TEMPLATES");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());	
	}
	
	
	@RequestMapping(value="/addTemplateApplication", method=RequestMethod.POST)
	public String addTemplateApplication(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_TEMPLATE_APPLICATION");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());	
	}
	
	@RequestMapping(value="/roleRights", method=RequestMethod.GET)	
	public ModelAndView croleRights(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("roleRights");			
		return mav;
			
	}
	
	@RequestMapping(value="/getRoleRightsList", method=RequestMethod.POST)
	public String getRoleRightsList(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response) {		
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ROLE_RIGHTS_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/getTemplateNameList", method=RequestMethod.POST)
	public String getTemplateNameList(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response) {		
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_TEMPLATE_NAME_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}	
	
	@RequestMapping(value="/getAssingedTemplateNameList", method=RequestMethod.POST)
	public String getAssingedTemplateNameList(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response) {		
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ASSINGEED_TEMPLATE_NAME_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/saveRolesRight", method=RequestMethod.POST)
	public String saveRolesRight(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
			HttpServletResponse response) {			
		JSONObject jsonObject = new JSONObject(requestPayload);						
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SAVE_ROLES_RIGHT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	@RequestMapping(value="/editFormsAndReport",method=RequestMethod.POST)
	public ModelAndView editFormsAndReport(HttpServletRequest request, HttpServletResponse response) {	
		ModelAndView mav = new ModelAndView("editFormsAndReport");			
		return mav;
	}
	@RequestMapping(value="/getApplicationNameFormsAndReport", method=RequestMethod.POST)
	public String getApplicationNameFormsAndReport(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_APPLICATIONNAME_FORMS_AND_REPORT");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());	
	}
	
	@RequestMapping(value="/updateAddFormsAndReport", method=RequestMethod.POST)
	public String updateAddFormsAndReport(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_ADD_FORM_AND_REPORT");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());	
	}
	
	
	
	@RequestMapping(value="/showApplicationsOnRoleBase", method=RequestMethod.POST)	
	public String showApplicationsOnRoleBase(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		HttpSession session = request.getSession();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_APPLICATION_BASED_ON_ROLE");
		String OSBURL = IpAndPortNo+Url;
		String resp= RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, requestObject);
		if(resp!=null && !resp.isEmpty()) {
			JSONObject json = new JSONObject(resp);
			JSONArray arr = json.getJSONArray(("respUserList"));
			String status = json.get("status").toString();
			if(!status.equalsIgnoreCase("0") && arr.length()>0){
				JSONObject obj = (JSONObject) arr.get(0);
				 session.setAttribute("user_id",obj.get("userId"));
				 session.setAttribute("firstName",obj.get("firstName"));
			     session.setAttribute("hospital_id",obj.get("hospitalId"));
			     session.setAttribute("user_Name",obj.get("user_Name"));
			     session.setAttribute("service_No",obj.get("service_No"));
			     session.setAttribute("hospital_Name",obj.get("hospital_Name"));
			     session.setAttribute("designationName",obj.get("designationName"));
			     
			}else {
				return resp;
			}
		}
		return resp;
	}
	
	
	
	@RequestMapping(value="/getDesignationList", method=RequestMethod.POST)
	public String getDesignationList(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response) {		
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getDesignationList");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		
	}
	
	@RequestMapping(value="/rolesAndDesignationMapping", method=RequestMethod.GET)
	public ModelAndView rolesAndDesignationMapping(HttpServletRequest request, HttpServletResponse response) {		
		return new ModelAndView("rolesAndDesignationMapping");
	}
	
	
	@RequestMapping(value="/saveroleAndDesignation", method=RequestMethod.POST)
	public String saveroleAndDesignation(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
			HttpServletResponse response) {			
		JSONObject jsonObject = new JSONObject(requestPayload);						
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "saveroleAndDesignation");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	
	@RequestMapping(value="/getRoleAndDesignationMappingList", method=RequestMethod.POST)
	public String getRoleAndDesignationMappingList(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
			HttpServletResponse response) {			
		JSONObject jsonObject = new JSONObject(requestPayload);						
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getRoleAndDesignationMappingList");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
	}
	
	
	@RequestMapping(value="/updateRoleAndDesignationMapping", method=RequestMethod.POST)
	public String updateRoleAndDesignationMapping(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateRoleAndDesignationMapping");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	//designation Master
	
	@RequestMapping(value="/designationMaster", method=RequestMethod.GET)
	public ModelAndView designationMaster(HttpServletRequest request, HttpServletResponse response) {		
		return new ModelAndView("designationMaster");
	}
	
	
	@RequestMapping(value="/getAllDesignations", method=RequestMethod.POST)
	public String getAllDesignations(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {	
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllDesignations");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());		
	}
	
	@RequestMapping(value="/updateDesignationDetails", method=RequestMethod.POST)
	public String updateDesignationDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateDesignationDetails");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/addDesignation", method=RequestMethod.POST)
	public String addDesignation(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "addDesignation");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/multipleRolesAndDesignation", method=RequestMethod.GET)
	public ModelAndView multipleRolesAndDesignation(HttpServletRequest request, HttpServletResponse response) {		
		return new ModelAndView("multipleRolesAndDesignation");
	}
	
	
	@RequestMapping(value="/submitRoleAndDesignation", method=RequestMethod.POST)
	public String submitRoleAndDesignation(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitRoleAndDesignation");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	
	@RequestMapping(value="/getMultipleRoleAndDesignation", method=RequestMethod.POST)
	public String getMultipleRoleAndDesignation(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getMultipleRoleAndDesignation");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/ldapAuthenticationUsersTest", method=RequestMethod.POST)	
	public String ldapAuthenticationUsersTest(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		boolean authResult = true ;
		HttpSession session = request.getSession();
		JSONObject json = new JSONObject(requestObject);
		
		//ActiveDirectoryAuthentication authentication = new ActiveDirectoryAuthentication("chakra.icg");
		
		String userName=json.getString("adId");
		//String password=json.getString("password");
		//System.out.println("username:" +userName);
		
		if(authResult==true) {
			String Url = HMSUtil.getProperties("urlextension.properties", "getServiceNoLdapAuth");
			String OSBURL = IpAndPortNo+Url;
			String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders,requestObject);
			
			return responseObject;
			}
			
		else
		{
			return "Username and password incorrect";
		}
		
	}
	
	@RequestMapping(value="/getServiceNoforLogin", method=RequestMethod.POST)	
	public String getServiceNoforLogin(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		JSONObject json = new JSONObject(requestObject);
		String adId= (String) json.get("adId");//Parameter("adId");
		if(adId!=null) {
			 String Url = HMSUtil.getProperties("urlextension.properties","getServiceNoLdapAuth"); 
			 String OSBURL = IpAndPortNo+Url;
			 String responseObject= RestUtils.postWithHeaders(OSBURL, requestHeaders, json.toString());
			return responseObject;
			}
		else
		{
			return "Username and password incorrect";
		}
		
	}
	
	@RequestMapping(value="/showUserManual", method=RequestMethod.GET)
	public ModelAndView showUserManual(HttpServletRequest request, HttpServletResponse response) {		
		return new ModelAndView("userManual");
	}
	
	@RequestMapping(value="/assignSequenceToApplication", method=RequestMethod.GET)	
	public ModelAndView assignSequenceToApplication(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("assignSequenceToApplication");			
		return mav;			
	}
	
	@RequestMapping(value="/getAllApplicationOfSelectedParentId", method=RequestMethod.POST)
	public String getAllApplicationOfSelectedParentId(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ALL_APPLICATION_OF_SELECTED_PARENT");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());	
	}
	
	
	@RequestMapping(value="/setSequenceToApplication", method=RequestMethod.POST)
	public String setSequenceForApplication(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SET_SEQUENCE_TO_APPLICATION");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());	
	}
	
	@RequestMapping(value="/mmuUserRegistartion", method=RequestMethod.GET)
	public ModelAndView mmuUserRegistartion(HttpServletRequest request, HttpServletResponse response) {		
		return new ModelAndView("mmuUserRegistration");
	}
	
	@RequestMapping(value="/mmuUserRegistartionPage", method=RequestMethod.GET)
	public ModelAndView mmuUserRegistartionPage(HttpServletRequest request, HttpServletResponse response) {		
		return new ModelAndView("mmuUserRegistrationPage");
	}
	
	@RequestMapping(value="/getAllUserTypeDataSDCM", method=RequestMethod.POST)
	public String getAllUserTypeDataSDCM(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllApplicationUsrTypeData");
		String OSBURL = IpAndPortNo+Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());	
	}
	
	@RequestMapping(value="/submitRoleAndTypeOfUsers", method=RequestMethod.POST)
	public String submitRoleAndTypeOfUsers(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "submitRoleAndTypeOfUsers");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/getUsersDetailsList", method=RequestMethod.POST)
	public String getUsersDetailsList(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getUsersDetailsList");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/getLoginApiSession", method=RequestMethod.POST)
	public String getLoginApiSession(@RequestBody Map<String, Object> requestObject,HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		HttpSession session = request.getSession();
		String Url = HMSUtil.getProperties("urlextension.properties", "getLoginApiSession");
		String OSBURL = IpAndPortNo+Url;
		String resp = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		if(resp!=null && !resp.isEmpty()) {
			JSONObject obj = new JSONObject(resp);
			
			//JSONArray arr = json.getJSONArray(("data"));
			//String status = json.get("status").toString();
			if(obj.get("status").equals("1")){
				//JSONObject obj = (JSONObject) arr.get(0);
				if(obj.has("mmuId"))
				{
					 session.setAttribute("mmuId",obj.get("mmuId"));
					 if(obj.has("campId"))
					 {	 
					 session.setAttribute("campId",obj.get("campId"));
				     session.setAttribute("departmentId",obj.get("departmentId"));
				     session.setAttribute("cityId",obj.get("cityId"));
				     session.setAttribute("campLocation",obj.get("campLocation"));
				     session.setAttribute("mmuName",obj.get("mmuName"));
				     session.setAttribute("departmentName",obj.get("departmentName"));
				     session.setAttribute("cityName",obj.get("cityName"));
				     session.setAttribute("campOrOff",obj.get("campOrOff"));
					 }
				}
				if(obj.has("mmuIdMultiple"))
				{
					 session.setAttribute("mmuIdMultiple",obj.get("mmuIdMultiple"));
					 //System.out.println("mmuIdMultiple111="+obj.get("mmuIdMultiple"));
				}
				if(obj.has("cityIdUsers"))
				{
					session.setAttribute("cityIdUsers",obj.get("cityIdUsers"));
				}
				if(obj.has("userTypeDesignation"))
				{
					session.setAttribute("userTypeDesignation",obj.get("userTypeDesignation"));
				}
				if(obj.has("distIdUsers"))
				{
					session.setAttribute("distIdUsers",obj.get("distIdUsers"));
				}
				if(obj.has("vendorIdUsers"))
				{
					session.setAttribute("vendorIdUsers",obj.get("vendorIdUsers"));
				}
				
			     session.setAttribute("userName",obj.get("userName"));
			     session.setAttribute("userId",obj.get("userId"));
			     session.setAttribute("user_id",obj.get("userId"));
			     if(obj.has("dispensaryCityId"))
			     {
			     session.setAttribute("dispensaryCityId",obj.get("dispensaryCityId"));
			     }
			     session.setAttribute("levelOfUser",obj.get("levelOfUser"));
			     session.setAttribute("employeeId",obj.get("employeeId"));
			     session.setAttribute("identificationTypeId",obj.get("identificationTypeId"));
			     session.setAttribute("userTypeName",obj.get("userTypeName"));
			     if(obj.has("authorityId"))
				 {
			    	 session.setAttribute("authorityId",obj.get("authorityId"));
				     session.setAttribute("authorityCode",obj.get("authorityCode"));
				     session.setAttribute("authorityName",obj.get("authorityName"));
				     session.setAttribute("approvinglevelNo",obj.get("approvinglevelNo"));
				     session.setAttribute("finalApproval",obj.get("finalApproval"));
				     session.setAttribute("approvalOrderNo",obj.get("approvalOrderNo"));
				   
				 }
			     
			     
			}else {
				return resp;
			}
		}
		return resp;
	}
	
	@RequestMapping(value="/getAllUserTypeForUserReg", method=RequestMethod.POST)
	public String getAllUserTypeForUserReg(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllUserTypeForUserReg");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/activeInactiveUsers", method=RequestMethod.POST)
	public String activeInactiveUsers(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "activeInactiveUsers");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/editUserDetails", method=RequestMethod.POST)
	public String editUserDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "editUserDetails");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/updateUsersRegistartionType", method=RequestMethod.POST)
	public String updateUsersRegistartionType(MultipartHttpServletRequest multipartHttpServletRequest) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("userId", multipartHttpServletRequest.getParameter("userId"));
		jsonObject.put("userTypeValues", multipartHttpServletRequest.getParameter("userTypeValues"));
		jsonObject.put("masRoleIdValues", multipartHttpServletRequest.getParameter("masRoleIdValues"));
		jsonObject.put("mobileNo", multipartHttpServletRequest.getParameter("mobileNo"));
		jsonObject.put("nameOfUser", multipartHttpServletRequest.getParameter("nameOfUser"));
		jsonObject.put("emailId", multipartHttpServletRequest.getParameter("emailId"));
		jsonObject.put("employeeId", multipartHttpServletRequest.getParameter("employeeId"));
		jsonObject.put("levelUsers", multipartHttpServletRequest.getParameter("levelUsers"));
		jsonObject.put("userTypeVal", multipartHttpServletRequest.getParameter("userTypeVal"));
		jsonObject.put("signatureFileName", this.uploadSignature(multipartHttpServletRequest));

		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "updateUsersRegistartionType");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}

	@RequestMapping(value = "/download")
	public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			String key = request.getParameter("key");
			String type = request.getParameter("type");
			String name = request.getParameter("name");
			String path = environment.getProperty("mmu.web.audit.basePath") + "/users/"+type+"/"+key;
			Path file = Paths.get(path, name);;

			if (Files.exists(file)) {
				if (name.indexOf(".mp4") > 0)
					response.setContentType("video/mp4");
				else if (name.indexOf(".png") > 0)
					response.setContentType("image/png");
				else if (name.indexOf(".jpg") > 0 || name.indexOf(".jpeg") > 0)
					response.setContentType("image/jpeg");
				else if (name.indexOf(".pdf") > 0)
					response.setContentType("application/pdf");
				else if (name.indexOf(".doc") > 0 || name.indexOf(".docx") > 0 || name.indexOf(".xls") > 0 || name.indexOf(".xlsx") > 0)
					response.setContentType("application/octet-stream");

				response.addHeader("Content-Disposition", "attachment; filename=" + name);
				try {
					Files.copy(file, response.getOutputStream());
					response.getOutputStream().flush();
				} catch (IOException ex) {
					ex.printStackTrace();
				}
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}
	}

	private String uploadSignature(MultipartHttpServletRequest multipartHttpServletRequest){
		String originalFileName = "";
		Iterator<String> it = multipartHttpServletRequest.getFileNames();
		String auditPath = environment.getProperty("mmu.web.audit.basePath");
		if (it.hasNext()) {
			MultipartFile file = multipartHttpServletRequest.getFile(it.next());
			originalFileName = file.getOriginalFilename();
			auditPath += "/users/signature/"+multipartHttpServletRequest.getParameter("userId");

			try {

				File folderPath = new File(auditPath);
				if(!folderPath.exists()) {
					folderPath.mkdirs();
				}
				String path = auditPath +"/"+ originalFileName;
				String existingFileName = "";
				for(File delFile: new File(auditPath).listFiles()){
					if(originalFileName != null && !originalFileName.isEmpty() && !delFile.isDirectory())
						delFile.delete();
					else if (!delFile.isDirectory()) existingFileName = delFile.getName();
				}

				if(originalFileName != null && !originalFileName.isEmpty()) {
					byte[] bytes = file.getBytes();
					File uploadedFile = new File(path);
					FileOutputStream opStream = new FileOutputStream(uploadedFile);
					opStream.write(bytes);
					opStream.flush();
					opStream.close();
				}else originalFileName = existingFileName;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return originalFileName;
	}
	
	@RequestMapping(value="/checkUserName", method=RequestMethod.POST)
	public String checkUserName(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "checkUserName");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/sendOtp", method=RequestMethod.POST)
	public String sendOtp(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "sendOtp");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/verifyOtp", method=RequestMethod.POST)
	public String verifyOtp(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "verifyOtp");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/employeeUserDetails", method=RequestMethod.POST)
	public String employeeUserDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "checkUserNameEmployee");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	

}
