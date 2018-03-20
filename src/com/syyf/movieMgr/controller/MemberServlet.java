package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.pojo.Member;
import com.syyf.movieMgr.service.MemberService;

public class MemberServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private MemberService memberService;
	
	public void init(){
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		memberService = context.getBean("memberService",MemberService.class);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		// ·ÖÒ³²ÎÊý
		String beginData = req.getParameter("beginData");
		String endData = req.getParameter("endData");
		Map<String, String> pageParm = new HashMap<String, String>();
		pageParm.put("beginData",beginData);
		pageParm.put("endData", endData);
		pageParm.put("member_name",req.getParameter("member_name"));
		
		String member_id = req.getParameter("member_id");
		String member_email = req.getParameter("member_email");
		String member_pwd = req.getParameter("member_pwd");
		String member_name = req.getParameter("member_name");
		String member_phone = req.getParameter("member_phone");
		String member_money = req.getParameter("member_money");
		String member_gender = req.getParameter("member_gender");
		String member_photo = req.getParameter("member_photo");
		String type = req.getParameter("type");
		
		Member member = new Member();
		member.setMember_id(member_id);
		member.setMember_email(member_email);
		member.setMember_pwd(member_pwd);
		member.setMember_name(member_name);
		member.setMember_phone(member_phone);
		member.setMember_money(member_money);
		member.setMember_gender(member_gender);
		member.setMember_photo(member_photo);
		
		String json = "";
		
		if("add".equals(type)){
			json = memberService.addMember(member);
			System.out.println(json);
		}else if("count".equals(type)){
			json = memberService.countMember(pageParm);
		}else if("single".equals(type)){
			json = memberService.singleMember(member_id);
		}else if("update".equals(type)){
			json = memberService.updateMember(member);
		}else if("delete".equals(type)){
			json = memberService.deleteMember(member_id);
		}else{
			json = memberService.queryPageMember(pageParm);
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
	
	

}
