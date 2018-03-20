package com.syyf.movieMgr.utils;

import java.util.List;

import com.syyf.movieMgr.pojo.Admin;

public final class DataUtils {

	private DataUtils() {}
	
	/**
	 * 将实体对象转换为JSON格式字符
	 * 
	 * @param admin
	 * @return
	 */
	public static final String pojoToJson(Admin admin) {
		
		String admin_id = admin.getAdmin_id();
		String admin_name = admin.getAdmin_name();
		String admin_pwd=admin.getAdmin_pwd();
		String admin_privilege=admin.getAdmin_privilege();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"admin_id\":\"").append(admin_id).append("\",");
		json.append("\"admin_name\":\"").append(admin_name).append("\",");
		json.append("\"admin_pwd\":\"").append(admin_pwd).append("\",");
		json.append("\"admin_privilege\":\"").append(admin_privilege).append("\"}");
		
		return json.toString();
	}
	
	/**
	 * 将集合转换为JSON格式字符
	 * @param list
	 * @return
	 */
	public static final String listToJson(List<Admin> list) {
		
		StringBuilder json = new StringBuilder();
		
		for(Admin admin : list) {
			if(json.length() != 0) {
				json.append(",");
			}
			
			String str = pojoToJson(admin);
			json.append(str);
		}
		
		return "[" + json + "]";
	}
}