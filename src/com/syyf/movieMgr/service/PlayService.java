package com.syyf.movieMgr.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.syyf.movieMgr.dao.PlayMapper;
import com.syyf.movieMgr.pojo.Play;
import com.syyf.movieMgr.utils.PlayUtils;

@Service
@Transactional
public class PlayService {
	
	@Resource
	private PlayMapper playMapper;
	
	public String countPlay(Map<String,Object> map){
		return playMapper.count(map);
	}
	
	public String queryBetweenPlay(Map<String,Object> map){
		return PlayUtils.listMapToJson(playMapper.queryBetween(map));
	}
	
	public String selectMoviePlay(){
		return PlayUtils.listMapToJson(playMapper.selectMovie());
	}
	
	public String addPlay(Play play){
		return "{\"result\":\"" + playMapper.add(play) +"\"}";
	}
	
	public String singlePlayInfo(String movie_id){
		return PlayUtils.listMapToJson(playMapper.singlePlay(movie_id));
	}
	
	public String singlePlay(String play_id){
		return JSON.toJSONString(playMapper.single(play_id));
	}
	
	public String updatePlay(Play play){
		return "{\"result\":" + playMapper.update(play) + "}";
	}
	
	public String deletePlay(String play_id){
		return "{\"result\":" + playMapper.delete(play_id) + "}";
	}
}
