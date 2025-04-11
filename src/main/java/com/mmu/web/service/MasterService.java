package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;


@Repository
public interface MasterService {

	String getCommandDetails(String cmdPayload, HttpServletRequest request, HttpServletResponse response);
	String getAllCommandDetails(String cmdPayload, HttpServletRequest request, HttpServletResponse response);
	String getTradeDetails(String tradeDetailsPayload, HttpServletRequest request, HttpServletResponse response);
	String checkFinancialYear(String cmdPayload, HttpServletRequest request, HttpServletResponse response);

	
}
