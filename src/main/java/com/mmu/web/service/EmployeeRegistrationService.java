package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRegistrationService {

	String getSavedEmployeeList(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPendingAttendanceList(String payload, HttpServletRequest request, HttpServletResponse response);

	String pendingListPhoto(String payload, HttpServletRequest request, HttpServletResponse response);

	String getPenaltyList(String payload, HttpServletRequest request, HttpServletResponse response);

	String auditAttendanceHistory(String payload, HttpServletRequest request, HttpServletResponse response);

	String getEmpListForEdit(String payload, HttpServletRequest request, HttpServletResponse response);



}
