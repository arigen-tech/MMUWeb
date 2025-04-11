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

import org.apache.commons.io.FilenameUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.excel.ExportExcelDiaDidi2;
import com.mmu.web.service.OpdService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.ProjectUtils;
import com.mmu.web.utils.RestUtils;



@RequestMapping("/opd")
@RestController
@CrossOrigin
public class OpdWebController  {
	
	@Autowired
	OpdService os;
	
	@Autowired
	private Environment environment;
	
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	@RequestMapping(value="/getPreConsPatientWatingWeb", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String preConsPatientWatingWeb(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.preConsPatientWatingWeb(payload, request, response);
	}
	
	@RequestMapping(value = "/preOpdWaitingList", method = RequestMethod.GET)
	public ModelAndView preOpdWaitingList(HttpServletRequest request,	HttpServletResponse response) {
		/*boolean check=ProjectUtils.checksession(request);
		if(check){*/
		////System.out.println("pre waiting called");
		String jsp = "opdPreConsulation";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
		//}
		//return new ModelAndView("redirect:/dashboard/login");
	}
	
	@RequestMapping(value = "/addVitalRecords", method = RequestMethod.GET)
	public ModelAndView addVitalRecord(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "addVitalPreConsultant";
		int visitId= Integer.parseInt(request.getParameter("visitId"));
		String payload = "{\"visitId\":"+visitId+"}";
		String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
		
	}
	
	@RequestMapping(value="/saveVitailsPatientdetails", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveVitailsPatientdetails(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.saveVitailsPatientdetails(payload, request, response);
	}
	
	@RequestMapping(value="/getIdealWeight", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getIdealWeight(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getIdealWeight(payload, request, response);
	}
	
	@RequestMapping(value="/getOpdWaitingList", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getOpdWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getOpdWaitingList(payload, request, response);
	}
	
/*	@RequestMapping(value="/getOpdPatientDetails", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getOpdPatinetDetails(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getOpdPatinetDetails(payload, request, response);
	}*/
	
	@RequestMapping(value = "/getOpdPatientModel", method = RequestMethod.GET)
	public ModelAndView getOpdPatientModel(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "opdMain";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		String payload = "{\"visitId\":"+visitId+"}";
		String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	
	@RequestMapping(value="/getIcdList", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getIcdList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getIcdList(payload, request, response);
	}
	
	@RequestMapping(value = "/getFamilyPatinetHistory", method = RequestMethod.GET)
	public ModelAndView getFamilyPatientHistory(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "temp_presentCompalint";
		
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/getChiefComplaint", method = RequestMethod.GET)
	public ModelAndView getChiefComplaint(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "temp_chiefCompalint";
		
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
@RequestMapping(value="/saveOpdPatientdetails", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveOpdPatientdetails(MultipartHttpServletRequest request, HttpServletResponse response) {	
	Box box = HMSUtil.getBox(request);
	JSONObject obj = new JSONObject(box);
    ////System.out.println("data Opd submit: " +obj.toString() );
    
    Iterator<String> itr = request.getFileNames();
 	try {
		while (itr.hasNext()) {
			 MultipartFile file = request.getFile(itr.next());
		 if(file.getOriginalFilename()!=null && file.getOriginalFilename()!="" )
		 {	 
			 String myFileName = "ecgDocument";
			try {
				String visitId= obj.get("visitId").toString();
				String rootPath = environment.getProperty("mmu.service.ecg.upload");
				visitId=HMSUtil.getReplaceString(visitId);
				
				String path = ProjectUtils.getPatientDocPath(rootPath,visitId);
				
				byte[] bytes = file.getBytes();
				File myFile = new File(
						path + "/" + myFileName + "." + FilenameUtils.getExtension(file.getOriginalFilename()));
				FileOutputStream opStream = new FileOutputStream(myFile);
				opStream.write(bytes);
				opStream.flush();
				opStream.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			
			}
		  }
		}
	   }
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return os.saveOpdPatientdetails(obj.toString(), request, response);
	}

	@RequestMapping(value = "/opdSubmit", method = RequestMethod.GET)
	public ModelAndView submitOpdPatientdetails(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("OPD Data Submited Successfully");
		String jsp = "opdSubmit";
		Long visitId= Long.parseLong(request.getParameter("visitId"));
		String payload = "{\"visitId\":"+visitId+"}";
		String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("msgRecall", "OPD Submited Successfully");
		
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/opdWaitingList", method = RequestMethod.GET)
	public ModelAndView opdWaitingList(HttpServletRequest request,	HttpServletResponse response) {
		boolean check=ProjectUtils.checksession(request);
		/*if(check){*/
		////System.out.println("waiting called");
		String jsp = "opdWaitingList";
		//String jsonResponse = os.saveOpdPatientdetails(payload, request, response);
		//////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		//mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
		//}
		//return new ModelAndView("redirect:/dashboard/login");
	}
	
	@RequestMapping(value = "/showCreateInvestigationTemplate", method = RequestMethod.GET)
	public ModelAndView showCreateInvestigationTemplate(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "opdInvestigationTemplate";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/opdUpdateInvestigationTemplate", method = RequestMethod.GET)
	public ModelAndView opdUpdateInvestigationTemplate(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("update investigation template called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "opdUpdateInvestigationTemplate";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/opdDeleteInvestigationTemplate", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String opdDeleteInvestigationTemplate(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.opdDeleteInvestigationTemplate(payload, request, response);
	}
	
	@RequestMapping(value="/getOpdPreviousVisitRecord", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getOpdPreviousVisitRecord(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getOpdPreviousVisitRecord(payload, request, response);
	}
	
	@RequestMapping(value="/getPreviousLabRecord", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getPreviousLabRecord(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getPreviousLabInvestigation(payload, request, response);
	}
	
	@RequestMapping(value = "/showPreveiousVisit", method = RequestMethod.GET)
	public ModelAndView showPreveiousVisit(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "opdPreveiousVisit";
		Long patientId= Long.parseLong(request.getParameter("patientId"));
		String payload = "{\"patientId\":"+patientId+"}";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/getOpdPreviousVital", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getOpdPreviousVital(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getOpdPreviousVital(payload, request, response);
	}
	
	
	@RequestMapping(value = "/showPreveiousVital", method = RequestMethod.GET)
	public ModelAndView showPreveiousVital(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("vital called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "opdPreviousVital";
		int patientId= Integer.parseInt(request.getParameter("patientId"));
		String payload = "{\"patientId\":"+patientId+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/showEHRRecords", method = RequestMethod.GET)
	public ModelAndView showEHRRecords(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "patientSummary";
		int patientId= Integer.parseInt(request.getParameter("patientId"));
		String payload = "{\"patientId\":"+patientId+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/showPreveiousLab", method = RequestMethod.GET)
	public ModelAndView showPreveiousLab(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("showPreveiousLab called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "preveiousLabInvestigation";
		int patientId= Integer.parseInt(request.getParameter("patientId"));
		String payload = "{\"patientId\":"+patientId+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/showPreveiousRadio", method = RequestMethod.GET)
	public ModelAndView showPreveiousRadio(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("showPreveiousRadio called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "preveiousRadioInvestigation";
		int patientId= Integer.parseInt(request.getParameter("patientId"));
		String payload = "{\"patientId\":"+patientId+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/showUpdateInvestigationTemplate", method = RequestMethod.GET)
	public ModelAndView updateCreateInvestigationTemplate(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "updateInvestigationTemplate";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/saveOpdInvestigationTemplates", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveOpdInvestigationTemplates(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		////System.out.println("data : " +payload );
		return os.saveOpdInvestigationTemplates(payload, request, response);
	}
	
	
	@RequestMapping(value="/getIinvestigationList", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getIinvestigationList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getIinvestigationList(payload, request, response);
	}
	
	@RequestMapping(value="/getMasDisposalList", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMasDisposalList(@RequestBody String payload,HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getMasDisposalList(payload,request, response);
	}
	
	@RequestMapping(value = "/createTreatmentTemplate", method = RequestMethod.GET)
	public ModelAndView createTreatmentTemplate(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "prescriptionTemplate";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/createProcedureMasters", method = RequestMethod.GET)
	public ModelAndView createProcedureMasters(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("Proecdure Masters called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "opdProcedureMaster";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/opdEmpanlledMaster", method = RequestMethod.GET)
	public ModelAndView opdEmpanlledMaster(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("Empanelled Masters called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "opdEmpanlledMaster";
		int empid= Integer.parseInt(request.getParameter("employeeId"));
		String payload = "{\"employeeId\":"+empid+"}";
		String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/saveTreatmentOpdTemplates", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveTreatmentOpdTemplates(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		////System.out.println("data : " +payload );
		return os.saveTreatmentOpdTemplates(payload, request, response);
	}
	
	@RequestMapping(value="/savePreocdureMasters", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String savePreocdureMasters(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		////System.out.println("data procedureCare: " +payload );
		return os.savePreocdureMasters(payload, request, response);
	}
	
	@RequestMapping(value="/saveEmpanlledHospitalMasters", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String saveEmpanlledHospitalMasters(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		////System.out.println("data EmpanlledHospital: " +payload );
		return os.saveEmpanlledHospitalMasters(payload, request, response);
	}
	
	@RequestMapping(value="/getMasStoreItemList", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMasStoreItemList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getMasStoreItemList(payload, request, response);
	}
	
	@RequestMapping(value="/getMasFrequency", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMasFrequency(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getMasFrequency(payload, request, response);
	}
	
	@RequestMapping(value="/getMasNursingCare", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMasNursingCare(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		////System.out.println("Nursing Care Called");
		return os.getMasNursingCare(payload, request, response);
	}
	
	@RequestMapping(value="/getTemplateName", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getTemplateName(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getTemplateName(payload, request, response);
	}
	
	@RequestMapping(value="/getEmpanelledHospital", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getEmpanelledHospital(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getEmpanelledHospital(payload, request, response);
	}
	
	@RequestMapping(value="/getOpdReportsDetailsbyServiceNo", method = RequestMethod.POST)
	public String getOpdReportsDetailsbyServiceNo(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getOpdReportsDetailsbyServiceNo(payload, request, response);
	}
	
	@RequestMapping(value="/getOpdReportsDetailsbyPatinetId", method = RequestMethod.POST)
	public String getOpdReportsDetailsbyPatinetId(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getOpdReportsDetailsbyPatinetId(payload, request, response);
	}
	
	@RequestMapping(value = "/getOpdReportsDetailsbyServiceNo", method = RequestMethod.GET)
	public ModelAndView getOpdReportsDetailsbyServiceNo(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("Reports called");
		String jsp = "opdReports";
		//String jsonResponse = os.saveOpdPatientdetails(payload, request, response);
		//////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		//mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	 @RequestMapping(value="/getDocumentListForPatient", method = RequestMethod.POST)
		public String getDocumentListForPatient(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {	
			return os.getDocumentListForPatient(data, request, response);
		}
	
	  @RequestMapping(value = "/uploadDocumentForPatient", method = RequestMethod.POST)
	  public String uploadDocumentForPatient(HttpServletRequest request,
	            @RequestParam CommonsMultipartFile[] uploadFile) throws Exception {	
		  return os.uploadDocumentForPatient(request, uploadFile);
	  }	


	
	@RequestMapping(value = "/opdPrescriptionReports", method = RequestMethod.GET)
	public ModelAndView opdPrescriptionReports(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("Reports called");
		String jsp = "opdReports";
		//String jsonResponse = os.saveOpdPatientdetails(payload, request, response);
		//////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		//mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/opdEhrReports", method = RequestMethod.GET)
	public ModelAndView opdEhrReports(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("Reports called");
		String jsp = "ehrReports";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value="/getTemplateInvestigation", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getTemplateInvestigation(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getTemplateInvestigation(payload, request, response);
	}
	
	@RequestMapping(value="/getTemplateTreatment", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getTemplateTreatment(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getTemplateTreatment(payload, request, response);
	}
	
	
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	@RequestMapping(value = "/getCaseSheet", method = RequestMethod.GET)
	public ModelAndView getCaseSheet(HttpServletRequest request,	HttpServletResponse response) {

		////System.out.println("Case Sheet Method called");
		Map<String, Object> map = new HashMap<String, Object>();
		//String jsp = "opdMain";
		int visitId= Integer.parseInt(request.getParameter("visitId"));
		String payload = "{\"visitId\":"+visitId+"}";
		String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
		////System.out.println("jsonResponse "+jsonResponse);
		ModelAndView mv =new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.addObject("msgCaseSheet", "Case Sheet VisitId.");
		//mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value="/getMasDispUnit", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMasDispUnit(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getMasDispUnit(payload, request, response);
	}
	
	@RequestMapping(value="/getMasItemClass", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMasItemClass(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getMasItemClass(payload, request, response);
	}
	
	@RequestMapping(value="/getMasStoreItemNip", method = RequestMethod.POST)
	 //HashMap<String,String> listMap =  new HashMap<String,String>();
	public String getMasStoreItemNip(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {	
		
		return os.getMasStoreItemNip(payload, request, response);
	}
	

	  @RequestMapping(value="/opdUploadDocument", method = RequestMethod.GET)
			public ModelAndView opdUploadDocument(HttpServletRequest request, HttpServletResponse response) {
			  Map<String,Object> map = new HashMap<String,Object>();
				String jsp = "opdUploadDocuments";
				return new ModelAndView(jsp,"map",map);
	  }
	  
	  @RequestMapping(value="/deleteUploadDocument", method = RequestMethod.POST)
			public String deleteUploadDocument(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {	
				return os.deleteUploadDocument(data, request, response);
			}
		
	 
	  @RequestMapping(value="/getMasDepartmentList", method = RequestMethod.POST)
		 //HashMap<String,String> listMap =  new HashMap<String,String>();
		public String getMasDepartmentList(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			
			return os.getMasDepartmentList(payload, request, response);
		}
	  
	  @RequestMapping(value="/getMasHospitalList", method = RequestMethod.POST)
		 //HashMap<String,String> listMap =  new HashMap<String,String>();
		public String getMasHospitalList(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			
			return os.getMasHospitalList(payload, request, response);
		}
	
	@RequestMapping(value="/show",method=RequestMethod.POST)
	public ResponseEntity<Object> showRegistrationJsp(@RequestBody String payload,HttpServletRequest request,HttpServletResponse httpServletResponse) {
   
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("departmentName", "GENERAL MEDICINE");
		map.put( "employeeName", "krishna" );
		map.put( "patientName", "Rahul" );
		map.put( "gender", "male" );
		map.put( "visitId", 2 );
		map.put( "patientId", 1234 );
		map.put( "tokenNo", 22 );
		map.put( "priority", 3);
		map.put( "doctorname", "Thakur" );
		map.put( "age", 30 );
		map.put( "status", "w" );
		//list.add(map)
		return new ResponseEntity<>(map,HttpStatus.ACCEPTED);
	}

	@RequestMapping(value = "/obesityWaitingJsp", method = RequestMethod.GET)
	public ModelAndView obesityWaitingLJsp() {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "obesityWaitingList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/obesityWaitingList", method = RequestMethod.POST)
	public String obesityWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		String result = os.obesityWaitingList(payload);
		return result;
	}

	@RequestMapping(value = "/patientObesityDetailjsp", method = RequestMethod.GET)
	public ModelAndView patientObesityDetailjsp(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "patientObesityDetail";
		int id = Integer.parseInt(request.getParameter("Id"));
		String payload = "{\"id\":" + id + "}";
		String jsonResponse = os.getObesityDetail(payload, request, response);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/saveObesityDetails", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String saveObesityDetails(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "saveObesityDetail");
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/saveObesityDetails",requestHeaders, payload);
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		return data;
	}

	@RequestMapping(value = "/referralWaitingList", method = RequestMethod.GET)
	public ModelAndView referralWaitingJsp() {
		////System.out.println("inside referralWaitingJsp");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "referralWaitingList";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/referredPatientList", method = RequestMethod.POST)
	public String referredPatientList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "referralWaitingList");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/referredPatientList",requestHeaders, payload);
		return data;
	}

	@RequestMapping(value = "/referredPatientDetail", method = RequestMethod.GET)
	public ModelAndView referredPatientDetail(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "referredPatientDetail";
		int id = Integer.parseInt(request.getParameter("Id"));
		String payload = "{\"id\":" + id + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "referralDetailList");
		String jsonResponse = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		//String jsonResponse = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/referredPatientDetail",requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", jsonResponse);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/updateReferralDetail", method = RequestMethod.POST)
	public String updateReferralDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "updateReferralDetail");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/updateReferralDetail",requestHeaders, payload);
		return data;
	}

	@RequestMapping(value = "/admissionPending", method = RequestMethod.GET)
	public ModelAndView getAdmissionDischargeList() {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "admissionPending";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getAdmissionPendingList", method = RequestMethod.POST)
	public String getAdmissionDischargeList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getAdmissionDischargeList");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/getAdmissionDischargeList",requestHeaders, payload);

		return data;
	}

	@RequestMapping(value = "/dischargePending", method = RequestMethod.GET)
	public ModelAndView getDischargePending() {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "getDischargePending";
		ModelAndView mv = new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/getDischargePendingList", method = RequestMethod.POST)
	public String getDischargePendingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		// getPendingDischargeList
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getPendingDischargeList");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
	    //String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/getPendingDischargeList",requestHeaders, payload);

		return data;
	}

	@RequestMapping(value = "/admission", method = RequestMethod.GET)
	public ModelAndView admission(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "admission";
		String id = request.getParameter("id");
		String payload = "{\"id\":" + id + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "admissionMain");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
	    //String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/admissionMain",requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", data);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/discharge", method = RequestMethod.GET)
	public ModelAndView discharge(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "discharge";
		String id = request.getParameter("id");
		String payload = "{\"id\":" + id + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "dischargeMain");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
	    //String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/dischargeMain",requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", data);
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/savePatientAdmission", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String savePatientAdmission(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "savePatientAdmission");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		//String data =RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/savePatientAdmission", requestHeaders, payload);
		return data;
	}

	@RequestMapping(value = "/newAdmission", method = RequestMethod.GET)
	public ModelAndView newAdmission(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		String jsp = "newAdmission";
		mv.setViewName(jsp);
		mv.addObject("genderList", getGenderList("{}",request,response));
		mv.addObject("rankList", getRankList("{}",request,response));
		mv.addObject("unitList", getUnitList("{}",request,response));
		return mv;
	}

	@RequestMapping(value = "/getServiceWisePatientList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String getServiceWisePatientList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getServiceWisePatientList");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/getServiceWisePatientList", requestHeaders, payload);
		return data;
	}

	@RequestMapping(value = "/saveNewAdmission", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String saveNewAdmission(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "saveNewAdmission");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
	    //String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/saveNewAdmission", requestHeaders, payload);
		return data;
	}

	@RequestMapping(value = "/nursingCareWaitingJSP", method = RequestMethod.GET)
	public ModelAndView nursingCareWaitingJSP(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		String jsp = "nursingCareWaitingJSP";
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/nursingCareWaitingList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String nursingCareWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/nursingCareWaitingList", requestHeaders, payload);
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "nursingCareWaitingList");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		return data;
	}

	@RequestMapping(value = "/nursingCareDetail", method = RequestMethod.GET)
	public ModelAndView nursingCareDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		String jsp = "nursingCareDetail";
		String id = request.getParameter("header_id");
		String payload = "{\"header_id\":" + id + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/getNursingCareDetail", requestHeaders, payload);
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getNursingCareDetail");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		mv.addObject("data", data);
		mv.setViewName(jsp);
		return mv;

	}
	
	@RequestMapping(value = "/getSpecificProcedureDetail", method = RequestMethod.GET)
	public ModelAndView getSpecificProcedureDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		String jsp = "saveProcedureDetail";
		String header_id = request.getParameter("id");
		String payload = "{\"header_id\":\"" + header_id + "\"}"; 
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/getProcedureDetail", requestHeaders, payload);
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getProcedureDetail");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		mv.addObject("data", data);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/saveProcedureDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String saveProcedureDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/saveProcedureDetail", requestHeaders, payload);
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "saveProcedureDetail");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		return data;
	}
	
	@RequestMapping(value = "/physioTherapyWaitingJSP", method = RequestMethod.GET)
	public ModelAndView physioTherapyWaitingJSP(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		String jsp = "physioTherapyWaitingJSP";
		mv.setViewName(jsp);
		return mv;
	}

	@RequestMapping(value = "/physioTherapyWaitingList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String physioTherapyWaitingList(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/physioTherapyWaitingList", requestHeaders, payload);
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "physiotherapyWaitingList");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		return data;
	}
	
	@RequestMapping(value = "/getphysioTherapyDetail", method = RequestMethod.GET)
	public ModelAndView getphysioTherapyDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		String jsp = "physioTherapyDetail";
		String id = request.getParameter("header_id");
		String payload = "{\"header_id\":" + id + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/getphysioTherapyDetail", requestHeaders, payload);
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getphysioTherapyDetail");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		mv.addObject("data", data);
		mv.setViewName(jsp);
		return mv;

	}
	
	@RequestMapping(value = "/getSpecificTherapyDetail", method = RequestMethod.GET)
	public ModelAndView savePhysioDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		String jsp = "saveTherapyDetail";
		String header_id = request.getParameter("id");
		String payload = "{\"header_id\":\"" + header_id + "\"}"; 
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		//String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/v0.1/opd/getProcedureDetail", requestHeaders, payload);
		String OsbURL = HMSUtil.getProperties("urlextension.properties", "getProcedureDetail");
		String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
		mv.addObject("data", data);
		mv.setViewName(jsp);
		return mv;
	}
	
	// Added by Avinash OPD Patient recalll
			@RequestMapping(value = "/opdPatientRecall", method = RequestMethod.GET)
			public ModelAndView opdPatientRecall(HttpServletRequest request, HttpServletResponse response) {
				////System.out.println("Patient Recall called");
				String jsp = "opdRecall";
				ModelAndView mv = new ModelAndView();
				mv.setViewName(jsp);
				return mv;
			}

			@RequestMapping(value = "/getOpdPatientRecalls", method = RequestMethod.POST)
			public String getOpdPatientRecalls(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				return os.getOpdWaitingList(payload, request, response);
			}

			@RequestMapping(value = "/getOpdPatientRecallModel", method = RequestMethod.GET)
			public ModelAndView getOpdPatientRecallModel(HttpServletRequest request, HttpServletResponse response) {
				////System.out.println("called");
				String jsp = "opdMainPaitentRecall";
				int visitId = Integer.parseInt(request.getParameter("visitId"));
				String payload = "{\"visitId\":" + visitId + "}";
				String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
				////System.out.println("jsonResponse " + jsonResponse);
				ModelAndView mv = new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
			}

			@RequestMapping(value = "/getExaminationDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getExaminationDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
			
			/*  MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,
			  String>(); String Url = HMSUtil.getProperties("urlextension.properties","GetExaminationDetail");
			  String OSBURL = ipAndPort + Url; 
			  String data=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);*/
			 
				
			
			  /*MultiValueMap<String, String> requestHeaders = new
			 LinkedMultiValueMap<String, String>(); String data =
			 RestUtils.postWithHeaders(
			 "http://localhost:8082/AshaShipServices/v0.1/opd/getExaminationDetail",
			  requestHeaders, payload);*/
				String data=os.getExaminationDetail(payload, request, response);
				return data;
			}

			@RequestMapping(value = "/getInvestigationDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getInvestigationDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.getInvestigationDetail(payload, request, response);
				return data;
			}

			@RequestMapping(value = "/getTreatmentPatientDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getTreatmentPatientDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
			
			/* MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,
			  String>(); String Url = HMSUtil.getProperties("urlextension.properties","GetTreatmentPatientDetail"); 
			  String OSBURL = ipAndPort + Url; 
			  String data=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);*/
			
				
			
			  /*MultiValueMap<String, String> requestHeaders = new
			  LinkedMultiValueMap<String, String>(); String data =
			  RestUtils.postWithHeaders(
			  "http://localhost:8082/AshaShipServices/v0.1/opd/getTreatmentPatientDetail",
			  requestHeaders, payload);*/
			
				String data=os.getTreatmentPatientDetail(payload, request, response);
				
				return data;
			}

			@RequestMapping(value = "/getPatientHistoryDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getPatientHistoryDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
			
				String data=os.getPatientHistoryDetail(payload, request, response);
				return data;
			}

			@RequestMapping(value = "/getPatientReferalDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getPatientReferalDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
			
			/*  MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>(); 
			  String Url = HMSUtil.getProperties("urlextension.properties","GetPatientReferalDetail");
			  String OSBURL = ipAndPort + Url;
			  String data= RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);*/
			
			
			  /*MultiValueMap<String, String> requestHeaders = new
			  LinkedMultiValueMap<String, String>(); String data =
			  RestUtils.postWithHeaders(
			  "http://localhost:8082/AshaShipServices/v0.1/opd/getPatientReferalDetail",
			  requestHeaders, payload);*/
				
				String data=os.getPatientReferalDetail(payload, request, response);
				return data;
				//return RestUtils.postWithHeaders(data, requestHeaders, payload);
			}

	@RequestMapping(value = "/deleteGridRow", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
	public String deleteGridRow(@RequestBody String payload, HttpServletRequest request, HttpServletResponse response) {
		
	/*  MultiValueMap<String, String> requestHeaders = new
	  LinkedMultiValueMap<String, String>(); */
	 // String data =RestUtils.postWithHeaders("http://localhost:8082/AshaShipServices/v0.1/opd/deleteGridRow", requestHeaders,payload);
	  String data =os.deleteGridRow(payload, request, response);
		return data;
	
	/*
	 * MultiValueMap<String,String> requestHeaders = new
	 * LinkedMultiValueMap<String,String>(); String Url =
	 * HMSUtil.getProperties("urlextension.properties", "DeleteGridRow"); String
	 * OSBURL = ipAndPort + Url;
	 * 
	 * return RestUtils.postWithHeaders(OSBURL, requestHeaders, payload);
	 */
		
	}

			@RequestMapping(value = "/submitPatientRecall", method = RequestMethod.POST)
			public ModelAndView updatAndInsertPatientRecall(MultipartHttpServletRequest request, HttpServletResponse response) {
				Box box = HMSUtil.getBox(request);
				JSONObject obj = new JSONObject(box);
	            
				 Iterator<String> itr = request.getFileNames();
				 	try {
						while (itr.hasNext()) {
							 MultipartFile file = request.getFile(itr.next());
							 if(file.getOriginalFilename()!=null && file.getOriginalFilename()!="")
							 {
							 String myFileName = "ecgDocument";
							try {
								String visitId= obj.get("VisitID").toString();
								visitId=HMSUtil.getReplaceString(visitId);
								String rootPath = environment.getProperty("mmu.service.ecg.upload");
								String path = ProjectUtils.getPatientDocPath(rootPath,visitId);
								byte[] bytes = file.getBytes();
								File myFile = new File(
										path + "/" + myFileName + "." + FilenameUtils.getExtension(file.getOriginalFilename()));
								FileOutputStream opStream = new FileOutputStream(myFile);
								opStream.write(bytes);
								opStream.flush();
								opStream.close();
								
							} catch (Exception e) {
								e.printStackTrace();
							
							}
						 }	
						}
					   }
						catch(Exception e)
						{
							e.printStackTrace();
						}
				//MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				  String Url = HMSUtil.getProperties("urlextension.properties","submitPatientRecall");
				  String OSBURL = ipAndPort + Url;
				  String data =  os.updatAndInsertPatientRecall(obj.toString(), request, response);
				//String data = RestUtils.postWithHeaders("http://localhost:8082/AshaShipServices/v0.1/opd/submitPatientRecall",requestHeaders, obj.toString());
				OSBURL=data;
				ModelAndView mv = new ModelAndView();
				String jsp = "opdSubmit";
				mv.addObject("data",data);
				mv.addObject("redirectValue","opdRecall");
				
				 JSONObject jSONObject =new JSONObject (data);
				String opdMessage = jSONObject.get("opdMessage").toString();
				mv.addObject("msgRecall", opdMessage);
				String empCategory = obj.get("empCategory").toString();
				empCategory = HMSUtil.getReplaceString(empCategory);
				String siqValue = obj.get("siqValue").toString();
				siqValue = HMSUtil.getReplaceString(siqValue);
				String flagForMLC = obj.get("markAsMlcFlag").toString();
				flagForMLC = HMSUtil.getReplaceString(flagForMLC);
				mv.addObject("empCategory", empCategory);
				mv.addObject("siqValue", siqValue);
				mv.addObject("flagForMLC", flagForMLC);
				mv.setViewName(jsp);
				return mv;

			}
			
			// end by Avinash OPD Patient recalll	
			
			///start by dhiraj //////////
			
			@RequestMapping(value = "/minorSurgeryWaitingJSP", method = RequestMethod.GET)
			public ModelAndView minorSurgeryWaitingJSP(HttpServletRequest request, HttpServletResponse response) {
				ModelAndView mv = new ModelAndView();
				String jsp = "minorSurgeryWaitingJSP";
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value = "/minorSurgeryResponse", method = RequestMethod.GET)
			public ModelAndView minorSurgeryResponse(HttpServletRequest request, HttpServletResponse response) {
				ModelAndView mv = new ModelAndView();
				String jsp = "minorSurgeryResponse";
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value = "/minorSurgeryWaitingList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String minorSurgeryWaitingList(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();				
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "minorSurgeryWaitingList");
				
				String data = RestUtils.postWithHeaders(ipAndPort.trim()+OsbURL.trim(), requestHeaders, payload);
				return data;
			}
			
			@RequestMapping(value = "/minorSurgeryDetail", method = RequestMethod.GET)
			public ModelAndView minorSurgeryDetail(HttpServletRequest request, HttpServletResponse response) {
				ModelAndView mv = new ModelAndView();
				String jsp = "minorSurgeryDetail";
				String id = request.getParameter("header_id");
				HttpSession session = request.getSession();
				String svNo="";
				if(session.getAttribute("service_No") !=null) 
				{
					svNo=(String) session.getAttribute("service_No");
					
				}
				JSONObject payload=new JSONObject();
				payload.put("header_id",id);
				payload.put("serviceNo",svNo);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();				
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "getMinorSurgeryDetail");
				String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload.toString());
				mv.addObject("data", data);
				mv.setViewName(jsp);
				return mv;

			}
			
			@RequestMapping(value = "/getAnesthesiaList", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getAnesthesiaList(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();				
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "getAnesthesiaList");
				String data = RestUtils.postWithHeaders(ipAndPort.trim()+OsbURL.trim(), requestHeaders, payload);
				return data;
			}
			
			@RequestMapping(value="/saveMinorSurgery", method=RequestMethod.POST)
			public String saveMinorSurgery(@RequestBody String requestPayload, HttpServletRequest request,
					HttpServletResponse response) {			
									
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "saveMinorSurgery");				
				return RestUtils.postWithHeaders(ipAndPort.trim()+OsbURL.trim(), requestHeaders, requestPayload);
			}
			
			@RequestMapping(value="/validateMinorSurgery", method=RequestMethod.POST)
			public String validateMinorSurgery(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
					HttpServletResponse response) {			
				JSONObject jsonObject = new JSONObject(requestPayload);						
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "validateMinorSurgery");				
				return RestUtils.postWithHeaders(ipAndPort.trim()+OsbURL.trim(), requestHeaders, jsonObject.toString());
			}
			
			
			@RequestMapping(value="/deleteMinorSurgery", method=RequestMethod.POST)
			public String deleteMinorSurgery(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
					HttpServletResponse response) {			
				JSONObject jsonObject = new JSONObject(requestPayload);						
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "deleteMinorSurgery");				
				return RestUtils.postWithHeaders(ipAndPort.trim()+OsbURL.trim(), requestHeaders, jsonObject.toString());
			}
			
			@RequestMapping(value = "/getPocedureDetailRecall", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getPocedureDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.getPocedureDetail(payload, request, response);
				return data;
			}
			
		
			@RequestMapping(value = "/authenticateUser", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String authenticateUser(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.authenticateUser(payload, request, response);
				return data;
			}		
			
			@RequestMapping(value = "/showCurrentMedication", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String showCurrentMedication(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {

				String data=os.showCurrentMedication(payload, request, response);
				return data;
			}	
			
			/*@RequestMapping(value = "/checkForAuthenticateUser", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String checkForAuthenticateUser(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.checkForAuthenticateUser(payload, request, response);
				return data;
			}	*/
			
			  @RequestMapping(value="/getSnomedData", method=RequestMethod.GET)
			  public String getSnomedData( HttpServletRequest request, HttpServletResponse response) {
			   String payload ="{}";
			   
			   ////System.out.println("getSnomedData");
			   
			   String term= request.getParameter("snoTerm");
			   String semantictag= request.getParameter("semantictag");
			   String returnlimit= request.getParameter("returnlimit");
			   String acceptability= request.getParameter("acceptability");
			   JSONObject jsonObject = new JSONObject(payload);
			   MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			   String Url = HMSUtil.getProperties("urlextension.properties", "SnomedServerURL");
			       
			   String url=Url+"/csnoserv/api/search/search?term="+term+"&state=active&semantictag="+semantictag+"&acceptability="+acceptability+"&returnlimit="+returnlimit+"&groupbyconcept=false&refsetid=null&parentid=null";
			   return RestUtils.getWithHeaders(url, requestHeaders);
			  }
			
			@RequestMapping(value = "/updateCurrentMedication", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String updateCurrentMedication(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.updateCurrentMedication(payload, request, response);
				return data;
			}	
			
			
			@RequestMapping(value = "/getDispStockDetails", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getDispStockDetails(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.getDispStockDetails(payload, request, response);
				return data;
			}
			
			@RequestMapping(value = "/getDepartmentId", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getDepartmentId(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.getDepartmentId(payload, request, response);
				return data;
			}
			
			@RequestMapping(value = "/getRidcDocmentInfo", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getRidcDocmentInfo(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.getRidcDocmentInfo(payload, request, response);
				return data;
			}
			
			@RequestMapping(value="/opdEmergencyShowEmployeeList", method = RequestMethod.GET)
			public ModelAndView opdEmergencyShowEmployeeList(HttpServletRequest request, HttpServletResponse response) {
				HttpSession session = request.getSession();
				Integer hospitalId = (Integer) session.getAttribute("hospital_id");
				String requestData = "{\"hospitalId\":" + hospitalId + "}";
				String data=os.getOpdEmergencyShowEmployeeList(requestData,request, response);
				String jsp = "opdEmergencyShowEmployeeList";
				ModelAndView mv = new ModelAndView();
				mv.setViewName(jsp);
				mv.addObject("data", data);
				return mv;
			}
			
			@RequestMapping(value = "/saveOpdEmergency", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String saveOpdEmergency(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				
				String data=os.saveOpdEmergency(payload, request, response);
				////System.out.println("JSON Emergency "+data);
				return data;
			}
			
			@RequestMapping(value="/getSpecialistList", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getSpecialistList(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.getSpecialistList(payload, request, response);
			}
	
			
			@RequestMapping(value="/getIcdListByName", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getIcdListByName(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.getIcdListByName(payload, request, response);
			}
			
				
			@RequestMapping(value="/updateOpdInvestigationTemplates", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String updateOpdInvestigationTemplates(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				////System.out.println("data : " +payload );
				return os.updateOpdInvestigationTemplates(payload, request, response);
			}
			
			@RequestMapping(value = "/opdUpdateTreatmentTemplate", method = RequestMethod.GET)
			public ModelAndView opdUpdateTreatmentTemplate(HttpServletRequest request,	HttpServletResponse response) {
				////System.out.println("update Prescription template called");
				Map<String, Object> map = new HashMap<String, Object>();
				String jsp = "updatePrescriptionTemplate";
				int empid= Integer.parseInt(request.getParameter("employeeId"));
				String payload = "{\"employeeId\":"+empid+"}";
				String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
				////System.out.println("jsonResponse "+jsonResponse);
				ModelAndView mv =new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value="/updateOpdTreatmentTemplates", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String updateOpdTreatmentTemplates(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				////System.out.println("data : " +payload );
				return os.updateOpdTreatmentTemplates(payload, request, response);
			}
			
			@RequestMapping(value="/getUsersAuthentication", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getUsersAuthentication(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				////System.out.println("data : " +payload );
				return os.getUsersAuthentication(payload, request, response);
			}
			
			@RequestMapping(value = "/createMedicalAdviceTemplate", method = RequestMethod.GET)
			public ModelAndView createMedicalAdviceTemplate(HttpServletRequest request,	HttpServletResponse response) {
				////System.out.println("called");
				Map<String, Object> map = new HashMap<String, Object>();
				String jsp = "opdMedicalAdviceTemplate";
				int empid= Integer.parseInt(request.getParameter("employeeId"));
				String payload = "{\"employeeId\":"+empid+"}";
				String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
				////System.out.println("jsonResponse "+jsonResponse);
				ModelAndView mv =new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value="/saveOpdMedicalAdviceTemplates", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String saveOpdMedicalAdviceTemplates(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				////System.out.println("data : " +payload );
				return os.saveOpdMedicalAdviceTemplates(payload, request, response);
			}
			
			@RequestMapping(value="/getTemplateMedicalAdvice", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getTemplateMedicalAdvice(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.getTemplateMedicalAdvice(payload, request, response);
			}
			
			@RequestMapping(value = "/childVaccinationChart", method = RequestMethod.GET)
			public ModelAndView childVaccinationChart(HttpServletRequest request,	HttpServletResponse response) {
				Map<String, Object> map = new HashMap<String, Object>();
				String jsp = "childVaccinationChart";
				//int patientId= Integer.parseInt(request.getParameter("patientId"));
				//String payload = "{\"patientId\":"+patientId+"}";
				Long visitId= Long.parseLong(request.getParameter("visitId"));
				String payload = "{\"visitId\":"+visitId+"}";
				//String jsonResponse = os.getOpdPatientDetailModel(payload, request, response);
				ModelAndView mv =new ModelAndView();
				//mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value="/saveOrUpdateChildVacatination", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String saveOrUpdateChildVacatination(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				////System.out.println("data : " +payload );
				return os.saveOrUpdateChildVacatination(payload, request, response);
			}	
			
			@RequestMapping(value="/getChildVacatinationRecord", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getChildVacatinationRecord(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.getChildVacatinationRecord(payload, request, response);
			}
			

			@RequestMapping(value = "/showImmunizationTemplate", method = RequestMethod.GET)
			public ModelAndView showImmunizationTemplate(HttpServletRequest request,	HttpServletResponse response) {
				////System.out.println("called");
				String jsp = "immunizationHistoryTemp";
				String userId=  request.getParameter("employeeId");
				String patientId=  request.getParameter("patientId");
				String visitId=  request.getParameter("visitId");
				//String payload = "{\"employeeId\":"+empid+"}";
				ModelAndView mv =new ModelAndView();
				mv.addObject("userId", userId);
				mv.addObject("patientId", patientId);
				mv.addObject("visitId", visitId);
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value = "/checkAuthenticateEHR", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String checkAuthenticateEHR(@RequestBody HashMap<String, Object> jsondata, HttpServletRequest request,
					HttpServletResponse response) {
				JSONObject jsonObject = new JSONObject(jsondata);		
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties", "checkAuthenticateEHR");
				String OSBURL = ipAndPort+Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
				//return RestUtils.postWithHeaders("http://localhost:8082/AshaShipServices/v0.1/opd/checkAuthenticateEHR", requestHeaders, jsonObject.toString());
			}
			
			@RequestMapping(value = "/checkAuthenticateUser", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String checkAuthenticateUser(@RequestBody HashMap<String, Object> jsondata, HttpServletRequest request,
					HttpServletResponse response) {
				JSONObject jsonObject = new JSONObject(jsondata);		
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties", "authenticateUHID");
				String OSBURL = ipAndPort+Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
				//return RestUtils.postWithHeaders("http://localhost:8082/AshaShipServices/v0.1/opd/authenticateUHID", requestHeaders, jsonObject.toString());
			}
			
			@RequestMapping(value = "/getPatientIdUHIDWise", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getPatientIdUHIDWise(@RequestBody HashMap<String, Object> jsondata, HttpServletRequest request,
					HttpServletResponse response) {
				JSONObject jsonObject = new JSONObject(jsondata);		
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties", "getPatientIdUHIDWise");
				String OSBURL = ipAndPort+Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
				//return RestUtils.postWithHeaders("http://localhost:8082/AshaShipServices/v0.1/opd/getPatientIdUHIDWise", requestHeaders, jsonObject.toString());
			}
		
		 @RequestMapping(value="/patientListForEmployeeAndDependent", method = RequestMethod.POST)
			public String patientListForEmployeeAndDependent(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {	
			 MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties","patientListForEmployeeAndDependent");
				String OSBURL = ipAndPort+Url;
				return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, data);
				//return RestUtils.postWithHeaders("http://localhost:8081/AshaShipServices/opd/patientListForEmployeeAndDependent", requestHeaders, data);
			}
		 
		 @RequestMapping(value="/getGenderList", method=RequestMethod.POST)
			public String getGenderList(@RequestBody String requestPayload, HttpServletRequest request, HttpServletResponse response) {
				JSONObject jsonObject = new JSONObject(requestPayload);	
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties", "getGenderList");	
				String OSBURL = ipAndPort.trim()+Url;		
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
				//return RestUtils.postWithHeaders("http://localhost:8081/AshaShipServices/opd/getGenderList", requestHeaders, jsonObject.toString());
			}
			
			@RequestMapping(value="/getUnitList", method=RequestMethod.POST)
			public String getUnitList(@RequestBody String requestPayload, HttpServletRequest request, HttpServletResponse response) {
				
				JSONObject jsonObject = new JSONObject(requestPayload);	
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties", "opdGetUnitList");	
				String OSBURL = ipAndPort+Url;		
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
				//return RestUtils.postWithHeaders("http://localhost:8081/AshaShipServices/opd/getUnitList", requestHeaders, jsonObject.toString());
			}
			
			@RequestMapping(value="/getRankList", method=RequestMethod.POST)
			public String getRankList(@RequestBody String requestPayload, HttpServletRequest request, HttpServletResponse response) {
				JSONObject jsonObject = new JSONObject(requestPayload);	
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties", "getRankList");	
				String OSBURL = ipAndPort+Url;		
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
				//return RestUtils.postWithHeaders("http://localhost:8081/AshaShipServices/opd/getRankList", requestHeaders, jsonObject.toString());
			}
			
			
			@RequestMapping(value="/rejectOpdWaitingList", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String rejectOpdWaitingList(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.rejectOpdWaitingList(payload, request, response);
			}
				
			
			@RequestMapping(value = "/obesityOverweightRegister", method = RequestMethod.GET)
			public ModelAndView obesityOverweightRegister(HttpServletRequest request,	HttpServletResponse response) {
				////System.out.println("Reports called");
				String jsp = "obesityOverweightRegister";
				ModelAndView mv =new ModelAndView();
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value="/getPatientByServiceNo", method=RequestMethod.POST)
			public String getPatientByServiceNo(@RequestBody Map<String, Object> requestPayload, HttpServletRequest request,
					HttpServletResponse response) {
				HttpSession session = request.getSession();
				if(session.getAttribute("user_id") !=null) {
					JSONObject jsonObject = new JSONObject(requestPayload);						
					MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url = HMSUtil.getProperties("urlextension.properties", "getPatientByServiceNo");
					String OSBURL = ipAndPort+Url;
					return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, jsonObject.toString());
				}else {
					return "redirect:/dashboard/login";
				}
				
			}
			

			@RequestMapping(value = "/createNivTreatmentTemplate", method = RequestMethod.GET)
			public ModelAndView createNivTreatmentTemplate(HttpServletRequest request,	HttpServletResponse response) {
				////System.out.println("called");
				Map<String, Object> map = new HashMap<String, Object>();
				String jsp = "nivPrescriptionTemplate";
				int empid= Integer.parseInt(request.getParameter("employeeId"));
				String payload = "{\"employeeId\":"+empid+"}";
				String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
				////System.out.println("jsonResponse "+jsonResponse);
				ModelAndView mv =new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value = "/opdUpdateNivTemplate", method = RequestMethod.GET)
			public ModelAndView opdUpdateNivTemplate(HttpServletRequest request,	HttpServletResponse response) {
				////System.out.println("update niv template called");
				Map<String, Object> map = new HashMap<String, Object>();
				String jsp = "updateNivTemplate";
				int empid= Integer.parseInt(request.getParameter("employeeId"));
				String payload = "{\"employeeId\":"+empid+"}";
				String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
				////System.out.println("jsonResponse "+jsonResponse);
				ModelAndView mv =new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value = "/AdmissionDischargeRegister", method = RequestMethod.GET)
			public ModelAndView AdmissionDischargeRegister(HttpServletRequest request,	HttpServletResponse response) {
				String jsp = "AdmissionDischargeRegister";
				ModelAndView mv =new ModelAndView();
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value = "/getAdmissionDischargeRegister", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getAdmissionDischargeRegister(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "getAdmissionDischargeRegister");
				String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
				return data;
			}
			
			@RequestMapping(value = "/markEmployeeAsObese", method = RequestMethod.GET)
			public ModelAndView markEmployeeAsObese(HttpServletRequest request,	HttpServletResponse response) {
				String jsp = "markEmployeeAsObese";
				ModelAndView mv =new ModelAndView();
				mv.setViewName(jsp);
				mv.addObject("genderList", getGenderList("{}",request,response));
				mv.addObject("rankList", getRankList("{}",request,response));
				mv.addObject("unitList", getUnitList("{}",request,response));
				return mv;
			}
			
			@RequestMapping(value = "/saveObesityEntry", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String saveObesityEntry(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String OsbURL = HMSUtil.getProperties("urlextension.properties", "saveObesityEntry");
				String data = RestUtils.postWithHeaders(ipAndPort.trim() + OsbURL.trim(), requestHeaders, payload);
			    //String data = RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/v0.1/opd/saveObesityEntry", requestHeaders, payload);
				return data;
			}
			
			@RequestMapping(value="/geTreatmentInstruction", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String geTreatmentInstruction(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.geTreatmentInstruction(payload, request, response);
			}
			
			@RequestMapping(value="/getPatientSympotons", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getPatientSympotons(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.getPatientSympotons(payload, request, response);
			}
			
			@RequestMapping(value="/deletePatientSymptom", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String deletePatientSymptom(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.deletePatientSymptom(payload, request, response);
			}
			
			@RequestMapping(value = "/getPatientDianosisDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getPatientDianosisDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {
		
				String data=os.getPatientDianosisDetail(payload, request, response);
				return data;
				//return RestUtils.postWithHeaders(data, requestHeaders, payload);
			}
			
			@RequestMapping(value = "/viewEcgDocument", method = RequestMethod.POST)
			public String viewEcgDocument(@RequestBody HashMap<String, Object> jsondata, HttpServletRequest request,
					HttpServletResponse response) {
				
				String visitIdVal = jsondata.get("visitId").toString();
				JSONObject jsonObject = new JSONObject();
				String rootPath = environment.getProperty("mmu.service.ecg.upload");
				jsonObject.put("ecg", ProjectUtils.getPatientDocument(rootPath,visitIdVal));
				return jsonObject.toString();
				
			}
			
			////////////////////////////// AI Part Of OPD ////////////////////////////////////////////
			
			@RequestMapping(value = "/getAIDiagnosisDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getAIDiagnosisDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {

				String data=os.getAIDiagnosisDetail(payload, request, response);
				return data;
			}
			
			@RequestMapping(value = "/getAIInvestgationDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getAIInvestgationDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {

				String data=os.getAIInvestgationDetail(payload, request, response);
				return data;
			}
			
			@RequestMapping(value = "/getAITreatmentDetail", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
			public String getAITreatmentDetail(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {

				String data=os.getAITreatmentDetail(payload, request, response);
				return data;
			}
			
			@RequestMapping(value = "/aiAuditReport", method = RequestMethod.GET)
			public ModelAndView aiAuditReport(HttpServletRequest request,	HttpServletResponse response) {
				/*boolean check=ProjectUtils.checksession(request);
				if(check){*/
				////System.out.println("aiAuditReport called");
				String jsp = "aiAuditReport";
				ModelAndView mv =new ModelAndView();
				mv.setViewName(jsp);
				return mv;
				//}
				//return new ModelAndView("redirect:/dashboard/login");
			}
			
			
			
			@RequestMapping(value="/getPatientHistoryRecord", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getPatientHistoryRecord(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.getPatientHistoryRecord(payload, request, response);
			}
			
			@RequestMapping(value = "/showAuditHistory", method = RequestMethod.GET)
			public ModelAndView showAuditHistory(HttpServletRequest request,	HttpServletResponse response) {
				////System.out.println("vital called");
				Map<String, Object> map = new HashMap<String, Object>();
				String jsp = "opdPreviousAuditHistory";
				int patientId= Integer.parseInt(request.getParameter("patientId"));
				String payload = "{\"patientId\":"+patientId+"}";
				String jsonResponse = os.getFamilyPatientHistory(payload, request, response);
				////System.out.println("jsonResponse "+jsonResponse);
				ModelAndView mv =new ModelAndView();
				mv.addObject("data", jsonResponse);
				mv.setViewName(jsp);
				return mv;
			}
			
			@RequestMapping(value="/getOpdPreviousAuditHistory", method = RequestMethod.POST)
			 //HashMap<String,String> listMap =  new HashMap<String,String>();
			public String getOpdPreviousAuditHistory(@RequestBody String payload, HttpServletRequest request,
					HttpServletResponse response) {	
				
				return os.getOpdPreviousAuditHistory(payload, request, response);
			}
			
	}

	

