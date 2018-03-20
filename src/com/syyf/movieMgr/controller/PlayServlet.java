package com.syyf.movieMgr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.syyf.movieMgr.pojo.Play;
import com.syyf.movieMgr.service.MovieService;
import com.syyf.movieMgr.service.PlayService;

public class PlayServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private PlayService playService;
	//private MovieService movieService;
	
	public void init(){
		String springLocation = this.getServletContext().getInitParameter("springLocation");
		ApplicationContext context = new ClassPathXmlApplicationContext(springLocation);
		playService = context.getBean("playService",PlayService.class);
		//movieService = context.getBean("movieService",MovieService.class);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		// 获取电影id
		String movie_id = req.getParameter("movie_id");
		
		String play_id = req.getParameter("play_id");
		String play_movie = req.getParameter("play_movie");
		String play_time = req.getParameter("play_time");
		String play_price = req.getParameter("play_price");
		
		String playStart = req.getParameter("playStart");
		String playEnd = req.getParameter("playEnd");
		String beginData = req.getParameter("beginData");
		String endData = req.getParameter("endData");
		String type = req.getParameter("type");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("playStart", playStart);
		map.put("playEnd", playEnd);
		map.put("beginData", beginData);
		map.put("endData", endData);
		
		Play play = new Play();
		play.setPlay_id(play_id);;
		play.setPlay_movie(play_movie);
		play.setPlay_time(play_time);
		play.setPlay_price(play_price);
		
		String json = "";
		
		if("add".equals(type)){
			json = playService.addPlay(play);
		}else if("selectMovie".equals(type)){
			json = playService.selectMoviePlay();
		}else if("single".equals(type)){
			json = playService.singlePlay(play_id);
		}else if("moviePlayInfo".equals(type)){
			json = playService.singlePlayInfo(movie_id);
		}else if("update".equals(type)){
			json = playService.updatePlay(play);
		}else if("delete".equals(type)){
			json = playService.deletePlay(play_id);
		}else if("count".equals(type)){
			json = playService.countPlay(map);
		}else{
			json = playService.queryBetweenPlay(map);
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}
	
	

}
