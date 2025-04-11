package com.mmu.web.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

public class ProjectUtils {

	public synchronized static String generateToken() {
		DateFormat sdf = new SimpleDateFormat("yyMMddHHmmssS");
		Date date = new Date();
		String tokenID = sdf.format(date);
		tokenID = tokenID.replace("-", "");
		tokenID = tokenID.replace("+", "");
		return RandomStringUtils.randomAlphabetic(5) + "" + tokenID;
	}

	public static String refreshTocken(HttpServletRequest request) {
		LinkedHashMap<String, String> userMAp = (LinkedHashMap<String, String>) request.getSession()
				.getAttribute("shopdetail");
		String token = ProjectUtils.generateToken();
		LinkedHashMap<String, String> usermap = new LinkedHashMap<String, String>();
		usermap.put(token, userMAp.get("adminid") + "");
		usermap.put("adminid", userMAp.get("adminid"));
		// usermap.put("shopid", userMAp.get("shopid"));
		request.getSession().setAttribute("shopdetail", usermap);
		request.getSession().setMaxInactiveInterval(15 * 60);
		return token;
	}

	public static String getErrorMssg(int status, String status_cd, String err_mssg) {
		JSONObject jsonObject = new JSONObject();
		try {
			jsonObject.put("status", status);
			jsonObject.put("status_cd", status_cd);
			jsonObject.put("err_mssg", err_mssg);
		} catch (Exception e) {
			System.err.println("Exception in getErrorMssg()" + e.toString());
		}
		return jsonObject.toString();

	}

	public static boolean validateSession(String token, HttpServletRequest session) {
		HttpSession s = session.getSession(false);
		if (s == null) {
			return false;
		}
		try {
			LinkedHashMap<String, String> userMAp = (LinkedHashMap<String, String>) s.getAttribute("shopdetail");
			if (userMAp == null)
				return false;

			if (userMAp.containsKey((String) token)) {
				return true;
			}

		} catch (Exception ex) {
			// System.out.println("USER SESSION IS EXPIRED ....!!! TIMES UP");
		}
		return false;
	}

	public static String saltify_level2(String unecryptedPassword) throws Exception {
		String salt = "VuCETZcz6D";
		MessageDigest messageDigest = null;
		try {
			messageDigest = MessageDigest.getInstance("SHA");
			messageDigest.update((unecryptedPassword + salt).getBytes());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		String encryptedPassword = (new BigInteger(messageDigest.digest())).toString(16);
		return encryptedPassword;
	}

	public static String getCurrentDate() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd ");
		Date d = new Date();
		return dateFormat.format(d).toString();
	}

	public static String getCurrentDateforweekgraph() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date d = new Date();
		return dateFormat.format(d).toString();
	}

	public static String getCurrentDateandTimeStamp() {
		DateFormat dateFormat = new SimpleDateFormat("E, MMM dd yyyy HH:mm:ss");
		Date d = new Date();
		return dateFormat.format(d).toString();
	}

	public synchronized static String generateCode() {
		return RandomStringUtils.randomNumeric(6);
	}

	public static String getDateForgraph() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		Calendar c = Calendar.getInstance();
		Date date = new Date();
		c.setTime(date);
		int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
		// System.out.println("date " + dateFormat.format(date));
		// System.out.println("day " + dayOfWeek);
		dayOfWeek = dayOfWeek + 7;
		// System.out.println("day again " + dayOfWeek);

		String dateagain = customizeDateForGraph(dateFormat.format(date), dayOfWeek);
		// System.out.println("day again and again " + dateagain);
		return dateagain.toString();
	}

	public static String customizeDateForGraph(String date, int day) {
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		Date startDate, newDate;
		Calendar cal = Calendar.getInstance();
		try {
			startDate = df.parse(date);
			String newDateString = df.format(startDate);
			cal.setTime(startDate);
			cal.add(Calendar.DATE, -day);
			Date currentDatePlusOne = cal.getTime();
			return df.format(currentDatePlusOne);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cal.getTime().toString();
	}

	//

	public static String getOneMonthBack(String date) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate, newDate;
		Calendar cal = Calendar.getInstance();
		try {
			startDate = df.parse(date);
			String newDateString = df.format(startDate);
			cal.setTime(startDate);
			cal.add(Calendar.MONTH, -1);
			Date currentDatePlusOne = cal.getTime();
			return df.format(currentDatePlusOne);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cal.getTime().toString();
	}

	public static Date getOneMonthBackNew(String date) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate, newDate;
		Calendar cal = Calendar.getInstance();
		try {
			startDate = df.parse(date);
			String newDateString = df.format(startDate);
			cal.setTime(startDate);
			cal.add(Calendar.MONTH, -1);
			Date currentDatePlusOne = cal.getTime();

			return currentDatePlusOne;
			// return df.format(currentDatePlusOne);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// return cal.getTime().toString();
		return cal.getTime();
	}

	public static String getDayNameOfDate(String date) {

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate, newDate;
		Calendar c = Calendar.getInstance();

		try {
			startDate = df.parse(date);
			c.setTime(startDate);
			int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
			// System.out.println("Bhai Day mila "+dayOfWeek);

			switch (dayOfWeek) {
			case 1:
				// System.out.print("Sunday");
				return "Sunday";
			// break;
			case 2:
				// System.out.print("Monday");
				return "Monday";
			// break;
			case 3:
				// System.out.print("Tuesday");
				return "Tuesday";
			// break;
			case 4:
				// System.out.print("Wednesday");
				return "Wednesday";
			// break;
			case 5:
				// System.out.print("Thursday");
				return "Thursday";
			// break;
			case 6:
				// System.out.print("Friday");
				return "Friday";
			// break;
			case 7:
				// System.out.print("Saturday");
				return "Saturday";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "";
	}

	private static JSONObject function(HashMap<String, String> jsonData, String[] strings) {

		for (int i = 0; i < strings.length; i++) {
			boolean b = jsonData.containsKey(strings[i]) && jsonData.get(strings[i]) != null
					&& !(jsonData.get(strings[i]).toString().equals(""));
			if (b == false) {
				return ErrorDiscriptions.getReturnMsg(
						"jsondata is not contain" + " " + strings[i] + " " + "as a  key or value or it is null", "0");
			}
		}
		return ErrorDiscriptions.getReturnMsg("validated data found.", "1");
	}

	public static java.sql.Date getCurrentDates() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date d = new Date();
		String temp = dateFormat.format(d);
		// System.out.println(java.sql.Date.valueOf(temp));
		return java.sql.Date.valueOf(temp);
	}

	public static LocalDateTime getDateTimePluseThirtyMin(String date) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
		LocalDateTime todayOld = LocalDateTime.parse(date, formatter);
		System.out.println("normal date " + todayOld);
		Duration addTwentyMin = Duration.ofMinutes(30);
		String oldFinal = todayOld.plus(addTwentyMin).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));
		LocalDateTime oldFinaldateTime = LocalDateTime.parse(oldFinal, formatter);
		System.out.println("After add 30 min      " + oldFinaldateTime);
		return oldFinaldateTime;
	}

	public static Map<String, Object> getCurrentDateAndTime() {

		Map<String, Object> map = new HashMap<String, Object>();
		String currentDate = "";
		String currentTime = "";
		String currentTimeWithoutSc = "";
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		String datetime = dateFormat.format(date);
		StringTokenizer s = new StringTokenizer(datetime, " ");
		while (s.hasMoreTokens()) {
			currentDate = s.nextToken();
			currentTime = s.nextToken();
		}
		map.put("currentDate", currentDate);
		/**
		 * Added By Ritu
		 */
		SimpleDateFormat dateFormatWithoutSc = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		String datetimeWithoutSc = dateFormatWithoutSc.format(date);
		StringTokenizer strWithoutSc = new StringTokenizer(datetimeWithoutSc, " ");
		while (strWithoutSc.hasMoreTokens()) {
			strWithoutSc.nextToken();
			currentTimeWithoutSc = strWithoutSc.nextToken();
		}
		map.put("currentTime", currentTimeWithoutSc);
		map.put("currentTimeWithoutSc", currentTimeWithoutSc);
		return map;
	}

	public static boolean checksession(HttpServletRequest request) {
		HttpSession httpSession = request.getSession(false);
		String userId;
		String mmuId;
		try {

			userId = httpSession.getAttribute("userId").toString();
			//mmuId = httpSession.getAttribute("mmuId").toString();
			System.out.println("userId:" + userId);
			//System.out.println("hospitalId:" + mmuId);

		} catch (Exception e) {

			userId = null;
			//mmuId = null;
		}
		if (userId == null) {
			return false;
		} else {
			return true;
		}

	}
	
	public static String getPatientDocPath(String fullpath,String visitId) {
		String path = fullpath+ visitId;
		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}
		return path;
	}
	
	public static boolean storePatientECGDocument(String empId, MultipartFile file, String fileName,String fullPath) {

		try {
			String path = getPatientDocPath(fullPath,empId);
			byte[] bytes = file.getBytes();
			File myFile = new File(
					path + "/" + fileName + "." + FilenameUtils.getExtension(file.getOriginalFilename()));
			FileOutputStream opStream = new FileOutputStream(myFile);
			opStream.write(bytes);
			opStream.flush();
			opStream.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

public static HashMap<String, String> getPatientDocument(String fullPath,String visitId) {

	File folder = new File(fullPath + visitId);
	File[] listOfFiles = folder.listFiles();
	HashMap<String, String> data = new HashMap<>();
	if (listOfFiles != null) {
		for (File file : listOfFiles) {
			String name = file.getName();
			name = name.substring(0, name.lastIndexOf("."));
			String temp = file.getPath().replace("\\", "/")
					.replaceFirst(fullPath, "");
			data.put(name, temp);
		}
	}
	return data;
}

public static JSONObject getReturnMsg(String status, String msg) {
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("status", status);
	jsonObject.put("msg", msg);
	return jsonObject;
}

}