<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>失物招领-失物招领</title>
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
setTimeout(showTopTime,800);

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
setTimeout(loginafter,500);
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
//生成lost的id号   取时间+随机数字
function getRanID(){
		 //获取时间毫秒数
		var time = new Date();
	    var times= time.getTime();//获取当前时间(从1970.1.1开始的毫秒数)   1546844352539  
	    //获取随机数字
	    var ran= Math.floor(Math.random()*1000);
	    var id=times+""+ran;
	    console.log("随机ID:"+id);
	    document.getElementById("aid").value= id;
}
setTimeout(getRanID,1200);
//设置文本中时间
function setTextTime(){
	var time = new Date();
	var year=time.getFullYear();//获取年份
	var month=time.getMonth()+1;//获取月
	var day=time.getDate();//获取日
	var sj=year+"-"+month+"-"+day;
	document.getElementById("time").value= sj;
	console.log("时间:"+sj);
}
setTimeout(setTextTime,900);

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
<!-- 失物内容 -->
<div style=" height:700px" >
		<div style=" margin: 0 auto; height: 100%; width: 1000px; text-align: center;">
		<h1>发布寻物启事</h1>
				<hr>
			<div style="margin: 0 auto; height: 100% ; width: 400px;  text-align: left;  ">
				<form method="post" action="/lostandfound/BaseServlet?method=lost">
				  	标题:<input name="title" type="text" size="25px" placeholder="请输入丢失的物品..."  style=" margin-top: 20px; width: 200px; height: 20px;"><br>
					<font color="red">在图书馆拾到一把红包雨伞(示范标题)</font>
					<br>
					物品种类:
					<select name="kind" style="margin-top: 20px; width: 200px; height: 20px;">
					    <option value="证件">证件</option>
						<option value="钱包">钱包</option>
						<option value="箱包">箱包</option>
						<option value="银行卡">银行卡</option>
						<option value="卡类">卡类</option>
						<option value="印章">印章</option>
						<option value="钥匙">钥匙</option>
						<option value="衣物">衣物</option>
						<option value="首饰">首饰</option>
						<option value="票据">票据</option>
						<option value="数码">数码</option>
						<option value="车牌">车牌</option>
						<option value="电脑">电脑</option>
						<option value="车辆">车辆</option>
						<option value="其他">其他</option>
						</select>
					<br>
					丢失地点:<input name="place" type="text" style=" margin-top: 20px; width: 200px; height: 20px;"> 
					<br>
					丢失时间:<input id="time" name="time" type="text" style=" margin-top: 20px; width: 200px; height: 20px;">
					<br>
					联系人姓名:<input name="name" type="text" style=" margin-top: 20px; width: 200px; height: 20px;">
					<br>
					联系电话:<input name="phone" type="text" style=" margin-top: 20px; width: 200px; height: 20px;">
					<br>
					<br>详细描述:<br><br>
					<textarea name="content" rows="5" cols="40">
					</textarea>
					<br>
					类型:<input type="text" name="type" readonly="readonly" value="lost" style="background-color: gray;">
					<br>
					<br>
					ID:<input id="aid" type="text" name="id" readonly="readonly" style="background-color: gray;">
					<br>
					<br>
					<button type="submit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="reset">清除</button>
				</form>
				</div>
			</div>
		</div>
<!--foot-->
<div style=" height:80px; background-color:#dddddd; margin-top:5px;text-align:center;"> 
	<div style="height:20px;">| 免责声明 | 关于我们 | 网站合作 | 联系我们 |</div>
	<div style="">2018 失物认领网  <br/>
				失物认领网 版权所有<br/></div>
</div>
</body>
</html>