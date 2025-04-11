package com.mmu.web.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mmu.web.dto.CaptureInvoice;
import com.mmu.web.dto.CaptureInvoices;
import com.mmu.web.service.MasterService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@RestController
@RequestMapping("/captureMedicine")
@CrossOrigin
public class CaptureMedicineIssue {
	
	@Autowired
	private Environment environment;

	@Autowired
	MasterService masterService;
	String IpAndPortNo = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	
	@RequestMapping(value="/issue", method = RequestMethod.GET)
	public ModelAndView medicineIssue() {
		return new ModelAndView("captureMedicineIssues");
	}
	
	@RequestMapping(value="/pendingmedicineinvoice", method = RequestMethod.GET)
	public ModelAndView pendingMedicineIssue(HttpServletRequest request, HttpServletResponse response) {
		//return new ModelAndView("pendingMedicineInvoice");
		return new ModelAndView("pendingMedicineInvoice_new");
	}
	
	@RequestMapping(value="/invoiceDashboard", method = RequestMethod.GET)
	public ModelAndView invoiceDashBoard(HttpServletRequest request, HttpServletResponse response) {
		Object invoiceFromDate = request.getSession().getAttribute("invoice_fromDate");
		ModelAndView mv = new ModelAndView("invoiceDashboard_1");
		if(invoiceFromDate!= null) {
			try {
				mv.addObject("invoice_fromDate", new ObjectMapper().writeValueAsString(invoiceFromDate));
			} catch (JsonProcessingException e) {
				mv.addObject("invoice_fromDate","{}");
			}
			request.getSession().removeAttribute("invoice_fromDate");
		}else {
			mv.addObject("invoice_fromDate","{}");
		}
	 		Box box = HMSUtil.getBox(request);
	 		JSONObject obj = new JSONObject(box);
		
	 		String responseData  =   masterService.checkFinancialYear(obj.toString(), request, response);
			JSONObject jSONObject =new JSONObject (responseData);
		     
			String financialYear = jSONObject.get("financialYear").toString();
			String [] fay=null;
			String finalYearVV="0000";
			if(financialYear!=null && financialYear.contains("-")) {
				fay=financialYear.split("-");
			    if(fay!=null) {
			    	finalYearVV=fay[0]; 	
			    }	
			}else {
				if(financialYear!=null && !financialYear.equalsIgnoreCase("")) {
					finalYearVV=financialYear;
				}
				
			}
			
		 	mv.addObject("financialYear", finalYearVV);
		
		return mv;
	}
	@RequestMapping(value="/fundManagementDashboard", method = RequestMethod.GET)
	public ModelAndView fundManagementDashboard(HttpServletRequest request, HttpServletResponse response) {
	
		//return new ModelAndView("fundManagementDashboard");
		Object invoiceFromDate = request.getSession().getAttribute("fundmgmt_fromDate");
		ModelAndView mv = new ModelAndView("fundManagementDashboard");
		if(invoiceFromDate!= null) {
			try {
				mv.addObject("fundmgmt_fromDate", new ObjectMapper().writeValueAsString(invoiceFromDate));
			} catch (JsonProcessingException e) {
				mv.addObject("fundmgmt_fromDate","{}");
			}
			request.getSession().removeAttribute("invoice_fromDate");
		}else {
			mv.addObject("fundmgmt_fromDate","{}");
		}
		Box box = HMSUtil.getBox(request);
 		JSONObject obj = new JSONObject(box);
	
 		String responseData  =   masterService.checkFinancialYear(obj.toString(), request, response);
		JSONObject jSONObject =new JSONObject (responseData);
	     
		String financialYear = jSONObject.get("financialYear").toString();
		String [] fay=null;
		String finalYearVV="0000";
		if(financialYear!=null && financialYear.contains("-")) {
			fay=financialYear.split("-");
		    if(fay!=null) {
		    	finalYearVV=fay[0]; 	
		    }	
		}else {
			if(financialYear!=null && !financialYear.equalsIgnoreCase("")) {
				finalYearVV=financialYear;
			}
		}
		
	 	mv.addObject("financialYear", finalYearVV);
	
		
		return mv;
	}
	@RequestMapping(value="/fundOperationDashboard", method = RequestMethod.GET)
	public ModelAndView fundOperationDashboard(HttpServletRequest request, HttpServletResponse response) {
		


		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Map<String, String> mapRequest = request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                  entry -> entry.getKey(),
                  entry -> entry.getValue()[0]));
		request.getSession().setAttribute("fundmgmt_fromDate", mapRequest);
		ModelAndView mv = new ModelAndView("fundAllocationOperatinalDashboard");
		String requestParam= "";
		try {
			requestParam = new ObjectMapper().writeValueAsString(mapRequest);
			String URL = HMSUtil.getProperties("urlextension.properties", "getFundInvoicDashboardData");
			
			String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, requestParam);
			mv.addObject("requestParam", requestParam);
			mv.addObject("response", responseData);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mv;
	}
	@RequestMapping(value="/fundUtilzationDashboard", method = RequestMethod.GET)
	public ModelAndView fundUtilizationOperatinalDashboard(HttpServletRequest request, HttpServletResponse response) {
	

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Map<String, String> mapRequest = request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                  entry -> entry.getKey(),
                  entry -> entry.getValue()[0]));
		request.getSession().setAttribute("fundmgmt_fromDate", mapRequest);
		ModelAndView mv = new ModelAndView("fundUtilizationOperatinalDashboard");
		String requestParam= "";
		try {
			requestParam = new ObjectMapper().writeValueAsString(mapRequest);
			String URL = HMSUtil.getProperties("urlextension.properties", "getFundInvoicDashboardData");
			
			String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, requestParam);
			mv.addObject("requestParam", requestParam);
			mv.addObject("response", responseData);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mv;
	}
	@RequestMapping(value="/fundUtilzationMedicineDashboard", method = RequestMethod.GET)
	public ModelAndView fundUtilzationMedicineDashboard(HttpServletRequest request, HttpServletResponse response) {
	

		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Map<String, String> mapRequest = request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                  entry -> entry.getKey(),
                  entry -> entry.getValue()[0]));
		request.getSession().setAttribute("fundmgmt_fromDate", mapRequest);
		ModelAndView mv = new ModelAndView("fundUtilizationMedicineDashboard");
		String requestParam= "";
		try {
			requestParam = new ObjectMapper().writeValueAsString(mapRequest);
			String URL = HMSUtil.getProperties("urlextension.properties", "getFundInvoicDashboardData");
			
			String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, requestParam);
			mv.addObject("requestParam", requestParam);
			 
			mv.addObject("response", responseData);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mv;
	}
	@RequestMapping(value="/authorityWiseStatus", method = RequestMethod.GET)
	public ModelAndView authorityWiseStatus(HttpServletRequest request, HttpServletResponse response) {
		String Id = request.getParameter("id");
		String jsp = "authorityWiseStatus";
		ModelAndView mv = new ModelAndView();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String payload = "{\"authId\":\"" + Id + "\"}";
		String URL = HMSUtil.getProperties("urlextension.properties", "getAuthorityWiseData");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, payload);
		mv.addObject("response", responseData);
		mv.setViewName(jsp);
		return mv;
		
	}
	@RequestMapping(value="/invoiceDashboardClear", method = RequestMethod.GET)
	public ModelAndView invoiceDashBoardClear(HttpServletRequest request, HttpServletResponse response) {
	
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Map<String, String> mapRequest = request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                  entry -> entry.getKey(),
                  entry -> entry.getValue()[0]));
		request.getSession().setAttribute("invoice_fromDate", mapRequest);
		ModelAndView mv = new ModelAndView("invoiceDashboardCleared");
		String requestParam= "";
		try {
			requestParam = new ObjectMapper().writeValueAsString(mapRequest);
			String URL = HMSUtil.getProperties("urlextension.properties", "getUpssInvoiceData");
			
			String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, requestParam);
			mv.addObject("requestParam", requestParam);
			mv.addObject("response", responseData);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mv;
	}
	@RequestMapping(value="/invoiceDashboardTotal", method = RequestMethod.GET)
	public ModelAndView invoiceDashBoardTotal(HttpServletRequest request, HttpServletResponse response) {	
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Map<String, String> mapRequest = request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                  entry -> entry.getKey(),
                  entry -> entry.getValue()[0]));
		request.getSession().setAttribute("invoice_fromDate", mapRequest);
		ModelAndView mv = new ModelAndView("invoiceDashboardTotal");
		String requestParam= "";
		try {
			requestParam = new ObjectMapper().writeValueAsString(mapRequest);
			String URL = HMSUtil.getProperties("urlextension.properties", "getUpssInvoiceData");
			
			String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, requestParam);
			mv.addObject("requestParam", requestParam);
			mv.addObject("response", responseData);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping(value="/invoiceDashboardMedicine", method = RequestMethod.GET)
	public ModelAndView invoiceDashboardLink(HttpServletRequest request, HttpServletResponse response) {
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Map<String, String> mapRequest = request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                  entry -> entry.getKey(),
                  entry -> entry.getValue()[0]));
		request.getSession().setAttribute("invoice_fromDate", mapRequest);
		ModelAndView mv = new ModelAndView("invoiceDashboardMedicine");
		String requestParam= "";
		try {
			requestParam = new ObjectMapper().writeValueAsString(mapRequest);
			String URL = HMSUtil.getProperties("urlextension.properties", "getMedicineInvoiceData");
			
			String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, requestParam);
			mv.addObject("requestParam", requestParam);
			mv.addObject("response", responseData);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mv;
	}
	@RequestMapping(value="/invoiceDashboardMmuExpenditure", method = RequestMethod.GET)
	public ModelAndView invoiceDashboardMmuExpenditure(HttpServletRequest request, HttpServletResponse response) {
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		Map<String, String> mapRequest = request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                  entry -> entry.getKey(),
                  entry -> entry.getValue()[0]));
		request.getSession().setAttribute("invoice_fromDate", mapRequest);
		ModelAndView mv = new ModelAndView("invoiceDashboardMmuExpenditure");
		String requestParam= "";
		try {
			requestParam = new ObjectMapper().writeValueAsString(mapRequest);
			String URL = HMSUtil.getProperties("urlextension.properties", "getMMUMedicineData");
			
			String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, requestParam);
			mv.addObject("requestParam", requestParam);
			mv.addObject("response", responseData);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping(value="/updateMedicineIssue", method = RequestMethod.GET)
	public ModelAndView updateMedicineIssue(HttpServletRequest request, HttpServletResponse response) {
		String Id = request.getParameter("id");
		
		
		String jsp = "capturemedicineIssueUpdate";
		ModelAndView mv = new ModelAndView();
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		
		String payload = "{\"Id\":\"" + Id + "\"}";
		String URL = HMSUtil.getProperties("urlextension.properties", "getInvoiceList");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, payload);
		mv.addObject("response", responseData);
		mv.setViewName(jsp);
		
		
		return mv;
	}
	
	@RequestMapping(value = "/sourceOfMedicine", method = RequestMethod.GET)
	public String getAllSourceMedicine(HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "sourceOfMedicine");
		
		return RestUtils.getWithHeaders(IpAndPortNo+URL, requestHeaders);
	}
	
	@RequestMapping(value = "/getMedicalStore", method = RequestMethod.POST)
	public String getAllMedicalStore(@RequestBody Map<String,Object> sourceOfMedicine,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMedicalStore");
		URL=URL+"/"+sourceOfMedicine.get("sourceOfMedicine")+"/"+sourceOfMedicine.get("districtId");
		return RestUtils.getWithHeaders(IpAndPortNo+URL, requestHeaders);
	}
	
	@RequestMapping(value = "/getMedicalStores", method = RequestMethod.GET)
	public String getAllMedicalStores(HttpServletRequest request,
							 HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "getMedicalStores");
		
		return RestUtils.getWithHeaders(IpAndPortNo+URL, requestHeaders);
	}
	

	@RequestMapping(value = "/captureInvoiceDetail", method = RequestMethod.POST)
	public String saveMedicalInvoice(@ModelAttribute CaptureInvoices captureInvoice,HttpServletRequest request){
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "captureInvoiceDetail");
		String requestBody = null;
		try {
		ObjectMapper objectmapper =new ObjectMapper();
		
		Set<CaptureInvoice> invoiceDetailList = new HashSet<>();
		invoiceDetailList.addAll(captureInvoice.getInvoiceDetails());
		if (invoiceDetailList.size() != captureInvoice.getInvoiceDetails().size()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("status", 0);
			map.put("msg", "Record already exists.");
			return objectmapper.writeValueAsString(map);
		}
		 
		String cityIdUser = (String) request.getSession().getAttribute("cityIdUsers");
		if(cityIdUser!= null && !cityIdUser.trim().isEmpty()) {
			if(cityIdUser.contains(",")) {
				cityIdUser=cityIdUser.split("\\,")[0];
			}
		}
		captureInvoice.setUserCityId(cityIdUser);
		
			List<CaptureInvoice> invoiceDetails= new ArrayList<>();
			for(int i=0;i<captureInvoice.getInvoiceDetails().size();i++) {
				CaptureInvoice capInvoice = captureInvoice.getInvoiceDetails().get(i);
				if(capInvoice.getFileTypeValue()!= null)
					save(capInvoice.getFileTypeValue()); 
				capInvoice.setFileTypeValue(null); 
				invoiceDetails.add(capInvoice);
			}
			captureInvoice.setInvoiceDetails(invoiceDetails);
			requestBody = objectmapper.writeValueAsString(captureInvoice);
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return RestUtils.postWithHeaders(IpAndPortNo+URL, requestHeaders,requestBody);
	}
	
	@RequestMapping(value = "/medicineInvoiceList", method = RequestMethod.POST)
	public String getMedicalInvoiceList(){
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String URL = HMSUtil.getProperties("urlextension.properties", "medicineInvoiceList");
		return RestUtils.getWithHeaders(IpAndPortNo+URL, requestHeaders);
	}
	@RequestMapping(value = "/searchMedicineInvoice", method = RequestMethod.POST,consumes = "application/json")
	public String searchMedicalInvoiceList(@RequestBody Map<String,Object> medicineSearch,HttpServletRequest request){
		String cityIdUser = (String) request.getSession().getAttribute("cityIdUsers");
		if(cityIdUser!= null && !cityIdUser.trim().isEmpty()) {
			if(cityIdUser.contains(",")) {
				cityIdUser=cityIdUser.split("\\,")[0];
			}
		}
		medicineSearch.put("cityIdUser", cityIdUser);
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();		
		String URL = HMSUtil.getProperties("urlextension.properties", "medicineInvoiceList");
		ObjectMapper objectmapper =new ObjectMapper();
		String requestBody="";
		try {
			requestBody = objectmapper.writeValueAsString(medicineSearch);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return RestUtils.postWithHeaders(IpAndPortNo+URL, requestHeaders,requestBody);
	}

	@RequestMapping(value="/download", method = RequestMethod.GET)
	 public void downloadFile(@RequestParam("fileName") String fileName,HttpServletResponse response) {
		  
		 
	      if (fileName.indexOf(".xls")>-1 || fileName.indexOf(".xlsx")>-1) response.setContentType("application/vnd.ms-excel");
	     
	      if (fileName.indexOf(".pdf")>-1) response.setContentType("application/pdf");
	     
	      response.setHeader("Content-Disposition", "inline; filename="+fileName);
	      response.setHeader("Content-Transfer-Encoding", "binary");
	      FileInputStream fis = null;
	      String basePath = environment.getProperty("mmu.web.invoicedetails.basePath");
	      try {
	    	  BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
	    	  fis = new FileInputStream(basePath+"/"+fileName);
	    	  int len;
	    	  byte[] buf = new byte[1024];
	    	  while((len = fis.read(buf)) > 0) {
	    		  bos.write(buf,0,len);
	    	  }
	    	  bos.close();
	    	  response.flushBuffer();
	    	  
	      }
	      catch(IOException e) {
	    	  e.printStackTrace();
	    	  
	      }
	      finally {
	    	  if(fis!= null)
				try {
					fis.close();
				} catch (IOException e) {
					
					e.printStackTrace();
				}
	      }
	 }
	
	public void save(MultipartFile multipartFile) 
	{
		 try {
		String basePath = environment.getProperty("mmu.web.invoicedetails.basePath");
		File dir = new File(basePath);
	    if (!dir.exists()) {
	    	dir.mkdirs();
	    }
		String fileName= multipartFile.getOriginalFilename();
		File file = new File(basePath+"/"+fileName);
		if(file.exists()) {
			file.delete();
		}
		Path root = Paths.get(basePath);
	   
	      Files.copy(multipartFile.getInputStream(), root.resolve(fileName));
	    } catch (Exception e) {
	      throw new RuntimeException("Could not store the file. Error: " + e.getMessage());
	    }
	  }
	@RequestMapping(value="/issueIEC", method = RequestMethod.GET)
	public ModelAndView medicineIssueIEC() {
		return new ModelAndView("captureMedicineIssuesIEC");
	}
	@RequestMapping(value="/pendingmedicineinvoiceIEC", method = RequestMethod.GET)
	public ModelAndView pendingMedicineIssueIEC(HttpServletRequest request, HttpServletResponse response) {
		//return new ModelAndView("pendingMedicineInvoice");
		return new ModelAndView("pendingMedicineInvoice_newIEC");
	}	
	@RequestMapping(value="/updateMedicineIssueIEC", method = RequestMethod.GET)
	public ModelAndView updateMedicineIssueIEC(HttpServletRequest request, HttpServletResponse response) {
		String Id = request.getParameter("id");
		
		
		String jsp = "capturemedicineIssueUpdateIEC";
		ModelAndView mv = new ModelAndView();
		
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		
		String payload = "{\"Id\":\"" + Id + "\"}";
		String URL = HMSUtil.getProperties("urlextension.properties", "getInvoiceList");
		String responseData = RestUtils.postWithHeaders(IpAndPortNo.trim() + URL.trim(), requestHeaders, payload);
		mv.addObject("response", responseData);
		mv.setViewName(jsp);
		
		
		return mv;
	}
	}
