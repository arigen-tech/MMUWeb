package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service
public interface LabService {
	
	String getPendingForSampleCollectionDetails(String reqPayload, HttpServletRequest request, HttpServletResponse response);

}
