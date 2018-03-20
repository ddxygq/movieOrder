package com.syyf.movieMgr.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.syyf.movieMgr.dao.CAdminMapper;
import com.syyf.movieMgr.pojo.Admin;
import com.syyf.movieMgr.utils.jdbc.DataUtils;


@Service("am")
@Transactional
public class CAdminService {

	@Resource
	private CAdminMapper cadminMapper;

	public String addAdmin(Admin admin) {
		
		 boolean flag = cadminMapper.add(admin);
		 return "{\"result\" : " + flag + "}";
	}
	
	public String deleteAdmin(String admin_id) {
		
		 boolean flag = cadminMapper.delete(admin_id);
		 return "{\"result\" : " + flag + "}";
	}
	
	public String updateAdmin(Admin admin) {
		
		 boolean flag = cadminMapper.update(admin);
		 return "{\"result\" : " + flag + "}";
	}
	
	@Transactional(readOnly=true)
	public String querySingle(String admin_id) {
		
		Admin admin = cadminMapper.querySingle(admin_id);
		return DataUtils.pojoToJson(admin);
	}
	
	@Transactional(readOnly=true)
	public String queryAll() {
		List<Admin> list = cadminMapper.queryAll();
		return JSON.toJSONString(list);
	}
}