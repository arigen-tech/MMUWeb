package com.mmu.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
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
import com.mmu.web.service.MedicalBoardService;
import com.mmu.web.service.MedicalExamService;
import com.mmu.web.service.OpdService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;
import com.mmu.web.utils.UtilityServices;



@RequestMapping("/medicalBoard")
@RestController
@CrossOrigin
public class MedicalBoardWebController {

	@Autowired
	MedicalBoardService mbs;
	
	@Autowired
	MedicalExamService medicalExamService;
		
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	String IpAndPortNoLocal = HMSUtil.getProperties("urlextension.properties", "LOCAL_IP_AND_PORT");
	

	
	@RequestMapping(value = "/piMBWaitingList", method = RequestMethod.GET)
	public ModelAndView validateMEWaiting(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("piMBWaitingList");
		return mav;

	}
	
	@RequestMapping(value="/getMBWaitingList", method = RequestMethod.POST)
	public String getMBWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return mbs.getMBWaitingList(payload, request, response);
	}
	
	/*@RequestMapping(value = "/preliminaryMBWaitingDetail", method = RequestMethod.GET)
	public ModelAndView preliminaryMBWaitingDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("preliminaryInvestigationMB");
		Integer visitId = Integer.parseInt(request.getParameter("visitId"));
		int age = Integer.parseInt(request.getParameter("age"));
		mav.addObject("visitId", visitId);
		mav.addObject("age", age);
		return mav;

	}*/
	
	@RequestMapping(value = "/preliminaryMBWaitingDetail", method = RequestMethod.GET)
	public ModelAndView preliminaryMBWaitingDetail(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "preliminaryInvestigationMBMA";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		 HttpSession session=request.getSession();
		Integer userId= (Integer) session.getAttribute("user_id");
		 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
		 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		//String payload = "{\"visitId\":"+visitId+"}";
		
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/saveInvestigationMBdetails", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveInvestigationMBdetails(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		//System.out.println(payload.toString());
		return mbs.saveInvestigationMBdetails(payload, request, response);
	}
	
	@RequestMapping(value = "/preliminaryMBSubmit", method = RequestMethod.GET)
	public ModelAndView preliminaryMBPatientdetails(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("preliminaryMB Submited Sucessufully");
		String jsp = "piMBSubmit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
	//	String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbPreAssesmentWaitingList", method = RequestMethod.GET)
	public ModelAndView mbPreAssesmentWaitingList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbPreAssesWaitingList");
		return mav;

	}
	
	
	
	@RequestMapping(value="/getMBPreAssesWaitingList", method = RequestMethod.POST)
	public String getMBPreAssesWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return mbs.getMBPreAssesWaitingList(payload, request, response);
	}
	
	@RequestMapping(value = "/mbPreassessmentDetails", method = RequestMethod.GET)
	public ModelAndView mbPreassessmentDetails(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbPreassessmentDetails";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/getMBPreAssesDetails", method = RequestMethod.POST)
	public String getMBPreAssesDetails(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
	  return mbs.getMBPreAssesDetails(payload, request, response);
	}
	
	@RequestMapping(value="/saveVitailsPatientdetails", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveVitailsPatientdetails(MultipartHttpServletRequest request, HttpServletResponse response) {	

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
					
					//System.out.println("info"+info);
					 File convFile = new File(file.getOriginalFilename());
					  convFile.createNewFile(); 
					  FileOutputStream fos = new FileOutputStream(convFile); 
					  fos.write(file.getBytes());
					  fos.close();
					  ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
					  String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
					  ridcIdValues+=""+ridcId+","; fileNameValue+=""+myFileName+",";
					  rmsAllValue+=""+ridcId+",";
					
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
		
			obj.put("ridcIdValues", ridcIdValues);
			obj.put("dynamicUploadInvesIdAndfileNew", dynamicUploadInvesIdAndfile);
			obj.put("referalRmsId", referalRmsId);
			obj.put("meRmsId", meRmsId);

		} catch (Exception e) {

		}
		//return digiFileUploadService.dataSaveSpecialistOpinion(obj.toString(), request, response);
		return mbs.saveVitailsPatientdetails(obj.toString(), request, response);
	}
	
	@RequestMapping(value = "/mbAssementSubmit", method = RequestMethod.GET)
	public ModelAndView submitOpdPatientdetails(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("OPD Data Submited Sucessufully");
		String jsp = "mbPreAssementSubmit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
		
	@RequestMapping(value = "/opinionMedicalList", method = RequestMethod.GET)
	public ModelAndView opinionMedicalList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbOpninionBoardWaitingList");
		return mav;

	}
	
	@RequestMapping(value = "/mbReferredForOpinionDetails", method = RequestMethod.GET)
	public ModelAndView mbReferredForOpinionDetails(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbReferredForOpinionDetails";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
		Integer userId= (Integer) session.getAttribute("user_id");
		 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
		 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/saveRefferedOpinionMBdetails", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveRefferedOpinionMBdetails(MultipartHttpServletRequest request, HttpServletResponse response) {	

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
					
					//System.out.println("info"+info); 
					 File convFile = new File(file.getOriginalFilename());
					  convFile.createNewFile(); 
					  FileOutputStream fos = new FileOutputStream(convFile); 
					  fos.write(file.getBytes());
					  fos.close();
					  ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
					  String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
					  ridcIdValues+=""+ridcId+","; fileNameValue+=""+myFileName+",";
					  rmsAllValue+=""+ridcId+",";
					
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
		
			obj.put("ridcIdValues", ridcIdValues);
			obj.put("dynamicUploadInvesIdAndfileNew", dynamicUploadInvesIdAndfile);
			obj.put("referalRmsId", referalRmsId);
			obj.put("meRmsId", meRmsId);

		} catch (Exception e) {

		}
		//return digiFileUploadService.dataSaveSpecialistOpinion(obj.toString(), request, response);
		return mbs.saveRefferedOpinionMBdetails(obj.toString(), request, response);
	}	
	/*public String saveRefferedOpinionMBdetails(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		//System.out.println(payload.toString());
		return mbs.saveRefferedOpinionMBdetails(payload, request, response);
	}*/
	
	@RequestMapping(value = "/mbRefferedOpinionSubmit", method = RequestMethod.GET)
	public ModelAndView mbRefferedOpinionSubmit(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("OPD Data Submited Sucessufully");
		String jsp = "mbRefferedOpinionSubmit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbSpecialistOpinionSubmit", method = RequestMethod.GET)
	public ModelAndView mbSpecialistOpinionSubmit(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("Submited Sucessufully");
		String jsp = "mbSpecialistOpinionSubmit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/getMedicalBoardAutocomplete", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMedicalBoardAutocomplete(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return mbs.getMedicalBoardAutocomplete(payload, request, response);
	}
	
	@RequestMapping(value = "/mbMembersWaitingList", method = RequestMethod.GET)
	public ModelAndView mbMembersWaitingList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbMembersWaitingList");
		return mav;

	}
	
	@RequestMapping(value = "/mbMembersAFMSForm", method = RequestMethod.GET)
	public ModelAndView mbMembersAFMSForm(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbMembersAFMSForm called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbMembersAFMS15Form";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		String payload = "{\"visitId\":"+visitId+"}";
		String jsonResponse = mbs.getPatientDetailToValidate(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getPatientDetailToValidate", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPatientDetailToValidate(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return mbs.getPatientDetailToValidate(payload, request, response);
	}
	
	
	@RequestMapping(value = "/specialistWaitingList", method = RequestMethod.GET)
	public ModelAndView specialistWaitingList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbSpecialistBoardWaitingList");
		return mav;

	}
	
	@RequestMapping(value = "/mbSpecialistForOpinionDetails", method = RequestMethod.GET)
	public ModelAndView mbSpecialistForOpinionDetails(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbSpecialityForOpinionDetails";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getPatientReferalDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getPatientReferalDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {

		return mbs.getPatientReferalDetail(payload, request, response);
	}
	
	@RequestMapping(value="/getRefferedOpinionDetails", method = RequestMethod.POST)
	public String getRefferedOpinionDetails(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
	  return mbs.getRefferedOpinionDetails(payload, request, response);
	}
	
	@RequestMapping(value = "/transcriptionWaitingList", method = RequestMethod.GET)
	public ModelAndView transcriptionWaitingList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbTranscriptionWaitingList");
		return mav;

	}
	
	@RequestMapping(value = "/mbTranscriptionDetailsForm15", method = RequestMethod.GET)
	public ModelAndView mbTranscriptionDetailsForm15(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbMembersAFMS15Form";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbTranscriptionDetailsForm16", method = RequestMethod.GET)
	public ModelAndView mbTranscriptionDetailsForm16(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		//String jsp = "mbMembersAFMS16Form";
		String jsp = "afmsf16";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		//String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18P(payload.toString(), request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
		
	@RequestMapping(value="/saveTranscriptionData", method = RequestMethod.POST)
	public String saveTranscriptionData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		//System.out.println("Transcription Data submit: " +payload );
		
		return mbs.saveTranscriptionData(payload, request, response);
	}
	
	@RequestMapping(value = "/mbTranscriptionSubmit", method = RequestMethod.GET)
	public ModelAndView mbTranscriptionSubmit(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbTranscriptionSubmit data Submited Sucessufully");
		String jsp = "mbTranscriptionSubmit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/moValidate15Submit", method = RequestMethod.GET)
	public ModelAndView moValidate15Submit(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("moValidateSubmit data Submited Sucessufully");
		String jsp = "mbValidate15Submit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/validateMoTranscEntry", method = RequestMethod.GET)
	public ModelAndView validateMoTranscEntry(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbValidateWaitingList");
		return mav;

	}
	
	@RequestMapping(value = "/mbValidateDetailsForm15", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm15(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS15Form";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbValidateDetailsForm16", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm16(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS16Form";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		//String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18P(payload.toString(), request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/getMOValidateWaitingList", method = RequestMethod.POST)
	public String getMOValidateWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return mbs.getMOValidateWaitingList(payload, request, response);
	}
	
	@RequestMapping(value="/getDataValidateAMSFform", method = RequestMethod.POST)
	public String getDataValidateAMSFform(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
	  return mbs.getDataValidateAMSFform(payload, request, response);
	}
	
	@RequestMapping(value="/updateSpecialistOpiniondetails", method = RequestMethod.POST)
	public String updateSpecialistOpiniondetails(MultipartHttpServletRequest request, HttpServletResponse response) {	
		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
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
					
					String serviceNo=request.getParameter("serviceNo");
					String year=request.getParameter("year");
					String docType=request.getParameter("docType");
					String type=request.getParameter("type");
					if(name.contains("referalFileUpload"))
					{
						docType="2";
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
					  String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
					  ridcIdValues+=""+ridcId+","; fileNameValue+=""+myFileName+",";
					  rmsAllValue+=""+ridcId+",";
					 

					if (StringUtils.isNotEmpty(name) && name.contains("referalFileUpload")) {
						referalRmsId += "" + ridcId + ",";
					}
					
				}

			}
			obj.put("ridcIdValues", ridcIdValues);
			obj.put("referalRmsId", referalRmsId);
			
		} catch (Exception e) {

		}
		//return mbs.updateSpecialistOpiniondetails(request, request, response);
		return mbs.updateSpecialistOpiniondetails(obj.toString(), request, response);
	}
	
	@RequestMapping(value="/saveAmsfForm15Details", method = RequestMethod.POST)
	public String saveAmsfForm15Details(MultipartHttpServletRequest request, HttpServletResponse response) {	
		//System.out.println("Transcription AMSF 15 Data submit: " +request );
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
				info.put("documentName", myFileName);
				info.put("documentType", contentType);
				
				//System.out.println("info"+info);
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
					  String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
					  ridcIdValues+=""+ridcId+","; fileNameValue+=""+myFileName+",";
					  rmsAllValue+=""+ridcId+",";
					 

				
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
           e.printStackTrace();
		}
		//return mbs.saveAmsfForm15Details(payload, request, response);
		return mbs.saveAmsfForm15Details(obj.toString(), request, response);
		
	}
	
	@RequestMapping(value="/getDataValidateAMSF15form", method = RequestMethod.POST)
	public String getDataValidateAMS15Fform(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
	  return mbs.getDataValidateAMSF15form(payload, request, response);
	}
	
	@RequestMapping(value = "/mbCheckListAMSFForm15", method = RequestMethod.GET)
	public ModelAndView mbCheckListAMSFForm15(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbAFMS15FormCheckList called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbAFMS15FormCheckList";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println(payload.toString());
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/newMbCheckListAMSFForm15", method = RequestMethod.GET)
	public ModelAndView newMbCheckListAMSFForm15(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbAFMS15FormCheckList called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "newMbAFMS15FormCheckList";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/saveAmsf15CheckList", method = RequestMethod.POST)
	public String saveAmsf15CheckList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		//System.out.println("Transcription AMSF 15 CheckList submit: " +payload.toString());
		
		return mbs.saveAmsf15CheckList(payload, request, response);
	}
	
	@RequestMapping(value = "/mbVerifyCheckListAMSFForm15", method = RequestMethod.GET)
	public ModelAndView mbVerifyCheckListAMSFForm15(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbAFMS15FormCheckList called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS15FormCheckList";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	} 
	
	@RequestMapping(value="/getAmsf15CheckList", method = RequestMethod.POST)
	public String getAmsf15CheckList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
	  return mbs.getAmsf15CheckList(payload, request, response);
	}
	
	@RequestMapping(value = "/mbValidateDetailsForm15ForForward", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm15ForForward(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS15FormForFowrwarded";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("flag", "0");
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbValidateDetailsForm15ForRMO", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm15ForRMO(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails RMO called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS15FormForRMO";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("flag", "0");
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbValidateDetailsForm15ForPDMS", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm15ForPDMS(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails PDMS called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS15FormForPDMS";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("flag", "0");
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbValidateDetailsForm15ForForwardData", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm15ForForwardData(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS15FormForFowrwarded";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("flag", "1");
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbGetSpecialistOpinionDetails", method = RequestMethod.GET)
	public ModelAndView mbGetSpecialistOpinionDetails(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbGetSpecialityForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbGetSpecialityForOpinionDetails";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
	//	String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	} 
	
	@RequestMapping(value = "/mbValidateDetailsForm16ForForward", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm16ForForward(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS16FormForFowrwarded";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
	//	String payload = "{\"visitId\":"+visitId+"}";
		//String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18P(payload.toString(), request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbValidateDetailsForm16ForRMO", method = RequestMethod.GET)
	public ModelAndView mbValidateDetailsForm16ForRMO(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbSpecialistForOpinionDetails RMO called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbValidateAFMS16FormForRMO";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		//String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18P(payload.toString(), request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbTranscriptionSubmit16", method = RequestMethod.GET)
	public ModelAndView mbTranscriptionSubmit16(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("mbTranscriptionSubmit data Submited Sucessufully");
		String jsp = "mbTranscriptionSubmit16";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		//String payload = "{\"visitId\":"+visitId+"}";
		 HttpSession session=request.getSession();
			Integer userId= (Integer) session.getAttribute("user_id");
			 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
			 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/mbReport", method = RequestMethod.GET)
	public ModelAndView mbReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbReport");
		return mav;
	}
	
	@RequestMapping(value = "/getAllEmployeeCategory", method = RequestMethod.POST)
	public String getAllEmployeeCategory(@RequestBody String employeeCategoryPayload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getAllEmployeeCategory");
		String OSBURL = ipAndPort + URL;
		return  RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, employeeCategoryPayload);
	}
	
	@RequestMapping(value="/getMBMedicalCategory", method = RequestMethod.POST)
	public String getMBMedicalCategory(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
	  return mbs.getMBMedicalCategory(payload, request, response);
	}
	
	@RequestMapping(value = "/showCreateInvestigationTemplate", method = RequestMethod.GET)
	public ModelAndView showCreateInvestigationTemplate(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "mbInvestigationTemplate";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/piMBWaitingListMO", method = RequestMethod.GET)
	public ModelAndView validateMEWaitingMo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("piMBWaitingListMO");
		return mav;

	}
	
	@RequestMapping(value = "/preliminaryMBWaitingDetailMO", method = RequestMethod.GET)
	public ModelAndView preliminaryMBWaitingDetailMO(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "preliminaryInvestigationMBMO";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		 HttpSession session=request.getSession();
		Integer userId= (Integer) session.getAttribute("user_id");
		 Integer hospitalId=(Integer) session.getAttribute("hospital_id");
		 String payload = "{\"visitId\":" + visitId +","+"\"userId\":" + userId + ","+"\"hospitalId\":" + hospitalId +"}";
		
		//String payload = "{\"visitId\":"+visitId+"}";
		
		String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
		//System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
   @RequestMapping(value="/getInvestigationAndResult", method = RequestMethod.POST)
	public String getInvestigationAndResult(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			
			return mbs.getInvestigationAndResult(payload, request, response);
		}
   
   @RequestMapping(value="/getDocumentList", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getDocumentList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return mbs.getDocumentList(payload, request, response);
	}
   
   @RequestMapping(value = "/mbNewEntryForm", method = RequestMethod.GET)
	public ModelAndView dataEntryForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("mbNewEntryForm");
		return mav;
	}
   
   @RequestMapping(value = "/newMbAFMSForm", method = RequestMethod.GET)
	public ModelAndView newMbAFMSForm(HttpServletRequest request, HttpServletResponse response) {
		String examTypeId = request.getParameter("examTypeId");
		String[] examTypeIds = null;
		String examTypeCode = "";
		if (StringUtils.isNotEmpty(examTypeId) && examTypeId.contains("@@")) {
			examTypeIds = examTypeId.split("@@");
			examTypeCode = examTypeIds[1];
		} else {
			examTypeCode = examTypeId.trim();
		}
		String mbForm15 = UtilityServices.getValueOfPropByKey("mbForm15");
	
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
			
			if (StringUtils.isNotEmpty(examTypeCode) && mbForm15.equalsIgnoreCase(examTypeCode)) {
				//System.out.println("hellllllllllllllll");
				jsp = "newEntryForm15ReadOnly";

			}
			
		}
		else {
		
		if (StringUtils.isNotEmpty(examTypeCode) && mbForm15.equalsIgnoreCase(examTypeCode)) {
			//System.out.println("hellllllllllllllll");
			jsp = "mbNewEntryMembersAFMS15Form";

		}
		
		}
		//System.out.println("jsonResponse " + jsonResponse);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("examTypeCode", examTypeCode);
		
		mv.addObject("viewOrEditFlag",viewOrEditFlag);
		mv.addObject("newEntryStatus",newEntryStatus);
		
		mv.setViewName(jsp);
		return mv;
	}

}
