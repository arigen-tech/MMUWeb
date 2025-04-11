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
import org.json.JSONArray;
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



@RequestMapping("/miAdmin")
@RestController
@CrossOrigin
public class MIAdminWebController {
String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT").trim();

//------------------------Create --------------------------------//	
	@RequestMapping(value = "/permanentStoreLedger", method = RequestMethod.GET)
	public ModelAndView permanentStoreLedger(HttpServletRequest request,	HttpServletResponse response,Model model) {
		//System.out.println("permanentStoreLedger called");
		String jsp = "permStoreLedger";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	//Disposal Type Report
	@RequestMapping(value="/disposalTypeReport", method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView budgetaryApprovalList(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
		
		return new ModelAndView("disposalTypeReport");
	}
	
	@RequestMapping(value = "/getDisposalTypeReportList", method = RequestMethod.POST)
	public String getBudgetaryApprovalList(@RequestBody Map<String, Object> payload,
			HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
	String disposalTypeList="";
	JSONObject json = new JSONObject(payload);
	json.put("userId", session.getAttribute("user_id"));
	json.put("hospitalId", session.getAttribute("hospital_id"));
	json.put("departmentId",session.getAttribute("department_id"));
	//System.out.println("inside getDisposalTypeReportList--"+json);
	MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
	String Url=HMSUtil.getProperties("urlextension.properties","getDisposalTypeList");
	String OSBURL = IpAndPortNo + Url;
  disposalTypeList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
	
  //disposalTypeList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getDisposalTypeList",requestHeaders, json.toString());
			
	return  disposalTypeList;
	}
	
	//ATT 'C' Type Report
		@RequestMapping(value="/attcTypeReport", method = {RequestMethod.POST,RequestMethod.GET})
		public ModelAndView attcTypeReport(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
			     MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
				 String Url1 =HMSUtil.getProperties("urlextension.properties","miAdmindisposalList");
				 String OSBURL1 = IpAndPortNo + Url1; 
				 String data1="{}";
				 String disposalList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders1,data1);
				 //String disposalList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/disposalList",requestHeaders1, data1); 
				 
				 model.addAttribute("masEmployeeCategoryList", disposalList);
			
				 return new ModelAndView("attCTypeReport");
		}
		
		@RequestMapping(value = "/getAttCTypeReportList", method = RequestMethod.POST)
		public String getAttCTypeReportList(@RequestBody Map<String, Object> payload,
				HttpServletRequest request, HttpServletResponse response,HttpSession session) {
			
		String attCTypeReportList="";
		JSONObject json = new JSONObject(payload);
		json.put("userId", session.getAttribute("user_id"));
		json.put("hospitalId", session.getAttribute("hospital_id"));
		json.put("departmentId",session.getAttribute("department_id"));
		//System.out.println("inside getAttCTypeReportList--"+json);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url=HMSUtil.getProperties("urlextension.properties","getAttCTypeReportList");
		String OSBURL = IpAndPortNo + Url;
		attCTypeReportList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
		
		//attCTypeReportList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getAttCTypeReportList",requestHeaders, json.toString());
				
		return  attCTypeReportList;
		}
		
		//AME Report for sailor/officer
				@RequestMapping(value="/ameReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView ameReportOpen(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					    
					     MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
					     MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
						 String Url1 =HMSUtil.getProperties("urlextension.properties","getEmployeeCategory");
						 String OSBURL1 = IpAndPortNo + Url1; 
						 String data1="{}";
				         String masEmployeeCategoryList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders,data1);
				
				         // String masEmployeeCategoryList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEmployeeCategory",requestHeaders, data1); 
						 String Url =HMSUtil.getProperties("urlextension.properties","getMedCategory");
						 String OSBURL = IpAndPortNo + Url; 
						 String medCategoryList=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders1,data1);
							
						 //String medCategoryList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getMedCategory",requestHeaders1, data1); 
						 model.addAttribute("medCategoryList", medCategoryList);
						 model.addAttribute("masEmployeeCategoryList", masEmployeeCategoryList);
							
					return new ModelAndView("ameReport");
				}
				
				@RequestMapping(value = "/getAmeReportList", method = RequestMethod.POST)
				public String getAmeTypeReportList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String ameReportList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getAmeReportList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getAmeReportList");
				String OSBURL = IpAndPortNo + Url;
				ameReportList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//ameReportList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getAmeReportList",requestHeaders, json.toString());
						
				return  ameReportList;
				}
				
				
				//Medical Statistics
				@RequestMapping(value="/masMedicalStatisticsReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView openMasMedicalStatistics(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					
					return new ModelAndView("medicalExamStatistics");
				}
				
				@RequestMapping(value = "/getMasMedicalStatistics", method = RequestMethod.POST)
				public String getMasMedicalStatistics(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String masMedicalStatistics="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getMasMedicalStatistics--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getMasMedicalStatistics");
				String OSBURL = IpAndPortNo + Url;
				masMedicalStatistics = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//masMedicalStatistics = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getMasMedicalStatistics",requestHeaders, json.toString());
						
				return  masMedicalStatistics;
				}
				
				
				//Blood group Entry Register
				@RequestMapping(value = "/createBloodGroupRegister", method = RequestMethod.GET)
				public ModelAndView createBloodGroupRegister(HttpServletRequest request,	HttpServletResponse response,Model model) {
					//System.out.println("createBloodGroupRegister called");
					String jsp = "bloodGroupEntryRegister";
					//Get Blood group
					 MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					 String data1="{}";
					   
				     String Url1 =HMSUtil.getProperties("urlextension.properties","getBloodGroup");
					 String OSBURL1 = IpAndPortNo + Url1; 
					 String bloodGroupList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders,data1);
			         //String bloodGroupList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getBloodGroup",requestHeaders1, data1); 
					  model.addAttribute("bloodGroupList", bloodGroupList);
					  
					     MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
						 String Url =HMSUtil.getProperties("urlextension.properties","miAdmingetRankList");
						 String OSBURL = IpAndPortNo + Url; 
						 String rankList=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders1,data1);
				         //String rankList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getRankList",requestHeaders1, data1); 
						 model.addAttribute("rankList", rankList);
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}


				//getEmpDetails
				@RequestMapping(value="/getEmpDetails", method = {RequestMethod.POST})
				public String getEmpDetails(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					String jsonResponse = "";
					JSONObject json = new JSONObject(requestObject);
					json.put("userId", session.getAttribute("user_id"));
					json.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("inside getEmpDetails--"+requestObject);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","miAdmingetEmpDetails");
					String OSBURL = IpAndPortNo + Url;
					jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
					
					//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEmpDetails",requestHeaders,json.toString());
				   return jsonResponse;
					
				}
				//submit form
				
				@RequestMapping(value = "/submitBloodGroupRegister", method = RequestMethod.POST)
				public ModelAndView submitBloodGroupRegister(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("submitBloodGroupRegister--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","miAdminsubmitBloodGroupRegister");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitBloodGroupRegister",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printSanitaryDairy";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("bgId",responsedata.get("bloodGroupRegisterId"));
					model.addAttribute("flag","bloodGroupRegister");
					mv.setViewName(jsp);
					return mv;

				}
				//Blood Group Report
				@RequestMapping(value="/bloodGroupReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView bloodGroupOpen(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					    
					     MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
					     MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					     String data1="{}";
					     //Get Blood group
					     String Url1 =HMSUtil.getProperties("urlextension.properties","getBloodGroup");
						 String OSBURL1 = IpAndPortNo + Url1; 
						 String bloodGroupList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders,data1);
				         //String bloodGroupList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getBloodGroup",requestHeaders1, data1); 
						
				         //Get UnitList
				         String Url =HMSUtil.getProperties("urlextension.properties","miAdmingetUnitList");
						 String OSBURL = IpAndPortNo + Url; 
						 String unitList=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders1,data1);
				         //String unitList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getUnitList",requestHeaders1, data1); 
						
				         model.addAttribute("unitList", unitList);
				         model.addAttribute("bloodGroupList", bloodGroupList);
						
					return new ModelAndView("bloodGroupRegister");
				}
				
				@RequestMapping(value = "/getBloodGroupRegister", method = RequestMethod.POST)
				public String getBloodGroupRegister(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String bloodGroupRegister="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getBloodGroupRegister--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getBloodGroupRegister");
				String OSBURL = IpAndPortNo + Url;
				bloodGroupRegister = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//bloodGroupRegister = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getBloodGroupRegister",requestHeaders, json.toString());
						
				return  bloodGroupRegister;
				}
				//Sanitary diary register
				@RequestMapping(value = "/createSanitaryDiary", method = RequestMethod.GET)
				public ModelAndView createSanitaryDiary(HttpServletRequest request,	HttpServletResponse response,Model model) {
					//System.out.println("createSanitaryDiary called");
					String jsp = "sanitaryDetails";
					ModelAndView mv =new ModelAndView();
					String data="{}"; 
					 MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
					 String Url1 =HMSUtil.getProperties("urlextension.properties","HOSPITAL_LIST");
					 String OSBURL1 = IpAndPortNo + Url1; 
					 String hospitalList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders1,data);
					 
					
				    //String hospitalList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/appointment/getHospitalList", requestHeaders, data); 
					model.addAttribute("hospitalList", hospitalList);
					mv.setViewName(jsp);
					return mv;
				}

				
				//submit form
				
				@RequestMapping(value = "/submitSanitaryDiary", method = RequestMethod.POST)
				public ModelAndView submitBudgetaryApproval(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitSanitaryDiary--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitSanitaryDiary");
					 String OSBURL = IpAndPortNo + Url;
					 String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					// String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitSanitaryDiary",requestHeaders, obj.toString());
					 JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printSanitaryDairy";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("sanitaryId",responsedata.get("sanitaryId"));
					model.addAttribute("flag","sanitary");
					mv.setViewName(jsp);
					return mv;

				}
				
				//Sanitary Diary Report
				@RequestMapping(value="/sanitoryDiaryReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView sanitoryDiaryReport(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("sanitaryDiaryReport");
				}
				
				@RequestMapping(value = "/getSanitaryReportList", method = RequestMethod.POST)
				public String getSanitaryReportList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String sanitaryReportList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getSanitaryReportList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getSanitaryReportList");
				String OSBURL = IpAndPortNo + Url;
				sanitaryReportList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//sanitaryReportList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getSanitaryReportList",requestHeaders, json.toString());
						
				return  sanitaryReportList;
				}
				
				//Injury Report Register
				@RequestMapping(value = "/createInjuryRegister", method = RequestMethod.GET)
				public ModelAndView createInjuryRegister(HttpServletRequest request,	HttpServletResponse response,Model model) {
					//System.out.println("createInjuryRegister called");
					String jsp = "injuryRegister";
					String data1="{}"; 
					 MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
					 String Url =HMSUtil.getProperties("urlextension.properties","miAdmingetRankList");
					 String OSBURL = IpAndPortNo + Url; 
					 String rankList=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders1,data1);
			         //String rankList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getRankList",requestHeaders1, data1); 
					
					// GET GENDER LIST
						MultiValueMap<String, String> requestHeaders2 = new LinkedMultiValueMap<String, String>();
						String Url2 = HMSUtil.getProperties("urlextension.properties", "GENDER_LIST");
						String OSBURL2 = IpAndPortNo + Url2;
						String genderList = RestUtils.postWithHeaders(OSBURL2.trim(), requestHeaders2, data1);

						
						// String genderList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/appointment/getGenderList",requestHeaders2, data);
						model.addAttribute("genderList", genderList);
					 model.addAttribute("rankList", rankList);
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}

				
				//submit form
				
				@RequestMapping(value = "/submitInjuryRegister", method = RequestMethod.POST)
				public ModelAndView submitInjuryRegister(MultipartHttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitInjuryRegister--"+obj);
					
					//File upload code
					int year = Calendar.getInstance().get(Calendar.YEAR);
					String ridcIdValues = "";
					String fileNameValue = "";
					String rmsAllValue = "";
					Iterator<String> itr = request.getFileNames();
					Integer ridcIdVv = 1;
					String ridcId ="";
					String letter="";
					String report="";
					//int docType = RIDCUtils.DOC_TYPE_OTHER;
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
							JSONArray serviceNoArr= new JSONArray();
							if(obj.get("serviceNo") !=null)
							{
								serviceNoArr = obj.getJSONArray(("serviceNo"));
							}
							String serviceNo =serviceNoArr.getString(0).trim();
							HashMap<String,String> info=new HashMap<String,String>();
							
							info.put("serviceNo", serviceNo);
							info.put("year", String.valueOf(year));
							//info.put("docType", String.valueOf(docType));
							info.put("type", "1");
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
								 // ridcDoc = RIDCUtils.getRidcEntityByValueMB(inputStream, myFileName, size, contentType,info);
								ridcDoc = PatientRegistrationWebController.getRidcEntityByValueMB(inputStream, convFile, size, contentType,info);
								ridcId = PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
								    ridcIdValues += "" + ridcId + ",";
									fileNameValue += "" + myFileName + ",";
									rmsAllValue += "" + ridcId + ",";
							}
							if(name.equalsIgnoreCase("fileInvUploadDyna") && StringUtils.isNotEmpty(myFileName))
							{
								report="report";
							}
							if(name.equalsIgnoreCase("fileInvUploadDynaletter") && StringUtils.isNotEmpty(myFileName))
							{
								letter="letter";
							}
						}
						} catch (Exception e) {
							JSONObject json = new JSONObject();
							e.printStackTrace();
						}
					obj.put("fileNameValue",fileNameValue);
					obj.put("ridcId",ridcIdValues);
					obj.put("report",report);
					obj.put("letter",letter);
					
					//End file upload
					
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitInjuryRegister");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitInjuryRegister",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printSanitaryDairy";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("injuryId",responsedata.get("injuryId"));
					model.addAttribute("flag","injury");
					mv.setViewName(jsp);
					return mv;

				}
				
				
				@RequestMapping(value="/injuryRegisterReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView injuryRegisterReport(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("injuryReport");
				}
				
				@RequestMapping(value = "/getInjuryRegisterList", method = RequestMethod.POST)
				public String getInjuryRegisterList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String injuryReportList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getInjuryRegisterList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getInjuryReportList");
				String OSBURL = IpAndPortNo + Url;
				injuryReportList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//injuryReportList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getInjuryReportList",requestHeaders, json.toString());
						
				return  injuryReportList;
				}
				
				//getPatientDetails
				@RequestMapping(value="/getPatientDetails", method = {RequestMethod.POST})
				public String getPatientDetails(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					String jsonResponse = "";
					JSONObject json = new JSONObject(requestObject);
					json.put("userId", session.getAttribute("user_id"));
					json.put("hospitalId", session.getAttribute("hospital_id"));
					
					//System.out.println("inside getPatientDetails--"+requestObject);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","getMIAdminPatientDetails");
					String OSBURL = IpAndPortNo + Url;
					jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
					
					//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getPatientDetails",requestHeaders,json.toString());
				   return jsonResponse;
					
				}
				//Hospital visit Register
				@RequestMapping(value = "/createHospitalVisitRegister", method = RequestMethod.GET)
				public ModelAndView createHospitalVisitRegister(HttpServletRequest request,	HttpServletResponse response,Model model) {
					//System.out.println("createHospitalVisitRegister called");
					String data1="{}"; 
					 MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
					 String Url =HMSUtil.getProperties("urlextension.properties","miAdmingetRankList");
					 String OSBURL = IpAndPortNo + Url; 
					 String rankList=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders1,data1);
			         //String rankList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getRankList",requestHeaders1, data1); 
					
					// GET GENDER LIST
						MultiValueMap<String, String> requestHeaders2 = new LinkedMultiValueMap<String, String>();
						String Url2 = HMSUtil.getProperties("urlextension.properties", "GENDER_LIST");
						String OSBURL2 = IpAndPortNo + Url2;
						String genderList = RestUtils.postWithHeaders(OSBURL2.trim(), requestHeaders2, data1);

						
						// String genderList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/appointment/getGenderList",requestHeaders2, data);
						model.addAttribute("genderList", genderList);
					    model.addAttribute("rankList", rankList);
					String jsp = "hospitalVisitRegister";
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}

				
				//submit form
				
				@RequestMapping(value = "/submitHospitalVisitRegister", method = RequestMethod.POST)
				public ModelAndView submitHospitalVisitRegister(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitHospitalVisitRegister--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitHospitalVisitRegister");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitHospitalVisitRegister",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printSanitaryDairy";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("hVisitId",responsedata.get("hospitalVisitId"));
					model.addAttribute("flag","hospitalRegister");
					mv.setViewName(jsp);
					return mv;

				}

				@RequestMapping(value="/hospitalVisitReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView hospitalVisitReport(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("hospitalVisitReport");
				}
				
				@RequestMapping(value = "/getHospitalVisitList", method = RequestMethod.POST)
				public String getHospitalVisitList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String hospitalVisitList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getInjuryRegisterList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getHospitalVisitList");
				String OSBURL = IpAndPortNo + Url;
				hospitalVisitList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//hospitalVisitList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getHospitalVisitList",requestHeaders, json.toString());
						
				return  hospitalVisitList;
				}
				
				//HIV/STD Register
				@RequestMapping(value = "/createHIvStdRegister", method = RequestMethod.GET)
				public ModelAndView createHIvStdRegister(HttpServletRequest request,	HttpServletResponse response,Model model) {
					//System.out.println("createHIvStdRegister called");
					MultiValueMap<String, String> requestHeaders1 = new LinkedMultiValueMap<String, String>();
					String data1="{}";
					 String Url =HMSUtil.getProperties("urlextension.properties","getMedCategory");
					 String OSBURL = IpAndPortNo + Url; 
					 String medCategoryList=RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders1,data1);
					 //String medCategoryList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getMedCategory",requestHeaders1, data1); 
					 String data="{}"; 
					 MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					 String Url1 =HMSUtil.getProperties("urlextension.properties","miAdmingetRankList");
					 String OSBURL1 = IpAndPortNo + Url1; 
					 String rankList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders,data);
			         //String rankList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getRankList",requestHeaders1, data1); 
					
					// GET GENDER LIST
						MultiValueMap<String, String> requestHeaders2 = new LinkedMultiValueMap<String, String>();
						String Url2 = HMSUtil.getProperties("urlextension.properties", "GENDER_LIST");
						String OSBURL2 = IpAndPortNo + Url2;
						String genderList = RestUtils.postWithHeaders(OSBURL2.trim(), requestHeaders2, data1);

						
						// String genderList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/appointment/getGenderList",requestHeaders2, data);
						model.addAttribute("genderList", genderList);
					 model.addAttribute("rankList", rankList);
					 model.addAttribute("medCategoryList", medCategoryList);
					
					String jsp = "hivStdRegister";
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}

				
				//submit form
				
				@RequestMapping(value = "/submitHivStdRegister", method = RequestMethod.POST)
				public ModelAndView submitHivStdRegister(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitHivStdRegister--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitHivStdRegister");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitHivStdRegister",requestHeaders, obj.toString());
					 JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printSanitaryDairy";
					model.addAttribute("message", responsedata.get("msg"));
					//model.addAttribute("hivId",responsedata.get("hivId"));
					model.addAttribute("flag","hivRegister");
					mv.setViewName(jsp);
					return mv;

				}
				@RequestMapping(value="/hivStdReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView hivStdReport(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("hivStdReport");
				}
				
				@RequestMapping(value = "/getHivStdList", method = RequestMethod.POST)
				public String getHivStdList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String hivStdList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getHivStdList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getHivStdList");
				String OSBURL = IpAndPortNo + Url;
				hivStdList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//hivStdList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getHivStdList",requestHeaders, json.toString());
						
				return  hivStdList;
				}
				
				//MILK Testing  Register
				@RequestMapping(value = "/createMilkTesting", method = RequestMethod.GET)
				public ModelAndView createMilkTesting(HttpServletRequest request,	HttpServletResponse response,Model model,HttpSession session) {
					//System.out.println("createMilkTesting called");
					JSONObject obj = new JSONObject();
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					
					 MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					 String Url1 =HMSUtil.getProperties("urlextension.properties","getEmpList");
					 String OSBURL1 = IpAndPortNo + Url1; 
					 String empList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders,obj.toString());
					 
					
				    //String empList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEmpList", requestHeaders, obj.toString()); 
					model.addAttribute("empList", empList);
				
					String jsp = "milkTesting";
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}

				
				//submit form
				
				@RequestMapping(value = "/submitMilkTesting", method = RequestMethod.POST)
				public ModelAndView submitMilkTesting(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitMilkTesting--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitMilkTesting");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
				    //String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitMilkTesting",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printSanitaryDairy";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("mId",responsedata.get("mId"));
					model.addAttribute("flag","milkTesting");
					mv.setViewName(jsp);
					return mv;

				}
				//Milk Testing Report
				@RequestMapping(value="/milkTestingReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView milkTestingReport(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("milkTestingReport");
				}
				
				@RequestMapping(value = "/getMilkTestingList", method = RequestMethod.POST)
				public String getMilkTestingList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String milkTestingList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getMilkTestingList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getMilkTestingList");
				String OSBURL = IpAndPortNo + Url;
				milkTestingList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//milkTestingList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getMilkTestingList",requestHeaders, json.toString());
						
				return  milkTestingList;
				}
				
				//Water Testing  Register
				@RequestMapping(value = "/createWaterTesting", method = RequestMethod.GET)
				public ModelAndView createWaterTesting(HttpServletRequest request,	HttpServletResponse response,Model model,HttpSession session) {
					//System.out.println("createWaterTesting called");
					JSONObject obj = new JSONObject();
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					
					 MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					 String Url1 =HMSUtil.getProperties("urlextension.properties","getEmpList");
					 String OSBURL1 = IpAndPortNo + Url1; 
					 String empList=RestUtils.postWithHeaders(OSBURL1.trim(), requestHeaders,obj.toString());
				    //String empList =RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEmpList", requestHeaders, obj.toString()); 
					model.addAttribute("empList", empList);
					String jsp = "waterTesting";
					ModelAndView mv =new ModelAndView();
					mv.setViewName(jsp);
					return mv;
				}

				
				//submit form
				
				@RequestMapping(value = "/submitWaterTesting", method = RequestMethod.POST)
				public ModelAndView submitWaterTesting(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					obj.put("departmentId",session.getAttribute("department_id"));
					//System.out.println("submitMilkTesting--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitWaterTesting");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
				   // String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitWaterTesting",requestHeaders, obj.toString());
					 JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "printSanitaryDairy";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("wId",responsedata.get("wId"));
					model.addAttribute("flag","waterTesting");
					mv.setViewName(jsp);
					return mv;

				}
				//Milk Testing Report
				@RequestMapping(value="/waterTestingReport", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView waterTestingReport(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("waterTestingReport");
				}
				
				@RequestMapping(value = "/getWaterTestingList", method = RequestMethod.POST)
				public String getWaterTestingList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String waterTestingList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				json.put("departmentId",session.getAttribute("department_id"));
				//System.out.println("inside getMilkTestingList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","getWaterTestingList");
				String OSBURL = IpAndPortNo + Url;
				waterTestingList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//waterTestingList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getWaterTestingList",requestHeaders, json.toString());
						
				return  waterTestingList;
				}
			//Dangerous Drug Register	
				@RequestMapping(value="/dangerousDrugRegister", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView dangerousDrugRegister(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("dangerousDrugRegister");
				}
				
				@RequestMapping(value = "/getdangerousDrugRegisterList", method = RequestMethod.POST)
				public String getdangerousDrugRegisterList(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					
				String dangerousDrugRegisterList="";
				JSONObject json = new JSONObject(payload);
				json.put("userId", session.getAttribute("user_id"));
				json.put("hospitalId", session.getAttribute("hospital_id"));
				//System.out.println("inside getdangerousDrugRegisterList--"+json);
				MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url=HMSUtil.getProperties("urlextension.properties","dangerousDrugRegisterList");
				String OSBURL = IpAndPortNo + Url;
				dangerousDrugRegisterList = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
				
				//dangerousDrugRegisterList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/dangerousDrugRegisterList",requestHeaders, json.toString());
						
				return  dangerousDrugRegisterList;
				}
				//EXPENDABLE LEDGER
				@RequestMapping(value="/expendableLedger", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView expendableLedger(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("expendableLedger1227");
				}
				
				
				//Local Purchase Store Ledger
				@RequestMapping(value="/localPurchaseStoreLedger", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView localPurchaseStoreLedger(HttpServletRequest request,Model model,HttpServletResponse response,HttpSession session) {
					       
					return new ModelAndView("localPurchaseStoreLedger");
				}
				
				//------------------------Capture Equipment Details--------------------------------//	
				@RequestMapping(value = "/captureEquipmentDetails", method = RequestMethod.GET)
				public ModelAndView captureEquipmentDetails(HttpServletRequest request,	HttpServletResponse response,Model model,HttpSession session) {
					//System.out.println("captureEquipmentDetails called");
					String jsp = "equipmentDetails";
					MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					
					 String Url = HMSUtil.getProperties("urlextension.properties","getDepartmentListBasedOnDepartmentType");		
					 String OSBURL = IpAndPortNo + Url;
					 String data="{}"; 
					 String departmentList =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,data);
					
				    //String departmentList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/appointment/recordsforAppointmentSetUp", requestHeaders, data); 
					 MultiValueMap<String,String> requestHeaders1 = new LinkedMultiValueMap<String,String>();
					 JSONObject obj = new JSONObject();
					 obj.put("hospitalId", session.getAttribute("hospital_id"));
					
					 String Url1 = HMSUtil.getProperties("urlextension.properties","getManufactureList");		
					 String OSBURL1 = IpAndPortNo + Url1;
					 String manufactureList =RestUtils.postWithHeaders(OSBURL1.trim(),requestHeaders1,obj.toString());
							
					 //String manufactureList = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getManufactureList", requestHeaders1, obj.toString()); 
					 ModelAndView mv =new ModelAndView();
					 model.addAttribute("departmentList", departmentList);
					 model.addAttribute("manufacturerList", manufactureList);
					
					mv.setViewName(jsp);
					return mv;
				}
				
				
				@RequestMapping(value = "/submitEquipmentDetails", method = RequestMethod.POST)
				public ModelAndView submitEquipmentDetails(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("submitEquipmentDetails--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitEquipmentDetails");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitEquipmentDetails",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "saveEquipmentDetails";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("eqMId",responsedata.get("eqMId"));
					model.addAttribute("flag","save");
					mv.setViewName(jsp);
					return mv;

				}
				
				@RequestMapping(value="/updateEquipmentDetails", method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView updateEquipmentDetails(HttpServletRequest request,Model model,HttpServletResponse response) {
					String jsp = "viewUpdateEquipmentdetails";
					//System.out.println("inside updateEquipmentDetails--");
				    MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String,String>();
					String data="{}"; 
					String Url = HMSUtil.getProperties("urlextension.properties","getDepartmentListBasedOnDepartmentType");		
				    String OSBURL = IpAndPortNo + Url;
				    String departmentList =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,data);
					
					ModelAndView mv =new ModelAndView();
					model.addAttribute("departmentList", departmentList);
					mv.setViewName(jsp);
					return mv;
				}
				
				@RequestMapping(value="/getEquipmentDetails", method = {RequestMethod.POST,RequestMethod.GET})
				public String getEquipmentDetails(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
				     String getEquipmentDetails="";
					JSONObject json = new JSONObject(payload);
					json.put("userId", session.getAttribute("user_id"));
				//  json.put("hospitalId", session.getAttribute("hospital_id")); // hiding for adding unit drop down for PDMS
					json.put("hospitalId",json.getInt("unitId"));
					//System.out.println("inside getEquipmentDetails--"+json);
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","getEquipmentDetails");
					String OSBURL = IpAndPortNo + Url;
					getEquipmentDetails = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
					
					//getEquipmentDetails = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEquipmentDetails",requestHeaders, json.toString());
							
					return  getEquipmentDetails;
				}
				
				@RequestMapping(value = "/submitWarrantydetails", method = RequestMethod.POST)
				public String submitWarrantydetails(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("submitWarrantydetails--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitWarrantydetails");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitWarrantydetails",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					String msg = responsedata.get("msg").toString();
					
					return responsedata.toString();

				}
				
				@RequestMapping(value = "/submitAccessarydetails", method = RequestMethod.POST)
				public String submitAccessarydetails(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("submitAccessarydetails--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitAccessarydetails");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitAccessarydetails",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
				    String msg = responsedata.get("msg").toString();
					
					return responsedata.toString();

				}		
				
				
				@RequestMapping(value="/getEquipmentDetailsByItemId", method = {RequestMethod.POST})
				public String getEquipmentDetailsByItemId(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					String jsonResponse = "";
					JSONObject obj = new JSONObject(requestObject);
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("inside getEquipmentDetailsByItemId--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","getEquipmentDetailsByItemId");
					String OSBURL = IpAndPortNo + Url;
					jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					
					//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEquipmentDetailsByItemId",requestHeaders,obj.toString());
				    return jsonResponse;
					
				}
				
				@RequestMapping(value="/getEquipmentReportList", method = {RequestMethod.POST})
				public String getEquipmentReportList(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
					String jsonResponse = "";
					JSONObject obj = new JSONObject(requestObject);
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("inside getEquipmentReportList--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","getEquipmentReportList");
					String OSBURL = IpAndPortNo + Url;
					jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					
					//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEquipmentReportList",requestHeaders,obj.toString());
				    return jsonResponse;
					
				}
				
				@RequestMapping(value="/getEquipmentDetailsForstoreLedger", method = {RequestMethod.POST,RequestMethod.GET})
				public String getEquipmentDetailsForstoreLedger(@RequestBody Map<String, Object> payload,
						HttpServletRequest request, HttpServletResponse response,HttpSession session) {
				     String getEquipmentDetails="";
					JSONObject json = new JSONObject(payload);
					json.put("userId", session.getAttribute("user_id"));
					json.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("inside getEquipmentDetailsForstoreLedger--"+json);
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","getEquipmentDetailsForstoreLedger");
					String OSBURL = IpAndPortNo + Url;
					getEquipmentDetails = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,json.toString());
					
					//getEquipmentDetails = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getEquipmentDetailsForstoreLedger",requestHeaders, json.toString());
							
					return  getEquipmentDetails;
				}
				
				@RequestMapping(value = "/submitBoardOutDetails", method = RequestMethod.POST)
				public String submitBoardOutDetails(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("submitBoardOutDetails--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitBoardOutDetails");
					String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitBoardOutDetails",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
				    String msg = responsedata.get("msg").toString();
					
					return responsedata.toString();

				}	
				
				
				@RequestMapping(value = "/submitAuditDetails", method = RequestMethod.POST)
				public ModelAndView submitAuditDetails(HttpServletRequest request, HttpServletResponse response,HttpSession session,Model model) {
					
					Box box = HMSUtil.getBox(request);
					JSONObject obj = new JSONObject(box);
					obj.put("userId", session.getAttribute("user_id"));
					obj.put("hospitalId", session.getAttribute("hospital_id"));
					//System.out.println("submitAuditDetails--"+obj);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
				    String Url = HMSUtil.getProperties("urlextension.properties","submitAuditDetails");
			        String OSBURL = IpAndPortNo + Url;
					String responseData =RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,obj.toString());
					//String responseData = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/submitAuditDetails",requestHeaders, obj.toString());
					JSONObject responsedata = new JSONObject(responseData);
					ModelAndView mv = new ModelAndView();
					String jsp = "submitAuditDetails";
					model.addAttribute("message", responsedata.get("msg"));
					model.addAttribute("flag","save");
					mv.setViewName(jsp);
					return mv;
				}
				
				
				//getMedicalCategory
				@RequestMapping(value="/getMedicalCategory", method = {RequestMethod.POST})
				public String getMedicalCategory(@RequestBody String requestObject,HttpServletRequest request, HttpServletResponse response) {
					String jsonResponse = "";
					//JSONObject json = new JSONObject(requestObject);
					//System.out.println("inside getMedicalCategory--"+requestObject);
					
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","miAdmingetMedicalCategoryList");
					String OSBURL = IpAndPortNo + Url;
					jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,requestObject);
					
					//jsonResponse=RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getMedicalCategory",requestHeaders,requestObject);
				   return jsonResponse;
					
				}
				
				
				@RequestMapping(value = "/getDetailsForHospitalRegister",  method = {RequestMethod.POST,RequestMethod.GET})
				public ModelAndView getDetailsForHospitalRegister(HttpServletRequest request,Model model,HttpServletResponse response) {
					int hospitalVisitId = Integer.parseInt(request.getParameter("hospitalVisitId"));
					String jsp = "showDetailsOfHospitalVisitRegister";
					String payload = "{\"hospitalVisitId\":" + hospitalVisitId + "}";
					//System.out.println("inside getDetailsForHospitalRegister--"+payload);
					MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
					String Url=HMSUtil.getProperties("urlextension.properties","getDetailsForHospitalRegister");
					String OSBURL = IpAndPortNo + Url;
					String jsonResponse = RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders,payload);
					//String jsonResponse = RestUtils.postWithHeaders("http://localhost:8082/AshaServices/v0.1/miAdmin/getDetailsForHospitalRegister",requestHeaders, payload);
					
					//System.out.println("jsonResponse " + jsonResponse);
					ModelAndView mv = new ModelAndView();
					mv.addObject("data", jsonResponse);
					mv.setViewName(jsp);
					return mv;
					
				}
}
