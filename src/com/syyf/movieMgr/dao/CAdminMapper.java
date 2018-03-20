package com.syyf.movieMgr.dao;

import java.util.List;

import com.syyf.movieMgr.pojo.Admin;

public interface CAdminMapper {

	boolean add(Admin admin);
	
	boolean delete(String admin_id);
	
	boolean update(Admin admin);

	Admin querySingle(String admin_id);
	
	List<Admin> queryAll();
}