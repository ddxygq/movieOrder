package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.service.TicketService;

public class TicketServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private TicketService ticketService;

	public void init() {
		
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		ticketService = context.getBean("ticketService", TicketService.class);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		String encoding = this.getInitParameter("encoding");
		
		/*req.setCharacterEncoding(encoding);*/
		
		String ticket_code = req.getParameter("ticket_code");
	
		String json = "";
				
		json = ticketService.queryTicket(ticket_code);
	
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
}