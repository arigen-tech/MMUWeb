package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
@Service
public interface MedicalExamService {
	String getMEWaitingList(String payload, HttpServletRequest request, HttpServletResponse response);
	String getPatientDetailToValidate(String payload, HttpServletRequest request, HttpServletResponse response);
	String submitMedicalExamByMo(String string, HttpServletRequest request, HttpServletResponse response);
	String submitMedicalExamByMA(String string, HttpServletRequest request, HttpServletResponse response);
	String getAFMSF3BForMOOrMA(String payload, HttpServletRequest request, HttpServletResponse response);
	String getInvestigationAndResult(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMEApprovalWaitingGrid(String payload, HttpServletRequest request, HttpServletResponse response);
	String getPatientDetailOfVisitId(String payload, HttpServletRequest request, HttpServletResponse response);
	String getUnitDetail(String payload, HttpServletRequest request, HttpServletResponse response);
	String getApprovalListByFlag(String payload, HttpServletRequest request, HttpServletResponse response);
	String getPatientReferalDetailMe(String payload, HttpServletRequest request, HttpServletResponse response);
	String getImmunisationHistory(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMEWaitingGridAFMS18(String payload, HttpServletRequest request, HttpServletResponse response);
	String getPatientDetailOfVisitIdAfms18(String payload, HttpServletRequest request, HttpServletResponse response);
	String submitMedicalExamByMAForm18(String string, HttpServletRequest request, HttpServletResponse response);
	String getServiceDetails(String payload, HttpServletRequest request, HttpServletResponse response);
	String getPatientDiseaseWoundInjuryDetail(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMasEmployeeDetailForService(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMasDesignationMappingByUnitId(String payload, HttpServletRequest request, HttpServletResponse response);
	String getInvestigationListUOM(String string, HttpServletRequest request, HttpServletResponse response);
	String submitMedicalExamByMA3A(String string, HttpServletRequest request, HttpServletResponse response);
	String getPatientDetailOfVisitIdAfms18P(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMedicalExamListCommon(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMEMBHistory(String payload, HttpServletRequest request, HttpServletResponse response);
	String submitPatientImmunizationHistory(String payload, HttpServletRequest request, HttpServletResponse response);
	String saveItemCommon(String payload, HttpServletRequest request, HttpServletResponse response);
	String submitApprovalDate(String string, MultipartHttpServletRequest request, HttpServletResponse response);
	String getTemplateInvestDataForDiver(String payload, HttpServletRequest request, HttpServletResponse response);
 }
