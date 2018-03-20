<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    	<base href="<%=basePath%>">
    	<style type="text/css">
			a{text-decoration:none;}
			a:hover{text-decoration:underline;}
			table{width:700px;text-align:center;}
    	</style>
    	<script type="text/javascript" src="js/jquery.min.js"></script>
    	<script type="text/javascript">
    		var pageSize = 3;
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
    			
    			// 点击查询按钮
    			$('#selectMember').click(function() {
    				member_name = $('#member_name').val();
    				param.member_name = member_name;
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
    				url : 'memberServlet',
    				type : 'post',
    				data : param,
    				success : function(data) {
    					data = $.parseJSON(data);
    					if(len > pageSize){
    						$('#nextPage').attr("disabled",false);
    					}
    					showMember(data);
    					
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
    		
    		<!-- 显示查询用户信息 -->
    		function showMember(data){
    			html = [];
    			html.push("<table id='show_tab' border='1px solid;'>");
    			html.push("<tr id='show_tab_one'><th>电子邮箱</th><th>姓名</th><th>密码</th><th>性别</th><th>电话</th><th>操作</th><tr>");
    			for(var i = 0;i < data.length;i++){
    				var member_gender = data[i].member_gender == 1 ? '男' : '女';
    				html.push("<tr>");
    				html.push("<td>" + data[i].member_email +"</td>");
    				html.push("<td>" + data[i].member_name +"</td>");
    				html.push("<td>" + data[i].member_pwd +"</td>");
    				html.push("<td>" + member_gender +"</td>");
    				html.push("<td>" + data[i].member_phone +"</td>");
    				html.push("<td><a href='managePages/memberPages/updateMember.jsp?member_id=" + data[i].member_id + "'>修改</a>");
    				html.push("&nbsp;<a href='javascript:void(0);' onclick='deleteMember(" + data[i].member_id + ")'>删除</a></td>");
    				html.push("</tr>");
    			}
    			html.push("</table>");
    			memberDiv = document.getElementById("memberDiv");
    			memberDiv.innerHTML = html.join("");
    		}
    		
    		// 总页数
    		function pageCount(){
    			$.ajax({
    				url : 'memberServlet',
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
    		
    		function deleteMember(member_id){
    			param.type = 'delete';
    			param.member_id = member_id;
    			$.ajax({
    				url : 'memberServlet',
    				type : 'post',
    				data : param,
    				success : function(data){
    					if($.parseJSON(data).result){
    						alert("删除成功");
    						window.onload();
    					}
    				},
    				error : function(){
    					alert("删除超时");
    				}
    			});
    		}
    	</script>
    </head>
    <body>
    	<fieldset>
    		<legend>用户管理</legend>
    		<a href="managePages/memberPages/addMember.jsp">添加用户</a>
    		<hr>
    		用户名：<input type="text" id="member_name"><br>
    		<input type="button" id="selectMember" value="搜索"><br>
    		<div id="memberDiv"></div><br>
    		
    		<input type="button" id="lastPage" value="上一页">&nbsp;&nbsp;
    		第<input type="text" id="curPage" size='3'>页
    		<input type="button" id="nPage" value="确定">
    		<input type="button" id="nextPage" value="下一页">&nbsp;&nbsp;
    		共<input type="text" id="page" readonly="readonly" size="3">页
    	</fieldset>
    </body>
</html>