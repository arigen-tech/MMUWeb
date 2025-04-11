package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;

@Repository
public interface MedicalBoardService {

	String getMBWaitingList(String payload, HttpServletRequest request, HttpServletResponse response);

	String preliminaryMBWaitingDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveInvestigationMBdetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMBPreAssesWaitingList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMBPreAssesDetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveVitailsPatientdetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveRefferedOpinionMBdetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMedicalBoardAutocomplete(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientDetailToValidate(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientReferalDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getRefferedOpinionDetails(String payload, HttpServletRequest request, HttpServletResponse response);

	//String submitMedicalExamByMA(String string, HttpServletRequest request, HttpServletResponse response);

	String saveTranscriptionData(String payload, HttpServletRequest request, HttpServletResponse response);
	
	String getMOValidateWaitingList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getDataValidateAMSFform(String payload, HttpServletRequest request, HttpServletResponse response);

	String updateSpecialistOpiniondetails(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveAmsfForm15Details(String payload, HttpServletRequest request, HttpServletResponse response);

	String getDataValidateAMSF15form(String payload, HttpServletRequest request, HttpServletResponse response);

	String saveAmsf15CheckList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getAmsf15CheckList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getMBMedicalCategory(String payload, HttpServletRequest request, HttpServletResponse response);

	String getInvestigationAndResult(String payload, HttpServletRequest request, HttpServletResponse response);

	String getDocumentList(String payload, HttpServletRequest request, HttpServletResponse response);



}
