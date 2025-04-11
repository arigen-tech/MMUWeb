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

public class FundManagementExcelReport extends AbstractXlsxView{
	
	private static String[] HEADERS1 = { "SN", "UPSS","Total Fund", "Fund Allocated","","","","Fund Utilized","","","","Available Balance"};
	private static String[] HEADERS2 ={ "MMU Operations", "IEC", "Medicine","Interest","MMU Operations", "IEC", "Medicine" ,"Total","MMU Operations", "IEC", "Medicine","Total","Utilized %","Remain %"};

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
		String distIdVal = model.get("distIdVal").toString();
		String levelOfUser = model.get("levelOfUser").toString();
		dates.add(1, fromDate);
		dates.add(3,toDate);
		dates.add(5,phase);
		//dates.add(6,distIdVal);
		//dates.add(7,levelOfUser);
		String mmuCity = model.get("mmuCity").toString();
		JSONObject json=new JSONObject(jsondata);
		JSONObject js=(JSONObject) json.get("data");
		String js1=js.get("fundInvoiceDataInfo").toString();
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
	    Sheet sheet = workbook.createSheet("FundManagement"+HEADERS1[1]+"_Report");
	    /** for header **/
	    String fileName = "FundManagement"+HEADERS1[1]+"_Report.xlsx";

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
        for (int i = 0; i < HEADERS1.length; i++) {
        	sheet.setColumnWidth(i, 25*256);
            Cell cell1 = headerRow1.createCell(i);
            cell1.setCellValue(HEADERS1[i]);
            cell1.setCellStyle(style);
        }
        sheet.setColumnWidth(12, 25*256);
        Cell cell1 = headerRow1.createCell(13);
        cell1.setCellValue(HEADERS1[11]);
        cell1.setCellStyle(style);
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 1, 1));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 2, 2));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 3, 6));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 7, 10));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 11, 14));
        //sheet.addMergedRegion(new CellRangeAddress(1, 1, 12, 1));
        //sheet.addMergedRegion(new CellRangeAddress(1, 1, 15, 17));

        Row headerRow = sheet.createRow(2);
        for (int i = 0; i < HEADERS2.length; i++) {
        	 sheet.setColumnWidth(i, 25*256);
            Cell cell = headerRow.createCell(i+3);
            cell.setCellValue(HEADERS2[i]);
            cell.setCellStyle(style);
        }

        // Create Other rows and cells with contacts data
        int rowNum = 3;
        try
        {
        	Double totalFund = 0.0;
        	Double fundOperation = 0.0;
        	Double fundAdmin = 0.0;
        	Double fundMedicine = 0.0;
        	
        	Double utilizedOperation = 0.0;
        	Double utilizedAdmin = 0.0;
        	Double utilizedMedicine = 0.0;
        	Double interest=0.0;
        	Double available_balance=0.0;
        	Double utilized_total=0.0;
        	Double available_operation=0.0;
        	Double available_admin=0.0;
        	Double available_medicine=0.0;
        	Double utilized=0.0;
        	Double remain=0.0;
    		JSONArray jsonArray=new JSONArray(js1);	
    		  for(int i=0;i<jsonArray.length();i++)
    	        {
    			  	JSONObject jsonObject1 = jsonArray.getJSONObject(i);
    	            Row row = sheet.createRow(rowNum++);
    	            row.createCell(0).setCellValue(i+1);
    	            String upss = isUPSS?jsonObject1.optString("upss"):jsonObject1.optString("city");
    	            row.createCell(1).setCellValue(upss);
    	            
    	       //     row.createCell(2).setCellValue(phase);
    	            
    	            row.createCell(2).setCellValue(jsonObject1.optString("total_fund"));
    	            row.createCell(3).setCellValue(jsonObject1.optString("fund_operation"));
    	            row.createCell(4).setCellValue(jsonObject1.optString("fund_admin"));
    	            row.createCell(5).setCellValue(jsonObject1.optString("fund_medicine"));
    	            
    	            row.createCell(6).setCellValue(jsonObject1.optString("fund_interest"));
    	            
    	            row.createCell(7).setCellValue(jsonObject1.optString("utilized_operation"));
    	            row.createCell(8).setCellValue(jsonObject1.optString("utilized_admin"));
    	            row.createCell(9).setCellValue(jsonObject1.optString("utilized_medicine"));
    	            row.createCell(10).setCellValue(jsonObject1.optString("utilized_total"));
    	            
    	            row.createCell(11).setCellValue(jsonObject1.optString("available_operation"));
    	            row.createCell(12).setCellValue(jsonObject1.optString("available_admin"));
    	            row.createCell(13).setCellValue(jsonObject1.optString("available_medicine"));
    	            row.createCell(14).setCellValue(jsonObject1.optString("available_balance"));
    	            row.createCell(15).setCellValue(jsonObject1.optString("utilized"));
    	            row.createCell(16).setCellValue(jsonObject1.optString("remain"));
    	            
    	            totalFund+=Double.valueOf(jsonObject1.optString("total_fund"));
    	            fundOperation+=Double.valueOf(jsonObject1.optString("fund_operation"));
    	            fundAdmin+=Double.valueOf(jsonObject1.optString("fund_admin"));
    	            fundMedicine+=Double.valueOf(jsonObject1.optString("fund_medicine"));
    	            interest+=Double.valueOf(jsonObject1.optString("fund_interest"));
     	            
    	            utilizedOperation+=Double.valueOf(jsonObject1.optString("utilized_operation"));
    	            utilizedAdmin+=Double.valueOf(jsonObject1.optString("utilized_admin"));
    	            utilizedMedicine+=Double.valueOf(jsonObject1.optString("utilized_medicine"));
    	            utilized_total+=Double.valueOf(jsonObject1.optString("utilized_total"));
    	            
    	            available_operation+=Double.valueOf(jsonObject1.optString("available_operation"));
    	            available_admin+=Double.valueOf(jsonObject1.optString("available_admin"));
    	            available_medicine+=Double.valueOf(jsonObject1.optString("available_medicine"));
    	            available_balance+=Double.valueOf(jsonObject1.optString("available_balance"));
    	            utilized+=Double.valueOf(jsonObject1.optString("utilized"));
    	            remain+=Double.valueOf(jsonObject1.optString("remain"));
    	        }
    		  
    		  Row lastRow = sheet.createRow(rowNum+2);
    		  lastRow.createCell(0).setCellValue("Total Amount ");
    		 // lastRow.createCell(2).setCellValue("Phase ");
    	      lastRow.createCell(2).setCellValue(""+totalFund);
    	      lastRow.createCell(3).setCellValue(""+fundOperation);
    	      lastRow.createCell(4).setCellValue(""+fundAdmin);
    	      lastRow.createCell(5).setCellValue(""+fundMedicine);
    	      lastRow.createCell(6).setCellValue(""+interest);
    	      lastRow.createCell(7).setCellValue(""+utilizedOperation);
    	      lastRow.createCell(8).setCellValue(""+utilizedAdmin);
    	      lastRow.createCell(9).setCellValue(""+utilizedMedicine);
    	      lastRow.createCell(10).setCellValue(""+utilized_total);
    	      
    	      lastRow.createCell(11).setCellValue(""+available_operation);
    	      lastRow.createCell(12).setCellValue(""+available_admin);
    	      lastRow.createCell(13).setCellValue(""+available_medicine);
    	      lastRow.createCell(14).setCellValue(""+available_balance);
    	      //lastRow.createCell(15).setCellValue(""+utilized);
    	      //lastRow.createCell(16).setCellValue(""+remain);
        }
        catch(Exception exception) {
        	exception.printStackTrace();
        }
		
	}
}
