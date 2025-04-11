package com.mmu.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service
public interface StoresService {

	String showOpeningBalance(String data, HttpServletRequest request, HttpServletResponse response);
	String getStoreItemList(String data, HttpServletRequest request, HttpServletResponse response);
	String submitStoreData(String data, HttpServletRequest request, HttpServletResponse response);
	String getOpeningBalanceWatingList(String data, HttpServletRequest request, HttpServletResponse response);
	String getOpeningBalanceDetailsForApproval(HttpServletRequest request, HttpServletResponse response);
	String submitOpeningBalanceDataForApproval(String data, HttpServletRequest request, HttpServletResponse response);
	String generateStockStatusReport(String data, HttpServletRequest request, HttpServletResponse response);
	String getDataForStockStatusReport(String data, HttpServletRequest request, HttpServletResponse response);
	String getReceivingIndentWaitingList(String data, HttpServletRequest request, HttpServletResponse response);
	String receivingIndentInInventory(HttpServletRequest request, HttpServletResponse response);
	String addToStockIssuedIndent(String data, HttpServletRequest request, HttpServletResponse response);
	String showCreateSupplyOrder(HttpServletRequest request, HttpServletResponse response);
	String getItemListForAutoComplete(String data, HttpServletRequest request, HttpServletResponse response);
	String getItemStockDetailsFromStore(String data, HttpServletRequest request, HttpServletResponse response);
	String updatePhysicalStockTaking(String data, HttpServletRequest request, HttpServletResponse response);
	String getstockTakingWatingListData(String data, HttpServletRequest request, HttpServletResponse response);
	String stockTakingApproval(HttpServletRequest request, HttpServletResponse response);
	String submitStockTakingDataForApproval(String data, HttpServletRequest request, HttpServletResponse response);
	String getSupplyOrderSanctionData(String data, HttpServletRequest request, HttpServletResponse response);
	String saveSODetails(String data, HttpServletRequest request, HttpServletResponse response);
	String getSupplyOrderWaitingList(String data, HttpServletRequest request, HttpServletResponse response);
	String getsupplyOrderDetailsForApproval(HttpServletRequest request, HttpServletResponse response);
	String saveOrSubmitSODetailForApproval(String data, HttpServletRequest request, HttpServletResponse response);
	String getRVWaitingListSo(String data,HttpServletRequest request, HttpServletResponse response);
	String rvDetailsAgainstSo(HttpServletRequest request, HttpServletResponse response);
	String submitRVAgainstSO(String data, HttpServletRequest request, HttpServletResponse response);
	String submitDirectReceiving(String data, HttpServletRequest request, HttpServletResponse response);
	String deleteRowFromDataBase(String data, HttpServletRequest request, HttpServletResponse response);
	String getSupplyOrderWaitingListForPendingApproval(String data, HttpServletRequest request,
			HttpServletResponse response);
	String getSupplierListForStore(String data, HttpServletRequest request, HttpServletResponse response);
	String createPvmsItemExcelList(String data);
	String importPvmsdataFromFileUpload(String data, HttpServletRequest request, HttpServletResponse response);
	String importPvmsdataReceivedFromiAushadhi(String string, HttpServletRequest request, HttpServletResponse response);
	String getAuNameForStore(String data, HttpServletRequest request, HttpServletResponse response);
	String showItemListForbackDateBudgetary(String data, HttpServletRequest request, HttpServletResponse response);
	String createBudgetaryForBackDateLP(String data, HttpServletRequest request, HttpServletResponse response);
	String getReceivingIndentWaitingListCo(String data, HttpServletRequest request, HttpServletResponse response);
	String receivingIndentInInventoryCo(HttpServletRequest request, HttpServletResponse response);
	String addToStockIssuedIndentCo(String string, HttpServletRequest request, HttpServletResponse response);
	String generateStockStatusReportCo(String data, HttpServletRequest request, HttpServletResponse response);
	String generateStockStatusReportDo(String data, HttpServletRequest request, HttpServletResponse response);
	String getAllUpssManufactureMapping(String data, HttpServletRequest request, HttpServletResponse response);

}
