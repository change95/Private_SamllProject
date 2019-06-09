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

</style>

<script type="text/javascript">
//表格隔行换色
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
			console.log("取出学号:"+sno.value);
			
			var curriculum = document.getElementById('curriculum');
			curriculum.value=atd[2].innerHTML;
			
			var grade = document.getElementById('xgrade');
			grade.value=atd[4].innerHTML;
			var status = document.getElementById('xstatus');
			status.value=atd[5].innerHTML;

    }
//根据成绩自动填写及格不及格
function achangestatus(){
	var grade=document.getElementById("xgrade").value;
	if(grade>=60){
		document.getElementById("xstatus").value="及格";
	}else{
		document.getElementById("xstatus").value="不及格";
	}
	
}

</script>
</head>
<body>
	   <jsp:include page="studentTop.jsp" />

	   <%

		   String sql="SELECT * FROM grade,student,curriculum where student.sno=grade.sno and curriculum.curriculum=grade.curriculum and student.sno="+session.getAttribute("user");//设置sql语句
	      	System.out.println("sql"+sql);
	      	
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
		<br><br><br><h1>成绩查询</h1><br>
		<center>
			 	<table id="mytable">
			<thead>
				<th>学号</th>
				<th>姓名</th>
				<th>课程号</th>
				<th>课程名</th>
				<th>成绩</th>
				<th>状态</th>
				<th>操作</th>
			</thead>
	<%
	//利用while循环将数据表中的记录列出
 	while(re.next()){
	%>
			<tbody>
				  <tr>
					    <td><%= re.getString("sno") %></td>
					    <td><%= re.getString("name") %></td>
					    <td><%= re.getString("curriculum") %></td>
					    <td><%= re.getString("curriculumname") %></td>
					    <td><%= re.getString("grade") %></td>
					    <td><%= re.getString("status") %></td>
 	<% 
 			if(re.getString("status").equals("不及格")){
 	%>
 			<td><a href="/jiaowu/BaseServlet?method=amendgrade&sno=<%= re.getString("sno") %>&curriculum=<%= re.getString("curriculum") %>&grade=<%= re.getString("grade") %>" onclick="modify(this)">申请重修</a></td>
 	<%					
 			}else {
 	%>		    
		  		<td></td>	    
	<% }%>			
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