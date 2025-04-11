package com.mmu.web.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Service
public interface ImportExportShipService {
	
	String getFileName();

	String zipFilesAndPlaceInDirectory(String commonFileName);

	String moveZipFile(String zipFileName, String userId, String flagForInsertOrUpdate, String flagForImportOrExport);

	String getExportSyncTableList(JSONObject jsonObject, HttpServletRequest request, HttpServletResponse response);

	Map<String, Object> getHospitalList(Map<String, Object> inputJson);

	void updateStatusInSyncData(String fName, String flag);

	String extractCSVFromZipShip(String fileName);

	String uploadFile(CommonsMultipartFile[] uploadFile, String userId);

}
