package com.mmu.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mmu.web.dao.ReportDao;
import com.mmu.web.service.StoresService;
import com.mmu.web.utils.Box;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

import jxl.Cell;
import jxl.CellView;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.format.Alignment;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

@RequestMapping("/store")
@RestController
@CrossOrigin
public class StoresWebController {


	@Autowired
	StoresService storesService;
	
	@Autowired
	ReportDao reportDao;
	
	@Autowired
	private Environment environment;
	
	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT").trim();
	
	@RequestMapping(value="/showopeningBalance", method = RequestMethod.GET)
	public ModelAndView showOpeningBalance(HttpServletRequest request, HttpServletResponse response) {
		String  data ="{}";
		data=storesService.showOpeningBalance(data,request, response);
		String jsp = "openingBalance";
		return new ModelAndView(jsp, "data", data);
	}
	
	
	  @RequestMapping(value="/getStoreItemList", method = RequestMethod.POST) 
	  public String getStoreItemList(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
	  return storesService.getStoreItemList( data,request, response); 
	  }
	
	  
	 /* @RequestMapping(value = "/submitOpeningBalanceData", method = RequestMethod.POST)
	  public ModelAndView submitStoreData(MultipartHttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String, Object>();
		String message="";
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
		//System.out.println("data head Type submit: " +data.toString() );
		data.put("invoiceName", this.uploadFile(request, "D"));
	    String jsonResponse= storesService.submitStoreData(data.toString(), request, response);
	    
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	message =  responseData.getString("message");
	    	map.put("message",message);
	    }
	    return new ModelAndView("successOpeningBalance", "map", map);
	  }	*/
	  
	  @RequestMapping(value="/submitOpeningBalanceData", method = RequestMethod.POST)
		 //HashMap<String,String> listMap =  new HashMap<String,String>();
		public String saveOpdPatientdetails(MultipartHttpServletRequest request, HttpServletResponse response) {	
		Box box = HMSUtil.getBox(request);
		JSONObject obj = new JSONObject(box);
	   //System.out.println("data head Type submit: " +obj.toString() );
	   obj.put("uploadFile", this.uploadFile(request, "D"));
	  
		String URL = HMSUtil.getProperties("urlextension.properties", "SUBMIT_STORE_ITEM_DATA");
		return RestUtils.postWithHeaders(
				(IpAndPortNo + URL).trim(),
				new LinkedMultiValueMap<String, String>(),
				obj.toString()
		);
			//return os.saveOpdPatientdetails(obj.toString(), request, response);
		}
	  
	  @RequestMapping(value = "/openingBalanceWatingList", method = RequestMethod.GET)
	  public ModelAndView openingBalanceWatingList(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "openingBalanceWatingList"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  
	  @RequestMapping(value = "/getOpeningBalanceWatingList", method = RequestMethod.POST)
	  public String getOpeningBalanceWatingList(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getOpeningBalanceWatingList(data,request, response);
		
	  }
	  
	  
	  @RequestMapping(value = "/openingBalanceApproval", method = RequestMethod.GET)
	  public ModelAndView openingBalanceApproval(HttpServletRequest request, HttpServletResponse response) {
	  String jsonResponse = storesService.getOpeningBalanceDetailsForApproval(request, response);
	  String jsp = "openingBalanceApproval"; 
	  return new ModelAndView(jsp, "jsonResponse", jsonResponse);
	  }
	  
	  
	
	  @RequestMapping(value = "/showOpeningBalanceRegister", method = RequestMethod.GET)
	  public ModelAndView successOpeningBalance(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "openingBalanceRegister"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  
	  @RequestMapping(value = "/submitOpeningBalanceDataForApproval", method = RequestMethod.POST)
	  public ModelAndView submitOpeningBalanceDataForApproval(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String, Object>();
		String message="";
		long balanceMId=0;
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
	    String jsonResponse= storesService.submitOpeningBalanceDataForApproval(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	balanceMId =Long.parseLong(responseData.get("balanceMId").toString());
	    	message =  responseData.getString("message");
	    	map.put("balanceMId",balanceMId);
	    	map.put("message",message);
	    }
	    return new ModelAndView("successOpeningBalance", "map", map);
	  }	
	  
	  @RequestMapping(value = "/showStockStatusReport", method = RequestMethod.GET)
	  public ModelAndView showStockStatusReport(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "stockStatusReport"; 
		  ModelAndView mv =new ModelAndView();
		  mv.setViewName(jsp);
		  return mv;
	  }
	  
	  @RequestMapping(value = "/showStockStatusReportCo", method = RequestMethod.GET)
	  public ModelAndView showStockStatusReportCo(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "stockStatusReportCo"; 
		  ModelAndView mv =new ModelAndView();
		  mv.setViewName(jsp);
		  return mv;
	  }
	  
	  @RequestMapping(value = "/mmuWiseStockStatusReportCo", method = RequestMethod.GET)
	  public ModelAndView mmuWiseStockStatusReportCo(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "mmuWiseStockStatusReportCo"; 
		  ModelAndView mv =new ModelAndView();
		  mv.setViewName(jsp);
		  return mv;
	  }
	  
	  @RequestMapping(value = "/mmuWiseStockStatusReportDo", method = RequestMethod.GET)
	  public ModelAndView mmuWiseStockStatusReportdo(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "mmuWiseStockStatusReportDo"; 
		  ModelAndView mv =new ModelAndView();
		  mv.setViewName(jsp);
		  return mv;
	  }
	  
	  
	  @RequestMapping(value = "/getDataForStockStatusReport", method = RequestMethod.POST)
	  public String getDataForStockStatusReport(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getDataForStockStatusReport(data,request, response);
	  }
	 
	  @RequestMapping(value = "/printStockStatusReport", method = RequestMethod.GET)
	  public ModelAndView printStockStatusReport(HttpServletRequest request, HttpServletResponse response) {
			String query="";
			int mmuId=0;
			int department=0;
			String radioValue="";
			String pvms="";
			String nomen="";
			int group=0;
			int section=0;
			int User_id=0;
			String Level_of_user="";

		/*
		 * if(request.getParameter("unitId")!=null &&
		 * Integer.parseInt(request.getParameter("unitId"))!=0 ) {
		 * hospital=Integer.parseInt(request.getParameter("unitId")); }
		 */
			if(request.getParameter("mmuId")!=null ) {
				mmuId=Integer.parseInt(request.getParameter("mmuId"));
			}
			
			if(request.getParameter("User_id")!=null && Integer.parseInt(request.getParameter("User_id"))!=0 ) {
				User_id=Integer.parseInt(request.getParameter("User_id"));
			}
			
			if(request.getParameter("Level_of_user")!=null && !request.getParameter("Level_of_user").toString().isEmpty()) {
				Level_of_user=request.getParameter("Level_of_user").toString();
			}
			
			
			if(request.getParameter("deptId")!=null && Integer.parseInt(request.getParameter("deptId"))!=0 ) {
				department=Integer.parseInt(request.getParameter("deptId"));
			}

			if(request.getParameter("radioStockStatus")!=null && !request.getParameter("radioStockStatus").toString().isEmpty()) {
				radioValue=request.getParameter("radioStockStatus").toString();
			}
			
			if(request.getParameter("pvms")!=null && !request.getParameter("pvms").toString().isEmpty()) {
				pvms=request.getParameter("pvms").toString();
				query += " and MAS_STORE_ITEM.PVMS_NO='"+pvms+"'";
			}
			
			if(request.getParameter("nomenclature")!=null && !request.getParameter("nomenclature").toString().isEmpty()) {
				nomen=request.getParameter("nomenclature").toString();
				query += " and MAS_STORE_ITEM.NOMENCLATURE like '"+nomen+"'";
			}
			
		/*
		 * if(request.getParameter("group")!=null &&
		 * Integer.parseInt(request.getParameter("group"))!=0) {
		 * group=Integer.parseInt(request.getParameter("group")); query +=
		 * " and MAS_STORE_ITEM.NOMENCLATURE like '"+group+"'"; }
		 * 
		 * if(request.getParameter("section")!=null &&
		 * Integer.parseInt(request.getParameter("section"))!=0) {
		 * section=Integer.parseInt(request.getParameter("section")); query +=
		 * " and MAS_STORE_ITEM.NOMENCLATURE like '"+section+"'"; }
		 */
			
			    query += " and store_item_batch_stock.CLOSING_STOCK>0";
			
			Map<String, Object> connectionMap = new HashMap<String, Object>();
			Map<String, Object> parameters = new HashMap<String, Object>();

			parameters.put("query", query);
			parameters.put("DEPARTMENT_ID", department);
			parameters.put("HOSPITAL_ID", mmuId);
			
			parameters.put("User_id", User_id);
			parameters.put("Level_of_user", Level_of_user);
			
			parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

			String userHome = request.getServletContext().getRealPath("/resources/images/");
			String imagePath = userHome+"/mmu-logo.png";
			parameters.put("path", imagePath);
			connectionMap = reportDao.getConnectionForReportMis();

			if ((radioValue).equalsIgnoreCase("D")) {
				HMSUtil.generateReportInPopUp("Stock_Status_Detail","StockStatusDetail", parameters, (Connection) connectionMap.get("conn"), response,
						request.getSession().getServletContext());
			} else {
				HMSUtil.generateReportInPopUp("Stock_Status_Summary","StockStatusSummary", parameters, (Connection) connectionMap.get("conn"), response,
						request.getSession().getServletContext());
			}
			return null;
		  }
	  
	  @RequestMapping(value = "/printStockStatusReportCo", method = RequestMethod.GET)
	  public ModelAndView printStockStatusReportCo(HttpServletRequest request, HttpServletResponse response) {
			String query="";
			int cityId=0;
			int department=0;
			String radioValue="";
			String pvms="";
			String nomen="";
			int group=0;
			int section=0;
			int User_id=0;
			String Level_of_user="";

			if(request.getParameter("cityId")!=null ) {
				cityId=Integer.parseInt(request.getParameter("cityId"));
			}
			
			if(request.getParameter("User_id")!=null && Integer.parseInt(request.getParameter("User_id"))!=0 ) {
				User_id=Integer.parseInt(request.getParameter("User_id"));
			}
			
			if(request.getParameter("Level_of_user")!=null && !request.getParameter("Level_of_user").toString().isEmpty()) {
				Level_of_user=request.getParameter("Level_of_user").toString();
			}
			
			
			if(request.getParameter("deptId")!=null && Integer.parseInt(request.getParameter("deptId"))!=0 ) {
				department=Integer.parseInt(request.getParameter("deptId"));
			}

			if(request.getParameter("radioStockStatus")!=null && !request.getParameter("radioStockStatus").toString().isEmpty()) {
				radioValue=request.getParameter("radioStockStatus").toString();
			}
			
			if(request.getParameter("pvms")!=null && !request.getParameter("pvms").toString().isEmpty()) {
				pvms=request.getParameter("pvms").toString();
				query += " and MAS_STORE_ITEM.PVMS_NO='"+pvms+"'";
			}
			
			if(request.getParameter("nomenclature")!=null && !request.getParameter("nomenclature").toString().isEmpty()) {
				nomen=request.getParameter("nomenclature").toString();
				query += " and MAS_STORE_ITEM.NOMENCLATURE like '"+nomen+"'";
			}
			
			    query += " and store_item_batch_stock.CLOSING_STOCK>0";
			
			Map<String, Object> connectionMap = new HashMap<String, Object>();
			Map<String, Object> parameters = new HashMap<String, Object>();

			parameters.put("query", query);
			//parameters.put("DEPARTMENT_ID", department);
			parameters.put("CITY_ID", cityId);
			
			//parameters.put("User_id", User_id);
			//parameters.put("Level_of_user", Level_of_user);
			
			parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

			String userHome = request.getServletContext().getRealPath("/resources/images/");
			String imagePath = userHome+"/mmu-logo.png";
			parameters.put("path", imagePath);
			connectionMap = reportDao.getConnectionForReportMis();

			if ((radioValue).equalsIgnoreCase("D")) {
				HMSUtil.generateReportInPopUp("Stock_CO_Status_Detail","StockStatusDetail", parameters, (Connection) connectionMap.get("conn"), response,
						request.getSession().getServletContext());
			} else {
				HMSUtil.generateReportInPopUp("Stock_CO_Status_Summary","StockStatusSummary", parameters, (Connection) connectionMap.get("conn"), response,
						request.getSession().getServletContext());
			}
			return null;
		  }
	  
	  @RequestMapping(value = "/printStockStatusReportDo", method = RequestMethod.GET)
	  public ModelAndView printStockStatusReportDo(HttpServletRequest request, HttpServletResponse response) {
			String query="";
			int districtId=0;
			int department=0;
			String radioValue="";
			String pvms="";
			String nomen="";
			int group=0;
			int section=0;
			int User_id=0;
			String Level_of_user="";

			if(request.getParameter("districtId")!=null ) {
				districtId=Integer.parseInt(request.getParameter("districtId"));
			}
			
			if(request.getParameter("User_id")!=null && Integer.parseInt(request.getParameter("User_id"))!=0 ) {
				User_id=Integer.parseInt(request.getParameter("User_id"));
			}
			
			if(request.getParameter("Level_of_user")!=null && !request.getParameter("Level_of_user").toString().isEmpty()) {
				Level_of_user=request.getParameter("Level_of_user").toString();
			}
			
			
			if(request.getParameter("deptId")!=null && Integer.parseInt(request.getParameter("deptId"))!=0 ) {
				department=Integer.parseInt(request.getParameter("deptId"));
			}

			if(request.getParameter("radioStockStatus")!=null && !request.getParameter("radioStockStatus").toString().isEmpty()) {
				radioValue=request.getParameter("radioStockStatus").toString();
			}
			
			if(request.getParameter("pvms")!=null && !request.getParameter("pvms").toString().isEmpty()) {
				pvms=request.getParameter("pvms").toString();
				query += " and MAS_STORE_ITEM.PVMS_NO='"+pvms+"'";
			}
			
			if(request.getParameter("nomenclature")!=null && !request.getParameter("nomenclature").toString().isEmpty()) {
				nomen=request.getParameter("nomenclature").toString();
				query += " and MAS_STORE_ITEM.NOMENCLATURE like '"+nomen+"'";
			}
			
			    query += " and store_item_batch_stock.CLOSING_STOCK>0";
			
			Map<String, Object> connectionMap = new HashMap<String, Object>();
			Map<String, Object> parameters = new HashMap<String, Object>();

			parameters.put("query", query);
			//parameters.put("DEPARTMENT_ID", department);
			parameters.put("DISTRICT_ID", districtId);
			
			//parameters.put("User_id", User_id);
			//parameters.put("Level_of_user", Level_of_user);
			
			parameters.put("SUBREPORT_DIR", request.getServletContext().getRealPath("/reports/"));

			String userHome = request.getServletContext().getRealPath("/resources/images/");
			String imagePath = userHome+"/mmu-logo.png";
			parameters.put("path", imagePath);
			connectionMap = reportDao.getConnectionForReportMis();

			if ((radioValue).equalsIgnoreCase("D")) {
				HMSUtil.generateReportInPopUp("Stock_DO_Status_Detail","StockStatusDetail", parameters, (Connection) connectionMap.get("conn"), response,
						request.getSession().getServletContext());
			} else {
				HMSUtil.generateReportInPopUp("Stock_DO_Status_Summary","StockStatusSummary", parameters, (Connection) connectionMap.get("conn"), response,
						request.getSession().getServletContext());
			}
			return null;
		  }
	  
	  
	  @RequestMapping(value = "/generateStockStatusReport", method = RequestMethod.POST)
	  public String generateStockStatusReport(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
			 return storesService.generateStockStatusReport(data,request, response);
	  }
	  
	  @RequestMapping(value = "/generateStockStatusReportCo", method = RequestMethod.POST)
	  public String generateStockStatusReportCo(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
			 return storesService.generateStockStatusReportCo(data,request, response);
	  }
	  
	  
	  @RequestMapping(value = "/showReceiveIndentWatingList", method = RequestMethod.GET)
	  public ModelAndView showReceiveIndentWatingList(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "receivingIndentWaiting"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  @RequestMapping(value = "/getReceivingIndentWaitingList", method = RequestMethod.POST)
	  public String getReceivingIndentWaitingList(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getReceivingIndentWaitingList(data,request, response);
		
	  }
	  	
	  
	  @RequestMapping(value = "/receivingIndentInInventory", method = RequestMethod.GET)
	  public ModelAndView receivingIndentInInventory(HttpServletRequest request, HttpServletResponse response) {
	  String jsonResponse = storesService.receivingIndentInInventory(request, response);
	  String jsp = "indentAcknowledgement"; 
	  return new ModelAndView(jsp, "jsonResponse", jsonResponse);
	  }
	 
	  
	  
	  @RequestMapping(value = "/addToStockIssuedIndent", method = RequestMethod.POST)
	  public ModelAndView addToStockIssuedIndent(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String, Object>();
		String message="";
		long indentMId=0;
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
	    String jsonResponse= storesService.addToStockIssuedIndent(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	indentMId = responseData.getLong("indentMId");
	    	message =  responseData.getString("message");
	    	map.put("message",message);
	    	map.put("indentMId",indentMId);
	    }
	    return new ModelAndView("successIndentAcknowledge", "map", map);
	  }	  
	  
	  
	  @RequestMapping(value = "/showPhysicalStockTaking", method = RequestMethod.GET)
	  public ModelAndView showPhysicalStockTaking(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "addPhysicalStock"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  	
		@RequestMapping(value = "/getItemListForAutoComplete", method = RequestMethod.POST)
		public String getItemListForAutoComplete(@RequestBody String data, HttpServletRequest request,
				HttpServletResponse response) {
			return storesService.getItemListForAutoComplete(data, request, response);
		} 
		  
	  @RequestMapping(value="/getItemStockDetailsFromStore", method = RequestMethod.POST) 
	  public String getItemStockDetailsFromStore(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
	  return storesService.getItemStockDetailsFromStore( data,request, response); 
	  }  
	  
	 
	  
	  @RequestMapping(value = "/updatePhysicalStockTaking", method = RequestMethod.POST)
	  public ModelAndView updatePhysicalStockTaking(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String, Object>();
		String message="";
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
	    String jsonResponse= storesService.updatePhysicalStockTaking(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	message =  responseData.getString("message");
	    	map.put("message",message);
	    }
	    return new ModelAndView("successStockTaking", "map", map);
	  }	
	  
	  
	  @RequestMapping(value = "/stockTakingWatingList", method = RequestMethod.GET)
	  public ModelAndView stockTakingWatingList(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "stockTakingWatingList"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  @RequestMapping(value = "/getstockTakingWatingListData", method = RequestMethod.POST)
	  public String getstockTakingWatingListData(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getstockTakingWatingListData(data,request, response);
		
	  }
	  
	  
	  @RequestMapping(value = "/stockTakingApproval", method = RequestMethod.GET)
	  public ModelAndView stockTakingApproval(HttpServletRequest request, HttpServletResponse response) {
	  String jsonResponse = storesService.stockTakingApproval(request, response);
	  String jsp = "physicalStockTakingApproval"; 
	  return new ModelAndView(jsp, "jsonResponse", jsonResponse);
	  }
	  
	  
	  @RequestMapping(value = "/submitStockTakingDataForApproval", method = RequestMethod.POST)
	  public ModelAndView submitStockTakingDataForApproval(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String, Object>();
		String message="";
		long takingMId=0;
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
	    String jsonResponse= storesService.submitStockTakingDataForApproval(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	takingMId =Long.parseLong(responseData.get("takingMId").toString());
	    	message =  responseData.getString("message");
	    	map.put("takingMId",takingMId);
	    	map.put("message",message);
	    }
	    return new ModelAndView("successStockTaking", "map", map);
	  }	
	  
	  
	  @RequestMapping(value = "/showStockTakingRegister", method = RequestMethod.GET)
	  public ModelAndView showStockTakingRegister(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "stockTakingRegister"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  
	  
	  @RequestMapping(value = "/showCreateSupplyOrder", method = RequestMethod.GET)
	  public ModelAndView showCreateSupplyOrder(HttpServletRequest request, HttpServletResponse response) {
	  String jsonResponse = storesService.showCreateSupplyOrder(request, response);
	  String jsp = "createSupplyOrder"; 
	  return new ModelAndView(jsp, "jsonResponse", jsonResponse);
	  }
	  
	  @RequestMapping(value = "/getSupplyOrderSanctionData", method = RequestMethod.POST)
	  public String getSupplyOrderSanctionData(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getSupplyOrderSanctionData(data,request, response);
		
	  }
	
	  @RequestMapping(value = "/saveSODetails", method = RequestMethod.POST)
	  public ModelAndView saveSODetails(HttpServletRequest request, HttpServletResponse response) {
		String message="";
		Map<String,Object> map = new HashMap<String, Object>();
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
		//System.out.println("save SO Details:" +data);
	    String jsonResponse= storesService.saveSODetails(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	message =  responseData.getString("message");
	    	map.put("message",message);
	    	map.put("requestType", "save");
	    }
	    return new ModelAndView("successSupplyOrder", "map", map);
	  }	
	  
	  
	  @RequestMapping(value = "/showSupplyOrderList", method = RequestMethod.GET)
	  public ModelAndView showSupplyOrderList(HttpServletRequest request, HttpServletResponse response) {
	  String jsp = "supplyOrderList"; 
	  ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	  }
	  
	  
	  @RequestMapping(value = "/getSupplyOrderWaitingList", method = RequestMethod.POST)
	  public String getSupplyOrderWaitingList(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getSupplyOrderWaitingList(data,request, response);
		
	  }
	  
	  @RequestMapping(value = "/showSupplyOrderPendingApprovalList", method = RequestMethod.GET)
	  public ModelAndView showSupplyOrderPendingApprovalList(HttpServletRequest request, HttpServletResponse response) {
	  String jsp = "supplyOrderPendingApprovalList"; 
	  ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	  }
	  
	  @RequestMapping(value = "/getSupplyOrderWaitingListForPendingApproval", method = RequestMethod.POST)
	  public String getSupplyOrderWaitingListForPendingApproval(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getSupplyOrderWaitingListForPendingApproval(data,request, response);
		
	  }
	  
	  
	  @RequestMapping(value = "/supplyOrderApproval", method = RequestMethod.GET)
	  public ModelAndView supplyOrderApproval(HttpServletRequest request, HttpServletResponse response) {
	  String jsonResponse = storesService.getsupplyOrderDetailsForApproval(request, response);
	  String jsp = "viewUpdateSupplyOrder"; 
	  return new ModelAndView(jsp, "jsonResponse", jsonResponse);
	  }
	  
	  
	  
	  @RequestMapping(value = "/saveOrSubmitSODetailForApproval", method = RequestMethod.POST)
	  public ModelAndView saveOrSubmitSODetailForApproval(HttpServletRequest request, HttpServletResponse response) {
		String message="";
		long balanceHeaderId=0;
		Map<String,Object> map = new HashMap<String, Object>();
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
	    String jsonResponse= storesService.saveOrSubmitSODetailForApproval(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	if(responseData.has("actionFlag")) {
	    		map.put("actionFlag", "A"); // In case of Approve/Reject.
	    	}else {
	    		map.put("actionFlag", "N"); // In case of Save/Submit.
	    	}
	    	message =  responseData.getString("message");
	    	balanceHeaderId = responseData.getLong("poMId");
	    	map.put("balanceHeaderId",balanceHeaderId);
	    	map.put("message",message);
	    	map.put("requestType", "update");
	    	
	    	
	    }
	    return new ModelAndView("successSupplyOrder", "map", map);
	  }	 
	  
	  

	  @RequestMapping(value = "/showRVWaitingListSo", method = RequestMethod.GET)
	  public ModelAndView showRVWaitingListAgainstSo(HttpServletRequest request, HttpServletResponse response) {
	  String jsp = "rvWaitingAgainstSO"; 
	  ModelAndView mv =new ModelAndView();
		mv.setViewName(jsp);
		return mv;
	  }
	  
	  
	  @RequestMapping(value = "/getRVWaitingListSo", method = RequestMethod.POST)
	  public String getRVWaitingListSo(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getRVWaitingListSo(data,request, response);
	  }
	  
	  
	  @RequestMapping(value = "/rvDetailsAgainstSo", method = RequestMethod.GET)
	  public ModelAndView rvDetailsAgainstSo(HttpServletRequest request, HttpServletResponse response) {
		  String jsonResponse = storesService.rvDetailsAgainstSo(request, response);
		  String jsp = "rvAgainstSO"; 
		  return new ModelAndView(jsp, "jsonResponse", jsonResponse);
	  
	  }
	  
	  @RequestMapping(value = "/submitRVAgainstSO", method = RequestMethod.POST)
	  public ModelAndView submitRVAgainstSO(HttpServletRequest request, HttpServletResponse response) {
		String message="";
		long grnMId=0;
		Map<String,Object> map = new HashMap<String, Object>();
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
		
	    String jsonResponse= storesService.submitRVAgainstSO(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	message =  responseData.getString("message");
	    	grnMId = responseData.getLong("grnMId");
	    	map.put("message",message);
	    	map.put("grnMId",grnMId);
	    }
	    return new ModelAndView("successRvAgainstSo", "map", map);
	  }	 
	  
	  
	  
	  @RequestMapping(value = "/showDirectReceivingSO", method = RequestMethod.GET)
	  public ModelAndView directReceivingOfItems(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "directRecievingSO"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  
	  @RequestMapping(value = "/showBudgetaryForDirectReceiving", method = RequestMethod.GET)
	  public ModelAndView showBudgetaryForDirectReceiving(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "createBudgetaryListForbackDate"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  
	  
	  
	  @RequestMapping(value = "/showItemListForbackDateBudgetary", method = RequestMethod.POST)
	  public String showItemListForbackDateBudgetary(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.showItemListForbackDateBudgetary(data,request, response);
	  }
	  
	  @RequestMapping(value = "/getSupplierListForStore", method = RequestMethod.POST)
	  public String getSupplierListForStore(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getSupplierListForStore(data,request, response);
	  }
	  
	  @RequestMapping(value = "/getAuNameForStore", method = RequestMethod.POST)
	  public String getAuNameForStore(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getAuNameForStore(data,request, response);
	  }
	  
	  
	  @RequestMapping(value = "/submitDirectReceiving", method = RequestMethod.POST)
	  public ModelAndView submitDirectReceiving(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String, Object>();
		String message="";
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
		//System.out.println("data..."+data);
	    String jsonResponse= storesService.submitDirectReceiving(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	message =  responseData.getString("message");
	    	map.put("message",message);
	    }
	    return new ModelAndView("successDirectRV", "map", map);
	  }	
	  
	  
	  @RequestMapping(value = "/showDirectReceivingRegister", method = RequestMethod.GET)
	  public ModelAndView directReceivingRegister(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "directReceivingRegister"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  @RequestMapping(value = "/createBudgetaryForBackDateLP", method = RequestMethod.POST)
	  public String createBudgetaryForBackDateLP(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		return storesService.createBudgetaryForBackDateLP(data, request, response);
		
	  }	
	  
	  
	  @RequestMapping(value = "/submitBudgetarySuccess", method = RequestMethod.POST)
	  public ModelAndView submitBudgetarySuccess(HttpServletRequest request, HttpServletResponse response) {
		  Map<String,Object> map = new HashMap<String, Object>();
		  long budgetaryMId=0;
		  String message=""; 
		  Box box= HMSUtil.getBox(request);
		  JSONObject json = new JSONObject(box);
		  budgetaryMId = Long.parseLong(json.getJSONArray("budgetaryMId").getString(0));
		  if(budgetaryMId!=0) {
			  message ="Budgetary created successfully.";
		  }else {
			  message ="Some error occured";
		  }
		  
		  map.put("budgetaryMId", budgetaryMId);
		  map.put("message", message);
		  
		  return new ModelAndView("successBackDateBudgetary", "map", map);
	  }
	  
	  
	  
	  @RequestMapping(value = "/indentFromIDS", method = RequestMethod.GET)
	  public ModelAndView receivingIndentFromIDS(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "indentFromIDS"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  @RequestMapping(value = "/deleteRowFromDataBase", method = RequestMethod.POST)
	  public String deleteRowFromDataBase(@RequestBody String data,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.deleteRowFromDataBase(data,request, response);
	  }
	  
	 
	  @RequestMapping(value = "/downloadPvmsItemExcelFormat", method = RequestMethod.POST)
	  public ModelAndView  createPvmsItemExcelList(HttpServletRequest request, HttpServletResponse response) {
			Map<String, Object> map = new HashMap<String, Object>();
			
		  	Box box = HMSUtil.getBox(request);
			JSONObject data = new JSONObject(box);
			
			String respData = storesService.createPvmsItemExcelList(data.toString());
			
			JSONObject responseData = new JSONObject(respData);
			responseData =(JSONObject) responseData.get("data"); 
			
			String resultFlag = responseData.getString("flag");
			
			if (resultFlag != null	&& resultFlag.equalsIgnoreCase("NoData")) 
			{
				map.put("message", "No Data Found!....");
				
			} else {
				JSONArray itemIdList =  responseData.getJSONArray("itemIdList");
				JSONArray pvmsNoList = responseData.getJSONArray("pvmsNoList");
				JSONArray itemNameList =  responseData.getJSONArray("itemNameList");
				JSONArray itemUnitList = responseData.getJSONArray("itemUnitList");
					
				map = createPvmsExcelFile(itemIdList,pvmsNoList,itemNameList,itemUnitList,response);
				
			}
			
			if(map!=null) {
				String jsp = "openingBalance";
				return new ModelAndView(jsp, "map", map);
			}else {
				return null;
				
			}
	  }

	
	public Map<String, Object> createPvmsExcelFile(JSONArray itemIdList, JSONArray pvmsNoList, JSONArray itemNameList,
			JSONArray itemUnitList, HttpServletResponse response) {
		try {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=DrugList.xls");

			WritableWorkbook wb = Workbook.createWorkbook(response.getOutputStream());
			WritableSheet ws = wb.createSheet("Sheet", 0);

			WritableFont wf = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);
			wcf.setWrap(true);

			WritableCellFormat wcf2 = new WritableCellFormat(NumberFormats.TEXT);
			wcf2.setWrap(true);

			CellView cell = new CellView();
			cell.setSize(3000);
			ws.setColumnView(0, cell);
			cell.setSize(4000);
			ws.setColumnView(1, cell);
			cell.setSize(7000);
			ws.setColumnView(2, cell);
			cell.setSize(3000);
			ws.setColumnView(3, cell);
			cell.setSize(3000);

			Label label = new Label(0, 0, "", wcf); // for first row and first column.
			ws.addCell(label);
			ws.mergeCells(0, 0, 3, 0);
			
			
			ws.getSettings().setVerticalFreeze(2);
			
			label = new Label(0, 1, "ItemId", wcf);
			ws.addCell(label);
			
			label = new Label(1, 1, "Drug Code", wcf);
			ws.addCell(label);

			label = new Label(2, 1, "Drug Name", wcf);
			ws.addCell(label);

			label = new Label(3, 1, "A/U", wcf);
			ws.addCell(label);

			label = new Label(4, 0, "Batch1", wcf);
			ws.addCell(label);
			ws.mergeCells(4, 0, 6, 0);
			
			label = new Label(4, 1, "BatchNo", wcf);
			ws.addCell(label);
			
			label = new Label(5, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			
			ws.setColumnView(5, cell);
			cell.setSize(7000);
			
			label = new Label(6, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(7, 0, "Batch2", wcf);
			ws.addCell(label);
			ws.mergeCells(7, 0, 9, 0);
			
			label = new Label(7, 1, "BatchNo", wcf);
			ws.addCell(label);
			
			label = new Label(8, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(8, cell);
			cell.setSize(7000);
			
			label = new Label(9, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(10, 0, "Batch3", wcf);
			ws.addCell(label);
			ws.mergeCells(10, 0, 12, 0);
			
			label = new Label(10, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(11, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(11, cell);
			cell.setSize(7000);
			
			label = new Label(12, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(13, 0, "Batch4", wcf);
			ws.addCell(label);
			ws.mergeCells(13, 0, 15, 0);
			
			label = new Label(13, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(14, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(14, cell);
			cell.setSize(7000);
			
			label = new Label(15, 1, "Qty", wcf);
			ws.addCell(label);

			
			label = new Label(16, 0, "Batch5", wcf);
			ws.addCell(label);
			ws.mergeCells(16, 0, 18, 0);
			
			label = new Label(16, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(17, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			
			ws.setColumnView(17, cell);
			cell.setSize(7000);
			
			label = new Label(18, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(19, 0, "Batch6", wcf);
			ws.addCell(label);
			ws.mergeCells(19, 0, 21, 0);
			
			label = new Label(19, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(20, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(20, cell);
			cell.setSize(7000);
			label = new Label(21, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(22, 0, "Batch7", wcf);
			ws.addCell(label);
			ws.mergeCells(22, 0, 24, 0);
			
			label = new Label(22, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(23, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(23, cell);
			cell.setSize(7000);
			label = new Label(24, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(25, 0, "Batch8", wcf);
			ws.addCell(label);
			ws.mergeCells(25, 0, 27, 0);
			
			label = new Label(25, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(26, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(26, cell);
			cell.setSize(7000);
			label = new Label(27, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(28, 0, "Batch9", wcf);
			ws.addCell(label);
			ws.mergeCells(28, 0, 30, 0);
			
			label = new Label(28, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(29, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(29, cell);
			cell.setSize(7000);
			label = new Label(30, 1, "Qty", wcf);
			ws.addCell(label);

			label = new Label(31, 0, "Batch10", wcf);
			ws.addCell(label);
			ws.mergeCells(31, 0, 33, 0);
			
			label = new Label(31, 1, "BatchNo", wcf);
			ws.addCell(label);
			label = new Label(32, 1, "Exp Date(DD/MM/YYYY)", wcf);
			ws.addCell(label);
			ws.setColumnView(32, cell);
			cell.setSize(7000);
			label = new Label(33, 1, "Qty", wcf);
			ws.addCell(label);

			int count = 2;
			int j = 0;
			for (j = 0; j < itemIdList.length() - 1; j++) {
				String pvms = "";
				String nomenclature = "";
				String itemId = "0";
				String au = "";
				try {
					itemId = itemIdList.get(j).toString();

				} catch (Exception e) {
					itemId = "0";
				}

				try {
					pvms = (String) pvmsNoList.get(j);
				} catch (Exception e) {
					pvms = "";
				}

				try {
					nomenclature = (String) itemNameList.get(j);
				} catch (Exception e) {
					nomenclature = "";
				}

				try {
					au = itemUnitList.get(j).toString();
				} catch (Exception e) {
					au = "";
				}

				label = new Label(0, count, itemId, wcf2);
				ws.addCell(label);

				label = new Label(1, count, pvms, wcf2);
				ws.addCell(label);

				label = new Label(2, count, nomenclature, wcf2);
				ws.addCell(label);

				label = new Label(3, count, au, wcf2);
				ws.addCell(label);

				count++;

			}
			wb.write();
			wb.close();
		} catch (IOException | WriteException ioe) {
			ioe.printStackTrace();
		}
		return null;
	}
	 
	@RequestMapping(value ="/importPvmsdataFromFileUpload", method = RequestMethod.POST)
	public String importPvmsdataFromFileUpload(HttpServletRequest request,
			HttpServletResponse response,@RequestParam CommonsMultipartFile[] uploadFile) {
		
			Map<String,Object> map = new HashMap<String, Object>();
		
			JSONObject json = new JSONObject();
			String jsonResponse="";
			long departmentId=0;
			long mmuId=0;
			long userId=0;
			
			
			
			if(request.getParameter("departmentIdUpload")!=null && !request.getParameter("departmentIdUpload").isEmpty()) {
				departmentId= Long.parseLong(request.getParameter("departmentIdUpload"));
			}
			 
			if(request.getParameter("mmuIdd")!=null && !request.getParameter("mmuIdd").isEmpty()) {
				mmuId= Long.parseLong(request.getParameter("mmuIdd"));
			}
			 
			if(request.getParameter("userIdUpload")!=null && !request.getParameter("userIdUpload").isEmpty()) {
				userId= Long.parseLong(request.getParameter("userIdUpload"));
			}
			
				List<Integer> itemIdList = new ArrayList<Integer>();
				List<String> pvmsNoList = new ArrayList<String>();
				List<String> nomenclatureList = new ArrayList<String>();
				List<String> auList = new ArrayList<String>();
				
				List<String> batch1 = new ArrayList<String>();
				List<String> expiryDate1 = new ArrayList<String>();
				List<BigDecimal> qty1 = new ArrayList<BigDecimal>();
				
				List<String> batch2 = new ArrayList<String>();
				List<String> expiryDate2 = new ArrayList<String>();
				List<BigDecimal> qty2 = new ArrayList<BigDecimal>();
				
				List<String> batch3 = new ArrayList<String>();
				List<String> expiryDate3 = new ArrayList<String>();
				List<BigDecimal> qty3 = new ArrayList<BigDecimal>();
				
				List<String> batch4 = new ArrayList<String>();
				List<String> expiryDate4 = new ArrayList<String>();
				List<BigDecimal> qty4 = new ArrayList<BigDecimal>();
				
				List<String> batch5 = new ArrayList<String>();
				List<String> expiryDate5 = new ArrayList<String>();
				List<BigDecimal> qty5 = new ArrayList<BigDecimal>();
				
				List<String> batch6 = new ArrayList<String>();
				List<String> expiryDate6 = new ArrayList<String>();
				List<BigDecimal> qty6 = new ArrayList<BigDecimal>();
				
				List<String> batch7 = new ArrayList<String>();
				List<String> expiryDate7 = new ArrayList<String>();
				List<BigDecimal> qty7 = new ArrayList<BigDecimal>();
				
				List<String> batch8 = new ArrayList<String>();
				List<String> expiryDate8 = new ArrayList<String>();
				List<BigDecimal> qty8 = new ArrayList<BigDecimal>();
				
				List<String> batch9 = new ArrayList<String>();
				List<String> expiryDate9 = new ArrayList<String>();
				List<BigDecimal> qty9 = new ArrayList<BigDecimal>();
				
				List<String> batch10 = new ArrayList<String>();
				List<String> expiryDate10 = new ArrayList<String>();
				List<BigDecimal> qty10 = new ArrayList<BigDecimal>();
				
				
				jxl.WorkbookSettings ws = null;
				jxl.Workbook workbook = null;
				jxl.Sheet s = null;
				Cell rowData[] = null;
				int rowCount = '0';
				int columnCount = '0';
				
				try {
					
					CommonsMultipartFile file = uploadFile[0];
					InputStream is = file.getInputStream();
					
					ws = new WorkbookSettings();
					ws.setLocale(new Locale("en", "EN"));
					workbook = jxl.Workbook.getWorkbook(is, ws);
					
					//Getting Default Sheet i.e. 0
					s = workbook.getSheet(0);
					
					//Reading Individual Cell
					//Total Total No Of Rows in Sheet, will return you no of rows that are occupied with some data
					rowCount = s.getRows();
					
					//Total Total No Of Columns in Sheet
					columnCount = s.getColumns();
					String au = "";
					 for (int i = 2; i < rowCount; i++) {
							//Get Individual Row
							rowData = s.getRow(i);
							if (rowData[0].getContents().length() != 0) { // the first date column must not null
							
								for (int j = 0; j < columnCount; j++) {
									switch (j) {
									case 0:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
												if(!rowData[j].getContents().toString().equals("")){
													itemIdList.add(Integer.parseInt(rowData[j].getContents().toString()));
												}else{
													itemIdList.add(0);
												}
										}
										else
										{
											itemIdList.add(0);
										}
										}
										catch(Exception e)
										{
											e.printStackTrace();
											itemIdList.add(0);
										}
										break;
									
									case 1:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
												pvmsNoList.add(rowData[j].getContents());
										}
										else
										{
											pvmsNoList.add("");
										}
										}
										catch(Exception e)
										{
											pvmsNoList.add("");
										}
										break;
									case 2:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
										nomenclatureList.add(rowData[j].getContents());
										}
										else
										{
											nomenclatureList.add("");
										}
										}
										catch(Exception e)
										{
											nomenclatureList.add("");
										}
										break;
										
										
									case 3:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											au = (rowData[j].getContents());
											auList.add(au);
										}
										else
										{
											auList.add("");
										}
										}catch(Exception e)
											{
											auList.add("");
											}
										break;
										
									case 4:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch1.add(rowData[j].getContents());
										
										}
										else
										{
											batch1.add("");
										}
										}catch(Exception e)
											{
											batch1.add("");
											}
										break;
										
									case 5:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate1.add(rowData[j].getContents());
										//System.out.println("rowData[j].getContents() ************************ "+rowData[j].getContents());
										}
										else
										{
											expiryDate1.add("");
										}
										}catch(Exception e)
											{
											expiryDate1.add("");
											}
										break;
										
									case 6:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty1.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty1.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty1.add(new BigDecimal(0));
											}
										break;
										
										
									case 7:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch2.add(rowData[j].getContents());
										
										}
										else
										{
											batch2.add("");
										}
										}catch(Exception e)
											{
											batch2.add("");
											}
										break;
									case 8:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
											expiryDate2.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate2.add("");
										}
										}catch(Exception e)
											{
											expiryDate2.add("");
											}
										
										break;
										
									case 9:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty2.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty2.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty2.add(new BigDecimal(0));
											}
										
										break;
										
									case 10:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch3.add(rowData[j].getContents());
										
										}
										else
										{
											batch3.add("");
										}
										}catch(Exception e)
											{
											batch3.add("");
											}
										break;
									case 11:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate3.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate3.add("");
										}
										}catch(Exception e)
											{
											expiryDate3.add("");
											}
										
										break;	
									case 12:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty3.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty3.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty3.add(new BigDecimal(0));
											}
										break;
										
										
									case 13:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch4.add(rowData[j].getContents());
										
										}
										else
										{
											batch4.add("");
										}
										}catch(Exception e)
											{
											batch4.add("");
											}
										break;
										
										
									case 14:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate4.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate4.add("");
										}
										}catch(Exception e)
											{
											expiryDate4.add("");
											}
										break;
									
									case 15:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty4.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty4.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty4.add(new BigDecimal(0));
											}
										break;
									case 16:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch5.add(rowData[j].getContents());
										
										}
										else
										{
											batch5.add("");
										}
										}catch(Exception e)
											{
											batch5.add("");
											}
										break;

									case 17:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate5.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate5.add("");
										}
										}catch(Exception e)
											{
											expiryDate5.add("");
											}
										break;
										
										
									case 18:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty5.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty5.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty5.add(new BigDecimal(0));
											}
										break;
									case 19:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch6.add(rowData[j].getContents());
										
										}
										else
										{
											batch6.add("");
										}
										}catch(Exception e)
											{
											batch6.add("");
											}
										break;
									case 20:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate6.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate6.add("");
										}
										}catch(Exception e)
											{
											expiryDate6.add("");
											}
										break;
										
									case 21:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty6.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty6.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty6.add(new BigDecimal(0));
											}
										break;
										
									case 22:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch7.add(rowData[j].getContents());
										
										}
										else
										{
											batch7.add("");
										}
										}catch(Exception e)
											{
											batch7.add("");
											}
										break;
									case 23:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate7.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate7.add("");
										}
										}catch(Exception e)
											{
											expiryDate7.add("");
											}
										break;
									case 24:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty7.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty7.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty7.add(new BigDecimal(0));
											}
										break;
										
									case 25:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch8.add(rowData[j].getContents());
										
										}
										else
										{
											batch8.add("");
										}
										}catch(Exception e)
											{
											batch8.add("");
											}
										break;
										
										
									case 26:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate8.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate8.add("");
										}
										}catch(Exception e)
											{
											expiryDate8.add("");
											}
										break;

									case 27:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty8.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty8.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty8.add(new BigDecimal(0));
											}
										break;
									case 28:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch9.add(rowData[j].getContents());
										
										}
										else
										{
											batch9.add("");
										}
										}catch(Exception e)
											{
											batch9.add("");
											}
										break;
										
									case 29:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate9.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate9.add("");
										}
										}catch(Exception e)
											{
											expiryDate9.add("");
											}
										break;
									case 30:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty9.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty9.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty9.add(new BigDecimal(0));
											}
										break;
									case 31:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										batch10.add(rowData[j].getContents());
										
										}
										else
										{
											batch10.add("");
										}
										}catch(Exception e)
											{
											batch10.add("");
											}
										break;
									case 32:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										expiryDate10.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDate10.add("");
										}
										}catch(Exception e)
											{
											expiryDate10.add("");
											}
										break;

									case 33:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qty10.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qty10.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qty10.add(new BigDecimal(0));
											}
										break;
									}
								}
							}
					 }
					 
					 workbook.close(); 
					
					 	map.put("itemIdList",itemIdList);
						map.put("pvmsNoList",pvmsNoList);
						map.put("itemNameList",nomenclatureList);
						map.put("itemUnitList",auList);
						
						map.put("batch1",batch1);
						map.put("batch2",batch2);
						map.put("batch3",batch3);
						map.put("batch4",batch4);
						map.put("batch5",batch5);
						map.put("batch6",batch6);
						map.put("batch7",batch7);
						map.put("batch8",batch8);
						map.put("batch9",batch9);
						map.put("batch10",batch10);
						
						map.put("expiryDate1",expiryDate1);
						map.put("expiryDate2",expiryDate2);
						map.put("expiryDate3",expiryDate3);
						map.put("expiryDate4",expiryDate4);
						map.put("expiryDate5",expiryDate5);
						map.put("expiryDate6",expiryDate6);
						map.put("expiryDate7",expiryDate7);
						map.put("expiryDate8",expiryDate8);
						map.put("expiryDate9",expiryDate9);
						map.put("expiryDate10",expiryDate10);
						
						map.put("qty1",qty1);
						map.put("qty2",qty2);
						map.put("qty3",qty3);
						map.put("qty4",qty4);
						map.put("qty5",qty5);
						map.put("qty6",qty6);
						map.put("qty7",qty7);
						map.put("qty8",qty8);
						map.put("qty9",qty9);
						map.put("qty10",qty10);
						
					   json.put("data", map);
					   json.put("mmuId", mmuId);
					   json.put("departmentId", departmentId);
					   json.put("userId", userId);
					
				 jsonResponse=storesService.importPvmsdataFromFileUpload(json.toString(), request, response);
					 
				}catch(IOException | BiffException e) {
					e.printStackTrace();
				}
				return jsonResponse;
			}
			  
  
	
	
	
	// Import excel file received indent from I-Aushadhi 
	
	@RequestMapping(value ="/importPvmsdataReceivedFromiAushadhi", method = RequestMethod.POST)
	public String importPvmsdataReceivedFromiAushadhi(HttpServletRequest request,
			HttpServletResponse response,@RequestParam CommonsMultipartFile[] uploadFile) {
		
			Map<String,Object> map = new HashMap<String, Object>();
		
			JSONObject json = new JSONObject();
			String jsonResponse="";
			long departmentId=0;
			long hospitalId=0;
			long userId=0;
			String indentNo="";
			String indentDate="";
			
			
			if(request.getParameter("indentNo")!=null && !request.getParameter("indentNo").isEmpty()) {
				indentNo= request.getParameter("indentNo").toString();
			}
			
			if(request.getParameter("indentDate")!=null && !request.getParameter("indentDate").isEmpty()) {
				indentDate= request.getParameter("indentDate").toString();
			}
			
			if(request.getParameter("departmentIdUpload")!=null && !request.getParameter("departmentIdUpload").isEmpty()) {
				departmentId= Long.parseLong(request.getParameter("departmentIdUpload"));
			}
			 
			if(request.getParameter("hospitalIdUpload")!=null && !request.getParameter("hospitalIdUpload").isEmpty()) {
				hospitalId= Long.parseLong(request.getParameter("hospitalIdUpload"));
			}
			 
			if(request.getParameter("userIdUpload")!=null && !request.getParameter("userIdUpload").isEmpty()) {
				userId= Long.parseLong(request.getParameter("userIdUpload"));
			}
			
				List<Integer> sNoList = new ArrayList<Integer>();
				List<String> pvmsNoList = new ArrayList<String>();
				List<String> nomenclatureList = new ArrayList<String>();
				List<String> auList = new ArrayList<String>();
				
				List<String> qtyDemanded = new ArrayList<String>();
				List<String> qtyIssued = new ArrayList<String>();
				List<BigDecimal> qtyReceived = new ArrayList<BigDecimal>();
				List<String> batchList = new ArrayList<String>();
				List<String> expiryDateList = new ArrayList<String>();
				List<String> remarksList = new ArrayList<String>();
				
				
				
				jxl.WorkbookSettings ws = null;
				jxl.Workbook workbook = null;
				jxl.Sheet s = null;
				Cell rowData[] = null;
				int rowCount = '0';
				int columnCount = '0';
				
				try {
					
					CommonsMultipartFile file = uploadFile[0];
					//FileInputStream is =  (FileInputStream) file.getInputStream();
					InputStream is = file.getInputStream();		
					
					ws = new WorkbookSettings();
					ws.setLocale(new Locale("en", "EN"));
					workbook = jxl.Workbook.getWorkbook(is, ws);
					
					//Getting Default Sheet i.e. 0
					s = workbook.getSheet(0);
					
					//Reading Individual Cell
					//Total Total No Of Rows in Sheet, will return you no of rows that are occupied with some data
					rowCount = s.getRows();
					
					//Total Total No Of Columns in Sheet
					columnCount = s.getColumns();
					String au = "";
					 for (int i = 10; i < rowCount; i++) {
							//Get Individual Row
							rowData = s.getRow(i);
							if (rowData[0].getContents().length() != 0) { // the first date column must not null
							
								for (int j = 0; j < columnCount; j++) {
									switch (j) {
									case 0:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
												if(!rowData[j].getContents().toString().equals("")){
													sNoList.add(Integer.parseInt(rowData[j].getContents().toString()));
												}else{
													sNoList.add(0);
												}
										}
										else
										{
											sNoList.add(0);
										}
										}
										catch(Exception e)
										{
											e.printStackTrace();
											sNoList.add(0);
										}
										break;
									
									case 1:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
												pvmsNoList.add(rowData[j].getContents());
										}
										else
										{
											pvmsNoList.add("");
										}
										}
										catch(Exception e)
										{
											pvmsNoList.add("");
										}
										break;
									case 2:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
										nomenclatureList.add(rowData[j].getContents());
										}
										else
										{
											nomenclatureList.add("");
										}
										}
										catch(Exception e)
										{
											nomenclatureList.add("");
										}
										break;
										
										
									case 3:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											au = (rowData[j].getContents());
											auList.add(au);
										}
										else
										{
											auList.add("");
										}
										}catch(Exception e)
											{
											auList.add("");
											}
										break;
										
									case 4:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
											qtyDemanded.add(rowData[j].getContents());
										
										}
										else
										{
											qtyDemanded.add("");
										}
										}catch(Exception e)
											{
											qtyDemanded.add("");
											}
										break;
										
									case 5:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
											qtyIssued.add(rowData[j].getContents());
										
										}
										else
										{
											qtyIssued.add("");
										}
										}catch(Exception e)
											{
											qtyIssued.add("");
											}
										break;
										
									case 6:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
										qtyReceived.add(new BigDecimal(rowData[j].getContents()));
										
										}
										else
										{
											qtyReceived.add(new BigDecimal(0));
										}
										}catch(Exception e)
											{
											qtyReceived.add(new BigDecimal(0));
											}
										break;
										
										
									case 7:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
											batchList.add(rowData[j].getContents());
										
										}
										else
										{
											batchList.add("");
										}
										}catch(Exception e)
											{
											batchList.add("");
											}
										break;
									case 8:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
											expiryDateList.add(rowData[j].getContents());
										
										}
										else
										{
											expiryDateList.add("");
										}
										}catch(Exception e)
											{
											expiryDateList.add("");
											}
										
										break;
										
									case 9:
										try
										{
											if(rowData[j].getContents().length() != 0)
										{
											
											remarksList.add(rowData[j].getContents());
										
										}
										else
										{
											remarksList.add("");
										}
										}catch(Exception e)
											{
											remarksList.add("");
											}
										
										break;
									}
								}
							}
					 }
					 
					 workbook.close(); 
					
					 	map.put("sNoList",sNoList);
						map.put("pvmsNoList",pvmsNoList);
						map.put("itemNameList",nomenclatureList);
						map.put("itemUnitList",auList);
						map.put("qtyDemanded",qtyDemanded);
						map.put("qtyIssued",qtyIssued);
						map.put("qtyReceived",qtyReceived);
						map.put("batchList",batchList);
						map.put("expiryDateList",expiryDateList);
						map.put("remarksList",remarksList);
						
						
					   json.put("data", map);
					   json.put("hospitalId", hospitalId);
					   json.put("departmentId", departmentId);
					   json.put("userId", userId);
					   json.put("receivingNo", indentNo);
					   json.put("rvDate", indentDate);
				 jsonResponse=storesService.importPvmsdataReceivedFromiAushadhi(json.toString(), request, response);
					 
				}catch(IOException | BiffException e) {
					e.printStackTrace();
				}
				return jsonResponse;
			}
	
	  @RequestMapping(value = "/showReceiveIndentWatingListCo", method = RequestMethod.GET)
	  public ModelAndView showReceiveIndentWatingListCo(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "receivingIndentWaitingCo"; 
			ModelAndView mv =new ModelAndView();
			mv.setViewName(jsp);
			return mv;
	  }
	  
	  @RequestMapping(value = "/getReceivingIndentWaitingListCo", method = RequestMethod.POST)
	  public String getReceivingIndentWaitingListCo(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
		  return storesService.getReceivingIndentWaitingListCo(data,request, response);
		
	  }
	  	
	  
	  @RequestMapping(value = "/receivingIndentInInventoryCo", method = RequestMethod.GET)
	  public ModelAndView receivingIndentInInventoryCo(HttpServletRequest request, HttpServletResponse response) {
	  String jsonResponse = storesService.receivingIndentInInventoryCo(request, response);
	  String jsp = "indentAcknowledgementCo"; 
	  return new ModelAndView(jsp, "jsonResponse", jsonResponse);
	  }
	 
	  
	  
	  @RequestMapping(value = "/addToStockIssuedIndentCo", method = RequestMethod.POST)
	  public ModelAndView addToStockIssuedIndentCo(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String, Object>();
		String message="";
		long indentMId=0;
		Box box = HMSUtil.getBox(request);
		JSONObject data = new JSONObject(box);
	    String jsonResponse= storesService.addToStockIssuedIndentCo(data.toString(), request, response);
	    if(!jsonResponse.isEmpty()) {
	    	JSONObject responseData = new JSONObject(jsonResponse);
	    	indentMId = responseData.getLong("indentMId");
	    	message =  responseData.getString("message");
	    	map.put("message",message);
	    	map.put("indentMId",indentMId);
	    }
	    return new ModelAndView("successIndentAcknowledgeCo", "map", map);
	  }	  
	
	  @RequestMapping(value = "/generateStockStatusReportDo", method = RequestMethod.POST)
	  public String generateStockStatusReportDo(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
			 return storesService.generateStockStatusReportDo(data,request, response);
	  }
	  
	  @RequestMapping(value = "/showStockStatusReportDo", method = RequestMethod.GET)
	  public ModelAndView showStockStatusReportDo(HttpServletRequest request, HttpServletResponse response) {
		  String jsp = "stockStatusReportDo"; 
		  ModelAndView mv =new ModelAndView();
		  mv.setViewName(jsp);
		  return mv;
	  }
	  
		@RequestMapping(value = "/getMasSupplierList", method = RequestMethod.POST)
		public String getMasSupplierList(@RequestBody String data, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMasSupplierList");
			return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		}

		@RequestMapping(value = "/getMasSupplierTypeList", method = RequestMethod.POST)
		public String getMasSupplierTypeList(@RequestBody String data, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMasSupplierTypeList");
			return RestUtils.postWithHeaders(IpAndPortNo.trim() + OSBURL.trim(), requestHeaders, data);
		}
		
		@RequestMapping(value = "/getAllUpssManufactureMapping", method = RequestMethod.POST)
		  public String getAllUpssManufactureMapping(@RequestBody String data ,HttpServletRequest request, HttpServletResponse response) {
			  return storesService.getAllUpssManufactureMapping(data,request, response);
			
		  }
		
		private String uploadFile(MultipartHttpServletRequest multipartHttpServletRequest, String uploadFlag){
			String originalFileName = "";
			Iterator<String> it = multipartHttpServletRequest.getFileNames();
			String auditPath = environment.getProperty("mmu.web.audit.basePath");
			if (it.hasNext()) {
				MultipartFile file = multipartHttpServletRequest.getFile(it.next());
				originalFileName = file.getOriginalFilename();
				String detailId, captureId, checklistId;
				if("I".equals(uploadFlag)){
					detailId = multipartHttpServletRequest.getParameter("inspectionDetailId");
					captureId = multipartHttpServletRequest.getParameter("captureInspectionChecklistId");
					checklistId = multipartHttpServletRequest.getParameter("inspectionChecklistId");
					auditPath += "/inspection/"+detailId+"/"+captureId+"/"+checklistId+"/";
				} else if("E".equals(uploadFlag)){
					detailId = multipartHttpServletRequest.getParameter("equipmentDetailId");
					captureId = multipartHttpServletRequest.getParameter("captureEquipmentChecklistId");
					checklistId = multipartHttpServletRequest.getParameter("equipmentChecklistId");
					auditPath += "/equipment/"+detailId+"/"+captureId+"/"+checklistId+"/";
				} 
				else if("A".equals(uploadFlag)){
					auditPath += "/audit_report/";
				}
				else if("F".equals(uploadFlag)){
					auditPath += "/fund_letter/";
				}
				else if("U".equals(uploadFlag)){
					auditPath += "/UC_Upload_Document/";
				}
				else if("D".equals(uploadFlag)){
					auditPath += "/Dispensary/";
				}else {
					auditPath += "/vendor_bill/";
				}

				try {

					File folderPath = new File(auditPath);
					if(!folderPath.exists()) {
						folderPath.mkdirs();
					}

					String path = auditPath;
					if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("letterNo") == null && multipartHttpServletRequest.getParameter("certificateNo") == null){
						path += multipartHttpServletRequest.getParameter("invoiceNo") + "_" + originalFileName;
					}
					else if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("invoiceNo") == null && multipartHttpServletRequest.getParameter("certificateNo") == null){
						path += multipartHttpServletRequest.getParameter("letterNo") + "_" + originalFileName;
					}
					else if(multipartHttpServletRequest.getParameter("historyId") == null && multipartHttpServletRequest.getParameter("invoiceNo") == null && multipartHttpServletRequest.getParameter("letterNo") == null){
						path += multipartHttpServletRequest.getParameter("certificateNo") + "_" + originalFileName;
					}else {
						path += multipartHttpServletRequest.getParameter("historyId") + "_" + originalFileName;
					}
					byte[] bytes = file.getBytes();
					File uploadedFile = new File(path);
					FileOutputStream opStream = new FileOutputStream(uploadedFile);
					opStream.write(bytes);
					opStream.flush();
					opStream.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return originalFileName;
		}
		
		@RequestMapping(value = "/download")
		public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {
			try {
				String keys[] = request.getParameter("keys").split(",");
				String type = request.getParameter("type");
				String name = "";
				String path = environment.getProperty("mmu.web.audit.basePath") + "/";
				Path file = null;
				if ("vendor_bill".equals(type)) {
					path += type;
					name = keys[0] + "_" + request.getParameter("name");
					file = Paths.get(path, name);
				}
				else if ("Dispensary".equals(type)) {
					path += type;
					name = keys[0] + "_" + request.getParameter("name");
					file = Paths.get(path, name);
				}
				else if ("audit_report".equals(type)) {
					path += type;
					name = keys[0] + "_" + request.getParameter("name");
					file = Paths.get(path, name);
				}
				else if ("UC_Upload_Document".equals(type)) {
					path += type;
					name = keys[0] + "_" + request.getParameter("name");
					file = Paths.get(path, name);
				}else if ("ce".equals(type)) { //Capture Equipment
					path += "capture_equipment";
					name = request.getParameter("name");
					String extension = name.substring(name.lastIndexOf("."));
					String fileName = keys[0] + keys[1] + "/" + keys[2] + "/" + keys[3] + keys[4];
					file = Paths.get(path, Base64.getEncoder().encodeToString(fileName.getBytes()) + extension);
				} else if ("ci".equals(type)) { //Capture Inspection
					path += "capture_inspection";
					name = request.getParameter("name");
					String extension = name.substring(name.lastIndexOf("."));
					String fileName = keys[0] + keys[1] + "/" + keys[2] + "/" + keys[3] + keys[4];
					file = Paths.get(path, Base64.getEncoder().encodeToString(fileName.getBytes()) + extension);
				} else {
					path += type + "/" + keys[0] + "/" + keys[1] + "/" + keys[2] + "/";
					name = keys[3] + "_" + request.getParameter("name");
					file = Paths.get(path, name);
				}

				if (Files.exists(file)) {
					if (name.indexOf(".mp4") > 0)
						response.setContentType("video/mp4");
					else if (name.indexOf(".png") > 0)
						response.setContentType("image/png");
					else if (name.indexOf(".jpg") > 0 || name.indexOf(".jpeg") > 0)
						response.setContentType("image/jpeg");
					else if (name.indexOf(".pdf") > 0)
						response.setContentType("application/pdf");
					else if (name.indexOf(".doc") > 0 || name.indexOf(".docx") > 0 || name.indexOf(".xls") > 0 || name.indexOf(".xlsx") > 0)
						response.setContentType("application/octet-stream");

					response.addHeader("Content-Disposition", "inline;  filename=" + name);
					try {
						Files.copy(file, response.getOutputStream());
						response.getOutputStream().flush();
					} catch (IOException ex) {
						ex.printStackTrace();
					}
				}
			}catch (Exception ex){
				ex.printStackTrace();
			}
		}
		
		
		@RequestMapping(value = "/showOpeningBalanceRegisterCO", method = RequestMethod.GET)
		  public ModelAndView showOpeningBalanceRegisterCO(HttpServletRequest request, HttpServletResponse response) {
			  String jsp = "openingBalanceRegisterCO"; 
				ModelAndView mv =new ModelAndView();
				mv.setViewName(jsp);
				return mv;
		  }
	  
}
