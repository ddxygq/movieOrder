package com.syyf.movieMgr.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syyf.movieMgr.dao.LanguageMapper;
import com.syyf.movieMgr.pojo.Language;
import com.syyf.movieMgr.utils.LanguageUtils;

@Service
@Transactional
public class LanguageService {
	
	@Resource
	private LanguageMapper languageMapper;
	
	public String queryLanguage(){
		return LanguageUtils.listToJson(languageMapper.queryAll());
	}
	
	public String addLanguage(Language language){
		boolean flag = languageMapper.add(language);
		return "{\"result\":" + flag + "}";
	}
}
