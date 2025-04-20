package com.mmu.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.ProjectUtils;
import com.mmu.web.utils.RestUtils;

import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.*;

import org.springframework.core.env.Environment;


@RequestMapping("/audit")
@RestController
@CrossOrigin
public class AuditWebController {
	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT").trim();

	@Autowired
	private Environment environment;

	@RequestMapping(value="/showClinicalAudit", method = RequestMethod.GET)
	public ModelAndView showRecordsForDoctorAppointment(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		String jsp = "clinicalAudit";
		return new ModelAndView(jsp, "data", "data");
	}

	@RequestMapping(value = "/captureInspectionChecklistDetails", method = RequestMethod.GET)
	public ModelAndView captureInspectionChecklistDetails(){

		return new ModelAndView("captureInspectionChecklistDetails");
	}

	@RequestMapping(value = "/captureEuipmentChecklistDetails", method = RequestMethod.GET)
	public ModelAndView captureEuipmentChecklistDetails(){

		return new ModelAndView("captureEuipmentChecklistDetails");
	}

	@RequestMapping(value = "/getAllCity", method = RequestMethod.POST)
	public String getAllCity(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCity");
		String result = RestUtils
				.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						payload
				);
		Object city = request.getSession().getAttribute("cityId");
		String[] cities = new String[0];
		JSONObject finalResult = new JSONObject();
		JSONArray finalArray = new JSONArray();
		JSONObject resultJson = new JSONObject(result);
		JSONArray data = resultJson.getJSONArray("data");
		if (city != null && !city.toString().trim().isEmpty()){
			cities = city.toString().split(",");
			for (int i=0;i<data.length();i++){
				for (int j=0;j<cities.length;j++){
					int resultCityId = data.getJSONObject(i).getInt("cityId");
					if(resultCityId == Integer.parseInt(cities[j])){
						finalArray.put(data.getJSONObject(i));
					}
				}
			}
			finalResult.put("msg", resultJson.getString("msg"));
			finalResult.put("data", finalArray);
		} else {
			finalResult = resultJson;
		}

		return finalResult.toString();
	}

	@RequestMapping(value = "/getInspectionChecklist", method = RequestMethod.POST)
	public String getInspectionChecklist(@RequestBody String payload, HttpServletRequest request,
							 HttpServletResponse response) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllInspectionChecklist");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/captureInspectionChecklistDetails", method = RequestMethod.POST)
	public String captureInspectionChecklistDetails(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletRequest request) {
		String URL = HMSUtil.getProperties("urlextension.properties", "captureInspectionChecklistDetails");
		JSONObject payloadJson = new JSONObject();
		payloadJson.put("cityId", multipartHttpServletRequest.getParameter("cityId"));
		payloadJson.put("mmuId", multipartHttpServletRequest.getParameter("mmuId"));
		payloadJson.put("inspectionDate", multipartHttpServletRequest.getParameter("inspectionDate"));
		payloadJson.put("vehicleRegNo", multipartHttpServletRequest.getParameter("vehicleRegNo"));
		payloadJson.put("mmuLocation", multipartHttpServletRequest.getParameter("mmuLocation"));
		payloadJson.put("auditStatus", multipartHttpServletRequest.getParameter("auditStatus"));
		payloadJson.put("inspectionDetailId", multipartHttpServletRequest.getParameter("inspectionDetailId"));
		payloadJson.put("checklistIds", multipartHttpServletRequest.getParameter("checklistIds"));
		payloadJson.put("inputValues", multipartHttpServletRequest.getParameter("inputValues"));
		payloadJson.put("remarks", multipartHttpServletRequest.getParameter("remarks"));
		payloadJson.put("createIncidents", multipartHttpServletRequest.getParameter("createIncidents"));
		payloadJson.put("inspectionChecklistIds", multipartHttpServletRequest.getParameter("inspectionChecklistIds"));
		payloadJson.put("apmNames", multipartHttpServletRequest.getParameter("apmNames"));
		payloadJson.put("doctorNames", multipartHttpServletRequest.getParameter("doctorNames"));
		payloadJson.put("doctorRegNos", multipartHttpServletRequest.getParameter("doctorRegNos"));
		payloadJson.put("commissionerName", multipartHttpServletRequest.getParameter("commissionerName"));
		payloadJson.put("nodalOfficerName", multipartHttpServletRequest.getParameter("nodalOfficerName"));
		payloadJson.put("tpaMember1Id", multipartHttpServletRequest.getParameter("tpaMember1Id"));
		payloadJson.put("tpaMember2Id", multipartHttpServletRequest.getParameter("tpaMember2Id"));
		payloadJson.put("campId", multipartHttpServletRequest.getParameter("campId"));
		String []uploadedFiles = this.uploadMultipleFiles(multipartHttpServletRequest, "I");
		payloadJson.put("uploadedFiles", uploadedFiles[0]);
		payloadJson.put("encodedFiles", uploadedFiles[1]);

		LocalTime time = LocalTime.now();
		payloadJson.put("inspectionTime", time.toString());
		payloadJson.put("inspectedBy", request.getSession().getAttribute("user_id"));
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJson.toString()
		);
	}

	@RequestMapping(value = "/getEquipmentChecklist", method = RequestMethod.POST)
	public String getEquipmentChecklist(@RequestBody String payload, HttpServletRequest request,
										 HttpServletResponse response) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllEquipmentChecklist");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/captureEquipmentChecklistDetails", method = RequestMethod.POST)
	public String captureEquipmentChecklistDetails(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletRequest request) {
		String URL = HMSUtil.getProperties("urlextension.properties", "captureEquipmentChecklistDetails");
		JSONObject payloadJson = new JSONObject();
		payloadJson.put("cityId", multipartHttpServletRequest.getParameter("cityId"));
		payloadJson.put("mmuId", multipartHttpServletRequest.getParameter("mmuId"));
		payloadJson.put("inspectionDate", multipartHttpServletRequest.getParameter("inspectionDate"));
		payloadJson.put("vehicleRegNo", multipartHttpServletRequest.getParameter("vehicleRegNo"));
		payloadJson.put("mmuLocation", multipartHttpServletRequest.getParameter("mmuLocation"));
		payloadJson.put("auditStatus", multipartHttpServletRequest.getParameter("auditStatus"));
		payloadJson.put("equipmentChecklistDetailId", multipartHttpServletRequest.getParameter("equipmentChecklistDetailId"));
		payloadJson.put("checklistIds", multipartHttpServletRequest.getParameter("checklistIds"));
		payloadJson.put("assignedQuantities", multipartHttpServletRequest.getParameter("assignedQuantities"));
		payloadJson.put("assignedQuantities", multipartHttpServletRequest.getParameter("assignedQuantities"));
		payloadJson.put("remarks", multipartHttpServletRequest.getParameter("remarks"));
		payloadJson.put("operationalQuantities", multipartHttpServletRequest.getParameter("operationalQuantities"));
		payloadJson.put("availableQuantities", multipartHttpServletRequest.getParameter("availableQuantities"));
		payloadJson.put("penaltyQuantities", multipartHttpServletRequest.getParameter("penaltyQuantities"));
		payloadJson.put("equipmentChecklistIds", multipartHttpServletRequest.getParameter("equipmentChecklistIds"));
		payloadJson.put("apmNames", multipartHttpServletRequest.getParameter("apmNames"));
		payloadJson.put("doctorNames", multipartHttpServletRequest.getParameter("doctorNames"));
		payloadJson.put("doctorRegNos", multipartHttpServletRequest.getParameter("doctorRegNos"));
		payloadJson.put("commissionerName", multipartHttpServletRequest.getParameter("commissionerName"));
		payloadJson.put("nodalOfficerName", multipartHttpServletRequest.getParameter("nodalOfficerName"));
		payloadJson.put("tpaMember1Id", multipartHttpServletRequest.getParameter("tpaMember1Id"));
		payloadJson.put("tpaMember2Id", multipartHttpServletRequest.getParameter("tpaMember2Id"));
		payloadJson.put("campId", multipartHttpServletRequest.getParameter("campId"));
		String uploadedFiles[] = this.uploadMultipleFiles(multipartHttpServletRequest, "E");
		payloadJson.put("uploadedFiles", uploadedFiles[0]);
		payloadJson.put("encodedFiles", uploadedFiles[1]);
		payloadJson.put("inspectedBy", request.getSession().getAttribute("user_id"));

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJson.toString()
		);
	}

	@RequestMapping(value = "/getAllMMU", method = RequestMethod.POST)
	public String getAllMMU(@RequestBody String payload, HttpServletRequest request,
												   HttpServletResponse response) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllMMU");

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/getCampLocation", method = RequestMethod.POST)
	public String getCampLocation(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getCampLocation");

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/inspectionAuditList", method = RequestMethod.GET)
	public ModelAndView inspectionAuditList(){
		return new ModelAndView("inspectionAuditList");
	}

	@RequestMapping(value = "/getAllCapturedInspectionChecklist", method = RequestMethod.POST)
	public String getAllCapturedInspectionChecklist(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCapturedInspectionChecklist");

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/equipmentAuditList", method = RequestMethod.GET)
	public ModelAndView equipmentAuditList(){
		return new ModelAndView("equipmentAuditList");
	}

	@RequestMapping(value = "/getAllCapturedEquipmentChecklist", method = RequestMethod.POST)
	public String getAllCapturedEquipmentChecklist(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllCapturedEquipmentChecklist");

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/getAllCapturedInspectionList", method = RequestMethod.GET)
	public ModelAndView getAllCapturedInspectionAuditList(){
		return new ModelAndView("allCapturedInspectionList");
	}

	@RequestMapping(value = "/getValidatedInspectionList", method = RequestMethod.GET)
	public ModelAndView getValidatedInspectionList(HttpServletRequest request){
		request.setAttribute("requestedStatus", "V");
		return new ModelAndView("allCapturedInspectionList");
	}

	@RequestMapping(value = "/getAllCapturedEquipmentList", method = RequestMethod.GET)
	public ModelAndView getAllCapturedEquipmentList(){
		return new ModelAndView("allCapturedEquipmentList");
	}

	@RequestMapping(value = "/getValidatedEquipmentList", method = RequestMethod.GET)
	public ModelAndView getValidatedEquipmentList(HttpServletRequest request){
		request.setAttribute("requestedStatus", "V");
		return new ModelAndView("allCapturedEquipmentList");
	}

	@RequestMapping(value = "/auditInspectionChecklist", method = RequestMethod.GET)
	public ModelAndView auditInspectionChecklist(HttpServletRequest request){
		request.getSession().setAttribute("inspectionChecklistDataForAudit", null);
		String detailId = request.getParameter("detail");
		if(detailId != null && !detailId.trim().isEmpty()){
			String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedInspectionChecklist");
			Long inspectionDetailId = Long.parseLong(detailId);
			JSONObject payload = new JSONObject();
			payload.put("PN", 0);
			payload.put("inspectionDetailId", inspectionDetailId);
			String inspectionData = RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload.toString()
			);
			request.getSession().setAttribute("inspectionChecklistDataForAudit", inspectionData);
		}
		return new ModelAndView("auditInspectionChecklist");
	}

	@RequestMapping(value = "/inspectionChecklistDataForAudit", method = RequestMethod.POST)
	public String inspectionChecklistDataForAudit(@RequestBody String payload, HttpServletRequest request) {
		String data = null;
		Object inspectionChecklistDataForAudit = request.getSession().getAttribute("inspectionChecklistDataForAudit");
		if (inspectionChecklistDataForAudit != null && !inspectionChecklistDataForAudit.toString().trim().isEmpty()){
			data = inspectionChecklistDataForAudit.toString();
		}
		return data;
	}

	@RequestMapping(value = "/addInspectionChecklistValidationHistory", method = RequestMethod.POST)
	public String addInspectionChecklistValidationHistory(@RequestBody String payload, HttpServletRequest request) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
		JSONObject payloadJSON = new JSONObject(payload);
		payloadJSON.put("queriedBy", request.getSession().getAttribute("user_id"));
		payloadJSON.put("queryDate", formatter.format(new Date()));
		String URL = HMSUtil.getProperties("urlextension.properties", "addInspectionChecklistValidationHistory");
		RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString());
		payloadJSON.put("PN", 0);
		return this.getAllInspectionChecklistValidationHistory(payloadJSON.toString());
	}

	@RequestMapping(value = "/getAllInspectionChecklistValidationHistory", method = RequestMethod.POST)
	public String getAllInspectionChecklistValidationHistory(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllInspectionChecklistValidationHistory");

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/updateInspectionChecklistValidationHistory", method = RequestMethod.POST)
	public String updateInspectionChecklistValidationHistory(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletRequest request) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
		String URL = HMSUtil.getProperties("urlextension.properties", "updateInspectionChecklistValidationHistory");
		JSONObject payloadJSON = new JSONObject();
		payloadJSON.put("inspectionDetailId", multipartHttpServletRequest.getParameter("inspectionDetailId"));
		payloadJSON.put("captureInspectionChecklistId", multipartHttpServletRequest.getParameter("captureInspectionChecklistId"));
		payloadJSON.put("inspectionChecklistId", multipartHttpServletRequest.getParameter("inspectionChecklistId"));
		payloadJSON.put("auditStatus", multipartHttpServletRequest.getParameter("auditStatus"));
		payloadJSON.put("response", multipartHttpServletRequest.getParameter("response"));
		payloadJSON.put("historyId", multipartHttpServletRequest.getParameter("historyId"));
		payloadJSON.put("respondedBy", request.getSession().getAttribute("user_id"));
		payloadJSON.put("responseDate", formatter.format(new Date()));
		payloadJSON.put("fileName", this.uploadFile(multipartHttpServletRequest, "I"));

		RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);

		payloadJSON.put("PN", 0);
		return this.getAllInspectionChecklistValidationHistory(payloadJSON.toString());
	}

	@RequestMapping(value = "/updateInspectionQueryRaisedHistory", method = RequestMethod.POST)
	public String updateInspectionQueryRaisedHistory(@RequestBody String payload, HttpServletRequest request) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
		String URL = HMSUtil.getProperties("urlextension.properties", "updateInspectionChecklistValidationHistory");
		JSONObject payloadJSON = new JSONObject(payload);
		payloadJSON.put("queriedBy", request.getSession().getAttribute("user_id"));
		payloadJSON.put("queryDate", formatter.format(new Date()));

		RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);

		payloadJSON.put("PN", 0);
		return this.getAllInspectionChecklistValidationHistory(payloadJSON.toString());
	}

	@RequestMapping(value = "/download")
	public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			String keys[] = request.getParameter("keys").split(",");
			String type = request.getParameter("type");
			String name = "";
			String path = environment.getProperty("mmu.web.audit.basePath") + "/";
			Path file = null;
			if ("vendor_bill".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if ("nodal_officer".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if("vendor_bill\\supporting_document".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if("vendor_bill\\payment_Recepit".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if ("fund_letter".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if ("audit_report".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if ("audit_report\\manual_penalty".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if ("UC_Upload_Document".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}else if ("ce".equals(type)) { //Capture Equipment
				path += "capture_equipment";
				name = request.getParameter("name");
				String extension = name.substring(name.lastIndexOf("."));
				String fileName = keys[0] + keys[1] + "/" + keys[2] + "/" + keys[3] + keys[4];
				file = Paths.get(path, Base64.getEncoder().encodeToString(fileName.getBytes()) + extension);
			} else if ("ci".equals(type)) { //Capture Inspection
				path += "capture_inspection";
				name = request.getParameter("name");
				String extension = name.substring(name.lastIndexOf("."));
				String fileName = keys[0] + keys[1] + "/" + keys[2] + "/" + keys[3] + keys[4];
				file = Paths.get(path, Base64.getEncoder().encodeToString(fileName.getBytes()) + extension);
			} else {
				path += type + "/" + keys[0] + "/" + keys[1] + "/" + keys[2] + "/";
				name = keys[3] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}

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

				response.addHeader("Content-Disposition", "inline;  filename=" + name);
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
	
	// Method to handle file upload
    private String uploadFileData(MultipartFile fileData,MultipartHttpServletRequest multipartHttpServletRequest, String uploadFlag) {
    	String originalFileName = "";
        if (fileData != null && !fileData.isEmpty()) {
                originalFileName = fileData.getOriginalFilename();
                // Define the directory to save the file (you can customize this path)
                 String auditPath = environment.getProperty("mmu.web.audit.basePath");
        		if (originalFileName!=null) {
        			MultipartFile file = fileData;
        			originalFileName = file.getOriginalFilename();
        			String detailId, captureId, checklistId;
        			if("I".equals(uploadFlag)){
        				detailId = multipartHttpServletRequest.getParameter("inspectionDetailId");
        				captureId = multipartHttpServletRequest.getParameter("captureInspectionChecklistId");
        				checklistId = multipartHttpServletRequest.getParameter("inspectionChecklistId");
        				auditPath += "/inspection/"+detailId+"/"+captureId+"/"+checklistId+"/";
        			} else if("E".equals(uploadFlag)){
        				detailId = multipartHttpServletRequest.getParameter("equipmentDetailId");
        				captureId = multipartHttpServletRequest.getParameter("captureEquipmentChecklistId");
        				checklistId = multipartHttpServletRequest.getParameter("equipmentChecklistId");
        				auditPath += "/equipment/"+detailId+"/"+captureId+"/"+checklistId+"/";
        			} 
        			else if("A".equals(uploadFlag)){
        				auditPath += "/audit_report/manual_penalty/";
        				
        			}
        			else if("N".equals(uploadFlag)){
        				auditPath += "/nodal_officer/";
        				
        			}
        			else if("F".equals(uploadFlag)){
        				auditPath += "/fund_letter/";
        			}
        			else if("U".equals(uploadFlag)){
        				auditPath += "/UC_Upload_Document/";
        			}
        			else {
        				auditPath += "/vendor_bill/supporting_document/";
        			}
        			try {

        				File folderPath = new File(auditPath);
        				if(!folderPath.exists()) {
        					folderPath.mkdirs();
        				}

        				String path = auditPath;
        				if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("letterNo") == null && multipartHttpServletRequest.getParameter("certificateNo") == null){
        					path += multipartHttpServletRequest.getParameter("invoiceNo") + "_" + originalFileName;
        				}
        				else if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("invoiceNo") == null && multipartHttpServletRequest.getParameter("certificateNo") == null){
        					path += multipartHttpServletRequest.getParameter("letterNo") + "_" + originalFileName;
        				}
        				else if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("invoiceNo") == null && multipartHttpServletRequest.getParameter("letterNo") == null){
        					path += multipartHttpServletRequest.getParameter("certificateNo") + "_" + originalFileName;
        				}else {
        					path += multipartHttpServletRequest.getParameter("historyId") + "_" + originalFileName;
        				}
        				byte[] bytes = file.getBytes();
        				File uploadedFile = new File(path);
        				FileOutputStream opStream = new FileOutputStream(uploadedFile);
        				opStream.write(bytes);
        				opStream.flush();
        				opStream.close();
        			} catch (Exception e) {
        				e.printStackTrace();
        			}
        		}
             }
        
        		return originalFileName;
         }


	private String uploadFile(MultipartHttpServletRequest multipartHttpServletRequest, String uploadFlag){
		String originalFileName = "";
		Iterator<String> it = multipartHttpServletRequest.getFileNames();
		String auditPath = environment.getProperty("mmu.web.audit.basePath");
		if (it.hasNext()) {
			MultipartFile file = multipartHttpServletRequest.getFile(it.next());
			originalFileName = file.getOriginalFilename();
			String detailId, captureId, checklistId;
			if("I".equals(uploadFlag)){
				detailId = multipartHttpServletRequest.getParameter("inspectionDetailId");
				captureId = multipartHttpServletRequest.getParameter("captureInspectionChecklistId");
				checklistId = multipartHttpServletRequest.getParameter("inspectionChecklistId");
				auditPath += "/inspection/"+detailId+"/"+captureId+"/"+checklistId+"/";
			} else if("E".equals(uploadFlag)){
				detailId = multipartHttpServletRequest.getParameter("equipmentDetailId");
				captureId = multipartHttpServletRequest.getParameter("captureEquipmentChecklistId");
				checklistId = multipartHttpServletRequest.getParameter("equipmentChecklistId");
				auditPath += "/equipment/"+detailId+"/"+captureId+"/"+checklistId+"/";
			} 
			else if("A".equals(uploadFlag)){
				auditPath += "/audit_report/";
			}
			else if("F".equals(uploadFlag)){
				auditPath += "/fund_letter/";
			}
			else if("U".equals(uploadFlag)){
				auditPath += "/UC_Upload_Document/";
			}
			else if("P".equals(uploadFlag)){
				auditPath += "/vendor_bill/payment_Recepit/";
			}else {
				auditPath += "/vendor_bill/";
			}

			try {

				File folderPath = new File(auditPath);
				if(!folderPath.exists()) {
					folderPath.mkdirs();
				}

				String path = auditPath;
				if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("letterNo") == null && multipartHttpServletRequest.getParameter("certificateNo") == null){
					path += multipartHttpServletRequest.getParameter("invoiceNo") + "_" + originalFileName;
				}
				else if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("invoiceNo") == null && multipartHttpServletRequest.getParameter("certificateNo") == null){
					path += multipartHttpServletRequest.getParameter("letterNo") + "_" + originalFileName;
				}
				else if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("invoiceNo") == null && multipartHttpServletRequest.getParameter("letterNo") == null){
					path += multipartHttpServletRequest.getParameter("certificateNo") + "_" + originalFileName;
				}else {
					path += multipartHttpServletRequest.getParameter("historyId") + "_" + originalFileName;
				}
				byte[] bytes = file.getBytes();
				File uploadedFile = new File(path);
				FileOutputStream opStream = new FileOutputStream(uploadedFile);
				opStream.write(bytes);
				opStream.flush();
				opStream.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return originalFileName;
	}

	private String[] uploadMultipleFiles(MultipartHttpServletRequest multipartHttpServletRequest, String uploadFlag){

		List<String> originalFileNames = new ArrayList<>();
		List<String> encodedFileNames = new ArrayList<>();
		Iterator<String> it = multipartHttpServletRequest.getFileNames();
		String basePath = environment.getProperty("mmu.web.audit.basePath");
		String inspectionDate = multipartHttpServletRequest.getParameter("inspectionDate");
		String mmuLocation = multipartHttpServletRequest.getParameter("mmuLocation");
		String []checklistIds = multipartHttpServletRequest.getParameter("checklistIds").split(",");

		String folderName = "capture_inspection";
		if(uploadFlag.equals("E"))
			folderName = "capture_equipment";

		int count = 0;
		for(Map.Entry<String, MultipartFile> entry: multipartHttpServletRequest.getFileMap().entrySet()){
			MultipartFile file = entry.getValue();
			String originFileName = file.getOriginalFilename();
			if(originFileName != null && !originFileName.isEmpty()) {
				originalFileNames.add(originFileName);
				String auditPath = basePath + "/"+folderName+"/";
				String fileType = originFileName.substring(originFileName.lastIndexOf(".") + 1);
				String fileName = mmuLocation + inspectionDate + checklistIds[count];
				String encodedFileName = Base64.getEncoder().encodeToString(fileName.getBytes());

				try {
					File folderPath = new File(auditPath);
					if (!folderPath.exists()) {
						folderPath.mkdirs();
					}

					//Deleting old existing files
					FilenameFilter filenameFilter = new FilenameFilter() {
						@Override
						public boolean accept(File dir, String name) {
							return name.contains(encodedFileName);
						}
					};
					File []files = folderPath.listFiles(filenameFilter);
					if(files !=null && files.length > 0) {
						for (File existingFile: files)
							existingFile.delete();
					}

					encodedFileNames.add(encodedFileName + "." + fileType);
					String path = auditPath + encodedFileName + "." + fileType;
					byte[] bytes = file.getBytes();
					File uploadedFile = new File(path);
					FileOutputStream opStream = new FileOutputStream(uploadedFile);
					opStream.write(bytes);
					opStream.flush();
					opStream.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else {
				originalFileNames.add("_");
				encodedFileNames.add("_");
			}
			count++;
		}
		return new String[]{String.join(",", originalFileNames), String.join(",", encodedFileNames)};
	}

	@RequestMapping(value = "/updateInspectionChecklistAuditStatus", method = RequestMethod.POST)
	public String updateInspectionChecklistAuditStatus(@RequestBody String payload, HttpServletRequest request) {
		String URL = HMSUtil.getProperties("urlextension.properties", "updateInspectionChecklistAuditStatus");
		JSONObject json = new JSONObject(payload);
		if(json.has("finalRemarks") && !json.getString("finalRemarks").isEmpty()){
			json.put("auditorId", Long.parseLong(request.getSession().getAttribute("user_id").toString()));
		}else{
			json.put("srAuditorId", Long.parseLong(request.getSession().getAttribute("user_id").toString()));
		}

		return RestUtils.postWithHeaders(
			(IpAndPortNo + URL).trim(),
			new LinkedMultiValueMap<String, String>(),
				json.toString()
		);
	}

	@RequestMapping(value = "/auditEuipmentChecklist", method = RequestMethod.GET)
	public ModelAndView auditEuipmentChecklist(HttpServletRequest request){
		request.getSession().setAttribute("equipmentChecklistDataForAudit", null);
		String detailId = request.getParameter("detail");
		if(detailId != null && !detailId.trim().isEmpty()){
			String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedEquipmentChecklist");
			JSONObject payload = new JSONObject();
			payload.put("PN", 0);
			payload.put("equipmentChecklistDetailId", Long.parseLong(detailId));
			String equipmentData = RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload.toString()
			);
			request.getSession().setAttribute("equipmentChecklistDataForAudit", equipmentData);
		}
		return new ModelAndView("auditEuipmentChecklist");
	}

	@RequestMapping(value = "/equipmentChecklistDataForAudit", method = RequestMethod.POST)
	public String equipmentChecklistDataForAudit(@RequestBody String payload, HttpServletRequest request) {
		String data = null;
		Object equipmentChecklistDataForAudit = request.getSession().getAttribute("equipmentChecklistDataForAudit");
		if (equipmentChecklistDataForAudit != null && !equipmentChecklistDataForAudit.toString().trim().isEmpty()){
			data = equipmentChecklistDataForAudit.toString();
		}
		return data;
	}

	@RequestMapping(value = "/addEquipmentChecklistValidationHistory", method = RequestMethod.POST)
	public String addEquipmentChecklistValidationHistory(@RequestBody String payload, HttpServletRequest request) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
		JSONObject payloadJSON = new JSONObject(payload);
		payloadJSON.put("queriedBy", request.getSession().getAttribute("user_id"));
		payloadJSON.put("queryDate", formatter.format(new Date()));

		String URL = HMSUtil.getProperties("urlextension.properties", "addEquipmentChecklistValidationHistory");
		RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString());
		payloadJSON.put("PN", 0);
		return this.getAllEquipmentChecklistValidationHistory(payloadJSON.toString());
	}

	@RequestMapping(value = "/getAllEquipmentChecklistValidationHistory", method = RequestMethod.POST)
	public String getAllEquipmentChecklistValidationHistory(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllEquipmentChecklistValidationHistory");

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/updateEquipmentChecklistValidationHistory", method = RequestMethod.POST)
	public String updateEquipmentChecklistValidationHistory(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletRequest request) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
		String URL = HMSUtil.getProperties("urlextension.properties", "updateEquipmentChecklistValidationHistory");
		JSONObject payloadJSON = new JSONObject();
		payloadJSON.put("equipmentDetailId", multipartHttpServletRequest.getParameter("equipmentDetailId"));
		payloadJSON.put("captureEquipmentChecklistId", multipartHttpServletRequest.getParameter("captureEquipmentChecklistId"));
		payloadJSON.put("equipmentChecklistId", multipartHttpServletRequest.getParameter("equipmentChecklistId"));
		payloadJSON.put("auditStatus", multipartHttpServletRequest.getParameter("auditStatus"));
		payloadJSON.put("response", multipartHttpServletRequest.getParameter("response"));
		payloadJSON.put("historyId", multipartHttpServletRequest.getParameter("historyId"));
		payloadJSON.put("respondedBy", request.getSession().getAttribute("user_id"));
		payloadJSON.put("responseDate", formatter.format(new Date()));
		payloadJSON.put("fileName", this.uploadFile(multipartHttpServletRequest, "E"));

		RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);
		payloadJSON.put("PN", 0);
		return this.getAllEquipmentChecklistValidationHistory(payloadJSON.toString());
	}

	@RequestMapping(value = "/updateEquipmentQueryRaisedHistory", method = RequestMethod.POST)
	public String updateEquipmentQueryRaisedHistory(@RequestBody String payload, HttpServletRequest request) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
		String URL = HMSUtil.getProperties("urlextension.properties", "updateEquipmentChecklistValidationHistory");
		JSONObject payloadJSON = new JSONObject(payload);
		payloadJSON.put("queriedBy", request.getSession().getAttribute("user_id"));
		payloadJSON.put("queryDate", formatter.format(new Date()));

		RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);
		payloadJSON.put("PN", 0);
		return this.getAllEquipmentChecklistValidationHistory(payloadJSON.toString());
	}

	@RequestMapping(value = "/updateEquipmentChecklistAuditStatus", method = RequestMethod.POST)
	public String updateEquipmentChecklistAuditStatus(@RequestBody String payload, HttpServletRequest request) {
		String URL = HMSUtil.getProperties("urlextension.properties", "updateEquipmentChecklistAuditStatus");
		JSONObject json = new JSONObject(payload);
		if(json.has("finalRemarks") && !json.getString("finalRemarks").isEmpty()){
			json.put("auditorId", Long.parseLong(request.getSession().getAttribute("user_id").toString()));
		}else{
			json.put("srAuditorId", Long.parseLong(request.getSession().getAttribute("user_id").toString()));
		}

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				json.toString()
		);
	}

	@RequestMapping(value = "/getAllCapturedQueriedInspectionList", method = RequestMethod.GET)
	public ModelAndView getAllCapturedQueriedInspectionList(){
		return new ModelAndView("allCapturedQueriedInspectionList");
	}

	@RequestMapping(value = "/getAllCapturedQueriedEquipmentList", method = RequestMethod.GET)
	public ModelAndView getAllCapturedQueriedEquipmentList(){
		return new ModelAndView("allCapturedQueriedEquipmentList");
	}

	@RequestMapping(value = "/responseInspectionChecklist", method = RequestMethod.GET)
	public ModelAndView responseInspectionChecklist(HttpServletRequest request){
		request.getSession().setAttribute("inspectionChecklistDataForResponse", null);
		String detailId = request.getParameter("detail");
		if(detailId != null && !detailId.trim().isEmpty()){
			String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedInspectionChecklist");
			Long inspectionDetailId = Long.parseLong(detailId);
			JSONObject payload = new JSONObject();
			payload.put("PN", 0);
			payload.put("inspectionDetailId", inspectionDetailId);
			String inspectionData = RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload.toString()
			);
			request.getSession().setAttribute("inspectionChecklistDataForResponse", inspectionData);
		}
		return new ModelAndView("responseInspectionChecklist");
	}

	@RequestMapping(value = "/inspectionChecklistDataForResponse", method = RequestMethod.POST)
	public String inspectionChecklistDataForResponse(@RequestBody String payload, HttpServletRequest request) {
		String data = null;
		Object inspectionChecklistDataForResponse = request.getSession().getAttribute("inspectionChecklistDataForResponse");
		if (inspectionChecklistDataForResponse != null && !inspectionChecklistDataForResponse.toString().trim().isEmpty()){
			data = inspectionChecklistDataForResponse.toString();
		}
		return data;
	}

	@RequestMapping(value = "/responseEquipmentChecklist", method = RequestMethod.GET)
	public ModelAndView responseEuipmentChecklist(HttpServletRequest request){
		request.getSession().setAttribute("equipmentChecklistDataForResponse", null);
		String detailId = request.getParameter("detail");
		if(detailId != null && !detailId.trim().isEmpty()){
			String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedEquipmentChecklist");
			JSONObject payload = new JSONObject();
			payload.put("PN", 0);
			payload.put("equipmentChecklistDetailId", Long.parseLong(detailId));
			String equipmentData = RestUtils.postWithHeaders(
					(IpAndPortNo + URL).trim(),
					new LinkedMultiValueMap<String, String>(),
					payload.toString()
			);
			request.getSession().setAttribute("equipmentChecklistDataForResponse", equipmentData);
		}
		return new ModelAndView("responseEquipmentChecklist");
	}

	@RequestMapping(value = "/equipmentChecklistDataForResponse", method = RequestMethod.POST)
	public String equipmentChecklistDataForResponse(@RequestBody String payload, HttpServletRequest request) {
		String data = null;
		Object equipmentChecklistDataForResponse = request.getSession().getAttribute("equipmentChecklistDataForResponse");
		if (equipmentChecklistDataForResponse != null && !equipmentChecklistDataForResponse.toString().trim().isEmpty()){
			data = equipmentChecklistDataForResponse.toString();
		}
		return data;
	}

	@RequestMapping(value = "/captureVendorBillDetails", method = RequestMethod.GET)
	public ModelAndView captureVendorBillDetails(){

		return new ModelAndView("captureVendorBillDetails");
	}

	@RequestMapping(value = "/captureVendorBillDetail", method = RequestMethod.POST)
	public String captureVendorBillDetail(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletRequest request) {
		String URL = HMSUtil.getProperties("urlextension.properties", "captureVendorBillDetail");
		JSONObject payloadJSON = new JSONObject();
		payloadJSON.put("vendorId", multipartHttpServletRequest.getParameter("vendorId"));
		payloadJSON.put("cityId", multipartHttpServletRequest.getParameter("cityId"));
		payloadJSON.put("mmuIds", String.join(",", multipartHttpServletRequest.getParameterValues("mmuIds")));
		payloadJSON.put("billMonth", multipartHttpServletRequest.getParameter("billMonth"));
		payloadJSON.put("billYear", multipartHttpServletRequest.getParameter("billYear"));
		payloadJSON.put("invoiceNo", multipartHttpServletRequest.getParameter("invoiceNo"));
		payloadJSON.put("createdBy", multipartHttpServletRequest.getParameter("userId"));
		payloadJSON.put("invoiceAmount", multipartHttpServletRequest.getParameter("invoiceAmount"));
		payloadJSON.put("invoiceDate", multipartHttpServletRequest.getParameter("invoiceDate"));
		payloadJSON.put("vendorFlag", multipartHttpServletRequest.getParameter("vendorFlag"));
		payloadJSON.put("district", multipartHttpServletRequest.getParameter("district"));
		payloadJSON.put("firstTime", multipartHttpServletRequest.getParameter("firstTime"));
		payloadJSON.put("uploadedFileName", this.uploadFile(multipartHttpServletRequest, "V"));
		
		 // Handle the data from <tbody id="supportingDocs">
        JSONArray supportingDocsArray = new JSONArray();
        // Assuming the data is passed as arrays of parameters for each row
        String[] docIds = multipartHttpServletRequest.getParameterValues("docId");
        String[] medicalDocs = multipartHttpServletRequest.getParameterValues("medicalDocs");
        String[] captureVendorSupportingDocsId=multipartHttpServletRequest.getParameterValues("captureVendorSupportingDocsId");
        String[] viewSupportingDocs=multipartHttpServletRequest.getParameterValues("viewSupportingDocs");
        List<MultipartFile> supportingDocsUploads = multipartHttpServletRequest.getFiles("supportingDocsUpload");

        if (docIds != null && medicalDocs != null && docIds.length == medicalDocs.length && supportingDocsUploads.size() == docIds.length) {
            for (int i = 0; i < docIds.length; i++) {
                JSONObject docObject = new JSONObject();
                docObject.put("docId", docIds[i]);
                docObject.put("medicalDocs", medicalDocs[i]);
                if(captureVendorSupportingDocsId[i]!=null) {
                docObject.put("captureVendorSupportingDocsId", captureVendorSupportingDocsId[i]);
                }
                MultipartFile supportingDocsUpload = supportingDocsUploads.get(i);
                if (supportingDocsUpload != null && !supportingDocsUpload.isEmpty()) {
                    String uploadedDocFileName = this.uploadFileData(supportingDocsUpload,multipartHttpServletRequest, "V");
                    docObject.put("supportingDocsUpload", uploadedDocFileName);
                }else {
                	if(viewSupportingDocs!=null) {
                	docObject.put("supportingDocsUpload", viewSupportingDocs[i]);
                	}
                }

                supportingDocsArray.put(docObject);
            }
        }

        payloadJSON.put("supportingDocs", supportingDocsArray);

        
        payloadJSON.put("supportingDocs", supportingDocsArray);
		if(!multipartHttpServletRequest.getParameter("phase").equals(""))
		{
			String phaseVal=multipartHttpServletRequest.getParameter("phase").toString();
			String[] phaseValue=phaseVal.split("@@");
			payloadJSON.put("phase", phaseValue[0]);	
		}
		
		if(payloadJSON.get("uploadedFileName").equals(""))
		{
			payloadJSON.put("uploadedFileName", multipartHttpServletRequest.getParameter("uploadedFileNameOld"));
		}
		payloadJSON.put("updateStatus", multipartHttpServletRequest.getParameter("updateStatus"));
		payloadJSON.put("captureVendorBillDetailId", multipartHttpServletRequest.getParameter("captureVendorBillDetailId"));
		payloadJSON.put("lastApprovalMsg", multipartHttpServletRequest.getParameter("lastApprovalMsg"));
		//payloadJSON.put("phase", multipartHttpServletRequest.getParameter("phase"));

	
		 return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);
	
	}

	@RequestMapping(value = "/getCapturedVendorBillDetail", method = RequestMethod.POST)
	public String getCapturedVendorBillDetail(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/getVendors", method = RequestMethod.POST)
	public String getVendors(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getVendors");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/getVendorsMMUAndCity", method = RequestMethod.POST)
	public String getVendorsMMUAndCity(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getVendorsMMUAndCity");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}

	@RequestMapping(value = "/vendorInvoiceList", method = RequestMethod.GET)
	public ModelAndView vendorInvoiceList(){

		return new ModelAndView("vendorInvoiceList");
	}

	@RequestMapping(value = "/vendorInvoiceDetail", method = RequestMethod.GET)
	public ModelAndView vendorInvoiceDetail(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("vendorInvoiceDetail");
	}

	@RequestMapping(value = "/vendorInvoiceDetailData", method = RequestMethod.GET)
	public String vendorInvoiceDetailData(HttpServletRequest request){
		return request.getSession().getAttribute("vendorInvoiceDetailData").toString();
	}

	@RequestMapping(value = "/vendorInvoiceDetailDataAuditor", method = RequestMethod.GET)
	public String vendorInvoiceDetailDataAuditor(HttpServletRequest request){
		return request.getSession().getAttribute("vendorInvoiceDetailDataAuditor").toString();
	}

	@RequestMapping(value = "/vendorInvoiceDetailDataCO", method = RequestMethod.GET)
	public String vendorInvoiceDetailDataCO(HttpServletRequest request){
		return request.getSession().getAttribute("vendorInvoiceDetailDataCO").toString();
	}

	@RequestMapping(value = "/validateCapturedDuplicateInspectionDetail", method = RequestMethod.POST)
	public String validateCapturedDuplicateInspectionDetail(@RequestBody String payload){
		String inspectionChecklist = this.getAllCapturedInspectionChecklist(payload);
		JSONObject insList = new JSONObject(inspectionChecklist);
		String inspectionData = "{\"data\": []}";
		if (insList != null && insList.has("data")) {
			JSONArray checklists = insList.getJSONArray("data");
			if (checklists.length() > 0) {
				String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedInspectionChecklist");
				JSONObject payloads = new JSONObject();
				payloads.put("PN", 0);
				payloads.put("inspectionDetailId", checklists.getJSONObject(0).getLong("inspectionDetailId"));
				inspectionData = RestUtils.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						payloads.toString()
				);
			}
		}
		return inspectionData;
	}

	@RequestMapping(value = "/validateCapturedDuplicateEquipmentDetail", method = RequestMethod.POST)
	public String validateCapturedDuplicateEquipmentDetail(@RequestBody String payload){
		String equipmentChecklist = this.getAllCapturedEquipmentChecklist(payload);
		JSONObject eqipList = new JSONObject(equipmentChecklist);
		String equipmentData = "{\"data\": []}";
		if (eqipList != null && eqipList.has("data")) {
			JSONArray checklists = eqipList.getJSONArray("data");
			if (checklists.length() > 0) {
				String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedEquipmentChecklist");
				JSONObject payloads = new JSONObject();
				payloads.put("PN", 0);
				payloads.put("equipmentChecklistDetailId", checklists.getJSONObject(0).getLong("equipmentChecklistDetailId"));
				equipmentData = RestUtils.postWithHeaders(
						(IpAndPortNo + URL).trim(),
						new LinkedMultiValueMap<String, String>(),
						payloads.toString()
				);
			}
		}
		return equipmentData;
	}

	@RequestMapping(value = "/getAllForwardedInspectionList", method = RequestMethod.GET)
	public ModelAndView getAllForwardedInspectionList(){
		return new ModelAndView("allForwardedInspectionList");
	}

	@RequestMapping(value = "/getAllForwardedEquipmentList", method = RequestMethod.GET)
	public ModelAndView getAllForwardedEquipmentList(){
		return new ModelAndView("allForwardedEquipmentList");
	}

	@RequestMapping(value = "/vendorBillApprovalListAuditor", method = RequestMethod.GET)
	public ModelAndView vendorBillApprovalListAuditor(){
		return new ModelAndView("vendorBillApprovalListAuditor");
	}

	@RequestMapping(value = "/vendorInvoiceApprovalAuditor", method = RequestMethod.GET)
	public ModelAndView vendorInvoiceApprovalAuditor(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailDataAuditor");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailDataAuditor", finalResult.toString());
		return new ModelAndView("vendorInvoiceApprovalAuditor");
	}

	@RequestMapping(value = "/updateVendorBillRemarks", method = RequestMethod.POST)
	public String updateVendorBillAuditorRemarks(MultipartHttpServletRequest multipartHttpServletRequest) {
		String URL = HMSUtil.getProperties("urlextension.properties", "updateVendorBillRemarks");
		JSONObject payloadJSON = new JSONObject();
		payloadJSON.put("captureVendorBillDetailId", multipartHttpServletRequest.getParameter("captureVendorBillDetailId"));
		payloadJSON.put("vendorBillAuditorData", multipartHttpServletRequest.getParameter("vendorBillAuditorData"));
		payloadJSON.put("status", multipartHttpServletRequest.getParameter("status"));
		payloadJSON.put("remarksType", multipartHttpServletRequest.getParameter("remarksType"));
		if("AUDITOR".equals(multipartHttpServletRequest.getParameter("remarksType")))
			payloadJSON.put("fileName", this.uploadFile(multipartHttpServletRequest, "vendor_auditor"));

		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);
	}

	@RequestMapping(value = "/vendorBillApprovalListCO", method = RequestMethod.GET)
	public ModelAndView vendorBillApprovalListCO(){
		return new ModelAndView("vendorBillApprovalListCO");
	}

	@RequestMapping(value = "/vendorInvoiceApprovalCO", method = RequestMethod.GET)
	public ModelAndView vendorInvoiceApprovalCO(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailDataCO");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailDataCO", finalResult.toString());
		return new ModelAndView("vendorInvoiceApprovalCO");
	}
	

	
	@RequestMapping(value = "/pendingAuditorVendorInvoice", method = RequestMethod.GET)
	public ModelAndView pendingAuditorVendorInvoice(){

		return new ModelAndView("pendingAuditVendorInvoiceList");
	}
	
	@RequestMapping(value = "/pendingAuditVendorInvoiceDetail", method = RequestMethod.GET)
	public ModelAndView pendingAuditVendorInvoiceDetail(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("pendingAuditVendorInvoiceDetail");
	}
	
	@RequestMapping(value = "/rejectedAuditVendorInvoiceDetail", method = RequestMethod.GET)
	public ModelAndView rejectedAuditVendorInvoiceDetail(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("rejectedAuditVendorInvoiceDetail");
	}
	
	@RequestMapping(value = "/vendorInvoiceDetailFinal", method = RequestMethod.GET)
	public ModelAndView vendorInvoiceDetailFinal(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("vendorInvoiceDetailFinal");
	}
	
	@RequestMapping(value = "/captureVendorBillAuditorDetail", method = RequestMethod.POST)
	public String captureVendorBillAuditorDetail(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletRequest request) {
		String URL = HMSUtil.getProperties("urlextension.properties", "captureVendorBillDetail");
		JSONObject payloadJSON = new JSONObject();
		payloadJSON.put("vendorId", multipartHttpServletRequest.getParameter("vendorId"));
		payloadJSON.put("cityId", multipartHttpServletRequest.getParameter("cityId"));
		payloadJSON.put("mmuIds", String.join(",", multipartHttpServletRequest.getParameterValues("mmuIds")));
		payloadJSON.put("billMonth", multipartHttpServletRequest.getParameter("billMonth"));
		payloadJSON.put("billYear", multipartHttpServletRequest.getParameter("billYear"));
		payloadJSON.put("invoiceNo", multipartHttpServletRequest.getParameter("invoiceNo"));
		payloadJSON.put("createdBy", multipartHttpServletRequest.getParameter("userId"));
		payloadJSON.put("invoiceAmount", multipartHttpServletRequest.getParameter("invoiceAmount"));
		payloadJSON.put("invoiceDate", multipartHttpServletRequest.getParameter("invoiceDate"));
		payloadJSON.put("vendorFlag", multipartHttpServletRequest.getParameter("vendorFlag"));
		payloadJSON.put("district", multipartHttpServletRequest.getParameter("district"));
		payloadJSON.put("uploadedFileName", multipartHttpServletRequest.getParameter("uploadedFileName"));
		payloadJSON.put("auditUploadedFileName", this.uploadFile(multipartHttpServletRequest, "A"));
		payloadJSON.put("updateStatus", multipartHttpServletRequest.getParameter("updateStatus"));
		payloadJSON.put("captureVendorBillDetailId", multipartHttpServletRequest.getParameter("captureVendorBillDetailId"));
		payloadJSON.put("actionIdValue", multipartHttpServletRequest.getParameter("actionId"));
		payloadJSON.put("forwordTo", multipartHttpServletRequest.getParameter("forwordTo"));
		payloadJSON.put("auditorRemarks", multipartHttpServletRequest.getParameter("auditorRemarks"));
		payloadJSON.put("auditorName", multipartHttpServletRequest.getParameter("auditorName"));
		payloadJSON.put("auditorAuthorityId", multipartHttpServletRequest.getParameter("auditorAuthorityId"));
		payloadJSON.put("auditorAuthorityName", multipartHttpServletRequest.getParameter("auditorAuthorityName"));
		payloadJSON.put("auditorAuthorityOrderNo", multipartHttpServletRequest.getParameter("auditorAuthorityOrderNo"));
		payloadJSON.put("lastApprovalMsg", multipartHttpServletRequest.getParameter("lastApprovalMsg"));
		payloadJSON.put("mmuPenaltyListData", multipartHttpServletRequest.getParameter("mmuPenaltyListData"));
		payloadJSON.put("penaltyAmountImposed", multipartHttpServletRequest.getParameter("penaltyAmountImposed"));
		payloadJSON.put("userId", multipartHttpServletRequest.getParameter("userId"));
		
		// Handle the data from <tbody id="mmuPenaltyDetails">
        JSONArray penaltyDetailsMMUArray = new JSONArray();
         String[] mmuIds = multipartHttpServletRequest.getParameterValues("mmuIds");
        String[] autoPenaltyAmount = multipartHttpServletRequest.getParameterValues("autoPenaltyAmount");
        String[] manualPenaltyAmount = multipartHttpServletRequest.getParameterValues("manualPenaltyAmount");
        String[] auditorRemarksMMU = multipartHttpServletRequest.getParameterValues("auditorRemarksMMU");
        List<MultipartFile> penaltyDocsUploads = multipartHttpServletRequest.getFiles("fileNameManualPenalty");

        if (mmuIds != null && manualPenaltyAmount != null && mmuIds.length == manualPenaltyAmount.length && penaltyDocsUploads.size() == manualPenaltyAmount.length) {
            for (int i = 0; i < mmuIds.length; i++) {
                JSONObject docObject = new JSONObject();
                docObject.put("mmuIds", mmuIds[i]);
                docObject.put("autoPenaltyAmount", autoPenaltyAmount[i]);
                docObject.put("manualPenaltyAmount", manualPenaltyAmount[i]);
                docObject.put("auditorRemarksMMU", auditorRemarksMMU[i]);

                MultipartFile manualDocsUpload = penaltyDocsUploads.get(i);
                if (manualDocsUpload != null && !manualDocsUpload.isEmpty()) {
                    String uploadedManualDocFileName = this.uploadFileData(manualDocsUpload,multipartHttpServletRequest, "A");
                    docObject.put("penaltyDocsUploads", uploadedManualDocFileName);
                }

                penaltyDetailsMMUArray.put(docObject);
            }
        }

        payloadJSON.put("penaltyDetailsMMUArray", penaltyDetailsMMUArray);
        
       	return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);
	}
	
	@RequestMapping(value = "/pendingVendorInvoiceApprovingAuthority", method = RequestMethod.GET)
	public ModelAndView pendingVendorInvoiceApprovingAuthority(){

		return new ModelAndView("pendingAuthorityVendorInvoiceList");
	}
	
	@RequestMapping(value = "/pendingVendorInvoiceApprovingAuthorityDetail", method = RequestMethod.GET)
	public ModelAndView pendingVendorInvoiceApprovingAuthorityDetail(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("pendingAuthorityVendorInvoiceDetail");
	}
	
	@RequestMapping(value = "/downloadVendorInvoice")
	public String downloadVendorInvoice(@RequestBody HashMap<String, Object> jsondata, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		JSONObject jsonObject = new JSONObject();
		try {
			
			String keys[] = request.getParameter("keys").split(",");
			String type = request.getParameter("type");
			String name = "";
			String path = environment.getProperty("mmu.web.audit.basePath") + "/";
			Path file = null;
			if ("vendor_bill".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if ("audit_report".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
			else if ("nodal_officer".equals(type)) {
				path += type;
				name = keys[0] + "_" + request.getParameter("name");
				file = Paths.get(path, name);
			}
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
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/getVendorInvoiceApprovalDetails", method = RequestMethod.POST)
	public String getVendorInvoiceApprovalDetails(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getVendorInvoiceApprovalDetails");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}
	
/*	@RequestMapping(value = "/saveOrUpdateAuthorityVendorBillDetails", method = RequestMethod.POST)
	public String saveOrUpdateAuthorityVendorBillDetails(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "saveOrUpdateAuthorityVendorBillDetails");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}*/
	
	@RequestMapping(value = "/saveOrUpdateAuthorityVendorBillDetails", method = RequestMethod.POST)
	public String saveOrUpdateAuthorityVendorBillDetails(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse response) {
		Box box = HMSUtil.getBox(multipartHttpServletRequest);
		JSONObject payloadJSON = new JSONObject(box);
		// Handle the data from Auditor Note-Sheet Data
        JSONArray noteSheetArray = new JSONArray();
        String[] noteSheet = multipartHttpServletRequest.getParameterValues("caseSheet");
        List<MultipartFile> noteSheetDocsUploads = multipartHttpServletRequest.getFiles("caseSheetUpload");

        if (noteSheet != null && noteSheetDocsUploads != null && noteSheet.length == noteSheetDocsUploads.size()) {
            for (int i = 0; i < noteSheet.length; i++) {
                JSONObject docObject = new JSONObject();
                docObject.put("noteSheet", noteSheet[i]);
                docObject.put("screenType", "nodal_officer");
                MultipartFile manualDocsUpload = noteSheetDocsUploads.get(i);
                if (manualDocsUpload != null && !manualDocsUpload.isEmpty()) {
                    String uploadedManualDocFileName = this.uploadFileData(manualDocsUpload,multipartHttpServletRequest, "N");
                    docObject.put("noteSheetDocsUploads", uploadedManualDocFileName);
                }

                noteSheetArray.put(docObject);
            }
        }

        payloadJSON.put("noteSheetArray", noteSheetArray);
        payloadJSON.put("paymentRecepitFileName", this.uploadFile(multipartHttpServletRequest, "P"));
		String URL = HMSUtil.getProperties("urlextension.properties", "saveOrUpdateAuthorityVendorBillDetails");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payloadJSON.toString()
		);
	}
	
	@RequestMapping(value="/getFilteredUsers", method=RequestMethod.POST)
	public String getFilteredUsers(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getFilteredUsers");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/paymentWaitingListVendorInvoice", method = RequestMethod.GET)
	public ModelAndView paymentWaitingListVendorInvoice(){

		return new ModelAndView("paymentWaitingListVendorInvoice");
	}
	
	@RequestMapping(value = "/paymentVendorInvoiceDetail", method = RequestMethod.GET)
	public ModelAndView paymentVendorInvoiceDetail(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);

		JSONObject resultJSON = new JSONObject(result);
		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("paymentVendorInvoiceDetail");
	}
	
	@RequestMapping(value="/getVendorInvoicePaymentDetail", method=RequestMethod.POST)
	public String getVendorInvoicePaymentDetail(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getVendorInvoicePaymentDetail");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/vendorBillSubmit", method = RequestMethod.GET)
	public ModelAndView vendorBillSubmit(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		/*String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);


		JSONObject resultJSON = new JSONObject(result);
		JSONObject penaltyPayload = new JSONObject();
		JSONObject dataJson = resultJSON.getJSONArray("data").getJSONObject(0);
		penaltyPayload.put("mmuIds", dataJson.getString("mmuIds"));
		penaltyPayload.put("vendorBillMMUDetailList", dataJson.getJSONArray("vendorBillMMUDetailList"));
		penaltyPayload.put("inspectionYear", dataJson.getInt("billYear"));
		penaltyPayload.put("inspectionMonth", dataJson.getInt("billMonth"));
		String URL1 = HMSUtil.getProperties("urlextension.properties", "getVendorsPenalty");
		String penaltyResult = RestUtils.postWithHeaders(
				(IpAndPortNo + URL1).trim(),
				new LinkedMultiValueMap<String, String>(),
				penaltyPayload.toString()
		);

		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		finalResult.put("penaltyDetailData", new JSONObject(penaltyResult));
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
*/		return new ModelAndView("vendorBillSubmit");
	}
	
	@RequestMapping(value = "/detailedVendorsBillingList", method = RequestMethod.GET)
	public ModelAndView detailedVendorsBillingList(){

		return new ModelAndView("detailVendorBillingWaitingList");
	}
	
	@RequestMapping(value = "/detailVendorBillingReports", method = RequestMethod.GET)
	public ModelAndView detailVendorBillingReports(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);

		JSONObject resultJSON = new JSONObject(result);
		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("detailVendorBillingReports");
	}
	
	
	
	/*@RequestMapping(value = "/auditDashboard", method = RequestMethod.GET , produces="application/json", consumes="application/json")
	public ModelAndView auditDashboard(){

		return new ModelAndView("auditDashboard");
	}*/
	
	@RequestMapping(value="/getVendorPenaltyDetail", method=RequestMethod.POST)
	public String getVendorPenaltyDetail(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getVendorPenaltyDetail");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/captureFundAllocation", method = RequestMethod.GET)
	public ModelAndView captureFundAllocation(){

		return new ModelAndView("captureFundAllocation");
	}
	
	@RequestMapping(value = "/captureFundAllocationDetails", method = RequestMethod.GET)
	public ModelAndView captureFundAllocationDetails(){

		return new ModelAndView("addViewFundAllocation");
	}
	
	@RequestMapping(value="/saveFundAllocationDetails", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveOpdPatientdetails(MultipartHttpServletRequest request, HttpServletResponse response) {	
	Box box = HMSUtil.getBox(request);
	JSONObject obj = new JSONObject(box);
   obj.put("fundLetterName", this.uploadFile(request, "F"));
  
	String URL = HMSUtil.getProperties("urlextension.properties", "saveFundAllocationDetails");
	return RestUtils.postWithHeaders(
			(IpAndPortNo + URL).trim(),
			new LinkedMultiValueMap<String, String>(),
			obj.toString()
	);
		//return os.saveOpdPatientdetails(obj.toString(), request, response);
	}
	
	@RequestMapping(value="/getFundAvailableBalance", method=RequestMethod.POST)
	public String getFundAvailableBalance(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getFundAvailableBalance");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/fundAllocationList", method = RequestMethod.GET)
	public ModelAndView fundAllocationList(){

		return new ModelAndView("approvalListFundSchemeWise");
	}
	
	@RequestMapping(value="/getFundAllocationDetails", method=RequestMethod.POST)
	public String getFundAllocationDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getFundAllocationHdDetails");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/fundAllocationDetails", method = RequestMethod.GET)
	public ModelAndView fundAllocationDetails(HttpServletRequest request,	HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "viewFundAllocation";
		Long fundAllocationHdId= Long.parseLong(request.getParameter("fundAllocationHdId"));
		String payload = "{\"fundAllocationHdId\":"+fundAllocationHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		String URL = HMSUtil.getProperties("urlextension.properties", "getDgFundAllcationHdDt");
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
	
	@RequestMapping(value="/deleteFundAllocationDtDetails", method=RequestMethod.POST)
	public String deleteFundAllocationDtDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "deleteFundAllocationDtDetails");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/approvalFundAllocationList", method = RequestMethod.GET)
	public ModelAndView approvalFundAllocationList(){

		return new ModelAndView("approvalListFundAllocation");
	}
	
	@RequestMapping(value = "/approvalFundAllocationDetails", method = RequestMethod.GET)
	public ModelAndView approvalFundAllocationDetails(HttpServletRequest request,	HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "approvalFundAllocationDetails";
		Long fundAllocationHdId= Long.parseLong(request.getParameter("fundAllocationHdId"));
		String payload = "{\"fundAllocationHdId\":"+fundAllocationHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		String URL = HMSUtil.getProperties("urlextension.properties", "getDgFundAllcationHdDt");
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
	
	@RequestMapping(value = "/fundBillSubmit", method = RequestMethod.GET)
	public ModelAndView fundBillSubmit(HttpServletRequest request,	HttpServletResponse response) {
		String jsp = "fundBillSubmit";
		Long fundAllocationHdId= Long.parseLong(request.getParameter("fundAllocationHdId"));
		String payload = "{\"fundAllocationHdId\":"+fundAllocationHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		String URL = HMSUtil.getProperties("urlextension.properties", "getDgFundAllcationHdDt");
		String jsonResponse = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);
    	ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("msgRecall", "Fund Bill Submited Successfully");
		
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/fundDetailReports", method = RequestMethod.GET)
	public ModelAndView fundDetailReports(){

		return new ModelAndView("fundReports");
	}
	
	@RequestMapping(value="/getFundAllocationAmount", method=RequestMethod.POST)
	public String getFundAllocationAmount(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getFundAllocationAmount");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value="/getPenaltyAuthorityDetailsByUpss", method=RequestMethod.POST)
	public String getPenaltyAuthorityDetailsByUpss(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getPenaltyAuthorityDetailsByUpss");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}

	@RequestMapping(value="/captureInterest", method = RequestMethod.GET)
	public ModelAndView captureInterest() {
		return new ModelAndView("captureInterest");
	}

	@RequestMapping(value = "/captureSubmitInterest", method = RequestMethod.GET)
	public ModelAndView captureSubmitInterest(HttpServletRequest request,	HttpServletResponse response) {
		String jsp = "captureSubmitInterest";
		Long  captureInterestHdId=  Long.parseLong(request.getParameter("captureInterestHdId"));
		String viewPage=request.getParameter("pageFlag");
		//String payload = "{\"fundAllocationHdId\":"+fundAllocationHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		//String URL = HMSUtil.getProperties("urlextension.properties", "getDgFundAllcationHdDt");
		/*String jsonResponse = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);*/
	//	System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		//mv.addObject("data", jsonResponse);
		String message="";
		/*
		 * if(flageForSubmit.equalsIgnoreCase("S")) {
		 * message="Capture Interest Saved successfully."; } else {
		 * message="Capture Interest Submitted successfully."; }
		 */
		mv.addObject("msgRecall", "Bank interest details captured successfully");
		mv.addObject("viewPage", viewPage);
		mv.setViewName(jsp);
		return mv;
	}

	
	@RequestMapping(value="/saveCaptureInterestDetails", method = RequestMethod.POST)
	 public String saveCaptureInterestDetails(HttpServletRequest request, HttpServletResponse response) {	
	Box box = HMSUtil.getBox(request);
	JSONObject obj = new JSONObject(box);
  
 
	String URL = HMSUtil.getProperties("urlextension.properties", "saveCaptureInterestDetails");
	return RestUtils.postWithHeaders(
			(IpAndPortNo + URL).trim(),
			new LinkedMultiValueMap<String, String>(),
			obj.toString()
	);
	 
	}
	@RequestMapping(value = "/approvalCaptureInterestList", method = RequestMethod.GET)
	public ModelAndView approvalCaptureInterestList(){

		return new ModelAndView("approvalCaptureInterest");
	}
	@RequestMapping(value="/getAllCaptureInterestDetails", method=RequestMethod.POST)
	public String getAllCaptureInterestDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllCaptureInterestDetails");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/captureApprovalDetails", method = RequestMethod.GET)
	public ModelAndView captureApprovalDetails(HttpServletRequest request,	HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "captureApprovalDetails";
		Long captureInterestHdId= Long.parseLong(request.getParameter("captureInterestHdId"));
		String payload = "{\"captureInterestHdId\":"+captureInterestHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCaptureInterestHdDt");
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
	@RequestMapping(value = "/captureInterestViewUpdate", method = RequestMethod.GET)
	public ModelAndView captureInterestViewUpdate(){

		return new ModelAndView("captureInterestViewupdate");
	}
	
	@RequestMapping(value = "/captureViewUpdateDetails", method = RequestMethod.GET)
	public ModelAndView captureViewUpdateDetails(HttpServletRequest request,	HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "captureViewUpdateDetails";
		Long captureInterestHdId= Long.parseLong(request.getParameter("captureInterestHdId"));
		String payload = "{\"captureInterestHdId\":"+captureInterestHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCaptureInterestHdDt");
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

	@RequestMapping(value="/deleteCaptureInterestDtDetails", method=RequestMethod.POST)
	public String deleteCaptureInterestDtDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "deleteCaptureInterestDtDetails");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/captureUcUploadCertificate", method = RequestMethod.GET)
	public ModelAndView captureUcUpload(){

		return new ModelAndView("captureUcUploadCertificate");
	}
	
	@RequestMapping(value = "/trackUcUploadCertificate", method = RequestMethod.GET)
	public ModelAndView trackUcUpload(){

		return new ModelAndView("trackUcUploadCertificate");
	}
	
	@RequestMapping(value = "/saveUCDocumentUploadDetails", method = RequestMethod.POST)
	// HashMap<String,String> listMap = new HashMap<String,String>();
	public String saveUCDocumentUploadDetails(MultipartHttpServletRequest request, HttpServletResponse response) {
		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		obj.put("fundLetterName", this.uploadFile(request, "U"));

		String URL = HMSUtil.getProperties("urlextension.properties", "saveUCDocumentUploadDetails");
		return RestUtils.postWithHeaders((IpAndPortNo + URL).trim(), new LinkedMultiValueMap<String, String>(),
				obj.toString());
		// return os.saveOpdPatientdetails(obj.toString(), request, response);
	}
	
	@RequestMapping(value = "/ucUploadDocumentSubmit", method = RequestMethod.GET)
	public ModelAndView ucUploadDocumentSubmit(HttpServletRequest request,	HttpServletResponse response) {
		String jsp = "ucDocumentSubmit";
		Long fundAllocationHdId= Long.parseLong(request.getParameter("fundAllocationHdId"));
		String payload = "{\"fundAllocationHdId\":"+fundAllocationHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		String URL = HMSUtil.getProperties("urlextension.properties", "getDgFundAllcationHdDt");
		String jsonResponse = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("msgRecall", "Fund Bill Submited Successfully");
		
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getUcUploadDocumentDetail", method = RequestMethod.POST)
	public String getUcUploadDocumentDetail(@RequestBody String payload) {
		String URL = HMSUtil.getProperties("urlextension.properties", "getUcUploadDocumentDetail");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload
		);
	}
	
	@RequestMapping(value = "/getUcUploadDocumentHdDt", method = RequestMethod.GET)
	public ModelAndView getUcUploadDocumentHdDt(HttpServletRequest request,	HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "viewUcUploadCertificate";
		Long ucUploadHdId= Long.parseLong(request.getParameter("ucUploadHdId"));
		String payload = "{\"ucUploadHdId\":"+ucUploadHdId+"}";
		//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		String URL = HMSUtil.getProperties("urlextension.properties", "getUcUploadDocumentHdDt");
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
	
	@RequestMapping(value="/deleteUCUploadDtDetails", method=RequestMethod.POST)
	public String deleteUCUploadDtDetails(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "deleteUCUploadDtDetails");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}
	
	@RequestMapping(value = "/detailedVendorsBillingListNodal", method = RequestMethod.GET)
	public ModelAndView detailedVendorsBillingListNodal(){

		return new ModelAndView("detailVendorBillingWaitingNodalList");
	}
	
	@RequestMapping(value = "/detailVendorBillingReportsNodal", method = RequestMethod.GET)
	public ModelAndView detailVendorBillingReportsNodal(HttpServletRequest request){
		request.getSession().removeAttribute("vendorInvoiceDetailData");
		JSONObject payload = new JSONObject();
		payload.put("captureVendorBillDetailId", request.getParameter("detail"));
		payload.put("PN", 0);
		String URL = HMSUtil.getProperties("urlextension.properties", "getCapturedVendorBillDetail");
		String result = RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				payload.toString()
		);

		JSONObject resultJSON = new JSONObject(result);
		JSONObject finalResult = new JSONObject();
		finalResult.put("vendorInvoiceDetailData", resultJSON);
		request.getSession().setAttribute("vendorInvoiceDetailData", finalResult.toString());
		return new ModelAndView("vendorInvoiceDetailFinal");
	}
	
	@RequestMapping(value="/deleteSupportingNoteSheetDocs", method=RequestMethod.POST)
	public String deleteSupportingNoteSheetDocs(@RequestBody Map<String, Object> requestObject) {
		JSONObject jsonObject = new JSONObject(requestObject);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "deleteSupportingNoteSheetDocs");
		String OSBURL = IpAndPortNo+Url;
		String responseObject = RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
		return responseObject;
	}

}
