<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页-失物招领</title>
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
                <form action="seek.jsp" method="post">
                    <input name="text" type="text" placeholder="请输入您要搜索的内容..." />
                    <button type="submit" ></button>
                </form>
                <center><font color="#FF0000">热搜词</font><font style="color: #000;font-family: "Microsoft YaHei";font-size: 12px;">：手机、钱包、钥匙、身份证、ipad、杯子</font></center>
              </div>
         </div>                                                      
    </div>
</div>
<!-- 大导航-->
<style>
	.menu2 li{background-color: #f9803a;}
	.menu2 {width: 220px;display: none;padding:0; margin:0}
	.menu1 li:hover .menu2 {display: block;}
</style>
<div class="nav">
	<div class="nav_content">
    	<ul class="menu1">
        	<li style="background-color: #F90"><a href="main.jsp">首页</a></li>
            <li><a href="lost.jsp">发布失物</a></li>
            <li><a href="found.jsp">发布招领</a></li>
          	<li ><a href="">我的信息</a>
					<ul class="menu2">
            		<li><a href="mylost.jsp" target="_blank">我的失物</a></li>
            		<li><a href="myfound.jsp" target="_blank">我的招领</a></li>
					</ul>
            </li>	
        </ul>
    </div>
</div>
<!-- 走马灯-->
<div style="z-index:-100;position: relative;">
		<!--标题部分-->
		<div style="height:20px; width:1100px; margin:2px auto; border-color:#1e7ace; border-bottom:solid; border-width:2px;color:red;">失物 | 招领信息</div>
        <!--滚动部分-->
        <div class="marquee">
        	<div><img src="img/1.jpeg"><br/>[失物招领]-[存储卡]</div>
            <div><img src="img/2.jpeg"><br/>[失物招领]-[证书]</div>
            <div><img src="img/3.jpeg"><br/>[失物招领]-[钱包]</div>
        </div>
</div>
<!--主题内容-->
<div class="content">
	<div class="content_text">
    	<!--失物招领-->
        <div class="lost">
        	<h3>
            <span style="color: #FFF; float:right; margin-right:20px; margin-top:10px;">
            <a href="look.jsp" target="_blank" style="text-decoration: none;" >more....</a></span>
        	<div style="border-radius: 10px 9px 0 0;height:35px;color: #FFF;padding-left:15px;background-color:#f9803a;">失物招领</div>
            </h3>
            <!-- lost 列表 -->
            <ul style="margin-top:10px;">
            <!-- 输出lost数据库数据 -->
            <%   
            //设置sql语句  取出几条
            String sql="SELECT * FROM form WHERE type=?";
            PreparedStatement ps; //设置预编译SQL语句保存到PreparedStatement对象
            ResultSet re;  //声明re用来接收SQL语句的结果
			//注册驱动
			Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shiwu","root","123456");
			ps = con.prepareStatement(sql);
			String gg="lost";
			ps.setString(1,gg);
			re = ps.executeQuery();//执行sql语句
			while(re.next()){
            %>
            	<li>
                <span style="float:right; font-size:11px;font-family:Arial; padding-right:20px;"><%=re.getString("time") %></span>
                <a href="/lostandfound/BaseServlet?method=lookform&id=<%=re.getString("id") %>" target="_blank" style=" text-decoration:none; color:#135c86; "><%=re.getString("title")%></a>
                </li>
             <%
                }
                ps.close();
                re.close();
                con.close();
  			 %>   
                
            </ul>
        </div>
        <!--寻物启事-->
        <div class="found">
        	<h3>
            <span style="color: #FFF; float:right; margin-right:20px; margin-top:10px;">
            <a href="look2.jsp" target="_blank" style="text-decoration: none;" >more....</a></span>
        	<div style="border-radius: 10px 9px 0 0;height:35px;color: #FFF;padding-left:15px;background-color:#f9803a;">寻物启事</div>
            </h3>
             <!-- found 列表 -->
            <ul style="margin-top:10px;">
             <!-- 输出lost数据库数据 -->
            <%   
            //设置sql语句 select top 数字或者百分比 * from table_name  取出几条
            String sql1="SELECT * FROM form WHERE type=?";
            PreparedStatement ps1; //设置预编译SQL语句保存到PreparedStatement对象
            ResultSet re1;  //声明re用来接收SQL语句的结果
			//注册驱动
			Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/shiwu","root","123456");
			ps1 = con1.prepareStatement(sql);
			String gg1="found";
			ps1.setString(1,gg1);
			re1 = ps1.executeQuery();//执行sql语句
			while(re1.next()){
            %>
            	<li>
                <span style="float:right; font-size:11px;font-family:Arial; padding-right:20px;"><%=re1.getString("time") %></span>
                <a href="/lostandfound/BaseServlet?method=lookform&id=<%=re1.getString("id")%>" target="_blank" style=" text-decoration:none; color:#135c86; "><%=re1.getString("title")%></a>

                </li>
             <%
                }
                ps.close();
                re.close();
                con.close();
  			 %>   
               
            </ul>
        </div>
    </div>
</div>
<div style="clear:both"></div>
<!--foot-->
<div style=" height:80px; background-color:#dddddd; margin-top:5px;text-align:center;"> 
	<div style="height:20px;">| 免责声明 | 关于我们 | 网站合作 | 联系我们 |</div>
	<div style="">2018 失物认领网  <br/>
				失物认领网 版权所有<br/></div>
</div>
</body>
</html>