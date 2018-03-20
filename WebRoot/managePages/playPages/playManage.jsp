<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>                                        
	<head>
		<base href="<%=basePath%>">
		<title>场次管理</title>
		<style>
			a{text-decoration:none;}
			a:hover{text-decoration:underline;}
		</style>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript">
			var pageSize = 2;
    		var curPage = 1; // 显示第curPage页
    		var len; // 每次查询数据的总行数
    		var page //总页数
    		var beginData = 1; // 起始
    		var endData = pageSize; // 结束
    	
    		var param = {};
    		param.beginData = beginData;
    		param.endData = endData;
			$(function() {
				$('#lastPage').attr("disabled",true);
    			$('#nextPage').attr("disabled",false);
    			
				$('#searchBtn').click(function() {
					var playStart = $('#playStart').val();
					var playEnd = $('#playEnd').val()

					param.playStart = playStart;
					param.playEnd = playEnd;
					param.type = 'count';
    				pageCount();
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
    				url : 'playServlet',
    				type : 'post',
    				data : param,
    				success : function(data) {
    					data = $.parseJSON(data);
    					if(len > pageSize){
    						$('#nextPage').attr("disabled",false);
    					}
    					showPlayData(data);
    					
    	    			// 分页
    					page = len % pageSize == 0 ? len / pageSize : Math.floor(len / pageSize) + 1;
    					$('#page').val(page);
    					$('#curPage').val(curPage);
    					pageIfExist();
    				},
    				error : function() {
    					alert("数据加载失败");
    				}
    			});
    		}
    		
    		// 总页数
    		function pageCount(){
    			$.ajax({
    				url : 'playServlet',
    				type : 'post',
    				data : param,
    				success : function(data){
    					len = parseInt(data);
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
			
			function showPlayData(arr){
				var html = [];
				html.push("<table border='1px outset'>")
				html.push("<tr><th>现有场次</th><th>电影片长</th><th>电影片名</th><th>电影语言</th><th>电影版本</th><th>上映时间</th><th>操作</th></tr>");
				for(var i = 0;i<arr.length;i++){
					html.push("<tr>");
					html.push("<td>" + arr[i].PLAY_TIME + "</td>");
					html.push("<td>" + arr[i].MOVIE_LONG + "</td>");
					html.push("<td>" + arr[i].MOVIE_NAME + "</td>");
					html.push("<td>" + arr[i].LANGUAGE_NAME + "</td>");
					html.push("<td>" + arr[i].EDITION_NAME + "</td>");
					html.push("<td>" + arr[i].MOVIE_DATE + "</td>");
					html.push("<td><a href='managePages/playPages/updatePlay.jsp?movie_id=" + arr[i].MOVIE_ID + "&play_id=" + arr[i].PLAY_ID + "'>修改场次</a></td>");
					html.push("<td><a href='javascript:void(0);' onclick='deletePlay(" + arr[i].PLAY_ID + ")'>删除场次</a></td>");
					html.push("</tr>");
				}
				html.push("<table></table>");
				var playDiv = document.getElementById("playDiv");
				playDiv.innerHTML = html.join("");
				
			}
			
			function deletePlay(play_id){
				var param = {};
				param.play_id = play_id;
				param.type = "delete";
				$.ajax({
						url : "playServlet",
						type : "post",
						data : param,
						success : function(data) {
							data = $.parseJSON(data);
							if(data.result){
								alert("删除成功！");
							}
						},
						error : function(){
							alert("删除失败");
						}
					});
			}
		</script>
	</head>
	<body>
		<fieldset>
			<legend>场次管理</legend>
			<a href="managePages/playPages/addPlay.jsp">场次录入</a>
			<hr>
			场次时间范围：<input type="text" id="playStart">&nbsp;&nbsp;至&nbsp;&nbsp;<input type="text" id="playEnd"><br><br>
			<input type="button" id="searchBtn" value="搜索"><br><br>
			<div id="playDiv"></div>
			<input type="button" id="lastPage" value="上一页">&nbsp;&nbsp;
    		第<input type="text" id="curPage" size='3'>页
    		<input type="button" id="nPage" value="确定">
    		<input type="button" id="nextPage" value="下一页">&nbsp;&nbsp;
    		共<input type="text" id="page" readonly="readonly" size="3">页
		</fieldset>
	</body>
</html>