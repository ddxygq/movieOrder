<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加影片</title>
		<style type="text/css">
			fieldset{
				width:30%;
				float:left;
			}
		</style>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript">
			var img_path = "images/uploadMovie";
			var movie_img_path = '';
			
			$(function() {
			
				<!-- 添加新语言 -->
				$('#addMovie_language').click(function(){
					var par_language = {};
					par_language.language_name = $('#movie_language').val();
					par_language.type = "add";
					$.ajax({
						url : "languageServlet",
						type : "post",
						data : par_language,
						success : function(data){
							var obj = $.parseJSON(data);
							if(obj.result){
								alert("添加成功！");
								location.reload();
							}
						}
					});
				});
				<!-- 添加新电影类型 -->
				<!-- 添加新电影版本 -->
				
				<!-- 动态更新电影语言 -->
				var para = {};
				para.type = "query";
				$.ajax({
					url : "languageServlet",
					type : "post",
					data : para,
					success : function(data) {
						showLanguage(data);
					}
				});
				
				<!-- 动态更新电影类型 -->
				var para2 = {};
				para2.type = "query";
				$.ajax({
					url : "kindServlet",
					type : "post",
					data : para2,
					success : function(data) {
						showKind(data);
					}
				});
				
				<!-- 动态更新电影版本 -->
				var para3 = {};
				para2.type = "query";
				$.ajax({
					url : "editionServlet",
					type : "post",
					data : para3,
					success : function(data){
						showEdition(data);
					}
				});
				
				
				$('#img_input').change(function() {
					var file = $(this).val();
					var fileName = getFileName(file);
					movie_img_path = img_path + "/" + fileName;
					$('#movie_photo').val(movie_img_path);
				});
				
				$('#addBtn').click(function(){
					var movie_name = $('#movie_name').val();
					var movie_director = $('#movie_director').val();
					var movie_actor = $('#movie_actor').val();
					var movie_info = $('#movie_info').val();
					
					<!--语言选择代码块-->
					var movie_languages = document.getElementsByName("language");
					var movie_language;
					for(var i = 0;i < movie_languages.length;i++){
						if(movie_languages[i].checked){
							movie_language = movie_languages[i].value;
						}
					}
					
					<!--类型选择代码块-->
					var movie_kind = $('#kind').val();
					
					var movie_photo = movie_img_path;
					var movie_long = $('#movie_long').val();
					var movie_date = $('#movie_date').val();
					
					<!--版本选择代码块-->
					var movie_editions = document.getElementsByName("edition");
					var movie_edition;
					for(var i = 0;i < movie_editions.length;i++){
						if(movie_editions[i].checked){
							movie_edition = movie_editions[i].value;
						}
					}
					
					var param = {};
					param.movie_name = movie_name;
					param.movie_director = movie_director;
					param.movie_actor = movie_actor;
					param.movie_info = movie_info;
					param.movie_language = movie_language;
					param.movie_kind = movie_kind;
					param.movie_photo = movie_photo;
					param.movie_long = movie_long;
					param.movie_date = movie_date;
					param.movie_edition = movie_edition;
					param.type = "add";
					$.ajax({
						url : 'movieServlet',
						type : 'post',
						data : param,
						success : function(data){
							var arr = $.parseJSON(data);
							if(arr.result){
								alert("添加电影成功！");
								location.href = "movieManage.jsp";
							}else{
								alert("添加电影失败");
							}
						}
					});
					
				});
			});
		
			<!-- 获取文件名称 -->
			function getFileName(path) {
				var pos1 = path.lastIndexOf('/');
				var pos2 = path.lastIndexOf('\\');
				var pos = Math.max(pos1, pos2);
				if (pos < 0) {
					return path;
				} else {
					return path.substring(pos + 1);
				}
			}
			
			<!-- 动态电影语言 -->
			function showLanguage(data){
				var arr = $.parseJSON(data);
				var html = [];
				html.push("电影语言：");
				for(var i = 0; i < arr.length;i ++){
					html.push("<input type=\"radio\" value=\"" + arr[i].language_id + "\" name=\"language\">" + arr[i].language_name);
				}
				var languageDiv = document.getElementById("languageDiv");
				languageDiv.innerHTML = html.join("");
			}
			
			<!-- 动态电影类型 -->
			function showKind(data){
				var arr = $.parseJSON(data);
				var html = [];
				html.push("电影类型：");
				html.push("<select id=\"kind\" name=\"kind\"");
				for(var i = 0;i < arr.length;i++){
					html.push("<option value=\"" + arr[i].kind_id+"\">" + arr[i].kind_name + "</option>")
				}
				html.push("</select></br>");
				var kindDiv = document.getElementById("kindDiv");
				kindDiv.innerHTML = html.join("");
			}
			
			<!-- 动态电影版本 -->
			function showEdition(data){
				var arr = $.parseJSON(data);
				var html = [];
				html.push("电影版本：");
				for(var i = 0; i < arr.length;i ++){
					html.push("<input type=\"radio\" value=\"" + arr[i].edition_id + "\" name=\"edition\">" + arr[i].edition_name);
				}
				var editionDiv = document.getElementById("editionDiv");
				editionDiv.innerHTML = html.join("");
			}
			
			
			<!-- 隐藏 -->
			function addLanguageHide(){
				$('#addLanguage').hide();
			}
			function addLanguageShow(){
				$('#addLanguage').show(1000);
			}
			
			function addKindHide(){
				$('#addKind').hide(1000);
			}
			function addKindShow(){
				$('#addKind').show(1000);
			}
			
			function addEditionHide(){
				$('#addEdition').hide(1000);
			}
			function addEditionShow(){
				$('#addEdition').show(1000);
			}
		</script>
	</head>
	<body>
		<fieldset id="addLanguage">
			<legend>添加新电影语言</legend>
			新电影语言：<input type="text" id="movie_language"><br><br>
			<input type="button" value="添加新电影语言" style="float:right;" id="addMovie_language"><br>
			<a href="javascript:void(0);" onclick="addLanguageHide()">隐藏起来</a>
		</fieldset>
		<fieldset id="addKind">
			<legend>添加新电影类型</legend>
			新电影类型：<input type="text" id="movie_kind"><br><br>
			<input type="button" value="添加新电影类型" style="float:right;"><br>
			<a href="javascript:void(0);" onclick="addKindHide()">隐藏起来</a>
		</fieldset>
		<fieldset id="addEdition">
			<legend>添加新电影版本</legend>
			新电影版本：<input type="text" id="movie_edition"><br><br>
			<input type="button" value="添加新电影版本" style="float:right;"><br>
			<a href="javascript:void(0);" onclick="addEditionHide()">隐藏起来</a>
		</fieldset>
		
		<fieldset>
			<legend>新片录入</legend>
			<a href="javascript:void(0);" onclick="addLanguageShow()">添加新电影语言</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="addKindShow()">添加新电影类型</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="addEditionShow()">添加新电影版本</a><br>
			电影片名：<input type="text" id="movie_name"><br>
			电影导演：<input type="text" id="movie_director"><br>
			电影演员：<input type="text" id="movie_actor">
			
			<!-- 电影语言 -->
			<div id="languageDiv"></div>
			
			<!-- 电影类型 -->
			<div id="kindDiv"></div>
			
			上传图片：<input type="text" id="movie_photo" size="35"><input type="file" value="浏览照片" id="img_input"><br>
			电影片长：<input type="text" id="movie_long">&nbsp;分钟<br>
			
			<!-- 电影版本 -->
			<div id="editionDiv"></div>
			
			电影信息：<textarea id="movie_info" rows="10" cols="100"></textarea><br>
			上映时间：<input type="text" id="movie_date"><br>
			<input type="button" id="addBtn" value="提交录入" style="float:right;">
		</fieldset>
	</body>
</html>