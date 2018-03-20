package com.syyf.movieMgr.utils;

import java.util.List;

import com.syyf.movieMgr.pojo.Kind;

public class KindUtils {
	
	private KindUtils(){}
	
	public static final String pojoToJson(Kind kind) {
		String kind_id = kind.getKind_id();
		String kind_name = kind.getKind_name();
		StringBuilder json = new StringBuilder();
		json.append("{\"kind_id\":\"").append(kind_id).append("\",");
		json.append("\"kind_name\":\"").append(kind_name).append("\"}");

		return json.toString();
	}
	
	public static final String listToJson(List<Kind> list) {

		StringBuilder json = new StringBuilder();

		for (Kind kind : list) {
			if (json.length() != 0) {
				json.append(",");
			}

			String str = pojoToJson(kind);
			json.append(str);
		}
		return "[" + json + "]";

	}
}
