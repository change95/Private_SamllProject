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
	width: 80%;
	text-align: center;
	}

</style>
<script type="text/javascript">

<script type="text/javascript">

//检测是否登陆  没有登陆返回首页
function islogin(){
	//获取session对象中的用户名
	 var username=<%=session.getAttribute("user")%>;
	 //判断 用户名   和   存放用户名的div 双层判断
	 if(null==username){
		 	 <%session.setAttribute("msg", "请登陆再操作!"); %>
				console.log("msg设置成功!");
			 	 window.location.href="msg.jsp";
	 }
}
setTimeout(islogin,500);
</script>
</script>
</head>
<body>
	   <%
	   	   String user= (String)session.getAttribute("user");
		   String sql="SELECT * FROM form where type='found' and username="+user;//设置sql语句
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
		<br><br><br><h1>我的招领表</h1><br>
		<center>
			 	<table id="mytable">
			<thead>
				<th>id</th>
				<th>标题</th>
				<th>用户名</th>
				<th>种类</th>
				<th>时间</th>
				<th>电话</th>
				<th>姓名</th>
				<th>内容</th>
				<th>地点</th>
				<th>类型</th>
				<th>操作</th>
			</thead>
	<%
	//利用while循环将数据表中的记录列出
 	while(re.next()){
	%>
			<tbody>
				  <tr>
					    <td><%= re.getString("id") %></td>
					    <td><%= re.getString("title") %></td>
					    <td><%= re.getString("username") %></td>
					    <td><%= re.getString("kind") %></td>
					    <td><%= re.getString("time") %></td>
					    <td><%= re.getString("phone") %></td>
					    <td><%= re.getString("name") %></td>
					    <td><%= re.getString("content") %></td>
					    <td><%= re.getString("place") %></td>
					    <td><%= re.getString("type") %></td>
					    <td>
					    <a target="_blank" href="/lostandfound/BaseServlet?method=lookform&id=<%= re.getString("id") %>">查看 </a>&nbsp;
					    <a href="/lostandfound/BaseServlet?method=deleform&id=<%= re.getString("id") %>">已找到</a></td>
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
</body>
</html>