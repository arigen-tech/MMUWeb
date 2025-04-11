package com.mmu.web.controller;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;

@RequestMapping("/medicalexam")
@RestController
@CrossOrigin
public class MedicalExamRestWebController {
	
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	String localIpAndPort = HMSUtil.getProperties("urlextension.properties", "local_IP_AND_PORT");
	
	@Autowired
	MedicalExamService medicalExamService;
	@Autowired
	MedicalBoardService mbs;
	 
	@RequestMapping(value = "/validateMEWaiting", method = RequestMethod.GET)
	public ModelAndView validateMEWaiting(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("validateME");
		return mav;

	}
	  
	@RequestMapping(value = "/validateMEWaitingForMa", method = RequestMethod.GET)
	public ModelAndView validateMEWaitingForMa(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("validateMEForMa");
		return mav;

	}
	
	
	@RequestMapping(value = "/validateMEWaitingDetail", method = RequestMethod.GET)
	public ModelAndView validateMEWaitingDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("validateMEDetail");
		Integer visitId = Integer.parseInt(request.getParameter("visitId"));
		int age =0;
		if(request.getParameter("age")!=null && !request.getParameter("age").equalsIgnoreCase(""))
		  age = Integer.parseInt(request.getParameter("age"));
		String meAge=request.getParameter("meAge");
		mav.addObject("visitId", visitId);
		mav.addObject("age", age);
		mav.addObject("meAge", meAge);
		
		return mav;

	}
	
	@RequestMapping(value = "/validateMEWaitingDetailForMa", method = RequestMethod.GET)
	public ModelAndView validateMEWaitingDetailForMa(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("validateMEDetailForMa");
		Integer visitId = Integer.parseInt(request.getParameter("visitId"));
		int age =0;
		if(request.getParameter("age")!=null && !request.getParameter("age").equalsIgnoreCase(""))
		  age = Integer.parseInt(request.getParameter("age"));
		String meAge=request.getParameter("meAge");
		mav.addObject("visitId", visitId);
		mav.addObject("age", age);
		mav.addObject("meAge", meAge);
		return mav;

	}
	
	 @RequestMapping(value="/getMEWaitingGrid", method = RequestMethod.POST)
		public String getMasHospitalListForAdmin(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
		  
			return medicalExamService.getMEWaitingList(payload, request, response);
		}
	 @RequestMapping(value="/getPatientDetailToValidate", method = RequestMethod.POST,produces="application/json",consumes="application/json")
		public String getPatientDetailToValidate(@RequestBody String payload, HttpServletRequest request,
				HttpServletResponse response) {	
			
			return medicalExamService.getPatientDetailToValidate(payload, request, response);
		}
	 
	 
	 
	 
	 @RequestMapping(value = "/submitMedicalExamByMoInves", method = RequestMethod.POST)
		public ModelAndView submitMedicalExamByMo(HttpServletRequest request, HttpServletResponse response) {
			Box box = HMSUtil.getBox(request);
			JSONObject obj = new JSONObject(box);
			  String data = medicalExamService.submitMedicalExamByMo(obj.toString(), request, response);
			 
			  String meType=obj.get("meType").toString();
			  meType=HMSUtil.getReplaceString(meType);
			  String msgStatus="";
			  String saveStatus=obj.get("saveStatus").toString();
			  saveStatus=HMSUtil.getReplaceString(saveStatus);
			  
			  if(StringUtils.isNotEmpty(meType)) {
				  JSONObject jSONObject =new JSONObject (data);
					String msg = jSONObject.get("status").toString();
				  msgStatus=msg;
			  }
			  else {
				  
				  msgStatus="Investigation Submitted Successfully";
			  }
			 
			ModelAndView mv = new ModelAndView();
			String jsp = "medicalExamSubmit";
			mv.addObject("data",data);
			mv.addObject("redirectValue","InvestigationReport");
			mv.addObject("msgStatus", msgStatus);
			mv.addObject("saveStatus", saveStatus);
			mv.setViewName(jsp);
			return mv;

		}

	 
	 
	 @RequestMapping(value = "/validateMAWaiting", method = RequestMethod.GET)
		public ModelAndView validateMAWaiting(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mav = new ModelAndView("meWaitingList");
			return mav;

		}
		@RequestMapping(value = "/validateMAWaitingDetail", method = RequestMethod.GET)
		public ModelAndView validateMAWaitingDetail(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mav = new ModelAndView("afmsf3B");
			Integer visitId = Integer.parseInt(request.getParameter("visitId"));
			Integer age =  Integer.parseInt(request.getParameter("age"));
			Integer patientId=null;
			if(request.getParameter("patientId")!=null) {
				patientId=Integer.parseInt(request.getParameter("patientId"));
			}
			String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"patientId\":"+patientId+"}";
			
			String jsonResponse =medicalExamService.getPatientDetailOfVisitId(payload, request, response);
			mav.addObject("visitId", visitId);
			mav.addObject("age", age);
			mav.addObject("commonHis", 0);
			mav.addObject("data", jsonResponse);
			return mav;

		}
		 @RequestMapping(value = "/submitMedicalExamByMA", method = RequestMethod.POST)
			public ModelAndView submitMedicalExamByMA(MultipartHttpServletRequest request, HttpServletResponse response) {
				Box box = HMSUtil.getBox(request);
				JSONObject obj = new JSONObject(box);
				String dynamicUploadInvesIdAndfile= obj.get("dynamicUploadInvesIdAndfile").toString();
				String mainChargeCodeForFileWithChargeCode= obj.get("mainChargeCodeForFileWithChargeCode").toString();
				mainChargeCodeForFileWithChargeCode=HMSUtil.getReplaceString(mainChargeCodeForFileWithChargeCode);
				String [] mainChargeCodeForFileWithChargeCodes=null;
				if(StringUtils.isNotBlank(mainChargeCodeForFileWithChargeCode))
				  mainChargeCodeForFileWithChargeCodes=mainChargeCodeForFileWithChargeCode.split(",");
				
				String ridcIdValues="";  
				String fileNameValue=""; 
				String rmsAllValue="";
				 String data ="";
				 String referalRmsId="";
				 String meRmsId="";
				 String meRmsIdOld="";
				 String investigationRmsId="";
				 
				Iterator<String> itr = request.getFileNames();
				  Integer ridcIdVv=1;
				  ModelAndView mv = new    ModelAndView();
				  String labRadioVal="";
				  String dataOfYear="";
					
					String serviceNo= obj.get("serviceNo").toString();
					serviceNo=HMSUtil.getReplaceString(serviceNo);
				
					 if(obj.has("dateOfExam") && obj.get("dateOfExam")!=null) {
							String dateOfExam= obj.get("dateOfExam").toString();
							dateOfExam=HMSUtil.getReplaceString(dateOfExam);
							if(dateOfExam!=null && !dateOfExam.equalsIgnoreCase("")) {
								String[] dataOfYear1=dateOfExam.split("/");
								if(dataOfYear1!=null && dataOfYear1.length==3)
									dataOfYear = dataOfYear1[2].trim();
								//System.out.println("dataOfYear"+dataOfYear);
							}
						}
				
					 

				if(obj.has("dateOfRelease") && obj.get("dateOfRelease")!=null) {
					String dateOfRelease= obj.get("dateOfRelease").toString();
					dateOfRelease=HMSUtil.getReplaceString(dateOfRelease);
					if(dateOfRelease!=null && !dateOfRelease.equalsIgnoreCase("")) {
						//dataOfYear=dateOfRelease.split("/")[2];
						String[] dataOfYear1=dateOfRelease.split("/");
						if(dataOfYear1!=null && dataOfYear1.length==3)
							dataOfYear = dataOfYear1[2].trim();
						//System.out.println("dataOfYear"+dataOfYear);
					}
				}
					
				  
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
						RidcEntity ridcDoc=null;
						String docType="";
						if(size==0) {
							rmsAllValue+=size+",";
						}
						if(StringUtils.isNotEmpty(myFileName) && !myFileName.equalsIgnoreCase("") && StringUtils.isNotEmpty(name) && !name.equalsIgnoreCase("")) {
							
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
							if(name.contains("medicalExamFileUpload")|| name.contains("medicalExamFileUploadOldDocument"))
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
						
						//System.out.println("info"+info);
							
						File convFile = new File(file.getOriginalFilename());
						  convFile.createNewFile(); 
						  FileOutputStream fos = new FileOutputStream(convFile); 
						  fos.write(file.getBytes());
						  fos.close();	
						ridcDoc  =  PatientRegistrationWebController.getRidcEntityByValueMB(inputStream,  convFile,   size,  contentType,info);
							  //RIDCUtils.getRidcEntityByValueMB(inputStream,  myFileName,   size,  contentType,info);
						
							 if(ridcDoc==null) {
								  String jsp = "medicalExamSubmit";
								//	mv.addObject("msgMedicalExam","RMS Server is  Down");
									mv.addObject("msgMedicalExam","Something Error"+0+"##"+"RMS Server is  Down.");
									mv.setViewName(jsp);
									return mv;
							  }
							
							String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
							
							 if(ridcId!=null && (ridcId.equalsIgnoreCase("") || ridcId.contains("RidcUpload Table"))) {
								  String jsp = "medicalExamSubmit";
									//mv.addObject("msgMedicalExam","Data is not saved due some internal exception.");
								  mv.addObject("msgMedicalExam","Something Error"+0+"##"+"Data is not saved due some internal exception.");
								  mv.setViewName(jsp);
									return mv;
							  }
							 
						 //String ridcId="1";
						  ridcIdValues+=""+ridcId+",";
						  fileNameValue+=""+myFileName+",";
						 	rmsAllValue+=""+ridcId+",";
						
					/*	ridcIdValues+=""+ridcIdVv+",";
						 rmsAllValue+=""+ridcIdVv+",";
						 ridcIdVv+=1;*/
						 if(dynamicUploadInvesIdAndfile.contains(myFileName)) {
							 dynamicUploadInvesIdAndfile=dynamicUploadInvesIdAndfile.replaceAll(myFileName.trim(), ""+ridcId);
							 investigationRmsId+=""+ridcId+",";
						 }
						 if(StringUtils.isNotEmpty(name) && name.contains("referalFileUpload")) {
							 referalRmsId+=""+ridcId+",";
						 }
						 if(StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUpload")) {
							 meRmsId=""+ridcId;
						 }
						 if(StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUploadOldDocument")) {
							 meRmsIdOld=""+ridcId;
						 }
						}
						
						}
				  //String[] rms2Id=ridcIdValues.split(",");
				  //String[] rms1IdVal=rmsAllValue.split(",");
				  //String[] rmsIdFinalVal=getRMSId(rms2Id,rms1IdVal);
				  obj.put("ridcIdValues", ridcIdValues);
				  obj.put("dynamicUploadInvesIdAndfileNew", dynamicUploadInvesIdAndfile);
				  obj.put("referalRmsId", referalRmsId);
				  obj.put("meRmsId", meRmsId);
				  obj.put("meRmsIdOld", meRmsIdOld);
				  data = medicalExamService.submitMedicalExamByMA(obj.toString(), request, response);
				  String jsp = "medicalExamSubmit";
					
					
					String saveInDraft=obj.get("saveInDraft").toString();
					saveInDraft=HMSUtil.getReplaceString(saveInDraft);
					String statusValue="";
					if(StringUtils.isNotEmpty(saveInDraft)&& saveInDraft.equalsIgnoreCase("draftMa")) {
						statusValue="MeReport";
					}
					else {	
						statusValue="MeReport";
						
					}
					
					JSONObject jSONObject =new JSONObject (data);
				     
					String status = jSONObject.get("status").toString();
					String errorMsg = jSONObject.get("errorMes").toString();
					String msgForPatient = jSONObject.get("msgForPatient").toString();
					String countInvesResultEmptystatus= jSONObject.get("countInvesResultEmptystatus").toString();
					mv.addObject("data",data);
					mv.addObject("status",status);
					mv.addObject("countInvesResultEmptystatus",countInvesResultEmptystatus);
					String visitId =obj.get("visitId").toString(); 
					visitId=HMSUtil.getReplaceString(visitId);
					
					mv.addObject("visitIdForInvestEmpty",visitId);
					mv.addObject("redirectValue",statusValue);
					mv.addObject("saveInDraft",saveInDraft);
					mv.addObject("msgMedicalExam",errorMsg);
					mv.addObject("msgForPatient",msgForPatient);
					
					try { 
					
					if(StringUtils.isNotEmpty(status) && status.equalsIgnoreCase("0")) {
						/*List<Long>rmsIdVal=new ArrayList<Long>();
						if(StringUtils.isNotEmpty(investigationRmsId)) {
							String[] investigationRmsIdArray=investigationRmsId.split(",");
							for(String inves:investigationRmsIdArray) {
								if(StringUtils.isNotEmpty(inves)) {
									rmsIdVal.add(Long.parseLong(inves));
								}
							}
						}
						if(StringUtils.isNotEmpty(referalRmsId)) {
							String[] referalRmsIdIdArray=referalRmsId.split(",");
							for(String referalId:referalRmsIdIdArray) {
								if(StringUtils.isNotEmpty(referalId)) {
									rmsIdVal.add(Long.parseLong(referalId));
								}
							}
						}
						if(StringUtils.isNotEmpty(meRmsId)) {
							String[] meRmsIdArray=meRmsId.split(",");
							for(String melId:meRmsIdArray) {
								if(StringUtils.isNotEmpty(melId)) {
									rmsIdVal.add(Long.parseLong(melId));
								}
							}
						}
						
						
						if(CollectionUtils.isNotEmpty(rmsIdVal)) {
							List<RidcUpload> listRidcUpload=ridcUploadDao.getRidcDocumentByRidcIDs(rmsIdVal);
						for(RidcUpload ridcUpload:listRidcUpload) {
							if(ridcUpload!=null)
								RIDCUtils.deleteDocument(ridcUpload.getDocumentId().toString(), ridcUpload.getEncryptedName());
							}
						}*/
						//commonDeleteRIDC(status,investigationRmsId,referalRmsId,meRmsId);
					}
					}catch(Exception e) {
						e.printStackTrace();
					}
					
					mv.setViewName(jsp);
				
				  }
				  catch(Exception e) {
					  e.printStackTrace();
					  mv.addObject("msgMedicalExam",data+=0+"##"+"Data is not updated,because something is wrong : "+e);
					  return mv;
				  }
				
					return mv;
				

			}
		
		 
		 
		 
		
//Mo List
			@RequestMapping(value = "/validateMOWaiting", method = RequestMethod.GET)
			public ModelAndView validateMEWaitingListMO(HttpServletRequest request, HttpServletResponse response) {
				ModelAndView mav = new ModelAndView("meWaitingListMO");
				return mav;

			}
		 
			@RequestMapping(value = "/validateMAWaitingDetailMO", method = RequestMethod.GET)
			public ModelAndView validateMAWaitingDetailMO(HttpServletRequest request, HttpServletResponse response) {
				ModelAndView mav = new ModelAndView("afmsf3Bobservation");
				int visitId = Integer.parseInt(request.getParameter("visitId"));
				Integer age =  Integer.parseInt(request.getParameter("age"));
				
				//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + "}";
				Integer patientId=null;
				if(request.getParameter("patientId")!=null) {
					patientId=Integer.parseInt(request.getParameter("patientId"));
				}
				String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"patientId\":"+patientId+"}";
				
				String jsonResponse =medicalExamService.getPatientDetailOfVisitId(payload, request, response);
				String approvalFlag =  request.getParameter("approvalFlag");
				mav.addObject("visitId", visitId);
				mav.addObject("age", age);
				mav.addObject("approvalFlag", approvalFlag);
				mav.addObject("commonHis", 0);
				mav.addObject("data", jsonResponse);
				return mav;

			}
			
			
			 @RequestMapping(value="/getMEWaitingGridMO", method = RequestMethod.POST)
				public String getMEWaitingGridMO(@RequestBody String payload, HttpServletRequest request,
						HttpServletResponse response) {	
					
					return medicalExamService.getMEWaitingList(payload, request, response);
				}
			 
			 
			 @RequestMapping(value="/getAFMSF3BForMOOrMA", method = RequestMethod.POST)
				public String getAFMSF3BForMOOrMA(@RequestBody String payload, HttpServletRequest request,
						HttpServletResponse response) {	
					
					return medicalExamService.getAFMSF3BForMOOrMA(payload, request, response);
				}
 
			 @RequestMapping(value="/getInvestigationAndResult", method = RequestMethod.POST)
				public String getInvestigationAndResult(@RequestBody String payload, HttpServletRequest request,
						HttpServletResponse response) {	
					
					return medicalExamService.getInvestigationAndResult(payload, request, response);
				}
			 
			 
			 
			 @RequestMapping(value = "/approvalWaitingList", method = RequestMethod.GET)
				public ModelAndView approvalWaitingList(HttpServletRequest request, HttpServletResponse response) {
					ModelAndView mav = new ModelAndView("meApprovalWaitingList(AO)");
					return mav;

				}

			 
			 @RequestMapping(value="/getMEApprovalWaitingGrid", method = RequestMethod.POST)
				public String getMEApprovalWaitingGrid(@RequestBody String payload, HttpServletRequest request,
						HttpServletResponse response) {	
					
					return medicalExamService.getMEApprovalWaitingGrid(payload, request, response);
				}

			 @RequestMapping(value = "/meApprovalWaitingDetail", method = RequestMethod.GET)
				public ModelAndView meApprovalWaitingDetail(HttpServletRequest request, HttpServletResponse response) {
					ModelAndView mav = new ModelAndView("meApproval");
					Integer visitId = Integer.parseInt(request.getParameter("visitId"));
					int age = Integer.parseInt(request.getParameter("age"));
					
					String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + "}";
					
					String jsonResponse =medicalExamService.getPatientDetailOfVisitId(payload, request, response);
					mav.addObject("visitId", visitId);
					mav.addObject("age", age);
					mav.addObject("data", jsonResponse);

					String approvalFlag =  request.getParameter("approvalFlag");
					mav.addObject("approvalFlag", approvalFlag);
					return mav;

				}
			 @RequestMapping(value = "/approvalPerusingWaitingList", method = RequestMethod.GET)
				public ModelAndView approvalPerusingWaitingList(HttpServletRequest request, HttpServletResponse response) {
					ModelAndView mav = new ModelAndView("meApprovalWaitingList(PA)");
					return mav;

				}
			 
			 @RequestMapping(value = "/meApprovalWaitingPerusingDetail", method = RequestMethod.GET)
				public ModelAndView meApprovalWaitingPerusingDetail(HttpServletRequest request, HttpServletResponse response) {
					ModelAndView mav = new ModelAndView("meApprovalPerusing");
					Integer visitId = Integer.parseInt(request.getParameter("visitId"));
					int age = Integer.parseInt(request.getParameter("age"));
					String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + "}";
					
					String jsonResponse =medicalExamService.getPatientDetailOfVisitId(payload, request, response);
 					String approvalFlag =  request.getParameter("approvalFlag");
					mav.addObject("visitId", visitId);
					mav.addObject("age", age);
					mav.addObject("approvalFlag", approvalFlag);
					mav.addObject("commonHis", 0);
					mav.addObject("data", jsonResponse);
					return mav;

				}
			 
			 @RequestMapping(value="/getPatientDetailOfVisitId", method = RequestMethod.POST)
				public String getPatientDetailOfVisitId(@RequestBody String payload, HttpServletRequest request,
						HttpServletResponse response) {	
				  
					return medicalExamService.getPatientDetailOfVisitId(payload, request, response);
				}
			 
			 
			 @RequestMapping(value="/getUnitDetail", method = RequestMethod.POST)
				public String getUnitDetail(@RequestBody String payload, HttpServletRequest request,
						HttpServletResponse response) {	
				  
					return medicalExamService.getUnitDetail(payload, request, response);
				}
			 
			 @RequestMapping(value="/getApprovalListByFlag", method = RequestMethod.POST)
				public String getApprovalListByFlag(@RequestBody String payload, HttpServletRequest request,
						HttpServletResponse response) {	
				 HttpSession session=request.getSession();
				 JSONObject json = new JSONObject(payload);
				 json.put("userId", session.getAttribute("user_id"));
					json.put("hospitalId", session.getAttribute("hospital_id"));
					
					return medicalExamService.getApprovalListByFlag(json.toString(), request, response);
				}
			 
			 
			 @RequestMapping(value = "/meInboxProcess", method = RequestMethod.GET)
				public ModelAndView meInboxProcess(HttpServletRequest request, HttpServletResponse response) {
					
					Integer visitId = Integer.parseInt(request.getParameter("visitId"));
					int age = Integer.parseInt(request.getParameter("age"));
					//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + "}";
					Integer patientId=null;
					if(request.getParameter("patientId")!=null) {
						patientId=Integer.parseInt(request.getParameter("patientId"));
					}
					String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"patientId\":"+patientId+"}";
					
					
					String jsonResponse =medicalExamService.getPatientDetailOfVisitId(payload, request, response);
					
					String approvalFlag =  request.getParameter("approvalFlag");
					
					String jspPage="";
					String menustatus="";	
					JSONObject jSONObject =new JSONObject (jsonResponse);
					org.json.JSONArray respList =null;
					if(jSONObject.getJSONArray("data")!=null)
					  respList = jSONObject.getJSONArray("data");
					if(respList!=null && respList.length()>0) {
					JSONObject jsonData = (JSONObject)respList.get(0);
					String approvedBy ="";
				    if(jsonData.get("approvedBy")!=null) 
				    	approvedBy = jsonData.get("approvedBy").toString();
					
					if(StringUtils.isNotEmpty(approvalFlag) && approvalFlag.contains("@@")) {
						String [] approvalFlageValue=approvalFlag.split("@@");
						approvalFlag=approvalFlageValue[0];
						menustatus=approvalFlageValue[1];
					} 
				String designationName="";
					try {
					HttpSession httpSession=request.getSession();
					designationName=(String) httpSession.getAttribute("designationName");
					}
					catch(Exception e) {e.printStackTrace();}
					if(StringUtils.isNotBlank(menustatus) && menustatus.equalsIgnoreCase("inbox")) {
					if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("MO")) {
						jspPage="afmsf3Bobservation";
					}	
					else if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("RMO")) {
						jspPage="meApproval";
					}	
					else if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("PDMS")) {
						jspPage="meApprovalPerusing";
					}	
					else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("MO")) {
				    	 jspPage="meApproval";
				     }
				     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("RMO")) {
				    	 jspPage="meApprovalPerusing";
				     }
				     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("PRMo")) {
				    	 jspPage="meApprovalPerusing";
				     }
					}
				else {
					if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("MO")) {
				    	 jspPage="afmsf3Bobservation";
				     }
				     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("RMO")) {
				    	 jspPage="meApproval";
				     }
				     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("PRMo")) {
				    	 jspPage="meApprovalPerusing";
				     }	
					}
					
					}
					
					ModelAndView mav = new ModelAndView(jspPage);
					mav.addObject("visitId", visitId);
					mav.addObject("age", age);
					
					mav.addObject("approvalFlag", approvalFlag);
					mav.addObject("menustatus", menustatus);
					mav.addObject("data", jsonResponse);
					mav.addObject("commonHis", 0);
					return mav;

				}
			 


				
				 
				 @RequestMapping(value="/getPatientReferalDetailMe", method = RequestMethod.POST)
					public String getPatientReferalDetailMe(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getPatientReferalDetailMe(payload, request, response);
					}
				
				 @RequestMapping(value="/getImmunisationHistory", method = RequestMethod.POST)
					public String getImmunisationHistory(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getImmunisationHistory(payload, request, response);
					}
					 
				 
				 @RequestMapping(value = "/meWaitingListAfms18", method = RequestMethod.GET)
					public ModelAndView portalAfmsf18(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("meWaitingListForAfms18");
						return mav;

					}
				 
				 @RequestMapping(value="/getMEWaitingGridAFMS18", method = RequestMethod.POST)
					public String getMEWaitingGridAFMS18(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
						return medicalExamService.getMEWaitingGridAFMS18(payload, request, response);
					}
				 
				 @RequestMapping(value = "/validateMAWaitingDetailAFMSForm18Portal", method = RequestMethod.GET)
					public ModelAndView validateMAWaitingDetailAFMSForm18Portal(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("portalAfmsf18");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						Integer age =  Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						HttpSession httpSession=request.getSession();
						String serviceNumber =  (String) httpSession.getAttribute("service_No");
						
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age +","+"\"userId\":"+userId+","+"\"serviceNumber\":"+serviceNumber+"}";
						JSONObject jSONObject =new JSONObject (payload);
						
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18P(jSONObject.toString(), request, response);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("data", jsonResponse);
						return mav;

					}
					
				 
				 
				 
				 @RequestMapping(value = "/validateMAWaitingDetailAFMSF18", method = RequestMethod.GET)
					public ModelAndView validateMAWaitingDetailAFMSF18(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("afmsf18");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						Integer age =  Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+"}";
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						String status =  request.getParameter("status");
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("data", jsonResponse);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 @RequestMapping(value = "/submitMedicalExamByMAForm18", method = RequestMethod.POST)
					public ModelAndView submitMedicalExamByMAForm18(MultipartHttpServletRequest request,  HttpServletResponse response) {
						Box box = HMSUtil.getBox(request);
						JSONObject obj = new JSONObject(box);
						
						
						////////////////////////////////////////
						
						String dynamicUploadInvesIdAndfile= obj.get("dynamicUploadInvesIdAndfile").toString();
						
						
						
						String mainChargeCodeForFileWithChargeCode= obj.get("mainChargeCodeForFileWithChargeCode").toString();
						mainChargeCodeForFileWithChargeCode=HMSUtil.getReplaceString(mainChargeCodeForFileWithChargeCode);
						String [] mainChargeCodeForFileWithChargeCodes=null;
						if(StringUtils.isNotBlank(mainChargeCodeForFileWithChargeCode))
						  mainChargeCodeForFileWithChargeCodes=mainChargeCodeForFileWithChargeCode.split(",");
						
						
						String serviceNo= obj.get("serviceNo").toString();
						serviceNo=HMSUtil.getReplaceString(serviceNo);
						String dataOfYear="";
						 if(obj.has("dateOfExam") && obj.get("dateOfExam")!=null) {
						String dateOfExam= obj.get("dateOfExam").toString();
						dateOfExam=HMSUtil.getReplaceString(dateOfExam);
						if(dateOfExam!=null && !dateOfExam.equalsIgnoreCase("")) {
							dataOfYear=dateOfExam.split("/")[2];
							//System.out.println("dataOfYear"+dataOfYear);
						}
					}
					
						 

					if(obj.has("dateOfRelease") && obj.get("dateOfRelease")!=null) {
						String dateOfRelease= obj.get("dateOfRelease").toString();
						dateOfRelease=HMSUtil.getReplaceString(dateOfRelease);
						if(dateOfRelease!=null && !dateOfRelease.equalsIgnoreCase("")) {
							dataOfYear=dateOfRelease.split("/")[2];
							//System.out.println("dataOfYear"+dataOfYear);
						}
					}
						
						
						String ridcIdValues="";  
						String fileNameValue=""; 
						String rmsAllValue="";
						 String data ="";
						 String referalRmsId="";
						 String meRmsId="";
						 String meRmsIdOld="";
						Iterator<String> itr = request.getFileNames();
						  Integer ridcIdVv=1;
						  ModelAndView mv = new    ModelAndView();
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
								RidcEntity ridcDoc=null;
								
								if(size==0) {
									rmsAllValue+=size+",";
								}
								if(StringUtils.isNotEmpty(myFileName)) {
									
									String docType="";
									  String labRadioVal="";
									
									
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
										if(name.contains("medicalExamFileUpload") || name.contains("medicalExamFileUploadOldDocument"))
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
									
									//System.out.println("info"+info);
									
									File convFile = new File(file.getOriginalFilename());
									  convFile.createNewFile(); 
									  FileOutputStream fos = new FileOutputStream(convFile); 
									  fos.write(file.getBytes());
									  fos.close();	
									
									
							//	ridcDoc  =  PatientRegistrationWebController.getRidcEntityByValue(inputStream,  myFileName,   size,  contentType);
									ridcDoc  =  PatientRegistrationWebController.getRidcEntityByValueMB(inputStream,  convFile,   size,  contentType,info);
									 if(ridcDoc==null) {
										  String jsp = "medicalExamSubmit";
										//	mv.addObject("msgMedicalExam","RMS Server is  Down");
											mv.addObject("msgMedicalExam","Something Error"+0+"##"+"RMS Server is  Down.");
											mv.setViewName(jsp);
											return mv;
									  }
									
									String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
									

									  if(ridcId!=null && (ridcId.equalsIgnoreCase("") || ridcId.contains("RidcUpload Table"))) {
										  String jsp = "medicalExamSubmit";
											//mv.addObject("msgMedicalExam","Data is not saved due some internal exception.");
										  mv.addObject("msgMedicalExam","Something Error"+0+"##"+"Data is not saved due some internal exception.");
										  mv.setViewName(jsp);
											return mv;
									  }
									//String ridcId="1";
								  ridcIdValues+=""+ridcId+",";
								  fileNameValue+=""+myFileName+",";
								 	rmsAllValue+=""+ridcId+",";
								 
								/* ridcIdValues+=""+ridcIdVv+",";
								 rmsAllValue+=""+ridcIdVv+",";
								 ridcIdVv+=1;*/
								 if(dynamicUploadInvesIdAndfile.contains(myFileName)) {
									 dynamicUploadInvesIdAndfile=dynamicUploadInvesIdAndfile.replaceAll(myFileName.trim(), ""+ridcId);
								 }
								 if(StringUtils.isNotEmpty(name) && name.contains("referalFileUpload")) {
									 referalRmsId+=""+ridcId+",";
								 }
								 if(StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUpload")) {
									 meRmsId=""+ridcId;
								 }
								 if(StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUploadOldDocument")) {
									 meRmsIdOld=""+ridcId;
								 }
								}
								
								}
						  //String[] rms2Id=ridcIdValues.split(",");
						  //String[] rms1IdVal=rmsAllValue.split(",");
						  //String[] rmsIdFinalVal=getRMSId(rms2Id,rms1IdVal);
						  obj.put("ridcIdValues", ridcIdValues);
						  obj.put("dynamicUploadInvesIdAndfileNew", dynamicUploadInvesIdAndfile);
						  obj.put("referalRmsId", referalRmsId);
						  obj.put("meRmsId", meRmsId);
						  obj.put("meRmsIdOld", meRmsIdOld);
						  data = medicalExamService.submitMedicalExamByMAForm18(obj.toString(), request, response);
							 
							String jsp = "medicalExamSubmit";
							
							
							String saveInDraft=obj.get("saveInDraft").toString();
							saveInDraft=HMSUtil.getReplaceString(saveInDraft);
							String statusValue="";
							if(StringUtils.isNotEmpty(saveInDraft)&& (saveInDraft.equalsIgnoreCase("portalDraftMa18") || saveInDraft.equalsIgnoreCase("draftMa18"))) {
								statusValue="MeReportF18";
							}
							else {	
								statusValue="MeReportF18";
								
							}
							
							JSONObject jSONObject =new JSONObject (data);
						     
							String status = jSONObject.get("status").toString();
							String errorMsg = jSONObject.get("errorMes").toString();
							String msgForPatient = jSONObject.get("msgForPatient").toString();
							String countInvesResultEmptystatus=jSONObject.get("countInvesResultEmptystatus").toString();//jSONObject.get("countInvesResultEmptystatus").toString();
							mv.addObject("data",data);
							mv.addObject("status",status);
							
							mv.addObject("redirectValue",statusValue);
							mv.addObject("saveInDraft",saveInDraft);
							mv.addObject("msgMedicalExam",errorMsg);
							String visitId =obj.get("visitId").toString();
							visitId=HMSUtil.getReplaceString(visitId);
							mv.addObject("visitIdForInvestEmpty",visitId);
							mv.addObject("countInvesResultEmptystatus",countInvesResultEmptystatus);
							mv.addObject("msgForPatient",msgForPatient);
							mv.setViewName(jsp);
						  }
						  catch(Exception e) {
							  e.printStackTrace();
							  mv.addObject("msgMedicalExam",data+=0+"##"+"Data is not updated,because something is wrong : "+e);
							  return mv;
						  }
						
						return mv;
					 
					}
				 
				 
				 @RequestMapping(value="/getServiceDetails", method = RequestMethod.POST)
					public String getServiceDetails(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getServiceDetails(payload, request, response);
					}
				 
				 
				 @RequestMapping(value="/getPatientDiseaseWoundInjuryDetail", method = RequestMethod.POST)
					public String getPatientDiseaseWoundInjuryDetail(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getPatientDiseaseWoundInjuryDetail(payload, request, response);
					}
				 
				 @RequestMapping(value="/getMasEmployeeDetailForService", method = RequestMethod.POST)
					public String getMasEmployeeDetailForService(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getMasEmployeeDetailForService(payload, request, response);
					}
				 @RequestMapping(value="/getMasDesignationMappingByUnitId", method = RequestMethod.POST)
					public String getMasDesignationMappingByUnitId(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getMasDesignationMappingByUnitId(payload, request, response);
					}
				 
				 
				 
				 @RequestMapping(value = "/validateMAWaitingDetailMOAFMSF18", method = RequestMethod.GET)
					public ModelAndView validateMAWaitingDetailMOAFMSF18(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("afmsfObservationF18");
						int visitId = Integer.parseInt(request.getParameter("visitId"));
						Integer age =  Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age +","+"\"userId\":"+userId+"}";
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						String approvalFlag =  request.getParameter("approvalFlag");
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("data", jsonResponse);
						mav.addObject("commonHis", 0);
						return mav;

					}
					
				 @RequestMapping(value = "/meApprovalWaitingDetailF18", method = RequestMethod.GET)
					public ModelAndView meApprovalWaitingDetailF18(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("meApprovalF18");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						int age = Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+" }";
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("data", jsonResponse);

						String approvalFlag =  request.getParameter("approvalFlag");
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 
				 @RequestMapping(value = "/meApprovalWaitingPerusingDetailF18", method = RequestMethod.GET)
					public ModelAndView meApprovalWaitingPerusingDetailF18(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("meApprovalPerusingF18");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						int age = Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
					//	String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+"}";
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("data", jsonResponse);

						String approvalFlag =  request.getParameter("approvalFlag");
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 
				 @RequestMapping(value = "/meInboxProcessF18", method = RequestMethod.GET)
					public ModelAndView meInboxProcessF18(HttpServletRequest request, HttpServletResponse response) {
						
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						int age = Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+"}";
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						
						String approvalFlag =  request.getParameter("approvalFlag");
						
						String jspPage="";
						String menustatus="";	
						JSONObject jSONObject =new JSONObject (jsonResponse);
						org.json.JSONArray respList =null;
						if(jSONObject.getJSONArray("data")!=null)
						  respList = jSONObject.getJSONArray("data");
						if(respList!=null && respList.length()>0) {
						JSONObject jsonData = (JSONObject)respList.get(0);
						String approvedBy =""; 
						if(jsonData.get("approvedBy")!=null)
						  approvedBy = jsonData.get("approvedBy").toString();
						
						if(StringUtils.isNotEmpty(approvalFlag) && approvalFlag.contains("@@")) {
							String [] approvalFlageValue=approvalFlag.split("@@");
							approvalFlag=approvalFlageValue[0];
							menustatus=approvalFlageValue[1];
						} 
						
						String designationName="";
						try {
						HttpSession httpSession=request.getSession();
						designationName=(String) httpSession.getAttribute("designationName");
						}
						catch(Exception e) {e.printStackTrace();}
						
						if(StringUtils.isNotBlank(menustatus) && menustatus.equalsIgnoreCase("inbox")) {
							
							if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("MO")) {
								jspPage="afmsfObservationF18";
							}	
							else if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("RMO")) {
								jspPage="meApprovalF18";
							}	
							else if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("PDMS")) {
								jspPage="meApprovalPerusingF18";
							}	
							
							else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("MO")) {
					    	 jspPage="meApprovalF18";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("RMO")) {
					    	 jspPage="meApprovalPerusingF18";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("PRMo")) {
					    	 jspPage="meApprovalPerusingF18";
					     }
						}
					else {
						if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("MO")) {
					    	 jspPage="afmsfObservationF18";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("RMO")) {
					    	 jspPage="meApprovalF18";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("PRMo")) {
					    	 jspPage="meApprovalPerusingF18";
					     }	
						}
						
						}
						
						ModelAndView mav = new ModelAndView(jspPage);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("menustatus", menustatus);
						mav.addObject("data", jsonResponse);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 
				 


				 @RequestMapping(value="/getInvestigationListUOM", method = RequestMethod.POST)
					public String getInvestigationListUOM(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getInvestigationListUOM(payload, request, response);
					}
				 
				 
				 
				 
				 @RequestMapping(value = "/submitMedicalExamByMA3A", method = RequestMethod.POST)
					public ModelAndView submitMedicalExamByMA3A(MultipartHttpServletRequest request, HttpServletResponse response) {
						Box box = HMSUtil.getBox(request);
						JSONObject obj = new JSONObject(box);
						//////////////////////////////////////////////////////////////////////////
						
						 
						String dynamicUploadInvesIdAndfile= obj.get("dynamicUploadInvesIdAndfile").toString();
						String mainChargeCodeForFileWithChargeCode= obj.get("mainChargeCodeForFileWithChargeCode").toString();
						mainChargeCodeForFileWithChargeCode=HMSUtil.getReplaceString(mainChargeCodeForFileWithChargeCode);
						String [] mainChargeCodeForFileWithChargeCodes=null;
						if(StringUtils.isNotBlank(mainChargeCodeForFileWithChargeCode))
						  mainChargeCodeForFileWithChargeCodes=mainChargeCodeForFileWithChargeCode.split(",");
						
						
						String ridcIdValues="";  
						String fileNameValue=""; 
						String rmsAllValue="";
						 String data ="";
						 String referalRmsId="";
						 String meRmsId="";
						 String meRmsIdOld="";
						Iterator<String> itr = request.getFileNames();
						  Integer ridcIdVv=1;
						  ModelAndView mv = new    ModelAndView();
						  String labRadioVal="";
						  String dataOfYear="";
						  
						  String serviceNo= obj.get("serviceNo").toString();
							serviceNo=HMSUtil.getReplaceString(serviceNo);
						
							 if(obj.has("dateOfExam") && obj.get("dateOfExam")!=null) {
							String dateOfExam= obj.get("dateOfExam").toString();
							dateOfExam=HMSUtil.getReplaceString(dateOfExam);
							if(dateOfExam!=null && !dateOfExam.equalsIgnoreCase("")) {
								dataOfYear=dateOfExam.split("/")[2];
								//System.out.println("dataOfYear"+dataOfYear);
							}
						}
						
							 

						if(obj.has("dateOfRelease") && obj.get("dateOfRelease")!=null) {
							String dateOfRelease= obj.get("dateOfRelease").toString();
							dateOfRelease=HMSUtil.getReplaceString(dateOfRelease);
							if(dateOfRelease!=null && !dateOfRelease.equalsIgnoreCase("")) {
								dataOfYear=dateOfRelease.split("/")[2];
								//System.out.println("dataOfYear"+dataOfYear);
							}
						}
							
						  
						  
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
								RidcEntity ridcDoc=null;
								String docType="";
								if(size==0) {
									rmsAllValue+=size+",";
								}
								if(StringUtils.isNotEmpty(myFileName)) {
									
									
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
										if(name.contains("medicalExamFileUpload")|| name.contains("medicalExamFileUploadOldDocument"))
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
											
											//System.out.println("info"+info);
									
									
											File convFile = new File(file.getOriginalFilename());
											  convFile.createNewFile(); 
											  FileOutputStream fos = new FileOutputStream(convFile); 
											  fos.write(file.getBytes());
											  fos.close();	
											ridcDoc  =  PatientRegistrationWebController.getRidcEntityByValueMB(inputStream,  convFile,   size,  contentType,info);

									 if(ridcDoc==null) {
										  String jsp = "medicalExamSubmit";
											mv.addObject("msgMedicalExam","Something Error,"+0+"##"+"RMS Server is  Down.");
											mv.setViewName(jsp);
											return mv;
									  }
								  String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
								  if(ridcId!=null && (ridcId.equalsIgnoreCase("") || ridcId.contains("RidcUpload Table"))) {
									  String jsp = "medicalExamSubmit";
									  mv.addObject("msgMedicalExam","Something Error,"+0+"##"+"Data is not saved due some internal exception.");
									  mv.setViewName(jsp);
										return mv;
								  }
								//String ridcId="1";	
								  ridcIdValues+=""+ridcId+",";
								  fileNameValue+=""+myFileName+",";
								 	rmsAllValue+=""+ridcId+",";
								 
								/* ridcIdValues+=""+ridcIdVv+",";
								 rmsAllValue+=""+ridcIdVv+",";
								 ridcIdVv+=1;*/
								 if(dynamicUploadInvesIdAndfile.contains(myFileName)) {
									 dynamicUploadInvesIdAndfile=dynamicUploadInvesIdAndfile.replaceAll(myFileName.trim(), ""+ridcId);
								 }
								 if(StringUtils.isNotEmpty(name) && name.contains("referalFileUpload")) {
									 referalRmsId+=""+ridcId+",";
								 }
								 if(StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUpload")) {
									 meRmsId=""+ridcId;
								 }
								 if(StringUtils.isNotEmpty(name) && name.equalsIgnoreCase("medicalExamFileUploadOldDocument")) {
									 meRmsIdOld=""+ridcId;
								 }
								}
								
								}
						  //String[] rms2Id=ridcIdValues.split(",");
						  //String[] rms1IdVal=rmsAllValue.split(",");
						  //String[] rmsIdFinalVal=getRMSId(rms2Id,rms1IdVal);
						  obj.put("ridcIdValues", ridcIdValues);
						  obj.put("dynamicUploadInvesIdAndfileNew", dynamicUploadInvesIdAndfile);
						  obj.put("referalRmsId", referalRmsId);
						  obj.put("meRmsId", meRmsId);
						  obj.put("meRmsIdOld", meRmsIdOld);
						    data = medicalExamService.submitMedicalExamByMA3A(obj.toString(), request, response);
							String jsp = "medicalExamSubmit";
							
							
							String saveInDraft=obj.get("saveInDraft").toString();
							saveInDraft=HMSUtil.getReplaceString(saveInDraft);
							String statusValue="";
							if(StringUtils.isNotEmpty(saveInDraft)&& saveInDraft.equalsIgnoreCase("draftMa3A")) {
								statusValue="MeReportF3A";
							}
							else {	
								statusValue="MeReportF3A";
								
							}
							
							JSONObject jSONObject =new JSONObject (data);
						     
							String status = jSONObject.get("status").toString();
							String errorMsg = jSONObject.get("errorMes").toString();
							String countInvesResultEmptystatus= jSONObject.get("countInvesResultEmptystatus").toString();
							 String msgForPatient = jSONObject.get("msgForPatient").toString();
							mv.addObject("data",data);
							mv.addObject("status",status);
							mv.addObject("countInvesResultEmptystatus",countInvesResultEmptystatus);
							String visitId =obj.get("visitId").toString(); 
							visitId=HMSUtil.getReplaceString(visitId);
							
							mv.addObject("visitIdForInvestEmpty",visitId);
							mv.addObject("redirectValue",statusValue);
							mv.addObject("saveInDraft",saveInDraft);
							mv.addObject("msgMedicalExam",errorMsg);
							mv.addObject("msgForPatient",msgForPatient);
							mv.setViewName(jsp);
						
						  }
						  catch(Exception e) {
							  e.printStackTrace();
							  mv.addObject("msgMedicalExam",data+=0+"##"+"Data is not updated,because something is wrong : "+e);
							  return mv;
						  }
						
						//////////////////////////////////////////////////////////////////////////
						  
						return mv;

					}
				 
				 
				 @RequestMapping(value = "/validateMAWaitingDetail3A", method = RequestMethod.GET)
					public ModelAndView validateMAWaitingDetail3A(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("afmsf3A");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						Integer age =  Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("data", jsonResponse);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 

				 @RequestMapping(value = "/validateMAWaitingDetailMOAFMS3A", method = RequestMethod.GET)
					public ModelAndView validateMAWaitingDetailMOAFMS3A(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("afmsf3AObservation");
						int visitId = Integer.parseInt(request.getParameter("visitId"));
						Integer age =  Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age +","+"\"userId\":"+userId+"}";
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":" + userId + ","+"\"patientId\":" + patientId +"}";
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						String approvalFlag =  request.getParameter("approvalFlag");
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("data", jsonResponse);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 
				 @RequestMapping(value = "/meApprovalWaitingDetail3A", method = RequestMethod.GET)
					public ModelAndView meApprovalWaitingDetail3A(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("meApproval3A");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						int age = Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+" }";
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
					
						
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("data", jsonResponse);

						String approvalFlag =  request.getParameter("approvalFlag");
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 
				 
				 @RequestMapping(value = "/meApprovalWaitingPerusingDetail3A", method = RequestMethod.GET)
					public ModelAndView meApprovalWaitingPerusingDetail3A(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("meApprovalPerusing3A");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						int age = Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						//String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+"}";
						
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ",\"+\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
					
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						mav.addObject("data", jsonResponse);

						String approvalFlag =  request.getParameter("approvalFlag");
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 
				  
				 @RequestMapping(value = "/meInboxProcess3A", method = RequestMethod.GET)
					public ModelAndView meInboxProcess3A(HttpServletRequest request, HttpServletResponse response) {
						
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						int age = Integer.parseInt(request.getParameter("age"));
						Long userId =  Long.parseLong(request.getParameter("userId"));
						Integer patientId=null;
						if(request.getParameter("patientId")!=null) {
							patientId=Integer.parseInt(request.getParameter("patientId"));
						}
						
						String payload = "{\"visitId\":" + visitId +","+"\"age\":" + age + ","+"\"userId\":"+userId+","+"\"patientId\":"+patientId+"}";
					
						String jsonResponse =medicalExamService.getPatientDetailOfVisitIdAfms18(payload, request, response);
						
						String approvalFlag =  request.getParameter("approvalFlag");
						
						String jspPage="";
						String menustatus="";	
						JSONObject jSONObject =new JSONObject (jsonResponse);
						org.json.JSONArray respList =null;
						if(jSONObject.getJSONArray("data")!=null)
						  respList = jSONObject.getJSONArray("data");
						if(respList!=null && respList.length()>0) {
						JSONObject jsonData = (JSONObject)respList.get(0);
						String approvedBy = "";
						if(jsonData.get("approvedBy")!=null)  
						  approvedBy = jsonData.get("approvedBy").toString();
						
						if(StringUtils.isNotEmpty(approvalFlag) && approvalFlag.contains("@@")) {
							String [] approvalFlageValue=approvalFlag.split("@@");
							approvalFlag=approvalFlageValue[0];
							menustatus=approvalFlageValue[1];
						} 
						
						String designationName="";
						try {
						HttpSession httpSession=request.getSession();
						designationName=(String) httpSession.getAttribute("designationName");
						}
						catch(Exception e) {e.printStackTrace();}
						if(StringUtils.isNotBlank(menustatus) && menustatus.equalsIgnoreCase("inbox")) {
							
							if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("MO")) {
								jspPage="afmsf3AObservation";
							}	
							else if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("RMO")) {
								jspPage="meApproval3A";
							}	
							else if(StringUtils.isNotEmpty(designationName)  && designationName.equalsIgnoreCase("PDMS")) {
								jspPage="meApprovalPerusing3A";
							}
							else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("MO")) {
					    	 jspPage="meApproval3A";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("RMO")) {
					    	 jspPage="meApprovalPerusing3A";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("PRMo")) {
					    	 jspPage="meApprovalPerusing3A";
					     }
						}
					else {
						if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("MO")) {
					    	 jspPage="afmsf3AObservation";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("RMO")) {
					    	 jspPage="meApproval3A";
					     }
					     else if(StringUtils.isNotEmpty(approvedBy) && approvedBy.equalsIgnoreCase("PRMo")) {
					    	 jspPage="meApprovalPerusing3A";
					     }	
						}
						
						}
						
						ModelAndView mav = new ModelAndView(jspPage);
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						
						mav.addObject("approvalFlag", approvalFlag);
						mav.addObject("menustatus", menustatus);
						mav.addObject("data", jsonResponse);
						mav.addObject("commonHis", 0);
						return mav;

					}
				 
				 

				 @RequestMapping(value="/getMedicalExamListCommon", method = RequestMethod.POST)
					public String getMedicalExamList(@RequestBody String payload, HttpServletRequest request,
							HttpServletResponse response) {	
					  
						return medicalExamService.getMedicalExamListCommon(payload, request, response);
					}
				 
				 
				 @RequestMapping(value = "/getHistory", method = RequestMethod.GET)
					public ModelAndView getHistory(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("commonMedicalReport");
						mav.addObject("commonHis", 1);
						return mav;
						 
					}
					  
				 @RequestMapping(value = "/meReport", method = RequestMethod.GET)
					public ModelAndView mbReport(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("meReport");
						return mav;
					}	 
				 


					@RequestMapping(value = "/validateMEWaitingForMaTest", method = RequestMethod.GET)
					public ModelAndView validateMEWaitingForMaTest(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("validateMEForMaTest");
						return mav;

					}

					@RequestMapping(value = "/validateMEWaitingDetailTest", method = RequestMethod.GET)
					public ModelAndView validateMEWaitingDetailTest(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("validateMEDetailTest");
						Integer visitId = Integer.parseInt(request.getParameter("visitId"));
						int age = Integer.parseInt(request.getParameter("age"));
						mav.addObject("visitId", visitId);
						mav.addObject("age", age);
						return mav;

					}
					
					@RequestMapping(value = "/showCreateInvestigationTemplateME", method = RequestMethod.GET)
					public ModelAndView showCreateInvestigationTemplateME(HttpServletRequest request,	HttpServletResponse response) {
						//System.out.println("called");
						Map<String, Object> map = new HashMap<String, Object>();
						String jsp = "meInvestigationTemplate";
						int empid= Integer.parseInt(request.getParameter("employeeId"));
						String payload = "{\"employeeId\":"+empid+"}";
						String jsonResponse = mbs.preliminaryMBWaitingDetail(payload, request, response);
						//System.out.println("jsonResponse "+jsonResponse);
						ModelAndView mv =new ModelAndView();
						mv.addObject("data", jsonResponse);
						mv.setViewName(jsp);
						return mv;
					}
					/*****************************ME/MB Investigation Report*********************************/
					@RequestMapping(value = "/meAndMbReportReport", method = RequestMethod.GET)
					public ModelAndView meAndMbReportReport(HttpServletRequest request, HttpServletResponse response) {
						ModelAndView mav = new ModelAndView("meAndMbReportReport");
						mav.addObject("commonHis", 1);
						return mav;
						 
					}
					
					 @RequestMapping(value="/getMEMBHistory", method = RequestMethod.POST)
						public String getMEMBHistory(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {	
							return medicalExamService.getMEMBHistory(payload, request, response);
						}
					 

					 @RequestMapping(value = "/submitPatientImmunizationHistory", method = RequestMethod.POST  , produces = "application/json", consumes = "application/json")
						public String submitPatientImmunizationHistory(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {
					 		String data=medicalExamService.submitPatientImmunizationHistory(payload, request, response);
							return data;
						}
					 
					 @RequestMapping(value="/saveItemCommon", method = RequestMethod.POST)
						public String saveItemCommon(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {	
							
							return medicalExamService.saveItemCommon(payload, request, response);
						}
					 
					 
					/* public void commonDeleteRIDC(String status,String investigationRmsId,String referalRmsId,String meRmsId) {
							if(StringUtils.isNotEmpty(status) && status.equalsIgnoreCase("0")) {
								List<Long>rmsIdVal=new ArrayList<Long>();
								if(StringUtils.isNotEmpty(investigationRmsId)) {
									String[] investigationRmsIdArray=investigationRmsId.split(",");
									for(String inves:investigationRmsIdArray) {
										if(StringUtils.isNotEmpty(inves)) {
											rmsIdVal.add(Long.parseLong(inves));
										}
									}
								}
								if(StringUtils.isNotEmpty(referalRmsId)) {
									String[] referalRmsIdIdArray=referalRmsId.split(",");
									for(String referalId:referalRmsIdIdArray) {
										if(StringUtils.isNotEmpty(referalId)) {
											rmsIdVal.add(Long.parseLong(referalId));
										}
									}
								}
								if(StringUtils.isNotEmpty(meRmsId)) {
									String[] meRmsIdArray=meRmsId.split(",");
									for(String melId:meRmsIdArray) {
										if(StringUtils.isNotEmpty(melId)) {
											rmsIdVal.add(Long.parseLong(melId));
										}
									}
								}
								
								
								if(CollectionUtils.isNotEmpty(rmsIdVal)) {
									List<RidcUpload> listRidcUpload=ridcUploadDao.getRidcDocumentByRidcIDs(rmsIdVal);
								for(RidcUpload ridcUpload:listRidcUpload) {
									if(ridcUpload!=null)
										RIDCUtils.deleteDocument(ridcUpload.getDocumentId().toString(), ridcUpload.getEncryptedName());
									}
								}
							}
							
						 
					 }*/
					 
					 
					 @RequestMapping(value = "/getApprovalHistory", method = RequestMethod.GET)
						public ModelAndView getApprovalHistory(HttpServletRequest request, HttpServletResponse response) {
							ModelAndView mav = new ModelAndView("approvalHistory");
							mav.addObject("commonHis", 1);
							return mav;
							 
						}
					 
					 @RequestMapping(value = "/submitMedicalExamApprovalFile", method = RequestMethod.POST)
						public String submitMedicalExamApprovalFile(MultipartHttpServletRequest request, HttpServletResponse response) {
							JSONObject json = new JSONObject();
						 Box box = HMSUtil.getBox(request);
							JSONObject obj = new JSONObject(box);
							//////////////////////////////////////////////////////////////////////////
							  String dataOfYear="";
							  String serviceNumber= obj.get("serviceNumber").toString();
							  serviceNumber=HMSUtil.getReplaceString(serviceNumber);	
							
							 
							  
							  if(obj.has("dateOfExam") && obj.get("dateOfExam")!=null) {
									String dateOfExam= obj.get("dateOfExam").toString();
									dateOfExam=HMSUtil.getReplaceString(dateOfExam);
									if(dateOfExam!=null && !dateOfExam.equalsIgnoreCase("")) {
										dataOfYear=dateOfExam.split("/")[2];
										//System.out.println("dataOfYear"+dataOfYear);
									}
								} 
							  
							  
							 String data ="";
							 String meApprovedRmsId="";
							Iterator<String> itr = request.getFileNames();
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
									RidcEntity ridcDoc=null;
									String docType="";
									 
									if(StringUtils.isNotEmpty(myFileName) ) {
										
											if(name.contains("medicalExamApprovalFileUpload") )
											{
												docType="1";
											}
											 
											 HashMap<String,String> info=new HashMap<String,String>();
												info.put("serviceNo", serviceNumber);
												info.put("year", dataOfYear);
												info.put("docType", docType);
												info.put("type", "1");
												
												//System.out.println("info"+info);
										
										
												File convFile = new File(file.getOriginalFilename());
												  convFile.createNewFile(); 
												  FileOutputStream fos = new FileOutputStream(convFile); 
												  fos.write(file.getBytes());
												  fos.close();	
												ridcDoc  =  PatientRegistrationWebController.getRidcEntityByValueMB(inputStream,  convFile,   size,  contentType,info);

									  if(ridcDoc==null) {
											json.put("message", "0"+"##" + "RMS Server is  Down.");
											return json.toString();
									  }
									  String ridcId= PatientRegistrationWebController.ridcUploadForInv(ridcDoc);
									  if(ridcId!=null && (ridcId.equalsIgnoreCase("") || ridcId.contains("RidcUpload Table"))) {
										  json.put("message", "0"+"##" + "Data is not saved due some internal exception. ");
											return json.toString();
									  }
									 if(StringUtils.isNotEmpty(name) && name.contains("medicalExamApprovalFileUpload")) {
										 meApprovedRmsId=""+ridcId;
									 }
									 
									}
									
									}
							  obj.put("meApprovedRmsId", meApprovedRmsId);
							   data = medicalExamService.submitApprovalDate(obj.toString(), request, response);
								 
							
							  }
							  catch(Exception e) {
								  e.printStackTrace();
									json.put("message",    "0"+"##" + "Data is not updated,because something is wrong ::::  " + e);
									return json.toString();
							  }
							
							/////////////////////////////////<<<<<<<<<<<<<<<<<<nnnnnnnnnn>>>>>>>>>>>>>>>>>>>>>>>>>>>/////////////////////////////////////////
							  
							return data;

						}
					 
					 @RequestMapping(value="/getTemplateInvestDataForDiver", method = RequestMethod.POST)
						public String getTemplateInvestDataForDiver(@RequestBody String payload, HttpServletRequest request,
								HttpServletResponse response) {	
							return medicalExamService.getTemplateInvestDataForDiver(payload, request, response);
						}
					 
					 
}


