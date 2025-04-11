package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Repository
public interface OpdService {

	String preConsPatientWatingWeb(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveVitailsPatientdetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String getIdealWeight(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdWaitingList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getIcdList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getFamilyPatientHistory(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdPatientDetailModel(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveOpdPatientdetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveOpdInvestigationTemplates(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveTreatmentOpdTemplates(String payload, HttpServletRequest request, HttpServletResponse response);

	String savePreocdureMasters(String payload, HttpServletRequest request, HttpServletResponse response);

	String getIinvestigationList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasStoreItemList(String payload, HttpServletRequest request, HttpServletResponse response);

	String obesityWaitingList(String payload);

	String getObesityDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasDisposalList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasFrequency(String payload, HttpServletRequest request, HttpServletResponse response);

	String getTemplateName(String payload, HttpServletRequest request, HttpServletResponse response);

	String getEmpanelledHospital(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasNursingCare(String payload, HttpServletRequest request, HttpServletResponse response);

	String getTemplateInvestigation(String payload, HttpServletRequest request, HttpServletResponse response);

	String getTemplateTreatment(String payload, HttpServletRequest request, HttpServletResponse response);

	String getCaseSheet(String payload, HttpServletRequest request, HttpServletResponse response);

	String getExaminationDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String updatAndInsertPatientRecall(String payload, HttpServletRequest request, HttpServletResponse response);

	String deleteGridRow(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientReferalDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientHistoryDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getTreatmentPatientDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getInvestigationDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdPreviousVisitRecord(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdReportsDetailsbyServiceNo(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdReportsDetailsbyPatinetId(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdPreviousVital(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasDispUnit(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasItemClass(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasStoreItemNip(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPocedureDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	//String getDocumentListForPatient(String data, HttpServletRequest request, HttpServletResponse response);

	//String uploadDocumentForPatient(HttpServletRequest request, CommonsMultipartFile[] uploadFile) throws Exception;

	//String deleteUploadDocument(String data, HttpServletRequest request, HttpServletResponse response);

	String saveEmpanlledHospitalMasters(String payload, HttpServletRequest request, HttpServletResponse response);

	String authenticateUser(String data, HttpServletRequest request, HttpServletResponse response);

	String getMasDepartmentList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMasHospitalList(String payload, HttpServletRequest request, HttpServletResponse response);

	String showCurrentMedication(String data, HttpServletRequest request, HttpServletResponse response);

	String checkForAuthenticateUser(String data, HttpServletRequest request, HttpServletResponse response);

	String updateCurrentMedication(String payload, HttpServletRequest request, HttpServletResponse response);

	String opdDeleteInvestigationTemplate(String payload, HttpServletRequest request, HttpServletResponse response);

	String getDispStockDetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String getDepartmentId(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPreviousLabInvestigation(String payload, HttpServletRequest request, HttpServletResponse response);

	String getRidcDocmentInfo(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdEmergencyShowEmployeeList(String requestData, HttpServletRequest request,
			HttpServletResponse response);

	String saveOpdEmergency(String payload, HttpServletRequest request, HttpServletResponse response);

	String getSpecialistList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getIcdListByName(String payload, HttpServletRequest request, HttpServletResponse response);
	String getDocumentListForPatient(String data, HttpServletRequest request, HttpServletResponse response);

	String uploadDocumentForPatient(HttpServletRequest request, CommonsMultipartFile[] uploadFile);

	String deleteUploadDocument(String data, HttpServletRequest request, HttpServletResponse response);

	String updateOpdInvestigationTemplates(String payload, HttpServletRequest request, HttpServletResponse response);

	String updateOpdTreatmentTemplates(String payload, HttpServletRequest request, HttpServletResponse response);

	String getUsersAuthentication(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveOpdMedicalAdviceTemplates(String payload, HttpServletRequest request, HttpServletResponse response);

	String getTemplateMedicalAdvice(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveOrUpdateChildVacatination(String payload, HttpServletRequest request, HttpServletResponse response);

	String getChildVacatinationRecord(String payload, HttpServletRequest request, HttpServletResponse response);

	String rejectOpdWaitingList(String payload, HttpServletRequest request, HttpServletResponse response);

	String geTreatmentInstruction(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientSympotons(String payload, HttpServletRequest request, HttpServletResponse response);

	String deletePatientSymptom(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientDianosisDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String documentUpload(String payload, MultipartFile ecgDoc, HttpServletRequest request, HttpServletResponse response);

	String getAIDiagnosisDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getAIInvestgationDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getAITreatmentDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientHistoryRecord(String payload, HttpServletRequest request, HttpServletResponse response);

	String getOpdPreviousAuditHistory(String payload, HttpServletRequest request, HttpServletResponse response);


}
