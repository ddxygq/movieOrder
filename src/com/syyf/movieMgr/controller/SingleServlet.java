package com.syyf.movieMgr.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SingleServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		
		req.setCharacterEncoding("utf-8");
		
		String name = req.getParameter("name");
		
		HttpSession session = req.getSession();
		String loginName = (String)session.getAttribute("loginName");
		
		if(name != null) {
			loginName = name;
		}

		session.setAttribute("loginName", loginName);

		res.sendRedirect("manageadmin.jsp");
	}
}