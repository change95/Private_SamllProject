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
			
			var informObj = document.getElementById('informObj');
			for(var i=0; i<informObj.options.length;i++){
				if(informObj.options[i].value==atd[2].innerHTML){
					informObj.options[i].selected=true;
					console.log('i为'+i+"值为:"+informObj.options[i].value);
					break;
				}
			}
			
			var id = document.getElementById('aid');
			console.log('id为'+id);
			id.value=atd[0].innerHTML;
			console.log("取出id:"+id.value);
			
			var time = document.getElementById('atime');
			time.value=atd[1].innerHTML;
			console.log("取出time:"+time.value);
			
			var content = document.getElementById('acontent');
			content.value=atd[3].innerHTML;
			console.log("取出content:"+content.value);
    }
</script>
</head>
<body>
	   <jsp:include page="teacherTop.jsp" />
	   <%
		   String sql="SELECT * FROM message";//设置sql语句
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
		<br><br><br><h1>信息管理</h1><br>
		<center>
			 	<table id="mytable">
			<thead>
				<th>ID</th>
				<th>时间</th>
				<th>通知对象</th>
				<th>内容</th>
				<th>操作</th>
			</thead>
	<%
	//利用while循环将数据表中的记录列出
 	while(re.next()){
	%>
			<tbody>
				  <tr>
				  		<td><%= re.getString("id") %></td>
					    <td><%= re.getString("time") %></td>
					    <td><%= re.getString("informObj") %></td>
					    <td><%= re.getString("content") %></td>
	<% 
			if(re.getString("informObj").equals("学生")){
	%>				    
					    <td><a href="javascript:openamend();" onclick="modify(this)">修改</a>&nbsp;<a href="/jiaowu/adminServlet?method=delemes&id=<%= re.getString("id") %>">删除</a></td>
	<% }else{%>
		
			<td></td>
	<%}%>			
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
 <br><h3><b>修改信息</b></h3><br>
        <!-- 修改信息 form表单 -->
        <form action="/jiaowu/adminServlet?method=amendmes" method="post">
	         通知对象:<select id="informObj" name="informObj">
	        	<option value="全体成员">全体成员</option>
	        	<option value="老师">老师</option>
	        	<option value="学生">学生</option>
	            </select>
           		 <br><br>
   		ID:<input id="aid" name="id" type="text" width="120px" height="40px;" placeholder="id" readonly="readonly" style="background-color:#dedede "><br><br>
   
      	时间:<input id="atime" name="time" type="text" width="120px" height="40px;" placeholder="time" readonly="readonly" style="background-color:#dedede "><br><br>
        内容:
        <textarea id="acontent" name="content" rows="3" cols="20" style="vertical-align:middle"></textarea>   
<br><br>
       
        <button type="submit">保存修改</button>
        
        
        </form>
        <br><br>
        <a href="javascript:closeamend();">关闭修改框</a>
        </div>
 
</body>
</html>