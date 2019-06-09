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
		case '5':
			//这是信息管理
			var element=document.getElementById("addmes");
				element.style.display="inline"
		break;
		case '4':
			//这是信息管理
			var element=document.getElementById("addgra");
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
		case '5':
			//这是信息添加
			var element=document.getElementById("addmes");
				element.style.display="none";
		break;
		case '4':
			//这是成绩添加
			var element=document.getElementById("addgra");
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
	 if(obj.id=="message"){
		document.getElementById("addmes2").style.display="";
		var time=new Date();
		var s=new Date(time.getTime());
		console.log("id为:"+time.getTime()+"时间为:"+s.toLocaleString());
		document.getElementById("id").value=time.getTime();
		
		document.getElementById("time").value=s.toLocaleString();
	}else if(obj.id=="grade"){
		document.getElementById("addgra2").style.display="";
	}
	
   
}
//隐藏添加窗口
function closeadd(obj){
	console.log("点击id窗口隐藏为:"+obj.id);
	if (obj.id=="closegra") {
		document.getElementById("addgra2").style.display="none";
	}else if (obj.id=="closemes") {
		document.getElementById("addmes2").style.display="none";
	}
 
}
//根据成绩自动填写及格不及格
function changestatus(){
	var grade=document.getElementById("getgrade").value;
	if(grade>=60){
		document.getElementById("status").value="及格";
	}else{
		document.getElementById("status").value="不及格";
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
				<a href="teacherSelfe.jsp">个人信息</a>  
			</li>
			<li  onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="teacherCurriculum.jsp">代理课程</a>	
			</li>
			<li id="4" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="teacherGradeClass.jsp">成绩管理</a>
				<ul><li id="addgra" style="display: none;"><a id="grade" onclick="openadd(this)">添加</a></li></ul>
			</li>
			<li id="5" onMouseOver="appear(this)" onmouseout="hide(this)">
				<a href="teacherMessage.jsp">信息通知</a>
				<ul><li id="addmes" style="display: none;"><a id="message" onclick="openadd(this)">添加</a></li></ul>
			</li>
			<li style="float: right;">
				<ul>
					<li id="2" onMouseOver="appear(this)" onmouseout="hide(this)">
						<a id="usertno"><%=session.getAttribute("user") %></a>▼
						<ul>
						<li id="user" style=" float: right;background-color: #f8f8f8; width: 200px; text-align: center;left: 50px; display: none;right: 0;left: auto;">
						<a href="/jiaowu/BaseServlet?method=loginOut&flag=teacher">退出登陆</a>
						</ul></li>
					</li>
				</ul>
			</li>
		</ul>
	</div>
 

 <!-- 添加信息通知显示窗口 -->
 <div id="addmes2" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加信息</b></h3><br>
        <!-- 添加信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=addmes" method="post">
        通知对象:<select  name="informObj">
        	<option value="学生">学生</option>
        </select>
         <br><br>
   &nbsp; ID:<input id="id"  name="id" type="text" width="120px" height="40px;" placeholder="ID" readonly="readonly" style="background-color:#dedede "><br><br>
        时间:<input id="time"  name="time" type="text" width="120px" height="40px;" placeholder="ID" readonly="readonly" style="background-color:#dedede "><br><br>
     <span style="display:inline-block; padding-bottom: 20px;">内容:</span>
    <textarea name="content" rows="3" cols="20" style="vertical-align:middle"></textarea>
        <br>
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closemes" onclick="closeadd(this)" href="#">关闭注册框</a></div> 
 <!-- 添加成绩显示窗口 -->
 <div id="addgra2" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        <br><h3><b>添加成绩</b></h3><br>
        <!-- 添加成绩form表单 -->
  
        <form action="/jiaowu/teacherServlet?method=addgra" method="post">
        学号:<select name="sno">
              	   <%
        	   String classnum=(String)session.getAttribute("class");
        	   System.out.println("session:class班级号"+classnum);
		   String sql="SELECT sno FROM student WHERE class="+classnum;//设置sql语句
		   System.out.println("添加sql语句"+sql);
	       PreparedStatement ps; //设置预编译SQL语句保存到PreparedStatement对象
	       ResultSet re;  //声明re用来接收SQL语句的结果
			//注册驱动
		   Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jiaowu","root","123456");
			try{
			ps = con.prepareStatement(sql);
			re = ps.executeQuery();//执行sql语句,将查询结果存放在re中
			while(re.next()){
	   %>
           <option value="<%=re.getString("sno") %>"><%=re.getString("sno") %></option>
<%
  		}
  		re.close(); //关闭ResultSet对象
 }
  catch(Exception e){
  out.println(e.getMessage());
  }
  con.close();  //关闭Connection对象	
	
%>        
        </select><br><br> 
        
      	课程号:<select name="curriculum">
      	<%
      	   String user=(String)session.getAttribute("user");
		   String sql1="SELECT curriculum FROM curriculum WHERE tno="+user;//设置sql语句
		   System.out.println("添加sql语句"+sql1);
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
      	<option value="<%=re1.getString("curriculum") %>"><%=re1.getString("curriculum") %></option>
<%
  		}
  		re1.close(); //关闭ResultSet对象
 }
  catch(Exception e){
  out.println(e.getMessage());
  }
  con1.close();  //关闭Connection对象	
	
%>
      	
      	</select><br><br>
       成绩: <input id="getgrade" name="grade" onkeyup="this.value=this.value.replace(/[^0-9-]+/,'');" oninput="changestatus()"  type="text" width="120px" height="40px;" placeholder="成绩"><br><br>
      状态:  <input id="status" name="status" type="text" width="120px" height="40px;" placeholder="状态" readonly="readonly" style="background-color:#dedede "><br><br>
        <button type="submit">提交</button>
        </form>
        <br><br>
        <a id="closegra" onclick="closeadd(this)" href="#">关闭注册框</a></div>       

</body>
</html>