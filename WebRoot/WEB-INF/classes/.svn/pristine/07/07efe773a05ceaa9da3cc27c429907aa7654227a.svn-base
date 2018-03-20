package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.pojo.Language;
import com.syyf.movieMgr.service.LanguageService;

public class LanguageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private LanguageService languageService;
	
	public void init(){
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		languageService = context.getBean("languageService",LanguageService.class);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String language_id = req.getParameter("language_id");
		String language_name = req.getParameter("language_name");
		String type = req.getParameter("type");
		
		Language language = new Language();
		language.setLanguage_id(language_id);
		language.setLanguage_name(language_name);
		
		String json = "";
		
		if("add".equals(type)){
			json = languageService.addLanguage(language);
		}else{
			json = languageService.queryLanguage();
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
	
	
	
}
