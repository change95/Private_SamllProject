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
window.onload=function (){ tablecss(); reloadPage();}
//自动刷新一次页面
function reloadPage() {
	if(location.href.indexOf('#reloaded')==-1){
		location.href=location.href+'#reloaded';
		location.reload();
	}
}

//表格隔行换色
function tablecss() {
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
	   <jsp:include page="teacherTop.jsp" />

	   <%
	   		String classnum=request.getParameter("class");
	        session.setAttribute("class", classnum);
	        System.out.println("Grade已设置session:class班级号"+classnum);
	        String user=(String)session.getAttribute("user");
		   String sql3="SELECT * FROM grade,student,curriculum where student.sno=grade.sno and curriculum.curriculum=grade.curriculum AND class="+classnum+" AND classnum="+classnum+" AND tno="+user;//设置sql语句
		   System.out.println("SQL:"+sql3);
		   PreparedStatement ps3; //设置预编译SQL语句保存到PreparedStatement对象
	       ResultSet re3;  //声明re用来接收SQL语句的结果
			//注册驱动
		   Class.forName("com.mysql.jdbc.Driver");
			//连接数据库
			Connection con3 = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jiaowu","root","123456");
			try{
			ps3 = con3.prepareStatement(sql3);
			re3 = ps3.executeQuery();//执行sql语句,将查询结果存放在re中
	   %>
<!--表格展示 --> 
 <div style="text-align: center;">
		<br><br><br><h1>成绩管理</h1><br>
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
 	while(re3.next()){
	%>
			<tbody>
				  <tr>
					    <td><%= re3.getString("sno") %></td>
					    <td><%= re3.getString("name") %></td>
					    <td><%= re3.getString("curriculum") %></td>
					    <td><%= re3.getString("curriculumname") %></td>
					    <td><%= re3.getString("grade") %></td>
					    <td><%= re3.getString("status") %></td>
					    <td><a href="javascript:openamend();" onclick="modify(this)">修改</a>&nbsp;<a href="/jiaowu/teacherServlet?method=delegra&curriculum=<%= re3.getString("curriculum") %>&sno=<%= re3.getString("sno") %>">删除</a></td>
				</tr> 
			</tbody>
<%
  }
  
  re3.close(); //关闭ResultSet对象
 }
  catch(Exception e){
  out.println(e.getMessage());
  }

  con3.close();  //关闭Connection对象	
	
%>
</table></center>
 </div>


 <!--修改弹窗-->
  <div id="amend" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
        
 <br><h3><b>修改成绩</b></h3><br>
        <!-- 修改课程信息 form表单 -->
        <form action="/jiaowu/teacherServlet?method=amendgra" method="post">
        
        <input id="sno" name="sno" type="text" width="120px" height="40px;" placeholder="学号" ><br><br>
         
        <input id="curriculum" name="curriculum" type="text" width="120px" height="40px;" placeholder="课程号"><br><br>
        <input id="xgrade" name="grade" onkeyup="this.value=this.value.replace(/[^0-9-]+/,'');" oninput="achangestatus()" type="text" width="120px" height="40px;" placeholder="成绩"><br><br>
        <input id="xstatus" name="status" type="text" width="120px" height="40px;" placeholder="状态" readonly="readonly" style="background-color:#dedede "><br><br>
        <button type="submit">保存修改</button>
        </form>
        <br><br>
        <a href="javascript:closeamend();">关闭修改框</a></div>
	
</body>
</html>