package com.mmu.web.service.schedulers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mmu.web.utils.HMSUtil;

@Component
public class AuditUploadJobExecution implements Job {

	static String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");


	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		String gpsUrl = HMSUtil.getProperties("adt.properties", "gpsAPIUrl").trim();
		
		String OSBURLsendFollowupMsgScheduler = HMSUtil.getProperties("urlextension.properties", "auditUploadData");
		String sendAuditMsgScheduler = ipAndPort.trim() + OSBURLsendFollowupMsgScheduler.trim();
		String gpsClientId = HMSUtil.getProperties("adt.properties", "gpsClientId").trim();

		String gpsSecretKey = HMSUtil.getProperties("adt.properties", "gpsSecretKey").trim();
		String authString = gpsClientId + ":" + gpsSecretKey;
		String base64Creds = Base64.encodeBase64String(authString.getBytes());
		
		HttpHeaders headers = new HttpHeaders();


		headers.add("Authorization", "Basic " + base64Creds);
		headers.add("Content-Type", MediaType.APPLICATION_JSON_VALUE);
		try {
			JSONObject reqJsonForCamp = new JSONObject();
			reqJsonForCamp.put("", "");
			HttpEntity request = new HttpEntity(reqJsonForCamp.toString(), headers);
			ResponseEntity<String> followMsgDlivered = new RestTemplate().exchange(sendAuditMsgScheduler, HttpMethod.POST, request,
				String.class);
		System.out.println("<<Audit Upload Status>>"+followMsgDlivered);
		}catch (Exception e) {
			e.printStackTrace();
		}
    }	

}
