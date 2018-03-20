<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <base href="<%=basePath%>">
    <style type="text/css">
    	a{text-decoration:none;}
		a:hover{text-decoration:underline;}
    	td{
    		white-space:rowrap;
    		text-align:center;
    	}
	</style>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript">
    	var pageSize = 3;
    	var curPage = 1; // 显示第curPage页
    	var len; // 每次查询数据的总行数
    	var page //总页数
    	var beginData = 1; // 起始
    	var endData = pageSize; // 结束
    	
    	var param = {};
    	param.beginData = beginData;
    	param.endData = endData;
    	
    	$(function(){
    		$('#lastPage').attr("disabled",true);
    		$('#nextPage').attr("disabled",false);
    		
    		//点击查询按钮
    		$('#btnSelect').click(function(){
    			movie_name = $('#movie_name').val();
    			param.movie_name = movie_name;
    			showPage();
    		});
    		
    		// 下一页
    		$('#nextPage').click(function(){
    			if(curPage < page){
    				curPage = curPage + 1;
    			}else{
    				alert("已是最后一页");
    				return;
    			}
    			param.beginData = (curPage - 1) * pageSize + 1;
    			param.endData = curPage * pageSize;
    			showPage();
    			pageIfExist();
    			$('#lastPage').attr("disabled",false);
    		});
    			
    		// 上一页
    		$('#lastPage').click(function(){
    			if(curPage > 1){
    				curPage = curPage - 1;
    			}else{
    				alert("已经是第一页");
    				return;
    			}
    			param.beginData = (curPage - 1) * pageSize + 1;
    			param.endData = curPage * pageSize;
    			showPage();
    			pageIfExist();
    			$('#nextPage').attr("disabled",false);
    		});
    		
    		// 固定到某一页
    		$('#nPage').click(function(){
    			var nPage = parseInt(document.getElementById("curPage").value);
    			if(nPage > page || nPage < 1){
    				alert("该页不存在");
    			}else{
    				curPage = nPage;
    			}
    			param.beginData = (curPage - 1) * pageSize + 1;
    			param.endData = curPage * pageSize;
    			showPage();
    			pageIfExist();
    		});
    		
    	});
    	
    	function showPage(){
    		param.type = 'count';
    		pageCount();
    		param.type = '';
    		$.ajax({
    			url : "movieServlet",
    			type : "post",
    			data : param,
    			success : function(data){
    				data = $.parseJSON(data);
    				if(data.length < 1){
    					alert("没有查询到相关影片，推荐相关影片如下");
    					param.movie_name = '';
    					showPage();
    				}
    				showData(data);
    				if(len > pageSize){
    					$('#nextPage').attr('disabled' ,false);
    				}
    				
    				//分页
    				page = len % pageSize == 0 ? len / pageSize : Math.floor(len / pageSize) + 1;
    				$('#page').val(page);
    				$('#curPage').val(curPage);
    				pageIfExist();
    			},
    			error : function(){
    				alert("未加载到数据");
    			}
    		});
    	}
    	
    	// 用于判断是否是第一页 / 最后一页
    	function pageIfExist(){
    		if(curPage <= 1){
    			$('#lastPage').attr("disabled",true);
    		}
    		if(curPage >= page){
    			$('#nextPage').attr("disabled",true);
    		}
    	}
    	
    	function showData(arr){
    		var html = [];
    		html.push("<table border='1px outset'>");
    		html.push("<tr><th>电影片名</th><th>电影导演</th><th>电影演员</th><th>电影语言</th><th>电影类型</th><th>电影片长</th><th>电影版本</th><th>电影信息</th><th>上映时间</th><th></th>操作</tr>");
    		for(var i = 0;i < arr.length;i++){
    			html.push("<td>" + arr[i].MOVIE_NAME + "</td>");
    			html.push("<td>" + arr[i].MOVIE_DIRECTOR + "</td>");
    			html.push("<td>" + arr[i].MOVIE_ACTOR + "</td>");
    			html.push("<td>" + arr[i].LANGUAGE_NAME + "</td>");
    			html.push("<td>" + arr[i].KIND_NAME + "</td>");
    			html.push("<td>" + arr[i].MOVIE_LONG + "</td>");
    			html.push("<td>" + arr[i].EDITION_NAME + "</td>");
    			html.push("<td>" + ${fn:substring(arr[i].MOVIE_INFO,0,15)} + "..." + "</td>");
    			html.push("<td>" + arr[i].MOVIE_DATE + "</td>");
    			html.push("<td><a href='managePages/moviePages/updateMovie.jsp?movie_id=" + arr[i].MOVIE_ID +"'>修改</a></td>");
    			html.push("<td><a href='javascript:void(0);' onclick='deleteMovie(" + arr[i].MOVIE_ID +")'>删除</a></td>");
    			html.push("</tr>");
    		}
    		html.push("</table>");
    		var movie_show = document.getElementById("movie_show");
    		movie_show.innerHTML = html.join("");
    	}
    	
    	
    	
    	// 总页数
    	function pageCount(){
    		$.ajax({
    			url : 'movieServlet',
    			type : 'post',
    			data : param,
    			success : function(data){
    				len = parseInt(data);
    			}
    		});
    	}
    	
    	function deleteMovie(movie_id){
    		if(window.confirm("确定删除吗？")){
    			$.ajax({
    				url : 'movieServlet',
    				type : "post",
    				data : "type=delete&movie_id=" + movie_id,
    				success : function(data) {
    					var obj = $.parseJSON(data);
    					if (obj.result) {
    						alert("删除成功！");
    					} else {
    						alert("删除失败！");
    					}
    				}
    			});
    		}
    		
    	}
    </script>
  </head>
  <body>
  	<fieldset>
  		<legend>影片管理</legend>
  		<br><a href='addMovie.jsp'>影片录入</a><hr>
  		影片名：<input type="text" id="movie_name"><br>
  		<input type="button" id="btnSelect" value="搜索"><br>
  		<div id="movie_show"></div>
  	</fieldset><br>
  	<input type="button" id="lastPage" value="上一页">&nbsp;&nbsp;
  	第<input type="text" id="curPage" size='3'>页
  	<input type="button" id="nPage" value="确定">
  	<input type="button" id="nextPage" value="下一页">&nbsp;&nbsp;
  	共<input type="text" id="page" readonly="readonly" size="3">页
  	
  </body>
</html>