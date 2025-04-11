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


public class ExportExcelDiaDidi extends AbstractXlsxView {	
  
	String campDate="";
    
  @Override
  protected void buildExcelDocument(Map<String, Object> model, Workbook workbook,
         HttpServletRequest request, HttpServletResponse response) throws Exception {
    	  
	String jsondata=model.get("data").toString();
	JSONObject json=new JSONObject(jsondata);
	JSONObject js=(JSONObject) json.get("daiDidiClinic_data");
	campDate= js.get("campDate").toString();
	String js1=js.get("daiDidiClinic_data").toString();
	
	String[] header1= {"S.No.","District","City","Today's progress - "+campDate,"","","","","","","Progress till date","","","","","","",};	
    String[] header2= {"","","","No. of camp","Total patients","Average patient count",
    		"Count of patient against which lab test is done","Count of patient to whom medicine is given",
    		"Count of patient registered in labour department","Count of patient who has submitted form for labour registration",
    		"No. of camp","Total patients","Average patient count","Count of patient against which lab test is done",
    		"Count of patient to whom medicine is given","Count of patient registered in labour department",
    		"Count of patient who has submitted form for labour registration"    		
    		};
	
    int rowNum = 2;
    
    // Creating sheet with in the workbook
    String campDateN=campDate.replace("/", "-");
    Sheet sheet = workbook.createSheet("Dai Didi Clinic_"+campDateN);
    /** for header **/
   
    String fileName = "DaiDidiClinicRegister_"+campDateN+".xlsx";

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
       
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$A$1:$A$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$B$1:$B$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$C$1:$C$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$D$1:$J$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$K$1:$Q$1"));
    
    try
    {
		JSONArray jsonArray=new JSONArray(js1);
		
		Double tot_t_no_of_camp=0.0;
		Double tot_t_no_of_patient=0.0;
		Double tot_t_avg_patient=0.0;
		Double tot_t_lab_test=0.0;
		Double tot_t_medicine_given=0.0;
		Double tot_t_labour_reg=0.0;
		Double tot_t_sub_labour_reg=0.0;
		Double tot_p_no_of_camp=0.0;
		Double tot_p_no_of_patient=0.0;
		Double tot_p_avg_patient=0.0;
		Double tot_p_lab_test=0.0;
		Double tot_p_medicine_given=0.0;
		Double tot_p_labour_reg=0.0;
		Double tot_p_sub_labour_reg=0.0;
		
		int rowTotal = 0;
		int totalNoOfCity = jsonArray.length();
		int totalNoOfCitywithtodayCamp=0;
		
		System.out.println("totalno of city"+totalNoOfCity);
         
        for(int i=0;i<jsonArray.length();i++)
        {
           	int j=1;
        	j=j+i;
        	
        	
        	
        	row3 = sheet.createRow(rowNum++);
        	
            JSONObject jsonObject1 = jsonArray.getJSONObject(i);
            if(jsonObject1.optString("t_no_of_camp") !=null && !jsonObject1.optString("t_no_of_camp").isEmpty()) {
            tot_t_no_of_camp=tot_t_no_of_camp+ Double.parseDouble(jsonObject1.optString("t_no_of_camp").toString());
            }
            if(jsonObject1.optString("t_no_of_patient") !=null && !jsonObject1.optString("t_no_of_patient").isEmpty()) {
            	
            tot_t_no_of_patient=tot_t_no_of_patient+ Double.parseDouble(jsonObject1.optString("t_no_of_patient").toString());
	            
            }
            if(jsonObject1.optString("t_avg_patient") !=null && !jsonObject1.optString("t_avg_patient").isEmpty()) {
            tot_t_avg_patient=tot_t_avg_patient+ Double.parseDouble(jsonObject1.optString("t_avg_patient").toString());
            }
            if(jsonObject1.optString("t_lab_test") !=null && !jsonObject1.optString("t_lab_test").isEmpty()) {
            tot_t_lab_test=tot_t_lab_test+ Double.parseDouble(jsonObject1.optString("t_lab_test").toString());
            }
            if(jsonObject1.optString("t_medicine_given") !=null && !jsonObject1.optString("t_medicine_given").isEmpty()) {
            tot_t_medicine_given=tot_t_medicine_given+ Double.parseDouble(jsonObject1.optString("t_medicine_given").toString());
            }
            if(jsonObject1.optString("t_labour_reg") !=null && !jsonObject1.optString("t_labour_reg").isEmpty()) {
            tot_t_labour_reg=tot_t_labour_reg+ Double.parseDouble(jsonObject1.optString("t_labour_reg").toString());
            }
            if(jsonObject1.optString("t_sub_labour_reg") !=null && !jsonObject1.optString("t_sub_labour_reg").isEmpty()) {
            tot_t_sub_labour_reg=tot_t_sub_labour_reg+ Double.parseDouble(jsonObject1.optString("t_sub_labour_reg").toString());
            }
            if(jsonObject1.optString("p_no_of_camp") !=null && !jsonObject1.optString("p_no_of_camp").isEmpty()) {
            tot_p_no_of_camp=tot_p_no_of_camp+ Double.parseDouble(jsonObject1.optString("p_no_of_camp").toString());
            }
            if(jsonObject1.optString("p_no_of_patient") !=null && !jsonObject1.optString("p_no_of_patient").isEmpty()) {
            tot_p_no_of_patient=tot_p_no_of_patient+ Double.parseDouble(jsonObject1.optString("p_no_of_patient").toString());
            }
            if(jsonObject1.optString("p_avg_patient").toString() !=null && !jsonObject1.optString("p_avg_patient").toString().isEmpty()) {
            	tot_p_avg_patient=tot_p_avg_patient+ Math.round(Double.parseDouble(jsonObject1.optString("p_no_of_patient"))/Double.parseDouble(jsonObject1.optString("p_no_of_camp")));
            }
            if(jsonObject1.optString("p_lab_test") !=null && !jsonObject1.optString("p_lab_test").isEmpty()) {
            tot_p_lab_test=tot_p_lab_test+ Double.parseDouble(jsonObject1.optString("p_lab_test").toString());
            }
            if(jsonObject1.optString("p_medicine_given") !=null && !jsonObject1.optString("p_medicine_given").isEmpty()) {
            tot_p_medicine_given=tot_p_medicine_given+ Double.parseDouble(jsonObject1.optString("p_medicine_given").toString());
            }
            if(jsonObject1.optString("p_labour_reg") !=null && !jsonObject1.optString("p_labour_reg").isEmpty()) {
            tot_p_labour_reg=tot_p_labour_reg+ Double.parseDouble(jsonObject1.optString("p_labour_reg").toString());
            }
            if(jsonObject1.optString("p_sub_labour_reg") !=null && !jsonObject1.optString("p_sub_labour_reg").isEmpty()) {
            tot_p_sub_labour_reg=tot_p_sub_labour_reg+ Double.parseDouble(jsonObject1.optString("p_sub_labour_reg").toString());
            }           
             
            row3.createCell(0).setCellValue(j);
            row3.createCell(1).setCellValue(jsonObject1.optString("districtname"));
            row3.createCell(2).setCellValue(jsonObject1.optString("cityname"));
            row3.createCell(3).setCellValue(jsonObject1.optString("t_no_of_camp") !=null && !jsonObject1.optString("t_no_of_camp").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("t_no_of_camp")) : 0);
            row3.createCell(4).setCellValue(jsonObject1.optString("t_no_of_patient") !=null  && !jsonObject1.optString("t_no_of_patient").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("t_no_of_patient")) : 0);
            row3.createCell(5).setCellValue(jsonObject1.optString("t_avg_patient") !=null && !jsonObject1.optString("t_avg_patient").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("t_avg_patient")) : 0);
            row3.createCell(6).setCellValue(jsonObject1.optString("t_lab_test") !=null && !jsonObject1.optString("t_lab_test").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("t_lab_test")) : 0);
            row3.createCell(7).setCellValue(jsonObject1.optString("t_medicine_given") !=null && !jsonObject1.optString("t_medicine_given").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("t_medicine_given")) : 0);
            row3.createCell(8).setCellValue(jsonObject1.optString("t_labour_reg") !=null && !jsonObject1.optString("t_labour_reg").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("t_labour_reg")) : 0);
            row3.createCell(9).setCellValue(jsonObject1.optString("t_sub_labour_reg") !=null && !jsonObject1.optString("t_sub_labour_reg").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("t_sub_labour_reg")) : 0);
            row3.createCell(10).setCellValue(jsonObject1.optString("p_no_of_camp") !=null && !jsonObject1.optString("p_no_of_camp").isEmpty() 
            		? Double.parseDouble(jsonObject1.optString("p_no_of_camp")) : 0);
            row3.createCell(11).setCellValue(jsonObject1.optString("p_no_of_patient") !=null && !jsonObject1.optString("p_no_of_patient").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("p_no_of_patient")) : 0);            
            row3.createCell(12).setCellValue(Math.round(Double.parseDouble(jsonObject1.optString("p_no_of_patient"))/Double.parseDouble(jsonObject1.optString("p_no_of_camp"))));
            row3.createCell(13).setCellValue(jsonObject1.optString("p_lab_test") !=null  && !jsonObject1.optString("p_lab_test").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("p_lab_test")) : 0);
            row3.createCell(14).setCellValue(jsonObject1.optString("p_medicine_given") !=null && !jsonObject1.optString("p_medicine_given").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("p_medicine_given")) : 0);
            row3.createCell(15).setCellValue(jsonObject1.optString("p_labour_reg") !=null && !jsonObject1.optString("p_labour_reg").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("p_labour_reg")) : 0);
            row3.createCell(16).setCellValue(jsonObject1.optString("p_sub_labour_reg") !=null && !jsonObject1.optString("p_sub_labour_reg").isEmpty()
            		? Double.parseDouble(jsonObject1.optString("p_sub_labour_reg")) : 0);
            Cell cell = row3.createCell(17);
            rowTotal = sheet.getLastRowNum();
        }
        Row row4 = sheet.createRow(rowTotal+2);
        
        row4.createCell(0).setCellValue("");
        row4.createCell(1).setCellValue("");
        row4.createCell(2).setCellValue("Total");
        row4.createCell(3).setCellValue(tot_t_no_of_camp);
        row4.createCell(4).setCellValue(tot_t_no_of_patient);
        row4.createCell(5).setCellValue(Math.round(tot_t_avg_patient/tot_t_no_of_camp));
        row4.createCell(6).setCellValue(tot_t_lab_test);
        row4.createCell(7).setCellValue(tot_t_medicine_given);
        row4.createCell(8).setCellValue(tot_t_labour_reg);
        row4.createCell(9).setCellValue(tot_t_sub_labour_reg);
        row4.createCell(10).setCellValue(tot_p_no_of_camp);
        row4.createCell(11).setCellValue(tot_p_no_of_patient);
        row4.createCell(12).setCellValue(Math.round(tot_p_avg_patient/totalNoOfCity));
        row4.createCell(13).setCellValue(tot_p_lab_test);
        row4.createCell(14).setCellValue(tot_p_medicine_given);
        row4.createCell(15).setCellValue(tot_p_labour_reg);
        row4.createCell(16).setCellValue(tot_p_sub_labour_reg);
        Cell cell = row4.createCell(17);
        
        
      }
    catch (JSONException e)
     {
        e.printStackTrace();
    }
    
    }
}