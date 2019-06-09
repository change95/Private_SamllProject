<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.show{display: block;}
	*{margin: 0; padding: 0;}
 	div ul li{width: 90px;line-height: 50px;float: left;text-align: center; display: block; background-color: #e7e7e7;}
 	li a{text-decoration:none; cursor: pointer;}
 	.show{display: inline;}
	
</style>

<script type="text/javascript">
//显示二级菜单
	function appear(o){	 
		 var flag=o.id; //获取当前点击的id
		 console.log("显示二级菜单! id为:"+flag);
		 switch (flag) {
		case '1':
				//这是添加学生
				var element=document.getElementById("addstu");
					element.style.display="inline"
			break;
		case '2':
				//这是用户退出
				console.log("进入用户号退出!");
				var element=document.getElementById("user");
					element.style.display="inline"
			
			break;

		
		break;
		default:
				console.log("显示二级菜单没找到id");
			break;
		} 
	}
//隐藏二级菜单
function hide(o){	 
		 var flag=o.id; //获取当前点击的id
		 console.log("显示二级菜单! id为:"+flag);
		 switch (flag) {
		case '1':
			//这是添加学生
				var element=document.getElementById("addstu");
					element.style.display="none";
			break;
		case '2':
				//这是用户退出
				console.log("进入用户号退出!");
				var element=document.getElementById("user");
					element.style.display="none";
			break;

		default:
				console.log("显示二级菜单没找到id");
			break;
		} 
	}
//弹出添加窗口
function openadd(obj){
	console.log("点击id窗口显示为:"+obj.id);
	if(obj.id=="student"){
		document.getElementById("add").style.display="";
	}
	
   
}
//隐藏添加窗口
function closeadd(obj){
	console.log("点击id窗口隐藏为:"+obj.id);
	if(obj.id=="closestu"){
		document.getElementById("add").style.display="none";
	}
}
</script>
</head>
<body>
<!-- 导航 -->
	<div style="width: 1100px; height: 50px; background-color: #f8f8f8; margin: 0 auto; border: 1px;border-radius: 15px; ">
		<div style="width: 110px;float: left;line-height: 50px; text-align: center;"><h3>首页</h3></div>
		<ul style="list-style: none;">
			<li id="1" onmouseover="appear(this)" onmouseout="hide(this)">
				<a href="admin.jsp">用户管理</a>
				<ul><li id="addstu" style="display: none;"><a id="student"  onclick="openadd(this)">添加</a></li></ul>
			</li>
			<li id="3" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="adminform.jsp">信息表管理</a>
			</li>
			<li style="float: right;">
				<ul>
					<li id="2" onMouseOver="appear(this)" onmouseout="hide(this)">
						<a><%=session.getAttribute("admin") %>▼</a>
						<ul>
						<li id="user" style=" float: right;background-color: #f8f8f8; width: 200px; text-align: center;left: 50px; display: none;right: 0;left: auto;">
						<a href="/lostandfound/adminServlet?method=loginOut">退出登陆</a></li>
						</ul>
				</ul>
			</li>
			
		</ul>
	</div>
 
<!-- 添加 学生显示窗口 -->
    <div id="add" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加用户</b></h3><br>
        <!-- 添加学生信息 form表单 -->
        <form action="/lostandfound/BaseServlet?method=adduser" method="post">
        <input name="username" type="text" width="120px" height="40px;" placeholder="用户名"><br><br>
        <input name="password" type="text" width="120px" height="40px;" placeholder="密码"><br><br>
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closestu" onclick="closeadd(this)" href="#">关闭注册框</a></div>
 <!-- 添加信息通知显示窗口 -->
 <div id="addmes2" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加信息</b></h3><br>
        <!-- 添加信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=addmes" method="post">
        通知对象:<select  name="informObj">
        	<option value="全体成员">全体成员</option>
        	<option value="老师">老师</option>
        	<option value="学生">学生</option>
        </select>
         <br><br>
    ID:<input id="id"  name="id" type="text" width="120px" height="40px;" placeholder="ID" readonly="readonly" style="background-color:#dedede "><br><br>
        时间:<input id="time"  name="time" type="text" width="120px" height="40px;" placeholder="ID" readonly="readonly" style="background-color:#dedede "><br><br>
        内容: <input  name="content" type="text" width="120px" height="40px;" placeholder="内容"><br><br>
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closemes" onclick="closeadd(this)" href="#">关闭注册框</a></div> 
 <!-- 添加课程显示窗口 -->
 <div id="addcur2" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加课程</b></h3><br>
        <!-- 添加课程信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=addcur" method="post">
        <input name="curriculum" type="text" width="120px" height="40px;" placeholder="课程号"><br><br>
        <input name="curriculumname" type="text" width="120px" height="40px;" placeholder="课程名"><br><br>
        <input name="tno" type="text" width="120px" height="40px;" placeholder="教师号"><br><br>
       
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closecur" onclick="closeadd(this)" href="#">关闭注册框</a></div>       
<!-- 添加 老师显示窗口 -->
    <div id="addtea2" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加教师</b></h3><br>
        <!-- 添加教师信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=addtea" method="post">
        <input name="tno" type="text" width="120px" height="40px;" placeholder="教师号"><br><br>
        <input name="password" type="text" width="120px" height="40px;" placeholder="密码"><br><br>
        <input name="name" type="text" width="120px" height="40px;" placeholder="姓名"><br><br>
        性别:<input type="radio" name="sex" value="男">男
        <input type="radio" name="sex" value="女" checked="checked">女<br><br>
        学历: <select name="education">
        	<option value="小学">小学</option>
        	<option value="初中">初中</option>
        	<option value="高中">高中</option>
        	<option value="专科">专科</option>
        	<option value="本科">本科</option>
        	<option value="研究生">研究生</option>
        	<option value="博士">博士</option>
        </select>
      
        <br><br>
        所属学院:<input name="college" type="text" width="120px" height="40px;" placeholder="如:信息工程学院....">
        <br><br>
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closetea" onclick="closeadd(this)" href="#">关闭注册框</a></div>
</body>
</html>