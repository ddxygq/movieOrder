package com.syyf.movieMgr.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FilterAdmin implements Filter{

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("===================���ع���Ա==================");
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = req.getSession(false);
		if(session != null){
			if(session.getAttribute("admin_name") != null){
				chain.doFilter(request, response);
				return;
			}
		}
		System.out.println("����������������������������������ת����¼���������������������������������");
		res.sendRedirect("/movieMgr/mgrLogin.jsp");
		System.out.println("����������������������������������ת����¼���������������������������������");
	}

	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("-----------------���ù���Ա����-----------------");
		
	}
}
