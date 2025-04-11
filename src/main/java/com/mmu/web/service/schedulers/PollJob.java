package com.mmu.web.service.schedulers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mmu.web.utils.HMSUtil;

@Component
public class PollJob implements Job {

	static String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");


	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		
		System.out.println("start");
		
		
		String url = HMSUtil.getProperties("adt.properties", "pollUrl").trim();
		
		String OSBURL = HMSUtil.getProperties("urlextension.properties", "getMMUListForPoll");
		String schedulerUrl = ipAndPort.trim() + OSBURL.trim();
		
		String OSBURL1 = HMSUtil.getProperties("urlextension.properties", "savePollInfo");
		String saveUrl = ipAndPort.trim() + OSBURL1.trim();
		
		String userName = HMSUtil.getProperties("adt.properties", "pollUserName").trim();
		String password = HMSUtil.getProperties("adt.properties", "pollPassword").trim();
		
		String authString = userName + ":" + password;
		String base64Creds = Base64.encodeBase64String(authString.getBytes());// getEncoder().encodeToString();
		
		HttpHeaders headers = new HttpHeaders();
		//headers.add("Accept", "application/json");
	   // headers.add("Content-Type", "application/json");
		
	    String jsonBody = "{\"\":\"\"}";
		
	   headers.add("Authorization", "Basic " + base64Creds);
	   headers.add("Content-Type", MediaType.APPLICATION_JSON_VALUE);
	   
	   LocalDate today = LocalDate.now();
	   String yesterday = (today.minusDays(1)).format(DateTimeFormatter.ISO_DATE);
	   
	   String startDate = yesterday+" "+"00:00:00";
	   String endDate = yesterday+" "+"23:59:59";
	    
	   
	    HttpClient client = new DefaultHttpClient();
	    HttpPost post = new HttpPost(schedulerUrl);
	    StringEntity input;
		try {
			input = new StringEntity(jsonBody);
			input.setContentType("application/json");
			 post.setEntity(input);
			    HttpResponse response = client.execute(post);
			    
			   String respjson = EntityUtils.toString(response.getEntity());
			   
			  ObjectMapper mapper = new ObjectMapper(); 
			  Map<String, List<HashMap<String, Object>>> pollMap = mapper.readValue(respjson, Map.class); 
			  List<HashMap<String, Object>> pollJson = pollMap.get("data");
			  int good = 0, average=0, bad=0,total=0;
			  for(HashMap<String, Object> pollNo : pollJson) { 
				  JSONObject reqJson = new JSONObject();
				  Long mmuId = Long.parseLong(String.valueOf(pollNo.get("mmuId")));
					reqJson.put("start_date", startDate);
					reqJson.put("end_date", endDate);
					reqJson.put("poll_id", pollNo.get("pollNo").toString());
					 HttpEntity request = new HttpEntity(reqJson.toString(),headers);
					 ResponseEntity<String> apiResponse = new RestTemplate().exchange(url,HttpMethod.POST, request, String.class);
					
					 String json = apiResponse.getBody();
					 Map<String, List<HashMap<String, Object>>> responseMap = mapper.readValue(apiResponse.getBody(), Map.class); 
					 List<HashMap<String, Object>> pollResponse = responseMap.get("obj");
					
					 for(HashMap<String, Object> resp : pollResponse) {
						 System.out.println("ggfgdfg--- "+resp);
						  good = Integer.parseInt(String.valueOf(resp.get("good")));
						  average = Integer.parseInt(String.valueOf(resp.get("average")));
						  bad = Integer.parseInt(String.valueOf(resp.get("bad")));
						  total = Integer.parseInt(String.valueOf(resp.get("total")));
						  JSONObject inputJson = new JSONObject();
						  inputJson.put("good", good);
						  inputJson.put("average", average);
						  inputJson.put("bad", bad);
						  inputJson.put("total", total);
						  inputJson.put("pollDate", yesterday);
						  inputJson.put("mmuId", mmuId);
						  System.out.println("inputJson--> "+inputJson.toString());
						  post = new HttpPost(saveUrl);
						  input = new StringEntity(inputJson.toString());
							input.setContentType("application/json");
							 post.setEntity(input);
							    response = client.execute(post);
							    
							   String inserResp = EntityUtils.toString(response.getEntity());
							   System.out.println("inserResp--> "+inserResp);
					 }
			  }
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		 
	}

}
