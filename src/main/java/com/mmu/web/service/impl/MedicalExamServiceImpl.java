package com.mmu.web.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mmu.web.service.MedicalExamService;
import com.mmu.web.utils.HMSUtil;
import com.mmu.web.utils.RestUtils;


@Repository
public class MedicalExamServiceImpl implements MedicalExamService{

	String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");
	
	@Override
	public String getMEWaitingList(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMEWaitingList");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getMEWaitingList", requestHeaders, payload);
	}

	@Override
	public String getPatientDetailToValidate(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientDetailToValidateME");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getPatientDetailToValidate", requestHeaders, payload);
	}

	@Override
	public String submitMedicalExamByMo(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","submitMedicalExamByMo");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/submitMedicalExamByMo", requestHeaders, payload);
	}

	@Override
	public String submitMedicalExamByMA(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","submitMedicalExamByMA");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	//	return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/submitMedicalExamByMA", requestHeaders, payload);
	}
	
	
	@Override
	public String getAFMSF3BForMOOrMA(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getAFMSF3BForMOOrMA");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getAFMSF3BForMOOrMA", requestHeaders, payload);
	}

	@Override
	public String getInvestigationAndResult(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getInvestigationAndResult");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getInvestigationAndResult", requestHeaders, payload);
	}

	@Override
	public String getMEApprovalWaitingGrid(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMEApprovalWaitingGrid");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getMEApprovalWaitingGrid", requestHeaders, payload);
	}
	
	@Override
	public String getPatientDetailOfVisitId(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientDetailOfVisitId");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getPatientDetailOfVisitId", requestHeaders, payload);
	}

	@Override
	public String getUnitDetail(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getUnitDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
	//	return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getUnitDetail", requestHeaders, payload);
	}
	@Override
	public String getApprovalListByFlag(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getApprovalListByFlag");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getApprovalListByFlag", requestHeaders, payload);
	}
	@Override
	public String getPatientReferalDetailMe(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientReferalDetailMe");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getPatientReferalDetailMe", requestHeaders, payload);
	}
	@Override
	public String getImmunisationHistory(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getImmunisationHistory");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getImmunisationHistory", requestHeaders, payload);
	}
	
	@Override
	public String getMEWaitingGridAFMS18(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMEWaitingGridAFMS18");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getMEWaitingGridAFMS18", requestHeaders, payload);
	}

	@Override
	public String getPatientDetailOfVisitIdAfms18(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientDetailOfVisitIdAfms18");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getPatientDetailOfVisitIdAfms18", requestHeaders, payload);
	}

	@Override
	public String submitMedicalExamByMAForm18(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","submitMedicalExamByMAForm18");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/submitMedicalExamByMAForm18", requestHeaders, payload);
	}	
		@Override
	public String getServiceDetails(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getServiceDetails");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getServiceDetails", requestHeaders, payload);
	}

	@Override
	public String getPatientDiseaseWoundInjuryDetail(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientDiseaseWoundInjuryDetail");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getPatientDiseaseWoundInjuryDetail", requestHeaders, payload);
	}

	@Override
	public String getMasEmployeeDetailForService(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasEmployeeDetailForService");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getMasEmployeeDetailForService", requestHeaders, payload);
	}

	@Override
	public String getMasDesignationMappingByUnitId(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMasDesignationMappingByUnitId");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getMasDesignationMappingByUnitId", requestHeaders, payload);
	}	
	
		@Override
	public String getInvestigationListUOM(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getInvestigationListUOM");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getInvestigationListUOM", requestHeaders, payload);
	}
	@Override
	public String submitMedicalExamByMA3A(String string, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","submitMedicalExamByMA3A");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, string);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/submitMedicalExamByMA3A", requestHeaders, string);
	}	
	
	
	@Override
	public String getPatientDetailOfVisitIdAfms18P(String payload, HttpServletRequest request,
			HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getPatientDetailOfVisitIdAfms18P");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getPatientDetailOfVisitIdAfms18P", requestHeaders, payload);
	}

	@Override
	public String getMedicalExamListCommon(String payload, HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
		String Url = HMSUtil.getProperties("urlextension.properties","getMedicalExamListCommon");
		String OSBURL = ipAndPort + Url;
		return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
		//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/getMedicalExamListCommon", requestHeaders, payload);
	}
	
	//code change by rajdeo
			@Override
			public String getMEMBHistory(String payload, HttpServletRequest request, HttpServletResponse response) {
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties","getMEMBHistory");
				String OSBURL = ipAndPort + Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);

			}

			@Override
			public String submitPatientImmunizationHistory(String payload, HttpServletRequest request,
					HttpServletResponse response) {
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties","submitPatientImmunizationHistory");
				String OSBURL = ipAndPort + Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
				//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/commonController/submitPatientImmunizationHistory", requestHeaders, payload);
					}

			@Override
			public String saveItemCommon(String payload, HttpServletRequest request, HttpServletResponse response) {
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("urlextension.properties","saveItemCommon");
				String OSBURL = ipAndPort + Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
				//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/commonController/saveItemCommon", requestHeaders, payload);
		
			}

			@Override
			public String submitApprovalDate(String payload, MultipartHttpServletRequest request,
					HttpServletResponse response) {
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("js_messages_en.properties","pathOfSubmitVerifyDocument");
				String OSBURL = Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
				//return RestUtils.postWithHeaders("http://localhost:8082/AshaServices/medicalexam/submitApprovalData", requestHeaders, data);
			}

			@Override
			public String getTemplateInvestDataForDiver(String payload, HttpServletRequest request,
					HttpServletResponse response) {
				MultiValueMap<String,String> requestHeaders = new LinkedMultiValueMap<String, String>();
				String Url = HMSUtil.getProperties("js_messages_en.properties","pathTemplateInvestDataForDiver");
				String OSBURL = Url;
				return RestUtils.postWithHeaders(OSBURL.trim(), requestHeaders, payload);
			}
}
