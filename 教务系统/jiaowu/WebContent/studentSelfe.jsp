<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生-教务管理系统</title>
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
	
	var sno = document.getElementById('sno');
	sno.value=atd[0].innerHTML;
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
	//设置出生年月
	var birth=atd[4].innerHTML;
	var births=birth.split("-");

	var year = document.getElementById('year');
	for(var i=0; i<year.options.length; i++){ 
		if(year.options[i].value == births[0]){ 
			year.options[i].selected = true; 
			break;
		} 
	}
	var month = document.getElementById('month');
	for(var i=0; i<month.options.length; i++){ 
		if(month.options[i].value == births[1]){ 
			month.options[i].selected = true; 
			break;
		} 
	}
	var day = document.getElementById('day');
	for(var i=0; i<day.options.length; i++){ 
		if(day.options[i].value == births[2]){ 
			day.options[i].selected = true; 
			break;
		} 
	}
	//设置班级号
	var classnum = document.getElementById('classnum');
	classnum.value=atd[5].innerHTML;

}
</script>
</head>
<body>
	   <jsp:include page="studentTop.jsp" />

	   <%
	       String tno= (String)session.getAttribute("user") ;
		   String sql="SELECT * FROM student where sno="+tno;//设置sql语句
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
				<th>学号</th>
				<th>密码</th>
				<th>姓名</th>
				<th>性别</th>
				<th>出生年月</th>
				<th>班级号</th>
				<th>操作</th>
			</thead>
	<%
	//利用while循环将数据表中的记录列出
 	while(re.next()){
	%>
			<tbody>
				  <tr>
					    <td><%= re.getString("sno") %></td>
					    <td><%= re.getString("pasword") %></td>
					    <td><%= re.getString("name") %></td>
					    <td><%= re.getString("sex") %></td>
					    <td><%= re.getString("birth") %></td>
					    <td><%= re.getString("class") %></td>
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
        
        <br><h3><b>修改学生</b></h3><br>
        <!-- 添加学生信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=amend" method="post">
        <input id="sno" name="sno" type="text" width="120px" height="40px;" placeholder="学号" readonly="readonly" style="background-color:#dedede "><br><br>
        <input id="pas" name="pas" type="text" width="120px" height="40px;" placeholder="密码"><br><br>
        <input id="name" name="name" type="text" width="120px" height="40px;" placeholder="姓名"><br><br>
        性别:<input type="radio" id="sex" name="sex" value="男" checked="checked">男
        <input type="radio" id="sex2" name="sex" value="女">女<br><br>
        出生年月: <select id="year" name="year">
        	<option value="1990">1990</option>
        	<option value="1991">1991</option>
        	<option value="1992">1992</option>
        	<option value="1993">1993</option>
        	<option value="1994">1994</option>
        	<option value="1995">1995</option>
        	<option value="1996">1996</option>
        	<option value="1997">1997</option>
        	<option value="1998">1998</option>
        </select>年
        	<select id="month" name="month">
        	<option value="1">1</option>
        	<option value="2">2</option>
        	<option value="3">3</option>
        	<option value="4">4</option>
        	<option value="5">5</option>
        	<option value="6">6</option>
        	<option value="7">7</option>
        	<option value="8">8</option>
        	<option value="9">9</option>
        </select>月
        <select id="day" name="day">
        	<option value="01">01</option>
        	<option value="02">02</option>
        	<option value="03">03</option>
        	<option value="04">04</option>
        	<option value="05">05</option>
        	<option value="06">06</option>
        	<option value="07">07</option>
        	<option value="08">08</option>
        	<option value="09">09</option>
        </select>日
        <br><br>
        <input id="classnum" name="classnum" type="text" width="120px" height="40px;" placeholder="班级号">
        <br><br>
        <button type="submit">保存修改</button>
        </form>
        <br><br>
        <a href="javascript:closeamend();">关闭修改框</a></div>
 
 
 <%
			String sql2="SELECT * FROM message WHERE id=(SELECT MAX(id) FROM message WHERE informObj='学生' OR informObj='全体成员' )";//设置sql语句
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