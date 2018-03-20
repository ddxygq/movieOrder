<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>管理员后台管理</title>
    <style type="text/css">
    	.manager{
    		height:200px;
    		width:20%;
    		margin-left:10%;
    		margin-top:50px;
    		float:left;
    		background-color:#666;
    		text-align:center;
    		line-height:200px;
    		color : #000;
    	}
    	
    	.manager:hover{background-color:#888;}
    	
    	
    </style>
	
  </head>
  
  <body>
  	<div>
  		<a href="managePages/moviePages/movieManage.jsp"><div class="manager"">影片管理</div></a>
		<a href="managePages/playPages/playManage.jsp"><div class="manager">场次管理</div></a>
		<a href="managePages/memberPages/memberManage.jsp"><div class="manager">用户管理</div></a>
		<a href="managePages/ticketPages/TicketManage.jsp"><div class="manager">票务管理</div></a>
		<a href="javascript:void(0);"><div class="manager">广告</div></a>
		<a href="managePages/adminPages/adminManage.jsp"><div class="manager">管理员管理</div></a>
	</div>
    
  </body>
</html>
