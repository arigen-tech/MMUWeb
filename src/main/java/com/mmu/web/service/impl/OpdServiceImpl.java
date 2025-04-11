package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.mmu.web.service.OpdService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.ProjectUtils;
import com.mmu.web.utils.RestUtils;

@Repository
public class OpdServiceImpl implements OpdService {
	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	@Autowired
	private Environment environment;
	
	/*
	 * @Autowired FileUploadDAO fileUploadDao;
	 */
	
	@Override
	public String preConsPatientWatingWeb(String payload, HttpServletRequest request, HttpServletResponse response) {
		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","preConsPatientWatingWeb");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String saveVitailsPatientdetails(String payload, HttpServletRequest request, HttpServletResponse response) {
		
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveVitailsPatientdetails");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getIdealWeight(String payload, HttpServletRequest request, HttpServletResponse response) {
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties","getIdealWeight");
				String OSBURL = ipAndPort + Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getOpdWaitingList(String payload, HttpServletRequest request, HttpServletResponse response) {
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdWaitingList");
		String OSBURL = ipAndPort + Url;
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getIcdList(String payload, HttpServletRequest request, HttpServletResponse response) {
		String Url = HMSUtil.getProperties("urlextension.properties","getIcdList");
		String OSBURL = ipAndPort + Url;
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	

	@Override
	public String getFamilyPatientHistory(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getFamilyPatientHistory");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
    
	@Override
	public String getPreviousLabInvestigation(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPreviousInvestigationAndResult");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	
	@Override
	public String getOpdPatientDetailModel(String payload,HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdPatientDetailModel");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String saveOpdPatientdetails(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveOpdPatientdetails");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String saveOpdInvestigationTemplates(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveOpdInvestigationTemplates");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String saveTreatmentOpdTemplates(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","saveOpdTreatmentTemplates");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getIinvestigationList(String payload, HttpServletRequest request, HttpServletResponse response) {
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties","getIinvestigationList");
				String OSBURL = ipAndPort + Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getMasStoreItemList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasStoreItemList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@Override
	public String getMasDisposalList(String payload,HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasDisposalList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getMasFrequency(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasFrequency");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getMasNursingCare(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasNursingCare");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	
	@Override
	public String getTemplateName(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getTemplateName");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getEmpanelledHospital(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getEmpanelledHospital");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@Override
	public String getTemplateInvestigation(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getTemplateInvestigationData");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getTemplateTreatment(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getTemplateTreatmentData");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


	@Override
	public String getCaseSheet(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdPatientDetailModel");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getOpdReportsDetailsbyServiceNo(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdReportsDetailsbyServiceNo");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getOpdReportsDetailsbyPatinetId(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdReportsDetailsbyPatinetId");
		String OSBURL = ipAndPort + Url;
	    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getOpdPreviousVisitRecord(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdPreviousVisitRecord");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	
	}

	@Override
	public String getOpdPreviousVital(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getOpdPreviousVitalRecord");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getMasDispUnit(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getDispUnit");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getMasItemClass(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasItemClass");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	

	@Override
	public String obesityWaitingList(String payload) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String osb = HMSUtil.getProperties("urlextension.properties", "obesityWaitingList");
		return RestUtils.postWithHeaders(ipAndPort.trim()+osb.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getObesityDetail(String payload, HttpServletRequest request, HttpServletResponse response){
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String osb = HMSUtil.getProperties("urlextension.properties", "getObesityDetail");
		return RestUtils.postWithHeaders(ipAndPort.trim()+osb.trim(), requestHeaders, payload);
	}
	
	//Added by Avinash According to Patient recall
	@Override
	public String updatAndInsertPatientRecall(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","SubmitPatientRecall");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
    

	@Override
	public String deleteGridRow(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","DeleteGridRow");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}

	@Override
	public String getPatientReferalDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GetPatientReferalDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getPatientHistoryDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GetPatientHistoryDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getTreatmentPatientDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GetTreatmentPatientDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	
	@Override
	public String getInvestigationDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GetInvestigationDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getExaminationDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","GetExaminationDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}
	
	@Override
	public String getMasStoreItemNip(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasStoreItemNip");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	}


/*
		@SuppressWarnings("unchecked")
		public String getDocumentListForPatient(String data, HttpServletRequest request, HttpServletResponse response) {
			Map<String,Object> map = new HashMap<String, Object>();
			JSONObject json = new JSONObject();
			List<HashMap<String,Object>> docListObj = new ArrayList<HashMap<String,Object>>();
			JSONObject jsonObj = new JSONObject(data);
			long patientId = jsonObj.getLong("patientId");
			
			map =fileUploadDao.showUploadedDocumentsForPatient(patientId);
			List<UploadDocument> docList = (List<UploadDocument>) map.get("documentList");
			if(docList!=null &&  docList.size()>0 ) {
				for (UploadDocument list : docList) {
					HashMap<String, Object> mapDoc = new HashMap<String, Object>();
					mapDoc.put("Id",list.getFileId());
					mapDoc.put("fileName",list.getFileName());
					mapDoc.put("remarks",list.getRemarks());
					mapDoc.put("ridcId",list.getRidcId());

					docListObj.add(mapDoc);
				}
				if (docListObj != null && docListObj.size() > 0) {
					json.put("data", docListObj);
					json.put("status", 1);
				} else {
					json.put("data", docListObj);
					json.put("msg", "Data not found");
					json.put("status", 0);
				}
				
			}
			return json.toString();
		}

		@Override
		public String uploadDocumentForPatient(HttpServletRequest request,
	            @RequestParam CommonsMultipartFile[] fileUpload) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			JSONObject json = new JSONObject();
			boolean flag=false;
			long patientId=0;
			String remarks="";
			
			if(!request.getParameter("patientName").isEmpty()) {
				patientId = Long.parseLong(request.getParameter("patientName"));
			}
			
			if(!request.getParameter("remarks").isEmpty()) {
				remarks = request.getParameter("remarks");
			}
			
		    if (fileUpload != null && fileUpload.length > 0) {
	            for (CommonsMultipartFile aFile : fileUpload){
	                  
	                System.out.println("Saving file: " + aFile.getOriginalFilename());
	                 
	                UploadDocument uploadFile = new UploadDocument();
	                uploadFile.setFileName(aFile.getOriginalFilename());
	                uploadFile.setFileData(aFile.getBytes());
	                
	                Patient patient = new Patient();
	                patient.setPatientId(patientId);
	                uploadFile.setPatient(patient);
	                
	                uploadFile.setRemarks(remarks);
	                
	                flag= fileUploadDao.save(uploadFile); 
	                
	                if(flag) {
	    		    	map.put("message", "File uploaded Sucessfully");
	    		    	map.put("status", "1");
	                }else {
	   	    		 map.put("message", "File is not uploaded Sucessfully, some error is occurred");
	 		    	 map.put("status", "0");
	                }
	            }
	        }
		    json.put("data", map);
	        return json.toString();
		}

		@Override
		public String deleteUploadDocument(String data, HttpServletRequest request, HttpServletResponse response) {
			boolean status=false;
			Map<String,Object> map = new HashMap<String, Object>();
			JSONObject json = new JSONObject();
			JSONObject jsonObj = new JSONObject(data);
			long fileId = jsonObj.getLong("fileId");
			
			status = fileUploadDao.deleteUploadDocument(fileId);
			if(status) {
				map.put("status", "1");
				map.put("msg", "File removed successfully.");
			}else {
				map.put("status", "0");
				map.put("msg", "File can not removed.");
			}
			json.put("data", map);
			return json.toString();
		}
*/

		@Override
		public String getPocedureDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","GetPocedureDetailRecall");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
		}

		@Override
		public String savePreocdureMasters(String payload, HttpServletRequest request, HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","savePreocdureMasters");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String saveEmpanlledHospitalMasters(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","saveEmpanlledHospitalMasters");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}
	
		@Override
		public String authenticateUser(String payload, HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","AuthenticateUser");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
		}

		@Override
		public String getMasDepartmentList(String payload, HttpServletRequest request, HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getDepartmentList");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		}

		@Override
		public String getMasHospitalList(String payload, HttpServletRequest request, HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getHospitalList");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

		}
		
		@Override
		public String showCurrentMedication(String payload, HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","ShowCurrentMedication");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
		}
		
		@Override
		public String checkForAuthenticateUser(String payload, HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","CheckForAuthenticateUser");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
		}

		@Override
		public String updateCurrentMedication(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","updateCurrentMedication");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String opdDeleteInvestigationTemplate(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public String getDispStockDetails(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getBatchStock");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getDepartmentId(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getDepartmentIdAgainstCode");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getRidcDocmentInfo(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getRidcDocumentInfo");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getOpdEmergencyShowEmployeeList(String requestData, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","DEPT_BlOOD_MEDICAL_CAT");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, requestData);
			
		}

		@Override
		public String saveOpdEmergency(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","opdEmergencySavePatient");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}



		@Override
		public String getSpecialistList(String payload, HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getSpecialistList");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getIcdListByName(String payload, HttpServletRequest request, HttpServletResponse response) {
			String Url = HMSUtil.getProperties("urlextension.properties","getIcdListByName");
			String OSBURL = ipAndPort + Url;
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getDocumentListForPatient(String data, HttpServletRequest request, HttpServletResponse response) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public String uploadDocumentForPatient(HttpServletRequest request, CommonsMultipartFile[] uploadFile) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public String deleteUploadDocument(String data, HttpServletRequest request, HttpServletResponse response) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public String updateOpdInvestigationTemplates(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","updateOpdTemplates");
			String OSBURL = ipAndPort + Url;
			 return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
		}

		@Override
		public String updateOpdTreatmentTemplates(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","updateTreatmentTemplates");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
		}

		@Override
		public String getUsersAuthentication(String payload, HttpServletRequest request, HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getUsersAuthication");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
		}

		@Override
		public String saveOpdMedicalAdviceTemplates(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","saveOpdMedicalAdviceTemplates");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
		}

		@Override
		public String getTemplateMedicalAdvice(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			     MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties","getTemplateMedicalAdvice");
				String OSBURL = ipAndPort + Url;
			    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
						
		}

		@Override
		public String saveOrUpdateChildVacatination(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","saveOrUpdateChildVacatination");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
		}

		@Override
		public String getChildVacatinationRecord(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			JSONObject jsonParent = new JSONObject();
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getChildVacatinationRecord");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			
		}
		
		@Override
		public String rejectOpdWaitingList(String payload, HttpServletRequest request, HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","rejectOpdWaitingList");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			//return RestUtils.postWithHeaders(AppUrlConstant.rejectOpdWaitingList, requestHeaders, payload);
		}

		@Override
		public String geTreatmentInstruction(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","geTreatmentInstruction");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getPatientSympotons(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getPatientSympotons");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String deletePatientSymptom(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","deletePatientSymptom");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getPatientDianosisDetail(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getPatientDianosisDetail");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String documentUpload(String payload,MultipartFile ecgDoc, HttpServletRequest request, HttpServletResponse response) {
			// TODO Auto-generated method stub
			String visitId=request.getParameter("visitId");
			String rootPath = environment.getProperty("mmu.service.ecg.upload");
			if (visitId != null) {
				ProjectUtils.storePatientECGDocument(visitId, ecgDoc, "ECGDoc",rootPath);
				}
			return null;
		}

		@Override
		public String getAIDiagnosisDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getAIDiagnosisDetail");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getAIInvestgationDetail(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getAIInvestgationDetail");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}

		@Override
		public String getAITreatmentDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
			
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getAITreatmentDetail");
			String OSBURL = ipAndPort + Url;
		    return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		}
		
		
		@Override
		public String getPatientHistoryRecord(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getPatientHistoryRecord");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
		}

		@Override
		public String getOpdPreviousAuditHistory(String payload, HttpServletRequest request,
				HttpServletResponse response) {
			MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
			String Url = HMSUtil.getProperties("urlextension.properties","getOpdPreviousAuditorRecord");
			String OSBURL = ipAndPort + Url;
			return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		
		}
}
