package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;

@Repository
public interface TreatmentAuditWebService {

	String getAuditWaitingList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getAuditDetailModel(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPatientDianosisDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getInvestigationDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getTreatmentPatientDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String treatmentAuditSubmit(String payload, HttpServletRequest request, HttpServletResponse response);

	String getRecommendedDiagnosisAllDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getRecommendedInvestgationAllDetail(String payload, HttpServletRequest request,
			HttpServletResponse response);

	String getRecommendedTreatmentAllDetail(String payload, HttpServletRequest request, HttpServletResponse response);

	String getAllSymptomsForOpd(String payload, HttpServletRequest request, HttpServletResponse response);

	String getAllIcdForOpd(String payload, HttpServletRequest request, HttpServletResponse response);

	String getExpiryMedicine(String payload, HttpServletRequest request, HttpServletResponse response);

}
