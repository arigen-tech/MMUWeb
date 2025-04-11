package com.mmu.web.dao;


import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Repository;

import com.mmu.web.entity.UploadDocument;


@Repository
public interface FileUploadDAO {
	boolean save(UploadDocument uploadFile);
	Map<String, Object> showUploadedDocumentsForPatient(long patientId);
	List<UploadDocument> viewUploadDocuments(long documentId);
	boolean deleteUploadDocument(long fileId);
	
	String generateShipCSV(String fileNameWithoutExtension);
	Map<String, Object> getExportToShipSyncTableList(JSONObject jsonObject);
	String moveZipFileShip(String zipFileName, String userId, String flagForInsertOrUpdate,
			String flagForImportOrExport);
	String getDirectoryShip(String directoryFlag2);
	Map<String, Object> getHospitalList(Map<String, Object> inputJson);
	void updateDownloadStatusInSyncData(String fName, String flag);
	String getUnitCode();
	String importCSVShip(String fileName);
	String changeSequenceOfImportedData();
	List<Object[]> getInvestigationResultEmptyForfileUpload(Long patientId);
	
}