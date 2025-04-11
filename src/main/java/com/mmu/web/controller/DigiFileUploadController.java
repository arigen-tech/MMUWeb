package com.mmu.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.mmu.web.service.DigiFileUploadService;
import com.mmu.web.service.MedicalBoardService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.ProjectUtils;
import com.mmu.web.utils.RestUtils;
import com.mmu.web.utils.UtilityServices;
 
@RestController
@CrossOrigin
@RequestMapping("/digifileupload")
public class DigiFileUploadController {
	@Autowired
	DigiFileUploadService digiFileUploadService;

	@Autowired
	MedicalBoardService mbs;
	
	//private static final String HOST = HMSUtil.getProperties("js_messages_en.properties", "RIDCSERVERIP").trim();
//	private static final String USER = HMSUtil.getProperties("js_messages_en.properties", "RIDCUSER").trim();
	//private static final String PASSWORD = HMSUtil.getProperties("js_messages_en.properties", "RIDCPASSWORD").trim();
	 
	String IpAndPortNo = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	@RequestMapping(value = "/waitingTagAndDataEntry", method = RequestMethod.GET)
	public ModelAndView validateMEWaiting(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("waitingListForTagAndDataEntry");
		return mav;

	}

	@RequestMapping(value = "/getWaitingTagAndDataEntry", method = RequestMethod.POST)
	public String getWaitingTagAndDataEntry(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return digiFileUploadService.getWaitingTagAndDataEntry(payload, request, response);
	}

	@RequestMapping(value = "/dataEntryForm", method = RequestMethod.GET)
	public ModelAndView dataEntryForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("dataEntryForm");
		return mav;
	}

	@RequestMapping(value = "/newEntryMEMEBForm", method = RequestMethod.POST)
	public ModelAndView newEntryMEMEBForm(HttpServletRequest request, HttpServletResponse response) {
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
		String serviceNo = data.get("serviceNo").toString();
		serviceNo = HMSUtil.getReplaceString(serviceNo);
		String patientId = data.get("patientId").toString();
		patientId = HMSUtil.getReplaceString(patientId);
		String employeeName = data.get("employeeName").toString();
		employeeName = HMSUtil.getReplaceString(employeeName);
		String documentType = data.get("documentType").toString();
		documentType = HMSUtil.getReplaceString(documentType);
		String examTypeId = data.get("examTypeId").toString();
		examTypeId = HMSUtil.getReplaceString(examTypeId);

		String commonJsp = "";

		String meForm18 = UtilityServices.getValueOfPropByKey("meForm18");
		String meForm3B = UtilityServices.getValueOfPropByKey("meForm3B");
		String mbForm15 = UtilityServices.getValueOfPropByKey("mbForm15");
		String mbForm16 = UtilityServices.getValueOfPropByKey("mbForm16");
		String meForm3A = UtilityServices.getValueOfPropByKey("meForm3A");
		String meForm2A = UtilityServices.getValueOfPropByKey("meForm2A");
		if (StringUtils.isNotEmpty(examTypeId)) {
			String[] examTypeIds = examTypeId.split("##");

			if (StringUtils.isNotEmpty(examTypeIds[1]) && examTypeIds[1].toString().equalsIgnoreCase(meForm18)) {
				commonJsp = "newEntryForm18";
			}
			if (StringUtils.isNotEmpty(examTypeIds[1]) && examTypeIds[1].toString().equalsIgnoreCase(meForm3B)) {
				commonJsp = "newEntryForm3B";
			}
			if (StringUtils.isNotEmpty(examTypeIds[1]) && examTypeIds[1].toString().equalsIgnoreCase(mbForm15)) {

				String jsp = "newEntryForm16";
				Long visitId = Long.parseLong(request.getParameter("visitId"));
				String payload = "{\"visitId\":" + visitId + "}";
				String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
				ModelAndView mv = new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
				// commonJsp="newEntryForm15" ;
			}
			if (StringUtils.isNotEmpty(examTypeIds[1]) && examTypeIds[1].toString().equalsIgnoreCase(mbForm16)) {
				commonJsp = "newEntryForm16";
			}
			
			if (StringUtils.isNotEmpty(examTypeIds[1]) && examTypeIds[1].toString().equalsIgnoreCase(meForm3A)) {
				commonJsp = "newEntryForm3A";
			}
			if (StringUtils.isNotEmpty(examTypeIds[1]) && examTypeIds[1].toString().equalsIgnoreCase(meForm2A)) {
				commonJsp = "newEntryForm2A";
			}
		}
		ModelAndView mav = new ModelAndView(commonJsp);
		mav.addObject("serviceNo", serviceNo);
		mav.addObject("patientId", patientId);
		mav.addObject("employeeName", employeeName);
		// mav.addObject("visitId", visitId);
		return mav;
	}

	@RequestMapping(value = "/submitNewEntryForm3B", method = RequestMethod.POST)
	public ModelAndView submitNewEntryForm3B(MultipartHttpServletRequest request, HttpServletResponse response) {

		if(!ProjectUtils.checksession(request)) {
			return new ModelAndView("redirect:/dashboard/login");
		}
		
		Box box = HMSUtil.getBox(request);
		String dataOfYear="";
		JSONObject obj = new JSONObject(box);
		String dynamicUploadInvesIdAndfile = obj.get("dynamicUploadInvesIdAndfile").toString();
		
		String mainChargeCodeForFileWithChargeCode= obj.get("mainChargeCodeForFileWithChargeCode").toString();
		mainChargeCodeForFileWithChargeCode=HMSUtil.getReplaceString(mainChargeCodeForFileWithChargeCode);
		String [] mainChargeCodeForFileWithChargeCodes=null;
		if(StringUtils.isNotBlank(mainChargeCodeForFileWithChargeCode))
		  mainChargeCodeForFileWithChargeCodes=mainChargeCodeForFileWithChargeCode.split(",");
		
		
		String serviceNo= obj.get("serviceNo").toString();
		serviceNo=HMSUtil.getReplaceString(serviceNo);
	
		 if(obj.has("dateOfExam") && obj.get("dateOfExam")!=null) {
		String dateOfExam= obj.get("dateOfExam").toString();
		dateOfExam=HMSUtil.getReplaceString(dateOfExam);
		if(dateOfExam!=null && !dateOfExam.equalsIgnoreCase("")) {
			dataOfYear=dateOfExam.split("/")[2];
		}
	}
	
		 

	if(obj.has("dateOfRelease") && obj.get("dateOfRelease")!=null) {
		String dateOfRelease= obj.get("dateOfRelease").toString();
		dateOfRelease=HMSUtil.getReplaceString(dateOfRelease);
		if(dateOfRelease!=null && !dateOfRelease.equalsIgnoreCase("")) {
			dataOfYear=dateOfRelease.split("/")[2];
		}
	}
		
		String ridcIdValues = "";
		String fileNameValue = "";
		String rmsAllValue = "";
		String data = "";
		String referalRmsId = "";
		String meRmsId = "";
		String docType="";
		Iterator<String> itr = request.getFileNames();
		Integer ridcIdVv = 1;
		String medicalBoardDocsUpload="";
		  String labRadioVal="";
		ModelAndView mv = new ModelAndView();
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
                
				if (size == 0) {
					rmsAllValue += size + ",";
				}
				
				if (StringUtils.isNotEmpty(myFileName)) {
					
					 
					if(mainChargeCodeForFileWithChargeCodes!=null && mainChargeCodeForFileWithChargeCodes.length>0)
					for(String mainChargeAndfielObj:mainChargeCodeForFileWithChargeCodes) {
						if(StringUtils.isNotEmpty(mainChargeAndfielObj) && !mainChargeAndfielObj.equalsIgnoreCase("0"))	
						 if(mainChargeAndfielObj.contains(myFileName)) {
							 String [] mainChargeAndFiles=mainChargeAndfielObj.split("##");
							 labRadioVal=mainChargeAndFiles[0];
							 break;
						 }
						}
					
						if(name.contains("referalFileUpload"))
						{
							docType="1";
						}
						if(name.contains("medicalExamFileUpload"))
						{
							docType="1";
						}
						if(name.contains("medicalBoardDocsUpload"))
						{
							docType="16";
						}
						 if(name.contains("fileInvUploadDyna")) {
						if(StringUtils.isNotEmpty(labRadioVal) && labRadioVal.equalsIgnoreCase("2")) {
							docType="4";
						}

						if(StringUtils.isNotEmpty(labRadioVal) && labRadioVal.equalsIgnoreCase("1")) {
							docType="8";
						}
						}
					HashMap<String,String> info=new HashMap<String,String>();
					info.put("serviceNo", serviceNo);
					info.put("year", dataOfYear);
					info.put("docType", docType);
					info.put("type", "1");
					File convFile = new File(file.getOriginalFilename());
					  convFile.createNewFile(); 
					  FileOutputStream fos = new FileOutputStream(convFile); 
					  fos.write(file.getBytes());
					  fos.close();
					 ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info); 
					  String ridcId ="";
					  PatientRegistrationWebController.ridcUploadForInv(ridcDoc); 
					  if(ridcId!=null && (ridcId.equalsIgnoreCase("") || ridcId.contains("RidcUpload Table"))) {
						  String jsp = "medicalExamSubmitForDigi";
							mv.addObject("msgMedicalExam","Data is not uploaded because something is not save in RidcUpload table");
							mv.setViewName(jsp);
							return mv;
					  }
					  if(ridcId!=null && StringUtils.isNotEmpty(ridcId)) {
					  ridcIdValues += "" + ridcId + ","; fileNameValue += "" + myFileName + ","; rmsAllValue += ""
					   + ridcId + ",";
					  }
					
					// ridcIdValues+=""+ridcIdVv+","; rmsAllValue+=""+ridcIdVv+","; ridcIdVv+=1;
					 
					if (dynamicUploadInvesIdAndfile.contains(myFileName)) {
						dynamicUploadInvesIdAndfile = dynamicUploadInvesIdAndfile.replaceAll(myFileName.trim(),
								"" + ridcId);
					}
					if (StringUtils.isNotEmpty(name) && name.contains("referalFileUpload")) {
						referalRmsId += "" + ridcId + ",";
					}
					if (StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUpload")) {
						meRmsId = "" + ridcId;
					}
					if (StringUtils.isNotEmpty(name) && name.contains("medicalBoardDocsUpload")) {
						medicalBoardDocsUpload += "" + ridcId + ",";
					}
				}

			}
			// String[] rms2Id=ridcIdValues.split(",");
			// String[] rms1IdVal=rmsAllValue.split(",");
			// String[] rmsIdFinalVal=getRMSId(rms2Id,rms1IdVal);
			obj.put("ridcIdValues", ridcIdValues);
			obj.put("dynamicUploadInvesIdAndfileNew", dynamicUploadInvesIdAndfile);
			obj.put("referalRmsId", referalRmsId);
			obj.put("meRmsId", meRmsId);
			obj.put("medicalBoardDocsUpload", medicalBoardDocsUpload);
			data = digiFileUploadService.submitNewEntryForm3B(obj.toString(), request, response);
			
			JSONObject jSONObject =new JSONObject (data);
			
			String status = jSONObject.get("status").toString();
			String errorMsg = jSONObject.get("errorMes").toString();
			String msgForPatient = jSONObject.get("msgForPatient").toString();
			mv.addObject("status",status);
			String visitId =obj.get("visitId").toString(); 
			visitId=HMSUtil.getReplaceString(visitId);
			
			mv.addObject("visitIdForInvestEmpty",visitId);
			mv.addObject("msgMedicalExam",errorMsg);
			mv.addObject("msgForPatient",msgForPatient);
			
			String jsp = "medicalExamSubmitForDigi";
			mv.addObject("data", data);
			mv.setViewName(jsp);
		} catch (Exception e) {
			/*if(StringUtils.isNotEmpty(ridcIdValues)) {
				String [] ridcIdVallll=ridcIdValues.split(",");
				JSONObject objForRidc = new JSONObject( );
			for(String ridciddd:ridcIdVallll) {
				objForRidc.put("ridcId", ridciddd);
				cs.getRidcDocumentInfo(objForRidc, request);
			}
			
			}*/
			e.printStackTrace();
			String jsp = "medicalExamSubmitForDigi";
			mv.addObject("msgMedicalExam",e.getMessage());
			mv.setViewName(jsp);
		}

		return mv;

	}

	@RequestMapping(value = "/mbMembersAFMSFormdata", method = RequestMethod.GET)
	public ModelAndView mbMembersAFMSFormData(HttpServletRequest request, HttpServletResponse response) {
		String examTypeId = request.getParameter("examTypeId");
		// String [] examTypeIds=examTypeId.split("##");
		// examTypeId= HMSUtil.getReplaceString(examTypeId);
		String meForm18 = UtilityServices.getValueOfPropByKey("meForm18");
		String meForm3B = UtilityServices.getValueOfPropByKey("meForm3B");
		String mbForm15 = UtilityServices.getValueOfPropByKey("mbForm15");
		String mbForm16 = UtilityServices.getValueOfPropByKey("mbForm16");
		String commonJsp = "";
		String jsp = "";
		String jsonResponse = "";

		if (StringUtils.isNotEmpty(examTypeId)) {
			// String [] examTypeIds=examTypeId.split("##");
			/*
			 * if(StringUtils.isNotEmpty(examTypeIds[1]) &&
			 * examTypeIds[1].toString().equalsIgnoreCase(meForm18)) { jsp="newEntryForm18"
			 * ; } if(StringUtils.isNotEmpty(examTypeIds[1]) &&
			 * examTypeIds[1].toString().equalsIgnoreCase(meForm3B)) { jsp="newEntryForm3B"
			 * ; }
			 */
			if (examTypeId == "5") {
				Map<String, Object> map = new HashMap<String, Object>();
				jsp = "newEntryForm15";
				// Long visitId= Long.parseLong(request.getParameter("visitId"));
				// String payload = "{\"visitId\":"+visitId+"}";
				// jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
	
			}
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/mbMembersAFMSForm", method = RequestMethod.GET)
	public ModelAndView mbMembersAFMSForm(HttpServletRequest request, HttpServletResponse response) {
		String examTypeId = request.getParameter("examTypeId");
		String[] examTypeIds = null;
		String examTypeCode = "";
		if (StringUtils.isNotEmpty(examTypeId) && examTypeId.contains("@@")) {
			examTypeIds = examTypeId.split("@@");
			examTypeCode = examTypeIds[1];
		} else {
			examTypeCode = examTypeId.trim();
		}
		String meForm18 = UtilityServices.getValueOfPropByKey("meForm18");
		String meForm3B = UtilityServices.getValueOfPropByKey("meForm3B");
		String mbForm15 = UtilityServices.getValueOfPropByKey("mbForm15");
		String mbForm16 = UtilityServices.getValueOfPropByKey("mbForm16");
		String meForm3BS = UtilityServices.getValueOfPropByKey("meForm3BS");
		String meForm3A = UtilityServices.getValueOfPropByKey("meForm3A");
		String meForm2A = UtilityServices.getValueOfPropByKey("meForm2A");
		
		String jsonResponse = "";
		String jsp = "";
		Map<String, Object> map = new HashMap<String, Object>();
		Long visitId = Long.parseLong(request.getParameter("visitId"));
		HttpSession session = request.getSession();

		Integer userId = (Integer) session.getAttribute("user_id");
		Integer hospitalId = (Integer) session.getAttribute("hospital_id");
		String newEntryStatus = request.getParameter("newEntryStatus");
		Integer newEntryStatusTemp=null;
		if(newEntryStatus!=null && newEntryStatus.equalsIgnoreCase("no")) {
			newEntryStatusTemp=0;
		}
		if(newEntryStatus!=null && newEntryStatus.equalsIgnoreCase("yes")) {
			newEntryStatusTemp=1;
		}
		String payload = "{\"visitId\":" + visitId + "," + "\"userId\":" + userId + "," + "\"hospitalId\":" + hospitalId
				+ "," + "\"newEntryStatus\":" + newEntryStatusTemp+"}";
		jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		String viewOrEditFlag = request.getParameter("viewOrEditFlag");
		
		if(StringUtils.isNotEmpty(viewOrEditFlag) && viewOrEditFlag.contains("@@")) {
			String[] viewOrEditFlagV = viewOrEditFlag.split("@@");
			viewOrEditFlag = viewOrEditFlagV[0];
			if (StringUtils.isNotEmpty(examTypeCode) &&( meForm3B.equalsIgnoreCase(examTypeCode) || meForm3BS.equalsIgnoreCase(examTypeCode))) {
				jsp = "newEntryForm3BView";
			}
			if (StringUtils.isNotEmpty(examTypeCode) && meForm18.equalsIgnoreCase(examTypeCode)) {
				jsp = "newEntryForm18View";
			}
			
			if (StringUtils.isNotEmpty(examTypeCode) && mbForm15.equalsIgnoreCase(examTypeCode)) {
				jsp = "newEntryForm15ReadOnly";

			}
			if (StringUtils.isNotEmpty(examTypeCode) && mbForm16.equalsIgnoreCase(examTypeCode)) {
				jsp = "newEntryForm16";
			}
			if (StringUtils.isNotEmpty(examTypeCode) && examTypeCode.toString().equalsIgnoreCase(meForm3A)) {
				jsp = "newEntryForm3AView";
			}
			if (StringUtils.isNotEmpty(examTypeCode) && examTypeCode.toString().equalsIgnoreCase(meForm2A)) {
				jsp = "newEntryForm2AView";
			}
		}
		else {
		if (StringUtils.isNotEmpty(examTypeCode) &&( meForm3B.equalsIgnoreCase(examTypeCode) || meForm3BS.equalsIgnoreCase(examTypeCode))) {
			jsp = "newEntryForm3B";
		}
		if (StringUtils.isNotEmpty(examTypeCode) && meForm18.equalsIgnoreCase(examTypeCode)) {
			jsp = "newEntryForm18";
		}
		if (StringUtils.isNotEmpty(examTypeCode) && mbForm15.equalsIgnoreCase(examTypeCode)) {
			jsp = "newEntryForm15";

		}
		if (StringUtils.isNotEmpty(examTypeCode) && mbForm16.equalsIgnoreCase(examTypeCode)) {
				jsp = "newEntryForm16";
		}
		if (StringUtils.isNotEmpty(examTypeCode) && meForm3A.toString().equalsIgnoreCase(examTypeCode)) {
			jsp = "newEntryForm3A";
		}
		if (StringUtils.isNotEmpty(examTypeCode) && meForm2A.toString().equalsIgnoreCase(examTypeCode)) {
			jsp = "newEntryForm2A";
		}
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("examTypeCode", examTypeCode);
		
		mv.addObject("viewOrEditFlag",viewOrEditFlag);
		mv.addObject("newEntryStatus",newEntryStatus);
		
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/waitingListOfVerify", method = RequestMethod.GET)
	public ModelAndView waitingListOfVerify(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("waitingListForVerify");
		return mav;

	}

	@RequestMapping(value = "/waitingListForApproval", method = RequestMethod.GET)
	public ModelAndView waitingListForApproval(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("waitingListForApproval");
		return mav;

	}

 
	@RequestMapping(value = "/dataSaveAmsfForm15", method = RequestMethod.POST)
	public String dataSaveAmsfForm15(MultipartHttpServletRequest request, HttpServletResponse response) {
			Box box = HMSUtil.getBox(request);
			JSONObject obj = new JSONObject(box);
			String ridcIdValues = "";
			String fileNameValue = "";
			String rmsAllValue = "";
			String data = "";
			String referalRmsId = "";
			String mbRmsId = "";
			Iterator<String> itr = request.getFileNames();
			Integer ridcIdVv = 1;
			ModelAndView mv = new ModelAndView();
			String medicalBoardDocsUpload="";
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
					
					String serviceNo=request.getParameter("serviceNo");
					String year=request.getParameter("year");
					String docType=request.getParameter("docType");
					String type=request.getParameter("type");
					if(name.contains("medicalBoardFileUpload"))
					{
						docType="2";
					}
					if(name.contains("medicalBoardDocsUpload"))
					{
						docType="16";
					}
					HashMap<String,String> info=new HashMap<String,String>();
					info.put("serviceNo", serviceNo);
					info.put("year", year);
					info.put("docType", docType);
					info.put("type", "1");
					
					RidcEntity ridcDoc = null;

					if (size == 0) {
						rmsAllValue += size + ",";
					}
					
					if (StringUtils.isNotEmpty(myFileName)) {
						File convFile = new File(file.getOriginalFilename());
						  convFile.createNewFile(); 
						  FileOutputStream fos = new FileOutputStream(convFile); 
						  fos.write(file.getBytes());
						  fos.close();
						  ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
						  String ridcId= "";
						  PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
						  ridcIdValues+=""+ridcId+","; fileNameValue+=""+myFileName+",";
						  rmsAllValue+=""+ridcId+",";
						 

						/*ridcIdValues += "" + ridcIdVv + ",";
						rmsAllValue += "" + ridcIdVv + ",";
						ridcIdVv += 1;*/
					
						if (StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalBoardFileUpload")) {
							mbRmsId = "" + ridcId;
						}
						if (StringUtils.isNotEmpty(name) && name.contains("medicalBoardDocsUpload")) {
							medicalBoardDocsUpload += "" + ridcId+ ",";
						}
					}

				}
				obj.put("ridcIdValues", ridcIdValues);
				obj.put("mbRmsId", mbRmsId);
				obj.put("medicalBoardDocsUpload", medicalBoardDocsUpload);

			} catch (Exception e) {

			}
			return digiFileUploadService.dataSaveAmsfForm15(obj.toString(), request, response);
		}

	@RequestMapping(value = "/mbTranscriptionSubmit", method = RequestMethod.GET)
	public ModelAndView mbTranscriptionSubmit(HttpServletRequest request, HttpServletResponse response) {
		String jsp = "newTranscriptionSubmit15";
		Long visitId = Long.parseLong(request.getParameter("visitId"));
		// String payload = "{\"visitId\":"+visitId+"}";
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("user_id");
		Integer hospitalId = (Integer) session.getAttribute("hospital_id");
		String payload = "{\"visitId\":" + visitId + "," + "\"userId\":" + userId + "," + "\"hospitalId\":" + hospitalId
				+ "}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/mbSpecialistOpinionDetails", method = RequestMethod.GET)
	public ModelAndView mbSpecialistOpinionDetails(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "newSpecialityForOpinionDetails";
		Long visitId = Long.parseLong(request.getParameter("visitId"));
		// String payload = "{\"visitId\":"+visitId+"}";

		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("user_id");
		Integer hospitalId = (Integer) session.getAttribute("hospital_id");
		String payload = "{\"visitId\":" + visitId + "," + "\"userId\":" + userId + "," + "\"hospitalId\":" + hospitalId
				+ "}";

		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/dataSaveSpecialistOpinion", method = RequestMethod.POST)
//HashMap<String,String> listMap =  new HashMap<String,String>();
	public String dataSaveSpecialistOpinion(MultipartHttpServletRequest request, HttpServletResponse response) {
		// System.out.println(payload.toString());

		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
		String dynamicUploadInvesIdAndfile = obj.get("dynamicUploadInvesIdAndfile").toString();
		String mainChargeCodeForFileWithChargeCode= obj.get("mainChargeCodeForFileWithChargeCode").toString();
		mainChargeCodeForFileWithChargeCode=HMSUtil.getReplaceString(mainChargeCodeForFileWithChargeCode);
		String [] mainChargeCodeForFileWithChargeCodes=null;
		if(StringUtils.isNotBlank(mainChargeCodeForFileWithChargeCode))
		  mainChargeCodeForFileWithChargeCodes=mainChargeCodeForFileWithChargeCode.split(",");
		String ridcIdValues = "";
		String fileNameValue = "";
		String rmsAllValue = "";
		String data = "";
		String referalRmsId = "";
		String meRmsId = "";
		String labRadioVal="";
		Iterator<String> itr = request.getFileNames();
		Integer ridcIdVv = 1;
		ModelAndView mv = new ModelAndView();
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
				
			 
				if (size == 0) {
					rmsAllValue += size + ",";
				}
				if (StringUtils.isNotEmpty(myFileName)) {
					
					if(mainChargeCodeForFileWithChargeCodes!=null && mainChargeCodeForFileWithChargeCodes.length>0)
						for(String mainChargeAndfielObj:mainChargeCodeForFileWithChargeCodes) {
							if(StringUtils.isNotEmpty(mainChargeAndfielObj) && !mainChargeAndfielObj.equalsIgnoreCase("0"))	
							 if(mainChargeAndfielObj.contains(myFileName)) {
								 String [] mainChargeAndFiles=mainChargeAndfielObj.split("##");
								 labRadioVal=mainChargeAndFiles[0];
								 break;
							 }
							}
					String serviceNo=request.getParameter("serviceNo");
					String year=request.getParameter("year");
					String docType=request.getParameter("docType");
					String type=request.getParameter("type");
					if(name.contains("referalFileUpload"))
					{
						docType="2";
					}
					if(name.contains("fileInvUploadDyna")) {
							if(StringUtils.isNotEmpty(labRadioVal) && labRadioVal.equalsIgnoreCase("2")) {
								docType="4";
							}

							if(StringUtils.isNotEmpty(labRadioVal) && labRadioVal.equalsIgnoreCase("1")) {
								docType="8";
							}
							}
					HashMap<String,String> info=new HashMap<String,String>();
					info.put("serviceNo",serviceNo);
					info.put("year",year);
					info.put("docType",docType);
					info.put("type","1");
					
					File convFile = new File(file.getOriginalFilename());
					  convFile.createNewFile(); 
					  FileOutputStream fos = new FileOutputStream(convFile); 
					  fos.write(file.getBytes());
					  fos.close();
					  ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
					  String ridcId= "";
					  PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
					  ridcIdValues+=""+ridcId+","; fileNameValue+=""+myFileName+",";
					  rmsAllValue+=""+ridcId+",";
					 

					ridcIdValues += "" + ridcIdVv + ",";
					rmsAllValue += "" + ridcIdVv + ",";
					ridcIdVv += 1;
					if (dynamicUploadInvesIdAndfile.contains(myFileName)) {
						dynamicUploadInvesIdAndfile = dynamicUploadInvesIdAndfile.replaceAll(myFileName.trim(),
								"" + ridcId);
					}
					if (StringUtils.isNotEmpty(name) && name.contains("referalFileUpload")) {
						referalRmsId += "" + ridcId + ",";
					}
					if (StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUpload")) {
						meRmsId = "" + ridcId;
					}
					 
				}

			}
			// String[] rms2Id=ridcIdValues.split(",");
			// String[] rms1IdVal=rmsAllValue.split(",");
			// String[] rmsIdFinalVal=getRMSId(rms2Id,rms1IdVal);
			obj.put("ridcIdValues", ridcIdValues);
			obj.put("dynamicUploadInvesIdAndfileNew", dynamicUploadInvesIdAndfile);
			obj.put("referalRmsId", referalRmsId);
			obj.put("meRmsId", meRmsId);

		} catch (Exception e) {
			e.printStackTrace();

		}
		return digiFileUploadService.dataSaveSpecialistOpinion(obj.toString(), request, response);
	}

	@RequestMapping(value = "/deleteRmsFile", method = RequestMethod.POST)
	public String deleteRmsFile(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		JSONObject obj = null;
		try {
			obj = new JSONObject(payload);
			String documentId = obj.get("documentId").toString();
			String encryptedName = obj.get("encryptedName").toString();

			String deleteStatus = "";
			//RIDCUtils.deleteDocument(documentId, encryptedName);
			obj.put("deleteStatus", deleteStatus);

		} catch (Exception e) {
			obj.put("deleteStatus", "Something is going wrong.");
			e.printStackTrace();
		}
		return obj.toString();
	}
	@RequestMapping(value="/showApplicationsOnRoleBaseForDigi", method=RequestMethod.POST)	
	public String showApplicationsOnRoleBaseForDigi(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		HttpSession session = request.getSession();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_APPLICATION_BASED_ON_ROLE");
		String OSBURL = IpAndPortNo+Url;
		String resp= RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, requestObject);
		//String resp= RestUtils.postWithHeaders("http://localhost:8082/AshaServices/user/getApplicationNameBasesOnRole", requestHeaders, requestObject);
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
	
	
	@RequestMapping(value = "/digiTrakingList", method = RequestMethod.GET)
	public ModelAndView validateMETrakingList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("digiTrakingList");
		return mav;

	}

	@RequestMapping(value = "/getDigiTrakingList", method = RequestMethod.POST)
	public String getDigiTrakingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return digiFileUploadService.getWaitingTagAndDataEntry(payload, request, response);
	}
	
	
	
	@RequestMapping(value = "/digiReject", method = RequestMethod.GET)
	public ModelAndView validateMEDigiReject(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("digiRejectList");
		return mav;

	}

	@RequestMapping(value = "/getDigiRejectList", method = RequestMethod.POST)
	public String getDigiRejectList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return digiFileUploadService.getWaitingTagAndDataEntry(payload, request, response);
	}
	 
	
	
	@RequestMapping(value = "/digiApproved", method = RequestMethod.GET)
	public ModelAndView validateMEdigiApprovedList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("digiApprovedList");
		return mav;

	}

	@RequestMapping(value = "/getDigidigiApprovedList", method = RequestMethod.POST)
	public String getDigidigiApprovedList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return digiFileUploadService.getWaitingTagAndDataEntry(payload, request, response);
	}

	@RequestMapping(value = "/getSubInvestigationHtml", method = RequestMethod.POST)
	public String getSubInvestigationHtml(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return digiFileUploadService.getSubInvestigationHtml(payload, request, response);
	}
	
	
	
	
	
	@RequestMapping(value = "/getStatus", method = RequestMethod.POST)
	public static String getStatus(@RequestBody String payload, HttpServletRequest request,	HttpServletResponse response) {//throws IdcClientException {
		@SuppressWarnings("rawtypes")
		String dStatus = null;
		JSONObject json = new JSONObject(payload);
		//IdcClient myIdcClient = new IdcClientManager().createClient(HOST);
		//DataBinder myRequestDataBinder = myIdcClient.createBinder();
		String actionName=json.getString("dFormat");
		int docId =json.getInt("docId");
		String myId=String.valueOf(docId);
		String docName=json.getString("docName");
		/*myRequestDataBinder.putLocal("IdcService", actionName);
		myRequestDataBinder.putLocal("dID", myId);
		myRequestDataBinder.putLocal("dDocName", docName);
		myRequestDataBinder.putLocal("IdcService", "DOC_INFO");
		
		ServiceResponse response1 = myIdcClient.sendRequest(new IdcContext(USER), myRequestDataBinder);
		
		 DataBinder serverBinder = response1.getResponseAsBinder();      
		 DataResultSet resultSet = serverBinder.getResultSet("REVISION_HISTORY");     
	
		for (DataObject dataObject : resultSet.getRows ()) 
		{        
			dStatus=dataObject.get ("dStatus");
			myRequestDataBinder.putLocal("dStatus", dStatus);
			System.out.println (" Status is: " +dStatus);         
			System.out.println (" dOutDate is: " + dataObject.get ("dOutDate"));        
			System.out.println (" ContentID is: " + dataObject.get ("dID"));        
			System.out.println (" Revision ID is: " + dataObject.get ("dRevisionID"));
		} 
	  */
		JSONObject jsobj = new JSONObject();
		jsobj.put("status", dStatus);
		
		return jsobj.toString();	  
	}

	@RequestMapping(value = "/showCreateInvestigationTemplateME", method = RequestMethod.GET)
	public ModelAndView showCreateInvestigationTemplateME(HttpServletRequest request,	HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "meInvestigationTemplate";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		//String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		String jsonResponse = "";
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getInvestigationAndSubInvesForTemplate", method = RequestMethod.POST)
	public String getInvestigationAndSubInvesForTemplate(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return digiFileUploadService.getInvestigationAndSubInvesForTemplate(payload, request, response);
	}
	

	@RequestMapping(value = "/mbMembersOtherDocument", method = RequestMethod.GET)
	public ModelAndView mbMembersOtherDocument(HttpServletRequest request,	HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "newDigiOtherDoc";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		HttpSession session=request.getSession();
		Integer userId= (Integer) session.getAttribute("user_id");
    	Integer hospitalId=(Integer) session.getAttribute("hospital_id");
		String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	
	@RequestMapping(value = "/getFamilyDetailsHistory", method = RequestMethod.POST)
	public String getFamilyDetailsHistory(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return digiFileUploadService.getFamilyDetailsHistory(payload, request, response);
	}

	
}
