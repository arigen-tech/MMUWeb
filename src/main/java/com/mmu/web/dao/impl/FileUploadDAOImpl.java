package com.mmu.web.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.jdbc.Work;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mmu.web.dao.FileUploadDAO;
import com.mmu.web.entity.MasHospital;
import com.mmu.web.entity.SyncDataShip;
import com.mmu.web.entity.UploadDocument;
import com.mmu.web.hibernateutils.GetHibernateUtils;
import com.mmu.web.utils.HMSUtil;

import oracle.jdbc.OracleTypes;

@Repository
public class FileUploadDAOImpl implements FileUploadDAO {
	
	String databaseScema = HMSUtil.getProperties("js_messages_en.properties", "currentSchema").trim();
	String databaseScema1 = HMSUtil.getProperties("adt.properties", "currentSchema").trim();
	final String DG_ORDER_HD=databaseScema1+"."+"DG_ORDER_HD";

	@Autowired
	GetHibernateUtils getHibernateUtils;

	@Autowired(required=true)
	@Qualifier("sessionFactory")
	SessionFactory sessionFactory;
	
	private Logger logger = Logger.getLogger(FileUploadDAOImpl.class);

	public FileUploadDAOImpl() {
	}

	public FileUploadDAOImpl(@Qualifier("sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	@Transactional
	public boolean save(UploadDocument uploadFile) {
		boolean flag = false;
		try {
			Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
			Transaction tx = session.beginTransaction();
			session.save(uploadFile);
			tx.commit();
			flag = true;

		} catch (Exception e) {

			getHibernateUtils.getHibernateUtlis().CloseConnection();
			e.printStackTrace();
		}

		return flag;
	}

	@SuppressWarnings("unchecked")
	@Transactional
	@Override
	public Map<String, Object> showUploadedDocumentsForPatient(long patientId) {
		List<UploadDocument> documentList = new ArrayList<UploadDocument>();
		Map<String, Object> map = new HashMap<String, Object>();

		Session session = getHibernateUtils.getHibernateUtlis().OpenSession();

		documentList = session.createCriteria(UploadDocument.class).add(Restrictions.eq("patient.patientId", patientId))
				.list();

		map.put("documentList", documentList);

		return map;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UploadDocument> viewUploadDocuments(long documentId) {
		List<UploadDocument> uploadDocuments = new ArrayList<UploadDocument>();

		Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
		uploadDocuments = session.createCriteria(UploadDocument.class).add(Restrictions.eq("fileId", documentId))
				.list();
		return uploadDocuments;
	}

	@Override
	public boolean deleteUploadDocument(long fileId) {
		UploadDocument document = new UploadDocument();
		boolean resultStatus = false;
		Transaction tx = null;
		try {
			Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
			document = (UploadDocument) session.get(UploadDocument.class, fileId);
			tx = session.beginTransaction();
			session.delete(document);
			tx.commit();
			resultStatus = true;
		} catch (Exception e) {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
			e.getMessage();
			e.printStackTrace();
		} finally {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
		}
		return resultStatus;
	}

	
	@Override
	public String generateShipCSV(String fileName) {
		//alterOracleSession();
		JSONObject jsonObj = new JSONObject();
		System.out.println("genrateCSV called");
		try {
/*			JSONObject json = new JSONObject(payload);
			String []id = json.getString("id").split("@");
			int unitId = Integer.parseInt(id[1]);
			int hospitalId = Integer.parseInt(id[0]);*/
			
			Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
			session.doWork(new Work() {

				@Override
				public void execute(Connection connection) throws SQLException {
					//CallableStatement call = connection.prepareCall("CALL ASP_CSV_GENERATE_SHIP(?,?,?,?,?)");
					CallableStatement call = connection.prepareCall("{? = CALL ASP_CSV_GENERATE_SHIP(?) }");
					call.registerOutParameter(1, Types.INTEGER);
					call.setString(2, fileName);
					/*call.setInt(3, unitId);
					call.registerOutParameter(4, Types.INTEGER);
					call.registerOutParameter(5, java.sql.Types.VARCHAR);*/
					call.execute();
					int status = call.getInt(1);
					jsonObj.put("status", status);
					//String result = call.getString(5);
					System.out.println("status "+status);
					/*if (status == 0) {
						jsonObj.put("status", "0");
					} else if (status == 1) {
						jsonObj.put("status", "1");
					}else if(status == -1) {
						jsonObj.put("status", "-1");
					}*/
				}

			});
			
		} catch (Exception e) {
			jsonObj.put("status", "2");
			jsonObj.put("msg", "error");
			e.printStackTrace();
			logger.error("", e);
		} finally {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
		}
		return jsonObj.toString();
	}

	@Override
	public Map<String, Object> getExportToShipSyncTableList(JSONObject jsObject) {
		List<SyncDataShip> exportTablist = new ArrayList<SyncDataShip>();
		Map<String,Object> map = new HashMap<>();
		try {
			Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
			Criteria criteria = session.createCriteria(SyncDataShip.class);
			String flag = jsObject.getString("flag");
			
			int count = 0;
			int pageNo = Integer.parseInt(String.valueOf(jsObject.get("pageNo")));
			int pagingSize = 5;
			
			System.out.println("flag is ********************************* "+flag);
			//for asha web app
			if(flag.equalsIgnoreCase("I")) {
				criteria = criteria.add(Restrictions.eq("applyFor", "A"));
				criteria = criteria.add(Restrictions.gt("impCount", new Long(0)));
			}
			if(flag.equalsIgnoreCase("E")) {
				criteria = criteria.add(Restrictions.eq("applyFor", "M"));
			}
			criteria = criteria.addOrder(Order.desc("expDate"));
			//for mobile app
			/*if(flag.equalsIgnoreCase("I")) {
				criteria = criteria.add(Restrictions.eq("applyFor", "A"));
			}
			if(flag.equalsIgnoreCase("E")) {
				criteria = criteria.add(Restrictions.eq("applyFor", "M"));
			}*/
			exportTablist = criteria.list();
			count = exportTablist.size();
			
			criteria = criteria.setFirstResult(pagingSize * (pageNo - 1));
			criteria = criteria.setMaxResults(pagingSize);
			exportTablist = criteria.list();
			map.put("count", count);
			map.put("exportTablist", exportTablist);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		} finally {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
		}
		System.out.println(exportTablist);
		return map;
	}

	@Override
	public String moveZipFileShip(String zipFileName, String userId, String flagForInsertOrUpdate,
			String flagForImportOrExport) {
		Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
		JSONObject obj = new JSONObject();
		System.out.println("zipFileName "+zipFileName+" :userId "+userId+" :flagForInsertOrUpdate "+flagForInsertOrUpdate+" :flagForImportOrExport "+flagForImportOrExport);
		try {
			int userId1 = Integer.parseInt(userId);
			// TODO Auto-generated method stub
			session.doWork(new Work() {

				@Override
				public void execute(java.sql.Connection connection) throws SQLException {
					CallableStatement call = connection.prepareCall("CALL ASP_MOVE_FILE(?,?,?,?,?,?)");
					call.setString(1, zipFileName);
					call.setInt(2, userId1);
					call.setString(3, flagForInsertOrUpdate);
					call.setString(4, flagForImportOrExport);
					call.registerOutParameter(5, java.sql.Types.INTEGER);
					call.registerOutParameter(6, java.sql.Types.VARCHAR);
					call.execute();
					int status = call.getInt(5);
					String result = String.valueOf(call.getObject(6));
					System.out.println("status *****************************"+status);
					if(status == 1) {
						obj.put("status", "1");
						obj.put("message", result);
					}
					if(status == 0) {
						obj.put("status", "0");
						obj.put("message", result);
					}
					if(status == -1) {
						obj.put("status", "-1");
						obj.put("message", result);
					}
					
				}
			});
		}catch(Exception ex) {
			ex.printStackTrace();
			obj.put("status", "2");
			obj.put("message", "Error occured in moving zip file");
			logger.error("", ex);
		}
		System.out.println("moveZipFile procedure response "+obj.toString());
		return obj.toString();
	}

	@Override
	public String getDirectoryShip(String directoryFlag) {
		Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
		JSONObject obj = new JSONObject();
		
		try {

			session.doWork(new Work() {

				@Override
				public void execute(java.sql.Connection connection) throws SQLException {
					connection.setAutoCommit(false);
					String runSP = "{  ? = call "+databaseScema+".ASP_GET_DIRECTORIES_SHIP( ? ) }";
					CallableStatement call = connection.prepareCall(runSP);
					//Z for zip and M for move directory                  
					call.registerOutParameter(1, Types.REF_CURSOR);//this is using with
					call.setString(2, directoryFlag.trim());
					
					call.execute();
					ResultSet rs = (ResultSet) call.getObject(1);
					while (rs.next()) {
						int x = rs.getInt(2);
						if (x == 1) {
							System.out.println("exportPath " + rs.getString(1));
							obj.put("exportPath", rs.getString(1));
						}
						if (x == 2) {
							System.out.println("importPath " + rs.getString(1));
							obj.put("importPath", rs.getString(1));
						}

					}

				}
			});
			return obj.toString();
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("", ex);
		} finally {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
		}
		return obj.toString();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getHospitalList(Map<String, Object> inputJson) {
		Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
		Map<String,Object> map = new HashMap<>();
		try {

			List<MasHospital> list = session.createCriteria(MasHospital.class).list();
			
			map.put("list", list);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
		}
		return map;
	}

	@Override
	public void updateDownloadStatusInSyncData(String fileName, String flag) {
		//status D for download, U for upload, and I for import status
				Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
				Transaction tx = session.beginTransaction();
				System.out.println("flag inside updateStatusInSyncData is "+flag+" and file name is "+fileName);
				try {
					SyncDataShip syncData = null;
					//for mobile application
					/*if(flag.equalsIgnoreCase("D")) {
						syncData = (SyncDataShip) session.createCriteria(SyncDataShip.class).add(Restrictions.eq("expSyncDir", fileName.trim()))
								.add(Restrictions.eq("applyFor", "M")).uniqueResult();
					}else if(flag.equalsIgnoreCase("I")) {
						syncData = (SyncDataShip) session.createCriteria(SyncDataShip.class).add(Restrictions.eq("impSyncDir", fileName.trim()))
								.add(Restrictions.eq("applyFor", "A")).uniqueResult();
					}*/
					
					//for asha application
					if(flag.equalsIgnoreCase("D")) {
						syncData = (SyncDataShip) session.createCriteria(SyncDataShip.class).add(Restrictions.eq("expSyncDir", fileName.trim()))
								.add(Restrictions.eq("applyFor", "A")).uniqueResult();
					}else if(flag.equalsIgnoreCase("I")) {
						syncData = (SyncDataShip) session.createCriteria(SyncDataShip.class).add(Restrictions.eq("impSyncDir", fileName.trim()))
								.add(Restrictions.eq("applyFor", "M")).uniqueResult();
					}
					
					if(syncData != null) {
						if(flag.equalsIgnoreCase("D")) {
							if(syncData.getExpCount() == null) {
								syncData.setExpCount(new Long(1));
								syncData.setExpStatus("Y");
							}else {
								long count = syncData.getExpCount();
								syncData.setExpCount(new Long(count+1));
							}
						}
						/*if(flag.equalsIgnoreCase("U")) {
							if(syncData.getImpCount() == null) {
								System.out.println("flag for upload file is U inside if");
								syncData.setImpCount(new Long(1));
							}else {
								long count = syncData.getImpCount();
								System.out.println("flag for upload file is U inside else "+count);
								syncData.setImpCount(new Long(count+1));
							}
						}*/
						if(flag.equalsIgnoreCase("I")) {
							syncData.setImpStatus("Y");
							Timestamp  ts = new Timestamp(System.currentTimeMillis());
							syncData.setImpDate(ts);
						}
						session.update(syncData);
						tx.commit();
					}else {
						System.out.println("status not updated due to object is null");
					}
				}catch(Exception ex) {
					ex.printStackTrace();
					logger.error("", ex);
				}finally {
					getHibernateUtils.getHibernateUtlis().CloseConnection();
				}
	}

	@Override
	public String getUnitCode() {
		Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
		Map<String,Object> map = new HashMap<>();
		String unitCode = null;
		try {
			
			Object query = session.createSQLQuery("select unit.unit_code from ship.ship_data data, ship.vu_mas_unit unit where data.unit_id = unit.unit_id;").uniqueResult();
			System.out.println("query result ****************** "+query.toString());
			if(query != null) {
				unitCode = query.toString();
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
		}
		return unitCode;
	}

	@Override
	public String importCSVShip(String fileName) {
		
			JSONObject jsonObj = new JSONObject();
			try {
				Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
				
				/*ProcedureCall query = session.createStoredProcedureCall("ASP_MERGER_TABLE");
				query.registerParameter("out", Integer.class, ParameterMode.OUT);
				ProcedureOutputs procedureResult = query.getOutputs();
				Integer result = (Integer) procedureResult.getOutputParameterValue("out");*/
				session.doWork(new Work() {

					@Override
					public void execute(Connection connection) throws SQLException {
						String runSP = "{  ? = call "+databaseScema+".asp_merger_table_ship(?) }";
						CallableStatement call = connection.prepareCall(runSP);
						/*call.registerOutParameter(1, Types.REF_CURSOR);*/
						call.registerOutParameter(1, Types.INTEGER);
						call.setString(2, fileName);
						call.execute();
						
						String status = String.valueOf(call.getObject(1));
						if(status.equals("1")) {
							jsonObj.put("status", "1");
						}else {
							jsonObj.put("status", "0");
						}
						/*if (status == 0) {
							jsonObj.put("status", "0");
							jsonObj.put("msg", msg);
						} else if (status == 1) {
							jsonObj.put("status", "1");
							jsonObj.put("msg", "File has been successfully imported");
							updateDownloadStatusInSyncData(fileName, "I");
						} else if (status == -1) {
							jsonObj.put("status", "-1");
							jsonObj.put("msg", msg);
						}*/

					}

				});
				
			} catch (Exception e) {
				jsonObj.put("status", "2");
				jsonObj.put("msg", "Exception occured while calling importing CSV Function");
				e.printStackTrace();
				logger.error("", e);
			} finally {
				getHibernateUtils.getHibernateUtlis().CloseConnection();
			}

			return jsonObj.toString();
	}

	@SuppressWarnings("unused")
	@Override
	public String changeSequenceOfImportedData() {
		JSONObject js = new JSONObject();
		try {
			Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
			
			/*ProcedureCall query = session.createStoredProcedureCall("ASP_MERGER_TABLE");
			query.registerParameter("out", Integer.class, ParameterMode.OUT);
			ProcedureOutputs procedureResult = query.getOutputs();
			Integer result = (Integer) procedureResult.getOutputParameterValue("out");*/
			session.doWork(new Work() {

				@Override
				public void execute(Connection connection) throws SQLException {
					connection.setAutoCommit(false);
					String runSP = "{  ? = call "+databaseScema+".asp_alter_seq() }";
					CallableStatement call = connection.prepareCall(runSP);
					call.registerOutParameter(1, Types.REF_CURSOR);
					call.execute();
					//Object obj = call.getObject(1);
					ResultSet rs = (ResultSet) call.getObject(1);
					while (rs.next()) {
						Integer x = rs.getInt(1);
						if(x == null) {
							js.put("status", "0");
						}else {
							js.put("status", "1");
						}
						break;
				}
			}

			});
			
		} catch (Exception e) {
			js.put("status", "-1");
			e.printStackTrace();
			logger.error("", e);
		} finally {
			getHibernateUtils.getHibernateUtlis().CloseConnection();
		}

		return js.toString();
	}
	
	@Override
	@Transactional
	public List<Object[]> getInvestigationResultEmptyForfileUpload(Long patientId) {
		List<Object[]> listObject = null;
		Integer count = 0;
		try { 
			Session session = getHibernateUtils.getHibernateUtlis().OpenSession();
			StringBuilder sbQuery = new StringBuilder();
			sbQuery.append(" select distinct ohd.order_no, ");
			sbQuery.append(" ohd.patient_id,ohd.ORDER_DATE from  "+DG_ORDER_HD+" ohd ");
			// sbQuery.append(" join DG_ORDER_DT odt on ohd.orderhd_id=odt.orderhd_id join
			// DG_MAS_INVESTIGATION ");
			// sbQuery.append(" dgmas on dgmas.INVESTIGATION_ID=odt.INVESTIGATION_ID ");
			// sbQuery.append(" left join DG_RESULT_ENTRY_DT rdt on
			// odt.ORDERDT_ID=rdt.ORDERDT_ID left join DG_RESULT_ENTRY_HD rht on
			// ohd.ORDERHD_ID= rht.ORDERHD_ID ");
			sbQuery.append(
					" where  ohd.ORDER_STATUS=:orderStatus and ohd.PATIENT_ID =:patientId  ORDER BY ohd.ORDER_DATE DESC  ");
			Query query = session.createSQLQuery(sbQuery.toString());
			query.setParameter("orderStatus", "P");
			query.setParameter("patientId", patientId);

			listObject = query.list();
			if (CollectionUtils.isNotEmpty(listObject)) {
				count = listObject.size();
			}
		} catch (Exception e) {
			e.printStackTrace();
			//logger.error("", e);
		}

		return listObject;
	}
}

