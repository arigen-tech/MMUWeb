package com.mmu.web.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
//import org.apache.poi.util.IOUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.mmu.web.dao.FileUploadDAO;
import com.mmu.web.entity.MasHospital;
import com.mmu.web.entity.SyncDataShip;
import com.mmu.web.service.ImportExportShipService;
import com.mmu.web.utils.HMSUtil;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;

@Service
public class ImportExportShipServiceImpl implements ImportExportShipService{
	@Autowired
	private FileUploadDAO fileUpload;
	
	private Logger logger = Logger.getLogger(ImportExportShipServiceImpl.class);

	@Override
	public String getFileName() {
 		String fileName = "";
		try {
			String unitCode = fileUpload.getUnitCode();
			if(unitCode == null) {
				unitCode = "";
			}
			
			Date today = new Date(); // Fri Jun 17 14:54:28 PDT 2016
			Calendar cal = Calendar.getInstance();
			cal.setTime(today); // don't forget this if date is arbitrary e.g. 01-01-2014

			String day = getDayNmonthNhourNminuteInTwoDigit(String.valueOf(cal.get(Calendar.DAY_OF_MONTH))); // 17
			String month = getDayNmonthNhourNminuteInTwoDigit(String.valueOf((cal.get(Calendar.MONTH)+1))); // 5
			String year = String.valueOf(cal.get(Calendar.YEAR)); // 2016
			String hour = getDayNmonthNhourNminuteInTwoDigit(String.valueOf(cal.get(Calendar.HOUR_OF_DAY)));
			String minute = getDayNmonthNhourNminuteInTwoDigit(String.valueOf(cal.get(Calendar.MINUTE)));
			String seconds = getDayNmonthNhourNminuteInTwoDigit(String.valueOf(cal.get(Calendar.SECOND)));
			fileName = unitCode+"_"+day + month + year + hour + minute + seconds+".zip";
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("", ex);
		}
 		return fileName;
	}
	
	public String getDayNmonthNhourNminuteInTwoDigit(String input) {
 		String output = "";
 		if(input.trim().length() == 1) {
 			output = "0"+input;
 		}else {
 			return input;
 		}
 		return output;
 	}

	@Override
	public String zipFilesAndPlaceInDirectory(String getNameOfFile) {
		//String getNameOfFile = getFileName();
		 JSONObject obj = new JSONObject();
		 
		 try {
			 	String directoryFlag = "Z";
				String filePath = fileUpload.getDirectoryShip(directoryFlag);
	        	JSONObject data = new JSONObject(filePath);
	        	String path = data.getString("exportPath");
	        	//String path = "E://oracle//Datapump//SYNC_ICG_SHIP_EXPORT";
	        	path = path.replace("/", "//");
	        	//path = "E:/src_folder/SYNC_ICG_EXPORT";
	        	System.out.println("source path is "+path);
	        	logger.info("the directory that contains csv files is "+path);   
	        	//comment below three line and uncomment next two line
	        	/*String windowPath = "E:/sourceFile";
	        	File directory = new File(path);
	        	String fileName = windowPath +"//"+getNameOfFile+".zip";*/
	            File directory = new File(path);
	        	String fileName = path +"//"+getNameOfFile;
	            System.out.println("the file path is "+directory.getPath());
	            
	            String[] files = directory.list();
		        System.out.println("fileName is with directory is "+fileName);
		        
		        String directoryFlag2 = "M";
				String filePath2 = fileUpload.getDirectoryShip(directoryFlag2);
	        	JSONObject data2 = new JSONObject(filePath2);
	        	String path2 = data2.getString("exportPath");
		        //String path2 = "E://oracle//Datapump//SYNC_ICG_SHIP_EXPORT_MOVE";
	        	path2 = path2.replace("/", "//");
	        	File fileOfPath2 = new File(path2);
	        	if(fileOfPath2.exists()) {
	        		 logger.info("path exists");
	        	}else {
	        		logger.info("path does not exists");
	        	}
	        	String fileName2 = path2+"//"+getNameOfFile;
		        FileOutputStream fout = new FileOutputStream(fileName2);
		        ZipOutputStream zos = new ZipOutputStream(fout);
		        byte bytes[] = new byte[2048];
		        logger.info("inside zipFiles method and all files are being iterated in loop");
		        logger.info("total files to be zipped is "+files.length);
		        for (String file : files) {
		            FileInputStream fis = new FileInputStream(directory.getPath() + "//"+file);
		            BufferedInputStream bis = new BufferedInputStream(fis);
		            System.out.println("the file is being put into zip file is "+file);
		            zos.putNextEntry(new ZipEntry(file));
	
		            int bytesRead;
		            while ((bytesRead = bis.read(bytes)) != -1) {
		                zos.write(bytes, 0, bytesRead);
		            }
		            logger.info("zip file has been created");
		            zos.closeEntry();
		            bis.close();
		            fis.close();
		        }
		        zos.flush();
		        zos.close();
		        obj.put("fileName", getNameOfFile);
		        obj.put("status", "1");
		        obj.put("msg", "success");
		 }catch(Exception ex) {
			 ex.printStackTrace();
			 obj.put("fileName", getNameOfFile);
		     obj.put("status", "0");
		     obj.put("msg", "Error occured while creating zip file");
		     logger.error("Error occured while creating zip file", ex);
		 }
	        return obj.toString();
	}

	@Override
	public String moveZipFile(String zipFileName, String userId, String flagForInsertOrUpdate,
			String flagForImportOrExport) {
		String message = fileUpload.moveZipFileShip(zipFileName, userId, flagForInsertOrUpdate, flagForImportOrExport);
		return message;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String getExportSyncTableList(JSONObject jsonObject, HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObj = new JSONObject();	
		List<Map<String, Object>> respList = new ArrayList<Map<String,Object>>();
		Map<String,Object> data = fileUpload.getExportToShipSyncTableList(jsonObject);
		List<SyncDataShip> exportTablist = new ArrayList<>();
		if(data.isEmpty()) {
				jsonObj.put("data", exportTablist);
				jsonObj.put("count", 0);
				jsonObj.put("msg", "No Record Found");
		}else{
			exportTablist = (List<SyncDataShip>) data.get("exportTablist");
			int count = (int) data.get("count");
			if (exportTablist != null && exportTablist.size() > 0) {
				
				for (SyncDataShip sync:exportTablist)
				{
					HashMap<String, Object> map = new HashMap<String, Object>();
					String syncId="", exportDate="", exportFileName="",exportStatus="",exportCount="",
							importDate="", importFileName="",importStatus="",importCount="";
					if(sync.getExpDate() != null) {
						exportDate = HMSUtil.changeDateToddMMyyyy(sync.getExpDate());
					}
					if(sync.getImpDate() != null) {
						importDate = HMSUtil.changeDateToddMMyyyy(sync.getImpDate());
					}
					exportFileName = HMSUtil.convertNullToEmptyString(sync.getExpSyncDir());
					exportStatus = HMSUtil.convertNullToEmptyString(sync.getExpStatus());
					exportCount = HMSUtil.convertNullToEmptyString(sync.getExpCount());
					importFileName = HMSUtil.convertNullToEmptyString(sync.getImpSyncDir());
					importStatus = HMSUtil.convertNullToEmptyString(sync.getImpStatus());
					importCount = HMSUtil.convertNullToEmptyString(sync.getImpCount());
					syncId = HMSUtil.convertNullToEmptyString(sync.getSyncId());
					map.put("exportFileName", exportFileName);
					map.put("downloadStatus", exportStatus);
					map.put("downloadCount", exportCount);
					map.put("exportDate", exportDate);
					map.put("importFileName", importFileName);
					map.put("importStatus", importStatus);
					map.put("uploadStatus", importCount);
					map.put("importDate", importDate);
					map.put("syncId", syncId);
					respList.add(map);
				}
				jsonObj.put("data", respList);
				jsonObj.put("count", count);
				jsonObj.put("msg", "Records are available");
			} else {
				jsonObj.put("data", exportTablist);
				jsonObj.put("count", 0);
				jsonObj.put("msg", "No Record Found");
			}
		}
		System.out.println(jsonObj.toString());
		return jsonObj.toString();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getHospitalList(Map<String, Object> inputJson) {
		
		Map<String, Object> map = new HashMap<>();
		List<Map<String,Object>> list = new ArrayList<>();
		try {
			//change function name
			Map<String, Object> outputJson = fileUpload.getHospitalList(inputJson);
			if(outputJson.isEmpty()) {
				map.put("status", 0);
				map.put("list", list);
			}else {
				//change entity name
				List<MasHospital> hospitalList = (List<MasHospital>) outputJson.get("list");
				if(hospitalList.isEmpty()) {
					map.put("status", 0);
					map.put("list", list);
				}else {
					for(MasHospital hospital : hospitalList) {
						Map<String,Object> data = new HashMap<>();
						String unitCode = "";
						if(hospital.getMasUnit() != null) {
							unitCode = HMSUtil.convertNullToEmptyString(hospital.getMasUnit().getUnitCode());
						}
						
						data.put("unitId", HMSUtil.convertNullToEmptyString(hospital.getUnitId()));
						data.put("hospitalId", hospital.getHospitalId());
						data.put("hospitalName", HMSUtil.convertNullToEmptyString(hospital.getHospitalName()));
						data.put("unitCode", unitCode);  
						list.add(data); 
					}
					map.put("status", 1);
					map.put("list", list);
				}
			}
		}catch (Exception ex) {
			ex.printStackTrace();
			map.put("status", 0);
			map.put("list", list);
		}

		return map;
	}

	@Override
	public void updateStatusInSyncData(String fName, String flag) {
		fileUpload.updateDownloadStatusInSyncData(fName, flag);
	}
	
	@Override
	public String extractCSVFromZipShip(String fileName) {
		JSONObject obj = new JSONObject();
		try {
			String password = "";
			String directoryFlag = "M";
			String p = fileUpload.getDirectoryShip(directoryFlag);
        	JSONObject data = new JSONObject(p);
        	String pathForZipFile = data.getString("importPath");
        	pathForZipFile = pathForZipFile.replace("/", "//");
            File file = new File(pathForZipFile+"//"+fileName);
			boolean exists = file.exists();
			if(!exists) {
				obj.put("status", "0");
				obj.put("msg", "File Does not exist in the directory");
				return obj.toString();
			}
			
			ZipFile zipFile = new ZipFile(file);
			if (zipFile.isEncrypted()) {
				zipFile.setPassword(password);
			}
			String dirResponse = fileUpload.getDirectoryShip("Z");
        	JSONObject pathForExtractingCSVJSON = new JSONObject(dirResponse);
        	String pathForExtractingCSV = pathForExtractingCSVJSON.getString("importPath");
        	pathForExtractingCSV = pathForExtractingCSV.replace("/", "//");
        	File fileNext = new File(pathForExtractingCSV);
        	if(!fileNext.exists()) {
        		obj.put("status", "0");
				obj.put("msg", "Directory does not exist for extracting CSV");
				return obj.toString();
        	}
			zipFile.extractAll(pathForExtractingCSV);
			obj.put("status", "1");
			obj.put("msg", "File extracted successfully");
			
			System.out.println("start of permission.sh execution");
			 String path = "//home//icg//permission.sh";
			 File fileDirectory = new File(path);
			 if(fileDirectory.exists()) {
				 ProcessBuilder pb = new ProcessBuilder("//home//icg//permission.sh", "", "");
				 Process process = pb.start();
				 BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
				 String line = null;
				 while ((line = reader.readLine()) != null)
				 {
				    System.out.println(line);
				 }
			 }
			 System.out.println("execution finished successfully");
			 
		}catch(Exception ex) {
			ex.printStackTrace();
			obj.put("status", "0");
			obj.put("msg", "Error occured while extracting CSV");
			logger.error("", ex);
		}
        
		return obj.toString();
	}

	public String uploadFile(CommonsMultipartFile[] commonsMultipartFiles, String userId) {
		String msg = "";
		for (CommonsMultipartFile aFile : commonsMultipartFiles) {
			try {
				String status = uploadZipFileToImportMoveDirectory(commonsMultipartFiles[0]);
				if(status.equalsIgnoreCase("0")) {
					msg = "Error while uploading zip file";
				}else if(status.equalsIgnoreCase("1")) {
					unzip(aFile);
					String originalFileName = aFile.getOriginalFilename();
					//call procedure moveZipFile for making entry in sync data from mobile to asha db and vice versa
					//to change permission of the files
					System.out.println("start of permission.sh execution");
					 String path = "//home//icg//permission.sh";
					 File file = new File(path);
					 if(file.exists()) {
						 ProcessBuilder pb = new ProcessBuilder("//home//icg//permission.sh", "", "");
						 Process p = pb.start();
						 BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
						 String line = null;
						 while ((line = reader.readLine()) != null)
						 {
						    System.out.println(line);
						 }
					 }
					 System.out.println("execution finished successfully");
					 
					 String result = fileUpload.importCSVShip(originalFileName);
					 //String checkAlterSequence = fileUpload.changeSequenceOfImportedData();
					
					 JSONObject js = new JSONObject(result);
					 String importStatus = String.valueOf(js.get("status"));
					 if(importStatus.equals("1")){
						 msg = "File has been successfully imported.";
					 }else {
						 msg = "Some error occured while importing Data.";
					 }
					 
					 
					/*String result = fileUpload.moveZipFile(originalFileName, userId,"I","I");
					JSONObject objJson = new JSONObject(result);
					String procedureStatus = String.valueOf(objJson.get("status"));
					System.out.println("upload procedure status is "+procedureStatus);
					if(procedureStatus.equals("1")) {
						String fileName = aFile.getOriginalFilename();
						System.out.println("uploaded file name is :: "+fileName);
						//fileUpload.updateStatusInSyncData(fileName, "U");
						msg = "File uploaded Successfully";
					}else if(procedureStatus.equals("0")){
						msg = objJson.getString("message");
					}else if(procedureStatus.equals("-1")) {
						msg = objJson.getString("message");
					}else if(procedureStatus.equals("2")) {
						msg = "Error occured during procedure call";
					}*/
					
				}
			} catch (Exception e) {
				e.printStackTrace();
				msg = "Error while extracting files";
				logger.error("", e);
			}
		}
		return msg;
	}
	
	private String uploadZipFileToImportMoveDirectory(CommonsMultipartFile aFile) {
		String result = "";
		try {
			//Z for get zip directory 
			//M for get Move directory
			String directoryFlag = "M";
			String filePath = fileUpload.getDirectoryShip(directoryFlag);
			JSONObject data = new JSONObject(filePath);
        	String path = data.getString("importPath");
        	System.out.println("import path ************************ "+path);
        	path = path.replace("/", "//");
        	String name = aFile.getOriginalFilename();
        	path = path+"//"+name;
        	System.out.println("path is "+path);
        	aFile.transferTo(new File(path));
	        result = "1";
		}catch(Exception ex) {
			ex.printStackTrace();
			result = "0";
			logger.error("", ex);
		}
		return result;
	}
	
	public void unzip(CommonsMultipartFile aFile) {
		String directoryFlag = "Z";
		String p = fileUpload.getDirectoryShip(directoryFlag);
    	JSONObject data = new JSONObject(p);
    	String destination = data.getString("importPath");
    	destination = destination.replace("/", "//");
    	System.out.println("destination path is "+destination);
    	logger.info("Directory for uploading file is :: "+destination);
		//String destination = "E:\\dest_folder";
		//String destination = "//u01//app//oracle//Datapump//SYNC_ICG";
		String password = "password";
		String msg = "";
		try {
			System.out.println("Temp Directory "+UUID.randomUUID().toString());
			logger.info("temp Directory "+UUID.randomUUID().toString());
			File zip = File.createTempFile(UUID.randomUUID().toString(), "temp");
			FileOutputStream o = new FileOutputStream(zip);
			//IOUtils.copy(aFile.getInputStream(), o);
			o.close();

			ZipFile zipFile = new ZipFile(zip);
			if (zipFile.isEncrypted()) {
				zipFile.setPassword(password);
			}
			System.out.println("zip files "+zipFile.getFile());
			logger.info("the files inside zip are :: "+zipFile.getFile());
			File path = new File(destination);
			boolean exists = path.exists();
			if(exists) {
				System.out.println("directory exists");
				logger.info("Directory for uploading file exist");
			}else {
				System.out.println("directory does not exists");
				logger.error("Directory for uploading file does not exist");
			}
			System.out.println("file is being extracted");
			logger.info("file is being extracted");
			zipFile.extractAll(destination);
			msg = "File extracted successfully";
			logger.info("the files imported successfully");
			System.out.println("the files uploaded successfully");
		} catch (ZipException e) {
			e.printStackTrace();
			msg = "Error while Extracting";
			logger.error("", e);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
}
