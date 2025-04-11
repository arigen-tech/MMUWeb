package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
@Service
public interface SystemAdminService {
	 String getMasHospitalListForAdmin(String payload, HttpServletRequest request, HttpServletResponse response);
	 String getMasEmployeeDetail(String payload, HttpServletRequest request,
				HttpServletResponse response);
	 String getAllMasDesigation(String payload, HttpServletRequest request,
				HttpServletResponse response);
	   String submitUnitAdmin(String payload, HttpServletRequest request, HttpServletResponse response);
	   
	   String submitMasDesignation(String payload, HttpServletRequest request, HttpServletResponse response);
	String getUnitAdminDetail(String payload, HttpServletRequest request, HttpServletResponse response);
	String activateDeActivatUser(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMasDesinationDetail(String payload, HttpServletRequest request, HttpServletResponse response);
	String editDesignation(String payload, HttpServletRequest request, HttpServletResponse response);
	String getUnitAdminMasRole(String payload, HttpServletRequest request, HttpServletResponse response);
	String editUnitAdminUser(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMasDesigationForUnitId(String payload, HttpServletRequest request, HttpServletResponse response);
	String getAllServiceByUnitId(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMasUnitListByUnitCode(String payload, HttpServletRequest request, HttpServletResponse response);
	    
}
