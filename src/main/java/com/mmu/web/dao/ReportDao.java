package com.mmu.web.dao;

import java.util.Map;

import org.apache.xmlbeans.impl.jam.JParameter;
import org.springframework.stereotype.Repository;


@Repository
public interface ReportDao {

	Map<String, Object> getConnectionForReport();
	
	Map<String, Object> getConnectionForReportMis();

}
