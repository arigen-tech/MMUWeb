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

public class MedicineInvoiceExcelReport extends AbstractXlsxView{

	public static String[] UPSS ={ "SN","City","Source of Medicine","Invoice Date", "Upload Date", "Invoice No.","Invoice Amount"};
	public static String[] CITY ={ "SN","Source of Medicine","Invoice Date", "Upload Date", "Invoice No.","Invoice Amount"};

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String flageTypeName=null;
		if(model.get("flageTypeName")!=null)
		  flageTypeName=model.get("flageTypeName").toString();
 		
	    List<String> dates =  new ArrayList<>();
	    List<String>  headers = new ArrayList<>();
	    dates.add("FromDate");
	    dates.add("ToDate");
	    dates.add("Phase");
		String jsondata=model.get("data").toString();
		String fromDate = model.get("fromDate").toString();
		String toDate = model.get("toDate").toString();
		String phase=model.get("phase").toString();
		dates.add(1, fromDate);
		dates.add(3,toDate);
		dates.add(5,phase);
		String mmuCity = model.get("mmuCity").toString();
		JSONObject json=new JSONObject(jsondata);
		JSONObject js=(JSONObject) json.get("data");
		String js1="";
			
			if(flageTypeName!=null && flageTypeName.equalsIgnoreCase("IEC")) {
				
				js1=js.get("fundInvoiceDataInfo").toString();
			}
			else {
		  js1=js.get("invoiceDataInfo").toString();
			}
		  boolean isUPSS = true;
		String types= mmuCity.equalsIgnoreCase("C")?"City":"UPSS";
		if(mmuCity.equalsIgnoreCase("C")) {
			isUPSS=false;
			headers.addAll(Arrays.asList(CITY));
		}else {
			isUPSS= true;
			headers.addAll(Arrays.asList(UPSS));
		}
		if(flageTypeName!=null && flageTypeName.equalsIgnoreCase("IEC")) {
			//List<String>  headers1 = new ArrayList<>();
			//headers1.add("Source of Medicine");
			headers.remove("Source of Medicine");
			headers.remove("City");
		}
		
		
	    // Creating sheet with in the workbook
		dates.add(types);
		dates.add(model.get("upss_name").toString());
	    /** for header **/
		String fileName ="";
		if(flageTypeName!=null && flageTypeName.equalsIgnoreCase("IEC")) {
			fileName = "IEC_Report";
		}
		else {
	    fileName = "MedicineInvoice_Report";
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
        Row headerRow = sheet.createRow(2);
     
        for (int i = 0; i < headers.size(); i++) {
        	 sheet.setColumnWidth(i, 25*256);
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers.get(i));
            cell.setCellStyle(style);
        }

        // Create Other rows and cells with contacts data
        int rowNum = 3;
        try
        {
        	
    		JSONArray jsonArray=new JSONArray(js1);	
    		
			Integer totalInvoiceAmount = 0;
			if(isUPSS) {
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject jsonObject1 = jsonArray.getJSONObject(i);
					Row row = sheet.createRow(rowNum++);
					row.createCell(0).setCellValue(i + 1);
					if(!flageTypeName.equalsIgnoreCase("IEC")) {
						
						String city = jsonObject1.has("city")?jsonObject1.optString("city"):"";
						row.createCell(1).setCellValue(city);
						
						row.createCell(2).setCellValue(jsonObject1.optString("soure_of_medicine"));
						
					row.createCell(3).setCellValue(jsonObject1.optString("invoice_date"));
					row.createCell(4).setCellValue(jsonObject1.optString("upload_date"));
					row.createCell(5).setCellValue(jsonObject1.optString("invoice_no"));
					row.createCell(6).setCellValue(jsonObject1.optString("total_invoice"));
					}
					else {
					 	row.createCell(1).setCellValue(jsonObject1.optString("invoice_date"));
						row.createCell(2).setCellValue(jsonObject1.optString("upload_date"));
						row.createCell(3).setCellValue(jsonObject1.optString("invoice_no"));
						row.createCell(4).setCellValue(jsonObject1.optString("total_invoice"));
					
					}
					totalInvoiceAmount += Integer.valueOf(jsonObject1.optString("total_invoice"));
				}
				Row lastRow = sheet.createRow(rowNum + 2);
				lastRow.createCell(0).setCellValue("Total Invoice Amount ");
				if(!flageTypeName.equalsIgnoreCase("IEC")) {
				lastRow.createCell(6).setCellValue("" + totalInvoiceAmount);
				}
				else {
					lastRow.createCell(4).setCellValue("" + totalInvoiceAmount);
				}
				}
			else {
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject jsonObject1 = jsonArray.getJSONObject(i);
					Row row = sheet.createRow(rowNum++);
					row.createCell(0).setCellValue(i + 1);
					if(!flageTypeName.equalsIgnoreCase("IEC")) {
					row.createCell(1).setCellValue(jsonObject1.optString("soure_of_medicine"));
					row.createCell(2).setCellValue(jsonObject1.optString("invoice_date"));
					row.createCell(3).setCellValue(jsonObject1.optString("upload_date"));
					row.createCell(4).setCellValue(jsonObject1.optString("invoice_no"));
					row.createCell(5).setCellValue(jsonObject1.optString("total_invoice"));
					
					}
					else {
						row.createCell(1).setCellValue(jsonObject1.optString("invoice_date"));
						row.createCell(2).setCellValue(jsonObject1.optString("upload_date"));
						row.createCell(3).setCellValue(jsonObject1.optString("invoice_no"));
						row.createCell(4).setCellValue(jsonObject1.optString("total_invoice"));
						
							
					}
					totalInvoiceAmount += Integer.valueOf(jsonObject1.optString("total_invoice"));
				}
				Row lastRow = sheet.createRow(rowNum + 2);
				lastRow.createCell(0).setCellValue("Total Invoice Amount ");
				if(!flageTypeName.equalsIgnoreCase("IEC")) {
				lastRow.createCell(5).setCellValue("" + totalInvoiceAmount);
				}
				else {
					lastRow.createCell(4).setCellValue("" + totalInvoiceAmount);
				}
				}
    	        
        }
        catch(Exception exception) {
        	
        }
		
	}
	
}
