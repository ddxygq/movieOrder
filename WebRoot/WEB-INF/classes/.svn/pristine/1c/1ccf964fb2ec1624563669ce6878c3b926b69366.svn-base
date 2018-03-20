package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.pojo.Edition;
import com.syyf.movieMgr.service.EditionService;

public class EditionServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private EditionService editionService;
	
	public void init(){
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		editionService = context.getBean("editionService",EditionService.class);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String edition_id = req.getParameter("edition_id");
		String edition_name = req.getParameter("edition_name");
		String type = req.getParameter("type");
		
		Edition edition = new Edition();
		edition.setEdition_id(edition_id);
		edition.setEdition_name(edition_name);
		
		String json = "";
		
		if("add".equals(type)){
			
		}else{
			json = editionService.queryEdition();
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
	
}
