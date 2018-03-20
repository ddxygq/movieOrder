<%@ page   pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title> 管理员管理</title>
		<base href="<%=basePath%>">
		
		<script type="text/javascript" src="js/jquery.min.js"></script>
		
		<script type="text/javascript">
			$(function()
			{
				// jQuery的ajax(异步)方式处理请求
				$.ajax({
					url : "cAdminServlet",//指定服务器资源 
					type : "post",//请求方式
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
			
			function showData(json)
			{
				var arr = $.parseJSON(json);
				
				var html = [];			
				html.push("<table border='1' align='center' width='600' cellspacing='0'>");
				html.push("<tr><th>管理员ID</th><th>管理员登录名</th><th>管理员密码</th><th>管理权限</th><th>操作</th></tr>");
				for(var i=0; i<arr.length; i++)
				{
					html.push("<tr>");
					html.push("<td>" + arr[i].admin_id + "</td>");
					html.push("<td>" + arr[i].admin_name + "</td>");
					html.push("<td>" + arr[i].admin_pwd + "</td>");
					html.push("<td>" + arr[i].admin_privilege + "</td>");
					html.push("<td><a href='managePages/adminPages/updateAdmin.jsp?admin_id=" + arr[i].admin_id + "'>修改</a></td>");
					html.push("<td><a href='javascript:void(0)' onclick='deleteAdmin(" + arr[i].admin_id + ")'>删除</a></td>");
					html.push("</tr>");
				}
				html.push("</table>");				
				$("#div_show").html(html.join(""));
			}
			
			function deleteAdmin(admin_id)
			{
				if(window.confirm("确定删除吗？"))
				{
					$.ajax({
						url : "cAdminServlet",
						type : "post",
						data : "type=delete&admin_id=" + admin_id,
						success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
						{
							var obj = $.parseJSON(data);
							if(obj.result)
							{
								alert("删除成功");
								location.reload();
							}
							else
							{
								alert("删除失败");
							}
						}
					});
				}
			}
		</script>
	</head>
  
	<body>
	<fieldset style="width:400px; float:center; margin: 20px 10px 10px 50px; background-image:url(images/b.jpg); ">
				<legend>管理员管理</legend>
		<div id="div_show"></div>
		<div align="center"><a href="managePages/adminPages/addAdmin.jsp">新增</a></div>	
	</fieldset>
	</body>
</html>