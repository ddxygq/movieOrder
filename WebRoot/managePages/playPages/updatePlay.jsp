<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>更新场次</title>
    	<style type="text/css">
    		#playInfo{width:75%;height:400px;float:left;}
    		#playInfo2{width:25%;height:400px;float:left;}
    		#playInfo2 img {margin-top:10%;margin-left:20%;}
			a{text-decoration:none;}
			a:hover{text-decoration:underline;}
			#aStyle{width:100%;text-align:center;}
    	</style>
    	<script type="text/javascript" src="js/jquery.min.js"></script>
    	<script type="text/javascript">
    		var movie_id = '${param.movie_id}';
    		var play_id = '${param.play_id}';
    		
    		<!-- 记录原始值，点击按钮，没有修改就不用执行修改操作 -->
    		var original_play_time;
    		var original_play_price;
    		$(function(){
    			var param = {};
    			param.movie_id = movie_id;
    			param.play_id = play_id;
    			param.type = 'moviePlayInfo';
    			$.ajax({
    				url : 'playServlet',
    				type : 'post',
    				data : param,
    				success : function(data){
    					showPlayInfo(data);
    				}
    			});
    			
    			<!-- 显示当前场次信息 -->
    			param.type = "single";
    			$.ajax({
    				url : 'playServlet',
    				type : 'post',
    				data : param,
    				success : function(data){
    					data = $.parseJSON(data);
    					original_play_time = data.play_time;
    					original_play_price = data.play_price;
    					$('#play_time').val(data.play_time);
    					$('#play_price').val(data.play_price);
    				}
    			});
    			
    			$('#sureUpdate').click(function(){
    				var play_time = $('#play_time').val();
    				var play_price = $('#play_price').val();
    				if((original_play_time == play_time) && (original_play_price == play_price)){
    					alert("你没做任何修改！");
    				}else{
    					param.play_time = play_time;
    					param.play_price = play_price;
    					param.type = "update";
    					$.ajax({
    						url : 'playServlet',
    						type : 'post',
    						data : param,
    						success : function(data){
    							data = $.parseJSON(data);
    							if(data.result){
    								alert("修改成功！");
    								window.onload();
    							}else{
    								alert("修改成功！");
    							}
    						}
    					});
    				}
    			});
    			
    		});
    		
    		<!-- 显示当前场次电影信息 -->
    		function showPlayInfo(data){
    			var arr = $.parseJSON(data)[0];
    			html = [];
    			html.push("<div id='playInfo'>");
    			html.push("<b>电影片名</b>：" + arr.MOVIE_NAME + "<br>");
    			html.push("<b>电影导演</b>：" + arr.MOVIE_DIRECTOR + "<br>");
    			html.push("<b>电影演员</b>：" + arr.MOVIE_ACTOR + "<br>");
    			html.push("<b>电影语言</b>：" + arr.LANGUAGE_NAME + "<br>");
    			html.push("<b>电影类型</b>：" + arr.KIND_NAME + "<br>");
    			html.push("<b>电影片长</b>：" + arr.MOVIE_LONG + "<br>");
    			html.push("<b>电影版本</b>：" + arr.EDITION_NAME + "<br>");
    			html.push("<b>上映时间</b>：" + arr.MOVIE_DATE + "<br>");
    			html.push("<b>电影信息</b>：" + arr.MOVIE_INFO + "<br>");
    			html.push("</div>");
    			
    			html.push("<div id='playInfo2'>");
    			html.push("<div id='aStyle'>");
    			html.push("<a href='managePages/moviePages/updateMovie.jsp?movie_id=" + movie_id +"'>修改影片</a>");
    			html.push("</div>");
    			html.push("<img src='" + arr.MOVIE_PHOTO + "'>");
    			html.push("</div>");
    			var movieDiv = document.getElementById("movieDiv");
    			movieDiv.innerHTML = html.join();
    		}
    		
    	</script>
	</head>
  	<body>
  		<fieldset>
  			<legend>修改场次</legend>
  			<fieldset>
  				<legend>影片信息</legend>
  				<div id="movieDiv"></div>
  			</fieldset>
  			<hr>
  			<div id="playDiv"></div>
  			添加场次：<input type="text" id="play_time"><br>
  			票&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：<input type="text" id="play_price">&nbsp;元<br>
  			<input type="button" id="sureUpdate" value="确认修改">
  		</fieldset>
  		
  	</body>
</html>