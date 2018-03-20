package com.syyf.movieMgr.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.syyf.movieMgr.dao.MemberMapper;
import com.syyf.movieMgr.pojo.Member;

@Service
@Transactional
public class MemberService {
	@Resource
	private MemberMapper memberMapper;
	
	public String queryPageMember(Map<String, String> pageParm){
		return JSON.toJSONString(memberMapper.queryPage(pageParm));
	}
	
	public String singleMember(String member_id){
		return JSON.toJSONString(memberMapper.single(member_id));
	}
	
	public String addMember(Member member){
		return "{\"result\":" + memberMapper.add(member) + "}";
	}
	
	public String countMember(Map<String, String> pageParm){
		return memberMapper.count(pageParm);
	}
	
	public String updateMember(Member member){
		return "{\"result\":" + memberMapper.update(member) + "}";
	}
	
	public String deleteMember(String member_id){
		return "{\"result\":" + memberMapper.delete(member_id) + "}";
	}
}
