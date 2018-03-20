package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.pojo.Kind;
import com.syyf.movieMgr.service.KindService;
import com.syyf.movieMgr.service.LanguageService;

public class KindServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private KindService kindService;
	
	public void init(){
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		kindService = context.getBean("kindService",KindService.class);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String kind_id = req.getParameter("kind_id");
		String kind_name = req.getParameter("kind_name");
		String type = req.getParameter("type");
		
		Kind kind = new Kind();
		kind.setKind_id(kind_id);
		kind.setKind_name(kind_name);
		
		String json = "";
		
		if("add".equals(type)){
			
		}else{
			json = kindService.queryKind();
		}

		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
	
}
