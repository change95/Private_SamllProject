<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的信息-丢失表</title>
<style type="text/css">

table th{	
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede; }
table td{	
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	
	}
table{ 
	font-size:19px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
	width: 60%;
	text-align: center;
	}

</style>
<script type="text/javascript">
//修改框的显示和隐藏
function openamend(){
	   document.getElementById("amend").style.display="";
	   
	}
function closeamend(){
	   document.getElementById("amend").style.display="none";
	}
	
	//修改框赋值
    function modify(obj){
	
			var atr= obj.parentNode.parentNode;
			var atd = atr.getElementsByTagName('td');
			//获取信息
			
			var sno = document.getElementById('username');
			sno.value=atd[0].innerHTML;
			var pasword = document.getElementById('userpas');
			pasword.value=atd[1].innerHTML;
	
    }	
	
	
//检测是否登陆  没有登陆返回首页
function islogin(){
	//获取session对象中的用户名
	 var username=<%=session.getAttribute("admin")%>;
	 //判断 用户名   和   存放用户名的div 双层判断
	 if(null==username){
		 	 <%session.setAttribute("msg", "请登陆再操作!"); %>
				console.log("msg设置成功!");
			 	 window.location.href="msg.jsp";
	 }
}
setTimeout(islogin,500);

</script>
</head>
<body>

			<jsp:include page="adminTop.jsp"></jsp:include>
	   <%

		   String sql="SELECT * FROM user ";//设置sql语句
	       System.out.println("sql:"+sql);
		   PreparedStatement ps; //设置预编译SQL语句保存到PreparedStatement对象
	       ResultSet re;  //声明re用来接收SQL语句的结果
			//注册驱动
		   Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/shiwu","root","123456");
			try{
			ps = con.prepareStatement(sql);
			re = ps.executeQuery();//执行sql语句,将查询结果存放在re中

	   %>
<!--表格展示 --> 
 <div style="text-align: center;">
		<br><br><br><h1>用户管理</h1><br>
		<center>
			 	<table id="mytable">
			<thead>
				<th>用户名</th>
				<th>密码</th>
				<th>操作</th>
			</thead>
	<%
	//利用while循环将数据表中的记录列出
 	while(re.next()){
	%>
			<tbody>
				  <tr>
					    <td><%= re.getString("username") %></td>
					    <td><%= re.getString("password") %></td>
					    <td>
					    <a target="_blank" href="/lostandfound/adminServlet?method=deleuser&username=<%= re.getString("username") %>">删除 </a>&nbsp;
					    <a href="javascript:openamend();" onclick="modify(this)">修改</a>
					    </td>
				</tr> 
				
			</tbody>
<%
  }
  
  re.close(); //关闭ResultSet对象
 }
  catch(Exception e){
  out.println(e.getMessage());
  }

  con.close();  //关闭Connection对象	
	
%>	
</table></center>
 </div>	
 
  <!--修改弹窗-->
  <div id="amend" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        
        <br><h3><b>修改学生</b></h3><br>
        <!-- 添加学生信息 form表单 -->
        <form action="/lostandfound/adminServlet?method=amenduser" method="post">
        <input id="username" name="username" type="text" width="120px" height="40px;" placeholder="学号" readonly="readonly" style="background-color:#dedede "><br><br>
        <input id="userpas" name="userpas" type="text" width="120px" height="40px;" placeholder="密码"><br><br>
        <button type="submit">保存修改</button>
        </form>
        <br><br>
        <a href="javascript:closeamend();">关闭修改框</a></div>
</body>
</html>