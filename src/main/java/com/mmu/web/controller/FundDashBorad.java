package com.mmu.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.excel.FundManagementExcelReport;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RequestMapping("/funddashboard")
@RestController
@CrossOrigin
public class FundDashBorad {

	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT");
	@RequestMapping(value = "/fundmanagement", method = RequestMethod.GET)
	public ModelAndView exportExcelAiReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("flagType", request.getParameter("flagType"));
		payload.put("phase", request.getParameter("phase"));
		payload.put("distIdVal", request.getParameter("distIdVal"));
		payload.put("levelOfUser", request.getParameter("levelOfUser"));
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getFundInvoicDashboardData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("flagType", request.getParameter("flagType"));
		map.put("phase", request.getParameter("phase"));
		map.put("distIdVal", request.getParameter("distIdVal"));
		map.put("levelOfUser", request.getParameter("levelOfUser"));
	    return new ModelAndView(new FundManagementExcelReport(), map);
			
	  }
}
