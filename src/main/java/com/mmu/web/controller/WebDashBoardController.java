package com.mmu.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.excel.FundAllocatedExcelReport;
import com.mmu.web.excel.FundUtilizedExcelReport;
import com.mmu.web.excel.InvoiceExcelReport;
import com.mmu.web.excel.MMUExpenditureMedicineExcelReport;
import com.mmu.web.excel.MedicineInvoiceExcelReport;
import com.mmu.web.excel.UPSSInvoiceExcelReport;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;



@RequestMapping("/dashboard")
@RestController
@CrossOrigin
public class WebDashBoardController {
	
	
	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT");	
	
	@RequestMapping(value = "/getDashBoardData", method = RequestMethod.POST)
	public String getDashBoardData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getDashBoardData");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	
	@RequestMapping(value = "/getHomePageData", method = RequestMethod.POST)
	public String getHomePageData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getHomePageData");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	
	@RequestMapping(value = "/getInvoiceData", method = RequestMethod.POST)
	public String getInvoiceData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getInvoiceData");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	
	@RequestMapping(value = "/getMedicineInvoiceData", method = RequestMethod.POST)
	public String getInvoiceMedicineData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getMedicineInvoiceData");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	
	@RequestMapping(value = "/getFundInvoicDashboardData", method = RequestMethod.POST)
	public String getFundInvoicDashboardData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getFundInvoicDashboardData");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	
	@RequestMapping(value = "/getInvoiceExcelReport", method = RequestMethod.GET)
	public ModelAndView exportExcelAiReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("distIdVal", request.getParameter("distIdVal"));
		payload.put("levelOfUser", request.getParameter("levelOfUser"));
		payload.put("phase", request.getParameter("phase"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getInvoiceData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("phase", request.getParameter("phase"));
		return new ModelAndView(new InvoiceExcelReport(), map);
			
	  }
	
	@RequestMapping(value = "/getMedicineInvoiceExcelReport", method = RequestMethod.GET)
	public ModelAndView exportMedicineInvoiceExcelReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("upss_id", request.getParameter("upss_id"));
		payload.put("flagType", request.getParameter("flagType"));
		payload.put("phase", request.getParameter("phase"));
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getMedicineInvoiceData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("upss_name", request.getParameter("upss_name"));
		map.put("flageTypeName", request.getParameter("flageTypeName"));
		map.put("phase", request.getParameter("phase"));
	    return new ModelAndView(new MedicineInvoiceExcelReport(), map);
			
	  }
	
	@RequestMapping(value = "/getInvoiceDashboardExcelReport", method = RequestMethod.GET)
	public ModelAndView exportInvoiceDetailExcelReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("upss_id", request.getParameter("upss_id"));
		payload.put("flagType", request.getParameter("flagType"));
		payload.put("phase", request.getParameter("phase"));
		payload.put("distIdVal", request.getParameter("distIdVal"));
		payload.put("levelOfUser", request.getParameter("levelOfUser"));
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getUpssInvoiceData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("flagType", request.getParameter("flagType"));
		map.put("upss_name", request.getParameter("upss_name"));
		map.put("phase", request.getParameter("phase"));
	    return new ModelAndView(new UPSSInvoiceExcelReport(), map);
			
	  }
	
	
	@RequestMapping(value = "/getMMUMedicineInvoiceExcelReport", method = RequestMethod.GET)
	public ModelAndView exportMMUMedicineInvoiceExcelReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("upss_id", request.getParameter("upss_id"));
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getMMUMedicineData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("upss_name", request.getParameter("upss_name"));
	    return new ModelAndView(new MMUExpenditureMedicineExcelReport(), map);
			
	  }
	
	@RequestMapping(value = "/getFundUtilzationOpeartionExcelReport", method = RequestMethod.GET)
	public ModelAndView getFundUtilzationOpeartionExcelReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("upss_id", request.getParameter("upss_id"));
		payload.put("flagType", request.getParameter("flagType"));
		payload.put("phase", request.getParameter("phase"));
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getFundInvoicDashboardData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("upss_name", request.getParameter("upss_name"));
		map.put("flagType", request.getParameter("flagType"));
		map.put("phase", request.getParameter("phase"));
	    return new ModelAndView(new FundUtilizedExcelReport(), map);
			
	  }
	
	@RequestMapping(value = "/getFundAllocationOpeartionExcelReport", method = RequestMethod.GET)
	public ModelAndView getFundAllocationOpeartionExcelReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("upss_id", request.getParameter("upss_id"));
		payload.put("flagType", request.getParameter("flagType"));
		payload.put("fundType", request.getParameter("fundType"));
		payload.put("phase", request.getParameter("phase"));
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getFundInvoicDashboardData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("upss_name", request.getParameter("upss_name"));
		map.put("flagType", request.getParameter("flagType"));
		map.put("fundType", request.getParameter("fundType"));
		map.put("phase", request.getParameter("phase"));
	    return new ModelAndView(new FundAllocatedExcelReport(), map);
			
	  }
	
	
	
	@RequestMapping(value = "/getAuditDashBoardData", method = RequestMethod.POST)
	public String getAuditDashBoardData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getAuditDashBoardData");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	

	@RequestMapping(value = "/getAuditDashBoardAuditorData", method = RequestMethod.POST)
	public String getAuditDashBoardAuditorData(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getAuditDashBoardAuditorData");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}
	
	@RequestMapping(value = "/getAllInvoiceDetail", method = RequestMethod.POST)
	public String getAllInvoiceDetail(@RequestBody String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getAllInvoiceDetail");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders, payload);
		
	}

	@RequestMapping(value = "/showInvoiceModal", method = RequestMethod.GET)
	public ModelAndView showInvoiceModal(HttpServletRequest request,	HttpServletResponse response) {
		//System.out.println("called");
		String jsp = "invoiceDetailForMmu";
		String mmuId=  request.getParameter("mmuId");
		String fromDate=  request.getParameter("fromDate");
		String toDate=  request.getParameter("toDate");
		//String payload = "{\"employeeId\":"+empid+"}";
		ModelAndView mv =new ModelAndView();
		mv.addObject("mmuId", mmuId);
		mv.addObject("fromDate", fromDate);
		mv.addObject("toDate", toDate);
		mv.setViewName(jsp);
		return mv;
	}

	

	@RequestMapping(value = "/getIECExcelReport", method = RequestMethod.GET)
	public ModelAndView getIECExcelReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		JSONObject payload=new JSONObject();
		payload.put("fromDate", request.getParameter("fromDate"));
		payload.put("toDate", request.getParameter("toDate"));
		payload.put("mmuCity", request.getParameter("mmuCity"));
		payload.put("upss_id", request.getParameter("upss_id"));
		payload.put("flagType", request.getParameter("flagType"));
		payload.put("phase", request.getParameter("phase"));
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();			
		String Url = HMSUtil.getProperties("urlextension.properties","getFundInvoicDashboardData");
		String OSBURL = IpAndPortNo + Url;	
		
		String data= RestUtils.postWithHeaders(OSBURL.trim(),requestHeaders	, payload.toString());
		Map<String,String> map = new HashMap<>();
		map.put("data", data);
		map.put("mmuCity", request.getParameter("mmuCity"));
		map.put("fromDate", request.getParameter("fromDate"));
		map.put("toDate", request.getParameter("toDate"));
		map.put("upss_name", request.getParameter("upss_name"));
		map.put("flageTypeName", request.getParameter("flageTypeName"));
		map.put("phase", request.getParameter("phase"));
	    return new ModelAndView(new MedicineInvoiceExcelReport(), map);
			
	  }
	
	
}
