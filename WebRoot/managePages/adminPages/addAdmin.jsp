<%@ page pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		
		<script type="text/javascript" src="js/jquery.min.js"></script>
		
		<script type="text/javascript">
			$(function()
			{
				$("#btnSave").click(function()
				{
					var admin_id = $("#admin_id").val();
					var admin_name = $("#admin_name").val();
					var admin_pwd = $("#admin_pwd").val();
					var admin_privilege = $("#admin_privilege").val();
					
					var param = {};
					param.admin_id = admin_id;
					param.admin_name = admin_name;
					param.admin_pwd = admin_pwd;
					param.admin_privilege = admin_privilege;
					param.type = "add";
					
					$.ajax({
						url : "cAdminServlet",
						type : "post",
						data : param,
						success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
						{
							var obj = $.parseJSON(data);
							if(obj.result)
							{
								alert("新增成功");
								location.href = "adminManage.jsp";
							}
							else
							{
								alert("新增失败");
							}
						}
					});
				});
			});
		</script>
	</head>
  
	<body>
		管理员编号：<input type="text" id="admin_id"/><br/><br/>
		管理员名称：<input type="text" id="admin_name"/><br/><br/>
		管理员密码：<input type="text" id="admin_pwd"/><br/><br/>
		管理员权限：<input type="text" id="admin_privilege"/><br/><br/>
		
		<input type="button" value="保存" id="btnSave"/>
	</body>
</html>