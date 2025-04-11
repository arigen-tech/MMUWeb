package com.mmu.web.excel;

import java.util.ArrayList;
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
import org.apache.poi.ss.util.CellRangeAddress;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.servlet.view.document.AbstractXlsxView;


public class InvoiceExcelReport extends AbstractXlsxView{
	private static String[] HEADERS1 = { "SN", "UPSS", "MMU Operations", "Medicine Invoice" };
	private static String[] HEADERS2 ={ "Total Invoice", "Cleared Amount", "Uncleared Amount","Invoice Amount" };

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
		JSONObject json=new JSONObject(jsondata);
		JSONObject js=(JSONObject) json.get("data");
		String js1=js.get("invoiceDataInfo").toString();
		boolean isUPSS = true;
		if(mmuCity!=null &&  mmuCity.equalsIgnoreCase("C")) {
			HEADERS1[1]="City";
			isUPSS = false;
		}
		else {
				HEADERS1[1]="UPSS";
				isUPSS = true;
		}
	    // Creating sheet with in the workbook
	    Sheet sheet = workbook.createSheet("TrackInvoice_"+HEADERS1[1]+"_Report");
	    /** for header **/
	    String fileName = "TrackInvoice_"+HEADERS1[1]+"_Report.xlsx";

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
        Row headerRow1 = sheet.createRow(1);
        for (int i = 0; i < HEADERS1.length-1; i++) {
        	sheet.setColumnWidth(i, 25*256);
            Cell cell1 = headerRow1.createCell(i);
            cell1.setCellValue(HEADERS1[i]);
            cell1.setCellStyle(style);
        }
        Cell cell1 = headerRow1.createCell(5);
        cell1.setCellValue(HEADERS1[3]);
        cell1.setCellStyle(style);
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));
        sheet.addMergedRegion(new CellRangeAddress(1,2,1, 1 ));
        sheet.addMergedRegion(new CellRangeAddress(1,1,2, 4 ));


        Row headerRow = sheet.createRow(2);
        for (int i = 0; i < HEADERS2.length; i++) {
        	 sheet.setColumnWidth(i, 25*256);
            Cell cell = headerRow.createCell(i+2);
            cell.setCellValue(HEADERS2[i]);
            cell.setCellStyle(style);
        }

        // Create Other rows and cells with contacts data
        int rowNum = 3;
        try
        {
        	Double totalInvoiceAmount = 0.0;
        	Double clearInvoiceAmount = 0.0;
        	Double unclearInvoiceAmount = 0.0;
        	Double medicineInvoiceAmount = 0.0;
    		JSONArray jsonArray=new JSONArray(js1);	
    		  for(int i=0;i<jsonArray.length();i++)
    	        {
    			  	JSONObject jsonObject1 = jsonArray.getJSONObject(i);
    	            Row row = sheet.createRow(rowNum++);
    	            row.createCell(0).setCellValue(i+1);
    	            String upss = isUPSS?jsonObject1.optString("upss"):jsonObject1.optString("city");
    	            row.createCell(1).setCellValue(upss);
    	            row.createCell(2).setCellValue(jsonObject1.optString("total_invoice"));
    	            row.createCell(3).setCellValue(jsonObject1.optString("cleared_amount"));
    	            row.createCell(4).setCellValue(jsonObject1.optString("uncleared_amount"));
    	            row.createCell(5).setCellValue(jsonObject1.optString("invoice_amount"));
    	            totalInvoiceAmount+=Double.valueOf(jsonObject1.optString("total_invoice"));
    	            clearInvoiceAmount+=Double.valueOf(jsonObject1.optString("cleared_amount"));
    	            unclearInvoiceAmount+=Double.valueOf(jsonObject1.optString("uncleared_amount"));
    	            medicineInvoiceAmount+=Double.valueOf(jsonObject1.optString("invoice_amount"));
    	        }
    		  
    		  Row lastRow = sheet.createRow(rowNum+2);
    		  lastRow.createCell(0).setCellValue("Total Amount ");
    	      lastRow.createCell(2).setCellValue(""+totalInvoiceAmount);
    	      lastRow.createCell(3).setCellValue(""+clearInvoiceAmount);
    	      lastRow.createCell(4).setCellValue(""+unclearInvoiceAmount);
    	      lastRow.createCell(5).setCellValue(""+medicineInvoiceAmount);
    	        
        }
        catch(Exception exception) {
        	
        }
		
	}
	
}
