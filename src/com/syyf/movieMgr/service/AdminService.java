package com.syyf.movieMgr.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syyf.movieMgr.dao.AdminMapper;
import com.syyf.movieMgr.pojo.Admin;


@Service
@Transactional
public class AdminService {
	
	@Resource
	private AdminMapper adminMapper;
	
	@Transactional(readOnly=true)
	public boolean querySingle(Admin admin)  {
		
		Admin admin2 = adminMapper.querySingle(admin);
		boolean flag = admin2 != null;
		//return "{\"result\":" + flag + "}";
		return flag;
	}
	
}
