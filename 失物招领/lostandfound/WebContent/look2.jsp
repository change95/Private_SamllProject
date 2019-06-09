<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
#divcss5 img{ border-radius:50%} 
td {
	width: 200px;
	text-align:center;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>全部招领信息</title>
<link href="css/top_nav.css" rel="stylesheet" type="text/css" /> 
<link href="css/marquee.css" rel="stylesheet" type="text/css" /> 
<link href="css/content.css" rel="stylesheet" type="text/css" /> 
<script>
//获取首页星期几
	function showTopTime(){
	
			var time = new Date();
			var week=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
			document.getElementById('top_time').innerHTML=time.getFullYear()+'年'+ time.getMonth()+'月'+ time.getDate()+'日            '+ week[time.getDay()];	
			}
setTimeout(showTopTime,1000);

//设置登陆之后删除登陆输入框等  并 设置退出按钮和显示用户名
	function loginafter(){
			var username=<%=session.getAttribute("user")%>;
			if(null!=username){
				//删除登陆等节点
				console.log("用户名"+username);
				var el = document.getElementById('userlogin'); 
				var childs = el.childNodes; 
				for(var i = childs .length - 1; i >= 0; i--) {
				  el.removeChild(childs[i]);
				}

				//添加节点  用户名  退出
				document.getElementById("usermsg").innerHTML="欢迎您尊敬的会员&nbsp;&nbsp;"+username+"&nbsp;&nbsp;<a href='/lostandfound/BaseServlet?method=loginout'>退出</a>";
			}
}
setTimeout(loginafter,800);
</script>
</head>
<body>
<!--top导航-->
<div class="top_nav">
	<!--小导航-->
	<div class="top_login">
    	<div class="top_content">
        	<form action="/lostandfound/BaseServlet?method=login" method="post">
  			您好 欢迎来到校园失物招领网 &nbsp;&nbsp; <span id="top_time"></span>
  			<span id="userlogin">
  			&nbsp;&nbsp;用户名:
            <input id="username" name="username" type="text" style="width:80px; height:20px; " />
            &nbsp;&nbsp; 密码:
            <input id="password" name="password" type="password" style=" width:80px; height:20px;" />
            &nbsp;&nbsp;
            <input type="submit" id="login" value="登陆" style="color: #222;cursor: pointer;width: 51px;height: 24px;line-height: 24px;"/>
            &nbsp;&nbsp;
            <input type="button" id="register" value="注册" onclick="window.location.href='register.html'" style="color: #222;cursor: pointer;width: 51px;height: 24px;line-height: 24px;" />
            </span>
           <span id="usermsg" style="float:right;"></span>
            </form>
            
		</div> 
    </div>
    <!--搜索+logo-->
    <div class="top_search">
    	 <div style=" width:1000px; margin:0 auto;height:103px; ">
    	 <div class="logo"> <img src="img/logo.jpg" width="250px" height="90px" style=" margin-top:6px;"></div>
               <div class="search">
                <form>
                    <input type="text" placeholder="请输入您要搜索的内容..." />
                    <button type="submit" ></button>
                </form>
                <center><font color="#FF0000">热搜词</font><font style="color: #000;font-family: "Microsoft YaHei";font-size: 12px;">：手机、钱包、钥匙、身份证、ipad、杯子</font></center>
              </div>
         </div>                                                      
    </div>
</div>
<!-- 大导航-->
<div class="nav">
	<div class="nav_content">
    	<ul>
        	<li style="background-color: #F90"><a href="main.jsp">首页</a></li>
            <li><a href="lost.jsp">发布失物</a></li>
            <li><a href="found.jsp">发布招领</a></li>
        </ul>
    </div>
</div>
		   <%
              String sql="SELECT * FROM form WHERE type=?";
              PreparedStatement ps; //设置预编译SQL语句保存到PreparedStatement对象
              ResultSet re;  //声明re用来接收SQL语句的结果
				//注册驱动
				Class.forName("com.mysql.jdbc.Driver");
				//连接数据库
				Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/shiwu","root","123456");
				ps = con.prepareStatement(sql);
				ps.setString(1,"found");
				re = ps.executeQuery();//执行sql语句
			%>
			<center>
			<table align="center" border="1">
			    <h1>全部的招领信息</h1>
			    <tr>
		        	<th>标题</th><th>种类</th><th>时间</th><th>查看</th>
		  		</tr>
			<%
		while(re.next()) {
			%>
			
				    <tr>
				        <td><%=re.getString("title") %></td>
				        <td><%=re.getString("kind") %></td>
				        <td><%=re.getString("time") %></td>
				        <td><a href="/lostandfound/BaseServlet?method=lookform&id=<%=re.getString("id") %>" target="_blank" style=" text-decoration:none; color:#135c86; ">
				        查看</a></td>
				    </tr>

			 <%
                }
                ps.close();
                re.close();
                con.close();
			 %>
			
			</table></center>

</body>
</html>