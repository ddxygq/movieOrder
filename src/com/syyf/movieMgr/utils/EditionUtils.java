package com.syyf.movieMgr.utils;

import java.util.List;

import com.syyf.movieMgr.pojo.Edition;

public class EditionUtils {
	private EditionUtils(){}
	
	public static final String pojoToJson(Edition edition){
		String edition_id = edition.getEdition_id();
		String edition_name = edition.getEdition_name();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"edition_id\":\"").append(edition_id).append("\",");
		json.append("\"edition_name\":\"").append(edition_name).append("\"}");
		
		return json.toString();
	}
	
	public static final String listToJson(List<Edition> list){
		StringBuilder json = new StringBuilder();
		
		for (Edition edition : list) {
			if(json.length() != 0){
				json.append(",");
			}
			json.append(pojoToJson(edition));
		}
		
		return "[" + json + "]";
	}
}
