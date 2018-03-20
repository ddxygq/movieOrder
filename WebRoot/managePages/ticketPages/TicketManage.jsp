<%@ page pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html;" />
		<script type="text/javascript" src="js/jquery.min.js"></script>
		
		<script type="text/javascript">
			$(function()
			{
			
				$("#btnSelect").click(function()
				{
					var ticket_code = $("#ticket_code").val();
					var param = {};
					param.ticket_code=ticket_code;
					// jQuery的ajax(异步)方式处理请求
					$.ajax({
						url : "ticketServlet",
						type : "post",
						data : param,
						success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
						{
							showData(data);	
						},
						error : function() // 执行失败后的回调函数
						{
							alert("未加载到数据");
						}
					});
				});
			});
			function showData(json) {
				var arr = $.parseJSON(json);
				var html = [];
				html.push("<table border='1' align='center' width='800' cellspacing='0'>");
		
				html.push("<tr><th>用户名</th><th>用户邮箱</th><th>订票时间</th><th>已订票</th><th>座位</th><th>电影</th><th>场次时间</th><th>票价</th></tr>");
				for (var i = 0; i < arr.length; i++) {
					html.push("<tr>");
					html.push("<td>" + arr[i].MEMBER_NAME + "</td>");
					html.push("<td>" + arr[i].MEMBER_EMAIL + "</td>");
					html.push("<td>" + arr[i].TICKET_DATE + "</td>");
					html.push("<td>" + arr[i].TICKET_FLAG + "</td>");
					html.push("<td>" + arr[i].TICKET_SEAT + "</td>");
					html.push("<td>" + arr[i].MOVIE_NAME + (arr[i].edition_name) + arr[i].language_name + "</td>");
					html.push("<td>" + arr[i].TICKET_DATE + "</td>");
					html.push("<td>" + arr[i].PLAY_PRICE + "</td>");
					html.push("</tr>");
				}
				html.push("</table>");
				html.push("</fieldset>");
		
				$("#ticketDiv").html(html.join(""));
			}
			
		</script>
	</head>
  
	<body>
 		<div style=" background-image:url(photo/l.jpg);">
	 
	 	<fieldset style='width:400px; float:center; margin: 20px 10px 10px 100px; '>
	 	<legend>票务管理</legend>
		订单号:<input type="text" id="ticket_code"/><br/><br/>		
		<input type="button" value="搜索" id="btnSelect"/>
		<div  id="ticketDiv"></div>
		</fieldset>
		
 		</div>
	</body>
</html>