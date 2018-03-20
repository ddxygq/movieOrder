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

import com.syyf.movieMgr.pojo.Movie;
import com.syyf.movieMgr.service.MovieService;

public class MovieServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private MovieService movieService;
	
	public void init(){
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		movieService = context.getBean("movieService",MovieService.class);
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
		pageParm.put("movie_name",req.getParameter("movie_name"));
		
		String movie_id = req.getParameter("movie_id");
		String movie_name = req.getParameter("movie_name");
		String movie_director = req.getParameter("movie_director");
		String movie_actor = req.getParameter("movie_actor");
		String movie_info = req.getParameter("movie_info");
		String movie_language = req.getParameter("movie_language");
		String movie_kind = req.getParameter("movie_kind");
		String movie_photo = req.getParameter("movie_photo");
		String movie_long = req.getParameter("movie_long");
		String movie_date = req.getParameter("movie_date");
		String movie_edition = req.getParameter("movie_edition");
		String type = req.getParameter("type");
		
		Movie movie = new Movie();
		movie.setMovie_id(movie_id);
		movie.setMovie_name(movie_name);
		movie.setMovie_director(movie_director);
		movie.setMovie_actor(movie_actor);
		movie.setMovie_info(movie_info);
		movie.setMovie_language(movie_language);
		movie.setMovie_kind(movie_kind);
		movie.setMovie_photo(movie_photo);
		movie.setMovie_long(movie_long);
		movie.setMovie_date(movie_date);
		movie.setMovie_edition(movie_edition);
		
		String json = "";
		if("add".equals(type)){
			json = movieService.addMovie(movie);
		}else if("single".equals(type)){
			json = movieService.querySingleMovie(movie);
		}else if("update".equals(type)){
			json = movieService.updateMovie(movie);
		}else if("delete".equals(type)){
			json = movieService.deleteMovie(movie);
		}else if("count".equals(type)){
			json = movieService.countMovie(pageParm);
		}else{
			json = movieService.queryLikeMovie(pageParm);
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
	
	
}
