package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public interface DigiFileUploadService {

	String getWaitingTagAndDataEntry(String payload, HttpServletRequest request, HttpServletResponse response);

	String submitNewEntryForm3B(String string, MultipartHttpServletRequest request, HttpServletResponse response);

	String dataSaveAmsfForm15(String payload, HttpServletRequest request, HttpServletResponse response);

	String dataSaveSpecialistOpinion(String payload, HttpServletRequest request, HttpServletResponse response);

	String getSubInvestigationHtml(String payload, HttpServletRequest request, HttpServletResponse response);

	String getInvestigationAndSubInvesForTemplate(String payload, HttpServletRequest request,
			HttpServletResponse response);

	String getFamilyDetailsHistory(String payload, HttpServletRequest request, HttpServletResponse response);

}
