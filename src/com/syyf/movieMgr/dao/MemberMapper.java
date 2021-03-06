package com.syyf.movieMgr.dao;

import java.util.List;
import java.util.Map;

import com.syyf.movieMgr.pojo.Member;

public interface MemberMapper {
	String count(Map<String, String> pageParm);
	
	List<Member> queryPage(Map<String, String> pageParm);
	
	boolean add(Member member);
	
	Member single(String member_id);
	
	boolean update(Member member);
	
	boolean delete(String member_id);
}
