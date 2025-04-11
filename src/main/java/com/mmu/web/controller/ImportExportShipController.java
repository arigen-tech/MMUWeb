package com.mmu.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.dao.FileUploadDAO;
import com.mmu.web.service.ImportExportShipService;

@RestController
@CrossOrigin
@RequestMapping(value="/ship")
public class ImportExportShipController {
	@Autowired
	private ImportExportShipService exportImportService;
	
	@Autowired
	private FileUploadDAO fileUpload;
	
	private Logger logger = Logger.getLogger(ImportExportShipController.class);
	
	@RequestMapping(value="/ExportUtilToShip", method=RequestMethod.GET)	
	public ModelAndView exportUtility(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("exportToShipUtility");			
		return mav;			
	}
	
	@RequestMapping(value="/getHospitalList", method=RequestMethod.POST, consumes="application/json", produces="application/json")
	public ResponseEntity<Map<String,Object>> getHospitalList(@RequestBody Map<String,Object> inputJson){
		Map<String,Object> map = exportImportService.getHospitalList(inputJson);
		if(map.isEmpty()) {
			return new ResponseEntity<Map<String,Object>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK); 
	}
	
	@RequestMapping(value="/getExportSyncTableList", method=RequestMethod.POST)
	public String getExportSyncTableList(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response) {		
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		jsonObject.put("flag", "E");
		return exportImportService.getExportSyncTableList(jsonObject, request, response);
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/utility/getExportSyncTableList", requestHeaders, jsonObject.toString());
		
	}	
	
	@RequestMapping(value="/genrateCSV", method=RequestMethod.POST)
	public String genrateCSV(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {		
		String result = "";
		JSONObject jsonObject = new JSONObject();
		try {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String commonFileName=exportImportService.getFileName();
			//System.out.println("common file name  is "+commonFileName);
			String[] cArr = commonFileName.split("\\.");
			//System.out.println("cArr length is "+cArr.length);
			String fileNameWithoutExtension = commonFileName.split("\\.")[0];
			//System.out.println("fileNameWithoutExtension********************** "+fileNameWithoutExtension);
			result = fileUpload.generateShipCSV(fileNameWithoutExtension);
			
			JSONObject obj = new JSONObject(result);
			//System.out.println("generate csv procedure "+obj.toString());
			String status = String.valueOf(obj.get("status"));
/*			if(status.equals("1")) {
				jsonObject.put("msg", "Data Exported Successfully"); 
			}else {
				jsonObject.put("msg", "Some Error occured while exporting Files"); 
			}*/
			//String generateCSVMsg = String.valueOf(obj.get("msg"));
			if(status.equals("1")) {
				String zipFileJson = exportImportService.zipFilesAndPlaceInDirectory(commonFileName);
				JSONObject jsObj = new JSONObject(zipFileJson);
				String zipStatus = jsObj.getString("status");
				if(zipStatus.equals("0")) {
					jsonObject.put("msg", "Error occured while creating zip file"); 
				}else if(zipStatus.trim().equals("1")) {
						/*String zipFileName = jsObj.getString("fileName");
						String userId = String.valueOf(session.getAttribute("user_id"));
						String flagForInsertOrUpdate = "I"; //I for Insert  
						String flagForImportOrExport = "E"; //E for export
						String moveFileJSON = exportImportService.moveZipFile(zipFileName,userId,flagForInsertOrUpdate,flagForImportOrExport);
						JSONObject jsObject = new JSONObject(moveFileJSON);
						String statusforMoveFile = jsObject.getString("status");
						String messageForMoveFile = jsObject.getString("message");
						if(statusforMoveFile.equals("1")){*/
							jsonObject.put("msg", "Data Exported Successfully"); 
						/*}else if(statusforMoveFile.equals("-1") || statusforMoveFile.equals("0")) {
							jsonObject.put("msg", messageForMoveFile); 
						}else if(statusforMoveFile.equals("2")) {
							jsonObject.put("msg", "Error occured in moving zip file"); 
						}*/
				}
				
			}else if(status.equals("0")){
				jsonObject.put("msg", "Data is not available to export"); 
			}else if(status.equals("-1")){
				//jsonObject.put("msg", generateCSVMsg); 
			}else if(status.equals("2")) {
				jsonObject.put("msg", "Error occured while fetching data"); 
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			logger.error("", ex);
		}
		return jsonObject.toString();
	}	
	
	@RequestMapping(value="/downloadZip", method=RequestMethod.GET)	
	public ResponseEntity<InputStreamResource> downloadZip(HttpServletRequest request, HttpServletResponse response) {
		String msg = "";
		//JSONObject obj = new JSONObject(payload);
		//String fName = obj.getString("fileName");
		String fName=request.getParameter("fileName");
		
		ResponseEntity<InputStreamResource> obj2 = null;
		try {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			//byte[] data = exportService.downloadZipFromMoveDirectory(fName.trim(), response, request);			
			String directoryFlag = "M";
			String p = fileUpload.getDirectoryShip(directoryFlag);
        	JSONObject data1 = new JSONObject(p);
        	String path = data1.getString("exportPath");
        	path = path.replace("/", "//");
			File file = new File(path+"//"+fName);
			if(!file.isFile()){
		            String errorMessage = "Sorry. The file you are looking for does not exist";
		            //System.out.println(errorMessage);
		            OutputStream outputStream = response.getOutputStream();
		            outputStream.write(errorMessage.getBytes(Charset.forName("UTF-8")));
		            outputStream.close();
		            return obj2;
		        }
		      FileInputStream fis = new FileInputStream(file);
			  InputStreamResource resource = new InputStreamResource(fis);
		      obj2 =  ResponseEntity.ok()
		                .header(HttpHeaders.CONTENT_DISPOSITION,
		                      "attachment;filename=" + file.getName())
		                .contentType(MediaType.APPLICATION_OCTET_STREAM).contentLength(file.length())
		                .body(resource);
			
 			String flag = "D";
 			exportImportService.updateStatusInSyncData(fName, flag);
 			//System.out.println("download function is being called");
 			return obj2;
		} catch (Exception ex) {
			ex.printStackTrace(); 
			logger.error("", ex);
		}
		return obj2;
	}
	
	@RequestMapping(value="/importToShipUtil", method=RequestMethod.GET)	
	public ModelAndView importUtility(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("importToShipUtility");			
		return mav;
			
	}
	
	@RequestMapping(value="/importCSV", method=RequestMethod.POST)
	public String importCSV(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response) {		
		JSONObject jsonObject = new JSONObject(payload);
		String fileName = jsonObject.getString("fileName");
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		/*String Url = HMSUtil.getProperties("urlextension.properties", "importCSV");
		String OSBURL = IpAndPortNo + Url;	*/
		String extractCSVResponse = exportImportService.extractCSVFromZipShip(fileName);
		JSONObject jsonForCSVExtractiongResponse = new JSONObject(extractCSVResponse);
		String status = jsonForCSVExtractiongResponse.getString("status");
		String result = "";
		if(status.equalsIgnoreCase("1")) {
			result = fileUpload.importCSVShip(fileName);
		}else if(status.equalsIgnoreCase("0")){
			result = extractCSVResponse;
		}
		return result;
		//return RestUtils.postWithHeaders("http://192.168.203.172:8081/AshaServices/utility/importCSV", requestHeaders, jsonObject.toString());
		
	}	
	
	@RequestMapping(value="/downloadImportLog", method=RequestMethod.GET)	
	public ResponseEntity<InputStreamResource> downloadImportLog(HttpServletRequest request, HttpServletResponse response) {
		String msg = "";
		//JSONObject obj = new JSONObject(payload);
		//String fName = obj.getString("fileName");
		String fName=request.getParameter("fileName");
		
		ResponseEntity<InputStreamResource> obj2 = null;
		try {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			//byte[] data = exportService.downloadZipFromMoveDirectory(fName.trim(), response, request);			
			String directoryFlag = "M";
			String p = fileUpload.getDirectoryShip(directoryFlag);
        	JSONObject data1 = new JSONObject(p);
        	String path = data1.getString("importPath");
        	path = path.replace("/", "//");
        	//System.out.println("import path is this "+path);
			 File file = new File(path+"//"+fName);
		     if(!file.isFile()){
		            String errorMessage = "Sorry. The file you are looking for does not exist";
		            //System.out.println(errorMessage);
		            OutputStream outputStream = response.getOutputStream();
		            outputStream.write(errorMessage.getBytes(Charset.forName("UTF-8")));
		            outputStream.close();
		            return obj2;
		        }
		      FileInputStream fis = new FileInputStream(file);
			  InputStreamResource resource = new InputStreamResource(fis);
		      obj2 =  ResponseEntity.ok()
		                .header(HttpHeaders.CONTENT_DISPOSITION,
		                      "attachment;filename=" + file.getName())
		                .contentType(MediaType.APPLICATION_OCTET_STREAM).contentLength(file.length())
		                .body(resource);
			
 			String flag = "D";
 			exportImportService.updateStatusInSyncData(fName, flag);
 			//System.out.println("download function is being called");
 			return obj2;
		} catch (Exception ex) {
			ex.printStackTrace(); 
			logger.error("", ex);
		}
		return obj2;
	}
	
	@RequestMapping(value="/getImportSyncTableList", method=RequestMethod.POST)
	public String getImportSyncTableList(@RequestBody String payload, 
			HttpServletRequest request, HttpServletResponse response) {		
		JSONObject jsonObject = new JSONObject(payload);
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		jsonObject.put("flag", "I");
		//return exportService.getImportSyncTableList(request, response);
		return exportImportService.getExportSyncTableList(jsonObject, request, response);
		
	}	
	
	@RequestMapping(value="/uploadZipFile", method=RequestMethod.POST)
	public String uploadZipFile(HttpServletRequest request,
            @RequestParam CommonsMultipartFile[] uploadFile, HttpServletResponse response, HttpSession session)throws Exception {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String userId = String.valueOf(session.getAttribute("user_id"));
		String result = exportImportService.uploadFile(uploadFile, userId);
		return result;
	  }	
	
	
}
