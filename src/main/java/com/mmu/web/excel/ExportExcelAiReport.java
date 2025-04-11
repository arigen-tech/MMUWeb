package com.mmu.web.excel;

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
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.servlet.view.document.AbstractXlsxView;


public class ExportExcelAiReport extends AbstractXlsxView {	
  
	String fromDate="";
	String toDate="";
	String mmuName="";
    
  @Override
  protected void buildExcelDocument(Map<String, Object> model, Workbook workbook,
         HttpServletRequest request, HttpServletResponse response) throws Exception {
    	  
	String jsondata=model.get("data").toString();
	JSONObject json=new JSONObject(jsondata);
	JSONObject js=(JSONObject) json.get("aiAuditReport_data");
	fromDate= js.get("fromDate").toString();
	toDate= js.get("toDate").toString();
	mmuName= js.get("mmuName").toString();
	String js1=js.get("aiAuditReport_data").toString();

    String[] header1= {"MMU Name :"+mmuName+" (From Date :"+fromDate+" and To Date :"+toDate+")","","" ,"","","","","","","","AI Based Action","","","Final Observation"};	
    String[] header2= {"Patient Name","Gender","Age","Mobile No.","OPD Date","Doctor Name","Signs and Symptoms","Diagnosis","Treatment","Investigation",
    		"Diagnosis","Treatment","Investigation",""
    		};
    int rowNum = 2;
    
    // Creating sheet with in the workbook
    Sheet sheet = workbook.createSheet("AI_Audit_Report");
    /** for header **/
    String fileName = "AIAuditReport_DateRange.xlsx";

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
    
    Row row1 = sheet.createRow(0);
    Row row2 = sheet.createRow(1);
    Row row3=null;
    
    for(int i = 0; i < header1.length; i++) {
      // each column 25 characters wide
      sheet.setColumnWidth(i, 25*256);
      Cell cell = row1.createCell(i);
      cell.setCellValue(header1[i]);
      cell.setCellStyle(style);
    }
    
    for(int i = 0; i < header2.length; i++) {
        // each column 25 characters wide
        sheet.setColumnWidth(i, 25*256);
        Cell cell = row2.createCell(i);
        cell.setCellValue(header2[i]);
        cell.setCellStyle(style);
      }
       
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$A$1:$J$1"));
    /*sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$B$1:$B$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$C$1:$C$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$D$1:$D$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$E$1:$E$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$F$1:$F$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$G$1:$G$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$H$1:$H$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$I$1:$I$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$J$1:$J$2"));*/
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$K$1:$M$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$N$1:$N$2"));
    
    try
    {
		JSONArray jsonArray=new JSONArray(js1);
		
		String diagnosisflag="";
		String prescriptionflag="";
		String investigationflag="";
		
		int rowTotal = 0;
         
        for(int i=0;i<jsonArray.length();i++)
        {
           	int j=1;
        	j=j+i;
        	
        	row3 = sheet.createRow(rowNum++);
        	
            JSONObject jsonObject1 = jsonArray.getJSONObject(i);
            if(jsonObject1.optString("diagnosisflag") !=null && !jsonObject1.optString("diagnosisflag").isEmpty()) {
            	diagnosisflag=jsonObject1.optString("diagnosisflag").toString();
            }
            if(jsonObject1.optString("prescriptionflag") !=null && !jsonObject1.optString("prescriptionflag").isEmpty()) {
            	prescriptionflag=jsonObject1.optString("prescriptionflag").toString();
            }
            if(jsonObject1.optString("investigationflag") !=null && !jsonObject1.optString("investigationflag").isEmpty()) {
            	investigationflag=jsonObject1.optString("investigationflag").toString();
            }
            
            row3.createCell(0).setCellValue(jsonObject1.optString("patientname"));
            row3.createCell(1).setCellValue(jsonObject1.optString("age"));
            row3.createCell(2).setCellValue(jsonObject1.optString("sex_name"));
            row3.createCell(3).setCellValue(jsonObject1.optString("mobilenumber"));
            row3.createCell(4).setCellValue(jsonObject1.optString("opddate"));
            row3.createCell(5).setCellValue(jsonObject1.optString("dectorname"));
            row3.createCell(6).setCellValue(jsonObject1.optString("sign"));
            row3.createCell(7).setCellValue(jsonObject1.optString("diagnosis"));
            row3.createCell(8).setCellValue(jsonObject1.optString("prescription"));
            row3.createCell(9).setCellValue(jsonObject1.optString("investigation"));
            row3.createCell(10).setCellValue(diagnosisflag);
            row3.createCell(11).setCellValue(prescriptionflag);
            row3.createCell(12).setCellValue(investigationflag);
            row3.createCell(13).setCellValue(jsonObject1.optString("ai_audit_exception"));
            
         
            Cell cell = row3.createCell(14);
            rowTotal = sheet.getLastRowNum();
        }
        Row row4 = sheet.createRow(rowTotal+2);
        
        row4.createCell(0).setCellValue("");
        row4.createCell(1).setCellValue("");
        row4.createCell(2).setCellValue("");
        row4.createCell(3).setCellValue("");
        row4.createCell(4).setCellValue("");
        row4.createCell(5).setCellValue("");
        row4.createCell(6).setCellValue("");
        row4.createCell(7).setCellValue("");
        row4.createCell(8).setCellValue("");
        row4.createCell(9).setCellValue("");
        row4.createCell(10).setCellValue("");
        row4.createCell(11).setCellValue("");
        row4.createCell(12).setCellValue("");
        row4.createCell(13).setCellValue("");
       
        Cell cell = row4.createCell(14);
        
        
      }
    catch (JSONException e)
     {
        e.printStackTrace();
    }
    
    }
}