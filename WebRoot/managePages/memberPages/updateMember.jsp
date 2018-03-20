<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>修改成员</title>
    	<script type="text/javascript" src="js/jquery.min.js"></script>
    	<script type="text/javascript">
    		var member_id = '${param.member_id}';
    		var param = {};
    		param.member_id = member_id;
    		param.type = "single";
    		$(function(){
    			$.ajax({
    				url : 'memberServlet',
    				type : 'post',
    				data : param,
    				success : function(data){
    					data = $.parseJSON(data);
    					$('#member_email').val(data.member_email);
    					$('#member_name').val(data.member_name);
    					$('input[name=genders][value=' + data.member_gender + ']').prop('checked',true);
    					$('#member_pwd').val(data.member_pwd);
    					$('#member_phone').val(data.member_phone);
    				}
    			});
    			
    			$('#saveBtn').click(function(){
    				param.member_email = $('#member_email').val();
    				param.member_name = $('#member_name').val();
    				param.member_gender = $('input[name=genders]:checked').val();
    				param.member_pwd = $('#member_pwd').val();
    				param.member_phone = $('#member_phone').val();
    				param.type = 'update';
    				$.ajax({
    					url : 'memberServlet',
    					type : 'post',
    					data : param,
    					success : function(data){
    						data = $.parseJSON(data);
    						if(data.result){
    							alert("修改成功");
    							window.onload();
    						}else{
    							alert("修改失败!");
    						}
    					},
    					error : function(){
    						alert("修改超时!");
    					}
    				});
    			});
    		});
    	</script>
    </head>
    <body>
    	<fieldset>
    		<legend>修改用户信息</legend>
    		电子邮箱:<input type="text" id="member_email"><br>
    		姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:<input type="text" id="member_name"><br>
    		密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:<input type="text" id="member_pwd"><br>
    		性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别:<input type="radio" name="genders" value="1" checked="true">男
    		<input type="radio" name="genders" value="0">女<br>
    		电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话:<input type="text" id="member_phone">
    		<input type="button" value="保存修改" id="saveBtn">
    	</fieldset>
    </body>
</html>