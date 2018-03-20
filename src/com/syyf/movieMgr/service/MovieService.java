package com.syyf.movieMgr.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.syyf.movieMgr.dao.MovieMapper;
import com.syyf.movieMgr.pojo.Movie;
import com.syyf.movieMgr.utils.MovieUtils;
import com.syyf.movieMgr.utils.PlayUtils;

@Service
@Transactional
public class MovieService {
	
	@Resource
	private MovieMapper movieMapper;
	
	// ģ����ѯ
	public String queryLikeMovie(Map<String, String> pageParm){
		return JSON.toJSONString(movieMapper.queryLike(pageParm));
	}
	
	//������ѯ
	public String querySingleMovie(Movie movie){
		return MovieUtils.pojoToJson(movieMapper.querySingle(movie));
	}
	
	//��ѯһ���ֶ�
	public String distinctMovie_name(){
		
		String str = PlayUtils.list2Json(movieMapper.distinct());
		return "{\"result\":" + str + "}";
	}
	
	// ���
	public String addMovie(Movie movie){
		boolean flag = movieMapper.add(movie);
		return "{\"result\":" + flag + "}";
	}
	
	// �޸�
	public String updateMovie(Movie movie){
		boolean flag = movieMapper.update(movie);
		return "{\"result\":" + flag + "}";
	}
	
	// ɾ��
	public String deleteMovie(Movie movie){
		boolean flag = movieMapper.delete(movie);
		return "{\"result\":" + flag + "}";
	}
	
	// ������
	public String countMovie(Map<String, String> pageParm){
		return movieMapper.count(pageParm);
	}

}
