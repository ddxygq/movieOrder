package com.syyf.movieMgr.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syyf.movieMgr.dao.EditionMapper;
import com.syyf.movieMgr.utils.EditionUtils;

@Service
@Transactional
public class EditionService {
	@Resource
	private EditionMapper editionMapper;
	
	public String queryEdition(){
		return EditionUtils.listToJson(editionMapper.queryAll());
	}
}
