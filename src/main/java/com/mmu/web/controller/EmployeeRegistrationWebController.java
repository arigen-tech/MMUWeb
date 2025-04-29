package com.mmu.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mmu.web.excel.ExportExcelAuditType;
import com.mmu.web.excel.ExportExcelDiaDidi;
import com.mmu.web.service.EmployeeRegistrationService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RequestMapping("/empRegistration")
@RestController
@CrossOrigin
public class EmployeeRegistrationWebController {
	static String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	String entitUrl = "https://www.hamarshahar.in/api/user/signup_mmu_user";

	@Autowired
	EmployeeRegistrationService es;

	@RequestMapping(value = "/employeeRegistration", method = RequestMethod.GET)
	public ModelAndView employeeRegistration(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("employeeRegistration");
		return mv;
	}

	@RequestMapping(value = "/getMMUList", method = RequestMethod.POST)
	public String getMMUList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMMUList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getEmpTypeList", method = RequestMethod.POST)
	public String getEmpTypeList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getAllUserTypeForEmpReg");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}

	
	@RequestMapping(value = "/saveEmployee", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String registerEmployee(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		////System.out.println("Input json save-->"+inputJson);
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveEmployee");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	 

	@RequestMapping(value = "/getSavedEmpList", method = RequestMethod.GET)
	public ModelAndView savedEmployeeListJsp(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "viewAndEditEmpRegistration";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/savedEmpList", method = RequestMethod.POST)
	public String savedEmpList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		return es.getSavedEmployeeList(payload, request, response);
	}

	@RequestMapping(value = "/getSavedEmployeeRecord", method = RequestMethod.GET)
	public ModelAndView getEmployeeRecord(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "editEmployeeRegistration";
		Long empRecId = Long.parseLong(request.getParameter("empRecId"));
		String payload = "{\"empRecId\":" + empRecId + "}";
		// String jsonResponse = es.getEmployeeRecord(payload, request, response);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getEmployeeDetails");
		String jsonResponse = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("empData", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getAPMWaitingList", method = RequestMethod.GET)
	public ModelAndView getAPMWaitingList(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "apmWaitingList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getAuditorWaitingList", method = RequestMethod.GET)
	public ModelAndView getAuditorWaitingList(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "auditorWaitingList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getEmployeeRecordForAPM", method = RequestMethod.GET)
	public ModelAndView getEmployeeRecordForAPM(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "apmApprovalRejection";
		Long empRecId = Long.parseLong(request.getParameter("empRecId"));
		String payload = "{\"empRecId\":" + empRecId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getEmployeeDetails");
		String jsonResponse = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("empData", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/saveAPMAction", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String saveAPMAction(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveAPMAction");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
		
	}

	@RequestMapping(value = "/getEmployeeRecordForAuditor", method = RequestMethod.GET)
	public ModelAndView getEmployeeRecordForAuditor(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "auditorApprovalRejection";
		Long empRecId = Long.parseLong(request.getParameter("empRecId"));
		String payload = "{\"empRecId\":" + empRecId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getEmployeeDetails");
		String jsonResponse = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("empData", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/saveAUDAction", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String saveAUDAction(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveAUDAction");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}

	@RequestMapping(value = "/getCHMOWaitingList", method = RequestMethod.GET)
	public ModelAndView getCHMOWaitingList(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "pendingApprovalRegRequestCHMO";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getEmployeeRecordForCHMO", method = RequestMethod.GET)
	public ModelAndView getEmployeeRecordForCHMO(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "registrationApprovalCHMO";
		Long empRecId = Long.parseLong(request.getParameter("empRecId"));
		String payload = "{\"empRecId\":" + empRecId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getEmployeeDetails");
		String jsonResponse = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("empData", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/saveCHMOAction", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String saveCHMOAction(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveCHMOAction");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}

	@RequestMapping(value = "/getUPSSWaitingList", method = RequestMethod.GET)
	public ModelAndView getUPSSWaitingList(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "pendingApprovalRegRequestUPSS";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getEmployeeRecordForUPSS", method = RequestMethod.GET)
	public ModelAndView getEmployeeRecordForUPSS(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "registrationApprovalUPSS";
		Long empRecId = Long.parseLong(request.getParameter("empRecId"));
		String payload = "{\"empRecId\":" + empRecId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getEmployeeDetails");
		String jsonResponse = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("empData", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}


	@RequestMapping(value = "/saveUPSSAction", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String saveUPSSAction(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveUPSSAction");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}

	@RequestMapping(value = "/getUplodedFile", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<InputStreamResource> getUplodedFile(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String filePath = request.getParameter("filePath");
		////System.out.println("fileId--> " + filePath);

		ResponseEntity<InputStreamResource> obj2 = null;
		File file = new File(filePath);
		URL url = file.toURI().toURL();
		////System.out.println(" URL of given file is:\t" + url);
		String sPath = file.getAbsolutePath();
		////System.out.println("sPath--> " + sPath);
		FileInputStream fis = new FileInputStream(file);
		InputStreamResource resource = new InputStreamResource(fis);
		obj2 = ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + file.getName())
				.contentType(MediaType.APPLICATION_OCTET_STREAM).contentLength(file.length()).body(resource);
		return obj2;
	}

	@RequestMapping(value = "/checkDuplicateMobile", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String checkDuplicateMobile(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "checkDuplicateMobile");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	
	@RequestMapping(value = "/getIdTypeList", method = RequestMethod.POST)
	public String getIdTypeList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIdTypeList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/pendingListAttendance", method = RequestMethod.GET)
	public ModelAndView pendingListAttendance(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("auditAttendanceList");
		return mv;
	}

	@RequestMapping(value = "/pendingListPhotoValidation", method = RequestMethod.GET)
	public ModelAndView pendingListPhotoValidation(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("photoValidationList");
		return mv;
	}
	@RequestMapping(value = "/pendingAttendanceList", method = RequestMethod.POST)
	public String pendingAttendanceList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		return es.getPendingAttendanceList(payload, request, response);
	}
	
	@RequestMapping(value = "/saveAttendance", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String saveAttendance(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		
		
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveAttendance");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	 
	@RequestMapping(value = "/pendingListPhoto", method = RequestMethod.POST)
	public String pendingListPhoto(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		return es.pendingListPhoto(payload, request, response);
	}
	
	@RequestMapping(value = "/savePhotoValidation", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String savePhotoValidation(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "savePhotoValidation");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	
	@RequestMapping(value = "/saveAttendanceAudit", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String saveAttendanceAudit(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveAttendanceAudit");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	
	@RequestMapping(value = "/showPenaltyList", method = RequestMethod.GET)
	public ModelAndView showPenaltyList(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "penaltyList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getAttendanceYears", method = RequestMethod.POST)
	public String getAttendanceYears(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getAttendanceYears");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getAttendanceMonths", method = RequestMethod.POST)
	public String getAttendanceMonths(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getAttendanceMonths");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	@RequestMapping(value = "/getPenaltyList", method = RequestMethod.POST)
	public String getPenaltyList(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		return es.getPenaltyList(payload, request, response);
	}
	

	@RequestMapping(value = "/displayAuditAttendanceHistory", method = RequestMethod.GET)
	public ModelAndView displayAuditAttendanceHistory(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("auditAttendanceHistory");
		return mv;
	}
	
	@RequestMapping(value = "/auditAttendanceHistory", method = RequestMethod.POST)
	public String auditAttendanceHistory(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		return es.auditAttendanceHistory(payload, request, response);
	}
	
	@RequestMapping(value = "/checkDuplicateIMEI", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String checkDuplicateIMEI(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "checkDuplicateIMEI");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	
	@RequestMapping(value = "/getEmpListForEdit", method = RequestMethod.GET)
	public ModelAndView getEmpListForEdit(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "editEmployeeList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/empListForEdit", method = RequestMethod.POST)
	public String empListForEdit(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		return es.getEmpListForEdit(payload, request, response);
	}
	
	@RequestMapping(value = "/getEmployeeRecordForUpdate", method = RequestMethod.GET)
	public ModelAndView getEmployeeRecordForUpdate(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "updateRegisteredEmployee";
		Long empRecId = Long.parseLong(request.getParameter("empRecId"));
		String payload = "{\"empRecId\":" + empRecId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getEmployeeRecordForUpdate");
		String jsonResponse = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("empData", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/updateEmployee", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String updateEmployee(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "updateEmployee");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	
	@RequestMapping(value = "/exportExcel", method = RequestMethod.GET)
	public ModelAndView exportExcelDiaDidi(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject requestData=new JSONObject();
		requestData.put("attnYear", request.getParameter("attnYear"));
		requestData.put("attnMonth", request.getParameter("attnMonth"));
		requestData.put("pageNo", request.getParameter("pageNo"));
		requestData.put("searchType", request.getParameter("searchType"));
		requestData.put("mmuId", request.getParameter("mmuId"));
		
		 // Convert payload to string
	    String payload = requestData.toString();
		String data= es.getPenaltyList(payload, request, response);
		JSONObject compositeResponse = new JSONObject();
		   compositeResponse.put("requestData", requestData); // Add requestData
		   compositeResponse.put("responseData", data); // Add the response data
				
	    return new ModelAndView(new ExportExcelAuditType(), "data", compositeResponse.toString());
			
	  }
}
