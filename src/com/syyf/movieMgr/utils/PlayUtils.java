package com.syyf.movieMgr.utils;

import java.util.List;
import java.util.Map;

import com.syyf.movieMgr.pojo.Play;

public class PlayUtils {
	private PlayUtils(){}
	
	public static final String pojoToJson(Play play) {
		String play_id = play.getPlay_id();
		String play_movie = play.getPlay_movie();
		String play_time = play.getPlay_time();
		String play_price = play.getPlay_price();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"play_id\":\"").append(play_id).append("\",");
		json.append("\"play_movie\":\"").append(play_movie).append("\",");
		json.append("\"play_time\":\"").append(play_time).append("\",");
		json.append("\"play_price\":\"").append(play_price).append("\"}");

		return json.toString();
	}
	
	public static final String listToJson(List<Play> list) {

		StringBuilder json = new StringBuilder();

		for (Play play : list) {
			if (json.length() != 0) {
				json.append(",");
			}

			String str = pojoToJson(play);
			json.append(str);
		}
		return "[" + json + "]";

	}
	
	// List<Map<String, String>>
	public final static String mapToJson(Map<String, String> map) {

		String json = null;
		StringBuffer sb = new StringBuffer();

		for (String key : map.keySet()) {
			Object value = map.get(key);

			sb.append("\"").append(key).append("\":\"").append(value).append("\",");
		}

		int lastIndex = sb.lastIndexOf(",");

		if (lastIndex != -1) {
			json = "{" + sb.substring(0, lastIndex) + "}";
		}

		return json;
	}
	
	public static final String listMapToJson(List<Map<String,String>> list) {

		StringBuilder json = new StringBuilder();

		for (Map<String,String> map : list) {
			if (json.length() != 0) {
				json.append(",");
			}

			String str = mapToJson(map);
			json.append(str);
		}
		return "[" + json + "]";

	}
	
	public static final String list2Json(List<String> list) {
		
		StringBuilder sb = new StringBuilder();
		
		for(String str : list) {
			if(sb.length() != 0) {
				sb.append(",");
			}
			
			sb.append("\"" + str + "\"");
		}
		
		return "[" + sb + "]";
	}
}
