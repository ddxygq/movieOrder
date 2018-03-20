package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.pojo.Admin;
import com.syyf.movieMgr.service.CAdminService;

public class CAdminServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private CAdminService cAdminService;

	public void init() {
		
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		cAdminService = context.getBean("am", CAdminService.class);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		/*String encoding = this.getInitParameter("encoding");
		
		req.setCharacterEncoding(encoding);*/
		
		String admin_id = req.getParameter("admin_id");
		String admin_name = req.getParameter("admin_name");
		String admin_pwd = req.getParameter("admin_pwd");
		String admin_privilege = req.getParameter("admin_privilege");
		String type = req.getParameter("type");
		
		Admin admin = new Admin();
		admin.setAdmin_id(admin_id);
		admin.setAdmin_name(admin_name);
		admin.setAdmin_pwd(admin_pwd);
		admin.setAdmin_privilege(admin_privilege);
		
		System.out.println(admin_id);
		
		String json = "";
		
		if("add".equals(type)) {
			json = cAdminService.addAdmin(admin);
		} else if("update".equals(type)) {
			json = cAdminService.updateAdmin(admin);
		} else if("single".equals(type)) {
			json = cAdminService.querySingle(admin_id);
		} else if("delete".equals(type)) {
			json = cAdminService.deleteAdmin(admin_id);
		} else {
			json = cAdminService.queryAll();
		}
		System.out.println(json);
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
}