package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;

@Repository
public interface LoginService {

	String executeDbProcedure(String payload, HttpServletRequest request, HttpServletResponse response);
	String executeDbProcedureforStatistics(String payload, HttpServletRequest request, HttpServletResponse response);
	String executeProcedureForDashBoard(String payload, HttpServletRequest request, HttpServletResponse response);
	String showApplicationsOnRoleBaseNew(String payload, HttpServletRequest request, HttpServletResponse response);
	String getPandmicZoneData(String payload, HttpServletRequest request, HttpServletResponse response);
	String getMMUServiceLogout(String payload, HttpServletRequest request, HttpServletResponse response);
	String getAuthenticateUser(String payload, HttpServletRequest request, HttpServletResponse response);

}
