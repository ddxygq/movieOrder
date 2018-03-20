package com.syyf.movieMgr.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syyf.movieMgr.dao.KindMapper;
import com.syyf.movieMgr.utils.KindUtils;

@Service
@Transactional
public class KindService {
	@Resource
	private KindMapper kindMapper;
	
	public String queryKind(){
		return KindUtils.listToJson(kindMapper.queryAll());
	}
}
