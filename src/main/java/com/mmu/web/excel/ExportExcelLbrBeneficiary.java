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
import org.apache.poi.ss.util.CellRangeAddress;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.servlet.view.document.AbstractXlsxView;


public class ExportExcelLbrBeneficiary extends AbstractXlsxView {
  
  private static final String[] header1= {"District","City","No. of labour beneficiary","","","", "Total No.  Of labour beneficiary",
		                                   "No. Of patient registered in labour department","","No. Of patient who has applied for registration","","Number of unregistered workers treated"
		                                   		+ " in the past who has applied for labour registration","","No. of non- labour who has been treated",
		                                   		"No. of beneficiary till date","", "","","No. Of patient registered in labour department till date\r\n"
		                                   				+ "(A)","","No.  Of patient who has applied for registration till date\r\n"
		                                   						+ "(B)","","Number of unregistered workers treated in the past who has applied for labour registration till date\r\n"
		                                   								+ " ( C )","","No. of non- labour who has been treated till date\r\n"
		                                   										+ " (D)","Total No.of beneficiary till date \r\n"
		                                   												+ "(A+B+C+D)"
		                                  };
  private static final String[] header2= {"","","Male","Female","Child","Transgender","",
		                                "BOC","Other","BOC","Other","BOC","Other","General Citizen","Male",
		                                "Female","Child","Transgender","BOC","Other","BOC","Other","BOC","Other","",""
		                                		
		                              };
  @Override
  protected void buildExcelDocument(Map<String, Object> model, Workbook workbook,
         HttpServletRequest request, HttpServletResponse response) throws Exception {
    	  
	String jsondata=model.get("data").toString();
	String campDateVal="";
	JSONObject json=new JSONObject(jsondata);
	JSONObject js=(JSONObject) json.get("labourBeneficiary_data");
	campDateVal= js.get("campDate").toString();
	campDateVal=campDateVal.replace("/", "-");
	String js1=js.get("labourBeneficiary_data").toString();
	
    int rowNum = 2;
    
    // Creating sheet with in the workbook
    Sheet sheet = workbook.createSheet("Labour Beneficiary"+"_"+campDateVal);
    /** for header **/
    String fileName = "LabourBeneficiary_"+campDateVal+".xlsx";    
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
    
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$A$1:$A$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$B$1:$B$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$C$1:$F$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$G$1:$G$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$H$1:$I$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$J$1:$K$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$L$1:$M$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$O$1:$R$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$S$1:$T$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$U$1:$V$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$W$1:$X$1"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$Y$1:$Y$2"));
    sheet.addMergedRegion(org.apache.poi.ss.util.CellRangeAddress.valueOf("$Z$1:$Z$2"));   
    
    
    try
    {
		JSONArray jsonArray=new JSONArray(js1);	
		
		int tot_t_labour_male=0;
		int tot_t_labour_female=0;
		int tot_t_labour_child=0;
		int tot_t_labour_other=0;
		int tot_t_labour_total=0;
		int tot_t_labour_reg_boc=0;
		int tot_t_labour_reg_other=0;
		int tot_t_labour_app_boc=0;
		int tot_t_labour_app_other=0;
		int tot_t_labour_unreg_boc=0;
		int tot_t_labour_unreg_other=0;
		int tot_t_nonlabour_srcitizen=0;
		int tot_p_labour_male=0;
		int tot_p_labour_female=0;
		int tot_p_labour_child=0;
		int tot_p_labour_other=0;
		int tot_p_labour_total=0;
		int tot_p_labour_reg_boc=0;
		int tot_p_labour_reg_other=0;
		int tot_p_labour_app_boc=0;
		int tot_p_labour_app_other=0;
		int tot_p_labour_unreg_boc=0;
		int tot_p_labour_unreg_other=0;
		int tot_p_nonlabour_srcitizen=0;
		int p_total=0;
		
		int rowTotal = 0;
         int totalNoABCD=0;
         int mainTotalCount=0;
		if(jsonArray.length()==0) {
			rowTotal=2;
		}
        for(int i=0;i<jsonArray.length();i++)
        {
        	totalNoABCD=0;
        	row3 = sheet.createRow(rowNum++);
            JSONObject jsonObject1 = jsonArray.getJSONObject(i);
            
            if(jsonObject1.optString("t_labour_male") !=null && !jsonObject1.optString("t_labour_male").isEmpty()) {
            	tot_t_labour_male=tot_t_labour_male+ Integer.parseInt(jsonObject1.optString("t_labour_male").toString());
            }   
            
            if(jsonObject1.optString("t_labour_female") !=null && !jsonObject1.optString("t_labour_female").isEmpty()) {
            	tot_t_labour_female=tot_t_labour_female+ Integer.parseInt(jsonObject1.optString("t_labour_female").toString());
            }
            
            if(jsonObject1.optString("t_labour_child") !=null && !jsonObject1.optString("t_labour_child").isEmpty()) {
            	tot_t_labour_child=tot_t_labour_child+ Integer.parseInt(jsonObject1.optString("t_labour_child").toString());
            }
            
            if(jsonObject1.optString("t_labour_other") !=null && !jsonObject1.optString("t_labour_other").isEmpty()) {
            	tot_t_labour_other=tot_t_labour_other+ Integer.parseInt(jsonObject1.optString("t_labour_other").toString());
            }
            
            if(jsonObject1.optString("t_labour_total") !=null && !jsonObject1.optString("t_labour_total").isEmpty()) {
            	tot_t_labour_total=tot_t_labour_total+ Integer.parseInt(jsonObject1.optString("t_labour_total").toString());
            }
            
            if(jsonObject1.optString("t_labour_reg_boc") !=null && !jsonObject1.optString("t_labour_reg_boc").isEmpty()) {
            	tot_t_labour_reg_boc=tot_t_labour_reg_boc+ Integer.parseInt(jsonObject1.optString("t_labour_reg_boc").toString());
            	 
            }
            
            if(jsonObject1.optString("t_labour_reg_other") !=null && !jsonObject1.optString("t_labour_reg_other").isEmpty()) {
            	tot_t_labour_reg_other=tot_t_labour_reg_other+ Integer.parseInt(jsonObject1.optString("t_labour_reg_other").toString());
             
            }
            
            if(jsonObject1.optString("t_labour_app_boc") !=null && !jsonObject1.optString("t_labour_app_boc").isEmpty()) {
            	tot_t_labour_app_boc=tot_t_labour_app_boc+ Integer.parseInt(jsonObject1.optString("t_labour_app_boc").toString());
            	 
            }
            
            if(jsonObject1.optString("t_labour_app_other") !=null && !jsonObject1.optString("t_labour_app_other").isEmpty()) {
            	tot_t_labour_app_other=tot_t_labour_app_other+ Integer.parseInt(jsonObject1.optString("t_labour_app_other").toString());
             
            }
            
            if(jsonObject1.optString("t_labour_unreg_boc") !=null && !jsonObject1.optString("t_labour_unreg_boc").isEmpty()) {
            	tot_t_labour_unreg_boc=tot_t_labour_unreg_boc+ Integer.parseInt(jsonObject1.optString("t_labour_unreg_boc").toString());
            	 
            }
            
            if(jsonObject1.optString("t_labour_unreg_other") !=null && !jsonObject1.optString("t_labour_unreg_other").isEmpty()) {
            	tot_t_labour_unreg_other=tot_t_labour_unreg_other+ Integer.parseInt(jsonObject1.optString("t_labour_unreg_other").toString());
            
            }
            
            if(jsonObject1.optString("t_nonlabour_srcitizen") !=null && !jsonObject1.optString("t_nonlabour_srcitizen").isEmpty()) {
            	tot_t_nonlabour_srcitizen=tot_t_nonlabour_srcitizen+ Integer.parseInt(jsonObject1.optString("t_nonlabour_srcitizen").toString());
            }
            
            if(jsonObject1.optString("p_labour_male") !=null && !jsonObject1.optString("p_labour_male").isEmpty()) {
            	tot_p_labour_male=tot_p_labour_male+ Integer.parseInt(jsonObject1.optString("p_labour_male").toString());
            }
            
            if(jsonObject1.optString("p_labour_female") !=null && !jsonObject1.optString("p_labour_female").isEmpty()) {
            	tot_p_labour_female=tot_p_labour_female+ Integer.parseInt(jsonObject1.optString("p_labour_female").toString());
            }
            
            if(jsonObject1.optString("p_labour_child") !=null && !jsonObject1.optString("p_labour_child").isEmpty()) {
            	tot_p_labour_child=tot_p_labour_child+ Integer.parseInt(jsonObject1.optString("p_labour_child").toString());
            }
            
            if(jsonObject1.optString("p_labour_other") !=null && !jsonObject1.optString("p_labour_other").isEmpty()) {
            	tot_p_labour_other=tot_p_labour_other+ Integer.parseInt(jsonObject1.optString("p_labour_other").toString());
            }
            
            if(jsonObject1.optString("p_labour_total") !=null && !jsonObject1.optString("p_labour_total").isEmpty()) {
            	tot_p_labour_total=tot_p_labour_total+ Integer.parseInt(jsonObject1.optString("p_labour_total").toString());
            }
            
            if(jsonObject1.optString("p_labour_reg_boc") !=null && !jsonObject1.optString("p_labour_reg_boc").isEmpty()) {
            	tot_p_labour_reg_boc=tot_p_labour_reg_boc+ Integer.parseInt(jsonObject1.optString("p_labour_reg_boc").toString());
            	totalNoABCD=totalNoABCD+Integer.parseInt(jsonObject1.optString("p_labour_reg_boc").toString());
            }
            
            if(jsonObject1.optString("p_labour_reg_other") !=null && !jsonObject1.optString("p_labour_reg_other").isEmpty()) {
            	tot_p_labour_reg_other=tot_p_labour_reg_other+ Integer.parseInt(jsonObject1.optString("p_labour_reg_other").toString());
            	totalNoABCD=totalNoABCD+Integer.parseInt(jsonObject1.optString("p_labour_reg_other").toString());
            }
            
            if(jsonObject1.optString("p_labour_app_boc") !=null && !jsonObject1.optString("p_labour_app_boc").isEmpty()) {
            	tot_p_labour_app_boc=tot_p_labour_app_boc+ Integer.parseInt(jsonObject1.optString("p_labour_app_boc").toString());
            	totalNoABCD=totalNoABCD+Integer.parseInt(jsonObject1.optString("p_labour_app_boc").toString());
            }
            
            if(jsonObject1.optString("p_labour_app_other") !=null && !jsonObject1.optString("p_labour_app_other").isEmpty()) {
            	tot_p_labour_app_other=tot_p_labour_app_other+ Integer.parseInt(jsonObject1.optString("p_labour_app_other").toString());
            	totalNoABCD=totalNoABCD+Integer.parseInt(jsonObject1.optString("p_labour_app_other").toString());
            }
            
            if(jsonObject1.optString("p_labour_unreg_boc") !=null && !jsonObject1.optString("p_labour_unreg_boc").isEmpty()) {
            	tot_p_labour_unreg_boc=tot_p_labour_unreg_boc+ Integer.parseInt(jsonObject1.optString("p_labour_unreg_boc").toString());
            	totalNoABCD=totalNoABCD+Integer.parseInt(jsonObject1.optString("p_labour_unreg_boc").toString());
            }
            
            if(jsonObject1.optString("p_labour_unreg_other") !=null && !jsonObject1.optString("p_labour_unreg_other").isEmpty()) {
            	tot_p_labour_unreg_other=tot_p_labour_unreg_other+ Integer.parseInt(jsonObject1.optString("p_labour_unreg_other").toString());
            	totalNoABCD=totalNoABCD+Integer.parseInt(jsonObject1.optString("p_labour_unreg_other").toString());
            }
            
            if(jsonObject1.optString("p_nonlabour_srcitizen") !=null && !jsonObject1.optString("p_nonlabour_srcitizen").isEmpty()) {
            	tot_p_nonlabour_srcitizen=tot_p_nonlabour_srcitizen+ Integer.parseInt(jsonObject1.optString("p_nonlabour_srcitizen").toString());
            	totalNoABCD=totalNoABCD+Integer.parseInt(jsonObject1.optString("p_nonlabour_srcitizen").toString());
            }
            if(jsonObject1.optString("p_total") !=null && !jsonObject1.optString("p_total").isEmpty()) {
            	p_total=p_total+ Integer.parseInt(jsonObject1.optString("p_total").toString());
            }
             
            row3.createCell(0).setCellValue(jsonObject1.optString("districtname"));            
            row3.createCell(1).setCellValue(jsonObject1.optString("cityname"));
            
            row3.createCell(2).setCellValue(jsonObject1.optString("t_labour_male") !=null && !jsonObject1.optString("t_labour_male").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_male")) : 0);
            
            row3.createCell(3).setCellValue(jsonObject1.optString("t_labour_female") !=null && !jsonObject1.optString("t_labour_female").isEmpty() 
            		?  Integer.parseInt(jsonObject1.optString("t_labour_female")) : 0);
            
            row3.createCell(4).setCellValue(jsonObject1.optString("t_labour_child") !=null  && !jsonObject1.optString("t_labour_child").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_child")) : 0);
            
            row3.createCell(5).setCellValue(jsonObject1.optString("t_labour_other") !=null && !jsonObject1.optString("t_labour_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_other")) : 0);
            
            row3.createCell(6).setCellValue(jsonObject1.optString("t_labour_total") !=null  && !jsonObject1.optString("t_labour_total").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_total")) : 0);
            
            row3.createCell(7).setCellValue(jsonObject1.optString("t_labour_reg_boc") !=null  && !jsonObject1.optString("t_labour_reg_boc").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_reg_boc")) : 0);
            
            row3.createCell(8).setCellValue(jsonObject1.optString("t_labour_reg_other") !=null  && !jsonObject1.optString("t_labour_reg_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_reg_other")) : 0);
            
            row3.createCell(9).setCellValue(jsonObject1.optString("t_labour_app_boc") !=null && !jsonObject1.optString("t_labour_app_boc").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_app_boc")) : 0);
           
            row3.createCell(10).setCellValue(jsonObject1.optString("t_labour_app_other") !=null && !jsonObject1.optString("t_labour_app_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_app_other")) : 0);
            
            row3.createCell(11).setCellValue(jsonObject1.optString("t_labour_unreg_boc") !=null && !jsonObject1.optString("t_labour_unreg_boc").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_unreg_boc")) : 0);
            
            row3.createCell(12).setCellValue(jsonObject1.optString("t_labour_unreg_other") !=null && jsonObject1.optString("t_labour_unreg_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_labour_unreg_other")) : 0);
            
            row3.createCell(13).setCellValue(jsonObject1.optString("t_nonlabour_srcitizen") !=null && !jsonObject1.optString("t_nonlabour_srcitizen").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("t_nonlabour_srcitizen")) : 0);
            
            row3.createCell(14).setCellValue(jsonObject1.optString("p_labour_male") !=null && !jsonObject1.optString("p_labour_male").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_male")) : 0);
            
            row3.createCell(15).setCellValue(jsonObject1.optString("p_labour_female") !=null  && !jsonObject1.optString("p_labour_female").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_female")) : 0);
            
            row3.createCell(16).setCellValue(jsonObject1.optString("p_labour_child") !=null && !jsonObject1.optString("p_labour_child").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_child")) : 0);
            
            row3.createCell(17).setCellValue(jsonObject1.optString("p_labour_other") !=null && !jsonObject1.optString("p_labour_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_other")) : 0);
            
            /*row3.createCell(18).setCellValue(jsonObject1.optString("p_labour_total") !=null && !jsonObject1.optString("p_labour_total").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_total")) : 0);*/
            
            row3.createCell(18).setCellValue(jsonObject1.optString("p_labour_reg_boc") !=null && !jsonObject1.optString("p_labour_reg_boc").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_reg_boc")) : 0);
            
            row3.createCell(19).setCellValue(jsonObject1.optString("p_labour_reg_other") !=null && !jsonObject1.optString("p_labour_reg_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_reg_other")) : 0);
            
            row3.createCell(20).setCellValue(jsonObject1.optString("p_labour_app_boc") !=null && !jsonObject1.optString("p_labour_app_boc").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_app_boc")) : 0);
            
            row3.createCell(21).setCellValue(jsonObject1.optString("p_labour_app_other") !=null && !jsonObject1.optString("p_labour_app_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_app_other")) : 0);
            
            row3.createCell(22).setCellValue(jsonObject1.optString("p_labour_unreg_boc") !=null && !jsonObject1.optString("p_labour_unreg_boc").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_unreg_boc")) : 0);
            
            row3.createCell(23).setCellValue(jsonObject1.optString("p_labour_unreg_other") !=null && !jsonObject1.optString("p_labour_unreg_other").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_labour_unreg_other")) : 0);
            
            row3.createCell(24).setCellValue(jsonObject1.optString("p_nonlabour_srcitizen") !=null && !jsonObject1.optString("p_nonlabour_srcitizen").isEmpty()
            		?  Integer.parseInt(jsonObject1.optString("p_nonlabour_srcitizen")) : 0); 
            //row3.createCell(25).setCellValue(jsonObject1.optString("p_total") !=null && !jsonObject1.optString("p_total").isEmpty()
            	//	?  totalNoABCD : 0); 
            mainTotalCount=mainTotalCount+totalNoABCD;
            row3.createCell(25).setCellValue(totalNoABCD);
            Cell cell = row3.createCell(26);
            rowTotal = sheet.getLastRowNum();
        }
        Row row4 = sheet.createRow(rowTotal+1);
        row4.createCell(0).setCellValue("");
        row4.createCell(1).setCellValue("Total");
        row4.createCell(2).setCellValue(tot_t_labour_male);
        row4.createCell(3).setCellValue(tot_t_labour_female);
        row4.createCell(4).setCellValue(tot_t_labour_child);
        row4.createCell(5).setCellValue(tot_t_labour_other);
        row4.createCell(6).setCellValue(tot_t_labour_total);
        row4.createCell(7).setCellValue(tot_t_labour_reg_boc);
        row4.createCell(8).setCellValue(tot_t_labour_reg_other);
        row4.createCell(9).setCellValue(tot_t_labour_app_boc);
        row4.createCell(10).setCellValue(tot_t_labour_app_other);
        row4.createCell(11).setCellValue(tot_t_labour_unreg_boc);
        row4.createCell(12).setCellValue(tot_t_labour_unreg_other);
        row4.createCell(13).setCellValue(tot_t_nonlabour_srcitizen);
        row4.createCell(14).setCellValue(tot_p_labour_male);
        row4.createCell(15).setCellValue(tot_p_labour_female);
        row4.createCell(16).setCellValue(tot_p_labour_child);
        row4.createCell(17).setCellValue(tot_p_labour_other);
        //row4.createCell(18).setCellValue(tot_p_labour_total);
        row4.createCell(18).setCellValue(tot_p_labour_reg_boc);
        row4.createCell(19).setCellValue(tot_p_labour_reg_other);
        row4.createCell(20).setCellValue(tot_p_labour_app_boc);
        row4.createCell(21).setCellValue(tot_p_labour_app_other);
        row4.createCell(22).setCellValue(tot_p_labour_unreg_boc);
        row4.createCell(23).setCellValue(tot_p_labour_unreg_other);
        row4.createCell(24).setCellValue(tot_p_nonlabour_srcitizen);
        row4.createCell(25).setCellValue(mainTotalCount);
       
        Cell cell = row4.createCell(26);        
       
      }
    catch (JSONException e)
     {
        e.printStackTrace();
    }
    
    }
}