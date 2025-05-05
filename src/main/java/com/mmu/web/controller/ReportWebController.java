package com.mmu.web.controller;

import java.sql.Connection;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.dao.ReportDao;
import com.mmu.web.service.ReportService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;



@RequestMapping("/report")
@RestController
@CrossOrigin
public class ReportWebController {

	@Autowired
	ReportService reportService;
	@Autowired
	ReportDao reportDao;
	@Autowired
	DispensaryWebController dispensaryController;

	@Autowired
	private Environment environment;
	
	@RequestMapping(value = "/printVisitTokenReport", method = RequestMethod.GET)
	public ModelAndView printVisitTokenReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String appointmentTypeOPD=HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_OPD").trim();
		String appointmentTypeME=HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_ME").trim();
		String appointmentTypeMB=HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_MB").trim();
		
		String reportType = request.getParameter("reportType");
		
		int VISIT_ID=0;
		if(reportType.equalsIgnoreCase(appointmentTypeOPD) && request.getParameter("visit_id") !=null && !(request.getParameter("visit_id").toString().equalsIgnoreCase("0")) )
		{
			VISIT_ID= Integer.parseInt(request.getParameter("visit_id"));
		}
		 
		if(reportType.equalsIgnoreCase(appointmentTypeMB) && request.getParameter("visit_id") !=null && !(request.getParameter("visit_id").toString().equalsIgnoreCase("0")))
		{
			VISIT_ID= Integer.parseInt(request.getParameter("visit_id"));
		}
		
		if(reportType.equalsIgnoreCase(appointmentTypeME) && request.getParameter("visit_id") !=null && !(request.getParameter("visit_id").toString().equalsIgnoreCase("0")))
		{
			VISIT_ID= Integer.parseInt(request.getParameter("visit_id"));
		}
		
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Token_Slip_report_1", "TokenSlip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
	
		return null;
	
	}
	
	@RequestMapping(value = "/printVisitTokenReportTest", method = RequestMethod.GET)
	public ModelAndView printVisitTokenReportTest(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String appointmentTypeOPD=HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_OPD").trim();
		String appointmentTypeME=HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_ME").trim();
		String appointmentTypeMB=HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_MB").trim();
		
		String reportType = request.getParameter("reportType");
		
		int VISIT_ID=0;
		if(reportType.equalsIgnoreCase(appointmentTypeOPD) && request.getParameter("visit_id") !=null && !(request.getParameter("visit_id").toString().equalsIgnoreCase("0")) )
		{
			VISIT_ID= Integer.parseInt(request.getParameter("visit_id"));
		}
		 
		if(reportType.equalsIgnoreCase(appointmentTypeMB) && request.getParameter("visit_id") !=null && !(request.getParameter("visit_id").toString().equalsIgnoreCase("0")))
		{
			VISIT_ID= Integer.parseInt(request.getParameter("visit_id"));
		}
		
		if(reportType.equalsIgnoreCase(appointmentTypeME) && request.getParameter("visit_id") !=null && !(request.getParameter("visit_id").toString().equalsIgnoreCase("0")))
		{
			VISIT_ID= Integer.parseInt(request.getParameter("visit_id"));
		}
		
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Token_Slip_report_New", "TokenSlip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printVisitTokenReportforOthers", method = RequestMethod.GET)
	public ModelAndView printVisitTokenReportforOthers(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String sVISIT_ID ="";
		if(request.getParameter("visit_id") !=null && !request.getParameter("visit_id").equalsIgnoreCase("0"))
		{
			 sVISIT_ID = request.getParameter("visit_id");
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID);
		
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Other_Token_report",  "TokenSlip", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printVisitTokenReportfromPortal", method = RequestMethod.GET)
	public ModelAndView printVisitTokenReportfromPortal(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Token_Slip_report_New", "TokenSlip" ,parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printCaseSheet", method = RequestMethod.GET)
	public ModelAndView printCaseSheet(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		
		JSONArray sUser_id= new JSONArray();
		JSONArray sLevel_of_user= new JSONArray();
		JSONArray smmu_id= new JSONArray();
		
		/*
		 * if(json.get("User_id") !=null) { sUser_id = json.getJSONArray(("User_id")); }
		 * int User_id= Integer.parseInt(sUser_id.getString(0));
		 * 
		 * 
		 * if(json.get("Level_of_user") !=null) { sLevel_of_user =
		 * json.getJSONArray(("Level_of_user")); } String Level_of_user=
		 * sLevel_of_user.getString(0);
		 */
		
		/*
		 * if(json.get("mmu_id") !=null) { smmu_id = json.getJSONArray(("mmu_id")); }
		 * int mmu_id= Integer.parseInt(smmu_id.getString(0));
		 */
		
		
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePathH = userHome+"/image-h.jpg";
		String imagePathF = userHome+"/image-f.jpg";
	    parameters.put("path_h", imagePathH);
	    parameters.put("path_f", imagePathF);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//parameters.put("User_id", User_id);
		//parameters.put("Level_of_user", Level_of_user);
		//parameters.put("mmu_id", mmu_id);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("opd_casesheet_new_report_1", "CaseSheet", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printCaseSheetDarkHeader", method = RequestMethod.GET)
	public ModelAndView printCaseSheetDarkHeader(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		
		JSONArray sUser_id= new JSONArray();
		JSONArray sLevel_of_user= new JSONArray();
		JSONArray smmu_id= new JSONArray();
		
		/*
		 * if(json.get("User_id") !=null) { sUser_id = json.getJSONArray(("User_id")); }
		 * int User_id= Integer.parseInt(sUser_id.getString(0));
		 * 
		 * 
		 * if(json.get("Level_of_user") !=null) { sLevel_of_user =
		 * json.getJSONArray(("Level_of_user")); } String Level_of_user=
		 * sLevel_of_user.getString(0);
		 */
		
		/*
		 * if(json.get("mmu_id") !=null) { smmu_id = json.getJSONArray(("mmu_id")); }
		 * int mmu_id= Integer.parseInt(smmu_id.getString(0));
		 */
		
		
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePathH = userHome+"/image-h.jpg";
		String imagePathF = userHome+"/image-f.jpg";
	    parameters.put("path_h", imagePathH);
	    parameters.put("path_f", imagePathF);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//parameters.put("User_id", User_id);
		//parameters.put("Level_of_user", Level_of_user);
		//parameters.put("mmu_id", mmu_id);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("opd_casesheet_new_report_1", "CaseSheet", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printPrescriptionSlip", method = RequestMethod.GET)
	public ModelAndView printPrescriptionSlip(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sUser_id= new JSONArray();
		JSONArray sLevel_of_user= new JSONArray();
		JSONArray smmu_id= new JSONArray();
		
		/*
		 * if(json.get("User_id") !=null) { sUser_id = json.getJSONArray(("User_id")); }
		 * int User_id= Integer.parseInt(sUser_id.getString(0));
		 * 
		 * 
		 * if(json.get("Level_of_user") !=null) { sLevel_of_user =
		 * json.getJSONArray(("Level_of_user")); } String Level_of_user=
		 * sLevel_of_user.getString(0);
		 * 
		 * if(json.get("mmu_id") !=null) { smmu_id = json.getJSONArray(("mmu_id")); }
		 * int mmu_id= Integer.parseInt(smmu_id.getString(0));
		 */
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		/*
		 * parameters.put("User_id", User_id); parameters.put("Level_of_user",
		 * Level_of_user); parameters.put("mmu_id", mmu_id);
		 */
		
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("OPD_Prescription_report_1","PrescriptionSlip", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printInvestigationSlip", method = RequestMethod.GET)
	public ModelAndView printInvestigationSlip(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		JSONArray sVISIT_ID= new JSONArray();
		
		JSONArray sUser_id= new JSONArray();
		JSONArray sLevel_of_user= new JSONArray();
		JSONArray smmu_id= new JSONArray();
		
		/*
		 * if(json.get("User_id") !=null) { sUser_id = json.getJSONArray(("User_id")); }
		 * int User_id= Integer.parseInt(sUser_id.getString(0));
		 * 
		 * 
		 * if(json.get("Level_of_user") !=null) { sLevel_of_user =
		 * json.getJSONArray(("Level_of_user")); } String Level_of_user=
		 * sLevel_of_user.getString(0);
		 * 
		 * if(json.get("mmu_id") !=null) { smmu_id = json.getJSONArray(("mmu_id")); }
		 * int mmu_id= Integer.parseInt(smmu_id.getString(0));
		 */
		
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		parameters.put("Option", "O");
		
		/*
		 * parameters.put("User_id", User_id); parameters.put("Level_of_user",
		 * Level_of_user); parameters.put("mmu_id", mmu_id);
		 */
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
	    
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Investigation_main_report", "InvestigationSlip" ,parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	
	@RequestMapping(value = "/generateUnitReport", method = RequestMethod.GET)
	public ModelAndView generateUnitReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		JSONArray sVISIT_ID= new JSONArray();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Unit_Master _report_1","Unit_master _report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printMIReport", method = RequestMethod.GET)
	public ModelAndView printMIReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		String fromdate="";
		String todate="";
		String reportFlag="";
		String disposalId="";
		String unitId="";
		String serviceNo="";
		String appointmentTypeId="";
		String departmentId="";
		
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FROM_DATE", fd);
		//System.out.println("FROM_DATE"+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("TO_DATE"+td);
		parameters.put("TO_DATE", td);
		
			
		if(box.get("inlineRadioOptions") !=null && !box.getString("inlineRadioOptions").isEmpty())
		{
			reportFlag =box.getString("inlineRadioOptions");
		}
		
		if(box.get("disposalId") !=null && !box.getString("disposalId").isEmpty())
		{
			disposalId = box.getString("disposalId");		
			}
		
		
		
		
		if(box.get("unitId") !=null && !box.getString("unitId").isEmpty())
		{
			unitId = box.getString("unitId");		
			}
		
		
		
		if(box.get("serviceNo") !=null && !box.getString("serviceNo").isEmpty())
		{
			serviceNo = box.getString("serviceNo");		}
		
		
		if(box.get("appointmentTypeId") !=null && !box.getString("appointmentTypeId").isEmpty())
		{
			appointmentTypeId = box.getString("appointmentTypeId");		}
		
		
		
		if(box.get("department") !=null && !box.getString("department").isEmpty())
		{
			departmentId = box.getString("department");		}
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
	    parameters.put("APPOINTMENT_TYPE_ID", Integer.parseInt(appointmentTypeId));
	    parameters.put("DEPARTMENT_ID", Integer.parseInt(departmentId));
	    parameters.put("ICD_ID", 0);
	    parameters.put("DISPOSAL_ID", Integer.parseInt(disposalId));
	    if(!unitId.equals("") && unitId!=null) {
		    parameters.put("HOSPITAL_ID", Integer.parseInt(unitId));
		    }
	    if(!serviceNo.equals("") && serviceNo!=null) {
	    parameters.put("SERVICE_NO", serviceNo);
	    }
	    else{
	    parameters.put("SERVICE_NO", "0");	
	    }

		connectionMap = reportDao.getConnectionForReportMis();
		if(reportFlag.equalsIgnoreCase("D"))
		HMSUtil.generateReportInPopUp("MI_Appointment_detailed_report", "MIAppointmentDetailedReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		if(reportFlag.equalsIgnoreCase("C")) {
			if(Integer.parseInt(appointmentTypeId)==1) {
				HMSUtil.generateReportInPopUp("MI_Appointment_count_report_opd", "MIAppointmentSummaryReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}else if(Integer.parseInt(appointmentTypeId)==2) {
				HMSUtil.generateReportInPopUp("MI_Appointment_count_report_me", "MIAppointmentSummaryReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}else if(Integer.parseInt(appointmentTypeId)==3) {
				HMSUtil.generateReportInPopUp("MI_Appointment_count_report_mb", "MIAppointmentSummaryReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
			HMSUtil.generateReportInPopUp("MI_Appointment_count_report", "MIAppointmentSummaryReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		return null;
	
	}
	
	@RequestMapping(value = "/generateRegionMasterReport", method = RequestMethod.GET)
	public ModelAndView generateRegionMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	 
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Command_Master_report_1", "Command_master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateAppointmentTypeReport", method = RequestMethod.GET)
	public ModelAndView generateAppointmentTypeReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	 
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Appointment_Type_Master_report_1", "AppointmentTypeReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDepartmentReport", method = RequestMethod.GET)
	public ModelAndView generateDepartmentReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Department Master_report_1", "DepartmentMaster",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateDisposalReport", method = RequestMethod.GET)
	public ModelAndView generateDisposalReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Disposal_Master_report_1", "DispoalReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateEmpanelledHospitalReport", method = RequestMethod.GET)
	public ModelAndView generateEmpanelledHospitalReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Empanelled_Hospital_Master_report_1", "Empanelled_Hospital_Master_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateFrequencyReport", method = RequestMethod.GET)
	public ModelAndView generateFrequencyReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Frequency_Master_report_1", "Frequency_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateHospitalReport", method = RequestMethod.GET)
	public ModelAndView generateHospitalReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Hospital_Master_report_1", "MIRoomMaster", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateIdealWeightReport", method = RequestMethod.GET)
	public ModelAndView generateIdealWeightReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		
	    //System.out.println("path="+imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Ideal_Weight_Master_report_1", "Ideal_Weight_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateRelationReport", method = RequestMethod.GET)
	public ModelAndView generateRelationReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Relation_Master_report_1", "RelationReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	/*06052019*/
	@RequestMapping(value = "/generateBloodGroupReport", method = RequestMethod.GET)
	public ModelAndView generateBloodGroupReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Blood_Group_Master_report_1", "BloodGroupReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateEmployeeCategoryReport", method = RequestMethod.GET)
	public ModelAndView generateEmployeeCategoryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Employee_Category_Master_report_1", "EmployeeCategoryReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateGenderReport", method = RequestMethod.GET)
	public ModelAndView generateGenderReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Gender_Master_report_1", "Gender_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateItemUnitReport", method = RequestMethod.GET)
	public ModelAndView generateItemUnitReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Item_Unit_Master_report_1", "Item_Unit_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateMaritalStatusReport", method = RequestMethod.GET)
	public ModelAndView generateMaritalStatusReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MaritalStatus_Master_report_1", "MaritalStatus_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateMedicalCategoryReport", method = RequestMethod.GET)
	public ModelAndView generateMedicalCategoryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Medical_Category_Master_report_1", "Medical_Category_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generatePhysiothreapyReport", method = RequestMethod.GET)
	public ModelAndView generatePhysiothreapyReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Procedure_Master_report_1", "Procedure_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateRangeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateRangeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Range_Master_report_1", "Range_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateRankMasterReport", method = RequestMethod.GET)
	public ModelAndView generateRankMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Rank_Master_report_1", "Rank_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateReligionMasterReport", method = RequestMethod.GET)
	public ModelAndView generateReligionMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Religion_Master_report_1", "Religion_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateRoleMasterReport", method = RequestMethod.GET)
	public ModelAndView generateRoleMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Role_Master _report_1", "Role_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateSampleContainerReport", method = RequestMethod.GET)
	public ModelAndView generateSampleContainerReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Sample_Container_Master_report_1", "Sample_Container_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateServiceTypeReport", method = RequestMethod.GET)
	public ModelAndView generateServiceTypeReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Service_Type_Master_report_1", "Service_Type_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateTradeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateTradeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Trade_Master_report_1","Trade_Master_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateUOMReport", method = RequestMethod.GET)
	public ModelAndView generateUOMReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Unit_of_Measurement_Master_report_1","Unit_of_Measurement_Master", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/generateUsersReport", method = RequestMethod.GET)
	public ModelAndView generateUsersReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Users_Master_report_1", "Users_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/generateEHRReport", method = RequestMethod.GET)
	public ModelAndView generateEHRReport(HttpServletRequest request, HttpServletResponse response) {
		
		//System.out.println("ass");
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		/*
		JSONArray sPatientId= new JSONArray();
		if(json.get("patientId") !=null)
		{
			sPatientId = json.getJSONArray(("patientId"));
		}
		int nPatientId= Integer.parseInt(sPatientId.getString(0));
		
		JSONArray sUserId= new JSONArray();
		if(json.get("userId") !=null)
		{
			sUserId = json.getJSONArray(("userId"));
		}
		int nUserId= Integer.parseInt(sUserId.getString(0));
		*/
		
		int nPatientId = Integer.parseInt(box.get("patientId"));
		int nUserId = Integer.parseInt(box.get("userId"));
		////System.out.println("nPatientId and nUserId :::::::::::: "+nPatientId +"@@@@"+ +nUserId);
		
		parameters.put("P_USERID", nUserId);
		parameters.put("P_PATIENTID", nPatientId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("EHR_report", "PatientEHR",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/referReportSlip", method = RequestMethod.GET)
	public ModelAndView referReportSlip(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sUser_id= new JSONArray();
		JSONArray sLevel_of_user= new JSONArray();
		JSONArray smmu_id= new JSONArray();
		
		/*
		 * if(json.get("User_id") !=null) { sUser_id = json.getJSONArray(("User_id")); }
		 * int User_id= Integer.parseInt(sUser_id.getString(0));
		 * 
		 * 
		 * if(json.get("Level_of_user") !=null) { sLevel_of_user =
		 * json.getJSONArray(("Level_of_user")); } String Level_of_user=
		 * sLevel_of_user.getString(0);
		 * 
		 * if(json.get("mmu_id") !=null) { smmu_id = json.getJSONArray(("mmu_id")); }
		 * int mmu_id= Integer.parseInt(smmu_id.getString(0));
		 */
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePathH = userHome+"/image-h.jpg";
		String imagePathF = userHome+"/image-f.jpg";
	    parameters.put("path_h", imagePathH);
	    parameters.put("path_f", imagePathF);
		
	    parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		/*
		 * parameters.put("User_id", User_id); parameters.put("Level_of_user",
		 * Level_of_user); parameters.put("mmu_id", mmu_id);
		 */
		
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Referral_Report", "ReferralLetter",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}
	
	@RequestMapping(value = "/printIndentReport", method = RequestMethod.GET)
	public ModelAndView printIndentReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		JSONArray sINDENT_ID= new JSONArray();
		if(json.get("indent_id") !=null)
		{
			sINDENT_ID = json.getJSONArray(("indent_id"));
		}
		int ID= Integer.parseInt(sINDENT_ID.getString(0));
		
		
		parameters.put("ID", ID);
	//	parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Indent_report", "IndentReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printIndentReportCo", method = RequestMethod.GET)
	public ModelAndView printIndentReportCo(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		JSONArray sINDENT_ID= new JSONArray();
		if(json.get("indent_id") !=null)
		{
			sINDENT_ID = json.getJSONArray(("indent_id"));
		}
		int ID= Integer.parseInt(sINDENT_ID.getString(0));
		
		
		parameters.put("ID", ID);
	//	parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Indent_report_CO", "IndentReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printIndentReportDo", method = RequestMethod.GET)
	public ModelAndView printIndentReportDo(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		JSONArray sINDENT_ID= new JSONArray();
		if(json.get("indent_id") !=null)
		{
			sINDENT_ID = json.getJSONArray(("indent_id"));
		}
		int ID= Integer.parseInt(sINDENT_ID.getString(0));
		
		
		parameters.put("ID", ID);
	//	parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Indent_report_DO", "IndentReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printissuedPrescriptionReport", method = RequestMethod.GET)
	public ModelAndView printissuedPrescriptionReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray prescriptionId= new JSONArray();
		if(json.get("id") !=null)
		{
			prescriptionId = json.getJSONArray(("id"));
		}
		int pId= Integer.parseInt(prescriptionId.getString(0));

		//System.out.println("prescriptionId "+pId);		
		parameters.put("PRESCRIPTION_HD_ID", pId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePathH = userHome+"/image-h.jpg";
		String imagePathF = userHome+"/image-f.jpg";
	    parameters.put("path_h", imagePathH);
	    parameters.put("path_f", imagePathF);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("OPD_Prescription_Slip_report", "PrescriptionSlip", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printIndentIssueReport", method = RequestMethod.GET)
	public ModelAndView printIndentIssueReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray prescriptionId= new JSONArray();
		if(json.get("id") !=null)
		{
			prescriptionId = json.getJSONArray(("id"));
		}
		int pId= Integer.parseInt(prescriptionId.getString(0));

		//System.out.println("requestNo "+pId);		
		parameters.put("INDENT_M_ID", pId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		//System.out.println("connectionMap.get"+connectionMap.get("conn"));
		HMSUtil.generateReportInPopUp("Medical_Store_Indent_Issue_report_1", "IndentIssueReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printIndentIssueReportDo", method = RequestMethod.GET)
	public ModelAndView printIndentIssueReportDo(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray prescriptionId= new JSONArray();
		if(json.get("id") !=null)
		{
			prescriptionId = json.getJSONArray(("id"));
		}
		int pId= Integer.parseInt(prescriptionId.getString(0));

		//System.out.println("requestNo "+pId);		
		parameters.put("INDENT_M_ID", pId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		//System.out.println("connectionMap.get"+connectionMap.get("conn"));
		HMSUtil.generateReportInPopUp("Medical_Store_Indent_CO_Issue_report_1", "IndentIssueReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/validateMedicalExamReport", method = RequestMethod.GET)
	public ModelAndView validateMedicalExamReport(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("VISIT_ID", VISIT_ID);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
	    parameters.put("Option", "M");
	    
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Investigation_main_report", "MEInvestigationSlip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}	
	
	@RequestMapping(value = "/printdrugExpiryReport", method = RequestMethod.GET)
	public ModelAndView printdrugExpiryReport(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Date todayDate = new Date();
		String query = "";
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sUser_id= new JSONArray();
		JSONArray sLevel_of_user= new JSONArray();
		
		
		if(json.get("User_id") !=null)
		{
			sUser_id = json.getJSONArray(("User_id"));
		}
		int User_id= Integer.parseInt(sUser_id.getString(0));
		
		
		if(json.get("Level_of_user") !=null)
		{
			sLevel_of_user = json.getJSONArray(("Level_of_user"));
		}
		String Level_of_user= sLevel_of_user.getString(0);
		
		JSONArray jArray= new JSONArray();
		if(json.get("mId") !=null)
		{
			jArray = json.getJSONArray(("mId"));
		}		
		int mmuId= jArray.getInt(0);
		
		if(json.get("dId") !=null)
		{
			jArray = json.getJSONArray(("dId"));
		}		
		int departmentId= jArray.getInt(0);
		boolean flag = true;
		Date fromDate = null;
		String firstDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			jArray = json.getJSONArray(("fromDate"));
			if(!(jArray.getString(0)).equals("")) {
				firstDate = jArray.getString(0);
				fromDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				String fDate = HMSUtil.convertDateToStringFormat(fromDate,"dd-MMM-yy");
				query += " and expiry_date >= '"+fDate+"'";
				flag = false;
			}			
		}		
		
		Date toDate = null;
		String nextDate = "";
		if(json.get("toDate") !=null && !(json.get("toDate")).equals(""))
		{
			jArray = json.getJSONArray(("toDate"));
			if(!(jArray.getString(0)).equals("")) {
				nextDate = jArray.getString(0);
				toDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				String tDate = HMSUtil.convertDateToStringFormat(toDate,"dd-MMM-yy");
				query += " and expiry_date <= '"+tDate+"'";
				flag = false;
			}
			
		}	
		
		if(json.get("pvmsNo") !=null && !json.get("pvmsNo").equals(""))
		{
			jArray = json.getJSONArray(("pvmsNo"));
			String pvmsNo = jArray.getString(0);
			if(!pvmsNo.equals("")) {
				query += " and MAS_STORE_ITEM.PVMS_NO='"+pvmsNo+"'";
			}			
		}		
		
		
		if(json.get("nmclature") !=null && !json.get("nmclature").equals(""))
		{
			jArray = json.getJSONArray(("nmclature"));
			String nmclature = jArray.getString(0);
			if(!nmclature.equals("")) {
				String clature = "%"+nmclature+"%";
				query += " and MAS_STORE_ITEM.NOMENCLATURE like '"+clature+"'";
			}			
		}		
		
		
		if(flag) {
			query += "and expiry_date < sysdate";
		}
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("HOSPITAL_ID", mmuId);
	    parameters.put("DEPARTMENT_ID", departmentId);
	    parameters.put("User_id", User_id);
		parameters.put("Level_of_user", Level_of_user);
	    
	   
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	    parameters.put("query", query);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		//System.out.println("query "+query);
		HMSUtil.generateReportInPopUp("Drug_Expiry_Report", "DrugExpiryReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}	
	
	@RequestMapping(value = "/printdrugExpiryReportCO", method = RequestMethod.GET)
	public ModelAndView printdrugExpiryReportCO(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Date todayDate = new Date();
		String query = "";
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		
		
		
		
		JSONArray jArray= new JSONArray();
		if(json.get("cityId") !=null)
		{
			jArray = json.getJSONArray(("cityId"));
		}		
		int cityId= jArray.getInt(0);
		
		
		boolean flag = true;
		Date fromDate = null;
		String firstDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			jArray = json.getJSONArray(("fromDate"));
			if(!(jArray.getString(0)).equals("")) {
				firstDate = jArray.getString(0);
				fromDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				String fDate = HMSUtil.convertDateToStringFormat(fromDate,"dd-MMM-yy");
				query += " and expiry_date >= '"+fDate+"'";
				flag = false;
			}			
		}		
		
		Date toDate = null;
		String nextDate = "";
		if(json.get("toDate") !=null && !(json.get("toDate")).equals(""))
		{
			jArray = json.getJSONArray(("toDate"));
			if(!(jArray.getString(0)).equals("")) {
				nextDate = jArray.getString(0);
				toDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				String tDate = HMSUtil.convertDateToStringFormat(toDate,"dd-MMM-yy");
				query += " and expiry_date <= '"+tDate+"'";
				flag = false;
			}
			
		}	
		
		if(json.get("pvmsNo") !=null && !json.get("pvmsNo").equals(""))
		{
			jArray = json.getJSONArray(("pvmsNo"));
			String pvmsNo = jArray.getString(0);
			if(!pvmsNo.equals("")) {
				query += " and MAS_STORE_ITEM.PVMS_NO='"+pvmsNo+"'";
			}			
		}		
		
		
		if(json.get("nmclature") !=null && !json.get("nmclature").equals(""))
		{
			jArray = json.getJSONArray(("nmclature"));
			String nmclature = jArray.getString(0);
			if(!nmclature.equals("")) {
				String clature = "%"+nmclature+"%";
				query += " and MAS_STORE_ITEM.NOMENCLATURE like '"+clature+"'";
			}			
		}		
		
		
		if(flag) {
			query += "and expiry_date < sysdate";
		}
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("HOSPITAL_ID", cityId);   
	    
	    
	   
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	    parameters.put("query", query);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		//System.out.println("query "+query);
		HMSUtil.generateReportInPopUp("Drug_Expiry_Report_CO", "DrugExpiryReportCO",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}	
	
	@RequestMapping(value = "/printRolReport", method = RequestMethod.GET)
	public ModelAndView printRolReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray jArray= new JSONArray();
		if(json.get("hId") !=null)
		{
			jArray = json.getJSONArray(("hId"));
		}
		int hId= Integer.parseInt(jArray.getString(0));
		
		if(json.get("unitId") !=null)
		{
			jArray = json.getJSONArray(("unitId"));
		}
		int unitId= Integer.parseInt(jArray.getString(0));
		if(json.get("dId") !=null)
		{
			jArray = json.getJSONArray(("dId"));
		}
		int dId= Integer.parseInt(jArray.getString(0));

		//System.out.println("hId "+hId);		
		parameters.put("HOSPITAL_ID", unitId);
		parameters.put("DEPARTMENT_ID", dId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		//System.out.println("connectionMap.get"+connectionMap.get("conn"));
		
		String dispensaryCode = HMSUtil.getProperties("js_messages_en.properties", "DISPENSARY_DEPARTMENT_CODE").trim();
		String storeCode = HMSUtil.getProperties("js_messages_en.properties", "STORE_DEPARTMENT_CODE").trim();
		JSONObject jobj = new JSONObject();
		jobj.put("code", dispensaryCode);
		JSONObject data = new JSONObject(dispensaryController.getDepartmentIdAgainstCode(jobj.toString()));
		int dispensaryId = data.getInt("departmentId");
		JSONObject jobj2 = new JSONObject();
		jobj2.put("code", storeCode);
		JSONObject data2  = new JSONObject(dispensaryController.getDepartmentIdAgainstCode(jobj2.toString()));
		int storeId = data2.getInt("departmentId");
		//System.out.println("dispensaryId "+dispensaryId);
		//System.out.println("storeId "+storeId);
		if(dId == dispensaryId) {
			HMSUtil.generateReportInPopUp("ROL_D_Report_", "ROL_Dispensary_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}else if(dId == storeId) {
			HMSUtil.generateReportInPopUp("ROL_S_Report_", "ROL_Stores_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}		
		return null;
	
	}	
	
	@RequestMapping(value = "/printNisSlip", method = RequestMethod.GET)
	public ModelAndView printNisSlip(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray prescriptionId= new JSONArray();
		if(json.get("id") !=null)
		{
			prescriptionId = json.getJSONArray(("id"));
		}
		int pId= Integer.parseInt(prescriptionId.getString(0));
		
		JSONObject jobj = new JSONObject();
		JSONObject data = new JSONObject(dispensaryController.getItemTypeIdForPVMS(jobj.toString()));
		int itemId = Integer.parseInt(String.valueOf(data.getInt("itemId")));
		
		//System.out.println("prescriptionId "+pId);		
		parameters.put("PRESCRIPTION_HD_ID", pId);
		parameters.put("ITEM_TYPE_ID", itemId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("NIS_Slip_report", "NIS_Slip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printNisRegister", method = RequestMethod.GET)
	public ModelAndView printNisRegister(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Date todayDate = new Date();
		String query = "";
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray jArray= new JSONArray();
		if(json.get("hId") !=null)
		{
			jArray = json.getJSONArray(("hId"));
		}		
		int hospitalId= jArray.getInt(0);
		
		if(json.get("unitId") !=null)
		{
			jArray = json.getJSONArray(("unitId"));
		}		
		int unitId= jArray.getInt(0);
/*		if(json.get("dId") !=null)
		{
			jArray = json.getJSONArray(("dId"));
		}	*/	
		int departmentId= jArray.getInt(0);
		//boolean flag = true;
		Date fromDate = null;
		String firstDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			jArray = json.getJSONArray(("fromDate"));
			if(!(jArray.getString(0)).equals("")) {
				firstDate = jArray.getString(0);
				fromDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				String fDate = HMSUtil.convertDateToStringFormat(fromDate,"dd-MMM-yy");
			}			
		}		
		
		Date toDate = null;
		String nextDate = "";
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			jArray = json.getJSONArray(("toDate"));
			if(!(jArray.getString(0)).equals("")) {
				nextDate = jArray.getString(0);
				toDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				String tDate = HMSUtil.convertDateToStringFormat(toDate,"dd-MMM-yy");
			}
			
		}	
		
		JSONObject jobj = new JSONObject();
		JSONObject data = new JSONObject(dispensaryController.getItemTypeIdForPVMS(jobj.toString()));
		int itemId = Integer.parseInt(String.valueOf(data.getInt("itemId")));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("HOSPITAL_ID", unitId);
//	    parameters.put("DEPARTMENT_ID", departmentId);
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	    parameters.put("ITEM_TYPE_ID", itemId);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		//System.out.println("query "+query);
		HMSUtil.generateReportInPopUp("NIS_Register_report", "NISRegister",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}	
	
	@RequestMapping(value = "/printDailyIssueSummaryReport", method = RequestMethod.GET)
	public ModelAndView printDailyIssueSummaryReport(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Date todayDate = new Date();
		String query = "";
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray jArray= new JSONArray();
/*		if(json.get("hId") !=null)
		{
			jArray = json.getJSONArray(("hId"));
		}		
		int hospitalId= jArray.getInt(0);*/
		if(json.get("unitId") !=null)
		{
			jArray = json.getJSONArray(("unitId"));
		}		
		int unitId= jArray.getInt(0);
		if(json.get("dId") !=null)
		{
			jArray = json.getJSONArray(("dId"));
		}		
		int departmentId= jArray.getInt(0);
		boolean flag = true;
		Date fromDate = null;
		String firstDate = "";
		String fDate="";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			jArray = json.getJSONArray(("fromDate"));
			if(!(jArray.getString(0)).equals("")) {
				firstDate = jArray.getString(0);
				fromDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				fDate = HMSUtil.convertDateToStringFormat(fromDate,"dd-MMM-yy");
				//query += " and STORE_ISSUE_M.ISSUE_DATE >='"+fDate+"'";
				
			}			
		}		
		
		Date toDate = null;
		String nextDate = "";
		String tDate="";
		if(json.get("toDate") !=null && !(json.get("toDate")).equals(""))
		{
			jArray = json.getJSONArray(("toDate"));
			if(!(jArray.getString(0)).equals("")) {
				nextDate = jArray.getString(0);
				toDate= HMSUtil.convertStringTypeDateToDateType(jArray.getString(0));
				tDate = HMSUtil.convertDateToStringFormat(toDate,"dd-MMM-yy");
				//query += " and STORE_ISSUE_M.ISSUE_DATE<='"+tDate+"'";
				 
			}
			
		}	
		
		if(json.get("serviceNo") !=null && !json.get("serviceNo").equals(""))
		{
			jArray = json.getJSONArray(("serviceNo"));
			String serviceNo = jArray.getString(0);
			if(!serviceNo.equals("")) {
				query += " AND PATIENT.SERVICE_NO='"+serviceNo+"'";
			}			
		}		
		
		
		if(json.get("mobileNo") !=null && !json.get("mobileNo").equals(""))
		{
			jArray = json.getJSONArray(("mobileNo"));
			String mobileNo = jArray.getString(0);
			if(!mobileNo.equals("")) {
				query += " AND PATIENT.MOBILE_NUMBER='"+mobileNo+"'";
			}			
		}		
		
		if(json.get("patientName") !=null && !json.get("patientName").equals(""))
		{
			jArray = json.getJSONArray(("patientName"));
			String patientName = jArray.getString(0);
			if(!patientName.equals("")) {
				String pName = "%"+patientName+"%";
				query += " AND PATIENT.PATIENT_NAME like '"+pName+"'";
			}			
		}

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);		
	    parameters.put("HOSPITAL_ID", unitId);
	    parameters.put("DEPARTMENT_ID", departmentId);	   
	    parameters.put("FromDate", fDate);
	    parameters.put("ToDate", tDate);
	    parameters.put("query", query);
	    //System.out.println("query "+query);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		HMSUtil.generateReportInPopUp("Patient_Daily_Issue_Register_report", "Patient_Daily_Issue_Register",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}	
	@RequestMapping(value = "/medicalExamReportReport", method = RequestMethod.GET)
	public ModelAndView medicalExamReportReport(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("MEDICAL_EXAMINATION_ID", VISIT_ID);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("AnnualMedicalExaminationReport", "AnnualMedicalExaminationReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}	
	
	@RequestMapping(value = "/printOpeningBalanceReport", method = RequestMethod.GET)
	public ModelAndView printOpeningBalanceReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		int opBalanceId=0;
				
		if(request.getParameter("balanceHeaderId") != null) {
			opBalanceId =Integer.parseInt(request.getParameter("balanceHeaderId"));
		}
		
		parameters.put("headerId", opBalanceId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome + "/mmu-logo.png";
		parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Opening_Balance_report", "Opening_Balance_report",parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/generateSampleReport", method = RequestMethod.GET)
	public ModelAndView generateSampleReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Sample Master_report_1", "Sample_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateInvestigationUOMReport", method = RequestMethod.GET)
	public ModelAndView generateInvestigationUOMReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Investigation_UOM_Master_report_1", "Investigation_UOM_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateMainTypeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateMainTypeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Main_Type_Master ", "Main_Type_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateMeMbTypeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateMeMbTypeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("ME_MB_Type_Master", "ME_MB_Type_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateSubTypeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateSubTypeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Sub_Type_Master", "Sub_Type_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/mbPrintCaseSheet", method = RequestMethod.GET)
	public ModelAndView mbPrintCaseSheet(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println(json.toString());
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MB_CaseSheet_report", "MB_CaseSheet", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/mbPrintRefferal", method = RequestMethod.GET)
	public ModelAndView mbPrintRefferal(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println(json.toString());
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MB_Referral_Report", "MB_Referral_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printInvestigationSlipResultEmpty", method = RequestMethod.GET)
	public ModelAndView printInvestigationSlipResultEmpty(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visitIdforInvestigationEmpty") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visitIdforInvestigationEmpty"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		parameters.put("Option", "M");
		parameters.put("Result_Flag", "P");
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Investigation_main_report", "MEInvestigationSlip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}
	
	@RequestMapping(value = "/medicalExamReportReportF18", method = RequestMethod.GET)
	public ModelAndView medicalExamReportReportF18(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("MEDICAL_EXAMINATION_ID", VISIT_ID);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MedicalExaminationReport", "MedicalExaminationReport-18",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}	
	
	@RequestMapping(value = "/generateMEInvestigationMasterReport", method = RequestMethod.GET)
	public ModelAndView generateMEInvestigationMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Investigation_Mapping_To_ME_Master", "Investigation_Mapping_To_ME_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/generateItemClassMasterReport", method = RequestMethod.GET)
	public ModelAndView generateItemClassMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Item_Class_Master", "Item_Class_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateItemSectionMasterReport", method = RequestMethod.GET)
	public ModelAndView generateItemSectionMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Item_Section_Master","Item_Section_Master", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateItemTypeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateItemTypeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Item_Type_Master ", "Item_Type_Master ",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateStoreGroupMasterReport", method = RequestMethod.GET)
	public ModelAndView generateStoreGroupMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Item_Group_Master","Item_Group_Master", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateItemDrugMasterReport", method = RequestMethod.GET)
	public ModelAndView generateItemDrugMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Item_Drug_master", "Item_Drug_master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateItemNonDrugMasterReport", method = RequestMethod.GET)
	public ModelAndView generateItemNonDrugMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Item_Non_Drug_master","Item_Non_Drug_master", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/referReportSlipMe", method = RequestMethod.GET)
	public ModelAndView referReportSlipMe(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visitIdforInvestigationEmpty") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visitIdforInvestigationEmpty"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Case_Sheet_SubReport5_report_1", "MEReferralReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}
	
	//print Budgetary Report
	
	@RequestMapping(value = "/printBudgetaryReport", method = RequestMethod.GET)
	public ModelAndView printBudgetaryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		JSONArray sBUDGETARY_ID= new JSONArray();
		if(json.get("budgetary_id") !=null)
		{
			sBUDGETARY_ID = json.getJSONArray(("budgetary_id"));
		}
		int ID= Integer.parseInt(sBUDGETARY_ID.getString(0));
		
		
		parameters.put("BUDGETARY_M_ID", ID);
	//	parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Budgetary_report","BudgetaryReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	//print Create Quotation Report
	
		@RequestMapping(value = "/printQuotationReport", method = RequestMethod.GET)
		public ModelAndView printQuotationReport(HttpServletRequest request, HttpServletResponse response) {
			
			Map<String, Object> connectionMap = new HashMap<String, Object>();
			Map<String, Object> parameters = new HashMap<String, Object>();
			
			Box box= HMSUtil.getBox(request);
			JSONObject json = new JSONObject(box);
			//System.out.println("json="+json);
			JSONArray sQUOTATION_ID= new JSONArray();
			if(json.get("quotation_id") !=null)
			{
				sQUOTATION_ID = json.getJSONArray(("quotation_id"));
			}
			int ID= Integer.parseInt(sQUOTATION_ID.getString(0));
			
			
			parameters.put("QUOTATION_M_ID", ID);
		//	parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
			
			String userHome = request.getServletContext().getRealPath("/resources/images/");
			String imagePath = userHome+"/mmu-logo.png";
		    parameters.put("path", imagePath);
			
			//System.out.println(request.getServletContext().getRealPath("/reports/"));

			connectionMap = reportDao.getConnectionForReportMis();
			
			HMSUtil.generateReportInPopUp("Quotation_report", "QuotationReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			return null;
		
		}
		
		//print Approve Quotation Report
		
		@RequestMapping(value = "/printApproveQuotationReport", method = RequestMethod.GET)
		public ModelAndView printApproveQuotationReport(HttpServletRequest request, HttpServletResponse response) {
			
			Map<String, Object> connectionMap = new HashMap<String, Object>();
			Map<String, Object> parameters = new HashMap<String, Object>();
			
			Box box= HMSUtil.getBox(request);
			JSONObject json = new JSONObject(box);
			//System.out.println("json="+json);
			JSONArray quotation_ID= new JSONArray();
			if(json.get("quotation_id") !=null)
			{
				quotation_ID = json.getJSONArray(("quotation_id"));
			}
			int ID= Integer.parseInt(quotation_ID.getString(0));
			
			
			parameters.put("QUOTATION_M_ID", ID);
			parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
			
			String userHome = request.getServletContext().getRealPath("/resources/images/");
			String imagePath = userHome+"/mmu-logo.png";
		    parameters.put("path", imagePath);
			
			//System.out.println(request.getServletContext().getRealPath("/reports/"));

			connectionMap = reportDao.getConnectionForReportMis();
			
			HMSUtil.generateReportInPopUp("Approved_Quotation_report", "ApprovedQuotationReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			return null;
		
		}
		
		//print Sanction Report
		
			@RequestMapping(value = "/printSanctionReport", method = RequestMethod.GET)
			public ModelAndView printSanctionReport(HttpServletRequest request, HttpServletResponse response) {
				
				Map<String, Object> connectionMap = new HashMap<String, Object>();
				Map<String, Object> parameters = new HashMap<String, Object>();
				
				Box box= HMSUtil.getBox(request);
				JSONObject json = new JSONObject(box);
				//System.out.println("json="+json);
				JSONArray sanction_ID= new JSONArray();
				if(json.get("sanction_id") !=null)
				{
					sanction_ID = json.getJSONArray(("sanction_id"));
				}
				int ID= Integer.parseInt(sanction_ID.getString(0));
				
				
				parameters.put("SO_M_ID", ID);
				parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
				
				String userHome = request.getServletContext().getRealPath("/resources/images/");
				String imagePath = userHome+"/mmu-logo.png";
			    parameters.put("path", imagePath);
				
				//System.out.println(request.getServletContext().getRealPath("/reports/"));

				connectionMap = reportDao.getConnectionForReportMis();
				
				HMSUtil.generateReportInPopUp("Sanction_For_Purchase_Report", "SanctionOrderReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
				return null;
			
			}
	
	@RequestMapping(value = "/printOpeningBalanceRegister", method = RequestMethod.GET)
	public ModelAndView printOpeningBalanceRegister(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		int departmentId=0;
		int mmuId=0;
		int userId=0;
		String levelOfUser="";
		
		Date fromDate = null;
		Date toDate = null;
		
		if(request.getParameter("User_id")!=null && Integer.parseInt(request.getParameter("User_id"))!=0) {
			userId = Integer.parseInt(request.getParameter("User_id"));
		}
		
		if(request.getParameter("Level_of_user")!=null && !request.getParameter("Level_of_user").toString().isEmpty()) {
			levelOfUser = request.getParameter("Level_of_user");
		}
		
		if(request.getParameter("mmuId")!=null) {
			mmuId = Integer.parseInt(request.getParameter("mmuId"));
		}
		if(request.getParameter("deptId")!=null && Integer.parseInt(request.getParameter("deptId"))!=0) {
			departmentId = Integer.parseInt(request.getParameter("deptId"));
		}
		
		if(request.getParameter("fromDate")!=null && !request.getParameter("fromDate").toString().isEmpty()) {
			fromDate = HMSUtil.convertStringTypeDateToDateType(request.getParameter("fromDate").toString());
		}
		
		if(request.getParameter("toDate")!=null && !request.getParameter("toDate").toString().isEmpty()) {
			toDate = HMSUtil.convertStringTypeDateToDateType(request.getParameter("toDate").toString());
		}
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("HOSPITAL_ID", mmuId);
	    parameters.put("DEPARTMENT_ID", departmentId);
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	    
	    parameters.put("User_id", userId);
		parameters.put("Level_of_user", levelOfUser);
	    
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		HMSUtil.generateReportInPopUp("Opening_Balance_Register_report_1", "OpeningBalanceReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}	
	
	
	@RequestMapping(value = "/printOpeningBalanceRegisterCO", method = RequestMethod.GET)
	public ModelAndView printOpeningBalanceRegisterCO(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		int departmentId=0;
		int cityId=0;	
		
		
		Date fromDate = null;
		Date toDate = null;
		
		
		if(request.getParameter("cityId")!=null) {
			cityId = Integer.parseInt(request.getParameter("cityId"));
		}
		if(request.getParameter("deptId")!=null && Integer.parseInt(request.getParameter("deptId"))!=0) {
			departmentId = Integer.parseInt(request.getParameter("deptId"));
		}
		
		if(request.getParameter("fromDate")!=null && !request.getParameter("fromDate").toString().isEmpty()) {
			fromDate = HMSUtil.convertStringTypeDateToDateType(request.getParameter("fromDate").toString());
		}
		
		if(request.getParameter("toDate")!=null && !request.getParameter("toDate").toString().isEmpty()) {
			toDate = HMSUtil.convertStringTypeDateToDateType(request.getParameter("toDate").toString());
		}
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("CITY_ID", cityId);
	    parameters.put("DEPARTMENT_ID", departmentId);
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	 		
	    
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		HMSUtil.generateReportInPopUp("Opening_Balance_Register_CO_report_1", "OpeningBalanceRegisterCO",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}	
	
	
	@RequestMapping(value = "/printStockTakingReport", method = RequestMethod.GET)
	public ModelAndView printStockTakingReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		int takingMId =0;

		if (request.getParameter("takingMHeaderId")!=null && Integer.parseInt(request.getParameter("takingMHeaderId"))!=0) {
			takingMId = Integer.parseInt(request.getParameter("takingMHeaderId"));
		}

		parameters.put("TAKING_M_ID", takingMId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome + "/mmu-logo.png";
		parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Stock_taking_report", "StockTakingReport",parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	
	
	@RequestMapping(value = "/printStockTakingRegister", method = RequestMethod.GET)
	public ModelAndView printStockTakingRegister(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

				
		int departmentId=0;
		int mmuId=0;
		Date fromDate = null;
		Date toDate = null;
		
		int User_id=0;
		String Level_of_user="";
		
		if(request.getParameter("User_id")!=null && Integer.parseInt(request.getParameter("User_id"))!=0) {
			User_id = Integer.parseInt(request.getParameter("User_id"));
		}
		
		if(request.getParameter("Level_of_user")!=null && !request.getParameter("Level_of_user").toString().isEmpty()) {
			Level_of_user = request.getParameter("Level_of_user").toString();
		}
		
		if(request.getParameter("mmuId")!=null ) {
			mmuId = Integer.parseInt(request.getParameter("mmuId"));
		}
		if(request.getParameter("deptId")!=null && Integer.parseInt(request.getParameter("deptId"))!=0) {
			departmentId = Integer.parseInt(request.getParameter("deptId"));
		}
		
		if(request.getParameter("fromDate")!=null && !request.getParameter("fromDate").toString().isEmpty()) {
			fromDate = HMSUtil.convertStringTypeDateToDateType(request.getParameter("fromDate").toString());
		}
		
		if(request.getParameter("toDate")!=null && !request.getParameter("toDate").toString().isEmpty()) {
			toDate = HMSUtil.convertStringTypeDateToDateType(request.getParameter("toDate").toString());
		}
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("HOSPITAL_ID", mmuId);
	    parameters.put("DEPARTMENT_ID", departmentId);
	    parameters.put("User_id", User_id);
		parameters.put("Level_of_user", Level_of_user);
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		HMSUtil.generateReportInPopUp("Stock_Taking_Register", "StockTakingRegister", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}
	
	@RequestMapping(value = "/mbAmsf15Report", method = RequestMethod.GET)
	public ModelAndView mbAmsf15Report(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println(json.toString());
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MB_15", "MedicalBoardReport-AMSF15", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	

	@RequestMapping(value = "/printSupplyOrderReport", method = RequestMethod.GET)
	public ModelAndView printSupplyOrderReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box = HMSUtil.getBox(request);
		int poMId =0;

		if (box.get("balanceHeaderId")!=null && box.getInt("balanceHeaderId")!=0) {
			poMId = box.getInt("balanceHeaderId");
		}

		parameters.put("PO_M_ID", poMId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome + "/mmu-logo.png";
		parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Supply_Order_report", "SupplyOrderReport",parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	
	
	@RequestMapping(value = "/printRvAgainstSoReport", method = RequestMethod.GET)
	public ModelAndView printRvAgainstSoReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box = HMSUtil.getBox(request);
		int grnMId =0;


		if (box.get("balanceHeaderId")!=null && box.getInt("balanceHeaderId")!=0) {
			grnMId = box.getInt("balanceHeaderId");
		}

		parameters.put("GRN_M_ID", grnMId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome + "/mmu-logo.png";
		parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Receipt_Voucher_report", "ReceiptVoucheReport",parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/printDirectReceivingSORegister", method = RequestMethod.GET)
	public ModelAndView printDirectReceivingSOReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		
		int departmentId=0;
		int hospitalId=0;
		Date fromDate = null;
		Date toDate = null;
		
		if(box.get("hospitalId")!=null && box.getInt("hospitalId")!=0) {
			hospitalId = box.getInt("hospitalId");
		}
		
		if(box.get("departmentId")!=null && box.getInt("departmentId")!=0) {
			departmentId = box.getInt("departmentId");
		}
		
		if(box.getString("from_date") !=null && !box.getString("from_date").isEmpty()) {
			fromDate = HMSUtil.convertStringTypeDateToDateType(box.getString("from_date"));
		}
			
		if(box.getString("to_date") !=null && !box.getString("to_date").isEmpty()) {
			toDate = HMSUtil.convertStringTypeDateToDateType(box.getString("to_date"));
		}
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("HOSPITAL_ID", hospitalId);
	    parameters.put("DEPARTMENT_ID", departmentId);
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Direct_receiving_report", "ReceiptVoucheReport",parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/printIndentMIdReport", method = RequestMethod.GET)
	public ModelAndView printIndentMIdReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box = HMSUtil.getBox(request);
		int indentMId =0;

		if (box.get("indentMId") !=null &&  box.getInt("indentMId")!=0) {
			indentMId = box.getInt("indentMId");
		}

		parameters.put("INDENT_M_ID", indentMId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome + "/mmu-logo.png";
		parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Indent_Receive_report","IndentReceivingReport", parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/printIndentMIdReportCo", method = RequestMethod.GET)
	public ModelAndView printIndentMIdReportCo(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box = HMSUtil.getBox(request);
		int indentMId =0;

		if (box.get("indentMId") !=null &&  box.getInt("indentMId")!=0) {
			indentMId = box.getInt("indentMId");
		}

		parameters.put("INDENT_M_ID", indentMId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome + "/mmu-logo.png";
		parameters.put("path", imagePath);

		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Indent_CO_Receive_report","IndentReceivingReport", parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/generateRadiologyInvestigationReport", method = RequestMethod.GET)
	public ModelAndView generateRadiologyInvestigationReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Radiology_Investigation","RadiologyInvestigationReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/mbAmsf15ReportCheckList", method = RequestMethod.GET)
	public ModelAndView mbAmsf15ReportCheckList(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println(json.toString());
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MB_15_Report_Checklist", "MB_15_Checklist_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateLabInvestigationReport", method = RequestMethod.GET)
	public ModelAndView generateLabInvestigationReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Laboratory_Investigations", "Laboratory_Investigations",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	

	@RequestMapping(value = "/generateVendorMasterReport", method = RequestMethod.GET)
	public ModelAndView generateVendorMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		
		int hospitalId=0;
		
		if(box.get("hospitalId")!=null && box.getInt("hospitalId")!=0) {
			hospitalId = box.getInt("hospitalId");
		}
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);	
	    parameters.put("HOSPITAL_ID", hospitalId);

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Vendor_Master", "VendorMaster",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateVendorTypeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateVendorTypeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Vendor_Type_Master", "Vendor_Type_Master", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDepartmentDoctorMappingReport", method = RequestMethod.GET)
	public ModelAndView generateDepartmentDoctorMappingReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		
		int hospitalId=0;
		
		if(box.get("hospitalId")!=null && box.getInt("hospitalId")!=0) {
			hospitalId = box.getInt("hospitalId");
		}
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);	
	    parameters.put("LOCATION_ID", hospitalId);

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Department_Doctor_Mapping", "Department_Doctor_Mapping",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/mbAmsf16Report", method = RequestMethod.GET)
	public ModelAndView mbAmsf16Report(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println(json.toString());
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MB_16_Report", "MB_16_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printMBReport", method = RequestMethod.GET)
	public ModelAndView printMBReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		
		/*if(json.get("date") !=null)
		{
			fromdate_array = json.getJSONArray(("date"));
		}
		
		String fromdate=fromdate_array.getString(0);
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FromDate", fd);
		//System.out.println("FromDate"+fd);
		
		JSONArray todate_array= new JSONArray();
		if(json.get("date") !=null)
		{
			todate_array = json.getJSONArray(("date"));
		}
		
		String todate=todate_array.getString(1);
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("ToDate"+td);
		parameters.put("ToDate", td);		
		
		JSONArray medicalCat_array= new JSONArray();
		if(json.get("medicalCat") !=null)
		{
			medicalCat_array = json.getJSONArray(("medicalCat"));	
		}
		
		String medicalCatId=medicalCat_array.getString(0);
		
		
		JSONArray unit_array= new JSONArray();
		if(json.get("unitId") !=null)
		{
			unit_array = json.getJSONArray(("unitId"));		}
		
		String unitId=unit_array.getString(0);
		
		
		JSONArray empCategory_array= new JSONArray();
		if(json.get("empCategory") !=null)
		{
			empCategory_array = json.getJSONArray(("empCategory"));	
		}
		
		String empCategoryId=empCategory_array.getString(0);
		
		JSONArray status_array= new JSONArray();
		if(json.get("status") !=null)
		{
			status_array = json.getJSONArray(("status"));	
		}
		
		String status=status_array.getString(0);		
		
		JSONArray service_array= new JSONArray();
		if(json.get("serviceNo") !=null)
		{
			service_array = json.getJSONArray(("serviceNo"));	
		}
		
		String serviceNo=service_array.getString(0);
		
		*/
		
		String fromdate="";
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FromDate", fd);
		//System.out.println("FromDate"+fd);
		
		 
		String todate="";
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("ToDate"+td);
		parameters.put("ToDate", td);	
		
		
		String unitId="";
		if(box.get("unitId") !=null && !box.getString("unitId").isEmpty() && box.get("unitId")!=null)
		{
			unitId=box.getString("unitId");
		}
		
		String empCategoryId="";
		if(box.get("empCategory") !=null && !box.getString("empCategory").isEmpty() && box.get("empCategory")!=null)
		{
			empCategoryId=box.getString("empCategory");
		}
		
		String status="";
		if(box.get("status") !=null && !box.getString("status").isEmpty())
		{
			status=box.getString("status");
		}
		
		String serviceNo="";
		if(box.get("serviceNo") !=null && !box.getString("serviceNo").isEmpty())
		{
			serviceNo=box.getString("serviceNo");
		} 
		 
		String medicalCatId="";
		if(box.get("medicalCat") !=null && !box.getString("medicalCat").isEmpty())
		{
			medicalCatId=box.getString("medicalCat");
		} 
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    if(medicalCatId !=null && !medicalCatId.equals("")) {
	    parameters.put("CATEGORY_ID", Integer.parseInt(medicalCatId));
	    }
	    else {
	    	parameters.put("CATEGORY_ID", 0);	
	    }
	    if(unitId !=null && !unitId.equals("")) {
	    parameters.put("UNIT_ID", Integer.parseInt(unitId));
	    }
	    else {
	    parameters.put("UNIT_ID", 0);	
	    }
	    if(empCategoryId !=null && !empCategoryId.equals("")) {
	    parameters.put("EMPLOYEE_CATEGORY_ID",Integer.parseInt(empCategoryId));
	    }
	    else {
	    parameters.put("EMPLOYEE_CATEGORY_ID",0);	
	    }
	    if(status !=null && !status.equals("")) {
	    parameters.put("STATUS", Integer.parseInt(status));
	    }
	    else {
	    parameters.put("STATUS", 0);	
	    }
	    
	    if(serviceNo !=null && !serviceNo.equals("")) {
		    parameters.put("SERVICE_NO", serviceNo);
		    }
		    else {
		    parameters.put("SERVICE_NO", "0");	
		    }
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MB_Report", "MedicalBoardReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			
		return null;
	
	}
	
	@RequestMapping(value = "/printMEReport", method = RequestMethod.GET)
	public ModelAndView printMEReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		
		JSONArray fromdate_array= new JSONArray();
		
		/*if(json.get("date") !=null)
		{
			fromdate_array = json.getJSONArray(("date"));
		}
		
		String fromdate=fromdate_array.getString(0);
		*/
		String fromdate="";
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FromDate", fd);
		//System.out.println("FromDate"+fd);
		
		JSONArray todate_array= new JSONArray();
		/*if(json.get("date") !=null)
		{
			todate_array = json.getJSONArray(("date"));
		}
		
		String todate=todate_array.getString(1);*/
		String todate="";
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("ToDate"+td);
		parameters.put("ToDate", td);	
		
		
		String unitId="";
		if(box.get("unitId") !=null && !box.getString("unitId").isEmpty() && box.get("unitId")!=null)
		{
			unitId=box.getString("unitId");
		}
		
		String empCategoryId="";
		if(box.get("empCategory") !=null && !box.getString("empCategory").isEmpty() && box.get("empCategory")!=null)
		{
			empCategoryId=box.getString("empCategory");
		}
		
		String status="";
		if(box.get("status") !=null && !box.getString("status").isEmpty())
		{
			status=box.getString("status");
		}
		
		String serviceNo="";
		if(box.get("serviceNo") !=null && !box.getString("serviceNo").isEmpty())
		{
			serviceNo=box.getString("serviceNo");
		} 
		 
	/*	
		JSONArray unit_array= new JSONArray();
		if(json.get("unitId") !=null)
		{
			unit_array = json.getJSONArray(("unitId"));		}
		
		String unitId=unit_array.getString(0);
		
		
		JSONArray empCategory_array= new JSONArray();
		if(json.get("empCategory") !=null)
		{
			empCategory_array = json.getJSONArray(("empCategory"));	
		}
		
		String empCategoryId=empCategory_array.getString(0);
		
		JSONArray status_array= new JSONArray();
		if(json.get("status") !=null)
		{
			status_array = json.getJSONArray(("status"));	
		}
		
		String status=status_array.getString(0);
		
		JSONArray service_array= new JSONArray();
		if(json.get("serviceNo") !=null)
		{
			service_array = json.getJSONArray(("serviceNo"));	
		}
		
		String serviceNo=service_array.getString(0);
		
		*/
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);	    
	    if(unitId !=null && !unitId.equals("")) {
		    parameters.put("UNIT_ID", Integer.parseInt(unitId));
		    }
	    else {
	    	parameters.put("UNIT_ID", 0);
	    }
		    if(empCategoryId !=null && !empCategoryId.equals("")) {
		    parameters.put("EMPLOYEE_CATEGORY_ID",Integer.parseInt(empCategoryId));
		    }
		    else {
		    	parameters.put("EMPLOYEE_CATEGORY_ID",0);	
		    }
		    if(status !=null && !status.equals("")) {
		    parameters.put("STATUS", Integer.parseInt(status));
		    }
		    else {
		    parameters.put("STATUS", 0);	
		    }
		    if(serviceNo !=null && !serviceNo.equals("")) {
			    parameters.put("SERVICE_NO", serviceNo);
			    }
			    else {
			    parameters.put("SERVICE_NO", "0");	
			    }
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("ME_Report", "MedicalExamReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			
		return null;
	
	}
	
	@RequestMapping(value = "/generateResultEntryReport", method = RequestMethod.GET)
	public ModelAndView generateResultEntryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		int orderHd= Integer.parseInt(request.getParameter("oderHdId"));
		
		
			//System.out.println("orderHd "+orderHd);
		
	//	int ORDERHD_ID= Integer.parseInt(sORDERHD_ID.getString(0));
		
			String userHome = request.getServletContext().getRealPath("/resources/images/");
			String imagePathH = userHome+"/image-h.jpg";
			String imagePathF = userHome+"/image-f.jpg";
		    parameters.put("path_h", imagePathH);
		    parameters.put("path_f", imagePathF);	
	    parameters.put("ORDERHD_ID", orderHd);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
	    
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Lab_Investigation_Report2","LabInvestigationReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateLabHistoryReport", method = RequestMethod.GET)
	public ModelAndView generateLabHistoryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		//System.out.println("oderHdId $$$$ "+ box.get("oderHdId"));
		
		String oderHdId = request.getParameter("oderHdId");
		/*
		 * String[] value = values.split("@@"); int headerId =
		 * Integer.parseInt(value[0].toString()); String status = value[1];
		 */
		//String validated = value[2];
		
		////System.out.println("values :: "+values);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePathH = userHome+"/image-h.jpg";
		String imagePathF = userHome+"/image-f.jpg";
	    parameters.put("path_h", imagePathH);
	    parameters.put("path_f", imagePathF);	
	   
	    int noderHdId  = Integer.parseInt(oderHdId);
	    parameters.put("ORDERHD_ID", noderHdId);
 	 	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
 		connectionMap = reportDao.getConnectionForReportMis();
 		//HMSUtil.generateReport("Lab_Investigation_Report2", "LabInvestigationResultReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
 		//HMSUtil.generateReportInPopUp("Lab_Investigation_Report_new", "LabInvestigationResultReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
 		HMSUtil.generateReportInPopUp("Lab_Investigation_Report2", "LabInvestigationResultReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
	   
		return null;
	
	}
	
	@RequestMapping(value = "/generateLabHistoryReportDarkHeader", method = RequestMethod.GET)
	public ModelAndView generateLabHistoryReportDarkHeader(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		//System.out.println("oderHdId $$$$ "+ box.get("oderHdId"));
		
		String oderHdId = request.getParameter("oderHdId");
		/*
		 * String[] value = values.split("@@"); int headerId =
		 * Integer.parseInt(value[0].toString()); String status = value[1];
		 */
		//String validated = value[2];
		
		////System.out.println("values :: "+values);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePathH = userHome+"/image-h.jpg";
		String imagePathF = userHome+"/image-f.jpg";
	    parameters.put("path_h", imagePathH);
	    parameters.put("path_f", imagePathF);	
	   
	    int noderHdId  = Integer.parseInt(oderHdId);
	    parameters.put("ORDERHD_ID", noderHdId);
 	 	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
 		connectionMap = reportDao.getConnectionForReportMis();
 		//HMSUtil.generateReport("Lab_Investigation_Report2", "LabInvestigationResultReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
 		HMSUtil.generateReportInPopUp("Lab_Investigation_Report2", "LabInvestigationResultReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
    
	   
		return null;
	
	}
	
	@RequestMapping(value = "/generateImagingHistoryReport", method = RequestMethod.GET)
	public ModelAndView generateImagingHistoryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();		
		int orderHd= Integer.parseInt(request.getParameter("oderHdId"));		
			//System.out.println("orderHd "+orderHd);
		
	//	int ORDERHD_ID= Integer.parseInt(sORDERHD_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		
	    parameters.put("ORDERHD_ID", orderHd);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));	    
		connectionMap = reportDao.getConnectionForReportMis();		
		HMSUtil.generateReportInPopUp("Imaging_Investigation_Report", "ImagingInvestigationResultReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateResultValidatedReport", method = RequestMethod.GET)
	public ModelAndView generateResultValidatedReport(HttpServletRequest request, HttpServletResponse response) {		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		int orderHd= Integer.parseInt(request.getParameter("orderHdId"));
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePathH = userHome+"/image-h.jpg";
		String imagePathF = userHome+"/image-f.jpg";
	    parameters.put("path_h", imagePathH);
	    parameters.put("path_f", imagePathF);	
	   	    
	    parameters.put("ORDERHD_ID", orderHd);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));	    
		connectionMap = reportDao.getConnectionForReportMis();		
		HMSUtil.generateReportInPopUp("Lab_Investigation_Report", "LabInvestigationResultReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/generateResultEntryUpdateReport", method = RequestMethod.GET)
	public ModelAndView generateResultEntryUpdateReport(HttpServletRequest request, HttpServletResponse response) {		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		int orderHd= Integer.parseInt(request.getParameter("orderHdId"));
		String userHome = request.getServletContext().getRealPath("/resources/images/");
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		
	    parameters.put("ORDERHD_ID", orderHd);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));	    
		connectionMap = reportDao.getConnectionForReportMis();		
		HMSUtil.generateReportInPopUp("Lab_Investigation_Report", "LabInvestigationResultReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateSpecialityReport", method = RequestMethod.GET)
	public ModelAndView generateSpecialityReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Speciality_Master", "Speciality_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateBedStatusMasterReport", method = RequestMethod.GET)
	public ModelAndView generateBedStatusMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Bed_Status_Master", "Bed_Status_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDischargeStatusMasterReport", method = RequestMethod.GET)
	public ModelAndView generateDischargeStatusMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Discharge_Status_Master","Discharge_Status_Master", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDiseaseReport", method = RequestMethod.GET)
	public ModelAndView generateDiseaseReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Disease_Master_report", "Disease_Master_report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDocumentReport", method = RequestMethod.GET)
	public ModelAndView generateDocumentReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Document_Master_report", "Document_Master_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	
	@RequestMapping(value = "/printBloodGroupReport", method = RequestMethod.GET)
	public ModelAndView printBloodGroupReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray bloodGroup= new JSONArray();
		JSONArray unitId= new JSONArray();
		JSONArray serviceNo= new JSONArray();
		JSONArray empName= new JSONArray();
		if(json.get("bloodGroup") !=null)
		{
			bloodGroup = json.getJSONArray(("bloodGroup"));
		}
		int BLOOD_GROUP_ID= Integer.parseInt(bloodGroup.getString(0));
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		
		if(json.get("empName") !=null)
		{
			empName = json.getJSONArray(("empName"));
		}
		if(json.get("serviceNo") !=null)
		{
			serviceNo = json.getJSONArray(("serviceNo"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		String sNo="";
		if(serviceNo.getString(0).equalsIgnoreCase(""))
			sNo="0";
		else
			sNo=serviceNo.getString(0).trim();
		String name=empName.getString(0).toUpperCase();
		String query="";
		if(!name.equalsIgnoreCase(""))
			query="AND UPPER(EBG.EMPLOYEE_NAME) LIKE '%"+name+"%'";
		
		parameters.put("BLOOD_GROUP_ID", BLOOD_GROUP_ID);
		parameters.put("UNIT_ID", UNIT_ID);
		parameters.put("SERVICE_NO", sNo);
		parameters.put("query", query);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Blood_Group_Report", "BloodGroupReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printInjuryReport", method = RequestMethod.GET)
	public ModelAndView printInjuryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		JSONArray serviceNo= new JSONArray();
		JSONArray empName= new JSONArray();
		/*
		 * if(json.get("fromDate") !=null) { fromDate = json.getJSONArray(("fromDate"));
		 * } String fDate= fromDate.getString(0); if(json.get("toDate") !=null) { toDate
		 * = json.getJSONArray(("toDate")); }
		 */
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		if(json.get("empName") !=null)
		{
			empName = json.getJSONArray(("empName"));
		}
		if(json.get("serviceNo") !=null)
		{
			serviceNo = json.getJSONArray(("serviceNo"));
		}
		String sNo="";
		if(serviceNo.getString(0).equalsIgnoreCase(""))
			sNo="0";
		else
			sNo=serviceNo.getString(0).trim();
		String name=empName.getString(0).toUpperCase();
		String query="";
		if(!name.equalsIgnoreCase(""))
			query="AND UPPER(PT.EMPLOYEE_NAME) LIKE '%"+name+"%'";
		
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		parameters.put("SERVICE_NO", sNo);
		parameters.put("query", query);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Injury_Report", "InjuryReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/hivStdReport", method = RequestMethod.GET)
	public ModelAndView hivStdReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		JSONArray serviceNo= new JSONArray();
		JSONArray empName= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		if(json.get("empName") !=null)
		{
			empName = json.getJSONArray(("empName"));
		}
		if(json.get("serviceNo") !=null)
		{
			serviceNo = json.getJSONArray(("serviceNo"));
		}
		String sNo="";
		if(serviceNo.getString(0).equalsIgnoreCase(""))
			sNo="0";
		else
			sNo=serviceNo.getString(0).trim();
		String name=empName.getString(0).toUpperCase();
		String query="";
		if(!name.equalsIgnoreCase(""))
			query="AND UPPER(PT.EMPLOYEE_NAME) LIKE '%"+name+"%'";
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		parameters.put("SERVICE_NO", sNo);
		parameters.put("query", query);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("HIV_AND_STD", "HIV_STDReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printHospitalVisitRegister", method = RequestMethod.GET)
	public ModelAndView printHospitalVisitRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		JSONArray serviceNo= new JSONArray();
		JSONArray empName= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		if(json.get("empName") !=null)
		{
			empName = json.getJSONArray(("empName"));
		}
		if(json.get("serviceNo") !=null)
		{
			serviceNo = json.getJSONArray(("serviceNo"));
		}
		String sNo="";
		if(serviceNo.getString(0).equalsIgnoreCase(""))
			sNo="0";
		else
			sNo=serviceNo.getString(0).trim();
		String name=empName.getString(0).toUpperCase();
		String query="";
		if(!name.equalsIgnoreCase(""))
			query="AND UPPER(PT.EMPLOYEE_NAME) LIKE '%"+name+"%'";
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		parameters.put("SERVICE_NO", sNo);
		parameters.put("query", query);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Hospital_Visit_Main_Report", "HospitalVisitReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printSanitaryDiaryRegister", method = RequestMethod.GET)
	public ModelAndView printSanitaryDiaryRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Sanitary_Diary_Report","SanitaryDiaryReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/printMilkTestingRegister", method = RequestMethod.GET)
	public ModelAndView printMilkTestingRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Milk_Testing_Report","MilkTestingReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	@RequestMapping(value = "/printWaterTestingRegister", method = RequestMethod.GET)
	public ModelAndView printWaterTestingRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Water_Testing_Report","WaterTestingReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDiagnosisReport", method = RequestMethod.GET)
	public ModelAndView generateDiagnosisReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("ICD_Master", "ICDMasterReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateBankMasterReport", method = RequestMethod.GET)
	public ModelAndView generateBankMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Bank_Master", "Bank_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateAccountTypeReport", method = RequestMethod.GET)
	public ModelAndView generateAccountTypeReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Account_Type_Master","Account_Type_Master", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printAMEReport", method = RequestMethod.GET)
	public ModelAndView printAMEReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		JSONArray empCategoryId= new JSONArray();
		JSONArray medCatId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		if(json.get("medcategory") !=null)
		{
			medCatId = json.getJSONArray(("medcategory"));
		}
		int medcatId= Integer.parseInt(medCatId.getString(0));
		
		if(json.get("empCategory") !=null)
		{
			empCategoryId = json.getJSONArray(("empCategory"));
		}
		int empID= Integer.parseInt(empCategoryId.getString(0));
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		parameters.put("MEDICAL_CATEGORY_ID", medcatId);
		parameters.put("EMPLOYEE_CATEGORY_ID", empID);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("AME_Report_For_Officers_Sailors", "AMEStatistics",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}
	
	@RequestMapping(value = "/printMedicalExamstatisticsReport", method = RequestMethod.GET)
	public ModelAndView printMedicalExamstatisticsReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Medical_Exam_Statistics", "MedicalExamStatistics",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
}
	
	@RequestMapping(value = "/printDisposalReport", method = RequestMethod.GET)
	public ModelAndView printDisposalReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Disposal_Type_Report", "DisposalTypeReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}
	
	@RequestMapping(value = "/printAttcReport", method = RequestMethod.GET)
	public ModelAndView printAttcReport(HttpServletRequest request, HttpServletResponse response) {
		String attcCode=HMSUtil.getProperties("js_messages_en.properties", "ATTC_CODE").trim();
		String siqCode=HMSUtil.getProperties("js_messages_en.properties", "SIQ_CODE").trim();
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		JSONArray reportType= new JSONArray();
		
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("toDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		if(json.get("reportType") !=null)
		{
			reportType = json.getJSONArray(("reportType"));
		}
		String reportCode= reportType.getString(0);
		parameters.put("ToDate", tDate);
		parameters.put("FromDate", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		//parameters.put("EMPLOYEE_CATEGORY_ID", empID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		if(attcCode.equalsIgnoreCase(reportCode))
			HMSUtil.generateReportInPopUp("Attc_Type_Report", "Att'C'_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		else
			 HMSUtil.generateReportInPopUp("SIQ_MI", "SIQ_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			
		return null;
	}
	
	@RequestMapping(value = "/fwcPrintCaseSheet", method = RequestMethod.GET)
	public ModelAndView fwcPrintCaseSheet(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("FWC_opd_casesheet", "CaseSheet",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	/********************************** SHO REPORT ***********************************************/
	
	@RequestMapping(value = "/generateBreakDownReport", method = RequestMethod.GET)
	public ModelAndView generateBreakDownReport(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		
		connectionMap = reportDao.getConnectionForReportMis();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray hospitalId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		if(json.get("hospitalId") !=null)
		{
			hospitalId = json.getJSONArray(("hospitalId"));
		}
		int UNIT_ID= Integer.parseInt(hospitalId.getString(0));
		
		
		parameters.put("to_date", tDate);
		parameters.put("from_date", fDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		
		HMSUtil.generateReportInPopUp("Break_Down_Report", "Break_Down_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}
	
	@RequestMapping(value = "/generateOperationDetailsReport", method = RequestMethod.GET)
	public ModelAndView generateOperationDetailsReport(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		
		connectionMap = reportDao.getConnectionForReportMis();
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray hospitalId= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("operationDate") !=null && !(json.get("operationDate")).equals(""))
		{
			fromDate = json.getJSONArray(("operationDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
			}			
		}		
		
		if(json.get("lastChgDate") !=null && !(json.get("lastChgDate")).equals(""))
		{
			toDate = json.getJSONArray(("lastChgDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
			}
		}	
		if(json.get("hospitalId") !=null){
			hospitalId = json.getJSONArray(("hospitalId"));
		}
		int UNIT_ID= Integer.parseInt(hospitalId.getString(0));
		parameters.put("fromDate", fromDate);
		parameters.put("ToDate", tDate);
		parameters.put("HOSPITAL_ID", UNIT_ID);
		
		HMSUtil.generateReportInPopUp("Operation_Details_Report", "Operation_Details_Report",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	}
	
	@RequestMapping(value = "/shoReport", method = RequestMethod.GET)
	public ModelAndView shoReport(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		
		JSONArray fromdate_array= new JSONArray();
		if(json.get("fromDate") !=null)
		{
			fromdate_array = json.getJSONArray(("fromDate"));
		}
		
		String fromdate=fromdate_array.getString(0);
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("fromDate", fd);
		//System.out.println("FROM_DATE"+fd);
		
		JSONArray todate_array= new JSONArray();
		if(json.get("toDate") !=null)
		{
			todate_array = json.getJSONArray(("toDate"));
		}
		
		String todate=todate_array.getString(0);
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("TO_DATE"+td);
		parameters.put("ToDate", td);
		
			
		JSONArray form_array= new JSONArray();
		if(json.get("formName") !=null)
		{
			form_array = json.getJSONArray(("formName"));
		}
		
		String reportFlag=form_array.getString(0);	
				
		JSONArray station_array= new JSONArray();
		if(json.get("stationId") !=null)
		{
			station_array = json.getJSONArray(("stationId"));
		}
		
		
		String stationId=station_array.getString(0);
		
		JSONArray unit_array= new JSONArray();
		if(json.get("unitId") !=null )
		{
			unit_array = json.getJSONArray(("unitId"));
		}
		
		String unitId=unit_array.getString(0);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		parameters.put("STATION_ID",Integer.parseInt(stationId));
		parameters.put("UNIT_ID",Integer.parseInt(unitId));
		connectionMap = reportDao.getConnectionForReportMis();
		if(reportFlag.equalsIgnoreCase("Malaria Case")) {
		HMSUtil.generateReportInPopUp("SHO_MALARIA_CASE_REPORT", "SHO_MALARIA_CASE_REPORT", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		if(reportFlag.equalsIgnoreCase("Health Promotion Activities")) {
			HMSUtil.generateReportInPopUp("Health_Promotion_Activities_Report", "Health_Promotion_Activities_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		if(reportFlag.equalsIgnoreCase("Water Surveillance")) {
			HMSUtil.generateReportInPopUp("Water_Surveillance_Report", "Water_Surveillance_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Mortality amongst service personnel and dependent")) {
			HMSUtil.generateReportInPopUp("Mortality_Against_Family_Report", "Mortality_Against_Family_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Anti Filaria")) {
			HMSUtil.generateReportInPopUp("Anti_Filaria_Report", "Anti_Filaria_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		//reports
		if(reportFlag.equalsIgnoreCase("School Health Details")) {
			HMSUtil.generateReportInPopUp("School_Health_Report", "School_Health_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		if(reportFlag.equalsIgnoreCase("Notifiable Disease")) {
			HMSUtil.generateReportInPopUp("Notifiable_Diseases_Report", "Notifiable_Diseases_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		if(reportFlag.equalsIgnoreCase("Operation Details")) {
			HMSUtil.generateReportInPopUp("Operation_Details_Report", "Operation_Details_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		if(reportFlag.equalsIgnoreCase("Case of Attempted Suicide")) {
			HMSUtil.generateReportInPopUp("Attempted_Sucide_Report", "Attempted_Sucide_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		if(reportFlag.equalsIgnoreCase("Alcoholism Patient Details")) {
			HMSUtil.generateReportInPopUp("Alcoholism_Monitoring_Report", "Alcoholism_Monitoring_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		if(reportFlag.equalsIgnoreCase("Break Down Details")) {
			HMSUtil.generateReportInPopUp("Break_Down_Report", "Break_Down_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Work Station Break Down Details")) {
			HMSUtil.generateReportInPopUp("Break_Down_Report", "Break_Down_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Preventable Disease Entry")) {
			HMSUtil.generateReportInPopUp("Preventable_Disease_Report", "Preventable_Disease_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Accommodation")) {
			HMSUtil.generateReportInPopUp("Accommodation_Report_1", "Accommodation_Report_1", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Allotment of accommodation")) {
			HMSUtil.generateReportInPopUp("Allotment_of_Accommodation_Report", "Allotment_of_Accommodation_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Activity Details Against HIV")) {
			HMSUtil.generateReportInPopUp("Activity_Details_Against_HIV_Reports", "Activity_Details_Against_HIV_Reports", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Conservancy")) {
			HMSUtil.generateReportInPopUp("Conservancy_Reports", "Conservancy_Reports", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Nutrition Examination")) {
			HMSUtil.generateReportInPopUp("Nutrition_Examination_Report", "Nutrition_Examination_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Industrial Disease")) {
			HMSUtil.generateReportInPopUp("Industrial_Disease_Reports", "Industrial_Disease_Reports", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Bio Medical Waste")) {
			HMSUtil.generateReportInPopUp("Bio_Medical_Waste_Reports", "Bio_Medical_Waste_Reports", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Anti Malaria/Fly/Filaria Measures")) {
			HMSUtil.generateReportInPopUp("Anti_Malaria_Fly_Filarial_Measures_Report", "Anti_Malaria_Fly_Filarial_Measures_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Work Service")) {
			HMSUtil.generateReportInPopUp("Work_Service_Report", "Work_Service_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Sanitary Rounds")) {
			HMSUtil.generateReportInPopUp("Sanitary_Rounds_Report", "Sanitary_Rounds_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Mentally and Physically Retarded Children")) {
			HMSUtil.generateReportInPopUp("Mental_And_Physical_Retarded_Children_Report", "Mental_And_Physical_Retarded_Children_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Free From Infection")) {
			HMSUtil.generateReportInPopUp("Free_From_Infection_Report", "Free_From_Infection_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Admission/ Death details")) {
			HMSUtil.generateReportInPopUp("Admission_Death_Details_Of_ICG_Employee_Report", "Admission_Death_Details_Of_ICG_Employee_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Two Four Wheeler Accident")) {
			HMSUtil.generateReportInPopUp("Road _accident_Report", "Road _accident_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Water Surveillance")) {
			HMSUtil.generateReportInPopUp("Water_Surveillance_Report", "Water_Surveillance_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Confirmed Case (H1N1)")) {
			HMSUtil.generateReportInPopUp("Confirmed_cases_(H1N1)_Report", "Confirmed_cases_(H1N1)_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Catering Arrangement")) {
			HMSUtil.generateReportInPopUp("Catering_Arrangement_Report", "Catering_Arrangement_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Water Supply")) {
			HMSUtil.generateReportInPopUp("Water_Supply_Report", "Water_Supply_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Family Health Programme")) {
			HMSUtil.generateReportInPopUp("Family_Health_Programme_Report", "Family_Health_Programme_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("School Inspection Details")) {
			HMSUtil.generateReportInPopUp("School_Inspection_Report", "School_Inspection_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		
		if(reportFlag.equalsIgnoreCase("Vector Control Activity")) {
			HMSUtil.generateReportInPopUp("Vector_Control_Activities_Report", "Vector_Control_Activities_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
			return null;
			
	}
	@RequestMapping(value = "/medicalExamReportReportF3A", method = RequestMethod.GET)
	public ModelAndView medicalExamReportReportF3A(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("MEDICAL_EXAMINATION_ID", VISIT_ID);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("3A_Report", "AnnualMedicalExaminationReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}	
	
	@RequestMapping(value = "/siqReportSlip", method = RequestMethod.GET)
	public ModelAndView siqReportSlip(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("SIQ", "SIQ",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}
	
	
	@RequestMapping(value = "/printWardAdmissionSlip", method = RequestMethod.GET)
	public ModelAndView printWardAdmissionSlip(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Hospital_Admission_Slip_Report", "wardAdmissionSlip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}

	
	@RequestMapping(value = "/medicalExamReportReportId2A", method = RequestMethod.GET)
	public ModelAndView medicalExamReportReportId2A(HttpServletRequest request, HttpServletResponse response) {
	
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
	
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
	    parameters.put("MEDICAL_EXAMINATION_ID", VISIT_ID);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("AnnualMedicalExaminationReport", "AnnualMedicalExaminationReport",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
		
	}	
	
	@RequestMapping(value = "/generateBedReport", method = RequestMethod.GET)
	public ModelAndView generateBedReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Bed_Master", "Bed_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDietReport", method = RequestMethod.GET)
	public ModelAndView generateDietReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Diet_Master", "Diet_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generatePatientConditionReport", method = RequestMethod.GET)
	public ModelAndView generatePatientConditionReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Patient_Condition", "Patient_Condition",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateMedicalExamScheduleReport", method = RequestMethod.GET)
	public ModelAndView generateMedicalExamScheduleReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Me_Schedule_Master", "Me_Schedule_Master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printDangerousRegister", method = RequestMethod.GET)
	public ModelAndView printDangerousRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray fromDate= new JSONArray();
		JSONArray toDate= new JSONArray();
		JSONArray unitId= new JSONArray();
		JSONArray userId= new JSONArray();
		JSONArray applyFor= new JSONArray();
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("fromDate") !=null && !(json.get("fromDate")).equals(""))
		{
			fromDate = json.getJSONArray(("fromDate"));
			if(!(fromDate.getString(0)).equals("")) {
				String firstDate = fromDate.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(fromDate.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("toDate") !=null && !(json.get("fromDate")).equals(""))
		{
			toDate = json.getJSONArray(("toDate"));
			if(!(toDate.getString(0)).equals("")) {
				nextDate = toDate.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(toDate.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
				
			}
			
		}	
		if(json.get("unitId") !=null)
		{
			unitId = json.getJSONArray(("unitId"));
		}
		int UNIT_ID= Integer.parseInt(unitId.getString(0));
		
		if(json.get("userId") !=null)
		{
			userId = json.getJSONArray(("userId"));
		}
		int uId= Integer.parseInt(userId.getString(0));
		
		if(json.get("applyFor") !=null)
		{
			applyFor = json.getJSONArray(("applyFor"));
			
		}
		String flag = applyFor.getString(0);
		parameters.put("PTODATE", tDate);
		parameters.put("PFROMDATE", fDate);
		parameters.put("PHOSPITALID", UNIT_ID);
		parameters.put("PUSERID", uId);
		parameters.put("PAPPLYFOR", flag);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    //System.out.println("parameters---"+parameters);
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		if(flag.equalsIgnoreCase("D"))
			HMSUtil.generateReportInPopUp("Dangerous_drug_register_report","DangerousDrugRegisterReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		if(flag.equalsIgnoreCase("E"))
			HMSUtil.generateReportInPopUp("Expendable_Ledger_Report","ExpendableLedgerRegisterReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			
		return null;
	
	}
	
	@RequestMapping(value = "/printWardDischargeSummary", method = RequestMethod.GET)
	public ModelAndView printWardDischargeSummary(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray inpatient= new JSONArray();
		if(json.get("inpatientId") !=null)
		{
			inpatient = json.getJSONArray(("inpatientId"));
		}
		int inpatientId= Integer.parseInt(inpatient.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("INPATIENT_ID", inpatientId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Discharge_Summary", "wardDischargeSlip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printDischargeSummaryApproval", method = RequestMethod.GET)
	public ModelAndView printDischargeSummaryApproval(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray inpatient= new JSONArray();
		if(json.get("inpatientId") !=null)
		{
			inpatient = json.getJSONArray(("inpatientId"));
		}
		int inpatientId= Integer.parseInt(inpatient.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		parameters.put("INPATIENT_ID", inpatientId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Discharge_Slip", "wardDischargeSlip",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}

	@RequestMapping(value = "/printObesityOverweightRegister", method = RequestMethod.GET)
	public ModelAndView printObesityOverweightRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		
		int hospitalId=0;
		
		Date fromDate = null;
		Date toDate = null;
		
		if(box.get("hospitalId")!=null && box.getInt("hospitalId")!=0) {
			hospitalId = box.getInt("hospitalId");
		}
		
		if(box.getString("fromDate") !=null && !box.getString("fromDate").isEmpty()) {
			fromDate = HMSUtil.convertStringTypeDateToDateType(box.getString("fromDate"));
		}
			
		if(box.getString("toDate") !=null && !box.getString("toDate").isEmpty()) {
			toDate = HMSUtil.convertStringTypeDateToDateType(box.getString("toDate"));
		}
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("HOSPITAL_ID", hospitalId);
	    parameters.put("FromDate", fromDate);
	    parameters.put("ToDate", toDate);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		HMSUtil.generateReportInPopUp("Obesity_Overweight_Register", "Obesity_Overweight_Register",parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/printObesityOverweightReports", method = RequestMethod.GET)
	public ModelAndView printObesityOverweightReports(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		int patientId=0; 
		String serviceNo ="";
		//String patientName = "";
		
		if(box.get("serviceNo") !=null && !box.getString("serviceNo").isEmpty())
		{
			serviceNo = box.getString("serviceNo");
		}
			if(box.get("patientId") !=null && !box.getString("patientId").isEmpty())
			{
				patientId = box.getInt("patientId");
			}
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("SERVICE_NO", serviceNo);
	    parameters.put("PATIENT_ID", patientId);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		HMSUtil.generateReportInPopUp("Obesity_Overweight_Report", "ObesityOverweightReport",parameters, (Connection) connectionMap.get("conn"), response,
				request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/generateDiseaseTypeReport", method = RequestMethod.GET)
	public ModelAndView generateDiseaseTypeReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Disease_type_master", "Disease_type_master",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/generateDiseaseMappingReport", method = RequestMethod.GET)
	public ModelAndView generateDiseaseMappingReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Disease_Diagnosis_Mapping", "Disease_Diagnosis_Mapping",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printAdmissionDischargeRegisterReport", method = RequestMethod.GET)
	public ModelAndView printAdmissionDischargeRegisterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		String service_no ="";
		//String patientName = "";
		Date fDate =null;
    	Date tDate = null;
		String nextDate = "";
		if(json.get("from_date") !=null && !(json.get("from_date")).equals(""))
		{
			from_date = json.getJSONArray(("from_date"));
			if(!(from_date.getString(0)).equals("")) {
				String firstDate = from_date.getString(0);
				 fDate = HMSUtil.convertStringTypeDateToDateType(from_date.getString(0));
				String frmDate = HMSUtil.convertDateToStringFormat(fDate,"dd-MMM-yy");
			}			
		}		
		
		if(json.get("to_date") !=null && !(json.get("to_date")).equals(""))
		{
			to_date = json.getJSONArray(("to_date"));
			if(!(to_date.getString(0)).equals("")) {
				nextDate = to_date.getString(0);
				tDate= HMSUtil.convertStringTypeDateToDateType(to_date.getString(0));
				String tdate = HMSUtil.convertDateToStringFormat(tDate,"dd-MMM-yy");
			}
			
		}	
		
		if(box.get("service_no") !=null && !box.getString("service_no").isEmpty())
		{
			service_no = box.getString("service_no");
		}
		
		parameters.put("to_date", tDate);
		parameters.put("from_date", fDate);
		//parameters.put("HOSPITAL_ID", Integer.parseInt(unitId));

		parameters.put("service_no", service_no);
	
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Admission_And_Discharge_Register", "Admission_And_Discharge_Register",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
}
	
	@RequestMapping(value = "/generateIdentificationTypeMasterReport", method = RequestMethod.GET)
	public ModelAndView generateIdentificationTypeMasterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");		
	    String imagePath = userHome+"/mmu-logo.png";	
	    parameters.put("path", imagePath);		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Identification_Type_Master _report_1", "Identification_Type_Master _report_1",parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printCampMonthlyReport", method = RequestMethod.GET)
	public ModelAndView printCampMonthlyReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		//JSONArray city_id= new JSONArray();
		JSONArray mmu_id= new JSONArray();
		JSONArray yr_id= new JSONArray();
		JSONArray month_id= new JSONArray();
		/*if(json.get("city_id") !=null)
		{
			city_id = json.getJSONArray(("city_id"));
		}
		int int_city_id= Integer.parseInt(city_id.getString(0));
	*/
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray(("mmu_id"));
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
		
		if(json.get("yr_id") !=null)
		{
			yr_id = json.getJSONArray(("yr_id"));
		}
		int int_yr_id= Integer.parseInt(yr_id.getString(0));
		
		if(json.get("month_id") !=null)
		{
			month_id = json.getJSONArray(("month_id"));
		}
		int int_month_id= Integer.parseInt(month_id.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
		//parameters.put("City_id", int_city_id);
		parameters.put("Mmu_id", int_mmu_id);
		parameters.put("Year", int_yr_id);
		parameters.put("Month", int_month_id);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Monthly_camp_plan_report", "MonthlyCampPlanReport", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printOPDRegisterReport", method = RequestMethod.GET)
	public ModelAndView printOPDRegisterReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		
		String fromdate="";
		String todate="";
		JSONArray mmu_id= new JSONArray();
		JSONArray gender_id= new JSONArray();
		JSONArray icd_id= new JSONArray();
		
		int fAge=0;
		int tAge=0;
		
		JSONArray fage= new JSONArray();
		JSONArray tage= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		JSONArray referral_val= new JSONArray();
		
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray(("User_id"));
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("fromAge") !=null)
		{
			fage = json.getJSONArray(("fromAge"));
		}
		fAge= Integer.parseInt(fage.getString(0));
		
		if(json.get("toAge") !=null)
		{
			tage = json.getJSONArray(("toAge"));
		}
		tAge= Integer.parseInt(tage.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray(("Level_of_user"));
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray(("mmu_id"));
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
	
		
		if(json.get("gender_id") !=null)
		{
			gender_id = json.getJSONArray(("gender_id"));
		}
		int int_gender_id= Integer.parseInt(gender_id.getString(0));
		
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		
		if(json.get("referral") !=null)
		{
			referral_val = json.getJSONArray(("referral"));
		}
		
		String referral=referral_val.getString(0);
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FROM_DATE", fd);
		//System.out.println("FROM_DATE "+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("TO_DATE "+td);
		parameters.put("TO_DATE", td);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    
	    
	    //System.out.println("int_gender_id="+int_gender_id);
	    //System.out.println("int_mmu_id="+int_mmu_id);
	    
		parameters.put("Sex_id", int_gender_id);
		parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("Mmu_id", int_mmu_id);
		parameters.put("Icd_id", 0);
		parameters.put("Patient_Type", "A");
		
		parameters.put("fromAge", fAge);
		parameters.put("toAge", tAge);
		parameters.put("referral_flag", referral);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		////System.out.println("Connection url"+ connectionMap.get("url"));
		
		HMSUtil.generateReportInPopUp("OPD_register_report", "OPD Register Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/mlcSlip", method = RequestMethod.GET)
	public ModelAndView mlcSlip(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray sUser_id= new JSONArray();
		JSONArray sLevel_of_user= new JSONArray();
		JSONArray smmu_id= new JSONArray();
		
		/*
		 * if(json.get("User_id") !=null) { sUser_id = json.getJSONArray(("User_id")); }
		 * int User_id= Integer.parseInt(sUser_id.getString(0));
		 * 
		 * 
		 * if(json.get("Level_of_user") !=null) { sLevel_of_user =
		 * json.getJSONArray(("Level_of_user")); } String Level_of_user=
		 * sLevel_of_user.getString(0);
		 * 
		 * if(json.get("mmu_id") !=null) { smmu_id = json.getJSONArray(("mmu_id")); }
		 * int mmu_id= Integer.parseInt(smmu_id.getString(0));
		 */
		
		JSONArray sVISIT_ID= new JSONArray();
		if(json.get("visit_id") !=null)
		{
			sVISIT_ID = json.getJSONArray(("visit_id"));
		}
		int VISIT_ID= Integer.parseInt(sVISIT_ID.getString(0));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		
		parameters.put("VISIT_ID", VISIT_ID);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		/*
		 * parameters.put("User_id", User_id); parameters.put("Level_of_user",
		 * Level_of_user); parameters.put("mmu_id", mmu_id);
		 */
		
		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("MLC_Slip","MlcSlip", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printDailyMMURegister", method = RequestMethod.GET)
	public ModelAndView printDailyMMURegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String campDate="";
		
		JSONArray camp_date= new JSONArray();
		JSONArray city_id= new JSONArray();
		
		if(box.get("campDate") !=null && !box.getString("campDate").isEmpty())
		{
			camp_date= json.getJSONArray("campDate");
		}
		
		campDate = camp_date.getString(0);
		
	
			if(json.get("cityId") !=null)
		{
			city_id = json.getJSONArray("cityId");
		}
		int cityId = Integer.parseInt(city_id.getString(0));
		
		
		Date cd= new Date();
		try {
			cd = HMSUtil.convertStringTypeDateToDateType(campDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("Camp_date", cd);
		parameters.put("City_ID", cityId);
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Daily_MMU_Report", "Daily_MMU_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printIndentRegister", method = RequestMethod.GET)
	public ModelAndView printIndentRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String fromDate="";
		String toDate="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_id= new JSONArray();
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray(("User_id"));
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray(("Level_of_user"));
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray(("mmu_id"));
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
		
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}
		
		fromDate = from_date.getString(0);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		
		toDate = to_date.getString(0);
		
		Date fd= new Date();
		Date td= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			td = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("Fromdate", fd);
		parameters.put("Todate", td);
		parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("Mmu_id", int_mmu_id);
				
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Indent_register", "Indent_register", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printMedicineIssueRegister", method = RequestMethod.GET)
	public ModelAndView printMedicineIssueRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String fromDate="";
		String toDate="";
		int int_drug_id=0;
		JSONArray mmu_id= new JSONArray();
		JSONArray User_id= new JSONArray();
		JSONArray Drug_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		
		if(json.get("drugId") !=null)
		{
			Drug_id = json.getJSONArray("drugId");
		}
		int_drug_id= Integer.parseInt(Drug_id.getString(0));
		
		 if(json.get("User_id") !=null)
			{
				User_id = json.getJSONArray(("User_id"));
			}
			int int_User_id= Integer.parseInt(User_id.getString(0));
			
			if(json.get("Level_of_user") !=null)
			{
				Level_of_user = json.getJSONArray(("Level_of_user"));
			}
			String str_Level_of_user= Level_of_user.getString(0);
			
			if(json.get("mmu_id") !=null)
			{
				mmu_id = json.getJSONArray(("mmu_id"));
			}
			int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
		
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}
		
		fromDate = from_date.getString(0);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}	
		
		toDate = to_date.getString(0);
		
		
		Date fd= new Date();
		Date td= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			td = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("Fromdate", fd);
		parameters.put("Todate", td);
		parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("Mmu_id", int_mmu_id);		
		parameters.put("Drug_id", int_drug_id);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Medicine_issue_register", "Medicine_issue_register", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printAttendanceRegister", method = RequestMethod.GET)
	public ModelAndView printAttendanceRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		String fromdate="";
		String todate="";
		JSONArray mmu_id= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray("User_id");
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray("mmu_id");
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("From_Date", fd);
		//System.out.println("FROM_DATE "+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("TO_DATE "+td);
		parameters.put("To_Date", td);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("MMU_ID", int_mmu_id);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Attendance_Register", "Attendance Register Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printIncidentRegister", method = RequestMethod.GET)
	public ModelAndView printIncidentRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		
		String fromdate="";
		String todate="";
		JSONArray mmu_id= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		
		JSONArray city_id= new JSONArray();
		JSONArray vendor_id= new JSONArray();
		JSONArray radioValue= new JSONArray();
		
		
		if(json.get("city_id") !=null)
		{
			city_id = json.getJSONArray("city_id");
		}
		int int_city_id= Integer.parseInt(city_id.getString(0));
		
		if(json.get("vendor_id") !=null)
		{
			vendor_id = json.getJSONArray("vendor_id");
		}
		int int_vendor_id= Integer.parseInt(vendor_id.getString(0));
				
		if(json.get("radioValue") !=null)
		{
			radioValue = json.getJSONArray("radioValue");
		}
		String str_radioValue= radioValue.getString(0);
		
				
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray(("User_id"));
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray(("mmu_id"));
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("From_Date", fd);
		//System.out.println("FROM_DATE "+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("TO_DATE "+td);
		parameters.put("To_Date", td);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("MMU_ID", int_mmu_id);
		parameters.put("CITY_ID", int_city_id);
		parameters.put("VENDOR_ID", int_vendor_id);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		if(str_radioValue.equals("S")) {
		HMSUtil.generateReportInPopUp("Incident_Summary_Report", "Incident Summary Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		else {
			HMSUtil.generateReportInPopUp("Incident_Detail_Report", "Incident Detail Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());	
		}
		
		return null;
	
	}
	
	
	@RequestMapping(value = "/printCampLocationPlan", method = RequestMethod.GET)
	public ModelAndView printCampLocationPlan(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String campDate="";
		
		JSONArray camp_date= new JSONArray();
		JSONArray city_id= new JSONArray();
		
		if(box.get("campDate") !=null && !box.getString("campDate").isEmpty())
		{
			camp_date= json.getJSONArray("campDate");
		}
		
		campDate = camp_date.getString(0);
		
	
			if(json.get("cityId") !=null)
		{
			city_id = json.getJSONArray("cityId");
		}
		int cityId = Integer.parseInt(city_id.getString(0));
		
		
		Date cd= new Date();
		try {
			cd = HMSUtil.convertStringTypeDateToDateType(campDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("Camp_date", cd);
		parameters.put("City_id", cityId);
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("camp_location_plan_report", "Camp Location Plan Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printEquipmentChecklist", method = RequestMethod.GET)
	public ModelAndView printEquipmentChecklist(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String campDate="";
		
		JSONArray camp_date= new JSONArray();
		JSONArray mmu_id= new JSONArray();
		
		if(box.get("campDate") !=null && !box.getString("campDate").isEmpty())
		{
			camp_date= json.getJSONArray("campDate");
		}
		
		campDate = camp_date.getString(0);
		
	
			if(json.get("mmuId") !=null)
		{
			mmu_id = json.getJSONArray("mmuId");
		}
		int mmuId = Integer.parseInt(mmu_id.getString(0));
		
		
		Date cd= new Date();
		try {
			cd = HMSUtil.convertStringTypeDateToDateType(campDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("AsOnDate", cd);
		parameters.put("MMU_ID", mmuId);
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		String basePath = environment.getProperty("mmu.web.audit.basePath")+"/"+"capture_equipment";
		parameters.put("path_img", basePath);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("mmu_equipment_report", "mmu_equipment_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printPenaltyRegister", method = RequestMethod.GET)
	public ModelAndView printPenaltyRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		
		String fromdate="";
		String todate="";
		JSONArray mmu_id= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		
		JSONArray vendor_id= new JSONArray();
    	if(json.get("vendor_id") !=null)
		{
			vendor_id = json.getJSONArray("vendor_id");
		}
		int int_vendor_id= Integer.parseInt(vendor_id.getString(0));
				
						
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray(("User_id"));
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray(("mmu_id"));
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("From_Date", fd);
		//System.out.println("FROM_DATE "+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("TO_DATE and FROM_DATE "+fd+"::"+td);
		parameters.put("To_Date", td);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("MMU_ID", int_mmu_id);
		parameters.put("VENDOR_ID", int_vendor_id);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Penalty_Register", "Penalty Register", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
				
		return null;
	
	}	
	
	@RequestMapping(value = "/printPatientFeedbackReport", method = RequestMethod.GET)
	public ModelAndView printPatientFeedbackReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		String fromdate="";
		String todate="";
		JSONArray mmu_id= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray("User_id");
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray("mmu_id");
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FROM_DATE", fd);
		//System.out.println("FROM_DATE "+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("TO_DATE "+td);
		parameters.put("TO_DATE", td);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("MMU_ID", int_mmu_id);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Mmu_feedback_data", "Patient Feedback Data Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printTreatmentAuditRegister", method = RequestMethod.GET)
	public ModelAndView printTreatmentAuditRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String fromDate="";
		String toDate="";
		String auditorId="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		
		JSONArray mmu_id= new JSONArray();
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		JSONArray auditor= new JSONArray();
		
		
		if(json.get("auditor") !=null)
		{
			auditor = json.getJSONArray("auditor");
		}
		int int_auditor_id= Integer.parseInt(auditor.getString(0));

		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray("User_id");
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray("mmu_id");
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
	
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}
		
		fromDate = from_date.getString(0);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		
		toDate = to_date.getString(0);
		
		Date fd= new Date();
		Date td= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			td = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("Fromdate", fd);
		parameters.put("Todate", td);
		parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("Mmu_id", int_mmu_id);
		parameters.put("Auditor_id", int_auditor_id);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Treatment_audit_register", "Treatment_audit_register", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}	
	
	@RequestMapping(value = "/printLabourRegistration", method = RequestMethod.GET)
	public ModelAndView printLabourRegistration(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		int labourId=0;
		labourId=Integer.parseInt(request.getParameter("labourId"));		
		parameters.put("labour_id", labourId);		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Labour_Report", "Labour Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printArrivalRegister", method = RequestMethod.GET)
	public ModelAndView printArrivalRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		String fromdate="";
		String todate="";
		String status="";
		JSONArray mmu_id= new JSONArray();
		
		if(json.get("status") !=null)
		{
			status = box.getString("status");
		}
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray("mmu_id");
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FromDate", fd);
		//System.out.println("FromDate"+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("TO_DATE "+td);
		parameters.put("ToDate", td);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   	parameters.put("MMU_ID", int_mmu_id);
	   	parameters.put("status", status);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Mmu_arrival_time_report", "Mmu Arrival Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printInspectionReport", method = RequestMethod.GET)
	public ModelAndView printInspectionReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String campDate="";
		
		JSONArray camp_date= new JSONArray();
		JSONArray mmu_id= new JSONArray();
		
		if(box.get("campDate") !=null && !box.getString("campDate").isEmpty())
		{
			camp_date= json.getJSONArray("campDate");
		}
		
		campDate = camp_date.getString(0);
		
	
			if(json.get("mmuId") !=null)
		{
			mmu_id = json.getJSONArray("mmuId");
		}
		int mmuId = Integer.parseInt(mmu_id.getString(0));
		
		
		Date cd= new Date();
		try {
			cd = HMSUtil.convertStringTypeDateToDateType(campDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("AsOnDate", cd);
		parameters.put("MMU_ID", mmuId);
		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		String basePath = environment.getProperty("mmu.web.audit.basePath")+"/"+"capture_inspection";
		parameters.put("path_img", basePath);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("mmu_inspection_report", "mmu_inspection_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printUsersReport", method = RequestMethod.GET)
	public ModelAndView printUsersReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		JSONArray userFlag= new JSONArray();
		if(json.get("userFlag") !=null)
		{
			userFlag = json.getJSONArray(("userFlag"));
		}
		int user_flag= Integer.parseInt(userFlag.getString(0));
		//System.out.println("user_flag :: "+user_flag);
	    parameters.put("path", imagePath);
	    parameters.put("user_flag", user_flag);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Users_details_report", "Users_details_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/attendanceInTimeOutTime", method = RequestMethod.GET)
	public ModelAndView attendanceInTimeOutTime(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		String fromdate="";
		String todate="";
		JSONArray mmu_id= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray("User_id");
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray("mmu_id");
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		 
		  Date fd= new Date();
			try {
				fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
			} catch (Exception e) {
				e.printStackTrace();
			}
			parameters.put("From_Date", fd);
			//System.out.println("FromDate"+fd);
			
			if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
			{
				todate=box.getString("toDate");
			}
			
			Date td= new Date();
			try {
				td = HMSUtil.convertStringTypeDateToDateType(todate);
			} catch (Exception e) {
				e.printStackTrace();
			}
			parameters.put("To_Date", td);
		 
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   	parameters.put("MMU_ID", int_mmu_id);
	    parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Attendance_InTime_OutTime_Report", "Attendance InTime OutTime Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	
	@RequestMapping(value = "/printInvestigationRegister", method = RequestMethod.GET)
	public ModelAndView printInvestigationRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		String fromdate="";
		String todate="";
		JSONArray mmu_id= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray("User_id");
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray("mmu_id");
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		int genderId=0;
		if(box.get("gender") !=null && !box.getString("gender").isEmpty())
		{
			String gndr= box.getString("gender");
			genderId= Integer.parseInt(gndr);
		}
		//System.out.println("gender--> "+genderId);
		parameters.put("genderId", genderId);
		
		
		int fromAge=0;
		if(box.get("fromAge") !=null && !box.getString("fromAge").isEmpty())
		{
			String fAge= box.getString("fromAge");
			fromAge= Integer.parseInt(fAge);
		}
		//System.out.println("fromAge--> "+fromAge);
		parameters.put("fromAge", fromAge);
		
		int toAge=0;
		if(box.get("toAge") !=null && !box.getString("toAge").isEmpty())
		{
			String tAge= box.getString("toAge");
			toAge= Integer.parseInt(tAge);
		}
		//System.out.println("toAge--> "+toAge);
		parameters.put("toAge", toAge);
		
		
		int investigationId=0;
		if(box.get("investigationId") !=null && !box.getString("investigationId").isEmpty())
		{
			String inv= box.getString("investigationId");
			investigationId= Integer.parseInt(inv);
		}
		//System.out.println("investigationId--> "+investigationId);
		parameters.put("investigationId", investigationId);
		
		//System.out.println("fromdate="+fromdate);
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//System.out.println("fd="+fd);
		parameters.put("FROM_DATE", fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		parameters.put("TO_DATE", td);
		String reportType = "";
		if(box.get("reportType") !=null && !box.getString("reportType").isEmpty())
		{
			reportType=box.getString("reportType");
		}
		//System.out.println("reportType--> "+reportType);
		parameters.put("reportType", reportType);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("MMU_ID", int_mmu_id);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Lab_Main_Report", "Investigation Register Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printNotInStockRegister", method = RequestMethod.GET)
	public ModelAndView printNotInStockRegister(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);		
		
		String fromDate="";
		String toDate="";
		JSONArray mmu_id= new JSONArray();
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		
		
		 if(json.get("User_id") !=null)
			{
				User_id = json.getJSONArray(("User_id"));
			}
			int int_User_id= Integer.parseInt(User_id.getString(0));
			
			if(json.get("Level_of_user") !=null)
			{
				Level_of_user = json.getJSONArray(("Level_of_user"));
			}
			String str_Level_of_user= Level_of_user.getString(0);
			
			if(json.get("mmu_id") !=null)
			{
				mmu_id = json.getJSONArray(("mmu_id"));
			}
			int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
		
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}
		
		fromDate = from_date.getString(0);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}	
		
		toDate = to_date.getString(0);
		
		
		Date fd= new Date();
		Date td= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			td = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("Fromdate", fd);
		parameters.put("Todate", td);
		parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("Mmu_id", int_mmu_id);		
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("NIS_Register_report", "NIS_Register_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/printRolExpiryReport", method = RequestMethod.GET)
	public ModelAndView printRolExpiryReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray mmu_id= new JSONArray();
		int mmuId = 0;
		if(json.get("mmuId") !=null)
		{
			mmu_id = json.getJSONArray(("mmuId"));
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
		
		
		

		//System.out.println("mmuId "+int_mmu_id);		
		parameters.put("mmuId", int_mmu_id);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("ROL_EXPIRY_report", "ROL_EXPIRY_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}

	@RequestMapping(value = "/printEdlReport", method = RequestMethod.GET)
	public ModelAndView printEdlReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		//String campDate="";

		//JSONArray camp_date= new JSONArray();
		JSONArray mmuId= new JSONArray();
		JSONArray clusterId= new JSONArray();
		JSONArray cityId= new JSONArray();

	/*	if(box.get("campDate") !=null && !box.getString("campDate").isEmpty())
		{
			camp_date= json.getJSONArray("campDate");
		}*/

		//campDate = camp_date.getString(0);
		if(json.get("clusterId") !=null)
		{
			clusterId = json.getJSONArray("clusterId");
		}
		if(json.get("cityId") !=null)
		{
			cityId = json.getJSONArray("cityId");
		}

		if(json.get("mmuId") !=null)
		{
				mmuId = json.getJSONArray("mmuId");
		}
		int MMU_ID = Integer.parseInt(mmuId.getString(0));
		int CLUSTER_ID=Integer.parseInt(clusterId.getString(0));
		int CITY_ID=Integer.parseInt(cityId.getString(0));

		/*Date cd= new Date();
		try {
			cd = HMSUtil.convertStringTypeDateToDateType(campDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		parameters.put("DISTRICT_ID", CLUSTER_ID);
		parameters.put("CITY_ID", CITY_ID);
		parameters.put("MMU_ID", MMU_ID);
		//parameters.put("asondate", cd);



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("EDL_Report", "EDL_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}

	@RequestMapping(value = "/printEdlReportCityWise", method = RequestMethod.GET)
	public ModelAndView printEdlReportCityWise(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		//String campDate="";

		//JSONArray camp_date= new JSONArray();
		JSONArray mmuId= new JSONArray();
		JSONArray clusterId= new JSONArray();
		JSONArray cityId= new JSONArray();

	/*	if(box.get("campDate") !=null && !box.getString("campDate").isEmpty())
		{
			camp_date= json.getJSONArray("campDate");
		}*/

		//campDate = camp_date.getString(0);
		if(json.get("clusterId") !=null)
		{
			clusterId = json.getJSONArray("clusterId");
		}
		if(json.get("cityId") !=null)
		{
			cityId = json.getJSONArray("cityId");
		}

		if(json.get("mmuId") !=null)
		{
				mmuId = json.getJSONArray("mmuId");
		}
		int MMU_ID = Integer.parseInt(mmuId.getString(0));
		int CLUSTER_ID=Integer.parseInt(clusterId.getString(0));
		int CITY_ID=Integer.parseInt(cityId.getString(0));

		/*Date cd= new Date();
		try {
			cd = HMSUtil.convertStringTypeDateToDateType(campDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		parameters.put("DISTRICT_ID", CLUSTER_ID);
		parameters.put("CITY_ID", CITY_ID);
		parameters.put("MMU_ID", MMU_ID);
		//parameters.put("asondate", cd);



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("EDL_Report_City", "EDL_Report_City", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}
	
	
	@RequestMapping(value = "/printLabReport", method = RequestMethod.GET)
	public ModelAndView printLabReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";

		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmuId= new JSONArray();
		JSONArray clusterId= new JSONArray();
		JSONArray cityId= new JSONArray();

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}

		toDate = to_date.getString(0);
		if(json.get("clusterId") !=null)
		{
			clusterId = json.getJSONArray("clusterId");
		}
		if(json.get("cityId") !=null)
		{
			cityId = json.getJSONArray("cityId");
		}

		if(json.get("mmuId") !=null)
		{
				mmuId = json.getJSONArray("mmuId");
		}
		int MMU_ID = Integer.parseInt(mmuId.getString(0));
		int CLUSTER_ID=Integer.parseInt(clusterId.getString(0));
		int CITY_ID=Integer.parseInt(cityId.getString(0));

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("DISTRICT_ID", CLUSTER_ID);
		parameters.put("CITY_ID", CITY_ID);
		parameters.put("MMU_ID", MMU_ID);
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Lab_Test_Report", "Lab_Test_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}

	@RequestMapping(value = "/medicineIssueReport", method = RequestMethod.GET)
	public ModelAndView medicineIssueReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";

		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmuId= new JSONArray();
		JSONArray cityId= new JSONArray();
		JSONArray districtId= new JSONArray();

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}

		toDate = to_date.getString(0);
		if(json.get("cityId") !=null)
		{
			cityId = json.getJSONArray("cityId");
		}
		if(json.get("districtId") !=null)
		{
			districtId = json.getJSONArray("districtId");
		}

		if(json.get("mmuId") !=null)
		{
				mmuId = json.getJSONArray("mmuId");
		}
		int MMU_ID = Integer.parseInt(mmuId.getString(0));
		int CITY_ID=Integer.parseInt(cityId.getString(0));
		int DISTRICT_ID=Integer.parseInt(districtId.getString(0));

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//parameters.put("CLUSTER_ID", CLUSTER_ID);
		parameters.put("DISTRICT_ID", DISTRICT_ID);
		parameters.put("CITY_ID", CITY_ID);
		parameters.put("MMU_ID", MMU_ID);
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);

		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();

		HMSUtil.generateReportInPopUp("Medicine_Issue", "Medicine_Issue", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/invoiceDashboardReport", method = RequestMethod.GET)
	public ModelAndView invoiceDashboardReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";
		String distIdVal="";
		String phase="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_City =  new JSONArray();
		JSONArray distIdVal_value =  new JSONArray();
		JSONArray phase_value =  new JSONArray();
		
	
		
		if(box.get("mmuCity") !=null && !box.getString("mmuCity").isEmpty())
		{
			mmu_City= json.getJSONArray("mmuCity");
		}

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}
		if(box.get("phase") !=null && !box.getString("phase").isEmpty())
		{
			phase_value= json.getJSONArray("phase");
		}
		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		if(box.get("distIdVal") !=null && !box.getString("distIdVal").isEmpty())
		{
			distIdVal_value= json.getJSONArray("distIdVal");
		}
		if(distIdVal_value!=null && !distIdVal_value.isNull(0))
		{	
		distIdVal=distIdVal_value.getString(0);
		}
		else
		{
			distIdVal="";
		}
		if(phase_value!=null && !phase_value.isNull(0))
		{	
		phase=phase_value.getString(0);
		}
		else
		{
			phase="";
		}
		String mmuCity=mmu_City.getString(0);
		
		toDate = to_date.getString(0);
		

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);
		parameters.put("p_distidval", distIdVal);
		parameters.put("p_phase", phase);



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			if(phase.equals(""))
			{	
			HMSUtil.generateReportInPopUp("City_Invoice_Dashboard", "City_Invoice_Dashboard", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
			else {
				HMSUtil.generateReportInPopUp("City_Invoice_Dashboard_PhaseWise", "City_Invoice_Dashboard_PhaseWise", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
		}else {
			if(phase.equals(""))
			{
			HMSUtil.generateReportInPopUp("Upss_Invoice_Dashboard", "Upss_Invoice_Dashboard", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
			else {
				HMSUtil.generateReportInPopUp("Upss_Invoice_Dashboard_PhaseWise", "Upss_Invoice_Dashboard_PhaseWise", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
		}
		return null;

	}
	
	
	@RequestMapping(value = "/medicineInvoiceDashboardReport", method = RequestMethod.GET)
	public ModelAndView medicineInvoiceDashboardReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";
		String phase="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_City =  new JSONArray();
		JSONArray upss_id =  new JSONArray();
		JSONArray phase_value =  new JSONArray();
		
	
		
		if(box.get("mmuCity") !=null && !box.getString("mmuCity").isEmpty())
		{
			mmu_City= json.getJSONArray("mmuCity");
		}
		
		if(box.get("upss_id") !=null && !box.getString("upss_id").isEmpty())
		{
			upss_id= json.getJSONArray("upss_id");
		}

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		if(box.get("phase") !=null && !box.getString("phase").isEmpty())
		{
			phase_value= json.getJSONArray("phase");
		}
		String mmuCity=mmu_City.getString(0);
		String upssId=upss_id.getString(0);
		
		toDate = to_date.getString(0);
		

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(phase_value!=null && !phase_value.isNull(0))
		{	
		phase=phase_value.getString(0);
		}
		else
		{
			phase="";
		}
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);
		parameters.put("p_phase", phase);
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			parameters.put("city_id", Integer.valueOf(upssId));
			//parameters.put("district_id", 0);
		}else {
			parameters.put("district_id", Integer.valueOf(upssId));
		}



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			HMSUtil.generateReportInPopUp("Medicine_invoice_CITY", "Medicine_invoice_CITY", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}else {
			HMSUtil.generateReportInPopUp("Medicine_invoice_UPSS", "Medicine_invoice_UPSS", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		return null;

	}
	
	
	
	
	@RequestMapping(value = "/medicineInvoiceDashboardTCUReport", method = RequestMethod.GET)
	public ModelAndView medicineInvoiceDashboardTCUReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";
		String phase="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_City =  new JSONArray();
		JSONArray requestType =  new JSONArray();
		JSONArray upss_id =  new JSONArray();
		JSONArray phase_value =  new JSONArray();
		
	
		
		if(box.get("mmuCity") !=null && !box.getString("mmuCity").isEmpty())
		{
			mmu_City= json.getJSONArray("mmuCity");
		}
		
		if(box.get("flagType") !=null && !box.getString("flagType").isEmpty())
		{
			requestType= json.getJSONArray("flagType");
		}
		if(box.get("phase") !=null && !box.getString("phase").isEmpty())
		{
			phase_value= json.getJSONArray("phase");
		}
		
		if(box.get("upss_id") !=null && !box.getString("upss_id").isEmpty())
		{
			upss_id= json.getJSONArray("upss_id");
		}

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		
		String mmuCity=mmu_City.getString(0);
		String upssId=upss_id.getString(0);
		String flagType =requestType.getString(0); 
		if(phase_value!=null && !phase_value.isNull(0))
		{	
		phase=phase_value.getString(0);
		}
		else
		{
			phase="";
		}
		toDate = to_date.getString(0);
		

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			parameters.put("city_id", Integer.valueOf(upssId));
			//parameters.put("district_id", 0);
		}else {
			parameters.put("district_id", Integer.valueOf(upssId));
		}
		
		
			parameters.put("flagType", flagType);
			parameters.put("p_phase", phase);
		



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		if(flagType.equalsIgnoreCase("C")) {
			if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
				HMSUtil.generateReportInPopUp("Invoice_Dashboard_Cleared_Cityl", "Invoice_Dashboard_Cleared_Cityl", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}else {
				HMSUtil.generateReportInPopUp("Invoice_Dashboard_Clearedl", "Invoice_Dashboard_Clearedl", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
		}
		else if(flagType.equalsIgnoreCase("U")) {
			if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
				HMSUtil.generateReportInPopUp("Invoice_Dashboard_Uncleared_City", "Invoice_Dashboard_Uncleared_City", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}else {
				HMSUtil.generateReportInPopUp("Invoice_Dashboard_Uncleared", "Invoice_Dashboard_Uncleared", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
		}
		else {
			if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
				HMSUtil.generateReportInPopUp("Invoice_Dashboard_Total_City", "Invoice_Dashboard_Total_City", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}else {
				HMSUtil.generateReportInPopUp("Invoice_Dashboard_Total", "Invoice_Dashboard_Total", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
			}
		}
		return null;

	}
	
	@RequestMapping(value = "/printVendorInvoiceReport", method = RequestMethod.GET)
	public ModelAndView printVendorInvoiceReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray captureVendorBillDetail_id= new JSONArray();
		int captureVendorBillDetailId = 0;
		if(json.get("captureVendorBillDetailId") !=null)
		{
			captureVendorBillDetail_id = json.getJSONArray(("captureVendorBillDetailId"));
		}
		int detail_id= Integer.parseInt(captureVendorBillDetail_id.getString(0));
		
		
		

		//System.out.println("captureVendorBillDetail_id "+detail_id);		
		parameters.put("detail_id", detail_id);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Invoice_Report", "Invoice_Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/detailedPrintVendorReport", method = RequestMethod.GET)
	public ModelAndView detailedPrintVendorReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		int vendor_id=0;
		String fromDate="";
		String toDate="";
		int districtId=0;
		String paymentStatus="";
		
		JSONArray Vendor_id= new JSONArray();
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray district_id =  new JSONArray();
		JSONArray payment_status =  new JSONArray();
		JSONArray upss_id =  new JSONArray();
		
		if(json.get("vendorId") !=null && json.get("vendorId") !="")
		{
			Vendor_id = json.getJSONArray(("vendorId"));
			if(!Vendor_id.getString(0).equals(""))
			vendor_id= Integer.parseInt(Vendor_id.getString(0));
		}
		 
		
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
			fromDate = from_date.getString(0);
		}

		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
			toDate = to_date.getString(0);
		}
		
		
		if(json.get("district") !=null && json.get("district") !="")
		{
			district_id = json.getJSONArray(("district"));
			if(!district_id.getString(0).equals(""))
			districtId= Integer.parseInt(district_id.getString(0));
		}
		 
		
		if(json.get("statusSearch") !=null && json.get("statusSearch") !="")
		{
			payment_status = json.getJSONArray(("statusSearch"));
			paymentStatus= payment_status.getString(0);
		}
		 
		
		
		Date cd_from= new Date();
		Date cd_to= new Date();
		if(box.get("fromDate") !=null && box.get("fromDate")!="")
		{		
		try {
			
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
			}
		 catch (Exception e) {
			e.printStackTrace();
		}
		}
		//System.out.println("print value "+cd_from+cd_to+vendor_id+"C"+districtId);	
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);
		parameters.put("Vendor_id", vendor_id);
		parameters.put("Payment_status", paymentStatus);
		parameters.put("district_id", districtId);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Detail_billing_report", "Detail_billing_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}
	
	
	
	@RequestMapping(value = "/printCampVisitStatusReport", method = RequestMethod.GET)
	public ModelAndView printCampVisitStatusReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		
		String fromdate="";
		String todate="";
			
		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			fromdate= box.getString("fromDate");
		}
		
		Date fd= new Date();
		try {
			fd = HMSUtil.convertStringTypeDateToDateType(fromdate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		parameters.put("FromDate", fd);
		//System.out.println("FromDate "+fd);
		
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			todate=box.getString("toDate");
		}
		
		
		Date td= new Date();
		try {
			td = HMSUtil.convertStringTypeDateToDateType(todate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("ToDate "+td);
		parameters.put("ToDate", td);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	  	
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		
		HMSUtil.generateReportInPopUp("Camp_visit_status", "Camp Visit Status Report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;
	
	}
	
	@RequestMapping(value = "/mmuExpenditureMedicineReport", method = RequestMethod.GET)
	public ModelAndView mmuExpenditureMedicineReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_City =  new JSONArray();
		JSONArray upss_id =  new JSONArray();
		
	
		
		if(box.get("mmuCity") !=null && !box.getString("mmuCity").isEmpty())
		{
			mmu_City= json.getJSONArray("mmuCity");
		}
		
		if(box.get("upss_id") !=null && !box.getString("upss_id").isEmpty())
		{
			upss_id= json.getJSONArray("upss_id");
		}

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		
		String mmuCity=mmu_City.getString(0);
		String upssId=upss_id.getString(0);
		
		toDate = to_date.getString(0);
		

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			parameters.put("city_id", Integer.valueOf(upssId));
			parameters.put("district_id", 0);

		}else {
			parameters.put("district_id", Integer.valueOf(upssId));
			parameters.put("city_id", 0);
		}



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		
	    HMSUtil.generateReportInPopUp("Track_Medical_Invoice", "Track_Medical_Invoice", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		
		return null;

	}
	
	
	@RequestMapping(value = "/fundManagementDashboard", method = RequestMethod.GET)
	public ModelAndView fundManagementDashboard(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";
		String flagType="";
		String phase="";
		String distIdVal="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_City =  new JSONArray();
		JSONArray flag_type =  new JSONArray();
		JSONArray phase_value =  new JSONArray();
		JSONArray distIdVal_value =  new JSONArray();
		
		
	
		
		if(box.get("mmuCity") !=null && !box.getString("mmuCity").isEmpty())
		{
			mmu_City= json.getJSONArray("mmuCity");
		}
		
		if(box.get("flagType") !=null && !box.getString("flagType").isEmpty())
		{
			flag_type= json.getJSONArray("flagType");
		}
		if(box.get("phase") !=null && !box.getString("phase").isEmpty())
		{
			phase_value= json.getJSONArray("phase");
		}
		if(box.get("distIdVal") !=null && !box.getString("distIdVal").isEmpty())
		{
			distIdVal_value= json.getJSONArray("distIdVal");
		}

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		
		String mmuCity=mmu_City.getString(0);

		
		toDate = to_date.getString(0);
		

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		flagType = flag_type.getString(0);
		if(phase_value!=null && !phase_value.isNull(0))
		{	
		phase=phase_value.getString(0);
		}
		else
		{
			phase="";
		}
		if(distIdVal_value!=null && !distIdVal_value.isNull(0))
		{	
		distIdVal=distIdVal_value.getString(0);
		}
		else
		{
			distIdVal="";
		}
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);
		parameters.put("pflag", flagType);
		parameters.put("p_phase", phase);
		parameters.put("p_distidval", distIdVal);
		



		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			HMSUtil.generateReportInPopUp("Fund_Management_Dashboard_City", "Fund_Management_Dashboard_City", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}else {
			HMSUtil.generateReportInPopUp("Fund_Management_Dashboard", "Fund_Management_Dashboard", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
			
		return null;

	}
	
	
	@RequestMapping(value = "/fundManagementOperationlDashboard", method = RequestMethod.GET)
	public ModelAndView fundManagementOperationlDashboard(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";
		String fundType="";
		String upssId="";
		String phase="";
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_City =  new JSONArray();
		JSONArray upss_id =  new JSONArray();
		JSONArray fund_type = new JSONArray();
		JSONArray phase_value = new JSONArray();
		
		
	
		
		if(box.get("mmuCity") !=null && !box.getString("mmuCity").isEmpty())
		{
			mmu_City= json.getJSONArray("mmuCity");
		}
		
		if(box.get("upss_id") !=null && !box.getString("upss_id").isEmpty())
		{
			upss_id= json.getJSONArray("upss_id");
		}
		if(box.get("fundType") !=null && !box.getString("fundType").isEmpty())
		{
			fund_type= json.getJSONArray("fundType");
		}
		if(box.get("phase") !=null && !box.getString("phase").isEmpty())
		{
			phase_value= json.getJSONArray("phase");
		}

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		
		String mmuCity=mmu_City.getString(0);

		fundType=fund_type.getString(0);
		toDate = to_date.getString(0);
		

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		upssId = upss_id.getString(0);
		if(phase_value!=null && !phase_value.isNull(0))
		{	
		phase=phase_value.getString(0);
		}
		else
		{
			phase="";
		}
		
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);		
		parameters.put("fund_type", fundType);
		parameters.put("p_phase", phase);
		
		if(mmuCity.equalsIgnoreCase("C")) {
			parameters.put("district_id", 0);
			parameters.put("city_id", Integer.valueOf(upssId));
		}else {
			parameters.put("city_id", 0);
			parameters.put("district_id", Integer.valueOf(upssId));
		}


		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			HMSUtil.generateReportInPopUp("Fund_Allocation_CITY", "Fund_Allocation_CITY", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}else {
			HMSUtil.generateReportInPopUp("Fund_Allocation_UPSS", "Fund_Allocation_UPSS", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
			
		return null;

	}
	
	@RequestMapping(value = "/fundBillReport", method = RequestMethod.GET)
	public ModelAndView fundBillReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);

		JSONArray fundAllocationHdId_id= new JSONArray();
		int captureVendorBillDetailId = 0;
		if(json.get("fundBillDetailId") !=null)
		{
			fundAllocationHdId_id = json.getJSONArray(("fundBillDetailId"));
		}
		int detail_id= Integer.parseInt(fundAllocationHdId_id.getString(0));
		
		
		

		System.out.println("fund_allocation_hd_id "+detail_id);		
		parameters.put("fund_allocation_h_id", detail_id);
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Fund_Allocation_report_hd", "Fund_Allocation_report_hd", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/fundAllocationReport", method = RequestMethod.GET)
	public ModelAndView fundAllocationReport(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		//System.out.println("json="+json);
		String phase="";
		
		
		JSONArray fundAllocationHdId_id= new JSONArray();
		JSONArray upss_id= new JSONArray();
		JSONArray phase_value =  new JSONArray();
		int captureVendorBillDetailId = 0;
		if(json.get("financialId") !=null)
		{
			fundAllocationHdId_id = json.getJSONArray(("financialId"));
		}
		int detail_id= Integer.parseInt(fundAllocationHdId_id.getString(0));
		if(box.get("phase") !=null && !box.getString("phase").isEmpty())
		{
			phase_value= json.getJSONArray("phase");
		}
		if(phase_value!=null && !phase_value.isNull(0))
		{	
		phase=phase_value.getString(0);
		}
		else
		{
			phase="";
		}
		if(box.get("upssId") !=null && !box.getString("upssId").isEmpty())
		{
			upss_id= json.getJSONArray("upssId");
		}
		String upssId=upss_id.getString(0);
    
		System.out.println("financial_id "+detail_id);		
		parameters.put("financial_id", detail_id);
		parameters.put("p_phase", phase);
		parameters.put("upss_id", Integer.valueOf(upssId));
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	   		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
	
		HMSUtil.generateReportInPopUp("Fund_Allocation_report", "Fund_Allocation_report", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		return null;

	}
	
	@RequestMapping(value = "/fundUltilizationReport", method = RequestMethod.GET)
	public ModelAndView fundUltilizationReport(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String asonDate="";
		String phase="";
		
		//String toDate="";
		
		JSONArray ason_date= new JSONArray();
		JSONArray city_id =  new JSONArray();
		JSONArray upss_id =  new JSONArray();
		JSONArray phase_value =  new JSONArray();
		
	
		
		if(box.get("cityId") !=null && !box.getString("cityId").isEmpty())
		{
			city_id= json.getJSONArray("cityId");
		}
		
		if(box.get("upssId") !=null && !box.getString("upssId").isEmpty())
		{
			upss_id= json.getJSONArray("upssId");
		}

		if(box.get("asOnDate") !=null && !box.getString("asOnDate").isEmpty())
		{
			ason_date= json.getJSONArray("asOnDate");
		}
		 if(box.get("phase") !=null && !box.getString("phase").isEmpty())
			{
				phase_value= json.getJSONArray("phase");
			}
		
			if(phase_value!=null && !phase_value.isNull(0))
			{	
			phase=phase_value.getString(0);
			}
			else
			{
				phase="";
			}

		asonDate = ason_date.getString(0);
		
		
		String cityId=city_id.getString(0);
		String upssId=upss_id.getString(0);
	   
		Date cd_from= new Date();
		//Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(asonDate);
			//cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
		parameters.put("Asondate", cd_from);
		parameters.put("City_id",Integer.valueOf(cityId) );
		parameters.put("District_id", Integer.valueOf(upssId));
		parameters.put("p_phase", phase);

		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		connectionMap = reportDao.getConnectionForReportMis();
		//System.out.println(cd_from+cityId+upssId+"phase="+phase);
		
	    HMSUtil.generateReportInPopUp("Utilization_Certificate", "Utilization_Certificate", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		
		return null;

	}

	@RequestMapping(value = "/medicineInvoiceDashboardReportIEC", method = RequestMethod.GET)
	public ModelAndView medicineInvoiceDashboardReportIEC(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();

		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);

		String fromDate="";
		String toDate="";
		String phase="";
	
		
		JSONArray from_date= new JSONArray();
		JSONArray to_date= new JSONArray();
		JSONArray mmu_City =  new JSONArray();
		JSONArray upss_id =  new JSONArray();
		JSONArray phase_value =  new JSONArray();
		
	
		
		if(box.get("mmuCity") !=null && !box.getString("mmuCity").isEmpty())
		{
			mmu_City= json.getJSONArray("mmuCity");
		}
		
		if(box.get("upss_id") !=null && !box.getString("upss_id").isEmpty())
		{
			upss_id= json.getJSONArray("upss_id");
		}

		if(box.get("fromDate") !=null && !box.getString("fromDate").isEmpty())
		{
			from_date= json.getJSONArray("fromDate");
		}

		fromDate = from_date.getString(0);
		if(box.get("toDate") !=null && !box.getString("toDate").isEmpty())
		{
			to_date= json.getJSONArray("toDate");
		}
		if(box.get("phase") !=null && !box.getString("phase").isEmpty())
		{
			phase_value= json.getJSONArray("phase");
		}
		String mmuCity=mmu_City.getString(0);
		String upssId=upss_id.getString(0);
		if(phase_value!=null && !phase_value.isNull(0))
		{	
		phase=phase_value.getString(0);
		}
		else
		{
			phase="";
		}
		toDate = to_date.getString(0);
		

		Date cd_from= new Date();
		Date cd_to= new Date();
		try {
			cd_from = HMSUtil.convertStringTypeDateToDateType(fromDate);
			cd_to = HMSUtil.convertStringTypeDateToDateType(toDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		parameters.put("From_Date", cd_from);
		parameters.put("To_Date", cd_to);
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			parameters.put("city_id", Integer.valueOf(upssId));
			//parameters.put("district_id", 0);
		}else {
			parameters.put("district_id", Integer.valueOf(upssId));
		}
		parameters.put("p_phase", phase);


		String userHome = request.getServletContext().getRealPath("/resources/images/");
		
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
		connectionMap = reportDao.getConnectionForReportMis();
		if(mmuCity!=null && mmuCity.equalsIgnoreCase("C")) {
			HMSUtil.generateReportInPopUp("IEC_invoice_CITY", "IEC_invoice_CITY", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}else {
			HMSUtil.generateReportInPopUp("IEC_invoice_UPSS", "IEC_invoice_UPSS", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		return null;

	}
	
	@RequestMapping(value = "/printPenaltyRegisterList", method = RequestMethod.GET)
	public ModelAndView printPenaltyRegisterList(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> connectionMap = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		Box box= HMSUtil.getBox(request);
		JSONObject json = new JSONObject(box);
		
		
		String fromdate="";
		String todate="";
		Date startDate = null;
		Date endDate=null;
		JSONArray mmu_id= new JSONArray();
		
		JSONArray User_id= new JSONArray();
		JSONArray Level_of_user= new JSONArray();
		JSONArray Search_Type= new JSONArray();
		
		
		JSONArray month= new JSONArray();
		JSONArray year= new JSONArray();
		if(json.get("attnMonth") !=null)
		{
			month = json.getJSONArray(("attnMonth"));
			year= json.getJSONArray(("attnYear"));
			
			int int_month=Integer.parseInt(month.getString(0));
			int int_year=Integer.parseInt(year.getString(0));
			 startDate = HMSUtil.getStartDate(int_year, int_month);
			 endDate = HMSUtil.getEndDate(int_year, int_month);
		}
		
		
		if(json.get("User_id") !=null)
		{
			User_id = json.getJSONArray(("User_id"));
		}
		int int_User_id= Integer.parseInt(User_id.getString(0));
		
		if(json.get("Level_of_user") !=null)
		{
			Level_of_user = json.getJSONArray("Level_of_user");
		}
		String str_Level_of_user= Level_of_user.getString(0);
		
		if(json.get("mmu_id") !=null)
		{
			mmu_id = json.getJSONArray(("mmu_id"));
		}
		int int_mmu_id= Integer.parseInt(mmu_id.getString(0));
		String searchType = null;	
		if(json.get("searchType") !=null)
		{
			Search_Type = json.getJSONArray(("searchType"));
			searchType=Search_Type.getString(0);
		}
		
		
		parameters.put("From_Date", startDate);
		   System.out.println("TO_DATE and from_date :"+startDate+"::"+endDate);
		parameters.put("To_Date", endDate);
		
		String userHome = request.getServletContext().getRealPath("/resources/images/");
		String imagePath = userHome+"/mmu-logo.png";
	    parameters.put("path", imagePath);
	    parameters.put("User_id", int_User_id);
		parameters.put("Level_of_user", str_Level_of_user);
		parameters.put("MMU_ID", int_mmu_id);
		
		parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));
		
		//System.out.println(request.getServletContext().getRealPath("/reports/"));

		connectionMap = reportDao.getConnectionForReportMis();
		if(searchType.equals("E")) {
		HMSUtil.generateReportInPopUp("Penalty_Register_Equipment", "Equipment Penalty Register", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}else if(searchType.equals("I")){
			HMSUtil.generateReportInPopUp("Penalty_Register_Inspection", "Inspection Penalty Register", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}else {
			HMSUtil.generateReportInPopUp("Penalty_Register_Attendance", "Attendance Penalty Register", parameters, (Connection)connectionMap.get("conn"), response, request.getSession().getServletContext());
		}
		return null;
	
	}	
	

}
