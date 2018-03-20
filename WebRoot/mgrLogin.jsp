<%@  page   pageEncoding="utf-8"%>
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
				$("#btnLogin").click(function()
				{
					var admin_name = $("#admin_name").val();
					var admin_pwd = $("#admin_pwd").val();
					var captcha = $("#captcha").val();
					
					var param = {};
					param.admin_name = admin_name;
					param.admin_pwd = admin_pwd;
					param.captcha = captcha;
					
					$.ajax({
						url : "admin",
						type : "post",
						data : param,
						success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
						{
							var obj = $.parseJSON(data);
							if(obj.result)
							{
								location.href = "managePages/backerManage.jsp";	
							}
							else
							{
								alert("登录失败");
								location.href = "mgrLogin.jsp";
							}
						}
					});
				});
			});
			
  		function refreshCode(img)
    		{
    			var t = (new Date()).getTime();
				var code = "captcha?k=" + t;
				img.src = code;
    		}
    		
    		window.onload = function()
    		{
    			var img = document.getElementById("img");
    			refreshCode(img);
    		}
   </script>
  </head>
  
  <body style= background-image:url(images/2.jpg);background-size:100%;>
  			<div align="center"; style="margin: 50px 10px 10px 10px;"><h1>乐享影业</h1></div>
  			<div style="margin: 50px 10px 10px 50px;"><h3>生活不止眼前的苟且，</h3></div>
  			<div style="margin: 50px 10px 10px 50px;"><h3>还有诗和远方</h3></div>
  			<div style="margin: 50px 10px 10px 50px;"><h3>乐享生活从看一场电影开始</h3></div>
		<div style="width:800px; float:center; margin: 100px 10px 10px 350px; ">		
  			<div align="center"><h3 align="center">管理员登录</h3></div>
  				<div align="center" text-align="right">  	
  				用户名:<input  type="text" id="admin_name"/><br/><br/>
  				密     码:<input  type="password" id="admin_pwd"/><br/><br/>
  				验证码:<input type="text"  id="captcha"/><br/>
  				<img id="img" title="点击刷新" width="54px" height="21px" style="vertical-align:middle; cursor:pointer;" onclick="refreshCode(this)"/>
	    		<br/><br/>
	   			<input type="button" value="登录" id="btnLogin"/>
	   			</div>   	 
  	  </div> 	  
  </body>
</html>
