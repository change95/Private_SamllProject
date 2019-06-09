<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
//检测是否登陆  没有登陆返回首页
function islogin(){
	//获取session对象中的用户名
	 var username=<%=session.getAttribute("user")%>;
	 //判断 用户名   
	 if(null==username){
		 	 <%session.setAttribute("msg", "请登陆再操作!"); %>
				console.log("msg设置成功!");
			 	 window.location.href="msg.jsp";
	 }
}
setTimeout(islogin,500);
//显示二级菜单
	function appear(o){	 
		 var flag=o.id; //获取当前点击的id
		 console.log("显示二级菜单! id为:"+flag);
		 switch (flag) {
		case '2':
				//这是用户退出
				console.log("进入用户号退出!");
				var element=document.getElementById("user");
					element.style.display="inline"
			
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

</script>
</head>
<body>
<!-- 导航 -->
	<div style="width: 1100px; height: 50px; background-color: #f8f8f8; margin: 0 auto; border: 1px;border-radius: 15px; ">
		<div style="width: 110px;float: left;line-height: 50px; text-align: center;"><h3>首页</h3></div>
		<ul style="list-style: none;">
			<li  onmouseover="appear(this)" onmouseout="hide(this)">
				<a href="studentSelfe.jsp">个人信息</a>  
			</li>
			<li  onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="studentCurriculum.jsp">课程查询</a>	
			</li>
			<li id="4" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="studentGrade.jsp">成绩查询</a>
			</li>
			<li id="5" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="studentMessage.jsp">信息通知</a>
			</li>
			<li style="float: right;">
				<ul>
					<li id="2" style="width: 110px;" onMouseOver="appear(this)" onmouseout="hide(this)">
						<a id="usertno"><%=session.getAttribute("user") %></a>▼
						<ul>
						<li id="user" style=" float: right;background-color: #f8f8f8; width: 200px; text-align: center;left: 50px; display: none;right: 0;left: auto;">
						<a href="/jiaowu/BaseServlet?method=loginOut&flag=student">退出登陆</a>
						</ul></li>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	

</body>
</html>