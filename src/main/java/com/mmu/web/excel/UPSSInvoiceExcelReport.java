package com.mmu.web.excel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

public class UPSSInvoiceExcelReport extends AbstractXlsxView{
	private static String[] CLEAR_HEADERS ={ "SN","Vendor","MMU","Invoice Date","Invoice No.","Invoice Amount","Cleared Amount","Penalty Amount","Total Deductions","Upload Date","Last Approved Status" };
	private static String[] UNCLEAR_HEADERS ={ "SN","Vendor","MMU","Invoice Date",  "Invoice No.","Invoice Amount","UnCleared Amount","Upload Date","Last Approved Status" };
	private static String[] TOTAL_HEADERS ={ "SN","Vendor","MMU","Invoice Date", "Upload Date", "Invoice No.","Invoice Amount","Last Approved Status" };

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	 

	    List<String> dates =  new ArrayList<>();
	    dates.add("FromDate");
	    dates.add("ToDate");
	    dates.add("Phase");
	    
		String jsondata=model.get("data").toString();
		String fromDate = model.get("fromDate").toString();
		String toDate = model.get("toDate").toString();
		String phase = model.get("phase").toString();
		dates.add(1, fromDate);
		dates.add(3,toDate);
		dates.add(5,phase);
		String mmuCity = model.get("mmuCity").toString();
		String flagType = model.get("flagType").toString();
		JSONObject json=new JSONObject(jsondata);
		JSONObject js=(JSONObject) json.get("data");
		String js1=js.get("invoiceDataInfo").toString();
		boolean isUPSS = true;
		String types= mmuCity.equalsIgnoreCase("C")?"City":"UPSS";
	    // Creating sheet with in the workbook
		dates.add(types);
		dates.add(model.get("upss_name").toString());
		String fileName = "";
		if (flagType.equalsIgnoreCase("C")) {
			fileName = "MMUClearedInvoiceReport";
		} else if (flagType.equalsIgnoreCase("U")) {
			fileName = "MMUUnclearedInvoiceReport";
		} else {
			fileName = "MMUTotalInvoiceReport";
		}
		
	    Sheet sheet = workbook.createSheet(fileName+"_"+types);
	    /** for header **/
	    fileName = fileName+"_"+types+".xlsx";

	    response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
	    response.setHeader("Content-Disposition", "attachment; filename="+fileName); 
	    Font font = workbook.createFont();
        font.setFontName("Calibri");
        font.setColor(IndexedColors.WHITE.getIndex());
        font.setBold(true);

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setWrapText(true);
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setFillForegroundColor(IndexedColors.CORNFLOWER_BLUE.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setBorderRight(BorderStyle.THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(BorderStyle.THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(BorderStyle.THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(BorderStyle.THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());

        Row headerRowDate = sheet.createRow(0);
        for (int i = 0; i < dates.size(); i++) {
        	sheet.setColumnWidth(i, 25*256);
            Cell cell1 = headerRowDate.createCell(i);
            cell1.setCellValue(dates.get(i));
          
        }
        // Create a Row
        List<String> HEADERS = null;
        Row headerRow = sheet.createRow(2);
        if(flagType.equalsIgnoreCase("C")) {
        	HEADERS= Arrays.asList(CLEAR_HEADERS);
        }else if(flagType.equalsIgnoreCase("U")) {
        	HEADERS= Arrays.asList(UNCLEAR_HEADERS);
        }else {
        	HEADERS= Arrays.asList(TOTAL_HEADERS);
        }
        for (int i = 0; i < HEADERS.size(); i++) {
        	 sheet.setColumnWidth(i, 25*256);
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(HEADERS.get(i));
            cell.setCellStyle(style);
        }

        // Create Other rows and cells with contacts data
        int rowNum = 3;
        try
        {
        	
    		  JSONArray jsonArray=new JSONArray(js1);
    		  Integer totalInvoiceAmount = 0;
    		  int index=1;
    		  if(flagType.equalsIgnoreCase("C")) {
    			  totalInvoiceAmount = 0;
    			  for(int i=0;i<jsonArray.length();i++)
	    	        {
  
	    			  	JSONObject jsonObject1 = jsonArray.getJSONObject(i);
	    	            Row row = sheet.createRow(rowNum++);
	    	            row.createCell(0).setCellValue(i+1);
	    	            String upss = isUPSS?jsonObject1.optString("upss"):jsonObject1.optString("city");
	    	            row.createCell(1).setCellValue(jsonObject1.optString("vendor"));
	    	            row.createCell(2).setCellValue(jsonObject1.optString("mmu"));
	    	            row.createCell(3).setCellValue(jsonObject1.optString("invoice_date"));
	    	            row.createCell(4).setCellValue(jsonObject1.optString("invoice_no"));
	    	            row.createCell(5).setCellValue(jsonObject1.optString("total_invoice"));
	    	            row.createCell(6).setCellValue(jsonObject1.optString("cleared_amount"));
	    	            row.createCell(7).setCellValue(jsonObject1.optString("penalty_amount"));
	    	            row.createCell(8).setCellValue(jsonObject1.optString("tds_deduction"));
	    	            row.createCell(9).setCellValue(jsonObject1.optString("upload_date"));
	    	            row.createCell(10).setCellValue(jsonObject1.optString("last_approval_status"));
	    	            //row.createCell(10).setCellValue(jsonObject1.optString("approval"));
	    	            totalInvoiceAmount+=Integer.valueOf(jsonObject1.optString("total_invoice"));
	    	            index=5;
	    	        }
    	        }else if(flagType.equalsIgnoreCase("U")) {
    	        	 totalInvoiceAmount = 0;
    	        	 for(int i=0;i<jsonArray.length();i++)
    	    	        {
    	        		 
    	    			  	JSONObject jsonObject1 = jsonArray.getJSONObject(i);
    	    	            Row row = sheet.createRow(rowNum++);
    	    	            row.createCell(0).setCellValue(i+1);
    	    	            String upss = isUPSS?jsonObject1.optString("upss"):jsonObject1.optString("city");
    	    	            row.createCell(1).setCellValue(jsonObject1.optString("vendor"));
    	    	            row.createCell(2).setCellValue(jsonObject1.optString("mmu"));
    	    	            row.createCell(3).setCellValue(jsonObject1.optString("invoice_date"));    	    	   
    	    	            row.createCell(4).setCellValue(jsonObject1.optString("invoice_no"));
    	    	            row.createCell(5).setCellValue( jsonObject1.has("total_invoice")?jsonObject1.optString("total_invoice"):"");
    	    	            row.createCell(6).setCellValue(jsonObject1.optString("uncleared_amount"));
    	    	            row.createCell(7).setCellValue(jsonObject1.optString("upload_date"));
    	    	            row.createCell(8).setCellValue(jsonObject1.optString("last_approval_status"));
    	    	           // row.createCell(9).setCellValue(jsonObject1.optString("approval"));
    	    	            totalInvoiceAmount+=Integer.valueOf(jsonObject1.optString("total_invoice"));
    	    	            index =5 ;
    	    	        }
    	        }else {  
    	         totalInvoiceAmount = 0;
	    		  for(int i=0;i<jsonArray.length();i++)
	    	        {
	    			  	JSONObject jsonObject1 = jsonArray.getJSONObject(i);
	    	            Row row = sheet.createRow(rowNum++);
	    	            row.createCell(0).setCellValue(i+1);
	    	            String upss = isUPSS?jsonObject1.optString("upss"):jsonObject1.optString("city");
	    	            row.createCell(1).setCellValue(jsonObject1.optString("vendor"));
	    	            row.createCell(2).setCellValue(jsonObject1.optString("mmu"));
	    	            row.createCell(3).setCellValue(jsonObject1.optString("invoice_date"));
	    	            row.createCell(4).setCellValue(jsonObject1.optString("upload_date"));
	    	            row.createCell(5).setCellValue(jsonObject1.optString("invoice_no"));
	    	            row.createCell(6).setCellValue(jsonObject1.optString("total_invoice"));
	    	            row.createCell(7).setCellValue(jsonObject1.optString("last_approval_status"));
	    	            totalInvoiceAmount+=Integer.valueOf(jsonObject1.optString("total_invoice"));
	    	          //  row.createCell(8).setCellValue(jsonObject1.optString("approval"));
	    	            index=6;
	    	        }
    	        }
    		  Row lastRow = sheet.createRow(rowNum+2);
    		  lastRow.createCell(0).setCellValue("Total Invoice Amount ");
    	      lastRow.createCell(index).setCellValue(""+totalInvoiceAmount);
        }
        catch(Exception exception) {
        	
        }
		
	}
	
}
