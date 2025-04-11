package com.mmu.web.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmu.web.dao.ReportDao;
import com.mmu.web.hibernateutils.GetHibernateUtils;
import com.mmu.web.hibernateutils.GetHibernateUtilsMis;

@Repository
public class ReportDaoImpl implements ReportDao {
	
	@Autowired
	GetHibernateUtils getHibernateUtils;
	
	@Autowired
	GetHibernateUtilsMis getHibernateUtilsMis;

	@Override
	public Map<String, Object> getConnectionForReport() {
		System.out.println("inside connection report method");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Connection conn = getHibernateUtils.getHibernateUtlis().getConnection();
			map.put("conn", conn);
		}catch(Exception e) {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
			e.printStackTrace();
		}
		return map;
	}

	@Override
	public Map<String, Object> getConnectionForReportMis() {
		System.out.println("inside Mis connection report method");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Connection conn = getHibernateUtilsMis.getHibernateUtlisMiss().getConnection();
			map.put("conn", conn);
		}catch(Exception e) {
			getHibernateUtilsMis.getHibernateUtlisMiss().CloseConnection();
			e.printStackTrace();
		}
		return map;
	}	

	

}
