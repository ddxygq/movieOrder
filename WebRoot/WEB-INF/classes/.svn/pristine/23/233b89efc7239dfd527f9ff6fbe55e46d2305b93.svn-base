package com.syyf.movieMgr.dao;

import java.util.List;
import java.util.Map;

import com.syyf.movieMgr.pojo.Movie;

public interface MovieMapper {
	String count(Map<String, String> pageParm);
	
	List<Map<String,String>> queryLike(Map<String, String> pageParm);
	
	Movie querySingle(Movie movie);
	
	boolean add(Movie movie);
	
	boolean update(Movie movie);
	
	boolean delete(Movie movie);
	
	List<String> distinct();
}
