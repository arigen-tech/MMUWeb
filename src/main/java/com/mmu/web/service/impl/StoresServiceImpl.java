package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.mmu.web.service.StoresService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;

@Service("StoresService")
public class StoresServiceImpl implements StoresService {


	String IpAndPortNo=HMSUtil.getProperties("urlextension.properties","OSB_IP_AND_PORT").trim();

	@Override
	public String showOpeningBalance(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SHOW_OPENING_BALANCE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getStoreItemList(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_STORE_ITEM_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String submitStoreData(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUBMIT_STORE_ITEM_DATA");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getOpeningBalanceWatingList(String data,HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_OPENING_BALANCE_WAITING_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getOpeningBalanceDetailsForApproval(HttpServletRequest request,
			HttpServletResponse response) {
		String headerId = request.getParameter("headerId");
		String data = "{\"headerId\":" + headerId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "OPENING_BALANCE_DETAILS_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String submitOpeningBalanceDataForApproval(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUBMIT_OPENING_BALANCE_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}
	
	@Override
	public String generateStockStatusReport(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GENERATE_STOCK_STATUS");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getDataForStockStatusReport(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SHOW_DATA_FOR_STOCK_STATUS_REPORT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getReceivingIndentWaitingList(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_RECEIVING_INDENT_WAITING_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String receivingIndentInInventory(HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String id = request.getParameter("id");
		String storeIssueMId = request.getParameter("storeIssueMId");
		JSONObject data = new JSONObject();
		data.put("indentId", id);
		data.put("storeIssueMId", storeIssueMId);
		String Url = HMSUtil.getProperties("urlextension.properties", "RECEIVING_INDENT_IN_INVENTORY");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data.toString());
		 
	}

	@Override
	public String addToStockIssuedIndent(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_STOCK_ISSUES_INDENT");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}


	@Override
	public String getItemListForAutoComplete(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ITEM_LIST_FOR_AUTO_COMPLETE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getItemStockDetailsFromStore(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_STOCK_ITEM_DETAILS_FROM_STORE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String updatePhysicalStockTaking(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "UPDATE_PHYSICAL_STOCK_TAKING");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getstockTakingWatingListData(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_STOCK_TAKING_WAITING_LIST_DATA");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String stockTakingApproval(HttpServletRequest request, HttpServletResponse response) {
		String headerId = request.getParameter("headerId");
		String data = "{\"headerId\":" + headerId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "STOCK_TAKING_DETAILS_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String submitStockTakingDataForApproval(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUBMIT_STOCK_TAKING_DATA_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}
	
	@Override
	public String showCreateSupplyOrder(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String data = "{\"hospitalId\":" + session.getAttribute("hospital_id") + ", \"departmentId\":" +session.getAttribute("department_id") + "}";
		String Url = HMSUtil.getProperties("urlextension.properties", "CREATE_SUPPLY_ORDER");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getSupplyOrderSanctionData(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_SUPPLY_ORDER_SANCTION_DATA");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String saveSODetails(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SAVE_SUPPLY_ORDER");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	
	@Override
	public String getSupplyOrderWaitingList(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUPPLY_ORDER_WAITING_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getSupplyOrderWaitingListForPendingApproval(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUPPLY_ORDER_WAITING_LIST_FOR_PENDING_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getsupplyOrderDetailsForApproval(HttpServletRequest request, HttpServletResponse response) {
		String headerId = request.getParameter("headerId");
		String data = "{\"headerId\":" + headerId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_SUPPLY_ORDER_DETAILS_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	
	
	@Override
	public String saveOrSubmitSODetailForApproval(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SAVE_OR_SUBMIT_SUPPLY_ORDER_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getRVWaitingListSo(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>(); 
		String Url = HMSUtil.getProperties("urlextension.properties","RV_WAITING_LIST_AGAINST_SO"); 
		String OSBURL = IpAndPortNo + Url; 
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String rvDetailsAgainstSo(HttpServletRequest request, HttpServletResponse response) {
		String headerId = request.getParameter("headerId");
		String data = "{\"headerId\":" + headerId + "}";
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_SUPPLY_ORDER_DETAILS_FOR_APPROVAL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String submitRVAgainstSO(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUBMIT_RV_AGAINST_SUPPLY_ORDER");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String submitDirectReceiving(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SUBMIT_DIRECT_RECEIVING_SO");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String deleteRowFromDataBase(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "DELETE_ROW_FROM_DATABASE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getSupplierListForStore(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_SUPPLIER_LIST_FOR_STORE");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String createPvmsItemExcelList(String data) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_PVMS_ITEM_LIST_FOR_EXCEL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String importPvmsdataFromFileUpload(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "IMPORT_PVMS_ITEM_LIST_FROM_EXCEL");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String importPvmsdataReceivedFromiAushadhi(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "IMPORT_ITEM_LIST_FROM_iAushadhi");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getAuNameForStore(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_ITEM_AU_NAME_LIST");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String showItemListForbackDateBudgetary(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "SHOW_ITEM_LIST_FOR_BACK_DATE_BUDGETARY");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String createBudgetaryForBackDateLP(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "CREATE_BUDGETARY_FOR_BACK_DATE_LP");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getReceivingIndentWaitingListCo(String data, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GET_RECEIVING_INDENT_WAITING_LIST_CO");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String receivingIndentInInventoryCo(HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String id = request.getParameter("id");
		String storeIssueMId = request.getParameter("storeIssueMId"); 
		JSONObject data = new JSONObject();
		data.put("indentId", id);
		data.put("storeIssueMId", storeIssueMId);
		
		String Url = HMSUtil.getProperties("urlextension.properties", "RECEIVING_INDENT_IN_INVENTORY_CO");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data.toString());
		 
	}

	@Override
	public String addToStockIssuedIndentCo(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "ADD_STOCK_ISSUES_INDENT_CO");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String generateStockStatusReportCo(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GENERATE_STOCK_STATUS_CO");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String generateStockStatusReportDo(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "GENERATE_STOCK_STATUS_DO");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}

	@Override
	public String getAllUpssManufactureMapping(String data, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties", "getAllUpssManufactureMapping");
		String OSBURL = IpAndPortNo + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, data);
	}
	
}
