<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆页面-教务系统</title>
<style>

	html,body {
		height: 100%;
	}
</style>
</head>
<body style="background-color:#6699ff;">

<div style="margin:0 auto; margin-top:300px;width: 500px;">
<div  style="border: none; width: 500px; height: 400px; background-color: #afb8d1 ">
		<div style="color:white ;background-color:#293d66; width: 500px; line-height: 84px; text-align: center;">
		<h3>教务管理系统登陆</h3>
		</div>
		<!-- 登陆表单  -->
		<form action="/jiaowu/BaseServlet?method=login" method="post">
		<div style="margin: 0 auto;width: 431px;">
			<input type="text" name="username" style="text-align:center ;width: 431px; line-height: 40px"  placeholder="用户名">
		</div>
		<br>
		<br>
		<div style="margin: 0 auto; width: 431px">
			<input type="password" name="password" style="text-align:center ; width: 431px; line-height: 40px" placeholder="密码">
		</div>
		<div style="margin: 0 auto;width: 103px; margin-top: 30px;">
			<button type="submit" style="color:white ;border-color: #46b8da;border-radius: 15px;width: 103px; line-height: 42px; background-color: #5bc0de; cursor: pointer;">登陆</button>
		</div>
		<div style="margin: 0 auto; width: 200px; margin-top: 8px; ">
			<span><input name="type" type="radio" value="学生">学生</span>
			<span><input name="type" type="radio" value="教师">教师</span>
			<span><input name="type" type="radio" value="管理员" checked="checked">管理员</span>
		</div>
		</form>
</div>
</div>


</body>
</html>