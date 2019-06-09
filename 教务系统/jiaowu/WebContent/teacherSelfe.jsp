<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>老师-教务管理系统</title>
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

* {
padding: 0;
margin: 0;
}

.ad {
width: 400px;
height: 200px;
border: 1px solid black;
position: fixed;
right: 0;
bottom: 0;
}

.ad>p {
display: flex;
justify-content: space-between;
}

.closeBtn {
padding: 0 4px;
}
</style>

<script type="text/javascript">

window.onload=function tablecss() {
			var tablename=document.getElementById("mytable");
			var li=tablename.getElementsByTagName("tr");//获取所有行数
			for(var i=0;i<li.length;i++){
				if(i%2==0){
					li[i].style.backgroundColor="#d9edf7";
				}else{
					li[i].style.backgroundColor="#FFFFFF";
				}
			}		
		}  
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
			
			var tno = document.getElementById('tno');
			tno.value=atd[0].innerHTML;
			var pasword = document.getElementById('pas');
			pasword.value=atd[1].innerHTML;
			var name = document.getElementById('name');
			name.value=atd[2].innerHTML;
			//设置radio的值
			if(atd[3].innerHTML=="男"){
				document.getElementById("sex").checked = true;
				}else{
				document.getElementById("sex2").checked = true;
				}
			//设置学历
			var educa=atd[4].innerHTML;

			var education = document.getElementById('education');
			for(var i=0; i<education.options.length; i++){ 
				if(education.options[i].value == educa){ 
					education.options[i].selected = true; 
					break;
				} 
			}
			//设置班级号
			var college = document.getElementById('college');
			college.value=atd[5].innerHTML;
	
    }
</script>
</head>
<body>
	   <jsp:include page="teacherTop.jsp" />

	   <%
	       String tno= (String)session.getAttribute("user") ;
		   String sql="SELECT * FROM teacher where tno="+tno;//设置sql语句
	       PreparedStatement ps; //设置预编译SQL语句保存到PreparedStatement对象
	       ResultSet re;  //声明re用来接收SQL语句的结果
			//注册驱动
		   Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jiaowu","root","123456");
			try{
			ps = con.prepareStatement(sql);
			re = ps.executeQuery();//执行sql语句,将查询结果存放在re中

	   %>
<!--表格展示 --> 
 <div style="text-align: center;">
		<br><br><br><h1>个人信息</h1><br>
		<center>
			 	<table id="mytable">
			<thead>
				<th>教师号</th>
				<th>密码</th>
				<th>姓名</th>
				<th>性别</th>
				<th>学历</th>
				<th>所属学院</th>
				<th>操作</th>
			</thead>
	<%
	//利用while循环将数据表中的记录列出
 	while(re.next()){
	%>
			<tbody>
				  <tr>
					    <td><%= re.getString("tno") %></td>
					    <td><%= re.getString("password") %></td>
					    <td><%= re.getString("name") %></td>
					    <td><%= re.getString("sex") %></td>
					    <td><%= re.getString("education") %></td>
					    <td><%= re.getString("college") %></td>
					    <td><a href="javascript:openamend();" onclick="modify(this)">修改</a>
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
        <br><h3><b>修改教师</b></h3><br>
        <!-- 修改教师信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=amendtea" method="post">
        <input id="tno" name="tno" type="text" width="120px" height="40px;" placeholder="教师号" readonly="readonly" style="background-color:#dedede "><br><br>
        <input id="pas" name="pas" type="text" width="120px" height="40px;" placeholder="密码"><br><br>
        <input id="name" name="name" type="text" width="120px" height="40px;" placeholder="姓名"><br><br>
        性别:<input type="radio" id="sex" name="sex" value="男" checked="checked">男
        <input type="radio" id="sex2" name="sex" value="女">女<br><br>
        学历: <select id="education" name="education">

        	<option value="本科">本科</option>
        	<option value="研究生">研究生</option>
        	<option value="博士">博士</option>
        </select>
        <br><br>
        所属学院:<input id="college" name="college" type="text" width="120px" height="40px;" placeholder="如:信息工程学院">
        <br><br>
        <button type="submit">保存修改</button>
        </form>
        <br><br>
        <a href="javascript:closeamend();">关闭修改框</a></div>
        

<%
			String sql2="SELECT * FROM message WHERE id=(SELECT MAX(id) FROM message WHERE informObj='老师' OR informObj='全体成员' )";//设置sql语句
			PreparedStatement ps2; //设置预编译SQL语句保存到PreparedStatement对象
			ResultSet re2;  //声明re用来接收SQL语句的结果
			//注册驱动
			Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con2 = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jiaowu","root","123456");
			try{
			ps2 = con2.prepareStatement(sql2);
			re2 = ps2.executeQuery();//执行sql语句,将查询结果存放在re中
			re2.next();
%>	
	
 <!-- 获取信息通知  -->
 <div class="ad" id="ad">
<p>
<span class="countdown" id="countdown"></span>
<input type="button" value="x" class="closeBtn" id="closeBtn">
</p>
<br>
<b>通知<%=re2.getString("informObj") %>:</b><br><br>
	<b>&nbsp;&nbsp;<%=re2.getString("content") %></b><br>
	<br>&nbsp;&nbsp;&nbsp;&nbsp;<%=re2.getString("time") %>

</div>

<% 
			re2.close(); //关闭ResultSet对象
			 }
			  catch(Exception e){
			  out.println(e.getMessage());
			 }

			  con.close();  //关闭Connection对象	

%>

 <script>
var ad = document.getElementById('ad');
var countdown = document.getElementById('countdown');
var closeBtn = document.getElementById('closeBtn');
// 设置初始位置
var position = -ad.offsetHeight;//获取可视高度
ad.style.bottom = position + "px";
// 设置初始事件
var time = 20; //设置时间
countdown.innerText = time + '秒';
//通知上升
var upInterval = setInterval(function () {
position++;
if (position >= 0) {
clearInterval(upInterval);//setInterval() 函数会每秒执行一次函数，类似手表)。使用 clearInterval() 来停止执行

countDown();//倒计时 开始减time
} else {
ad.style.bottom = position + "px";
}
}, 10)
//倒计时函数
function countDown() {
	var timeInterval = setInterval(function () {
	time--;
	if (time < 0) {
	clearInterval(timeInterval);
	ad.style.display = 'none';
	} else {
	countdown.innerText = time + '秒';
	}
	}, 1000)
	
	closeBtn.onclick = function () {
	clearInterval(timeInterval);
	ad.style.display = 'none';
	}
}

</script>
</body>
</html>