<%@ page pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>修改电影</title>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript">
			$(function(){
			
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
				
				<!-- 显示当前影片信息 -->
				var movie_id = '${param.movie_id}';
				$.ajax({
					url : 'movieServlet',
					type : 'post',
					data : "type=single&movie_id=" + movie_id,
					success : function(data){
						var obj = $.parseJSON(data);
						$('#movie_name').val(obj.movie_name);
						$('#movie_director').val(obj.movie_director);
						$('#movie_actor').val(obj.movie_actor);
						$('#movie_info').val(obj.movie_info);
						
						<!--语言选择-->
						$('input[name=language][value=' + obj.movie_language + ']').prop('checked',true);

						<!--类型选择-->
						$('#kind option[value=' + obj.movie_kind + ']').prop('selected',true);
						
						$('#movie_photo').val(obj.movie_photo);
						$('#movie_long').val(obj.movie_long);
						$('#movie_date').val(obj.movie_date);
						
						<!--版本选择-->
						$('input[name=edition][value=' + obj.movie_edition + ']').prop("checked",true);
					}
				});
				
				<!-- 保存修改 -->
				$('#updateBtn').click(function(){
					var movie_name = $('#movie_name').val();
					var movie_director = $('#movie_director').val();
					var movie_actor = $('#movie_actor').val();
					var movie_info = $('#movie_info').val();
					var movie_language = $('input[name=language]:checked').val();
					var movie_kind = $('#kind option:selected').val();
					var movie_photo = $('#movie_photo').val();
					var movie_long = $('#movie_long').val();
					var movie_date = $('#movie_date').val();
					var movie_edition = $('input[name=edition]:checked').val();
					
					var param = {};
					param.movie_id = movie_id;
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
					param.type = "update";
					<!-- 执行修改 -->
					$.ajax({
						url : "movieServlet",
						type : "post",
						data : param,
						success : function(data){
							var obj = $.parseJSON(data);
							if(obj.result){
								alert("修改成功！");
								location.href = "managePages/moviePages/movieManage.jsp";
							}else{
								alert("修改失败！");
								window.onload();
							}
						}
						
					});
				});
				
			});
			
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
			
			
		</script>
	</head>
	
	<body>
		<fieldset>
			<legend>影片及场次管理</legend>
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
			
			电影信息：<br><textarea id="movie_info" rows="10" cols="100"></textarea><br>
			上映时间：<input type="text" id="movie_date"><br>
			<input type="button" id="updateBtn" value="保存修改" style="float:right;">
		</fieldset>
	</body>
</html>