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
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mmu.web.utils.HMSUtil;

@Component
public class VehicleLocationJob implements Job {

	static String ipAndPort = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");


	@SuppressWarnings("unchecked")
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		String gpsUrl = HMSUtil.getProperties("adt.properties", "gpsAPIUrl").trim();

		// String OSBURL = HMSUtil.getProperties("urlextension.properties",
		// "getMMUListForPoll");
		// String schedulerUrl = ipAndPort.trim() + OSBURL.trim();

		String OSBURLCAMP = HMSUtil.getProperties("urlextension.properties", "getCampDetailsForMMU");
		String campUrl = ipAndPort.trim() + OSBURLCAMP.trim();

		String OSBURLSave = HMSUtil.getProperties("urlextension.properties", "saveVehicleLocation");
		String saveUrl = ipAndPort.trim() + OSBURLSave.trim();
		
		String OSBURLsendFollowupMsgScheduler = HMSUtil.getProperties("urlextension.properties", "sendFollowupMsgScheduler");
		String sendFollowupMsgScheduler = ipAndPort.trim() + OSBURLsendFollowupMsgScheduler.trim();

		String gpsClientId = HMSUtil.getProperties("adt.properties", "gpsClientId").trim();

		String gpsSecretKey = HMSUtil.getProperties("adt.properties", "gpsSecretKey").trim();

		String authString = gpsClientId + ":" + gpsSecretKey;
		String base64Creds = Base64.encodeBase64String(authString.getBytes());

		HttpHeaders headers = new HttpHeaders();


		//headers.add("Authorization", "Basic " + base64Creds);
		headers.add("X-IBM-Client-Id", gpsClientId.toString());
		headers.add("X-IBM-Client-Secret", gpsSecretKey.toString());
		headers.add("Content-Type", MediaType.APPLICATION_JSON_VALUE);

		LocalDate today = LocalDate.now();
		String startDate = today.toString().replaceAll("-", "") + "" + "070000";
		String endDate = today.toString().replaceAll("-", "") + "" + "210000";

		HttpClient client = new DefaultHttpClient();
		StringEntity input;
		try {

			JSONObject reqJsonForCamp = new JSONObject();
			reqJsonForCamp.put("", "");
			@SuppressWarnings({ "unchecked", "rawtypes" })
			HttpEntity request = new HttpEntity(reqJsonForCamp.toString(), headers);
			ResponseEntity<String> apiResponse = null;
			try {
			 apiResponse = new RestTemplate().exchange(campUrl, HttpMethod.POST, request,
					String.class);
			}catch (Exception e) {
				e.printStackTrace();
			}
			try {
			ResponseEntity<String> followMsgDlivered = new RestTemplate().exchange(sendFollowupMsgScheduler, HttpMethod.POST, request,
					String.class);
			System.out.println("Follow Message Status "+followMsgDlivered);
			}catch (Exception e) {
				e.printStackTrace();
			}
			ObjectMapper mapper = new ObjectMapper();
			String campJson = apiResponse.getBody();
			System.out.println("apiResponsefor camp:- "+apiResponse);
			Map<String, List<HashMap<String, Object>>> responseMap;
			responseMap = mapper.readValue(campJson, Map.class);
			System.out.println("apiResponsefor responseMap:- " + responseMap);
			if (responseMap.get("data") != null) {
				List<HashMap<String, Object>> campApiResp = responseMap.get("data");
				if (campApiResp.size() > 0) {
					for (HashMap<String, Object> campRecord : campApiResp) {
						Long campId = 0l;
						Double campLat = 0.0;
						Double campLong = 0.0;
						double distance = 0.0;

						Long mmuId = Long.parseLong(String.valueOf(campRecord.get("mmuId")));
						System.out.println("MMU ID--> " + mmuId);
						campId = Long.parseLong(String.valueOf(campRecord.get("campId")));
						System.out.println("campId ID--> " + campId);
						campLat = Double.parseDouble(String.valueOf(campRecord.get("campLat")));
						//System.out.println("campLat--> " + campLat);
						campLong = Double.parseDouble(String.valueOf(campRecord.get("campLong")));
						//System.out.println("campLong--> " + campLong);
						String chasis = String.valueOf(campRecord.get("chassisNo"));
						//System.out.println("chassisNo--> " + chasis);
						String[] chassisNo = new String[] { chasis };

						JSONObject inputJson = new JSONObject();
						inputJson.put("startDateTime", startDate);
						inputJson.put("endDateTime", endDate);
						inputJson.put("chassisno", chassisNo);
						inputJson.put("latestOnly", true);

						//if (mmuId != 34 && mmuId != 39 && mmuId != 44) {
							System.out.println("inputJson.toString()---kk--> " + inputJson.toString());
							//HttpEntity request1 = new HttpEntity(inputJson.toString(), headers);
							HttpEntity<String> request1 = new HttpEntity<String>(inputJson.toString(), headers);
							ResponseEntity<String> apiResponse1=null; 
							//RestTemplate restTemplate = new RestTemplate();
							//restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
							try {
							/*	System.out.println(request1.toString());
							apiResponse1 = restTemplate.exchange(gpsUrl, HttpMethod.POST,
									request1, String.class);*/
								MultiValueMap<String, String> headers1 = new LinkedMultiValueMap<String, String>();
								headers1.add("X-IBM-Client-Id", gpsClientId.toString());
								headers1.add("X-IBM-Client-Secret", gpsSecretKey.toString());
								headers1.add("Content-Type", "application/json");
								headers1.add("user-agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36");

								RestTemplate restTemplate = new RestTemplate();
								restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
								HttpEntity<String> requestNew = new HttpEntity<String>(inputJson.toString(), headers1);
								System.out.println(headers1.toString());
								System.out.println(requestNew.toString());
								apiResponse1=restTemplate.postForEntity(gpsUrl, requestNew, String.class);
							
							}catch (Exception e) {
								e.printStackTrace();
							}
							String json = apiResponse1.getBody();
							System.out.println("API response-> " + json);
							String tempStr = json.substring(1, json.length() - 1);
							responseMap = mapper.readValue(tempStr, Map.class);

							if (responseMap.get("positiondata") != null) {
								List<HashMap<String, Object>> apiResp = responseMap.get("positiondata");

								Double mmuLattitude = Double
										.parseDouble(String.valueOf(apiResp.get(0).get("lattitude")));
								Double mmuLongitude = Double
										.parseDouble(String.valueOf(apiResp.get(0).get("longitude")));
								if (campLat > 0 && campLong > 0) {
									distance = calculateDistanceInMeters(campLat, campLong, mmuLattitude, mmuLongitude);
								}
								 distance = Math.round(distance * 100.0) / 100.0;
								 
								 System.out.println("distance="+distance);
								JSONObject saveJson = new JSONObject();
								saveJson.put("schedulerDate", today);
								saveJson.put("campId", campId);
								saveJson.put("mmuId", mmuId);
								saveJson.put("campLatitudes", campLat);
								saveJson.put("campLongitudes", campLong);
								saveJson.put("mmuLattitude", mmuLattitude);
								saveJson.put("mmuLongitude", mmuLongitude);
								saveJson.put("distance", distance);

								System.out.println("saveJson--> " + saveJson.toString());

								HttpPost post = new HttpPost(saveUrl);
								input = new StringEntity(saveJson.toString());
								input.setContentType("application/json");
								post.setEntity(input);
								HttpResponse response = client.execute(post);

								String inserResp = EntityUtils.toString(response.getEntity());
								//System.out.println("inserResp--> " + inserResp);

							}
						//}
					}
				}
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	private double calculateDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {

		double theta = lon1 - lon2;
		  double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
		  dist = Math.acos(dist);
		  dist = rad2deg(dist);
		  dist = dist * 60 * 1.1515;
		  dist = dist * 1.609344 * 1000;//convert in meters
		   return (dist);
		}
	
	private double deg2rad(double deg) {
		  return (deg * Math.PI / 180.0);
		}
	
	private double rad2deg(double rad) {
		  return (rad * 180.0 / Math.PI);
		}

}
