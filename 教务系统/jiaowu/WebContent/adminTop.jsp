<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="css/time.css" type="text/css" />

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
		case '1':
				//这是添加学生
				var element=document.getElementById("addstu");
					element.style.display="inline"
			break;
		case '3':
			//这是添加教师
			var element=document.getElementById("addtea");
				element.style.display="inline"
		   break;	
		case '4':
			//这是添加课程
			var element=document.getElementById("addcur");
				element.style.display="inline"
		   break;
		case '2':
				//这是用户退出
				console.log("进入用户号退出!");
				var element=document.getElementById("user");
					element.style.display="inline"
			
			break;
		case '5':
			//这是信息管理
			var element=document.getElementById("addmes");
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
		case '1':
			//这是添加学生
				var element=document.getElementById("addstu");
					element.style.display="none";
			break;
		case '3':
			//这是添加教师
			var element=document.getElementById("addtea");
				element.style.display="none";
		   break;	
		case '4':
			//这是添加课程
			var element=document.getElementById("addcur");
				element.style.display="none";
		   break;
		case '2':
				//这是用户退出
				console.log("进入用户号退出!");
				var element=document.getElementById("user");
					element.style.display="none";
			break;
		case '5':
			//这是信息添加
			var element=document.getElementById("addmes");
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
	}else if(obj.id=="teacher"){
		document.getElementById("addtea2").style.display="";
	}else if(obj.id=="curriculum"){
		document.getElementById("addcur2").style.display="";
	}else if(obj.id=="message"){
		document.getElementById("addmes2").style.display="";
		var time=new Date();
		var s=new Date(time.getTime());
		console.log("id为:"+time.getTime()+"时间为:"+s.toLocaleString());
		document.getElementById("id").value=time.getTime();
		
		document.getElementById("time").value=s.toLocaleString();
	}
	
   
}
//隐藏添加窗口
function closeadd(obj){
	console.log("点击id窗口隐藏为:"+obj.id);
	if(obj.id=="closestu"){
		document.getElementById("add").style.display="none";
	}else if (obj.id=="closetea") {
		document.getElementById("addtea2").style.display="none";
	}else if (obj.id=="closecur") {
		document.getElementById("addcur2").style.display="none";
	}else if (obj.id=="closemes") {
		document.getElementById("addmes2").style.display="none";
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
				<a href="admin.jsp">学生管理</a>
				<ul><li id="addstu" style="display: none;"><a id="student"  onclick="openadd(this)">添加</a></li></ul>
			</li>
			<li id="3" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="teacher.jsp">教师管理</a>
				<ul><li id="addtea" style="display: none;"><a id="teacher" onclick="openadd(this)">添加</a></li></ul>
			</li>
			<li id="4" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="curriculum.jsp">课程管理</a>
				<ul><li id="addcur" style="display: none;"><a id="curriculum" onclick="openadd(this)">添加</a></li></ul>
			</li>
			
			<li id="5" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="message.jsp">信息通知</a>
				<ul><li id="addmes" style="display: none;"><a id="message" onclick="openadd(this)">添加</a></li></ul>
			</li>
			<li style="float: right;">
				<ul>
					<li id="2" onMouseOver="appear(this)" onmouseout="hide(this)">
						<a><%=session.getAttribute("user") %>▼</a>
						<ul>
						<li id="user" style=" float: right;background-color: #f8f8f8; width: 200px; text-align: center;left: 50px; display: none;right: 0;left: auto;">
						<a href="/jiaowu/BaseServlet?method=loginOut&flag=admin">退出登陆</a></li>
						</ul>
				</ul>
			</li>
			
		</ul>
	</div>
 
<!-- 添加 学生显示窗口 -->
    <div id="add" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加学生</b></h3><br>
        <!-- 添加学生信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=addstu" method="post">
        学号:<input name="sno" type="text" width="120px" height="40px;" placeholder="学号"><br><br>
       密码:<input name="pas" type="text" width="120px" height="40px;" placeholder="密码"><br><br>
      姓名:<input name="name" type="text" width="120px" height="40px;" placeholder="姓名"><br><br>
        性别:<input type="radio" name="sex" value="男" checked="checked">男
        <input type="radio" name="sex" value="女" checked="checked">女<br><br>
       出生年月：<input name="date" type="text" id="j_Date1" class="input"><br><br>  
       班级号: <input name="classnum" type="text" width="120px" height="40px;" placeholder="班级号">
        <br><br>
        <button type="submit">提交</button>
        </form>
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
        内容: 
        <textarea  name="content" rows="3" cols="20" style="vertical-align:middle"></textarea>   
<br><br>
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closemes" onclick="closeadd(this)" href="#">关闭注册框</a></div> 
 <!-- 添加课程显示窗口 -->
 <div id="addcur2" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加课程</b></h3><br>
        <!-- 添加课程信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=addcur" method="post">
        课程号:<input name="curriculum" type="text" width="120px" height="40px;" placeholder="课程号"><br><br>
        课程名:<input name="curriculumname" type="text" width="120px" height="40px;" placeholder="课程名"><br><br>
                 教师号:<select id="tno" name="tno">
               <!-- 连接数据库获取教师号 -->
 	   <%
		   String sql1="SELECT tno FROM teacher";//设置sql语句
	       PreparedStatement ps1; //设置预编译SQL语句保存到PreparedStatement对象
	       ResultSet re1;  //声明re用来接收SQL语句的结果
			//注册驱动
		   Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con1 = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jiaowu","root","123456");
			try{
			ps1 = con1.prepareStatement(sql1);
			re1 = ps1.executeQuery();//执行sql语句,将查询结果存放在re中
			while(re1.next()){
	   %>
              <option><%=re1.getString("tno")%></option>
        <%
			  }
			  
			  re1.close(); //关闭ResultSet对象
			 }
			  catch(Exception e){
			  out.println(e.getMessage());
			  }
			
			  con1.close();  //关闭Connection对象	
				
			%>      
            </select>
            <br><br>
        班级号:<input name="classnum" type="text" width="120px" height="40px;" placeholder="班级号"><br><br>
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closecur" onclick="closeadd(this)" href="#">关闭注册框</a></div>       
<!-- 添加 老师显示窗口 -->
    <div id="addtea2" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加教师</b></h3><br>
        <!-- 添加教师信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=addtea" method="post">
        教师号:<input name="tno" type="text" width="120px" height="40px;" placeholder="教师号"><br><br>
        密码:<input name="password" type="text" width="120px" height="40px;" placeholder="密码"><br><br>
        姓名:<input name="name" type="text" width="120px" height="40px;" placeholder="姓名"><br><br>
        性别:<input type="radio" name="sex" value="男">男
        <input type="radio" name="sex" value="女" checked="checked">女<br><br>
        学历: <select name="education">
        	<option value="本科">本科</option>
        	<option value="研究生">研究生</option>
        	<option value="博士">博士</option>
        </select>
      
        <br><br>
        所属学院:<input name="college" type="text" width="120px" height="40px;" placeholder="如:信息工程学院....">
        <br><br>
        <button type="submit">提交</button>
        </form>
        <a id="closetea" onclick="closeadd(this)" href="#">关闭注册框</a></div>
        <script src="js/time.js"></script>
</body>
</html>