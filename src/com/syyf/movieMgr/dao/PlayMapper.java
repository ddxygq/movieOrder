package com.syyf.movieMgr.dao;

import java.util.List;
import java.util.Map;

import com.syyf.movieMgr.pojo.Play;

public interface PlayMapper {
	String count(Map<String,Object> map);
	
	List<Map<String, String>> queryBetween(Map<String,Object> map);
	
	List<Map<String,String>> selectMovie();
	
	boolean add(Play play);
	
	List<Map<String,String>> singlePlay(String movie_id);
	
	Play single(String play_id);
	
	boolean update(Play play);
	
	boolean delete(String play_id);
}
