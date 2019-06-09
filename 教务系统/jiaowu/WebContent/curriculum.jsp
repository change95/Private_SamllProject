<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员-教务管理系统</title>
<style type="text/css">

table th{	
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
	 }
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

window.onload=function tablecss() {
			var tablename=document.getElementById("mytable");
			var li=tablename.getElementsByTagName("tr");//获取所有行数
			for(var i=1;i<li.length;i++){
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
			var cur = document.getElementById('cur');
			cur.value=atd[0].innerHTML;
			console.log("取出课程号:"+cur.value);
			
			var curriculumname = document.getElementById('curriculumname');
			curriculumname.value=atd[1].innerHTML;
			
			var tno = document.getElementById('tno1');
			tno.value=atd[2].innerHTML;
			console.log("取出教师号:"+atd[2].innerHTML);
			
			var classnum = document.getElementById('classnum');
			classnum.value=atd[3].innerHTML;

    }
</script>
</head>
<body>
	   <jsp:include page="adminTop.jsp" />
	   <%
		   String sql="SELECT * FROM curriculum ";//设置sql语句
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
		<br><br><br><h1>课程管理</h1><br>
		<center>
			 	<table id="mytable">
			<thead>
				<th>课程号</th>
				<th>课程名</th>
				<th>教师号</th>
				<th>班级号</th>
				<th>操作</th>
			</thead>
	<%
	//利用while循环将数据表中的记录列出
 	while(re.next()){
	%>
			<tbody>
				  <tr>
					    <td><%= re.getString("curriculum") %></td>
					    <td><%= re.getString("curriculumname") %></td>
					    <td><%= re.getString("tno") %></td>
					    <td><%= re.getString("classnum") %></td>
					    <td><a href="javascript:openamend();" onclick="modify(this)">修改</a>&nbsp;<a href="/jiaowu/adminServlet?method=delecur&curriculum=<%= re.getString("curriculum") %>">删除</a></td>
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
        
 <br><h3><b>修改课程</b></h3><br>
        <!-- 修改课程信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=amendcur" method="post">
        
        课程号:<input id="cur" name="curriculum" type="text" width="120px" height="40px;" placeholder="课程号" readonly="readonly" style="background-color:#dedede "><br><br>
     课程名:<input id="curriculumname" name="curriculumname" type="text" width="120px" height="40px;" placeholder="课程名"><br><br>
      教师号:<input id="tno1" name="tno" type="text" width="120px" height="40px;" placeholder="教师号"><br><br>
        班级号:<input id="classnum" name="classnum" type="text" width="120px" height="40px;" placeholder="班级号"><br><br>
        <button type="submit">保存修改</button>
        </form>
        <br><br>
        <a href="javascript:closeamend();">关闭修改框</a></div>
 
</body>
</html>