<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提示页面-失物招领</title>
<script type="text/javascript">
var time=5;
function dao(){
	if (time > 0) {
		document.getElementById('last').innerHTML=time;
		time=time-1;
	}else {
		console.log(time);
		clearInterval(timer);
		var msghref=document.getElementById('referer').attributes["href"].value;
		console.log("获取请求页面:"+msghref);
		if(msghref!="null"){

			window.location.href=msghref;
		}else {

			window.location.href="main.jsp";
		}
		
	}

}
timer=setInterval(dao,500);
</script>
</head>
<body>
	<div style=" margin: 0 auto; width: 500px; height: 300px; border:2px solid orange; text-align: center;">

	   <div style="display:inline-block;width: 500px; border-bottom:2px solid orange; height: 50px; color: red;" >
	   <b>
	   <h3>提示页面-失物招领</h3>
	   </b>
	   </div>
	     &nbsp;<br>
	     <b><%=(String)session.getAttribute("msg")%></b><br>
		<span style=" line-height: 100px;">还有<span id="last"></span>秒......</span></br>
		<a id="referer" href='<%=(String)session.getAttribute("referer")%>'>如果你的浏览器没有反应,请点击这里.....</a>

	</div>
</body>
</html>