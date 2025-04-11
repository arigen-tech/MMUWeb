package com.mmu.web.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.entity.RidcEntity;
import com.mmu.web.service.RegistrationService;
import com.mmu.web.utils.AlfrescoUpload;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

@RequestMapping("/registration")
@RestController
@CrossOrigin
public class PatientRegistrationWebController {
	static String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");

	@Autowired
	RegistrationService registrationService;

	/*
	 * @RequestMapping(value="/showemployeeanddependent", method =
	 * RequestMethod.GET) public ModelAndView
	 * showEmployeeAndDependentJsp(HttpServletRequest request, HttpServletResponse
	 * response) { String jsp = "showEmployeeAndDependent"; ModelAndView mv = new
	 * ModelAndView(); mv.setViewName(jsp); return mv; }
	 * 
	 * @RequestMapping(value="/getEmployeeAndDependentlist", method =
	 * RequestMethod.POST) public String getEmployeeAndDependentData(@RequestBody
	 * String data, HttpServletRequest request, HttpServletResponse response) {
	 * return registrationService.getEmployeeAndDependentData(data, request,
	 * response); }
	 * 
	 * 
	 * @RequestMapping(value="/tokenNoForDepartmentMultiVisit", method =
	 * RequestMethod.POST) public String
	 * getTokenNoForDepartmentMultiVisit(@RequestBody String data,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.getTokenNoForDepartmentMultiVisit(data, request,
	 * response); }
	 * 
	 * @RequestMapping(value = "/uploadAuthorityLetter", method =
	 * RequestMethod.POST) public String uploadAuthorityLetter(HttpServletRequest
	 * request,
	 * 
	 * @RequestParam CommonsMultipartFile[] fileUpload) throws Exception { return
	 * registrationService.uploadAuthorityLetter(request, fileUpload); }
	 * 
	 * 
	 * @RequestMapping(value = "/submitPatientDetails", method = RequestMethod.POST)
	 * public String submitPatientDetails(@RequestBody String
	 * data,HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.submitPatientDetails(data, request, response);
	 * 
	 * }
	 * 
	 * 
	 * @RequestMapping(value = "/showVisitTokenList", method = RequestMethod.POST)
	 * public ModelAndView showVisitTokenList(HttpServletRequest request,
	 * HttpServletResponse response) { Map<String,Object> map = new
	 * HashMap<String,Object>(); long visitIdOpd=0; long visitIdME=0; long
	 * visitIdMB=0; String message=""; String messageME=""; String messageMB="";
	 * 
	 * Box box = HMSUtil.getBox(request); JSONObject data = new JSONObject(box);
	 * 
	 * 
	 * if (data.getJSONArray("visitIdOPD") != null &
	 * !(data.getJSONArray("visitIdOPD").get(0).toString().isEmpty())) {
	 * visitIdOpd=Long.parseLong(data.getJSONArray("visitIdOPD").get(0).toString());
	 * } if (data.getJSONArray("visitIdME") != null &
	 * !(data.getJSONArray("visitIdME").get(0).toString().isEmpty())) {
	 * visitIdME=Long.parseLong(data.getJSONArray("visitIdME").get(0).toString()); }
	 * if (data.getJSONArray("visitIdMB") != null &
	 * !(data.getJSONArray("visitIdMB").get(0).toString().isEmpty())) {
	 * visitIdMB=Long.parseLong(data.getJSONArray("visitIdMB").get(0).toString()); }
	 * 
	 * if (data.getJSONArray("rspMsg") != null &
	 * !(data.getJSONArray("rspMsg").get(0).toString().isEmpty())) {
	 * message=data.getJSONArray("rspMsg").get(0).toString(); } if
	 * (data.getJSONArray("rspMsgME") != null &
	 * !(data.getJSONArray("rspMsgME").get(0).toString().isEmpty())) {
	 * messageME=data.getJSONArray("rspMsgME").get(0).toString(); } if
	 * (data.getJSONArray("rspMsgMB") != null &
	 * !(data.getJSONArray("rspMsgMB").get(0).toString().isEmpty())) {
	 * messageMB=data.getJSONArray("rspMsgMB").get(0).toString(); }
	 * 
	 * map.put("visitIdOPD",visitIdOpd); map.put("visitIdME",visitIdME);
	 * map.put("visitIdMB",visitIdMB); map.put("message",message);
	 * map.put("messageME",messageME); map.put("messageMB",messageMB);
	 * 
	 * String jsp = "responseMessageICG"; return new ModelAndView(jsp, "map", map);
	 * }
	 * 
	 * 
	 * 
	 * @RequestMapping(value="/registrationandappointmentothers", method =
	 * RequestMethod.GET) public ModelAndView
	 * showRegistrationAndAppointmentOthers(HttpServletRequest request,
	 * HttpServletResponse response) { String jsp =
	 * "othersappointmentandregistration"; return new ModelAndView(jsp); }
	 * 
	 * 
	 * @RequestMapping(value="/getRegistrationAndAppointmentOthers", method =
	 * RequestMethod.POST) public String
	 * getRegistrationAndAppointmentOthers(@RequestBody String data,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.showRegistrationAndAppointmentOthers(data,request,
	 * response); }
	 * 
	 * @RequestMapping(value="/tokenNoOfDepartmentForOthers", method =
	 * RequestMethod.POST) public String
	 * getTokenNoOfDepartmentForOthers(@RequestBody String data, HttpServletRequest
	 * request, HttpServletResponse response) { return
	 * registrationService.getTokenNoOfDepartmentForOthers(data, request, response);
	 * }
	 * 
	 * 
	 * @RequestMapping(value = "/submitPatientDetailsForOthers", method =
	 * RequestMethod.POST) public String submitPatientDetailsForOthers(@RequestBody
	 * String data, HttpServletRequest request, HttpServletResponse response) {
	 * String result = registrationService.submitPatientDetailsForOthers(data,
	 * request, response); return result; }
	 * 
	 * @RequestMapping(value = "/showVisitTokenForOthers", method =
	 * RequestMethod.GET) public ModelAndView
	 * showVisitTokenForOthers(HttpServletRequest request, HttpServletResponse
	 * response) { Map<String, Object> map = new HashMap<String, Object>(); String
	 * visitId = request.getParameter("visitId");
	 * 
	 * if (!visitId.equalsIgnoreCase("0") && visitId!=null ) { String resultMsg =
	 * "Appointment Booked successfully."; map.put("resultMsg", resultMsg); }
	 * map.put("visitId", visitId); String jsp = "responseMessage"; return new
	 * ModelAndView(jsp, "map", map); }
	 * 
	 * @RequestMapping(value="/searchOthersRegisteredPatient", method =
	 * RequestMethod.POST) public String searchOthersRegisteredPatient(@RequestBody
	 * String data, HttpServletRequest request, HttpServletResponse response) {
	 * return registrationService.searchOthersRegisteredPatient(data, request,
	 * response); }
	 * 
	 * 
	 * 
	 * @RequestMapping(value="/showUploadPatientDocument", method =
	 * RequestMethod.GET) public ModelAndView
	 * showuploadPatientDocument(HttpServletRequest request, HttpServletResponse
	 * response) { Map<String,Object> map = new HashMap<String,Object>(); String jsp
	 * = "uploadpatientdocuments"; return new ModelAndView(jsp,"map",map); }
	 * 
	 * 
	 * @RequestMapping(value="/getPatientListFromServiceNo", method =
	 * RequestMethod.POST) public String getPatientListFromServiceNo(@RequestBody
	 * String data, HttpServletRequest request, HttpServletResponse response) {
	 * return registrationService.getPatientListFromServiceNo(data, request,
	 * response); }
	 * 
	 * 
	 * 
	 * @RequestMapping(value="/getDocumentListForPatient", method =
	 * RequestMethod.POST) public String getDocumentListForPatient(@RequestBody
	 * String data, HttpServletRequest request, HttpServletResponse response) {
	 * return registrationService.getDocumentListForPatient(data, request,
	 * response); }
	 * 
	 * @RequestMapping(value = "/uploadDocumentForPatient", method =
	 * RequestMethod.POST) public String uploadDocumentForPatient(HttpServletRequest
	 * request,
	 * 
	 * @RequestParam CommonsMultipartFile[] uploadFile) throws Exception { return
	 * registrationService.uploadDocumentForPatient(request, uploadFile); }
	 * 
	 * 
	 * @RequestMapping(value="/viewUploadDocuments", method = RequestMethod.GET)
	 * public ModelAndView viewUploadDocuments(HttpServletRequest request,
	 * HttpServletResponse response) throws SQLException { Map<String,Object> map =
	 * new HashMap<String, Object>(); map=
	 * registrationService.viewUploadDocuments(request, response); String jsp =
	 * "viewdocument"; return new ModelAndView(jsp,"map",map); }
	 * 
	 * @RequestMapping(value="/showMIReport", method = RequestMethod.GET) public
	 * ModelAndView showMIReport() { ModelAndView mv =new ModelAndView();
	 * mv.setViewName("miAppointmentReport"); return mv;
	 * 
	 * }
	 * 
	 * @RequestMapping(value="/getAppointmentTypeList", method=RequestMethod.POST)
	 * public String getAppointmentTypeList(@RequestBody String jsonPayload,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.getAppointmentTypeList(jsonPayload, request, response);
	 * 
	 * }
	 * 
	 * 
	 * @RequestMapping(value="/deleteUploadDocument", method = RequestMethod.POST)
	 * public String deleteUploadDocument(@RequestBody String data,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.deleteUploadDocument(data, request, response); }
	 * 
	 * 
	 * @RequestMapping(value="/getExamSubType", method=RequestMethod.POST) public
	 * String getExamSubType(@RequestBody String data, HttpServletRequest request,
	 * HttpServletResponse response) { return
	 * registrationService.getExamSubType(data, request, response);
	 * 
	 * }
	 * 
	 * @RequestMapping(value = "/showFutureAppointment", method = RequestMethod.GET)
	 * public ModelAndView showFutureAppointment() { ModelAndView mv = new
	 * ModelAndView(); mv.setViewName("showFutureAppointment"); return mv;
	 * 
	 * }
	 * 
	 * 
	 * @RequestMapping(value="/getFutureAppointmentWaitingList",
	 * method=RequestMethod.POST) public String
	 * getFutureAppointmentWaitingList(@RequestBody String data, HttpServletRequest
	 * request, HttpServletResponse response) { return
	 * registrationService.getFutureAppointmentWaitingList(data, request, response);
	 * 
	 * }
	 * 
	 * @RequestMapping(value="/getInvestigationEmptyResultByOrderNo",
	 * method=RequestMethod.POST) public String
	 * getInvestigationEmptyResultByOrderNo(@RequestBody String data,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.getInvestigationEmptyResultByOrderNo(data, request,
	 * response);
	 * 
	 * }
	 * 
	 * 
	 * 
	 * @RequestMapping(value = "/submitInvestigationUp", method =
	 * RequestMethod.POST) public String
	 * submitInvestigationUp(MultipartHttpServletRequest request,
	 * HttpServletResponse response) { JSONObject json = new JSONObject(); Box box =
	 * HMSUtil.getBox(request); JSONObject obj = new JSONObject(box); String
	 * dynamicUploadInvesIdAndfile =
	 * obj.get("dynamicUploadInvesIdAndfile").toString();
	 * 
	 * String mainChargeCodeForFileWithChargeCode =
	 * obj.get("mainChargeCodeForFileWithChargeCode").toString();
	 * mainChargeCodeForFileWithChargeCode =
	 * HMSUtil.getReplaceString(mainChargeCodeForFileWithChargeCode); String[]
	 * mainChargeCodeForFileWithChargeCodes = null; if
	 * (StringUtils.isNotBlank(mainChargeCodeForFileWithChargeCode))
	 * mainChargeCodeForFileWithChargeCodes =
	 * mainChargeCodeForFileWithChargeCode.split(",");
	 * 
	 * String serviceNo = obj.get("serviceNoIn").toString(); serviceNo =
	 * HMSUtil.getReplaceString(serviceNo); LocalDate currentDate = LocalDate.now();
	 * int year = currentDate.getYear();
	 * 
	 * String ridcIdValues = ""; String fileNameValue = ""; String rmsAllValue = "";
	 * String data = ""; Iterator<String> itr = request.getFileNames(); Integer
	 * ridcIdVv = 1; String precriptRmsId=""; String otherSupportedDocsRmsId=""; try
	 * { while (itr.hasNext()) { MultipartFile file = request.getFile(itr.next());
	 * 
	 * InputStream inputStream = null; String name = null, contentType = null; long
	 * size = 0; try { inputStream = file.getInputStream(); } catch (IOException e)
	 * { // TODO Auto-generated catch block e.printStackTrace(); } name =
	 * file.getName(); size = file.getSize(); contentType = file.getContentType();
	 * String myFileName = file.getOriginalFilename(); RidcEntity ridcDoc = null;
	 * String docType = ""; String labRadioVal = ""; if (size == 0) { rmsAllValue +=
	 * size + ","; } if (StringUtils.isNotEmpty(myFileName) &&
	 * !myFileName.equalsIgnoreCase("") && StringUtils.isNotEmpty(name) &&
	 * !name.equalsIgnoreCase("")) {
	 * 
	 * if (mainChargeCodeForFileWithChargeCodes != null &&
	 * mainChargeCodeForFileWithChargeCodes.length > 0) for (String
	 * mainChargeAndfielObj : mainChargeCodeForFileWithChargeCodes) { if
	 * (StringUtils.isNotEmpty(mainChargeAndfielObj) &&
	 * !mainChargeAndfielObj.equalsIgnoreCase("0")) if
	 * (mainChargeAndfielObj.contains(myFileName)) { String[] mainChargeAndFiles =
	 * mainChargeAndfielObj.split("##"); labRadioVal = mainChargeAndFiles[0]; break;
	 * } }
	 * 
	 * if (name.contains("referalFileUpload")) { docType = "1"; } if
	 * (name.contains("medicalExamFileUpload")) { docType = "1"; } if
	 * (name.contains("medicalBoardDocsUpload")) { docType = "16"; } if
	 * (name.contains("precriptionUploadFile")) { docType = "1"; }
	 * if(name.contains("medicalBoardDocsUpload")) { docType="16"; } if
	 * (name.contains("fileInvUploadDyna")) { if
	 * (StringUtils.isNotEmpty(labRadioVal) && labRadioVal.equalsIgnoreCase("2")) {
	 * docType = "4"; }
	 * 
	 * if (StringUtils.isNotEmpty(labRadioVal) && labRadioVal.equalsIgnoreCase("1"))
	 * { docType = "8"; } } HashMap<String, String> info = new HashMap<String,
	 * String>(); info.put("serviceNo", serviceNo); info.put("year",
	 * String.valueOf(year)); info.put("docType", docType); info.put("type", "1");
	 * 
	 * 
	 * //System.out.println("info" + info); File convFile = new
	 * File(file.getOriginalFilename()); convFile.createNewFile(); FileOutputStream
	 * fos = new FileOutputStream(convFile); fos.write(file.getBytes());
	 * fos.close(); ridcDoc =
	 * PatientRegistrationWebController.getRidcEntityByValueMB(inputStream,
	 * convFile, size,contentType, info);
	 * 
	 * // ridcDoc = getRidcEntityByValue(inputStream, myFileName, size,
	 * contentType); String ridcId =""; ridcId=ridcUploadForInv(ridcDoc); if (ridcId
	 * != null && (ridcId.equalsIgnoreCase("") ||
	 * ridcId.contains("RidcUpload Table"))) { json.put("message",
	 * "Data is not uploaded because something is not save in RidcUpload table");
	 * return json.toString(); } ridcIdValues += "" + ridcId + ","; fileNameValue +=
	 * "" + myFileName + ","; rmsAllValue += "" + ridcId + ",";
	 * 
	 * ridcIdValues+=""+ridcIdVv+","; rmsAllValue+=""+ridcIdVv+","; ridcIdVv+=1;
	 * 
	 * if (dynamicUploadInvesIdAndfile.contains(myFileName)) {
	 * dynamicUploadInvesIdAndfile =
	 * dynamicUploadInvesIdAndfile.replaceAll(myFileName.trim(), "" + ridcId); }
	 * if(StringUtils.isNotEmpty(name) &&
	 * name.equalsIgnoreCase("precriptionUploadFile")) { precriptRmsId=""+ridcId; }
	 * 
	 * if (StringUtils.isNotEmpty(name) && name.contains("medicalBoardDocsUpload"))
	 * { otherSupportedDocsRmsId += "" + ridcId + ","; } }
	 * 
	 * } // String[] rms2Id=ridcIdValues.split(","); // String[]
	 * rms1IdVal=rmsAllValue.split(","); // String[]
	 * rmsIdFinalVal=getRMSId(rms2Id,rms1IdVal); obj.put("ridcIdValues",
	 * ridcIdValues); obj.put("dynamicUploadInvesIdAndfileNew",
	 * dynamicUploadInvesIdAndfile); obj.put("precriptRmsId", precriptRmsId);
	 * obj.put("medicalBoardDocsUpload", otherSupportedDocsRmsId); data =
	 * registrationService.submitInvestigationUp(obj.toString(), request, response);
	 * } catch (Exception e) {
	 * 
	 * e.printStackTrace(); json.put("message", "0"+"##" +
	 * "Data is not updated,because something is wrong ::::  " + e); return
	 * json.toString(); } return data;
	 * 
	 * }
	 * 
	 * 
	 */
	public static String ridcUploadForInv(RidcEntity ridcEntity) { String
	  alfrescoId =""; String encryptedName =""; 
	  
	 /*try { MultiValueMap<String, String> requestHeaders = new
	  LinkedMultiValueMap<String, String>(); alfrescoId =
	  String.valueOf(ridcEntity.getAlfrescoId()); String documentName =
	  String.valueOf(ridcEntity.getDocumentName()); String documentFormat =
	  String.valueOf(ridcEntity.getDocumentFormat()); // encryptedName =
	  String.valueOf(ridcEntity.getEncryptedName()); // save document detail to
	  ridc upload table JSONObject obj = new JSONObject(); obj.put("alfrescoId",
	  alfrescoId); obj.put("documentName", documentName); obj.put("documentFormat",
	  documentFormat); //obj.put("encryptedName", encryptedName);
	  //obj.put("documentUrl", ridcEntity.getDocumentUrl()); String
	  saveDocumentData = HMSUtil.getProperties("urlextension.properties",
	  "saveDocumentData"); String getRidcId =
	  RestUtils.postWithHeaders(ipAndPort.trim()+saveDocumentData.trim(),
	  requestHeaders, obj.toString()); //String getRidcId =
	  RestUtils.postWithHeaders(
	  "http://localhost:8082/AshaServices/radiology/saveDocumentData",
	  requestHeaders, obj.toString());
	  
	  JSONObject response = new JSONObject(getRidcId); String status =
	  response.getString("result"); String rId = ""; if(status.equals("success")) {
	  rId = response.getString("ridcId"); }else { String result =
	  "{\"result\":\"error\"}"; //RIDCUtils.deleteDocument(documentId,
	  encryptedName);
	  
	  } return rId; } catch (Exception e) { e.printStackTrace();
	  RIDCUtils.deleteDocument(documentId, encryptedName);*/
	  return "RidcUpload Table";
	  } // return null; }

	/*
	 * public static RidcEntity getRidcEntityByValue(InputStream inputStream,String
	 * name, long size,String contentType) throws IdcClientException { RidcEntity
	 * ridcDoc = new RidcEntity(); // String USER = "weblogic"; //String HOST =
	 * "idc://192.168.203.220:4444"; String HOST =
	 * HMSUtil.getProperties("js_messages_en.properties", "RIDCSERVERIP").trim();
	 * String USER = HMSUtil.getProperties("js_messages_en.properties",
	 * "RIDCUSER").trim(); String PASSWORD =
	 * HMSUtil.getProperties("js_messages_en.properties", "RIDCPASSWORD").trim();
	 * 
	 * @SuppressWarnings("rawtypes") IdcClient idcClient = new
	 * IdcClientManager().createClient(HOST); DataBinder dataBinder =
	 * idcClient.createBinder(); dataBinder.putLocal("IdcService",
	 * "CHECKIN_UNIVERSAL"); dataBinder.putLocal("dDocTitle", name);
	 * //dataBinder.putLocal("dDocName", name); dataBinder.putLocal("dDocType",
	 * "Document"); dataBinder.putLocal("dSecurityGroup", "Public");
	 * dataBinder.addFile("primaryFile", new TransferFile(inputStream, name, size,
	 * contentType)); try { IdcContext user = new IdcContext (USER,PASSWORD);
	 * DataBinder responseData = idcClient.sendRequest(new
	 * IdcContext(USER,PASSWORD), dataBinder).getResponseAsBinder();
	 * //ServiceResponse response = idcClient.sendRequest (user, dataBinder);
	 * //DataBinder responseData = response.getResponseAsBinder();
	 * ridcDoc.setDocumentId(Long.parseLong(responseData.getLocalData().get("dID")))
	 * ; ridcDoc.setEncryptedName(responseData.getLocalData().get("dDocName"));
	 * ridcDoc.setDocumentName(responseData.getLocalData().get("dDocTitle"));
	 * ridcDoc.setDocumentFormat(responseData.getLocalData().get("dFormat")); }catch
	 * (Exception e) { e.printStackTrace(); }
	 * 
	 * return ridcDoc; }
	 */
	public static RidcEntity getRidcEntityByValueMB(InputStream inputStream, File convFile, long size,
			String contentType, HashMap<String, String> saveType) {
		RidcEntity ridcDoc = new RidcEntity(); // String USER = "weblogic"; // String
		/*
		 * HOST = "idc://192.168.203.220:4444"; String shipUploadUrl =
		 * HMSUtil.getProperties("js_messages_en.properties", "shipUploadUrl").trim();
		 * String documentId=""; String charset = "UTF-8"; File uploadFile1 = new
		 * File("D:/Credentails/sitiBoradband.PNG"); File uploadFile2 = new
		 * File("C:/Users/User/Downloads/Alfresco_Installing.PDF"); String requestURL =
		 * "http://101.53.157.154:8070/icg-dms/batch-job/uploadFilesToAlfresco";
		 * 
		 * try { AlfrescoUpload multipart = new AlfrescoUpload(shipUploadUrl, charset);
		 * 
		 * multipart.addHeaderField("User-Agent", "CodeJava");
		 * multipart.addHeaderField("Test-Header", "Header-Value");
		 * 
		 * multipart.addFormField("description", "Cool Pictures");
		 * multipart.addFormField("keywords", "Java,upload,Spring");
		 * 
		 * multipart.addFilePart("file", convFile); //multipart.addFilePart("file",
		 * uploadFile2);
		 * 
		 * List<String> response = multipart.finish();
		 * 
		 * 
		 * //System.out.println("SERVER REPLIED:");
		 * 
		 * for (String line : response) { //System.out.println(line); JSONObject
		 * jsonObject = new JSONObject(line); JSONArray items = (JSONArray)
		 * jsonObject.get("fileUploadResponse"); String str=(String) items.get(0);
		 * String[] parts = str.split(";"); documentId = parts[0]; } } catch
		 * (IOException ex) { System.err.println(ex); } if(documentId!=null) {
		 * 
		 * ridcDoc.setAlfrescoId(documentId); //ridcDoc.setEncryptedName("abc");
		 * if(saveType.get("documentName")!=null) {
		 * ridcDoc.setDocumentName(saveType.get("documentName")); }
		 * if(saveType.get("documentType")!=null) {
		 * ridcDoc.setDocumentFormat(saveType.get("documentType")); } //
		 * ridcDoc.setDocumentUrl("http://test.com"); }
		 */

		return ridcDoc;
	}

	/*
	 * public static String[] getRMSId(String[] rms2Id, String[] rms1IdVal) { //
	 * return null;
	 * 
	 * // String [] s1=s.split(","); // String []
	 * s1={"0","0","1","0","2","0","2","3","0","0","4","4","0","5","0"}; String[] s1
	 * = { "1", "0", "0", "0", "2", "3", "4", "5", "0", "0", "6", "0", "0", "7",
	 * "0", "0", "0" }; String[] s2 = { "1", "2", "3", "4", "5", "6", "7" }; int a =
	 * -1; int b = -1; for (int j = 0; j < rms2Id.length; j++) { for (int i = 0; i <
	 * rms1IdVal.length; i++) { if
	 * (rms1IdVal[i].trim().equalsIgnoreCase(rms2Id[j].trim())) { a = i; } if (a !=
	 * -1) { if (!rms1IdVal[i].trim().equalsIgnoreCase(rms2Id[j].trim()) &&
	 * !rms1IdVal[i].trim().equalsIgnoreCase("0")) { b = i; } if (a != -1 && b !=
	 * -1) { break; } } } if (a != -1) { for (int k = 0; k < a; k++) { if
	 * (rms1IdVal[k].trim().equalsIgnoreCase("0")) rms1IdVal[k] = rms2Id[j].trim();
	 * } } if (b != -1) { for (int p = a; p < b; p++) { if
	 * (rms1IdVal[p].equalsIgnoreCase("0")) rms1IdVal[p] = rms2Id[j].trim(); } b =
	 * -1; a = -1; }
	 * 
	 * }
	 * 
	 * for (int i = 0; i < rms1IdVal.length - 1; i++) { if
	 * (!rms1IdVal[i].trim().equalsIgnoreCase("0") && rms1IdVal[i +
	 * 1].equalsIgnoreCase("0")) { rms1IdVal[i + 1] = rms1IdVal[i].trim(); }
	 * 
	 * } for (int i = 0; i < rms1IdVal.length; i++) { //System.out.println("aaaa" +
	 * rms1IdVal[i]); } return rms1IdVal; }
	 * 
	 * @RequestMapping(value="/getDepartmentBloodGroupAndMedicalCategory", method =
	 * RequestMethod.POST) public String
	 * getDepartmentBloodGroupAndMedicalCategory(@RequestBody String data,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.getDepartmentBloodGroupAndMedicalCategory(data, request,
	 * response); }
	 * 
	 * 
	 * @RequestMapping(value="/getStateFromDistrict", method=RequestMethod.POST)
	 * public String getStateFromDistrict(@RequestBody String data,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.getStateFromDistrict(data, request, response);
	 * 
	 * }
	 */

	/*
	 * @RequestMapping(value="/getDistrictFromState", method=RequestMethod.POST)
	 * public String getDistrictFromState(@RequestBody String data,
	 * HttpServletRequest request, HttpServletResponse response) { return
	 * registrationService.getDistrictFromState(data, request, response); }
	 */

	@RequestMapping(value = "/getRegionFromStation", method = RequestMethod.POST)
	public String getRegionFromStation(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		return registrationService.getRegionFromStation(data, request, response);
	}

	@RequestMapping(value = "/createCampPlan", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String createCampPlan(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "createCampPlan");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}

	@RequestMapping(value = "/updatePatientInformationOrMakeAppointment", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String savePatientRegistrationAndAppointment(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "updatePatientInformationOrMakeAppointment");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}

	@RequestMapping(value = "/patientRegistration", method = RequestMethod.GET)
	public ModelAndView patientRegistration(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("z-mmu-registration");
		return mv;
	}

	@RequestMapping(value = "/campRegistration", method = RequestMethod.GET)
	public ModelAndView campRegistration(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("z-mmu-campdetails");
		return mv;
	}

	@RequestMapping(value = "/getDistrictList", method = RequestMethod.POST)
	public String getDistrictList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDistrictListForCH");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/radiology/getResultPrintingData",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getCityList", method = RequestMethod.POST)
	public String getCityListForCH(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCityListForCH");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);
		// return
		// RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaShipServices/radiology/getResultPrintingData",
		// requestHeaders, data);
	}

	@RequestMapping(value = "/getReligionList", method = RequestMethod.POST)
	public String getReligionList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getReligionListForCH");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getBloodGroupList", method = RequestMethod.POST)
	public String getBloodGroupList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getBloodGroupListForCH");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getLabourTyeList", method = RequestMethod.POST)
	public String getLabourTyeList(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getLabourTyeListForCH");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getIdentificationTypeList", method = RequestMethod.POST)
	public String getIdentificationTypeList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getIdentificationTypeListForCH");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/getCampDepartment", method = RequestMethod.POST)
	public String getCampDepartment(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCampDepartment");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getMMUList", method = RequestMethod.POST)
	public String getMMUList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMMUList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getZoneList", method = RequestMethod.POST)
	public String getZoneList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getZoneList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getDepartmentListBasedOnDepartmentType", method = RequestMethod.POST)
	public String getDepartmentListBasedOnDepartmentType(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getDepartmentListBasedOnDepartmentType");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getWardList", method = RequestMethod.POST)
	public String getWardList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWardList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getCampDetail", method = RequestMethod.POST)
	public String getCampDetail(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getCampDetail");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	//createPatientAndMakeAppointment
	@RequestMapping(value = "/createPatientAndMakeAppointment", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String createPatientAndMakeAppointment(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "createPatientAndMakeAppointment");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	
	@RequestMapping(value = "/getMMUDepartment", method = RequestMethod.POST)
	public String getMMUDepartment(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMMUDepartment");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/patientAppointmentAndUpdateInfo", method = RequestMethod.GET)
	public ModelAndView patientAppointmentAndUpdateInfo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("z-mmu-patientAppointment");
		return mv;
	}
	
	@RequestMapping(value = "/getPatientList", method = RequestMethod.POST)
	public String getPatientList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMMUPatientList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getOnlinePatientList", method = RequestMethod.POST)
	public String getOnlinePatientList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getOnlinePatientList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getPreConsultationPatientListOnline", method = RequestMethod.GET)
	public ModelAndView getPreConsultationPatientListOnline(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("z-mmu-pendingListOfPreConsultationOnline");
		return mv;
	}
	
	@RequestMapping(value = "/getPatientDataBasedOnVisit", method = RequestMethod.GET)
	public ModelAndView patientObesityDetailjsp(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "z-mmu-capturePreConsultationOnline";
		int visitId = Integer.parseInt(request.getParameter("visitId"));
		String payload = "{\"visitId\":" + visitId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getPatientDataBasedOnVisit");
		String result = RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, payload);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", result);
		mv.setViewName(jsp);
		return mv;
	}
	
	@RequestMapping(value = "/saveVitalDetailsAndUpdateVisit", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public String saveVitalDetailsAndUpdateVisit(@RequestBody String inputJson, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveVitalDetailsAndUpdateVisit");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, inputJson);
	}
	
	@RequestMapping(value = "/getWardListWithoutCity", method = RequestMethod.POST)
	public String getWardListWithoutCity(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getWardListWithoutCity");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getAllSymptoms", method = RequestMethod.POST)
	public String getAllSymptoms(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getAllSymptoms");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/campMonthlyPlanReport", method = RequestMethod.GET)
	public ModelAndView campMonthlyPlanReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("mis_campRoster");
		return mv;
	}
	
	@RequestMapping(value = "/showOPDRegister", method = RequestMethod.GET)
	public ModelAndView showOPDRegister(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("showOPDRegister");
		return mv;
	}
	
	@RequestMapping(value = "/getRelationList", method = RequestMethod.POST)
	public String getRelationList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getRelationList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getFrequentlyUsedSymptomsList", method = RequestMethod.POST)
	public String getFrequentlyUsedSymptomsList(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getFrequentlyUsedSymptomsList");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/labourRegistration", method = RequestMethod.GET)
	public ModelAndView labourRegistration(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("labourRegistration");
		return mv;

	}
	
	@RequestMapping(value = "/saveLabourRegistration", method = RequestMethod.POST)
	public String saveLabourRegistration(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "saveLabourRegistration");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/checkIfPatientIsAlreadyRegistered", method = RequestMethod.POST)
	public String checkIfPatientIsAlreadyRegistered(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "checkIfPatientIsAlreadyRegistered");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}

	@RequestMapping(value = "/deleteCampPlan", method = RequestMethod.POST)
	public String deleteCampPlan(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "deleteCampPlan");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/getFutureCampPlan", method = RequestMethod.POST)
	public String getFutureCampPlan(@RequestBody String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getFutureCampPlan");
		return RestUtils.postWithHeaders(ipAndPort.trim() + OSBURL.trim(), requestHeaders, data);

	}
	
	@RequestMapping(value = "/showPatientHistory", method = RequestMethod.GET)
	public ModelAndView showPatientHistory(HttpServletRequest request,	HttpServletResponse response) {
		////System.out.println("called");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsp = "showPatientHistory";
		Long patientId= Long.parseLong(request.getParameter("patientId"));
		////System.out.println("patientId###"+patientId);
		String payload = "{\"patientId\":"+patientId+"}";
		ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	}
	
}
