package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.pojo.Admin;
import com.syyf.movieMgr.service.AdminService;


public class AdminServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private AdminService adminService;

	public void init() {
		
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		adminService = context.getBean("adminService", AdminService.class);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		String encoding = this.getInitParameter("encoding");
		
		req.setCharacterEncoding(encoding);
		
		String code = req.getParameter("captcha");
		// 验证码
		String captcha = (String)req.getSession().getAttribute("captcha");
		boolean flag=false;
		if(captcha !=null && code !=null){
			flag=code.equals(captcha);
			
		}
		
		String admin_id = req.getParameter("admin_id");
		String admin_name = req.getParameter("admin_name");
		String admin_pwd = req.getParameter("admin_pwd");
		String admin_privilege = req.getParameter("admin_privilege");
		
		Admin admin = new Admin();
		admin.setAdmin_id(admin_id);
		admin.setAdmin_name(admin_name);
		admin.setAdmin_pwd(admin_pwd);
		admin.setAdmin_privilege(admin_privilege);
		boolean flag2=false ;
		if(admin !=null){
			
			flag2 = adminService.querySingle(admin);
			
		}
		
		HttpSession session = req.getSession();
		String json = "";
		if(flag && flag2){
			json= "{\"result\":" + flag + "}";
			session.setAttribute("isLogin", true);
			session.setAttribute("admin_name", admin_name);
		}else{
			flag=false;
			json= "{\"result\":" + flag + "}";
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
		
		
		
	}
}