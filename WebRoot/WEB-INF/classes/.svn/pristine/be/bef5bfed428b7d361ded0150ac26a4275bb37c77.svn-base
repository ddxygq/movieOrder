package com.syyf.movieMgr.utils;

import java.util.List;

import com.syyf.movieMgr.pojo.Language;

public class LanguageUtils {
	
	private LanguageUtils(){}
	
	public static final String pojoToJson(Language language) {
		String language_id = language.getLanguage_id();
		String language_name = language.getLanguage_name();
		StringBuilder json = new StringBuilder();
		json.append("{\"language_id\":\"").append(language_id).append("\",");
		json.append("\"language_name\":\"").append(language_name).append("\"}");

		return json.toString();
	}
	
	public static final String listToJson(List<Language> list) {

		StringBuilder json = new StringBuilder();

		for (Language language : list) {
			if (json.length() != 0) {
				json.append(",");
			}

			String str = pojoToJson(language);
			json.append(str);
		}
		return "[" + json + "]";

	}
}
