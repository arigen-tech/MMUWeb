package com.mmu.web.service;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Repository
public interface RegistrationService {

	String getEmployeeAndDependentData(String data, HttpServletRequest request, HttpServletResponse response);
	String getDepartmentBloodGroupAndMedicalCategory(String data, HttpServletRequest request, HttpServletResponse response);
	String getTokenNoForDepartmentMultiVisit(String data, HttpServletRequest request, HttpServletResponse response);
	String submitPatientDetails(String data, HttpServletRequest request, HttpServletResponse response);
	String showRegistrationAndAppointmentOthers(String data, HttpServletRequest request, HttpServletResponse response);
	String getTokenNoOfDepartmentForOthers(String data, HttpServletRequest request, HttpServletResponse response);
	String submitPatientDetailsForOthers(String data, HttpServletRequest request, HttpServletResponse response);
	String searchOthersRegisteredPatient(String data, HttpServletRequest request, HttpServletResponse response);
	String getPatientListFromServiceNo(String data, HttpServletRequest request, HttpServletResponse response);
	String uploadDocumentForPatient(HttpServletRequest request, CommonsMultipartFile[] fileUpload) throws Exception;
	String getAppointmentTypeList(String jsonPayload, HttpServletRequest request, HttpServletResponse response);
	String getDocumentListForPatient(String data, HttpServletRequest request, HttpServletResponse response);
	 Map<String,Object> viewUploadDocuments(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	String deleteUploadDocument(String data, HttpServletRequest request, HttpServletResponse response);
	String getExamSubType(String data, HttpServletRequest request, HttpServletResponse response);
	String getFutureAppointmentWaitingList(String data,HttpServletRequest request, HttpServletResponse response);
	String getInvestigationEmptyResultByOrderNo(String data, HttpServletRequest request, HttpServletResponse response);
	String submitInvestigationUp(String string, HttpServletRequest request, HttpServletResponse response);
	String getStateFromDistrict(String data, HttpServletRequest request, HttpServletResponse response);
	String uploadAuthorityLetter(HttpServletRequest request, CommonsMultipartFile[] uploadFile);
	String getRegionFromStation(String data, HttpServletRequest request, HttpServletResponse response);
	

}
