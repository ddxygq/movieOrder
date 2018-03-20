<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<base href="<%=basePath%>">
		<title>场次录入</title>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript">
			$(function(){
				var param = {};
				param.type = "selectMovie";
				$.ajax({
					url : "playServlet",
					type : 'post',
					data : param,
					success : function(data){
						data = $.parseJSON(data);
						selectMovieDiv(data);
					}
				});
				
				$('#sureAdd').click(function(){
					var play_movie = $('#play_movie').val()
					var play_time = $('#play_time').val();
					var play_price = $('#play_price').val();
					var param = {};
					param.play_movie = play_movie;
					param.play_time = play_time;
					param.play_price = play_price;
					param.type = "add";
					
					$.ajax({
						url : 'playServlet',
						type : 'post',
						data : param,
						success : function(data){
							data = $.parseJSON(data);
							if(data.result){
								alert("添加场次成功");
								window.onload();
							}else{
								alert("添加场次失败");
							}
						}
					});
				});
			});
			
			<!-- 显示要添加场次的所有电影 -->
			function selectMovieDiv(data){
				var html = [];
				html.push("选择影片：");
				html.push("<select id=\"play_movie\"");
				html.push("<option value=''>--请选择场次--</option>");
				for(var i = 0;i < data.length;i++){
					var str = data[i].MOVIE_NAME + "--" + data[i].EDITION_NAME + "--" + data[i].LANGUAGE_NAME + "--" + data[i].KIND_NAME;
					html.push("<option value='" + data[i].MOVIE_ID + "'>" + str + "</option>");
				}
				html.push("</select>");
				var selectMovieDiv = document.getElementById("selectMovieDiv");
				selectMovieDiv.innerHTML = html.join("");
			}
		</script>
	</head>
	<body>
		<fieldset>
			<legend>场次管理</legend>
			<div id="selectMovieDiv"></div><br>
			添加场次：<input type="text" id="play_time"><br><br>
			票&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：<input type="text" id="play_price">&nbsp;元<br><br>
			<input type="button" value="确认添加" id="sureAdd">
		</fieldset>
	</body>
</html>