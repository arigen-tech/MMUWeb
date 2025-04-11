package com.mmu.web.excel;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Header;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.servlet.view.document.AbstractXlsxView;


public class ExportExcelEdlReportsCityWise extends AbstractXlsxView {
  
  static String asondate="";

  //static String toDate="";
  
  @Override
  protected void buildExcelDocument(Map<String, Object> model, Workbook workbook,
         HttpServletRequest request, HttpServletResponse response) throws Exception {
    	  
	String jsondata=model.get("data").toString();
	JSONObject json=new JSONObject(jsondata);
	JSONObject js=(JSONObject) json.get("edlReportCityWise_data");
	String js1=js.get("edlReportCityWise_data").toString();
	asondate=js.getString("asondate").toString();
	//toDate=js.getString("toDate").toString();
	//String header="Stock Status Report(MMU Wise)";
	// String[] header1= {"","","Stock Status Report(MMU Wise)","",""};
    //String[] header2= {"","Serial No.","City Name","MMU Name","Stock Of MMU EDL Wise","Summary of EDL not available in MMU's (As on date"+asondate+""};
    String[] header1= {"Stock Status Report(City Wise)"};	
    String[] header2= {"S.No.","City Name","Stock of EDL City Wise"    		
    		};
    int rowNum = 2;
    
    // Creating sheet with in the workbook
    Sheet sheet = workbook.createSheet("EDLInfo reg");
    /** for header **/
    String fileName = "EdlReportsCityWise.xlsx";    
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
    Row row3 = null;
    for(int i = 0; i < header1.length; i++) {
        // each column 15 characters wide
        sheet.setColumnWidth(i, 15*256);
        Cell cell = row1.createCell(i);
        cell.setCellValue(header1[i]);
        cell.setCellStyle(style);
      }
    
    for(int i = 0; i < header2.length; i++) {
      // each column 15 characters wide
      sheet.setColumnWidth(i, 15*256);
      Cell cell = row2.createCell(i);
      cell.setCellValue(header2[i]);
      cell.setCellStyle(style);
    }
   
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$A$1:$C$1"));
    //sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$B$1:$B$2"));
    //sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$C$1:$C$2"));
    //sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$D$1:$E$1"));
    //sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$E$1:$E$2"));
    try
    {
		JSONArray jsonArray=new JSONArray(js1);	
			
		int a1=0;
		int a2=0;
		String city_name = null;
		String mmu_name=null;
		
		
		int rowTotal = 0;
		
		if(jsonArray.length()==0) {
			rowTotal=2;
		}
		
        for(int i=0;i<jsonArray.length();i++)
        {
        	int j=1;
        	j=j+i;
        	row3 = sheet.createRow(rowNum++);
            JSONObject jsonObject1 = jsonArray.getJSONObject(i);
            //sheet.getPageSetup().setRightHeader("Stock Status Report(MMU Wise)");
            if(jsonObject1.optString("city_name") !=null && !jsonObject1.optString("city_name").isEmpty()) {
            	city_name=jsonObject1.optString("city_name").toString();
            }
           
            if(jsonObject1.optString("a1") !=null && !jsonObject1.optString("a1").isEmpty()) {
            	a1=Integer.parseInt(jsonObject1.optString("a1").toString());
            }   
                      
           
            row3.createCell(0).setCellValue(j);
            row3.createCell(1).setCellValue(jsonObject1.optString("city_name"));
            row3.createCell(2).setCellValue(jsonObject1.optString("a1") !=null && !jsonObject1.optString("a1").isEmpty()
            		? Integer.parseInt(jsonObject1.optString("a1")) : 0);
            Cell cell = row3.createCell(3);
            rowTotal = sheet.getLastRowNum();
        }
        Row row4 = sheet.createRow(rowTotal+1);
        
     
       // row4.createCell(0).setCellValue(j);
       // row4.createCell(1).setCellValue(city_name);
       // row4.createCell(2).setCellValue(mmu_name);
       // row4.createCell(3).setCellValue(a1);
       // row4.createCell(4).setCellValue(a2);
        
        //Cell cell = row4.createCell(5);        
       
      }
    catch (JSONException e) 
     {
        e.printStackTrace();
    }
    
    }
}