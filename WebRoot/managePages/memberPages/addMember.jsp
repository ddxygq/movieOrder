<%@ page pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>添加用户</title>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript">
			var param = {};
			$(function(){
				$('#sureSave').click(function(){
					//存放格式验证信息
					var error = [];
					
					var member_email = $('#member_email').val();
					//验证邮箱
					var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
					if(reg.test(member_email)){
						param.member_email = member_email;
					}else{
						error.push("邮箱输入格式有误");
					}
					var member_pwd = $('#member_pwd').val();
					if(member_pwd){
						param.member_pwd = member_pwd;
					}else{
						error.push("请输入密码");
					}
					param.member_name = $('#member_name').val();
					param.member_gender = $("input[name='genders']:checked").val();
					param.member_phone = $('#member_phone').val();
					param.type = 'add';
					if(error.length > 0){
						alert(error.join("\n"));
						return;
					}
					$.ajax({
						url : 'memberServlet',
						type : 'post',
						data : param,
						success : function(data){
							data = $.parseJSON(data);
							if(data.result){
								alert("添加成功");
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<fieldset>
			<legend>添加用户</legend>
			电子邮箱：<input type="text" id="member_email"><br>
			姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：<input type="text" id="member_name"><br>
			密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="text" id="member_pwd"><br>
			性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：<input type="radio" name="genders" value="1">男
				<input type="radio" name="genders" value="0" checked="true">女<br>
			电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：<input type="text" id="member_phone">
			<input type="button" id="sureSave" value="确认保存">
		</fieldset>
	</body>
</html>