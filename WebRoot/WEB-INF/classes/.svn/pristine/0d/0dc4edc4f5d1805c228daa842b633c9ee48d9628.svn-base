package com.syyf.movieMgr.utils;

import java.util.List;

import com.syyf.movieMgr.pojo.Movie;


public final class MovieUtils {

	private MovieUtils() {}
	
	/**
	 * 将实体对象转换为JSON格式字符串
	 * 
	 * @param movie
	 * @return
	 */
	public static final String pojoToJson(Movie movie) {
		
		String movie_id = movie.getMovie_id();
		String movie_name = movie.getMovie_name();
		String movie_director = movie.getMovie_director();
		String movie_actor = movie.getMovie_actor();
		String movie_info = movie.getMovie_info();
		String movie_language = movie.getMovie_language();
		String movie_kind = movie.getMovie_kind();
		String movie_photo = movie.getMovie_photo();
		String movie_long = movie.getMovie_long();
		String movie_date = movie.getMovie_date();
		String movie_edition = movie.getMovie_edition();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"movie_id\":\"").append(movie_id).append("\",");
		json.append("\"movie_name\":\"").append(movie_name).append("\",");
		json.append("\"movie_director\":\"").append(movie_director).append("\",");
		json.append("\"movie_actor\":\"").append(movie_actor).append("\",");
		json.append("\"movie_info\":\"").append(movie_info).append("\",");
		json.append("\"movie_language\":\"").append(movie_language).append("\",");
		json.append("\"movie_kind\":\"").append(movie_kind).append("\",");
		json.append("\"movie_photo\":\"").append(movie_photo).append("\",");
		json.append("\"movie_long\":\"").append(movie_long).append("\",");
		json.append("\"movie_date\":\"").append(movie_date).append("\",");
		json.append("\"movie_edition\":\"").append(movie_edition).append("\"}");
		
		return json.toString();
	}
	
	/**
	 * 将集合转换为JSON格式字符串
	 * 如:[{"shopId":"1","shopName":"陶慧化妆品","shopAddress":"上海路23号","contact":"15923670909"},
	 * {"shopId":"2","shopName":"领先一步干果店","shopAddress":"江汉路万达广场B座","contact":"13927098123"}]
	 * @param list
	 * @return
	 */
	public static final String listToJson(List<Movie> list) {
		
		StringBuilder json = new StringBuilder();
		
		for(Movie movie : list) {
			if(json.length() != 0) {
				json.append(",");
			}
			
			String str = pojoToJson(movie);
			json.append(str);
		}
		return "[" + json + "]";
		
	}
}